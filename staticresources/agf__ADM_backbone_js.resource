/*jshint globalstrict:true */
/*global _:true, Backbone:true, client:true, moment:true, $:true */
"use strict";

Backbone.sync = function(method, model, options) {
    if(!options){
        options = {};
    }
    var successCallback = function(resp, statusText, xhr) { 
        //the server may return 
        if(resp && resp.attributes) {
            delete resp.attributes;
        }
    
        if(options.success) {
            options.success(resp, statusText, xhr);
        }
        model.trigger('sync', model, resp, options);
    };
    var errorCallback = function(xhr) {

        //remoteTk will serialize the response object as a javascript object, however the REST api will send back
        //the response as a text string. we are going to make sure it is the same for each
        if(typeof options.processResponse === 'undefined' || options.processResponse) {
        
            //responseText is only found in REST api version
            if(xhr.responseText) {
                try {
                    xhr.response = JSON.parse(xhr.responseText);
                } catch(e) {
                    console.warn('unable to parse responseText as JSON. returning responseText as string');
                }
                
            } else { 
                var result = xhr;
                xhr = {
                    responseText: JSON.stringify(result),
                    response: result
                };
            }
        }

        if(options.error) {
            options.error(model, xhr, options);
        }
        model.trigger('error', model, xhr, options);
    };
    var sObjectType = _.result(model, 'sObjectType');
    var attributes = null;
    if(method === 'update' || method === 'patch') {
        attributes = model.getChangesToUpdate();
        client.update(sObjectType, model.id, attributes, successCallback, errorCallback);
    } else if(method === 'create') {
        attributes = model.getChangesToUpdate();
        client.create(sObjectType, attributes, successCallback, errorCallback);
    } else if(method === 'read') {
        client.retrieve(sObjectType, model.id, '', successCallback, errorCallback);
    } else {
        errorCallback(null, null, null);
    }
};

var gus = {};
gus.soqlEncode = function(term) {
    return term.replace(/'/g, '\\\'');
};
gus.handleWithDeferred = function(deferred) {
    return function(result, event) {
        if(event.type === 'exception') {
            deferred.reject(result, event);
        } else {
            deferred.resolve(result);
        }
    };
};

gus.deferredFetch = function(ModelClass, attrs, options) {
    options = options ? _.clone(options) : {};
    var model = new ModelClass(attrs, options);
    var deferred = new $.Deferred();
    var success = options.success;
    options.success = function(model, resp, options) {
        deferred.resolve(model);
        if(success) {
            success(model, resp, options);
        }
    };
    var error = options.error;
    options.error = function(model, xhr, options) {
        deferred.reject(model, xhr, options);
        if(error) {
            error(model, xhr, options);
        }
    };
    model.fetch(options);
    return deferred.promise();
};

(function(){
    var cacheModelMap = [];
    
    gus.cachable = function(options) {
        cacheModelMap.push(options);
    };
    
    gus.getCache = function(modelClass) {
        var mapping = null;
        for(var index = 0; index < cacheModelMap.length; index++) {
            if(cacheModelMap[index].model === modelClass) {
                mapping = cacheModelMap[index];
                break;
            }
        }
        
        if(mapping) {
            if(!mapping.cache) {
                var CollectionClass = mapping.collection;
                mapping.cache = new CollectionClass();
            }
            return mapping.cache;
        }
        return void 0;
    };
})();

gus.getOrFetch = function(modelClass, id) {
    var collection = gus.getCache(modelClass);
    if(collection) {
        return collection.getOrFetch(id);
    } else {
        return gus.deferredFetch(modelClass, {Id: id});
    }
};


