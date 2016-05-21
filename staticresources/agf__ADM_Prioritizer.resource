
/**
 * Converts an escaped JSON variable from Visualforce into a valid Javascript variable.
 * var names = vfJsonVar('{!JSINHTMLENCODE(namesAsJson)}');
 */
function vfJsonVar(value) {
    return JSON.parse(_.unescape(value));
}

function addSprintDividersToBacklog() {

    //method is called onload and each time the backlog rank is changed
    var runningTotal = 0.0;
    var dividerHtml = '<li class="sprintDivider ui-state-default"></li>';
    
    //remove old dividers first by class
    var numberOfDividersBefore = $('.sprintDivider').length;
    $('.sprintDivider').remove();
    
    if(teamVelocity != 0) {
        //retrieve all li's
        $('#sortable1 li.sortableLi').each(function(index) {
            
            var points = 0;
            points = $(this).attr('data-work-story-points');
            if(points != null && points != '' && !isNaN(points)) {
                 //if adding the next stories points would exceed the team's velocity then add a sprint divider
                 var potentialTotal = runningTotal + parseInt(points);
                 if(potentialTotal >= teamVelocity) {
                    var currentLiId = $(this).attr("id");
                   
				    //if current story is larger then average velocity then it won't fit in any sprint and according to AC we should quit
                    if( (parseInt(points)) > teamVelocity) {
                    	//add a final divider before the blocking the story and break
                    	if(!$(this).prev().hasClass('sprintDivider')){
                            $(this).before(dividerHtml);
                        }
                        
						return false; //jquery version of break
                    }                       
                   
                    //if current story would exceed the velocity then add divider before it
                    if(potentialTotal  > teamVelocity) {
                        if(!$(this).prev().hasClass('sprintDivider')) {
                            $(this).before(dividerHtml);  
                        }
                        //since the divider is coming before current points should be remembered 
                        runningTotal = parseInt(points);
                    }
                    
                    //if current story would equal the velocity then add divider after it
                    if(potentialTotal == teamVelocity) {
                        $(this).after(dividerHtml); 
                        //reset total
                        runningTotal = 0.0;
                    }
                } else {
                    //adding current work's points did not exceed team velocity so add to total
                    runningTotal = runningTotal + parseInt(points);
                }
            }                   
        }); 
	}
	
	if(numberOfDividersBefore != $('.sprintDivider').length) {
	   handleHeightAdjustment();
	}
}    

