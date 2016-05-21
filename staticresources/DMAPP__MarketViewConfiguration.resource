        var ttg = ttg || {};
        ttg.am = ttg.am || {};
    
    ttg.am.reportconfiguration = function(spec) {

        var that = {};
        that.spec = spec;
        
        var dlg;
        var userId = spec.userId || '';
        var title = spec.title || '';
        var planId = spec.reportId;
        var ttgApi = spec.ttgApi; 
        var spinnerURL = spec.spinnerURL || '';
        var calendarURL = spec.calendarURL || ''
        var uniqueId = 1;
        var spinner;
        var readonly = spec.readonly;
        var inactive = false;//spec.inactive;
        var onSave = spec.onSave;
        var onDelete = spec.onDelete;
        var defaultAccountId = spec.accountId || '';
        var defaultAccountName = spec.accountName || '';
        var dateFormat = 'yy-mm-dd';
        var MAX_NUMBER_OF_PLANS = 50;

        var isopen = false;

        var userSearchSpec = jQuery.extend({}, spec);
        userSearchSpec.autosearch = false;
        userSearchSpec.title = 'Team search';
        userSearchSpec.lookup = { 
                callback: function(v) {
                    var table = dlg.find('table#MEMBERSTABLE');
                    if (table.find('tr[id=\'' + v.Id + '\']').length == 0) {
                        table.append(memberLine(v.Id, v.Name, 'Edit', true))
						addedMembers.push(v);
                    }
                    table.parent().animate({ scrollTop: table.height() }, "slow");
                } 
        }
        var userMetadataControl = ttg.metadata(userSearchSpec);

        var accountPlanSearchSpec = jQuery.extend({}, spec);
        accountPlanSearchSpec.autosearch = false;
        accountPlanSearchSpec.title = 'Plan search';
        accountPlanSearchSpec.lookup = { 
                layouts: {},
                overallCallback : function(plans) {
                    updatePlanList(plans);
                }
        }
        accountPlanSearchSpec.multiSelectLimit = MAX_NUMBER_OF_PLANS;
        accountPlanSearchSpec.lookup.layouts[(ttg.vfp + 'DM_Account_Plan__c').toLowerCase()] = [
            { key: 'Id', hidden: true, select: 'hidden' },
            { key: 'Name', label: 'Name', searchable: true, select: 'display', searchViewableField: true, orderdir: 'ASC' },
            { key: 'Owner.Name', label: 'Owner', searchable: true, searchViewableField: true },
            { key: ttg.vfp + 'Plan_Type__r.Name', label: 'Plan Type', searchable: true, searchViewableField: true},
            { key: ttg.vfp + 'From_Date__c', label: 'From Date', searchable: false, searchViewableField: true, type: 'DATE'},
            { key: ttg.vfp + 'To_Date__c', label: 'To Date', searchable: false, searchViewableField: true, type: 'DATE'}
        ];
        var accountPlanMetadataControl = ttg.metadata(accountPlanSearchSpec);
        
		var addedMembers = [];

		var data;

        function configure() {
            _wrapGet (handleConfigure);
        }
        
        function handleConfigure(responseData) {
            data = responseData;
            dateFormat = data.dateFormat;
            dlg = jQuery('<div>', {id: 'MARKETVIEW_CONFIGURATION_CONTAINER'}).addClass('AMCONFIGURATION');
            dlg.html(getDialogHTML())

            var buttons = [];

            if (!readonly) {
                buttons.push( { text: 'Save', click: save, ttgid: "SAVEBUTTON" } );
            }
            
            if (planId != '' && !readonly) {
                buttons.push({ text: 'Delete', click: deleteMarketView, ttgid: "DELETEBUTTON", "class": "DELETE" });
            }
            
            buttons.push( { text: 'Cancel', click: function() { jQuery(this).dialog("close") }, ttgid: "CANCELBUTTON" } );

            var height = jQuery(window).height()-60;
            var selectionHeight = 300;
            var zoneHeight = 500;
            if (height > zoneHeight) height = zoneHeight;
            if (height < 340) height = 340;
            zoneHeight += 10;
            dlg.dialog({ 
                    modal: true, 
                    resizable: false, 
                    autoOpen: true, 
                    title: title, 
                    width: '600px',
                    height: height,
                    buttons: buttons, 
                    close: suicide
                } 
            );
            jQuery('#SELECTEDPLANS').css('height', selectionHeight-(zoneHeight-height));
            jQuery('#USERS').css('height', selectionHeight-(zoneHeight-height));
            
            jQuery('.AMCONFIGURATION').css('overflow', 'hidden');
            
            dlg.find('#PLANNAME').val(data.reportname);

            if (!readonly && !inactive) {
                jQuery('#PLANINPUT').autocomplete({ 
                        open: userMetadataControl.autoCompleteClear, 
                        source: function (term, callback) { 
                                
                            var cb = function(a, b, c) { showAjaxSpinner(false); return callback(a,b,c); }

                            showAjaxSpinner(true);
                        
                            return userMetadataControl.autoCompleteFind('user', term, cb) 

                        }, 
                        select: userMetadataControl.autoCompleteSelected 
                    }
                ).change(function() { 
                        jQuery(this).parent().find('INPUT[type=\'hidden\']').val(''); 
                    }
                )
                jQuery('#SEARCHPLAN').click(userMetadataControl.lookup);
                jQuery('#SEARCHPLAN').parent().attr('layout','user');

                jQuery('#USERINPUT').autocomplete({ 
                        open: userMetadataControl.autoCompleteClear, 
                        source: function (term, callback) { 
                                
                            var cb = function(a, b, c) { showAjaxSpinner(false); return callback(a,b,c); }

                            showAjaxSpinner(true);
                        
                            return userMetadataControl.autoCompleteFind('user', term, cb) 

                        }, 
                        select: userMetadataControl.autoCompleteSelected 
                    }
                ).change(function() { 
                        jQuery(this).parent().find('INPUT[type=\'hidden\']').val(''); 
                    }
                )
                jQuery('#SEARCHUSER').click(userMetadataControl.lookup);
                jQuery('#SEARCHUSER').parent().attr('layout','user');
            }
            
            //renderPlanList(data.plans);
            renderPlanList(data.plans);
            renderMemberList(data.members);

            setupOwnerSearch();
            
            dlg.tabs({ active: 0 });

            var numberOfAddedPlans = jQuery('#SELECTEDPLANS').find('li').not('.ui-sortable-placeholder').length;
            if(numberOfAddedPlans >= MAX_NUMBER_OF_PLANS) {
            	jQuery('#LIMIT_MSG').text('Maximum of ' + MAX_NUMBER_OF_PLANS + ' plans added').css('color', 'red');
            }
            else {
            	jQuery('#LIMIT_MSG').text(numberOfAddedPlans + ' plans added').css('color', 'black');
            }             
            
            if (readonly) {
                jQuery(dlg).find('input[type=\'text\']').attr('disabled', 'true');
            }

            jQuery(dlg).parent().find('BUTTON.DELETE').css('background', 'none').css('background-color', 'maroon');
            
        }

        function updatePlanList(plans) {
            var liSelector = 'DIV.AMCONFIGURATION #SELECTEDPLANS UL LI';
            var currentPlanList = jQuery(liSelector);
            // Add plans not currently in the list
            jQuery.each(plans,function(key, plan){
                if(jQuery(liSelector + '#' + key).length==0) {
                    addPlanToList({id: plan.Id, name: plan.Name});
                }
            });

        }

        function enablePlanSorting() {
            jQuery('DIV.AMCONFIGURATION').find('#SELECTEDPLANS').find('UL').sortable({
                placeholder: "ui-state-highlight",
                start: function(event, ui) {
                    jQuery(dlg).dialog( "option", "closeOnEscape", false );
                    // To cancel drag and drop if user clicks ESC
                    jQuery('BODY').on('keydown.ttg_event', function(e) {
                            if(e.keyCode === 27) {
                                jQuery(ui.helper).parent().sortable('cancel').trigger('mouseup');
                                setTimeout(function() { jQuery(dlg).dialog( "option", "closeOnEscape", true ) }, 500);
                            }
                        }
                    );
                },
                stop: function(event, ui) {
                    jQuery('BODY').off('keydown.ttg_event');
                    // Force IE7 to redraw the area as it corrupts the display dagnabit
                    jQuery('DIV.AMCONFIGURATION').find('#SELECTEDPLANS').css('display', 'none')
                    jQuery('DIV.AMCONFIGURATION').find('#SELECTEDPLANS').css('display', '')
                }
            }).disableSelection().setEdgesAutoScrollable();
        }

        function addPlanToList(plan) {
            var ul = jQuery('DIV.AMCONFIGURATION #SELECTEDPLANS UL');
            ul.append(
                jQuery('<li>')
                    .attr('id', plan.id)
                    .addClass('ITEM PLANID')
                    .append(
                        jQuery('<span>')
                            .addClass('PLANNAME SELECTED TOPLEVEL')
                            .text(plan.name),
                        jQuery('<a>')
                            .addClass('del_link')
                            .click(deletePlan)
                    )
            )
        }

        function renderPlanList(plans) {
            var ul = jQuery('DIV.AMCONFIGURATION #SELECTEDPLANS UL');
            if (!readonly && !inactive) {
                enablePlanSorting()
            }

            if (!readonly && !inactive) {
                dlg.find('#SELECTEDPLANS').attr('layout',ttg.vfp + 'DM_Account_Plan__c').scrollTop(0);
                
                var filterResultCallback = function(plan) {
                    var currentPlans = jQuery('#SELECTEDPLANS UL LI.PLANID').map(function(){return jQuery(this).attr('id') });
                    for(var i = 0; i < currentPlans.length; i++) {
                        if(currentPlans[i] === plan.Id) {
                            return true;
                        }
                    }
                    return false;
                }
                
                jQuery('#SELECTEDPLANS').parent().attr('layout', ttg.vfp + 'DM_Account_Plan__c');
                jQuery('<span>')
                    .append(
                        createButton()
                            .attr('value', 'New')
                                .click(function(){
                                    accountPlanMetadataControl.lookup.call(dlg.find('#SELECTEDPLANS'), filterResultCallback, null, true);
                                })
                    ).attr('layout', ttg.vfp + 'DM_Account_Plan__c')
                    .insertAfter(dlg.find('#SELECTEDPLANS'))
                jQuery('<br>').insertAfter(dlg.find('#SELECTEDPLANS'));
            }

            jQuery.each(plans, function(key, plan) {
                    addPlanToList(plan)
                }
            )

        }

        function renderMemberList(members) {
            
            var table = jQuery('<table/>').addClass('opportunities').attr('id', 'MEMBERSTABLE');
            table.append(
                jQuery('<tr/>').append(
                    jQuery('<th/>').text('Member')
                ).append(
                    jQuery('<th/>').text('Access').css('width','100px')
                ).append(
                    jQuery('<th/>').css('width','20px')
                )
            )

            if(members) {
	            jQuery.each(members, function(key, value) {
	                    table.append(
	                        memberLine(value.ownerId, value.name, value.permission, value.candelete)
	                    )
	                }
	            )
            }
            dlg.find('#USERS').append(table);
            dlg.find('#USERS').append(jQuery('<BR/>'));
            if (!readonly && !inactive) {
                dlg.find('#USERS').attr('layout','user').scrollTop(0);
                

                var filterResultCallback = function(user) {
                    var currentMembers = members;
                    for(var i = 0; i < currentMembers.length; i++) {
                        if(currentMembers[i].ownerId === user.Id) {
                            return true;
                        }
                    }
                    for(var i = 0; i < addedMembers.length; i++) {
                        if(addedMembers[i].Id === user.Id) {
                            return true;
                        }
                    }
                    return false;
                }
				
				jQuery('#USERS').parent().attr('layout','user');
                var userDlg = dlg.find('#USERS');
				jQuery('<span>')
                    .append(
                        createButton()
                            .attr('value', 'New')
                                .click(function(){
                                    userMetadataControl.lookup.call(dlg.find('#USERS'), filterResultCallback, null, true);
                                })
                    ).attr('layout','user')
                    .insertAfter(userDlg)
            }
            
        }

        function memberLine(id, name, permission, candelete) {

            var optionRead = jQuery('<option>').attr('value', 'Read').text('Read only')
            var optionReadWrite = jQuery('<option>').attr('value', 'Edit').text('Read/Write')
            
            if (permission=='Read') optionRead.attr('selected', 'true');
            if (permission=='Edit') optionReadWrite.attr('selected', 'true');
                
            var tr = jQuery('<tr>').attr('id', id);
            
            tr.append(jQuery('<td>').text(name));

            var select = jQuery('<select>').append(
                optionReadWrite
            ).append(
                optionRead
            ).append(
                permission=='Default' ? jQuery('<option>').text('Default').attr('selected', 'true') : null
            )
            
            if (readonly || inactive || (id == userId /*&& permission=='Read'*/)) select.attr('disabled', 'true');
            
            tr.append(
                jQuery('<td>').append(candelete ? select : 'All')
            )
            
            if (candelete && !readonly && !inactive && id != userId) { 
                tr.append(jQuery('<td>').append(
                        jQuery('<span>').addClass('del_link').click(deleteMember)
                    )
                )
            }
            else {
                tr.append(jQuery('<td>'));
            }
                    
            return tr
            
        }

        function deletePlan() {

            var id = jQuery(this).parent().attr('id');
            alertDialog(
                    'Delete Plan', 
                    'Warning! This plan will no longer appear in the market view report. Do you want to proceed?',
                    {
                        'Yes': function() { 
                            jQuery('#SELECTEDPLANS').find('LI[id=\'' + id + '\']').remove();
                            jQuery(this).dialog('close'); 
                        },
                        'No':  function() { 
                            jQuery(this).dialog('close'); 
                        }
                    }
            )
            
            
        }
        
        function deleteMember() {

            var id = jQuery(this).parent().parent().attr('id');
            alertDialog(
                    'Delete Team Member', 
                    'Warning! This user will no longer have access to the market view report. Do you want to proceed?',
                    {
                        'Yes': function() { 
                            jQuery('#MEMBERSTABLE').find('TR[id=\'' + id + '\']').remove();
                            jQuery(this).dialog('close'); 
                        },
                        'No':  function() { 
                            jQuery(this).dialog('close'); 
                        }
                    }
            )
            
            
        }
        
        function packageMembers() {
            var contents = dlg.find('table#MEMBERSTABLE').find('TR');

            var members = [];
            
            jQuery.each(contents, function(key, value) {
                
                    var id = jQuery(value).attr('id')
                    if (id != undefined) { // Skip the thead block
                        var permission = jQuery(value).find('select').val();
                        members.push({ ownerId: id, permission: permission })
                    }
                    
                }
            )

            return members;
        }
        
        function createButton() {

            return jQuery('<input/>')
                    .attr('type','button')
                    .addClass('ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only');
                                                
        }

        function deleteMarketView() {

            alertDialog(
                    'Delete Market View Report', 
                    'Warning! Do you want to proceed?',
                    {
                        'Yes': function() {
                            _wrapDelete (function () {
                                    
                                    try {
                                        showAjaxSpinner(true);
                                        onDelete();
                                    }
                                    catch(e) {
                                        showAjaxSpinner(false);
                                    }
    
                                }
                            );

                            jQuery(this).dialog('close'); 
                        },
                        'No': function() {
                            jQuery(this).dialog('close'); 
                        }
                        
                    }
            )
            
        }
        
        function save() {

            var planItems = dlg.find('#SELECTEDPLANS').find('LI');
            var sortOrder = 1;
            var plans = [];
            jQuery.each(planItems, function(key, value) {
                    var plan = {id: jQuery(value).attr('id'), sortOrder: sortOrder++ };
                    plans.push(plan) ;            
                } 
            )
        
            //var units = [];
            //packageUnits(units, undefined)
            
            var params = { }
            params.reportname = jQuery.trim(dlg.find('#PLANNAME').val());
            
            /*if (fndAdded) params.addedPlans = added
            if (fndRemoved) params.removedPlans = removed*/

            params.plans = plans;
            

            params.members = packageMembers();
            params.ownerId = dlg.find('#OWNERINPUT_ID').val(); 

            // Validation
            if (params.reportname == '') {

                // We need a plan name
                dlg.find('A[href=\'#tabs-1\']').trigger('click');
                alertDialog(
                        'Error', 
                        'Enter a Market View Report name',
                        {
                            'Ok': function() { 
                                jQuery(this).dialog('close'); 
                            }
                        }
                )

                return;
            }

            // Plan owner seems to be missing
            if (params.ownerId == '') {

                // We need a valid plan owner
                dlg.find('A[href=\'#tabs-1\']').trigger('click');
                alertDialog(
                        'Error', 
                        'New report owner wasn\'t confirmed.  Please select the owner from the list that displays below the input or use the search button to select the owner',
                        {
                            'Ok': function() { 
                                jQuery(this).dialog('close'); 
                            }
                        }
                )
                return;
            }

            _wrapPutPost ({ param: params} , refreshPage)
        
        }

        
        
        
        function refreshPage(info) {

            try {

                onSave(info)

            }
            catch (e) {
                location.reload();
            }

        }
        
        function suicide() {
            dlg.remove();
        } 


        var ajaxSpinnerCnt = 0;
        var spinner;
        
        function showAjaxSpinner(show) {
            
            if (show) { 
                ajaxSpinnerCnt++;
                if (ajaxSpinnerCnt == 1) {

                    spinner = jQuery('<div>').css('position', 'absolute').css('z-index', '2000');

                    jQuery('body').append(spinner);
                    
                    spinner.append(jQuery('<img>').attr('id', 'tas_ajax_spinner').addClass('spinner').attr('src', spinnerURL));
                    spinner.css("top", ( jQuery(window).height() - spinner.height() ) / 2+jQuery(window).scrollTop() + "px");
                    spinner.css("left", ( jQuery(window).width() - spinner.width() ) / 2+jQuery(window).scrollLeft() + "px");
                }                 
            }
            else {

                ajaxSpinnerCnt--;
                if (ajaxSpinnerCnt <= 0) {              
                    spinner.remove();
                    ajaxSpinnerCnt = 0;
                }

            }
        }


        function _wrapPutPost (params, callback, error) {

            showAjaxSpinner(true);
            preventClicksOnDialog(true);

            var err = function(a,b,c) { 

                preventClicksOnDialog(false);
                
                showAjaxSpinner(false);  
				
                try {
                    error && error(a, b, c)
                }
                catch(e) {
                    
                }
                
            }

            var ret = function (result) {  }

            ttgApi.genericAjaxPut('MarketViewAdmin', planId, params, callback, err, ret);

        }

        function _wrapGet (callback, error) {
            if(isopen) {
                return;
            }
            
            isopen = true;
            
            showAjaxSpinner(true);
            
            var ret = function (result) { showAjaxSpinner(false); isopen = false; }

            ttgApi.genericAjaxGet('MarketViewAdmin', planId, callback, error, ret);

        }

        function _wrapDelete (callback, error) {

            showAjaxSpinner(true);
            
            var ret = function (result) { showAjaxSpinner(false);  }

            ttgApi.genericAjaxDelete('MarketViewAdmin', planId, callback, error, ret);

        }

        function preventClicksOnDialog(enable) {

            if (enable) { 
                var width = dlg.parent().width();
                var height = dlg.parent().height();

                dlg.find('#DISABLECLICKS').click( function(event) {event.stopPropagation(); } );

                dlg.find('#DISABLECLICKS').width(width);
                dlg.find('#DISABLECLICKS').height(height);
                
                dlg.parent().find('BUTTON').attr('disabled', 'true')
                dlg.parent().find('A').attr('disabled', 'true')
                dlg.parent().find('INPUT').attr('disabled', 'true')
                dlg.parent().find('SELECT').attr('disabled', 'true')
            }
            else {
            	dlg.parent().find('BUTTON').removeAttr('disabled');
                dlg.parent().find('A').removeAttr('disabled');
                dlg.parent().find('INPUT').removeAttr('disabled');
                dlg.parent().find('SELECT').removeAttr('disabled');
                dlg.find('#DISABLECLICKS').width(0);
                dlg.find('#DISABLECLICKS').height(0);
            }

            
        }
        
        function setupOwnerSearch() {
            var ownerSearchSpec = that.spec;

            ownerSearchSpec.autosearch = false;
            ownerSearchSpec.lookup = { callback: function() { } }

            if ( data.ownerId ) {
                 ownerSearchSpec.previouslySelectedId = data.ownerId;
            }

            var ownerMetadataControl = ttg.metadata(ownerSearchSpec);
            
            if (!readonly) {
                dlg.find('#OWNERINPUT').autocomplete({ 
                        open: ownerMetadataControl.autoCompleteClear, 
                        source: function (term, callback) {
                            
                           	var cb = function(a, b, c) { showAjaxSpinner(false); return callback(a,b,c); }
							
                            showAjaxSpinner(true);
                            
                            return ownerMetadataControl.autoCompleteFind('user', term, cb) 
                        }, 
                        select: ownerMetadataControl.autoCompleteSelected 
                    }
                ).change(function() {
                        jQuery(this).parent().find('INPUT[type=\'hidden\']').val(''); 
                    }
                )
                dlg.find('#SEARCHOWNER').click(function() {
                     
                        if ( dlg.find('#OWNERINPUT_ID').val() && dlg.find('#OWNERINPUT_ID').val().length > 0 ) {
                             ownerSearchSpec.previouslySelectedId = dlg.find('#OWNERINPUT_ID').val();
                        }

                        dlg.find('#SEARCHOWNER').parent().attr('layout','user');
                        ownerMetadataControl.lookup.call(dlg.find('#SEARCHOWNER'), null, ownerSearchSpec.previouslySelectedId);
                    }
                );
                dlg.find('#SEARCHOWNER').parent().attr('layout','user');
            }

            if(! planId) {
                dlg.find('#OWNERINPUT').attr('disabled', 'disabled');
                dlg.find('#SEARCHOWNER').hide();
            }

            dlg.find('#OWNERINPUT').val(data.ownerName); 
            dlg.find('#OWNERINPUT_ID').val(data.ownerId); 
 
        }

        function alertDialog(title, text, actions) {
            
            
            jQuery('<div/>', {title: title}).text(text).dialog({
                    resizable: false,
                    modal: true,
                    buttons: actions,
                    close: function() { jQuery(this).remove() }
                });
            
        }
        
        function getDialogHTML() {
            var html = ''+
                    
                    '<div id="DISABLECLICKS" class="omcDisableClicks" style="width: 0px; height: 0px; z-index: 1002;"></div>' +
                    '<ul>' +
                        '<li><a href="#tabs-1">General</a></li>' +
                        '<li><a href="#tabs-2">Plans</a></li>' +
                        '<li><a href="#tabs-3">Team</a></li>' +
                    '</ul>' +
            
                    '<div class="tabs-spacer"></div>' +
                    '<div id="tabs-1">' +
                        '<div class="GENERALTAB">' + 
                            '<table class="DATERANGE">' +
                                '<tr>' + 
                                    '<td><span class="LABEL">Name:</span>' +
                                    '<td><input type="TEXT" id="PLANNAME" size="60" maxlength="80"/>' +
                                '</tr>' +
                                '<tr>' + 
                                    '<td><span class="LABEL">Owner:</span>' +
                                    '<td>' +
                                        '<span>' +
                                            '<input type="text" id="OWNERINPUT" size="60" maxlength="80"/>' +
                                            '<input type="hidden" id="OWNERINPUT_ID"/>' +
                                            '<a class="MAGNIFY" id="SEARCHOWNER"/>' +
                                        '</span>' +
                                    '</td>' +
                                '</tr>' +
                            '</table>' +
                        '</div>' +
                    '</div>' +
                    '<div id="tabs-2">' +
                        '<div class="DRAGGINGFORDUMMIES PLANINFO">Units which have associated opportunities are indicated with a tick.\nWhere segmentation mapping has been carried out for a unit, its quadrant [A,B,C,D] is also indicated beside the unit name.</div>' +
                        '<div id="ADDPLANS">' +
                            '<input type="text" id="PLANINPUT"/>' +
                            '<input type="hidden" id="PLANINPUT_ID"/>' +
                            '<input type="button" id="SEARCHPLAN" value="Search" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>' +
                            '<input type="button" id="ADDPLAN" value="Add" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>' +
                        '</div>' +
                        '<div id="SELECTEDPLANS" class="PLANSORTABLE">' +
                            '<UL id="ROOTPLANSORTING"/>' +
                        '</div>' +
                    '</div>' +


                    '<div id="tabs-3">' +
                        '<div id="ADDUSER">' +
                            '<input type="text" id="USERINPUT"/>' +
                            '<input type="hidden" id="USERINPUT_ID"/>' +
                            '<input type="button" id="SEARCHUSER" value="Search" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>' +
                            '<input type="button" id="ADDUSER" value="Add" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>' +
                        '</div>' +
                        '<div id="USERS">' +
                        '</div>' +
                    '</div>' +
            
            '';
            
            return html;
            
        }
        
        
        that.configure = configure;
        
        return that;
    } 

    jQuery.fn.setEdgesAutoScrollable = function(options) {
            var defaults = {
                scrollspeed: 200,
                incrementSeed: 20,
                topOffsetTop: -10,
                topOffsetBottom: 30,
                bottomOffsetTop: -20,
                bottomOffsetBottom: 20
            };

            var options = jQuery.extend(defaults, options)

            var top = jQuery(this).offset().top;
            var left = jQuery(this).offset().left;
            var height = jQuery(this).height();
            var width = jQuery(this).width();
            var selectedItemSelector = this.selector;

            var bottom = (top + height);
            var right = (left + width);

            var xmin = left;
            var xmax = right + 20; // take scrollbar into account

            var topScrollTop = top + defaults.topOffsetTop;
            var topScrollBottom = top + defaults.topOffsetBottom;

            var bottomScrollTop = bottom + defaults.bottomOffsetTop;
            var bottomScrollBottom = bottom + defaults.bottomOffsetBottom;

            jQuery().mousemove(function(e) {

                var myPageX = e.pageX;
                var myPageY = e.pageY;

                if (myPageX > xmin && myPageX < xmax) {

                    if (myPageY > topScrollTop && myPageY < topScrollBottom) {
                        //top edges
                        jQuery(selectedItemSelector).scrollTo('-=' + defaults.incrementSeed + 'px', defaults.scrollspeed);
                    } else if (myPageY > bottomScrollTop && myPageY < bottomScrollBottom) {
                        //bottom edges
                        jQuery(selectedItemSelector).scrollTo('+=' + defaults.incrementSeed + 'px', defaults.scrollspeed);
                    } else {
                        jQuery(selectedItemSelector).stop();
                    }
                }

                return true;
            });
        }