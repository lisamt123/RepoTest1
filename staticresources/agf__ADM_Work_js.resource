function AssignmentComponent() {
    this.initialize = function(options) {
        
        //get the controller
        this.controller = options.controller;
        if(!this.controller) {
            throw new Error('Controller is required');
        }
        
        //get the form
        this.form = options.form;
        if(!this.form) {
            throw new Error('Form is required');
        }
        
    };
    
    this.update = function() {
            var severityLevel = this.form.getSeverityLevel(), 
            productTag = this.form.getProductTag(),
            recordType = this.form.getRecordType(),
            workType = this.form.getWorkType(),
            recipients = this.form.getEncodedRecipients();
            console.log('Prod tag : '+productTag);
            console.log(productTag);
            console.log('recordType : '+recordType);
            console.log(recordType);
            console.log('current workType : '+workType);
        if(productTag && recordType && workType) {
            var view = this;
            var success = function(result) {
                var assignments = result.assignments;
                if(typeof assignments === 'undefined') {
                    return;
                }
                var assignee = view.form.getAssignee();
                if(!assignee && 'Assignee__r' in assignments) {
                    view.form.setAssignee(assignments.Assignee__r);
                }
                
                var productOwner = view.form.getProductOwner();
                if(!productOwner && 'Product_Owner__r' in assignments) {
                    view.form.setProductOwner(assignments.Product_Owner__r);
                }
                
                var qaEngineer = view.form.getQaEngineer();
                if(!qaEngineer && 'QA_Engineer__r' in assignments) {
                    view.form.setQaEngineer(assignments.QA_Engineer__r);
                }


                var seniorManagementPOC = view.form.getSeniorManagementPOC();
                if(!seniorManagementPOC && 'Senior_Management_POC__r' in assignments) {
                    view.form.setSeniorManagementPOC(assignments.Senior_Management_POC__r);
                }
        
                var techWriter = view.form.getTechWriter();
                if(!techWriter && 'Tech_Writer__r' in assignments) {
                    view.form.setTechWriter(assignments.Tech_Writer__r);
                }

                

                var ueEngineer = view.form.getUeEngineer();
                if(!ueEngineer && 'UE_Engineer__r' in assignments) {
                    view.form.setUeEngineer(assignments.UE_Engineer__r);
                }

                var perfEngineer = view.form.getPerfEngineer();
                if(!perfEngineer && 'System_Test_Engineer__r' in assignments) {
                    view.form.setPerfEngineer(assignments.System_Test_Engineer__r);
                }           
            };
            
            var fail = function(result){
                console.warn('Failed to retrieve the work assignments: ' + result[0].message);
            };
            
            this.controller.getWorkAssignments({
                severityLevel: severityLevel, 
                productTag: productTag, 
                recordType: recordType, 
                workType: workType, 
                recipients: recipients,
                success: success,
                fail: fail
            });
        } else {
            console.log('unable to update assignments because not all required fields are entered');
        }
    };
    
    this.initialize.apply(this, arguments);
}
/*
  A method to check whether the current page is running in a GlobalAction context or not. 
  If the var is not defined false will be returned which indicates the page is not a Global Action page.
*/
function getGlobalAction(){
    if('undefined' === typeof isGlobalAction){
           isGlobalAction = false;
      }
    return isGlobalAction;
}
function PriorityComponent() {

    this.initialize = function(options) {
        var self = this;
        //get the controller
        this.controller = options.controller;
        if(!this.controller) {
            throw new Error('Controller is required');
        }
        
        //get the form
        this.form = options.form;
        if(!this.form) {
            throw new Error('Form is required');
        }
        
        //initialize the impact field, then we need to calculate the priority
        this.form.on('change:impact', function() {
            self.calculatePriority();
        });
        
        //when the frequency field changes, then we need to calculate the priority
        this.form.on('change:frequency', function() {
            self.calculatePriority();
        });
        
        //when the priority is changed, then we need to update the UI
        this.form.on('change:priority', function() {
            self.renderPriority();
        });

        //when the calculated priority is changed, we need to update the UI
        this.form.on('change:priorityCalculated', function() {
            self.renderPriority();
        });
        
        this.renderPriority();
        //Only show override dialog if this is not MDP (Global Action)
        if(false === getGlobalAction()){
            this.initializePriorityOverrideDialog();
        }
    };

    this.initializePriorityOverrideDialog = function() {
        var self = this;
        
        //setup the override priority dialog
        var $dialog = $('#dialog-priorityOverride').dialog({
            modal: true,
            resizable: false,
            width: 560,
            autoOpen: false,
            buttons: {
                'OK': function() {
                    self.form.setPriority($dialog.find('#priorityOverrideInput').val());
                    self.form.setPriorityOverrideReason($dialog.find('#priorityOverrideReason').val());
                    self.renderPriority();
                    $dialog.dialog('close');
                },
                'Cancel': function() {
                    $dialog.dialog('close');
                }
            }
        });

        //setup the override priority link
        $('.priority').on('click', '#priorityOverrideLink', function(event) {
            event.stopPropagation();
            event.preventDefault();
            
            $dialog.dialog('open');
            $dialog.find('.priorityCalculated').text(self.form.getCalculatedPriority());
            $dialog.find('#priorityOverrideInput').val(self.form.getPriority()).change();
            $dialog.find('#priorityOverrideReason').val(self.form.getPriorityOverrideReason());
        });
    };

    this.canCalculatePriority = function() {
        var impactId = this.form.getImpactId();
        var frequencyId = this.form.getFrequencyId();
        return !!impactId && !!frequencyId;
    };
    
    this.calculatePriority = function() {
        
        var self = this;
        if(this.canCalculatePriority()) {
            var showPriorityWorkingIndicator = function() {
                $('#calculatePriorityProgress').show();
                $('.priority').hide();
            };
            var hidePriorityWorkingIndicator = function() {
                $('#calculatePriorityProgress').hide();
                $('.priority').show();
            };
            showPriorityWorkingIndicator();
            
            var impactId = this.form.getImpactId();
            var frequencyId = this.form.getFrequencyId();
            var success = function(result) {
                hidePriorityWorkingIndicator();
                self.form.setPriority(result);
                self.form.setCalculatedPriority(result);
            };
            var fail = function(event) {
                hidePriorityWorkingIndicator();
                alert('failed to update priority');
            };
            
            this.controller.calculatePriority({
                impactId: impactId,
                frequencyId: frequencyId,
                success: success,
                fail: fail
            });
        } else {
            self.form.setCalculatedPriority(null);
        }
    };

    this.renderPriority = function() {
        isGlobalAction = getGlobalAction();
        
        var $priority = $('.priority').empty(),
            priority = this.form.getPriority(),
            priorityCurrent = this.form.getPriorityCurrent(),
            canCalculate = this.canCalculatePriority(),
            calculatedPriority = this.form.getCalculatedPriority(),
            isNew = this.form.isNew();
        
        if((priorityCurrent && isNew) || !canCalculate) {
            $('<span style="color: gray">To Be Calculated</span>').appendTo($priority);
        }
        
        //if a value was loaded from the database but it currently cannot be calculated
        if(priorityCurrent && !canCalculate) {
            $priority.append($('<span style="color: gray">').text(' - Previously ' + priority));
        }
        
        //if the priority is the same as the calculated, then it has not been overwritten
        //if it is MDP display the priority here
        if(priority && ((priority == calculatedPriority) || isGlobalAction)) {
            $priority.append(document.createTextNode(priority));
        }
        
        //if the user has already overwritten the priority
        //No need to provide override priority link if it is MDP
        if(priority && priority != calculatedPriority && canCalculate && !isGlobalAction ) {
            $('<span style="padding:0 3px; margin:0 3px 0 0; color: white; background-color: orange; font-weight: bold;">').text(priority).appendTo($priority);
            $('<i>').text('Overridden (Default ' + calculatedPriority + ')').appendTo($priority);
        }
        
        //allow the user to overwrite the priority if it can be calculated (and a value is specified)
        if(priority && canCalculate && !isGlobalAction) {
            $('<a id="priorityOverrideLink" href="#" style="padding-left: 1em;">Override</a>').appendTo($priority);
        }
    };
    
    this.initialize.apply(this, arguments);
}