$(function() {
	$('#showMore').button().click(function() {
		showMore($(this));	
	});	
	
    $('#select_filter').live('change', function() {
        //hide all of the filter inputs
        $('#dialog-form-filter input.filterValue').hide();
        
        if($(this).val() != '--None--') {
            //show the selected filter input
            $('#' + $(this).val()).toggle();
            
            enableButtonByValue('#' + $(this).parent().attr('Id'), 'Filter');
		}
	});
	
	$("#dialog,#dialog-form-filter").dialog({
        autoOpen: false,
        modal: true
    });
    
    $("#dialog").bind("dialogclose", function(event, ui) {
        $(this).html('');
        $(this).dialog("option", "width", 300); 
        
        for(var idx = 0; idx < highlightIds.length; idx++) {
            highlightRec(highlightIds[idx]);        
        }
                             
        highlightIds = new Array();
    }); 
    
    $('#cancelButton').click(function() {
        clearInputVals();
    });
    
    $("#users").autocomplete({
        source: '{!users}'.split(',')
    });

    $("#sprints").autocomplete({
        source: sprintNames
    });

    $("#at_sprints").autocomplete({
        source: sprintNames
    });
    
    $("#builds").autocomplete({
        source: buildNames
    });
    
    $("#at_builds").autocomplete({
        source: buildNames
    });
    
    $("#themes").autocomplete({
        source: themeNames
    });
    
    $("#at_themes").autocomplete({
        source: themeNames
    });
    
    $('.assignVal').click(function() {
		var hasOpen = false;
		var elClassname = '.' + $(this).parent().text().trim();
	
		$(elClassname).toggle();
	
		$('.assignValTd').each(function() {
			if(!$(this).hasClass('assignValButtons')) {
				if($(this).css('display') == 'table-cell') {
					hasOpen = true;
					return false;
				}
			}
		});
	
		if($('.assignValButtons').css("display") == 'none' || !hasOpen) {
			$('.assignValButtons').toggle();
		}         	
	});

    $('#assignSaveButton').click(function() {
        var ids = new Array();
        var buildName, sprintName, themeName;
        
        //get all of the work IDs for the checked items
        $('.portlet-header').each(function() {
            if($(this).find('.checkMe').attr('checked')) {
                ids.push(getIdFromClass($(this).attr('class'), '_portletHeader'));
            }
        });
        
        var validationContext = {
            formErrors: [],
            addError: function(error) {
                validationContext.formErrors.push(error);
            }
        };
        
        $('.assignValTd').each(function() {
            var thisId = '';
            
            if(!$(this).hasClass('assignValButtons')) {
                var ignoreVal = ($(this).css('display') == 'none') ? true : false;          
                thisId = '#at_' + $(this).attr('class').replace('assignValTd','').trim().toLowerCase() + 's';
                var fieldValue = $(thisId).val();
                var removeVal = fieldValue == 'remove' || fieldValue == '';
                                            
                if(thisId.indexOf('build') > -1) {
                    if(ignoreVal) { 
                        buildName = 'ignore';
                    } else if(removeVal) {
                        buildName = 'remove';
                    } else {
                        buildName = fieldValue;
                        validateBuildName(buildName, validationContext);
                    } 
                } else if(thisId.indexOf('sprint') > -1) {
                    if(ignoreVal) { 
                        sprintName = 'ignore'; 
                    } else if(removeVal) {
                        sprintName = 'remove';
                    } else {
                        sprintName = fieldValue;
                        validateSprintName(sprintName, validationContext);
                    }
                } else if(thisId.indexOf('theme') > -1) {
                    if(ignoreVal) { 
                        themeName = 'ignore';
                    } else if(removeVal) {
                        themeName = 'remove';
                    } else {
                        themeName = fieldValue;
                        validateThemeName(themeName, validationContext);
                    }
                }
            }
        });
        
        if(!themeName || themeName === 'remove') {
            validationContext.addError('Unable to update selected work because a theme name was not specified.<br /><br />Trying to remove a theme?<br />Theme removal is not allowed through the Prioritizer. Visit the related list on the work detail to remove the themes.');
        }
        
        if(validationContext.formErrors.length > 0) {
            var formErrors = validationContext.formErrors.join('<br />');
            formErrors = '<span class="ui-icon ui-icon-alert" style="float: left; width: 16px; margin-right:4px;"></span><span style="float: left; width:220px;"><strong>Errors? What happened? Biker fight? Nose job? What?</strong><br />' + formErrors + '</span>';
            formErrors = '<div class="ui-state-error ui-corner-all ui-helper-clearfix" style="margin: 5px; padding: 5px;">' + formErrors + '</div>';
            $('#dialog')
                .append(formErrors)
                .dialog("option", "width", 330)
                .dialog("option", "minWidth", 300)
                .dialog("option", "minHeight", 200)
                .dialog('open');
        } else if(ids.length == 0) {
            var htmlMessage = '<span class="ui-icon ui-icon-info" style="float: left; width: 16px; margin-right:4px;"></span><span style="float: left; width:220px;">I had to go to Greek school, where I learned valuable lessons such as, "If Nick clicks on the save button and doesn\'t select any records, what\'s gonna happen?" The answer was of course τίποτα (nothing)!</span>';
            htmlMessage = '<div class="ui-state-highlight ui-corner-all ui-helper-clearfix" style="margin: 5px; padding: 5px;">' + htmlMessage + '</div>';
            $('#dialog')
                .append(htmlMessage)
                .dialog("option", "width", 330)
                .dialog("option", "minWidth", 300)
                .dialog("option", "minHeight", 200)
                .dialog('open');
        } else {
            agf.ADM_PriorExt.updateAssignments(teamId, ids.join(","), buildName, sprintName, themeName, handle({
                success: function(results){
                    handleUpdateAssignments(results, buildName, sprintName, themeName)
                },
                fail: function(event) {
                    openErrorDialog({message: 'Unable to update the selected work: ' + event.message});
                },
                finally: closeDialogWithProgressbar
            }), {escape: false}); 
            openDialogWithProgressbar();
        }
    });
    
	$('#cancelButton').click(function() {
        //hide the assign input values
		$('.assignValTd').each(function() {
			if($(this).css('display') != 'none') {
				$(this).toggle();
			}
		});
	});	
	
	$("#sortable1,#sortable2").each(function() { makeMineSortable($(this)) });
    
    $('#sortable1').bind('sortreceive', function(event, ui) {
        if($('#sortable1').sortable('toArray').length <= backlogLimit) {
            savePosition(event, ui, {
                cancel: function() {
                    $(ui.sender).sortable('cancel');
                }
            });
        } else {
            var item_id = $(ui.item).attr("Id");
            $(ui.sender).sortable('cancel');
            
            openErrorDialog({
                message: 'Just as the best wool comes from flocks with ' + backlogLimit + ' sheep or less, our backlog tile only lets you rank ' + backlogLimit + ' stories at a time. If you\'d like to add more, please consider culling some lower-priority stories first.'
            });
            
            if(jQuery.inArray(item_id, highlightIds) < 0) {
                highlightIds.push(item_id);
            }
        }
        handleHeightAdjustment();
    });
    
    $('#sortable1').bind('sortstop', function(event, ui) {
        savePosition(event, ui, {
            cancel: function() {
                $('#sortable1').sortable('cancel');
            }
        });
        handleHeightAdjustment();
    });
    
    //initialize all of the story point select inputs
    $('select.selectPts').each(function() {
        var $container = $(this).closest('[data-work-id]');
        var storyPts = parseInt($container.data('work-story-points'));
        
        //build the story point scale for the current work
        var storyPtScale = new Array();
        for(var i = 0; i < ptScale.length; i++) {
            storyPtScale.push(parseInt(ptScale[i]));    
        }
        
        //if the story points for the work is not found in the scale, add it
        if(!isNaN(storyPts) && jQuery.inArray(storyPts, storyPtScale) < 0) {
            storyPtScale.push(storyPts);
        }
        
        storyPtScale = storyPtScale.sort(function(a,b) {return a -b});
        
        var $select = $(this).empty();
        
        //create the blank item
        $select.append($('<option />').attr('value', '--').text('--'));
        
        //create the select element from the story points scale
        for(var j = 0; j < storyPtScale.length; j++) {
            var $option = $('<option />').attr('value', storyPtScale[j]).text(storyPtScale[j]).appendTo($select);
            if(storyPts === storyPtScale[j]) {
                $option.attr('selected', 'selected');
            }
        }
    });
    $('select.selectPts').live('change', function() { 
        setStoryPts(this) 
    }).live('focus', function() {
        $(this).data('previous-value', $(this).val());
    });
    
    $('.subjectLine').each(function() {
        trimLongTextFromElement($(this));
    });

    $(".portlet-header .expand").live('click', function() {
        $(this).toggleClass("ui-icon-triangle-1-s").toggleClass("ui-icon-triangle-1-e");
        
        $(this).parents(".portlet:first").find('div[class*="portletContent"]').each(function() {
            var $form = $(this);
            var $work = $(this).closest('[data-work-id]');
            
            //if the form is visible and the form has been changed, then show the Save/Revert dialog
            if($form.is(':visible') && isWorkFormChanged($form)) {
                var htmlMessage = '<span class="ui-icon ui-icon-info" style="float: left; width: 16px; margin-right:4px;"></span><span style="float: left; width:220px;">The best feta is saved in brine, just as the best changes to your record are saved by clicking "Save" before closing the record.</span>';
                htmlMessage = '<div class="ui-state-highlight ui-corner-all ui-helper-clearfix" style="margin: 5px; padding: 5px;">' + htmlMessage + '</div>';
                
                $('#dialog')
                    .append(htmlMessage)
                    .dialog("option", "width", 330)
                    .dialog("option", "minWidth", 300)
                    .dialog("option", "minHeight", 200)
                    .dialog("option", "buttons", { 
                        "Save": function() {
                            openDialogWithProgressbar(); 
                            
                            var sObject = getWorkFormValues($work);
                            updateWorkValues(sObject);
                            
                            $(this).dialog("close");
                            $form.toggle();
                        }, 
                        "Revert": function() {
                            cancelUpdateWorkOnPageUsingElement($work);
                            $(this).dialog("close");
                            $form.toggle();
                        }
                    })
                    .dialog('open');
            } else {
                $form.toggle();
            }
        });
        
        handleHeightAdjustment();
    });
    
    $(".cancelPortlet").live('click', function() {
        var $form = $(this).closest('.portlet-content');
        var $work = $(this).closest('[data-work-id]');
        cancelUpdateWorkOnPageUsingElement($work);     
        $form.toggle();
        $work.find('.expand').toggleClass("ui-icon-triangle-1-s").toggleClass("ui-icon-triangle-1-e"); 
        handleHeightAdjustment();
    });

    $(".savePortlet").live('click', function() {
        var $form = $(this).closest('.portlet-content');
        var $work = $(this).closest('[data-work-id]');
        
        if(!isWorkFormChanged($form)) {
            var htmlMessage = '<span class="ui-icon ui-icon-info" style="float: left; width: 16px; margin-right:4px;"></span><span style="float: left; width:220px;">I had to go to Greek school, where I learned valuable lessons such as, "If Nick clicks on the save button and doesn\'t make any changes to the record, what\'s gonna happen?" The answer was of course τίποτα (nothing)!</span>';
            htmlMessage = '<div class="ui-state-highlight ui-corner-all ui-helper-clearfix" style="margin: 5px; padding: 5px;">' + htmlMessage + '</div>';
            $('#dialog')
                .append(htmlMessage)
                .dialog({
                    "width": 330,
                    "minWidth": 300,
                    "minHeight": 200,
                    "buttons": {
                        "OK": function() {
                            $(this).dialog("close");
                        }
                    }
                }).dialog('open');
        } else {
            openDialogWithProgressbar();
            var sObject = getWorkFormValues($work);
            updateWorkValues(sObject);
        }
    });
    
    $(".ui-state-default").each(function() {
        if($(this).hasClass('sprintDivider')) {
        } else {
            $(this).prepend("<input type='checkbox' class='toggle checkAll' />");
        }
    });
        
    $(".checkAll").click(function() {
        var checkAll = ($(this).attr('checked')) ? true : false;                        
           
        $(this).parents("[id^='sortable']").find(".checkMe").each(function() {
            if(checkAll) {
                $(this).attr('checked', 'checked');    
            } else {
                $(this).removeAttr('checked');
            }
        });
        
        limitSelected();
    });

    $(".checkMe").click(function() {
        limitSelected(); 
    });
    
  
    $('label[for="filter"]').addClass('ui-state-active').attr('aria-pressed', true);
    
    
    
    $('.assignValButton').button().addClass('ui-state-error');  
    
    $('#showMore').button({
        icons: {
            primary: "ui-icon-triangle-1-s"
        }
    });
    
    $('#vcButton').button({
        icons: {
            primary: "ui-icon-wrench"
        }
    }).click(function() {
        selectNumSprints(); 
    });
    
    
    function clearFilterForm() {
        //reset the filter option
        $('#select_filter option').filter(function(){
            return $(this).text() == '--None--';
        }).attr('selected', 'selected');
    
        //clear and hide all of the filter inputs
        $('#dialog-form-filter input.filterValue').hide().val('');
    }
    
    $('#openFormFilter').click(function() {
        clearFilterForm();
        openFilterDialog('#dialog-form-filter');
    });
    
    $("#backlog").click(function() {
        $("#sortable1").toggle();
        handleWidthAdjustment();
    });
    
    $("#backburner").click(function() {             
        $("#sortable2").toggle();
        handleWidthAdjustment();
    });
    
    $("#filter").click(function() {
        var $checkEl = $('#sortable3');
        $checkEl.toggle();
        
        if($checkEl.is(':visible')) {
            openFilterDialog('#dialog-form-filter');
        } else {
            $('#sortable3').find('li:gt(0)').remove();
            $('#sortable3').find('.tileTitle').text('Filter');
            clearFilterForm();
        }
        
        handleWidthAdjustment(); 
    });
    
    //due to firefox vs chrome differences instead of hiding the filter tab via CSS on load we now toggle it
    $("#filter").click();
    $("#filter").attr('checked','checked');
    $("#backlog,#backburner").removeAttr('checked');
    
    $("#buttonSetFilters,#buttonSetVelocityControl").buttonset(); 
    
    $(document).ready(function() {
        queueHeightAdjustment();
        handleWidthAdjustment();
    });
    
    $(window).resize(function() {
        handleHeightAdjustment();
        handleWidthAdjustment();                   
    });    
});
        