gus.SObjectModel = Backbone.Model.extend({
    idAttribute: 'Id',
    urlRoot: function() {
        return '/services/data/v26.0/sobjects/' + this.sObjectType;
    },
    fetchRelated: function(attributeName, modelClass) {
        return gus.deferredFetch(modelClass, {Id: this.get(attributeName)});
    },
    getOrFetchRelated: function(attributeName, modelClass) {
        return gus.getOrFetch(modelClass, this.get(attributeName));
    },
    getAsMoment: function(attributeName) {
        var value = this.get(attributeName);
        if(value) {
            return moment(this.get(attributeName), 'YYYY-MM-DD\\THH:mm:ss\\.SSSZ');
        }
        return value;
    },
    getAsDate: function(attributeName) {
        var value = this.get(attributeName);
        if(value) {
            return this.getAsMoment(attributeName).toDate();
        }
        return value;
    },
    
    /**
     * Gets the changes to be sent to the server during a save or update
     */
    getChangesToUpdate: function(options) {
        var attributes = this.toJSON(options);
        var omittedFields = [];
        
        //omit the "attributes" metadata field
        omittedFields.push('attributes');
        
        //omit any readonly fields
        var readOnlyFields = ['Id', 'CreatedById', 'CreatedDate', 'IsDeleted', 'LastModifiedById', 'LastModifiedDate', 'OwnerId', 'SystemModstamp'];
        omittedFields = omittedFields.concat(readOnlyFields);
        
        //append any custom read-only fields
        var restrictedFields = _.result(this, 'sObjectReadonlyFields');
        if(restrictedFields) {
            omittedFields = omittedFields.concat(restrictedFields);
        }
        
        //omit any relationship attributes
        var relationshipFields = _.filter(_.keys(attributes), function(attribute) {
            return attribute.length > 3 && attribute.substring(attribute.length - 3) === '__r';
        });
        omittedFields = omittedFields.concat(relationshipFields);
        
        //remove all of the read-only fields 
        attributes = _.omit(attributes, omittedFields);
        
        return attributes;
    }
});

/**
 * Generic collection for handling SObjects
 */
gus.SObjectCollection = Backbone.Collection.extend({
    getOrFetch: function(id) {
        var deferred;
    
        //if an id is not specified, then return undefined
        if(!id) {
            deferred = $.Deferred();
            deferred.resolve(void 0);
            return deferred.promise();
        }
        
        var related = this.get(id);
        if(related) {
            deferred = $.Deferred();
            deferred.resolve(related);
            return deferred.promise();
        } else {
            if(!gus.SObjectCollection._fetchQueue) {
                gus.SObjectCollection._fetchQueue = {};
            }
            
            if(gus.SObjectCollection._fetchQueue[id]) {
                return gus.SObjectCollection._fetchQueue[id];
            } else {
                var fetching = gus.deferredFetch(this.model, {Id: id})
                    .done(_.bind(function(model){
                        this.add(model);
                        delete gus.SObjectCollection._fetchQueue[id];
                    }, this));
                gus.SObjectCollection._fetchQueue[id] = fetching;
                return fetching;
            }
        }
    }
});

gus.RecordTypeModel = gus.SObjectModel.extend({
    sObjectType: 'RecordType'
});
gus.RecordTypeList = gus.SObjectCollection.extend({
    model: gus.RecordTypeModel
});
gus.cachable({model: gus.RecordTypeModel, collection: gus.RecordTypeList});

gus.UserModel = gus.SObjectModel.extend({
    sObjectType: 'User'
});
gus.UserList = gus.SObjectCollection.extend({
    model: gus.UserModel
});
gus.cachable({model: gus.UserModel, collection: gus.UserList});