function extend(protoProperties) {
    var parent = this;
    var child = function() {
        return parent.apply(this, arguments);
    };
    
    function Proxy(){};
    Proxy.prototype = parent.prototype;
    child.prototype = new Proxy();
    
    $.extend(child.prototype, protoProperties);
    
    return child;
}

function WorkEditView() {
    this.initialize.apply(this, arguments);
}


$.extend(WorkEditView.prototype, {
    initialize: function(options) {
        this.controller = options.controller;
        this.inputIds = options.inputIds;
        this.recordTypeId = options.recordTypeId;
        this._isNew = (typeof options.isNew !== 'undefined') ? options.isNew : true;
        this.app = options.app;
        var view = this;
        
        //initialize the product tag component
        this.productTagComponent = options.productTagComponent;
        if(this.productTagComponent) {
        
            //whenever the product tag is removed from the form, we want to clear the 
            //fields used during auto assignment
            $(this.productTagComponent).bind('remove', function() {
                //clear the standard fields
                view.setAssignee(null);
                view.setQaEngineer(null);
                view.setProductOwner(null);
        view.setTechWriter(null);
        view.setUeEngineer(null);
        view.setPerfEngineer(null);
        view.setSeniorManagementPOC(null);

       
            });

            $('.severityLevelInput').bind('change', function() {
                //clear the standard fields
                var value = $('.severityLevelInput').val();
                if((value == "")||(value == null) ){
                    view.setAssignee(null);
                    view.setQaEngineer(null);
                    view.setProductOwner(null);
                    view.setTechWriter(null);
                    view.setSeniorManagementPOC(null);
                }

       
            });
            
        }
        
        //initialize the assignment component
        this.assignmentComponent = new AssignmentComponent({
            controller: this.controller,
            form: this
        });
        
        //if the product tag is changed, then we need update the assignments
        if(this.productTagComponent) {
            $(this.productTagComponent).bind('change:tag', function() {
                view.assignmentComponent.update();
            });
        }
        //if the product tag is changed, then we need update the assignments
            $('.severityLevelInput').bind('change', function() {
            view.assignmentComponent.update();
            });
    },
    
    getWorkType: function() {
        return $(document.getElementById(this.inputIds.typeInput)).val();
    },
    
    setWorkType: function(value) {
        $(document.getElementById(this.inputIds.typeInput)).val(value);
    },
    
    getRecordTypeId: function() {
        return this.recordTypeId;
    },
    
    getRecordType: function() {
        var recordTypeId = this.getRecordTypeId();
        if(!recordTypeId) {
            return;
        } 
        return {
            Id: recordTypeId
        };
    },
    
    getAssignee: function() {
        var input = this._getRichUserAutocompleteForInput($('.assigneeInput'));
        return (input) ? input.getSelected() : null;
    },
    
    setAssignee: function(value) {
        var input = this._getRichUserAutocompleteForInput($('.assigneeInput'));
        if(input) { 
            input.set(value);
        }
    },

    
    getProductOwner: function() {
        var input = this._getRichUserAutocompleteForInput($('.productOwnerInput'));
        return (input) ? input.getSelected() : null;
    },
    
    setProductOwner: function(value) {
        var input = this._getRichUserAutocompleteForInput($('.productOwnerInput'));
        if(input) { 
            input.set(value);
        }
    },



    getSeniorManagementPOC: function() {
        var input = this._getRichUserAutocompleteForInput($('.seniorManagementPOCInput'));
        return (input) ? input.getSelected() : null;
    },
    
    setSeniorManagementPOC: function(value) {
        var input = this._getRichUserAutocompleteForInput($('.seniorManagementPOCInput'));
        if(input) { 
            input.set(value);
        }
    },
    
    getQaEngineer: function() {
        var input = this._getRichUserAutocompleteForInput($('.qaEngineerInput'));
        return (input) ? input.getSelected() : null;
    },
    
    setQaEngineer: function(value) {
        var input = this._getRichUserAutocompleteForInput($('.qaEngineerInput'));
        if(input) { 
            input.set(value);
        }
    },

    getTechWriter: function() {
        var input = this._getRichUserAutocompleteForInput($('.techWriterInput'));
        return (input) ? input.getSelected() : null;
    },
    
    setTechWriter: function(value) {
        var input = this._getRichUserAutocompleteForInput($('.techWriterInput'));
        if(input) { 
            input.set(value);
        }
    },

    getUeEngineer: function() {
        var input = this._getRichUserAutocompleteForInput($('.ueEngineerInput'));
        return (input) ? input.getSelected() : null;
    },
    
    setUeEngineer: function(value) {
        var input = this._getRichUserAutocompleteForInput($('.ueEngineerInput'));
        if(input) { 
            input.set(value);
        }
    },

    getPerfEngineer: function() {
        var input = this._getRichUserAutocompleteForInput($('.perfEngineerInput'));
        return (input) ? input.getSelected() : null;
    },
    
    setPerfEngineer: function(value) {
        var input = this._getRichUserAutocompleteForInput($('.performanceEngineerInput'));
        if(input) { 
            input.set(value);
        }
    },      
    
    getEncodedRecipients: function(value) {
        return;
    },
    
    getSeverityLevel: function() {
        var severity = $('.severityLevelInput').val();
        return severity;
    },

    isNew: function() {
        return this._isNew;
    },
    
    /**
     * Gets the currently selected product tag
     * @returns {Object} returns the currently selected product tag or null
     */
    getProductTag: function() {
        //the default implementation will try and retrieve the product tag ID
        //from the component and wrap into a lightweight sObject 
        //TODO: return full tag sObject instance
        if(!this.productTagComponent) {
            console.warn('Product Tag component could not found. Make sure the page contains ADM_ProductTagInput and that it is populating window.productTag.');
        } else {
            var id = this.productTagComponent.getValue();
            if(typeof id === 'undefined' || id === null || id.length === 0) {
                return null;
            } else {
                return {
                    Id: this.productTagComponent.getValue()
                };
            }
        }
    },
    
    trigger: function() {
        return $.prototype.trigger.apply($(this), arguments);
    },
    
    on: function() {
        return $.prototype.on.apply($(this), arguments);
    },
    
    _getRichUserAutocompleteForInput: function($input) {
        return $input.closest('.gusRichAutoComplete').data('gus.RichAutoComplete');
    }
});
WorkEditView.extend = extend;