function getIdFromClass(classVal, pattern) {
    idFromClass = '';
    classNames = classVal.split(' ');
    
    for(var i = 0; i < classNames.length; i++) {
        className = classNames[i];
        if(className.indexOf(pattern) > -1) {
            idFromClass = className.replace(pattern, '');
        } 
    }
    
    return idFromClass;
}

function clearObjectValues(obj) {
    for(var i in obj) {
        obj[i] = '';
    }
}

function setValById(id2clearVal, textVal) {
    setValByIds(new Array(id2clearVal), textVal);
}

function setValByIds(ids2clearVal, textVal) {   
    for(var i = 0; i < ids2clearVal.length; i++) {
        $('#' + ids2clearVal[i]).val(textVal);
    }
}

function hideById(id2hide) {
    hideByIds(new Array(id2hide));
}

function hideByIds(ids2hide) {  
    for(var i = 0; i < ids2hide.length; i++) {
        $('#' + ids2hide[i]).hide('blind', 1);
    }
}

function toggleById(id2toggle) {
    toggleByIds(new Array(id2toggle));
}

function toggleByIds(ids2toggle) {  
    for(var i = 0; i < ids2toggle.length; i++) {
        $('#' + ids2toggle[i]).toggle();
    }
}

function toggleAssignValTd() {
    $('.assignValTd').toggle();
}

