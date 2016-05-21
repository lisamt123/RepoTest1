var ttg = ttg || {};

ttg.fileExportDialog = function(spec) {
    var that = {};
    that.spec = spec;

    var type = spec.type;
    var label = spec.label;
    var id = spec.id; 
    var exporter = spec.exporter;
    var cleanUp = spec.cleanUp;

    var dialogOpen = true;
    var callCount = 0;

    function createAdvice() {
        return jQuery('<ol/>')
                .append(jQuery('<li/>').text('Dealmaker is preparing to export your ' + label + '.'))
                .append(jQuery('<li/>').text('Once complete a link will appear below.'))
                .append(jQuery('<li/>').text('Right click this link and save the file.'))
    }

    function createControlDiv() {
        callCount = 0;
        return  jQuery('<div/>')
            .css({ width : '100%', 'text-align' : 'center'})
            .addClass('ttg_future_exporter_linkdiv')
            .append(jQuery('<span/>').text('Preparing'));
            
    }    

    function callController(controllerMethod, success, error, complete) {
        var succ = function(data) { try { success(data); } finally { complete(); } };
        var err = ttg.ajaxErrorFunction(
            error,
            complete,
            {
                showDetail: true, 
                title: 'Error Exporting ' + label
            }
        );
        if (id === undefined) {
            ttgInvoker.invokeVFR(ttg.getController(controllerMethod), 
                type,
                function(result, event) { 
                    if (event.type == 'exception') { 
                        err(result,event);
                    } else {
                        succ(result); 
                    } 
                }, 
                {escape: false});            
        } else {
            ttgInvoker.invokeVFR(ttg.getController(controllerMethod), 
                id,
                function(result, event) { 
                    if (event.type == 'exception') { 
                        err(result,event);
                    } else {
                        succ(result); 
                    } 
                }, 
                {escape: false});
        }
    }    

    function deletefutureConfigExport() {
        callController(cleanUp,
            function() { checkForFutureConfigExportUrl() },                    
            function() { /* error */ },                 
            function() { /* complete */ }               
        )
        
    }           
    
    function checkForFutureConfigExportUrl() {
        callController(exporter,
            function(responseData) { 
                if (responseData != null && responseData.downloadURL != null) {
                    jQuery('.ttg_future_exporter_linkdiv').html('');

                    jQuery('.ttg_future_exporter_linkdiv').append(
                        jQuery('<a/>', {href: responseData.downloadURL }).css('cursor', 'pointer').text('Click to save ' + label)
                    )
                }
                else {
                    if (++callCount > 40) {
                        jQuery('.ttg_future_exporter_linkdiv').html('');
                        jQuery('.ttg_future_exporter_linkdiv').append(
                            jQuery('<a/>').text('Taking too long.  Continue waiting?').css('cursor', 'pointer').click(function() { callCount = 0; checkForFuturePPTXUrl()} ) 
                        )
                    }
                    else {
                        jQuery('.ttg_future_exporter_linkdiv').html('');
                        jQuery('.ttg_future_exporter_linkdiv').append(
                            jQuery('<span/>').css({'display': 'inline-block', width: '100px', 'text-align': 'left'}).text('Waiting' + dots(callCount, 4))
                        )

                        if (dialogOpen) {
                            checkForFutureConfigExportUrl();
                        }
                    }
                    
                } 
            },
            function() { /* error */ },                 
            function() { /* complete */ }               
        )

    }
    
    function dots(num, mnum) {
    
        var s = '';
        while(s.length < (num % mnum)) {
            s += '.';
        }

        while(s.length < mnum) {
            s += ' ';
        }
        
        return s;
    }
    
    function closeDialog() {
        dialogOpen = false;
        jQuery('ttg_simple_exporter_div').remove();
    }
    
    function showDialog() {
          
        jQuery('<div/>',{ id : 'ttg_simple_exporter_div'})
            .addClass('ttg_simple_exporter')
            .append(
                createAdvice() 
            )
            .append(
                createControlDiv() 
            )
            .dialog({
                title   : 'Export ' + label,
                width   : '500px',
                close   : closeDialog
            });
        
    }
            
    showDialog();
    deletefutureConfigExport();            
};