var UserStoryEditView = WorkEditView.extend({
    getWorkType: function() {
        return 'User Story';
    }
});

var InvestigationEditView = WorkEditView.extend({
    getWorkType: function() {
        return 'Investigation';
    }
});

var BugEditView = WorkEditView.extend({
    initialize: function(options) {
        WorkEditView.prototype.initialize.apply(this, arguments);
        
        //get the form fields
        this.$impactInput = $('.impactInput');
        this.$impactInput.on('change', function() {
            view.trigger('change:impact');
        });
        
        this.$frequencyInput = $('.frequencyInput');
        this.$frequencyInput.on('change', function() {
            view.trigger('change:frequency');
        });
        
        this.$priorityInput = $(document.getElementById(options.inputIds.priorityInput));
        this.$priorityInput.on('change', function() {
            view.trigger('change:priority');
        });
        
        this.$priorityCalculatedInput = $(document.getElementById(options.inputIds.priorityCalculatedInput));
        this.$priorityCalculatedInput.on('change', function() {
            view.trigger('change:priorityCalculated');
        });
        
        this.$priorityCurrentInput = $(document.getElementById(options.inputIds.priorityCurrentInput));
        this.$priorityOverrideReasonInput = $(document.getElementById(options.inputIds.priorityOverrideReasonInput));
        
        //initialize the priority component
        this.priorityComponent = new PriorityComponent({
            controller: options.controller,
            form: this
        });
        
        //whenever the impact changes, we need to update the frequency field
        this.updateFrequency();
        $(this).on('change:impact', function() {
            view.updateFrequency();
        });
        
        getGlobalAction();
    },
    
    getImpactId: function() {
        return this.$impactInput.val();
    },
    
    getImpact: function() {
        var impactId = this.getImpactId();
        if(!impactId) {
            return null;
        }
        return {
            Id: impactId
        };
    },

    getFrequencyId: function() {
        return this.$frequencyInput.val();
    },
    
    disableFrequency: function() {
        this.$frequencyInput.attr('disabled', 'disabled');
    },
    
    enableFrequency: function() {
        this.$frequencyInput.removeAttr('disabled');
    },

    getPriorityCurrent: function() {
        return this.$priorityCurrentInput.val();
    },
    
    getPriority: function() {
        return this.$priorityInput.val();
    },
    
    setPriority: function(value) {
        this.$priorityInput.val(value).change();
    },

    setPriorityOverrideReason: function(value) {
        this.$priorityOverrideReasonInput.val(value).change();
    },

    getPriorityOverrideReason: function() {
        return this.$priorityOverrideReasonInput.val();
    },

    getCalculatedPriority: function() {
        return this.$priorityCalculatedInput.val();
    },

    getWorkType: function() {
        console.log('getWorkType BugEditView this.$typeInput:' + this.$typeInput);
        if(this.$typeInput == null || this.$typeInput == '') {
            return 'Bug';
        } else {
            return this.$typeInput;
        }
    },
    
    setCalculatedPriority: function(value) {
        this.$priorityCalculatedInput.val(value).change();
    },
    
    updateFrequency: function() {
        var impactValue = this.getImpact();
        if(impactValue) {
            this.enableFrequency();
        } else {
            this.disableFrequency();
        }
    }
    
});