function openFilterDialog() {
    $('#dialog-form-filter')
        .dialog({
            "buttons": { 
                "Filter": function() {
                    $(this).dialog("close");
                    openDialogWithProgressbar();
                    getFilteredWork({success:getFiltered});
                }
            },
            "width": 400
        })
        .dialog('open');
}

function disableButtonByValue(dialogId, buttonText) {
    $(dialogId).parent().find('button').each(function() {
        if($(this).text() == buttonText) {
            $(this).attr('disabled', true);
            $(this).addClass('ui-state-disabled');
        }
    });
}

function enableButtonByValue(dialogId, buttonText) {
    $(dialogId).parent().find('button').each(function() {
        if($(this).text() == buttonText) {
            $(this).attr('disabled', false);
            $(this).removeClass('ui-state-disabled');
        }
    });
}

function makeMineSortable(sortMe) {
    sortMe.sortable({
        cancel: ".dataCol,:input,button",
        connectWith: "ul",
        cursor: "move",
        delay: 0,
        distance: 1,
        dropOnEmpty: true,
        handle: '.portlet-handle',
        items: '.sortableLi',
        opacity: 0.8,
        scroll: true,
        scrollSensitivity: 80,
        scrollSpeed: 20,                
        tolerance: "pointer",
        over: function(ev, ui) {
            handleHeightAdjustment();
        }
    });
}

function isVisible(elChecking) {
    return elChecking.is(':visible');
}



function hasChangedValue(oldEl, newEl) {
    var hasChange = false;
    
    if(oldEl == null || typeof oldEl == 'undefined') {
        oldEl = '';
    }
                
    if(newEl == null || typeof newEl == 'undefined') {
        newEl = '';
    }
    
    if(jQuery.trim(oldEl) != jQuery.trim(newEl)) {
        hasChange = true;
    }
    return hasChange;
}

function getWorkFormValues($work) {
    return {
        "Id": $work.data('work-id'),
        "Subject__c": $work.find('input[name=subject]').val(),
        "Status__c":  $work.find('select[name=status]').val(),
        "Details__c": $work.find('textarea[name=details]').val()
    };
}

function isWorkFormChanged($work) {
    var oSubject = $work.find('input[name="oSubject"]').val();
    var subject2save = $work.find('input[name="subject"]').val();
    if(hasChangedValue(oSubject, subject2save)) {
        return true;
    }
    
    var oDetails = $work.find('input[name="oDetails"]').val();
    var details2save = $work.find('textarea[name="details"]').val();
    if(hasChangedValue(oDetails, details2save)) {
        return true;
    }
    
    var oStatus = $work.find('input[name="oStatus"]').val();
    var status2save = $work.find('select[name="status"]').val();
    if(hasChangedValue(oStatus, status2save)) {
        return true;
    }
    
    return false;
}

function limitSelected() {
    var selectLimit = 100;
    var selectedWork = [];
    var highlightIds = [];
    
    $("[id^='sortable'] .checkMe:checked").each(function() {
        if(selectedWork.length > selectLimit) {
            var item_id = $(this).closest('[data-work-id]').data('work-id');
            $(this).removeAttr('checked');
            if(jQuery.inArray(item_id, highlightIds) < 0) {
                highlightIds.push(item_id);
            }
        } else {
            selectedWork.push($(this));
        }
    });
    
    if(highlightIds.length > 0) {
        var formErrors = '<div class="ui-state-error ui-corner-all ui-helper-clearfix" style="margin: 5px; padding: 5px;"><span class="ui-icon ui-icon-alert" style="float: left; width: 16px; margin-right:4px;"></span><span style="float: left; width:220px;"><strong>The best feta comes from farms with no more than ' + selectLimit + ' sheep.</strong><br />That\'s why we\'ve limited mass editing to ' + selectLimit + ' work recods.</span></div>';
        
        $('#dialog')
            .append(formErrors)
            .dialog({
                "width":330,
                "minWidth": 300,
                "minHeight": 200
            })
            .dialog('open');
    }
}





function clearInputVals() {
    $('.assignValTd input').val('');
}

function clearCheckAll() {
    var hasCheck = false;
    $("[id^='sortable']").each(function(i) {
        $(this).find(".checkMe").each(function() {                      
            if($(this).attr('checked')) {
                hasCheck = true;
                return false;
            }                       
        });
        if(!hasCheck) {
            $(this).find(".checkAll").removeAttr('checked');
        }
    });
    
}

function toggleAssignValTd() {
    $('.assignValTd').toggle();
}

function handleWidthAdjustment() {
    var width = $(window).width();
    var lenVisibleCols = $('.sortable:visible').length;
    
    //calculate the width of the visible columns
    var newWidth = Math.round(width / lenVisibleCols) - Math.round(40 / (lenVisibleCols * 0.50));
    $(".sortable:visible").width(newWidth);
    
    //show more fields when a single column is displayed
    if(lenVisibleCols == 1) {
        $(document.body).removeClass('portlet-count-n');
    } else {
        $(document.body).addClass('portlet-count-n');
    }
    
    handleHeightAdjustment();
}

function validateBuildName(value, context) {
    if(jQuery.inArray(value, buildNames) < 0 || (value != '' && buildNames.length == 0)) {
        context.addError('An invalid build was entered');
    }
}

