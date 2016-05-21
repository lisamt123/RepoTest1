//requires ADM_common_js
//requires productTag_js

function setTeam(team) {
    var $field = $('.scrumTeamField');

    if(isString(team)) {
        $field.val(team);
    } else if('Name' in team) {
        $field.val(team.Name);
    }
}

function tagStatusOnStart() {
    if(showProductTagStatus) {
        showProductTagStatus();
    }
}

function tagStatusOnStop() {
    if(hideProductTagStatus) {
        hideProductTagStatus();
    }
}

function tagChanged(event) {
    console.debug('product tag changed'); 
    //assume that when the new value is blank that we don't need to update the 
    //assignments
    if(event.newValue && event.newValue != null && event.newValue.length > 0) {
        form.assignmentController.update();
    }
    
    adjustProductTagLabelPadding();
}

function adjustProductTagLabelPadding() {

    //since the product tag is much larger than the label,
    //we need to add some padding to the top when it 
    //is being displayed.
    var paddingTop = null;
    if(productTag.getValue() != null && productTag.getValue().length > 0) {
        paddingTop = '15px';
    } else {
        paddingTop = '5px'; 
    }
    
    $('.productTagLabel').parent().css('paddingTop', paddingTop);
}

/**
 * @function
 * @description Defines a class. When the class is constructed, the method named
 * $constructor is automatically invoked on the object.
 */
function defineClass(object) {
    return function(){
        this.__class = true;
    
        //take the object given and merge it into this new object
        $.extend(this, object);
        
        //invoke the constructor on this instance
        if('$constructor' in this) {
            this.$constructor.apply(this, arguments);
        }
    };
}

/**
 * @class 
 * @description
 * Component that manages the assignments
 */
var AssignmentController = defineClass(/**@lends AssignmentController.prototype*/{
    $constructor : function(/**Object*/ form) {
        this.form = form;
    },
    
    /**
     * Triggers the controller to update
     */
    update : function(){
        $(this).trigger('updating');
        
        var severityLevel = this.form.getSeverityLevel();
        var productTag = this.form.getProductTag();
        var recordType = this.form.getRecordType();
        var workType = this.form.getTypeLabel();
        var recipients = this.form.getEncodedRecipients();
        
        this.form.clearErrors();
        
        ADM_WorkControllerExtension.getAssignments(severityLevel, productTag, recordType, workType, recipients, $.proxy(function(result, event){
            $(this).trigger('updated');
            
            if(event.type == 'exception') {
                $(this).trigger('error', [{message:event.message}]);
            } else if(result != null) {
                if('errorMessages' in result && result.errorMessages != null && result.errorMessages.length > 0) {
                    $(this).trigger('validationError', [{messages:result.errorMessages}]);
                }
                
                if('assignments' in result) {
                    $(this).trigger('change', [result.assignments]);
                }
                
                if('recipients' in result) {
                    $(this).trigger('recipientChange', [result.recipients]);
                }
            }
        }, this), {escape:false});
    }
});

/**
 * @class 
 * @description
 * Component that manages the notification including recipients
 */
var NotificationController = defineClass(/**@lends NotificationController.prototype*/{
    
    /**
     * @param {String} recipientId The ID of the DOM element that contains the
     * encoded recipient information. This value must not be null.
     */
    $constructor : function(/**String*/ recipientId) {
        if(recipientId == null) {
            throw "Recipient ID is required";
        }
        this._recipientId = recipientId;
        
        //when this is changed, we need to invoke the method on the notifier 
        //component to update the other reps list
        if(window['populateOtherRepsListAfterRemoval']) {
            $(this).bind('recipientsChanged', function(event, data) {
                populateOtherRepsListAfterRemoval('panelOtherRecipients');
            });
        }
    },
    
    /** 
     * @private
     * @description
     * retrieves the DOM node for the recipients input. if the DOM node is not 
     * found, then a warning is logged in the console and a null is returned.
     */
    _getRecipientsDom : function() {
        var recipientsDom = document.getElementById(this._recipientId);
        if(recipientsDom == null) {
            console.warn('Hidden recipients field could not be found.');
        }
        return recipientsDom;
    },
    
    /**
     * Gets the notification recipients in the encoded format.
     */
    getEncodedRecipients : function() {
        var recipientsDom = this._getRecipientsDom();
        if(recipientsDom != null) {
            return $(recipientsDom).val();
        }
        return "";
    },
    
    /**
     * Sets the notification recipients to the encoded value. The format of the 
     * value is not checked!
     */
    setEncodedRecipients : function(value) {
        var previousValue = ""; 
        var recipientsDom = this._getRecipientsDom();
        if(recipientsDom != null) {
            previousValue = $(recipientsDom).val();
            $(recipientsDom).val(value);
        }
        $(this).trigger("recipientsChanged", [{newValue : value, previousValue : previousValue}]);
        return previousValue;
    }
});