function handleWithCallbacks(options) {
    return function(result, event) {
        if(event.status) {
            if(options.success) {
                options.success(result);
            }
        } else {
            if(options.fail) {
                options.fail(event);
            }
        }
    };
}

function calculatePriority(options) {
    if(!options) {
        options = {};
    }
    
    if(!options.frequencyId) {
        throw new Error('Frequency ID is required to calculate priority');
    }
    
    if(!options.impactId) {
        throw new Error('Impact ID is required to calculate priority');
    }
    
    agf.ADM_WorkRemoteActionsExtension.calculatePriority(options.frequencyId, options.impactId, handleWithCallbacks(options), {escape: false});
};

function getWorkAssignments(options) {
    var severityLevel = options.severityLevel || '',
        productTag = options.productTag,
        recordType = options.recordType,
        workType = options.workType,
        recipients = options.recipients || '',
        success = options.success,
        fail = options.fail;
    
    agf.ADM_WorkRemoteActionsExtension.getAssignments(severityLevel, productTag, recordType, workType, recipients, function(result, event){
        
        if(event.type === 'exception') {
            fail([{message:event.message}]);
            
        } else if(result != null) {
        
            if('errorMessages' in result && result.errorMessages != null && result.errorMessages.length > 0) {
                fail([{messages:result.errorMessages}]);
                return;
            }
            
            //the current implementation returns a ADM_AutoAssignWorkAction.Assignment variable, which
            //has properties that don't match the sObject properties. We try to correct for that here.
            var mapping = {
                'Assignee': 'Assignee__r',
                'Tech_Writer': 'Tech_Writer__r',
                'Product_Owner': 'Product_Owner__r',
                'QA_Engineer': 'QA_Engineer__r',
                'UE_Engineer': 'UE_Engineer__r',
                'System_Test_Engineer': 'System_Test_Engineer__r',
                'Senior_Management_POC': 'Senior_Management_POC__r', 
                'Scrum_Team': 'Scrum_Team__c',
                'Email_Subscription_ID': 'Email_Subscription_ID__c'
            };
            
            Object.keys(mapping).forEach(function(value) {
                if(value in result.assignments) {
                    result.assignments[mapping[value]] = result.assignments[value];
                    delete result.assignments[value];
                }
            })
            
            success(result);
        }
        
    }, {escape:false});
};