function validateSprintName(value, context) {
    if(jQuery.inArray(value, sprintNames) < 0 || (value != '' && sprintNames.length == 0)) {
        context.addError('An invalid sprint was entered');
    }
}

function validateThemeName(value, context) {
    if(jQuery.inArray(value, themeNames) < 0 || (value != '' && themeNames.length == 0)) {
        context.addError('An invalid theme was entered');
    }
}

function trimLongTextFromElement(trimEl) {
    trimEl.text(trimLongTextFromString(trimEl.text()));
}

function trimLongTextFromString(trimMe) {        
    var textLines = new Array();
    var newText = '';
    var textLine = '';
    
    if(trimMe.length > 20) {                
        textLines = trimMe.trim().split(' ');
        
        for(var i = 0; i < textLines.length; i++) {
            textLine = textLines[i];
            
            if(textLine.length > 20) {
                newText += textLine.substring(0,17) + '...';
            } else {
                newText += textLine;
            }
            
            newText += ' '; 
        }
    } else {
        newText = trimMe;
    }
    
    return newText;
}

function highlightRec(id2use) {
    var options = {};
    $('.' + id2use + '_portletHeader').each(function() {
        $(this).effect('highlight', options, 2000);
    });
}
(function(container) {
    var timeouts = [];
    
    container.queueHeightAdjustment = function(time) {
        timeouts.push(setTimeout("handleHeightAdjustment()", time | 100));
    }
    
    container.handleHeightAdjustment = function() {
        var maxH = 0;
        var minH = 0;
        
        $("[id^='sortable']").each(function(outerIndex) {
            var colH = 0;
            $(this).find("li").each(function(innerIndex) {
                colH += $(this).outerHeight(true);  
            });
            
            if(outerIndex == 0) {
                minH = colH;
                maxH = colH;    
            } else {
                if(colH > maxH) {
                    maxH = colH;
                }
                if(colH < minH) {
                    minH = colH;
                }
            }
        });
        
        $("[id^='sortable']").outerHeight(maxH);
        
        //clear any queued height adjustments
        var queuedTimeouts = timeouts.slice(0);
        timeouts = [];
        for(var index = 0; index < queuedTimeouts.length; index++) {
            clearTimeout(queuedTimeouts);
        }
    }
})(window);

/**
 * Gets a comma-separated list of work IDs and rank
 * @param el Optional: If specified, this element is checked against the list of elements. If it is not found, then
 *           the list will contain the ID of the element at rank -1
 */
function getPR2Update(els, el) {
    var arrUpdate = new Array();
    var removeEl = true;
    
    els.each(function(i) {
        var thisRank = i + 1;
        var priorityRank = $(this).find('.priorityRank').text().trim();
        
        
        //if the priority rank on the element is different, add it to the updated rank array
        if(priorityRank == '' || priorityRank != thisRank) {
            arrUpdate.push($(this).attr("Id") + '=' + thisRank);
        }
        
        //if the element was found in the list of elements, then it wasn't deleted
        if($(this).attr("Id") === el.attr("Id")) {
            removeEl = false;
        }
    });
    
    //if the object was not found in the list, then set its rank to -1
    if(removeEl) {
        arrUpdate.push(el.attr("Id") + '=-1');
    }
    
    return arrUpdate.join(",");
}


function getFiltered(vfResults, options) {
    $('#sortable3').find('li:gt(0)').remove();
    
    var objRelated, objectFieldName;
    if(options.obj__r) {
        objRelated = options.obj__r.split('.')[0];
        objFieldName = options.obj__r.split('.')[1];
    }
    var titleText = '';
    
    for(var i = 0; i < vfResults.length; i++) {
        var vfResult = vfResults[i];
        
        //get the title of the column from the first object
        if(i == 0 && objRelated && objFieldName) {
            try {
                titleText = vfResult[objRelated][objFieldName];
            } catch(e) { }                          
        } 
        
        var $original = $('li.sortableLi').first();
        if($original.length > 0) {
            setupDuplicate(vfResult, $original, '#sortable3');
        }
    }
    
    if(titleText == null || jQuery.trim(titleText) == '') {
        if(jQuery.trim(options.fieldValue) == '') {
            titleText = options.objectTitle;
        } else {
            titleText = trimLongTextFromString(options.fieldValue);
        }
    }
    
    $('#sortable3 .tileTitle').text(titleText);
}

function savePosition(event, ui, options) { 
    
    //get a comma-seperated list of work IDs and their rank
    var ranks = getPR2Update($('#sortable1 .sortableLi'), $(ui.item));
    
    openDialogWithProgressbar();
    
    agf.ADM_PriorExt.updateBacklogRank(ranks, handle({
        success: function(result) {
            //make sure to highligh the row
            var item_id = $(ui.item).attr("Id");
            if(jQuery.inArray(item_id, highlightIds) < 0) {
                highlightIds.push(item_id);
            }
            
            refreshPriorityRank(result);
        }, 
        fail: function(event) {
            if(options && options.cancel) {
                options.cancel();
            }
            openErrorDialog({
                message: 'Error while changing the backlog rank: ' + event.message
            });
        },
        finally: closeDialog
    }), {escape:false});
}

function refreshPriorityRank(resultFromVFRemoting) {
    for(var i = 0; i < resultFromVFRemoting.length; i++) {
        var id2use = resultFromVFRemoting[i].Id;
        var $rank = $('.' + id2use + '_rank');
        
        if(resultFromVFRemoting[i].Priority_Rank__c != null) {
            $rank.text(resultFromVFRemoting[i].Priority_Rank__c);
        } else {
            $rank.text('');
        }
    } 
    
    addSprintDividersToBacklog();      
}