gus.WorkModel = gus.SObjectModel.extend({
    sObjectType: 'ADM_Work__c', 
    sObjectReadonlyFields: ['Product_Tag_Name__c', 'Open_Rank__c', 'Age__c', 'Story_Status__c', 'Age_With_Scrum_Team__c', 'Frequency_Name__c', 'Closed__c', 'Total_Age_When_Closed__c', 'Has_Story_Points__c', 'Related_URL_Link__c', 'Created_In_Last_30_Days__c', 'Scheduled_Build_Name__c', 'Resolved__c', 'Created_On_Date__c', 'CreatedDate', 'Scrum_Team_Name__c', 'Closed_Month__c', 'Email_Subscription_Queue__c', 'Record_Type__c', 'Log_Bug_From_Template__c', 'Found_In_Build_Name__c', 'Impact_Name__c', 'Created_In_Last_7_Days__c', 'Age_With_Scrum_Team_When_Closed__c', 'Sprint_Name__c', 'Last_Updated_By__c', 'Type_Value__c', 'LastActivityDate', 'Bugforce_link__c', 'User_Profile_of_the_Creator__c', 'Name', 'Closed_Story_Points__c', 'visual_link_num_of_Test_Failures__c'],
    defaults: {
        'Origin__c': 'ADM_WorkControllerExtension'
    },
    initialize: function() {
        //default values for new records
        if(this.isNew() && !this.has('Status__c')) {
            this.set('Status__c', 'New');
        }
    },
    getComments: function() {
        return gus.getCache(gus.CommentModel).where({Work__c: this.id});
    },
    getRecordType: function() {
        if(this._recordType) {
            var deferred = $.Deferred(); 
            deferred.resolve(this._recordType);
            return deferred.promise();
        } else {
            var promise = this.getOrFetchRelated('RecordTypeId', gus.RecordTypeModel)
                .done(_.bind(function(recordType){
                    this._recordType = recordType;
                }, this));
            return promise;
        }
    },
    getProductTag: function() {
        return this.getOrFetchRelated('agf__Product_Tag__c', gus.ProductTagModel);
    },
    getAssignee: function() {
        return this.getOrFetchRelated('agf__Assignee__c', gus.UserModel);
    },
    getQAEngineer: function() {
        return this.getOrFetchRelated('agf__QA_Engineer__c', gus.UserModel);
    },
    getProductOwner: function() {
        return this.getOrFetchRelated('agf__Product_Owner__c', gus.UserModel);
    },
    getTheme: function() {
        return this.getOrFetchRelated('agf__Theme__c', gus.ThemeModel);
    },
    getScheduledBuild: function() {
        return this.getOrFetchRelated('agf__Scheduled_Build__c', gus.BuildModel);
    },
    getFoundInBuild: function() {
        return this.getOrFetchRelated('agf__Found_in_Build__c', gus.BuildModel);
    },
    getSprint: function() {
        return this.getOrFetchRelated('agf__Sprint__c', gus.SprintModel);
    },
    getEpic: function() {
        return this.getOrFetchRelated('agf__Epic__c', gus.EpicModel);
    }
}, {
    getPriorityValues: function() { 
        var d = $.Deferred();
        d.reject('Unsupport operation.');
        return d.promise();
    },
    getPerforceStatusValues: function() {
        var d = $.Deferred();
        d.reject('Unsupport operation.');
        return d.promise();
    }
});

gus.WorkList = gus.SObjectCollection.extend({
    model: gus.WorkModel
});
gus.cachable({model: gus.WorkModel, collection: gus.WorkList});

gus.SprintModel = gus.SObjectModel.extend({
    sObjectType: 'agf__ADM_Sprint__c'
});
gus.SprintList = gus.SObjectCollection.extend({
    model: gus.SprintModel
});
gus.cachable({model: gus.SprintModel, collection: gus.SprintList});

gus.CommentModel = gus.SObjectModel.extend({
    sObjectType: 'ADM_Comment__c'
});
gus.CommentList = gus.SObjectCollection.extend({
    model: gus.CommentModel
});
gus.cachable({model: gus.CommentModel, collection: gus.CommentList});

gus.ImpactModel = gus.SObjectModel.extend({
    sObjectType: 'ADM_Impact__c'
});
gus.ImpactList = gus.SObjectCollection.extend({
    model: gus.ImpactModel
});
gus.cachable({model: gus.ImpactModel, collection: gus.ImpactList});

gus.FrequencyModel = gus.SObjectModel.extend({
    sObjectType: 'ADM_Frequency__c'
});
gus.FrequencyList = gus.SObjectCollection.extend({
    model: gus.FrequencyModel
});
gus.cachable({model: gus.FrequencyModel, collection: gus.FrequencyList});

gus.ProductTagModel = gus.SObjectModel.extend({
    sObjectType: 'agf__ADM_Product_Tag__c',
    getTeam: function() {
        return this.getOrFetchRelated('agf__Team__c', gus.TeamModel);
    }
});
gus.ProductTagList = gus.SObjectCollection.extend({
    model: gus.ProductTagModel
});
gus.cachable({model: gus.ProductTagModel, collection: gus.ProductTagList});

gus.BuildModel = gus.SObjectModel.extend({
    sObjectType: 'agf__ADM_Build__c'
});
gus.BuildList = gus.SObjectCollection.extend({
    model: gus.BuildModel
});
gus.cachable({model: gus.BuildModel, collection: gus.BuildList});



gus.EpicModel = gus.SObjectModel.extend({
    sObjectType: 'agf__ADM_Epic__c'
});
gus.EpicList = gus.SObjectCollection.extend({
    model: gus.EpicModel
});
gus.cachable({model: gus.EpicModel, collection: gus.EpicList});