function SObjectCollection(sObjects) {
    var byId = {};
    
    this.models = [];
    this.length = 0;
    
    /**
     * Calls the callback with each of the models
     */
    this.each = function(callback) {
        this.models.forEach(callback);
    };
    
    /**
     * Gets the index of the specified model from the collection
     */
    this.indexOf = function(value) {
        return this.models.indexOf(value);
    };
    
    /**
     * Removes the specified model (or an array of models) from the collection
     * @param value A model or an array of models
     */
    this.remove = function(value) {
        if(!Array.isArray(value)) value = value ? [value] : [];
        var i, sObject, index;
        for(i = 0; i < value.length; i++) {
            sObject = this.get(value[i]);
            if(!sObject) {
                return this;
            }
            
            delete byId[sObject.Id];
            
            index = this.indexOf(sObject);
            this.models.splice(index, 1);
            
            this.length--;
        }
        
        this.trigger('remove');
        return this;
    };
    
    /**
     * Adds the specified model (or an array of models) to the collection
     * @param value A model or an array of models
     * @param options.at Specifies the index within the collection where all of the models are put
     */
    this.add = function(value, options) {
        options = options || {};
        if(!Array.isArray(value)) value = value ? [value] : [];
        var i;
        var at = options.at;
        var toAdd = [];
        
        for(i = 0; i < value.length; i++) {
            if(value[i].Id) {
                byId[value[i].Id] = value[i]; 
            }
            toAdd.push(value[i]);
        }
        
        //add the items at the specified index or just push them on them on the exisiting
        if (toAdd.length) {
            this.length += toAdd.length;
            if (at != null) {
                Array.prototype.splice.apply(this.models, [at, 0].concat(toAdd));
            } else {
                Array.prototype.push.apply(this.models, toAdd);
            }
            
            this.sort();
        }
        
        return this;
    };

    /**
     * Gets the sObject with the specified ID
     */
    this.get = function(value) {
        return byId[value.Id || value];
    };
    
    /** 
     * Gets the sObject at the specified index
     */
    this.at = function(index) {
        return this.models[index];
    };
    
    var stringCompare = function(string1, string2) {
        if(string1 < string2) {
            return -1;
        } else if(string1 > string2) {
            return 1;
        }
        return 0;
    };
    
    /**
     * Sorts the collection by the Name property
     */
    this.sort = function() {
        this.models.sort(function(model1, model2) {
            var nameCompare = stringCompare(model1.Name, model2.Name);
            if(nameCompare !== 0) {
                return nameCompare;
            }
            
            var idCompare = stringCompare(model1.Id, model2.Id);
            return idCompare;
        });
        this.trigger('sort', this);
        return this;
    };
    
    //jQuery has built in support for eventing on plain objects however it doesnt
    //like it when the plain object has a 'length' property. I think jquery thinks
    //it's an array like object instead of just a normal object. To get around this,
    //we use an inner object for the eventing.
    var eventSupport = {};
    
    this.on = function() {
        $.prototype.on.apply($(eventSupport), arguments);
    };
    
    this.trigger = function() {
        $.prototype.trigger.apply($(eventSupport), arguments);
    };
    
    //add each of the models
    Array.prototype.forEach.call(sObjects, $.proxy(this.add, this));
};