function setStoryPts(selEl) {           
    //update title of li which stores hidden version of story points used by sprint bucketing
    workId = getIdFromClass(selEl.className, '_selectPts');
    $('#' + workId).attr('data-work-story-points', selEl.value);
    
    var onFail = function(event) {
        if($(selEl).data('previous-value')) {
            $(selEl).val($(selEl).data('previous-value'));
        }
        openErrorDialog({message: 'Error while saving story points: ' + event.message});
    };
    
    agf.ADM_PriorExt.updateStoryPts(workId, selEl.value, handleDmlResult({
        success: handleSetStoryPoints,
        fail: onFail,
        finally: closeDialogWithProgressbar
    }));
    openDialogWithProgressbar();
}

function handleSetStoryPoints(resultFromVfRemoting) {
    if(resultFromVfRemoting == null) {
        console.error('no results from handleSetStoryPoints');
    } else if(resultFromVfRemoting.success) {
        var id2use = resultFromVfRemoting.id;
        $('.' + id2use + '_selectPts').each(function() {
            if($(this).val() != resultFromVfRemoting.work.Story_Points__c) {
                $(this).val(resultFromVfRemoting.work.Story_Points__c);
            }
        });
        highlightIds.push(id2use);
    }
    
    addSprintDividersToBacklog();
}

function updateWorkValues(sObject, options) {
    agf.ADM_PriorExt.updateWorkVals(sObject.Id, sObject.Subject__c, sObject.Details__c, sObject.Status__c, handleDmlResult({
        success: handleUpdateWorkVals, 
        fail: function(event) {
            if(options && options.cancel) {
                options.cancel();
            }
            openErrorDialog({message: 'Error while saving work values: ' + event.message});
        },
        finally: closeDialogWithProgressbar
    }), {escape:false});
}

function handleUpdateWorkVals(resultFromVfRemoting) {
    if(resultFromVfRemoting == null) {
        console.error('no results from handleUpdateWorkVals');                  
    } else {
        if(resultFromVfRemoting.success) {
            var id2use = resultFromVfRemoting.id;
            highlightIds.push(id2use);
            $('#dialog').dialog('close');
            updateWorkOnPage(id2use, resultFromVfRemoting.work);
            addSprintDividersToBacklog();   
        } else {
            $('#dialog').empty().append('<div class="ui-state-error ui-corner-all ui-helper-clearfix" style="margin: 5px; padding: 5px;"><span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span><span style="float: left; width: 220px;"><div class="dialog-title" style="font-weight: bold;">Errors? What happened? Biker fight? Nose job? What?</div><div class="dialog-body"></div></span></div>');
            $('#dialog .dialog-body').text(resultFromVfRemoting.error);
            $('#dialog').dialog('option','title','Error occurred while saving').dialog('open');
        }   
    }
} 

function getRelatedName(vfResult, relatedName) {
    var rName = '';
    try {
        rName = vfResult[relatedName]['Name'];
    } catch(e) {}
    return rName;
} 

function isNull(checkMe) {
    var isNull = false;
    try {
        if(checkMe == null || typeof checkMe == 'undefined') {
            isNull = true;
        }   
    } catch(e) {}
    return isNull;
}

String.prototype.capitalize = function(){
    return this.replace( /(^|\s)([a-z])/g , function(m,p1,p2){ return p1+p2.toUpperCase(); } );
};

function updateWorkOnPage(id2use, workUpdated) {
    var vals2check = new Object();
    var currVals = new Object();
    
    vals2check['subject'] = 'Subject__c';
    vals2check['details'] = 'Details__c';
    vals2check['subject'] = 'Subject__c';
    vals2check['status'] = 'Status__c';
    
    //if it expanded, then collapse it
    $("." + id2use + "_portletContent").each(function() {
        if(isVisible($(this))) {
            $(this).hide('blind',1000);
            $(this).parents(".portlet:first").find('span.expand').toggleClass("ui-icon-triangle-1-e").toggleClass("ui-icon-triangle-1-s");
        }               
    });
    
    for(var i in vals2check) {
        try {
            if(i == 'subject') {
                currVals[i] = trimLongTextFromString(workUpdated[vals2check[i]]);
            } else { 
                currVals[i] = workUpdated[vals2check[i]];
            }

            $('.' + id2use + '_' + i).each(function() {
                $(this).val(workUpdated[vals2check[i]]);
            });
            
            $('.' + id2use + '_o' + i.capitalize()).each(function() {
                $(this).val(workUpdated[vals2check[i]]);
            });                 
        } catch(e) {} 
    }   
                        
    $('.' + id2use + '_sub').text(currVals['subject']);
    
    if(workUpdated.Closed__c == 1) {
        $('ul').each(function() { 
            $(this).find('#' + workUpdated.Id).remove();
        }); 
        //refresh the backlog since the ranks will be incorrect now that closed records have been removed
        var firstRecord = $('#sortable1').find('.sortableLi:first');
        savePosition(null, firstRecord);
    }
    
    queueHeightAdjustment(1000);
}

function restoreOldValue(oldEl, newEl) {
    try {
        newEl.val(oldEl.val());
    } catch(e) {}
}

function cancelUpdateWorkOnPageUsingElement(selectedEl) {
    var oSubject = selectedEl.find('input[name="oSubject"]');
    var subject2save = selectedEl.find('input[name="subject"]');
    restoreOldValue(oSubject, subject2save);
    
    var oDetails = selectedEl.find('input[name="oDetails"]');
    var details2save = selectedEl.find('textarea[name="details"]');
    restoreOldValue(oDetails, details2save);
    
    var oStatus = selectedEl.find('input[name="oStatus"]');
    var status2save = selectedEl.find('select[name="status"]');
    restoreOldValue(oStatus, status2save);
}

function addThemeToWork($work, theme) {
    //only add the theme if the name is not already present
    $work.find('.themeNames').each(function() {
        if($(this).find('.themeItem[data-theme-id=' + theme.Id + ']').size() === 0) {
            $('<span>').addClass('themeItem').attr('data-theme-id', theme.Id || '').text(theme.Name || '').appendTo($(this));
        }
    });
}

function updateAssignmentVals(id2use, fieldVal, fieldId) {
    if(fieldVal != 'ignore') {
        $("." + id2use + fieldId + "").each(function() {
            if(fieldVal == 'remove') {
                $(this).text('');
            } else {
                $(this).text(fieldVal);
            }
        });
    }
}