ttg.JSONFileImportDialogSpinner = function(spec) {
    var that = {};
    that.spec = spec;

    var spinnerURL = spec.spinnerURL;
    add = function() {
        var spinner = jQuery("<div id='tas_ajax_spinner_div'>").css('position', 'absolute').css('z-index', '1000002');
        spinner.append(jQuery('<img>').attr('id', 'tas_ajax_spinner').addClass('dm-spinner').attr('src', spinnerURL).css("visibility", "hidden"));
        // console.log('JSONFileImportDialogSpinner().add(): jQuery(window).height() = ' + jQuery(window).height()  + ',  jQuery(window).width() = ' +  jQuery(window).width());
        // console.log('JSONFileImportDialogSpinner().add(): spinner.height() = ' + spinner.height() + ',  spinner.width() = ' +  spinner.width());
        // console.log('JSONFileImportDialogSpinner().add(): jQuery(window).scrollTop() = ' + jQuery(window).scrollTop() + ',  jQuery(window).scrollLeft() = ' +  jQuery(window).scrollLeft());
        spinner.css("top", ( jQuery(window).height() - spinner.height() ) / 2+jQuery(window).scrollTop() + "px");
        spinner.css("left", ( jQuery(window).width() - spinner.width() ) / 2+jQuery(window).scrollLeft() + "px");
        jQuery('body').append(spinner);
        
        jQuery('#tas_ajax_spinner_div').hide();
    }

    show = function() {
        jQuery('#tas_ajax_spinner').css("visibility", "visible");
        jQuery('#tas_ajax_spinner_div').show();
    }

    hide = function() {
       jQuery('#tas_ajax_spinner').css("visibility", "hidden");
       jQuery('#tas_ajax_spinner_div').hide();
    }

    that.add = add;
    that.show = show;
    that.hide = hide;
    return that;
};

ttg.JSONFileImportDialog = function(spec) {
    var that = {};
    that.spec = spec;

    var spinnerURL = spec.spinnerURL;
    var type = spec.type;
    var label = spec.label;
    var spinner = ttg.JSONFileImportDialogSpinner(spec);

    function createAdvice() {
    	return jQuery('<ol/>').css('margin','1.1em')
				.append(jQuery('<li/>').text('Dealmaker is preparing to import your ' + label + '.').css('list-style-type', 'decimal'))
                .append(jQuery('<li/>').text('Select a file and click import.').css('list-style-type', 'decimal'));
    };

    function createControlDiv() {
        
        var importForm = jQuery('form[id$="importFileForm"]');
        var importField = jQuery('input[id$="importFileField"]');
       	var importButton = jQuery('input[id$="importFileButton"]');

        var ret = jQuery('<div/>')
            .css({ width : '100%', 'text-align' : 'center'})
            .addClass('ttg_future_exporter_buttondiv')
            .append(importForm);
        importForm.show(); 
		importField.show();
		importButton.show();
		return ret;
            
    }

    function closeDialog() {
        //clearImportActive();
        spinner.hide();
        jQuery("input[id*='importActive']").prop("checked", false);
        jQuery('form[id$="importFileForm"]').hide().appendTo(jQuery('body'));
        jQuery('#ttg_simple_importer_div').remove();
    }
    
    function showDialog() {
        spinner.add();
        jQuery('<div/>',{ id : 'ttg_simple_importer_div'})
            .addClass('ttg_simple_exporter')
            .append(
                createAdvice() 
            )
            .append(
                createControlDiv() 
            )
            .dialog({
                title       :   'Import ' + label,
				width 	    :   '550px',
                beforeClose :   function() {closeDialog();}
            }); 
    }

    function hideSpinner() {
        spinner.hide();
    }
    function showSpinner() {
        spinner.show();
    }
          
    that.showDialog = showDialog;
    that.hideSpinner = hideSpinner;
    that.showSpinner = showSpinner;
    return that;
};