function ThemeContainerView(options) {
    var clearOnClose = false,
        $el = options.$el,
        $themeInput = $el.find('.themeInput'),
        $themeList = $el.find('.themeList'),
        $errorContainer = $el.find('.errorMsg'),
        workId = this.workId = options.workId;
    
    var themes = this.themes = options.themes;
    rebuildThemeList();
    
    themes.on('sort', $.proxy(rebuildThemeList, this));
    themes.on('remove', $.proxy(rebuildThemeList, this));
    
    $themeInput.autocomplete({
        source: function(request, response) {
            var term = request.term;
            
            agf.ADM_ThemeInputController.queryThemes(term, handleResponse(function(result, event) {
                var exactMatch = false,
                    items = [];
                
                //convert the response for jquery
                result.forEach(function(element) {
                    //check to see if the element is an exact match
                    if(element.Name.toLowerCase() === term.toLowerCase()) {
                        exactMatch = true;
                    }
                    
                    //make sure the theme is active
                    if(!element.agf__Active__c) {
                        return;
                    }
                    
                    items.push({
                        value: element.Name,
                        data: element
                    });
                });
                
                //if there is no exact match, then we need to add an entry to create a new theme
                if(!exactMatch) {
                    items.push({
                        label: 'Create theme: ' + term,
                        value: term,
                        create: true
                    });
                }
                
                response(items);
            }, function(result, event) {
                response([]);
                console.warn('Unable to query for themes');
            }), {escape: false});
        }, 
        select: function(event, data) {
            if(data.item.create) {
                selectThemeWithName(data.item.value);
            } else {
                selectThemeWithName(data.item.data.Name);
            }
            clearOnClose = true;
        },
        close: function() {
            if(clearOnClose) {
                clearOnClose = false;
                $themeInput.val('');
            }
        }
    }).keypress(function(event) {
        if((event.keyCode || event.which) === 13) {
            event.preventDefault();
            addThemeFromInput();
            return false;
        }
    }).focus(function() {
        clearOnClose = false;
    }).data('autocomplete')._renderItem = function(ul, item) {
        var $item = $('<li>').data('item.autocomplete', item)
            .append($('<a>').text(item.label))
            .appendTo(ul );
            
        if(item.create) {
            $item.addClass('themeInput-createNewThemeItem')
        }
        
        return $item;
    };
    
    $themeList.delegate('.removeTheme', 'click', function(event){
        event.preventDefault();
        
        var $themeEl = $(this).closest('li').hide();
        var themeId = $themeEl.data('theme-id');
        
        //get the theme with the specified ID and remove it from the theme collection
        var selectedTheme = themes.get(themeId);
        var selectedThemeIndex = -1;
        if(selectedTheme) {
            selectedThemeIndex = themes.indexOf(selectedTheme);
            themes.remove(selectedTheme);
        }
        
        agf.ADM_ThemeInputController.removeThemeFromWork(workId, themeId, handleResponse(function(result, event) {
            $themeEl.remove();
        }, function(result, event) {
            $themeEl.show();
            
            //add the theme back in the collection
            if(selectedTheme) {
                themes.add(selectedTheme, {at: selectedThemeIndex});
            }
            
            showErrors('Failed to contact server');
            console.log(event);
        }), {escape: false});
    });
    
    $el.delegate('.addThemeButton', 'click', function(event) {
        event.preventDefault();
        addThemeFromInput();
    });
    
    function addThemeFromInput() {
        selectThemeWithName($themeInput.val());
        
        //make sure the autocomplete is closed
        clearOnClose = true;
        $themeInput.val('').autocomplete('close');
    }
    
    function clearErrors() {
        $errorContainer.empty().hide();
    }
    
    function showErrors(messages) {
        $errorContainer
            .empty()
            .show()
            .append($('<strong>').text('Error:'));
        if(typeof(messages) === 'string') {
            messages = [messages];
        }
        
        Array.prototype.forEach.call(messages, function(message) {
            $errorContainer.append($('<span>').text(message))
                .append(document.createTextNode(' '));
        });
    };
    
    function handleResponse(success, fail) {
        return function(result, event) {
            if(event.status && success) {
                success(result, event);
            }
            if(!event.status && fail) {
                fail(result, event);
            }
        };
    };
    
    function createThemeItemView(theme) {
        var $theme = $('<li>').addClass('theme').text(theme.Name).wrapInner( "<a href='/" + theme.Id + "' class='theme'></a>").attr('data-theme-id', theme.Id).appendTo($themeList);
        $theme.append(document.createTextNode(' '));
        $theme.append('<a href="javascript: void 0;" class="removeTheme" title="Remove">X</a>');
    };
    
    function addTheme(theme) {
        //check to make sure this theme isn't already on the page
        var found = themes.get(theme.Id);
        if(found) {
            return;
        }
        
        //add the theme to the javascript collection
        themes.add(theme);
    };
    
    function selectThemeWithName(themeName) {
        clearErrors();
        agf.ADM_ThemeInputController.addThemeToWork(workId, themeName, handleResponse(function(result, event) {
            if(result.success) {
                addTheme(result.theme);
                
            } else {
                //show the failure to user
                showErrors(result.messages);
            }
        }, function(result, event) {
            showErrors('Failed to contact server');
            console.log(event);
        }), {escape:false});
    };
    
    function rebuildThemeList() {
        //render the theme items
        $themeList.empty();
        themes.each(createThemeItemView);
    };
};

if (this.$) {
	$(function() {
		// change the title of the rich-text editor for accessibility
	    setTimeout(function() {
			$('.cke_wysiwyg_frame').contents().find('title').attr('data-cke-title','Details and Steps to Reproduce').text('Details and Steps to Reproduce');
	    }, 5000);
	});
};