//FIXME: why are we using the build/sprint/theme values entered by the user instead of getting the real values from the DB? 
function handleUpdateAssignments(resultFromVFRemoting, buildName, sprintName, themeName) {
    if(resultFromVFRemoting == null) {
        console.error('no results from handleUpdateAssignments');
    } else {
        var hasError = false;
        var htmlMessage = '';
        var pass = 0;
        var fail = 0;
        
        $("#dialog").dialog("close");
        
        $.each(resultFromVFRemoting, function(index, saveResult) {
            var id2use = saveResult.Id;
            var workSaveResult = saveResult.workDmlResult;
            var themeSaveResult = saveResult.themeDmlResult;
            var success = true;
            var $work = $('[data-work-id=' + saveResult.Id +']');
            
            //check to see if the work was saved properly
            if(workSaveResult) {
                if(workSaveResult.success) {
                    updateAssignmentVals(id2use, buildName, '_build');
                    updateAssignmentVals(id2use, sprintName, '_sprint');
                } else {
                    success = false;
                    htmlMessage +=  workSaveResult.error + '<br />';
                }
            }
            
            //check to see if the theme assignment was successful
            if(themeSaveResult) {
                if(themeSaveResult.success) {
                    if(saveResult.theme) {
                        addThemeToWork($work, saveResult.theme);
                    }
                } else {
                    success = false;
                    htmlMessage += themeSaveResult.error + '<br />';
                }
            }
            
            if(success) {
                highlightIds.push(id2use);
                pass++;
                $("." + id2use + "_portletHeader").find('.checkMe').removeAttr('checked');
            } else {
                fail++;
                hasError = true;
            }
        });
        
        if(hasError) {
            var htmlError = '<span class="ui-icon ui-icon-alert" style="float: left; margin-right: .3em;"></span><span style="float: left;"><strong>Errors? What happened? Biker fight? Nose job? What?</strong><br />';
            if(pass > 0) {
                htmlMessage = htmlError + '<p>Looks like this is a good news, bad news moment.<ul><li>Records saved: ' + pass + '</li><li>Records failed to save: ' + fail + '</li></ul></p>' + htmlMessage + '</span>';
            } else {
                htmlMessage = htmlError + htmlMessage + '</span>';
            }
            htmlMessage = '<div class="ui-state-error ui-corner-all ui-helper-clearfix" style="margin: 5px; padding: 5px;">' + htmlMessage;
            htmlMessage += '</div>'
            $('#dialog').append(htmlMessage);
            $('#dialog').dialog("option", "width", 600);
        } else {
            $('#dialog').dialog("option", "width", 300);
            $('#dialog').dialog("option", "minWidth", 300);
            $('#dialog').dialog("option", "minHeight", 300);
            $('#dialog').append('<div class="ui-corner-all ui-helper-clearfix" style="margin: 5px; padding: 5px;"><span class="ui-icon ui-icon-info" style="float: left; width:16px; margin-right: 4px;"></span><span style="float: left; width:220px;color:green">Opa! Everything saved successfully.</span></div>');
            $('#builds').val('');
            $('#sprints').val('');
            $('#themes').val('');
            $('.assignValTd').each(function() {
                if($(this).css('display') == 'none') {
                } else {
                    $(this).toggle();
                }
            });
            clearInputVals();                        
            
            addSprintDividersToBacklog();                        
        } 
        
        clearCheckAll();
    }
    
    $('#dialog').dialog( "option", "buttons", {
        "Ok": function() {
            $(this).dialog("close");
        }
    });
    
    $("#dialog").dialog("open");
}

function createCookie(name,value,days) {
    if(days) {
        var date = new Date();
        date.setTime(date.getTime()+(days*24*60*60*1000));
        var expires = "; expires="+date.toGMTString();
    } else {
        var expires = "";
    }
    document.cookie = name+"="+value+expires+"; path=/";
}

function readCookie(name) {
    var nameEQ = name + "=";
    var ca = document.cookie.split(';');
    for(var i=0;i < ca.length;i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') c = c.substring(1,c.length);
        if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
    }
    return null;
}

function getMoreRecs() {
    var lastBacklogEntry = $('#sortable1 > .sortableLi:last');
    var lastBacklogWorkId = lastBacklogEntry.data('work-id');
    var lastBackburnerWorkId = $('#sortable2 > .sortableLi:last').data('work-id');
    
    var getMorebbId = '';
    var getMoreblId = '';
    var rankSpan = '';
    
    if(lastBackburnerWorkId != null && typeof lastBackburnerWorkId != 'undefined') {
        getMorebbId = lastBackburnerWorkId;
    }
    
    if(lastBacklogWorkId != null && typeof lastBacklogWorkId != 'undefined') {
        getMoreblId = lastBacklogWorkId;
        rankSpan = lastBacklogEntry.find('.backlogRank').html();
    }
    
    //getMoreRecs() has been updated to handle empty variables as it a valid for a new team to have zero items on their backlog or backburner
    agf.ADM_PriorExt.getMoreRecs(getMorebbId, getMoreblId, rankSpan, handle({
        success: handleGetMoreRecs
    }), {escape:false});
}

function handleGetMoreRecs(vfResults) {
    console.debug('inside handleMoreRecs()');
    if(vfResults == null) {
        console.error('no results from handleGetBackburner');
    } else {
    
        //add the new entries to the backlog
        if(vfResults.backlog != null && vfResults.backlog.length > 0) {
            addWorkToColumn('#sortable1', vfResults.backlog);
            addSprintDividersToBacklog();
        }
        
        //add the new entries to the back burner
        if(vfResults.backburner != null && vfResults.backburner.length > 0) {
            addWorkToColumn('#sortable2', vfResults.backburner);
        }
        
        if(vfResults.hasMore) {
            $('#showMore').button('enable');
        } else {
            $('#showMore').button('disable');
        }
    }
}

