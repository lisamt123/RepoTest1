var ttg = ttg || {};

ttg.SObjectReportGenerator = function(spec) {
    var that = {};
    that.spec = spec;
    
    var api = ttg.apiLayer.sfdcDelegate( { sessionid : '{!$Api.Session_ID}' } );
    var id = spec.id || null;
	var type = spec.type;
	var label = spec.label;
	var comparisionJSON = spec.comparisionJSON;
	var sortByUpdated = spec.sortByUpdated;
	var showAllFields = spec.showAllFields;
	var showAllElements = spec.showAllElements;
	var controllerName = spec.controllerName;
	var getJSONMethod = spec.getJSONMethod || 'getJSON';
	var getJSONForComparisionMethod = spec.getJSONForComparisionMethod || 'getJSONForComparision';
	var insertMethod = spec.insertMethod ||  'insertObject';
	var objectReportGenerator = spec.objectReportGenerator;
	var diffExists = 0;
	var idFieldName = spec.idFieldName || 'DMAPP__DealmakerID__c';
	var original;
	var updated;

	function updateDebugJSON(json1, json2, diffJSON) {
        jQuery('#json1').val(typeof json1 === 'string' ? json1 : JSON.stringify(json1, null, 2));
        jQuery('#json2').val(typeof json2 === 'string' ? json2 : JSON.stringify(json2, null, 2));
        jQuery('#jsonDiff').val(JSON.stringify(diffJSON, null, 2));
	}

 	function getFieldNameLabelMap (success, error, complete, spec) {
        var succ = function(data) { try { success(data); } finally { complete(spec); } };
        var err = ttg.ajaxErrorFunction(error,complete);
//		console.log('getFieldNameLabelMap(): calling: ' + ttg.vfpclass + controllerName + '.getFieldNameLabelMap()')
		ttgInvoker.invokeVFR(ttg.getController(ttg.vfpclass + controllerName +  '.getFieldNameLabelMap'), 
        	spec.reportSpec.objectType, 
        	function(result, event) { 
				if (event.type === 'exception') { 
					err(result,event);
				} else {
					succ(result); 
				} 
			}, 
		{escape: false});
	}

	function visualizeTable(tableSpec) {
		var fieldMap;
		getFieldNameLabelMap(
			function(responseData) {
				fieldMap = responseData;
        	},
        	function() { jQuery('#errormessage').text("An error occurred trying to retrieve data for the updated " + label + ", please reload the file and try again");/* error */},
        	function(spec) {
		 		spec.fieldMap = fieldMap;
		 		spec.id = id;
		 		spec.heading = spec.heading;
				spec.oldJSON = spec.original;
				spec.newJSON = spec.updated;
		 		spec.tableName = spec.reportSpec.tableName;
		 		spec.desc = spec.reportSpec.name;
		 		spec.importantFields = spec.reportSpec.importantFields;
		 		spec.showAllFields = showAllFields;
				spec.showAllElements = showAllElements;
				spec.parentObjectId = tableSpec.parentObjectId;
				spec.parentName = tableSpec.parentName;
				spec.parentRefField = tableSpec.parentRefField;
				spec.parentObjectDealmakerId = tableSpec.parentObjectDealmakerId;
				spec.controllerName = controllerName;
				if (spec.reportSpec.reportType === 'SingleObject') {
					jQuery(spec.reportSpec.divName).append(ttg.objectDetailsVisualizer(spec));
				} else {
					jQuery(spec.reportSpec.divName).append(ttg.objectVisualizer(spec));					
				}
        	},
        	tableSpec              
		) ;
	}

	function generateObjectReport(reportSpec) {
		var spec = {
			original : filterElements(original, reportSpec),
			updated : filterElements(updated, reportSpec),
			sortFieldName : reportSpec.sortFieldName
		};
		sortByRequiredSortOrder(spec);
	    var diffOriginal = filterElements(spec.original, {fieldBlackList: 'Id'});
	    var diffUpdated = filterElements(spec.updated, {fieldBlackList: 'Id'});
		var diffJSON;
		if (reportSpec.reportType === 'SingleObject') {
			diffJSON = jsondiffpatch.diff(diffOriginal[0], diffUpdated[0]);
			spec.original = spec.original[0];
			spec.updated = spec.updated[0];			
		} else {
			diffJSON = jsondiffpatch.diff(diffOriginal, diffUpdated);
		}
		if (typeof diffJSON !== 'undefined') {
			diffExists = 1;
		}
		if (reportSpec.debug) {
			updateDebugJSON(spec.original, spec.updated, diffJSON);
		}
		spec.reportSpec = reportSpec;
		spec.diff = diffJSON;
		spec.originalOrgIdPrefix = original['orgPrefix'];
		spec.updatedOrgIdPrefix = updated['orgPrefix'];;
		spec.parentObjectId = id;

		jQuery(reportSpec.divName).empty();
		visualizeTable(spec)
	}

	function generateChildObjectReport(reportSpec, parentReportSpec) {
		jQuery(reportSpec.divName).empty();
 		// console.log('generateChildObjectReport(): reportSpec= ' + reportSpec.name + ', parentReportSpec = ' + parentReportSpec.name );
	 	var parentIdNames = getParentIds(original, updated, reportSpec.parentElement, parentReportSpec.sortFieldName);
 		_.each(parentIdNames, function (idName, index, list) {
 			// console.log('generateChildObjectReport(): idName.name = ' + idName.name + ', idName.dealmakerId = ' + idName.dealmakerId + ', idName.originalId = ' + idName.originalId + ', idName.updatedId = ' + idName.updatedId);
			var cleanParentsSpec = {
				children : original, 
				parentId : idName.originalId, 
			};
			reportSpec.children = original 
			reportSpec.parentId = idName.originalId;
	 		var cleanOriginal = cleanChildren(reportSpec);
			reportSpec.children = updated 
			reportSpec.parentId = idName.updatedId;
	 		var cleanUpdated = cleanChildren(reportSpec);

			var spec = {
				original : filterElements(cleanOriginal, {fieldBlackList: reportSpec.fieldBlackList}),
				updated : filterElements(cleanUpdated, {fieldBlackList: reportSpec.fieldBlackList}),
				sortFieldName : reportSpec.sortFieldName
			};
			sortByRequiredSortOrder(spec);
			if ((spec.original.length !== 0) || (spec.updated.length !== 0)) {
			    var diffOriginal = filterElements(spec.original, {fieldBlackList: 'Id'});
			    var diffUpdated = filterElements(spec.updated, {fieldBlackList: 'Id'});
				var diffJSON;
				if (reportSpec.reportType === 'SingleObject') {
					diffJSON = jsondiffpatch.diff(diffOriginal[0], diffUpdated[0]);
					spec.original = spec.original[0];
					spec.updated = spec.updated[0];			
				} else {
					diffJSON = jsondiffpatch.diff(diffOriginal, diffUpdated);
				}
				if (typeof diffJSON !== 'undefined') {
					diffExists = 1;
				}
				if (reportSpec.debug) {
					updateDebugJSON(spec.original, spec.updated, diffJSON);
				}
				spec.reportSpec = reportSpec;
				spec.diff = diffJSON;
				spec.originalOrgIdPrefix = original['orgPrefix'];
				spec.updatedOrgIdPrefix = updated['orgPrefix'];
				spec.parentName = idName.name;
				spec.parentObjectDealmakerId = idName.dealmakerId;
//	 			console.log('generateChildObjectReport(): visualizeTable parentName = ' + spec.parentName + ', parentObjectDealmakerId = ' + spec.parentObjectDealmakerId);
	 			visualizeTable(spec)
			}
		});
 	}

 	function getParentIds(original, updated, name, sortFieldName) {
		// console.log('----> getParentIds(): name = ' + name);
		var originalParents = getElementByName(original, name);
		var updatedParents = getElementByName(updated, name);
		// console.log('----> getParentIds(): name = ' + name + ', originalParents = ' + originalParents + ', updatedParents = ' + updatedParents);
		var spec = {
		    original : originalParents,
		    updated : updatedParents,
		    sortFieldName : sortFieldName
		};
		sortByRequiredSortOrder(spec);
		var originalIds = getIdNameMap(spec.original);
		// console.log('----> getParentIds(): originalIds = ' + originalIds);
		var updatedIds = getIdNameMap(spec.updated);
		// console.log('----> getParentIds(): updatedIds = ' + updatedIds);
		var dealmakerIds;
		if (sortByUpdated) {
			dealmakerIds = _.union(_.keys(updatedIds), _.keys(originalIds));
		} else {
			dealmakerIds = _.union(_.keys(originalIds), _.keys(updatedIds));
		}
		// console.log('----> getParentIds(: dealmakerIds = ' + dealmakerIds);
		var idNames = [];
		_.each(dealmakerIds, function(dealmakerId, index) {
			var idName = {};
			idName.dealmakerId = dealmakerId;
			idName.originalId = originalIds[dealmakerId] && originalIds[dealmakerId].id;
			idName.updatedId = updatedIds[dealmakerId] && updatedIds[dealmakerId].id;
			idName.name = (originalIds[dealmakerId] && originalIds[dealmakerId].name) || (updatedIds[dealmakerId] && updatedIds[dealmakerId].name);
			idNames.push(idName);
		});
		return idNames;
	}

	function cleanChildren(reportSpec){
		var children  = reportSpec.children;
		var parentId = reportSpec.parentId; 
		var name = reportSpec.name; 
		var parentRefField = reportSpec.parentRefField;
		var cleanOptions ;
		 // console.log('====> cleanChildren(): parentRefField = ' + parentRefField + ', parentId = ' + parentId);
		if (children && children[name]) {
				cleanOptions = getElementByName(children, reportSpec.name);

				// console.log('====> cleanChildren(): cleanOptions = ' + cleanOptions);
		    	cleanOptions = _.filter(cleanOptions, function(option){    	 
					// console.log('====> cleanChildren(): found = ' + option[parentRefField]);
			    	return option[parentRefField] === parentId; 
			    });
		}
		return cleanOptions;
	}



	function sortByRequiredSortOrder(spec) {
		if (sortByUpdated) {
			spec.updated = sortElements(spec.updated, spec.sortFieldName);
			spec.original = sortElements(spec.original, spec.sortFieldName, _.pluck(spec.updated, idFieldName));
		} else {
			spec.original = sortElements(spec.original, spec.sortFieldName);
			spec.updated = sortElements(spec.updated, spec.sortFieldName, _.pluck(spec.original, idFieldName));
		}
	}

	function sortElements(elements, sortField, sortIds) {
		var sortedElements = new Array();
		if (_.isArray(elements)) {
		    sortedElements = _.sortBy(elements,  function(element) {
		    	if (sortIds) {
		    		// console.log('SortIds = ' + sortIds);
		    		var index;
		    		if (_.contains(sortIds, element[idFieldName])) {
		    			index = _.indexOf(sortIds, element[idFieldName]);
			    		// console.log('Found element[idFieldName] = ' + element[idFieldName] + ' at ' + index);
		    		} else {
		    			var sortOrder = parseInt(_.pick(element, sortField)[sortField]);
		    			index = sortIds.length + (isNaN(sortOrder) ? 1 : sortOrder);
			    		// console.log('Didnt find element[idFieldName] = ' + element[idFieldName] + ', returning ' + index);
		    		}
			    	return index;
				} else {
					// console.log('SortElements(): _.pick(' + sortField + ')' + _.pick(element, sortField)[sortField]);
			    	return _.pick(element, sortField)[sortField];
			    }
		    }); 
		}
		// _.each(sortedElements, function iterator(element, index) {
		// 	console.log('sortElements(): returning element[' + index + ']' + element[sortField]);
		// });
	    return sortedElements;
	}
 
	function filterElements(elements, reportSpec){
 		var fields = ['CreatedBy', 'LastModifiedBy', 'Owner', 'attributes' ];
 		fields = fields.concat(reportSpec.fieldBlackList);
 		// console.log('filterElements(): reportSpec name = ' + reportSpec.name);

	 	var filteredObjects = getElementByName(elements, reportSpec.name);
 		var cleanElements = _.map(filteredObjects, function(value, key) {
	 		// console.log('filterElements(): _.Map _.keys(value) = ' + _.keys(value));
	    	var filtered = _.omit(value, fields);
	    	if (value['attributes']) {
		    	var type = _.pick(value['attributes'], 'type');
		    	filtered = _.extend(filtered, type);
		    }
	    	return filtered;
	    });	    
 		 // console.log('filterElements(): returning ' + cleanElements);
	    return cleanElements;
 	}

	function getElementByName(elements, name) {
		var filteredObjects = elements;
		if (name) {
			var nameList = name.split('.');
	 		_.each(nameList, function(name) {
		 		 // console.log('getElementByName(): name = ' + name);
	 			filteredObjects = _.pick(filteredObjects, name)[name]
	 		});
 		}
 		return filteredObjects;
	}

 	function getIdNameMap(objects) {
		var idNames = {};
		_.each(objects, function(val) {
// 			console.log('getIdNameMap(): val[idFieldName] = ' + val[idFieldName] + ', val.id = ' + val.Id );
 			idNames[val[idFieldName]] = {id : val.Id, name : val.Name, dealmakerId : val[idFieldName]};
 		});
		return idNames; 		
 	}
 	
 	function getJSONForComparision (success, error, complete) {
        var succ = function(data) { try { success(data); } finally { complete(); } };
        var err = ttg.ajaxErrorFunction(error,complete);
		console.log('getJSONForComparision(): calling: ' + ttg.vfpclass + controllerName + '.' + getJSONForComparisionMethod + ', with id = ' + id)
		ttgInvoker.invokeVFR(ttg.getController(ttg.vfpclass + controllerName +  '.' + getJSONForComparisionMethod), 
        	id, 
        	function(result, event) { 
				if (event.type === 'exception') { 
					err(result,event);
				} else {
					succ(result); 
				} 
			}, 
		{escape: false});
	}

	function getJSONReport (success, error, complete) {
		var succ = function(data) { try { success(data); } finally { complete(); } };
		var err = ttg.ajaxErrorFunction(error,complete);
		console.log('getJSONReport(): calling: ' + ttg.vfpclass + controllerName + '.' + getJSONMethod + ', with id = ' + id)
		ttgInvoker.invokeVFR(ttg.getController(ttg.vfpclass + controllerName + '.' + getJSONMethod),
			id,
			function(result, event) { 
				if (event.type === 'exception') {
					err(result,event);
				} else {
					succ(result);
				} 
			}, 
			{escape: false});
	}

	function generateReport(originalData, newData) {
		original = JSON.parse(originalData);
		updated = JSON.parse(newData);
		diffExists = 0;
		var reportElementMap = objectReportGenerator.getReportElements();

		_.each(_.values(reportElementMap), function(reportElementSpec, index) {
			 // console.log('generateReport(): reportElement: ' + reportElementSpec.name);
			if (reportElementSpec.parentElement) {
				generateChildObjectReport(reportElementSpec, reportElementMap[reportElementSpec.parentElement]);
			} else {
				generateObjectReport(reportElementSpec);
			}
		});
		if (diffExists === 0) {
		    jQuery("span[id*='reportStatus']").html(label + " is unchanged");
		} else {
		    jQuery("span[id*='reportStatus']").css('color', 'red').html(label + " has <strong>differences</strong>");
		}
	}


	function generateFromJSON() {
    	getJSONReport(
            function(responseData) { 
                if (responseData !== null) {
                	if (comparisionJSON !== null) {
                		generateReport(responseData, comparisionJSON);
	                } else {
			            jQuery('#errormessage').html("No data was retrieved for the updated " + label + ", please reload the file and try again");
	                }
                } else {
                    jQuery('#errormessage').text("An error occurred trying to retrieve data for the current " + label);
                }
            },
            function() { jQuery('#errormessage').text("An error occurred try to retrieve data for the current " + label);/* error */ },
            function() { /* complete */ }
        );
    }

	function generate() {
    	getJSONForComparision(
	            function(responseData) {
	                if (responseData !== null) {
	                	comparisionJSON = JSON.parse(JSON.stringify(responseData));
	                }
	            },
	            function() { jQuery('#errormessage').text("An error occurred trying to retrieve data for the updated " + label + ", please reload the file and try again");/* error */ },                 
	            function() { generateFromJSON() }               
	        );
    }

 	
    that.generate = generate;
    that.generateFromJSON = generateFromJSON;
	that.filterElements = filterElements;
	that.sortElements = sortElements;
	that.sortByRequiredSortOrder = sortByRequiredSortOrder;	
	that.getParentIds = getParentIds;
	that.cleanChildren = cleanChildren;
	return that;
};