gus.ThemeModel = gus.SObjectModel.extend({
    sObjectType: 'agf__ADM_Theme__c'
});
gus.ThemeList = gus.SObjectCollection.extend({
    model: gus.ThemeModel
});
gus.cachable({model: gus.ThemeModel, collection: gus.ThemeList});

gus.TeamModel = gus.SObjectModel.extend({
    sObjectType: 'ADM_Scrum_Team__c'
});
gus.TeamList = gus.SObjectCollection.extend({
    model: gus.TeamModel
});
gus.cachable({model: gus.TeamModel, collection: gus.TeamList});

gus.TaskModel = gus.SObjectModel.extend({
    sObjectType: 'agf__ADM_Task__c',
    getAssignedTo: function() {
        return this.getOrFetchRelated('agf__Assigned_To__c', gus.UserModel);
    }
});
gus.TaskList = gus.SObjectCollection.extend({
    model: gus.TaskModel
});
gus.cachable({model: gus.TaskModel, collection: gus.TaskList});

/*****************************************************************************
* Components
******************************************************************************/

gus.LookupComponent = function() {
    this.cid = _.unique('lookupcomponent_');
    this.initialize.apply(this, arguments);
};
_.extend(gus.LookupComponent.prototype, Backbone.Events, {
    initialize: function(options) {
        if(!options) options = {};
        this.$el = options.$nameInput || $('<input type="text" style="width: 100%">');
        this.minLength = options.minLength || 1;
        
        //modelClass: the constructor of the model class
        this.modelClass = options.modelClass;
        
        //sObject: the name of the sObject type used for queries 
        this.sObject = this.modelClass.prototype.sObjectType;
        
        this.delegateEvents();
        
        this.on('change:selected', this.update, this)
    },
    delegateEvents: function() {
        this.$el.on('keypress.' + this.cid, _.bind(this._onKeyPress, this));
        this.$el.on('autocompleteselect.' + this.cid, _.bind(this._onAutocompleteSelect, this));
        this.$el.on('autocompletechange.' + this.cid, _.bind(this._onAutocompleteChange, this));
    },
    undelegateEvents: function() {
        this.$el.off('.' + this.cid);
    },
    
    /**
     * Clears the input of any prior selections
     */
    clear: function() {
        this.select(null);
    },
    
    /**
     * Sets the model or attribute to be selected
     * @deprecated Use select instead
     */
    set: function(attrs) {
        this.select(attrs);
    },
    
    /**
     * Sets the model or attribute to be selected
     */
    select: function(attrs) {
        this._selected = attrs;
        this.trigger('change:selected', this, attrs);
    },
    
    getSelected: function() {
        return this._selected;
    },
    
    /**
     * Gets the ID of the selected item.
     */
    getId: function() {
        var selected = this.getSelected();
        if(selected) {
            return selected.Id;
        } else {
            return void 0;
        }
    },
    
    /**
     * Renders the DOM. This should only be invoked once
     */
    render: function() {
        //setup the name input with autocomplete
        this.$el.autocomplete({
            source: _.bind(this._onLookup, this),
            minLength: this.minLength,
            delay: 0
        })
        this.update();
        return this;
    },
    
    remove: function() {
        this.undelegateEvents();
        if(this.$el.data('autocomplete')) {
            this.$el.autocomplete('destroy');
        }
        this.$el.remove();
    },
    
    /**
     * Updates the DOM with the newest values
     */
    update: function() {
        if(this._selected) {
            //update the name element when a new item is selected
            this.$el.val(this._selected.Name);
        } else {
            this.$el.val('');
        }
    },
    
    /**
     * Call this method when finished using this input (like when the form is to be submit) to 
     * ensure that all asynchronous work has completed. Attach to the done of the deferred. 
     * @returns $.Deferred
     */
    commit: function() {
        var deferred = new $.Deferred();
        var name = this.$el.val();
        if(this._selected && name == this._selected.Name) {
            deferred.resolve(this, this._selected);
        } else if(name) {
            this._queryWithName(name)
                .done(_.bind(function(results) {
                    
                    //try to find an exact match within the query results
                    var exactMatch = _.find(results.records, function(result) {
                        return result['Name'].toLowerCase() === name.toLowerCase();
                    });
                    if(exactMatch) {
                        this.select(exactMatch);
                        deferred.resolve(this, exactMatch);
                        
                    } else {
                        this.trigger('error.nomatch', name);
                        deferred.reject(this, 'Nothing found with name: ' + name);
                    }
                
                }, this))
                .fail(function(){
                    deferred.reject(this, 'Failed while executing query for autocomplete field. Are you logged in and is your session still active?');
                });
        } else {
            //make sure to clear if the user cleared the input
            this.clear();
            deferred.resolve(this);
        }
        return deferred.promise();
    },
    
    /**
     * Invoked by jQuery UI autocomplete when trying to find items with the entered search term
     */
    _onLookup: function(request, response) {
        var term = request.term;
        if(!term || term.length < this.minLength) {
            return;
        }
        
        var input = this;
        this._query(term)
            .fail(function(){
                input._onError('Failed while executing query for autocomplete field. Are you logged in and is your session still active?');
            })
            .then(function(results) {
                //convert results returned by the SOQL into something jQuery can use
                return _.map(results.records, function(result) {
                    return _.extend({
                        label: result.Name || result.Id,
                        value: result.Name || result.Id
                    }, result);
                });
            })
            
            //invoke the jquery response callback
            .done(response);
    },
    
    /**
     * Override this method to build a SOQL query to use to search for the specified term. The term is 
     * not escaped so it could include illegal characters.
     */
    _buildQuery: function(term) {
        var cleanTerm = gus.soqlEncode(term);
        var cleanSObject = gus.soqlEncode(_.result(this, 'sObject'));
        return "select Id, Name from " + cleanSObject + " where Name like '%" + cleanTerm + "%' order by Name";
    },
    
    _buildQueryWithName: function(name) {
        var cleanName = gus.soqlEncode(name);
        var cleanSObject = gus.soqlEncode(_.result(this, 'sObject'));
        var soqlQuery = "select Id, Name from " + cleanSObject + " where Name = '" + cleanName + "' limit 1";
        return soqlQuery;
    },

    /**
     * Executes the query with the given term. 
     * @returns $.Deferred
     */
    _query: function(term) {
        var soqlQuery = this._buildQuery(term);
        return this._execSoql(soqlQuery);
    },
    
    /**
     * Queries for a record with exactly the specified name
     * @returns $.Deferred
     */
    _queryWithName: function(name) {
        var soqlQuery = this._buildQueryWithName(name);
        return this._execSoql(soqlQuery);
    },
    
    /**
     * Executes the given soql statement
     * @returns $.Deferred
     */
    _execSoql: function(soqlQuery) {
        var load = this._startLoading();
        var deferred = new $.Deferred();
        
        var success =  function(response) {
            deferred.resolve(response);
        };
        var error = function(jqXHR, textStatus, errorThrown) {
            deferred.reject(jqXHR, textStatus, errorThrown);
        };
        
        //TODO: this class should not have a dependency on client
        client.query(soqlQuery, success, error);
        
        deferred.always(function() {
            load.finish();
        });
        return deferred.promise();
    },
    
    /**
     * Invoked by jQuery UI autocomplete when an item is selected
     */
    _onAutocompleteSelect: function(event, ui) {
        this.select(ui.item);
    },
    
    _onAutocompleteChange: function(event, ui) {
        //user didnt select an item but assume they know what they are doing
        if(!ui.item) {
            this.commit().fail(_.bind(function(input, msg) {
                this._onError(msg);
            }, this));
        }
    },
    
    _onKeyPress: function(event, ui) {
        this.trigger('keypress', event);
    },
    
    _onError: function(attributes) {
        var message = attributes.messages || attributes.message || attributes;
        
        if(typeof message === 'string') {
            this.trigger('error', message, attributes);
        } else {
            this.trigger('error', 'Error occurred with autocomplete', attributes);
        }
    },
    
    /**
     * We only want to trigger the 'loading' once no matter how many times we start loading. We 
     * also want to trigger 'loaded' only after all 'loading' has occurred.
     */
    _nextLoadId: 0,
    _loads: {},
    _startLoading: function() {
        var loadId = this._nextLoadId++;
        var load = {
            id: loadId,
            finish: _.bind(function() {
                this._endLoading(load);
            }, this)
        };
        var currentlyLoading = !_.isEmpty(this._loads);
        this._loads[loadId] = load;
        if(!currentlyLoading) {
            this.trigger('loading');
        }
        return load;
    },
    _endLoading: function(load) {
        delete this._loads[load.id];
        if(_.isEmpty(this._loads)) {
            this.trigger('loaded');
        }
    }
});
gus.LookupComponent.extend = Backbone.View.extend;