function addWorkToColumn(columnId, sObjects) {
    //TODO: this will fail if there are no entries within the column
    var $masterDup = $(columnId).find('.sortableLi:last');

    for(var i = 0; i < sObjects.length; i++) { 
        var sObject = sObjects[i];
        
        //create the duplicate
        var $dup = setupDuplicate(sObject, $masterDup, columnId);
        
        //update the duplicate
        updateWorkStatus($dup, sObject);
        updateWorkStoryPoints($dup, sObject);
    }
    
    queueHeightAdjustment();
}

function updateWorkStatus($work, sObject) {
    $work
        .find('select[name="status"] option')
        .filter(function(){ 
            return $(this).val() == sObject.Status__c;
        })
        .attr('selected','selected')
}

function updateWorkStoryPoints($work, sObject) {
    var storyPoints = (typeof sObject.Story_Points__c == 'undefined')? '--' : sObject.Story_Points__c;
    $work
    	.find('select.selectPts option[selected="selected"]').removeAttr('selected').end()
        .find('select.selectPts option')
        .filter(function(){
            return $(this).val() == storyPoints;
        })
        .attr('selected','selected');
}

function setupDuplicate(vfResult, masterDup, id2appendTo) {
    var $dup = masterDup.clone();
    var masterId = $dup.attr('Id');
    
    //rebuild the status select options
    if(statusValues && statusValues[vfResult.RecordType.Name]) {
        var $status = $dup.find('select[name="status"]').empty();
        $.each(statusValues[vfResult.RecordType.Name], function(index, value) {
            $('<option>').attr('value', value).text(value).appendTo($status);
        });
    }
    
    //rebuild the themes 
    var $themeContainer = $dup.find('.themeNames').empty();
    if(vfResult.Theme_Assignments__r) {
        $.each(vfResult.Theme_Assignments__r, function(index, themeAssignment) {
            if(themeAssignment.Theme__r) {
                var theme = themeAssignment.Theme__r;
                addThemeToWork($dup, theme);
            }
        });
    }
    
    var storyPts = vfResult.Story_Points__c;
    var sprintName = getRelatedName(vfResult, 'Sprint__r');
    var buildName = getRelatedName(vfResult, 'Scheduled_Build__r');
    var subjectVal = trimLongTextFromString(vfResult.Subject__c);
    
    
    var vals2check = new Object();
    var currVals = new Object();
    
    vals2check['details'] = vfResult.Details__c;
    vals2check['recTypeFields'] = vfResult.RecordType.Name;
    vals2check['status'] = vfResult.Status__c;
    vals2check['subject'] = subjectVal;
    vals2check['recTypeIcon'] = iconUrl[vfResult.RecordType.Name];
    vals2check['_rank'] = vfResult.Priority_Rank__c;
    vals2check['_pts'] = storyPts;
    vals2check['_selectPts'] = storyPts;
    vals2check['_sub'] = subjectVal;            
    vals2check['_sb'] = buildName;
    vals2check['_build'] = buildName;           
    vals2check['_sprint'] = sprintName;
    vals2check['_nameLink'] = vfResult.Name + '|' + vfResult.Id;
    
    var arrTextEls = new Array('TD', 'SPAN', 'DIV');
    var arrTypeEls = new Array();
    
    for(var i in vals2check) {
        if(i.indexOf('_') > -1) {
            if(i === '_nameLink') {
                $dup.find('.' + masterId + i).each(function() {
                    $(this).text(vals2check[i].split('|')[0]);
                    $(this).attr('href', '/' + vals2check[i].split('|')[1]);
                });
            } else {       
                var newValue = vals2check[i];
                if(typeof newValue == 'undefined') {
                    newValue = '';
                }
                
                $dup.find('.' + masterId + i).each(function() {
                    if(jQuery.inArray(this.tagName, arrTextEls) > -1) {
                        $(this).text(newValue);
                    } else {
                        $(this).val(newValue);
                    }
                });
            }
        } else if(i === 'recTypeIcon') {
            $dup.find('.' + i).attr('src', vals2check[i]);
        } else if(i === 'recTypeFields') {
            //User Story has specific fields.  If record type is not a story then hide those fields.  TODO: refactor if more rec type dependent fields are added
            if(vfResult.RecordType.Name != 'User Story') {
                $dup.find('.UserStoryOnly').hide();
            } else {
                $dup.find('.UserStoryOnly').show();
            }   
        } else {
            $dup.find('.' + masterId + '_' + i).each(function() {
                $(this).val(vals2check[i]);
            });
            $dup.find('.' + masterId + '_o' + i.capitalize()).each(function() {
                $(this).val(vals2check[i]);
            });
        }
    }
    
    var arrTypes = new Array('div', 'input', 'span', 'a', 'select', 'textarea', 'td', 'li');
    
    for(var i = 0; i < arrTypes.length; i++) {
        $dup.find(arrTypes[i] + '[class*="' + masterId + '"]').each(function() {
            var classes = $(this).attr('class').split(' ');
            for(var i = 0; i < classes.length; i++) {
                if(classes[i].indexOf(masterId) > -1) {
                    var oldClass = classes[i];
                    var newClass = classes[i].replace(masterId, vfResult.Id);
                    $(this).removeClass(oldClass).addClass(newClass);
                }
            }
        });
    } 
    
    $dup.attr('Id', vfResult.Id).attr('data-work-id', vfResult.Id);
    
    if(storyPts) {
        $dup.attr('data-work-story-points', storyPts);
    } else {
        $dup.removeAttr('data-work-story-points');
    }
    $dup.appendTo($(id2appendTo));
    
    return $dup;
}

function showMore(clicked) {
    getMoreRecs();
    $('#showMore').button('disable');
}

function toggleRowHeader(clickedRow) {
    $(clickedRow).parents(".portlet:first").find('span[class*="_recordHeaderRow"]').toggleClass('recordHeaderSelected').toggleClass('recordHeaderUnselected');
}