/**
 * @class
 * @description
 * Represents the work edit form
 */
var WorkEditForm = defineClass(/**@lends WorkEditForm.prototype*/{
    $constructor: function(params) {
        this.recordType = null;
        this.assignmentController = new AssignmentController(this);
        
        //always instantiate the notification controller, even if the notification
        //component is not available on the page.
        this.notificationController = new NotificationController('pageEdit:formEdit:pageBlockEdit:pageBlockSectionInformation:theHiddenReps');
        
        //instantiate the default error handler. this may be overwritten by the
        //page
        this.errorHandler = {
            showErrors : function(errors) {
                if(errors == null) {
                    return;
                }
                
                if(isString(errors)) {
                    if(errors.length == 0) {
                        return;
                    }
                    errors = [errors];
                }
                
                if(errors.length == 0) {
                    return;
                }
                
                var message = 'The following errors have occurred:\n\n';
                for(var index = 0; index < errors.length; index++) {
                    message += errors[index] + '\n';
                }
                alert(message);
            },
            clearErrors : function() {}
        };
        
        //overwrite anything in this class with any given parameters
        $.extend(this, params);
        
        //begin initialization
        this._initializeAssignmentController();
        this._bindAssignmentFieldsToProductTag();
    },
    
    getSeverityLevel: function() {
        console.debug('severity is only used in investigations. returning empty string.');
        return '';
    },
    
    /**
     * Gets the value specified in the Type field.
     * @function
     * @returns {String}
     */
    getTypeValue: function() {
        var fieldSelector = '.typeField';
        var $field = $(fieldSelector);
        if($field.size() == 0) {
            console.warn('Type field could not be found. Make sure the document contains the field with selector of \'' + fieldSelector + '\'');
            return null;
        }
        return $field.val();
    },
    
    getTypeLabel: function() {
        var fieldSelector = '.typeField';
        var $field = $(fieldSelector);
        if($field.size() == 0) {
            console.warn('Type field could not be found. Make sure the document contains the field with selector of \'' + fieldSelector + '\'');
            return null;
        } else {
        	return $(fieldSelector).find("option:selected").text();
        }	
        
    },
    
    getEncodedRecipients : function() {
        return this.notificationController.getEncodedRecipients();
    },
    
    getRecordType : function() {
        return this.recordType;
    },
    
    /**
     * Gets the currently selected product tag
     * @returns {Object} returns the currently selected product tag or null
     */
    getProductTag : function() {
        //the default implementation will try and retrieve the product tag ID
        //from the window and wrap into a lightweight sObject 
        //TODO: return full tag sObject instance
        if(!('productTag' in window)) {
            console.warn('Product Tag component could not found. Make sure the page contains ADM_ProductTagInput and that it is populating window.productTag.');
        } else {
            var id = window.productTag.getValue();
            if(id == null || id.length == 0) {
                return null;
            } else {
                return {
                    Id: window.productTag.getValue()
                };
            }
        }
    },
    
    /**
     * @param {String} params.title The title of the message. The default is 'Fatal Exception Occurred'.
     * @param {String} params.message The message of the error in HTML. The default is 'An error has occurred'.
     */
    showFatalErrorMessage : function(params) {
        params = $.extend({
            title: 'Fatal Exception Occurred',
            message: '<p>An error has occurred.</p>'
        }, params);
        
        $('<div></div>')
            .attr({
                title: params.title
            })
            .html(params.message)
            .appendTo(document.body)
            .dialog({modal:true});
    },
    
    /**
     * Shows only the errors specified. 
     
     * When this method is invoked, all error messages that are currently being 
     * displayed are cleared and replaced with the current ones.  If you want to 
     * keep the previous error messages and display new ones, use #addError()
     * instead.
     *
     * @param {String|String[]} errors An array (or a single) error message to display.
     */
    showErrors : function(errors) {
        try {
            this.errorHandler.showErrors(errors);
        } catch(e) {
            console.warn('Unable to show page error messages to the user. Running errors to fatal error message. Reason: ' + e);
            var fullMessage = '';
            
            //convert to an array if a string
            if(isString(errors)) {
                errors = [errors];
            }
            
            for(var index = 0; index < errors.length; index++) {
                fullMessage += '<li>' + escapeHTML(errors[index]) + '</li>';
            }
            this.showFatalErrorMessage({
                message: '<div>Please correct the following errors to continue. <ul>' + fullMessage + '</ul></div>'
            });
        }
    },
    
    clearErrors : function() {
        if(typeof this.errorHandler.clearErrors !== 'undefined') {
            this.errorHandler.clearErrors();
        }
    },
    
    _initializeAssignmentController : function() {
        var form = this;
    
        //link the assignment controller to input fields
        $(this.assignmentController).bind('change', function(event, assignments) {
            
            /**
             * @function
             * @description Sets the field to the Name of the user object within 
             *      the context. If the property is not found or the object at 
             *      the property does not contain the 'Name' property, warnings 
             *      are logged and no errors are thrown.
             *
             * @example
             * var assignments = {'Assignee':{Name:'Jared'}};
             * //assume field <input id="user" name="user" />
             * setNameInField($('#user'), assignments.Assignee);
             * //assert document.getElementById('user').value == assignments.Assignee.Name 
             *
             * @param {jQuery Context} $field The field
             * @param {Object} sObject The sObject
             */
            var setNameInField = function($field, sObject) {
                if(!$field) {
                    return;
                }
            
                var previousValue = $field.val();
                //if the field has a previous value, then don't overwrite it
                if(previousValue == null || previousValue.length == 0) {
                    if(sObject) {
                        
                        //set the field value
                        if('Name' in sObject) {
                            var newValue = sObject['Name'];
                            $field.val(newValue);
                        }
                        
                        //try to set the lookup fields
                        try {
                            var fieldId = $field.attr('id');
                            if(lookupPick && $(document.getElementById(fieldId + '_lkid')).length > 0) {
                                lookupPick(
                                    $field.closest('form').attr('id'),
                                    fieldId + '_lkid',
                                    fieldId,
                                    '',
                                    sObject.Id, //ID
                                    sObject.Name, //value
                                    '',
                                    '');
                            }
                        } catch(e) {
                            console.warn('Error while trying to set lookup fields: ' + e);
                        }
                        
                        //update the standard recipients
                        if('updateStandardRecipients' in window) {
                            window.updateStandardRecipients(sObject.Name, previousValue);
                        }
                    }
                }
            };
            
            setNameInField($('input.assigneeField'), assignments['Assignee']);
            setNameInField($('input.techWriterField'), assignments['Tech_Writer']);
            setNameInField($('input.systemTestEngineerField'), assignments['System_Test_Engineer']);
            setNameInField($('input.ueField'), assignments['UE_Engineer']);
            setNameInField($('input.productOwnerField'), assignments['Product_Owner']);
            setNameInField($('input.qaField'), assignments['QA_Engineer']);
        });
        
        //link the assignment controller to show validation messages
        $(this.assignmentController).bind('validationError', function(event, error) {
            form.showErrors(error.messages);
        });
        
        //link the assignment controller to show a fatal form error
        $(this.assignmentController).bind('error', function(event, error) {
            form.showFatalErrorMessage({
                message: '<p>Fatal error occurred while retrieving assignments.</p><p>' + escapeHTML(error.message) + '</p>'
            });
        });
        
        $(this.assignmentController).bind('updating', function() {
            window.productTag.showStatus();
        });
        
        $(this.assignmentController).bind('updated', function() {
            window.productTag.hideStatus();
        });
        
        //link the assignment controller to the notification controller
        $(this.assignmentController).bind('recipientChange', function(event, recipients){
            //recipients parameter is the encoded recipient string
            form.notificationController.setEncodedRecipients(recipients);
        });
    },
    
    /**
     * @function
     * @description
     * Function for initializing the binding of the product tag to the 
     * auto-assignment fields.  This method is invoked during the initialization 
     * lifecycle event.
     */
    _bindAssignmentFieldsToProductTag : function() {
        
        //whenever the product tag is removed from the form, we want to clear the 
        //fields used during auto assignment
        if('productTag' in window) {
            $(window.productTag).bind('remove', function() {
                //clear the standard fields
                $('input.assigneeField').val('');
                $('input.qaField').val('');
                $('input.productOwnerField').val('');
                
                //clear the investigation specific fields
                $('input.seniorManagement').val('');
                
                //clear the bug/template/user story specific fields
                $('input.ueField').val('');
                $('input.techWriterField').val('');
                $('input.systemTestEngineerField').val('');
            });
        }
    }
});
