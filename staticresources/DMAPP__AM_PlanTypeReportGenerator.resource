var ttg = ttg || {};

ttg.AM_PlanTypeReportGenerator = function(spec) {
    var that = {};
    that.spec = spec;
    
    var api = ttg.apiLayer.sfdcDelegate( { sessionid : '{!$Api.Session_ID}', opportunityid : '{!thePlanType.Id}' } );
	var id = spec.id;
	var sortByUpdated = spec.sortByUpdated;
	var showAllFields = spec.showAllFields;
	var diffExists = 0;
	var idFieldName = 'DMAPP__DealmakerID__c';
	var original;
	var updated;
	var updatedOrgIdPrefix;

	function getJSONReport (success, error, complete) {
        var succ = function(data) { try { success(data); } finally { complete(); } };
        var err = ttg.ajaxErrorFunction(error,complete);
		ttgInvoker.invokeVFR(ttg.getController('DMAPP.AM_PlanTypeReportController.getJSON'), 
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
 
	function parseJson(id){
        jQuery('#json' + id).removeClass('json-error');
        jQuery('#json' + id + 'errormessage').text('');
        try {
            var txt = jQuery.trim(jQuery('#json' + id).val());
            if (txt.slice(0,1) !== '{' && txt.slice(0,1) !== '[') {
                return txt;
            }
            else {
                return JSON.parse(txt);
            }
        } 
        catch (err) {
            jQuery('#json' + id).addClass('json-error');
            jQuery('#json' + id + 'errormessage').text(err + '');
        }
    }

	function log(desc, obj) {
		if (typeof obj === 'undefined') {
//			console.log(desc + ': undefined');
		} else {
			if (jQuery.isArray(obj)) {
//				console.log('array');
				_.each(obj, function (element, index, list) {
//					console.log(desc + '['+index+'] = ' + element);
					log(desc + '['+index+']', element); 
				});
			} else {
//				console.log('object');
				_.each(_.pairs(obj), function (element, index, list) {
//					console.log(desc + ': key = ' + element[0] + ', value = ' + element[1] + ', index = ' + index + ', length = ' + list.length);
					if (typeof element[1] === 'object') {
						log(desc + ' '+ element[0], element[1]);
					}
				});
			}
		}
	}

	function updateDebugJSON(json1, json2, diffJSON) {
        jQuery('#json1').val(typeof json1 === 'string' ? json1 : JSON.stringify(json1, null, 2));
        jQuery('#json2').val(typeof json2 === 'string' ? json2 : JSON.stringify(json2, null, 2));
        jQuery('#jsonDiff').val(JSON.stringify(diffJSON, null, 2));

	}

	function generatePlanDetailsTable(heading, originalComplete, updatedComplete, fields, fieldMap) {
	    var original = _.pick(_.first(originalComplete), fields);
	    var updated = _.pick(_.first(updatedComplete), fields);			    
		var diffJSON = jsondiffpatch.diff(original, updated);
		if (typeof diffJSON !== 'undefined') {
			diffExists = 1;
		}
		//updateDebugJSON(original, updated, diffJSON);
		var importantFields = ['Name'];
		var spec = {
			heading : heading,
			oldJSON : original,
			newJSON : updated,
			diff : diffJSON,
			importantFields : importantFields,
			fieldMap : fieldMap
		};
		jQuery('#PlanDetailsReportViewDiv').append(ttg.planDetailsVisualizer(spec));
	}

	function generatePlanDetailsSection(original, updated) {
		var fields = [
			'Name',  'DMAPP__Vertical_Axis__c', 'DMAPP__Horizontal_Axis__c', 
			'DMAPP__Current_Opportunity_Multiplier__c', 'DMAPP__Potential_Opportunity_Multiplier__c', 'Id', 'DMAPP__Order_No__c',
			'DMAPP__DealmakerID__c'
	    ];
		var fieldMap = {
 			'Name':'Plan Type Name',
			'DMAPP__Vertical_Axis__c':'Vertical Axis',
			'DMAPP__Horizontal_Axis__c':'Horizontal Axis', 
			'DMAPP__Current_Opportunity_Multiplier__c':'Current Opportunity Multiplier',
			'DMAPP__Potential_Opportunity_Multiplier__c':'Potential Opportunity Multiplier', 
			'DMAPP__Order_No__c':'Order No',
			'Id':'Id',
			'DMAPP__DealmakerID__c':'Dealmaker Id'
		};
		generatePlanDetailsTable('Details', original.planTypeDetails, updated.planTypeDetails, fields, fieldMap);
	}

	function generatePlanMetricsSection(original, updated) {
		var fields = [
			'DMAPP__DealmakerID__c', 'DMAPP__Tactical_Coverage_Amber__c','DMAPP__Tactical_Coverage_Green__c','DMAPP__Segmentation_Score_Amber__c','DMAPP__Segmentation_Score_Green__c',
			'DMAPP__Strategic_Potential_Amber__c','DMAPP__Strategic_Potential_Green__c','DMAPP__Value_Contribution_Amber__c','DMAPP__Value_Contribution_Green__c',
			'DMAPP__Strategic_Contribution_Amber__c','DMAPP__Strategic_Contribution_Green__c','DMAPP__Strategic_Coverage_Amber__c','DMAPP__Strategic_Coverage_Green__c',
			'DMAPP__Potential_Ops_Ratio_Amber__c','DMAPP__Potential_Ops_Ratio_Green__c','DMAPP__Target_Revenue_Attainment_Amber__c','DMAPP__Target_Revenue_Attainment_Green__c',
			'DMAPP__Strategic_Penetration_Amber__c','DMAPP__Strategic_Penetration_Green__c','DMAPP__Current_Ops_Ratio_Green__c','DMAPP__Current_Ops_Ratio_Amber__c', 'Id'
		];
 		var fieldMap = {
			'DMAPP__Tactical_Coverage_Amber__c': 'Targeted Unit Coverage Amber',
			'DMAPP__Tactical_Coverage_Green__c':'Targeted Unit Coverage Green',
			'DMAPP__Segmentation_Score_Amber__c':'Mutual Value Amber',
			'DMAPP__Segmentation_Score_Green__c':'Mutual Value Green',
			'DMAPP__Strategic_Potential_Amber__c':'Targeted Solution Potential Amber',
			'DMAPP__Strategic_Potential_Green__c':'Targeted Solution Potential Green',
			'DMAPP__Value_Contribution_Amber__c':'Value To Customer Amber',
			'DMAPP__Value_Contribution_Green__c':'Value To Customer Green',
			'DMAPP__Strategic_Contribution_Amber__c':'Targeted Solution Pipeline Amber',
			'DMAPP__Strategic_Contribution_Green__c':'Targeted Solution Pipeline Green',
			'DMAPP__Strategic_Coverage_Amber__c':'Targeted Relationship Coverage Amber',
			'DMAPP__Strategic_Coverage_Green__c':'Targeted Relationship Coverage Green',
			'DMAPP__Potential_Ops_Ratio_Amber__c':'Potential Opportunities Amber',
			'DMAPP__Potential_Ops_Ratio_Green__c':'Potential Opportunities Green',
			'DMAPP__Target_Revenue_Attainment_Amber__c':'Revenue Attainment Amber',
			'DMAPP__Target_Revenue_Attainment_Green__c':'Revenue Attainment Green',
			'DMAPP__Strategic_Penetration_Amber__c':'Targeted Solution Penetration Amber',
			'DMAPP__Strategic_Penetration_Green__c':'Targeted Solution Penetration Green',
			'DMAPP__Current_Ops_Ratio_Green__c':'Current Opportunities Green',
			'DMAPP__Current_Ops_Ratio_Amber__c':'Current Opportunities Amber', 
			'Id':'Id',
			'DMAPP__DealmakerID__c':'Dealmaker Id'
		};
	    generatePlanDetailsTable('Metrics', original.planTypeDetails, updated.planTypeDetails, fields, fieldMap);
	}

	function generatePlanDetailsReport() {
		jQuery('#PlanDetailsReportViewDiv').empty();
		generatePlanDetailsSection(original, updated);
		generatePlanMetricsSection(original, updated);
		jQuery('#PlanDetailsReportViewDiv').find('.jsondiffpatch-unchanged').each(function(){
			jQuery(this).css('display', (showAllFields ? 'table-row' : 'none' ));
		});
 	}

 	function generateAmQuestionsTable(heading, original, updated) {			    
		var diffJSON = jsondiffpatch.diff(original, updated);
		if (typeof diffJSON !== 'undefined') {
			diffExists = 1;
		}
		updateDebugJSON(original, updated, diffJSON);
		var importantFields = ['DMAPP__Question_Text__c', 'DMAPP__Order_Number__c'];
		var fieldMap = {
			'Name':'Account Plan Question Name',
			'DMAPP__Active__c':'Active',
			'DMAPP__Help__c':'Help',
			'DMAPP__Mandatory__c':'Mandatory',
			'DMAPP__No_Label__c':'No Label',
			'DMAPP__No_Score__c':'No Score',
			'DMAPP__Order_Number__c':'Order Number', 
			'DMAPP__Question_Text__c':'Question Text',
			'DMAPP__Recommended__c':'Recommended',
			'DMAPP__Section_Heading__c':'Section Heading',
			'DMAPP__Summary__c':'Summary',
			'DMAPP__Unknown_Score__c':'Unknown Score',
			'DMAPP__Yes_Label__c':'Yes Label',
			'DMAPP__Yes_Score__c':'Yes Score',
			'Id':'Id',
			'DMAPP__DealmakerID__c':'Dealmaker Id'
		};
		var spec = {
			planTypeId : id,
			heading: heading,
			desc :  'amQuestion',
			oldJSON : original,
			newJSON : updated,
			fieldMap : fieldMap,
			diff : diffJSON,
			importantFields : importantFields,
			newJSONOrgIdPrefix : updatedOrgIdPrefix					 		
 		};
// 		console.log('generateAmQuestionsTable(): updatedOrgIdPrefix = ' + updatedOrgIdPrefix);
		jQuery('#AMQuestionsReportViewDiv').empty().append(ttg.objectVisualizer(spec));
 	}
 
 	function generateAmQuestionQuicklinksTable(parentName, heading, original, updated, questionDealmakerId) {			    
		var diffJSON = jsondiffpatch.diff(original, updated);
		//updateDebugJSON(original, updated, diffJSON);
		if (typeof diffJSON !== 'undefined') {
			diffExists = 1;
		}
		var importantFields = [];
 		var fieldMap = {
			'Name':'DM Plan Question Quicklink Name',
			'DMAPP__AM_Question__c':'AM Question',
			'DMAPP__SortOrder__c':'SortOrder',
			'DMAPP__Quicklink__c':'Quicklink',
			'Id':'Id',
			'DMAPP__DealmakerID__c':'Dealmaker Id'
		};
 		var spec = {
			heading: heading,
			desc :  'amQuestionQuicklinks',
			oldJSON : original,
			newJSON : updated,
			fieldMap : fieldMap,
			diff : diffJSON,
			importantFields : importantFields,
			parentObjectDealmakerId : questionDealmakerId,
			parentName : parentName,
			newJSONOrgIdPrefix : updatedOrgIdPrefix
 		};
 		jQuery('#AMQuestionQuicklinksReportViewDiv').append(ttg.objectVisualizer(spec));
 	}		 	

 	function generateSegQuestionsTable(heading, original, updated) {
		var diffJSON = jsondiffpatch.diff(original, updated);
		if (typeof diffJSON !== 'undefined') {
			diffExists = 1;
		}
//				updateDebugJSON(original, updated, diffJSON);
		var importantFields = ['DMAPP__Category__c'];
		var fieldMap = {
				'Name':'Question',
				'DMAPP__Category__c':'Category',
				'DMAPP__Help__c':'Help',
				'DMAPP__SortOrder__c':'SortOrder',
				'Id':'Id',
				'DMAPP__DealmakerID__c':'Dealmaker Id'
				};
 		var spec = {
 				planTypeId : id,
	 			heading: heading,
	 			desc :  'segQuestion',
				oldJSON : original,
				newJSON : updated,
				fieldMap : fieldMap,
				diff : diffJSON,
				importantFields : importantFields,
				newJSONOrgIdPrefix : updatedOrgIdPrefix					 		
	 		};
		jQuery('#SegQuestionsReportViewDiv').empty().append(ttg.objectVisualizer(spec));
 	}


 	function generateSegQuestionOptionsTable(parentName, heading, original, updated, questionDealmakerId) {
		var diffJSON = jsondiffpatch.diff(original, updated);
		//updateDebugJSON(original, updated, diffJSON);
		if (typeof diffJSON !== 'undefined') {
			diffExists = 1;
		}
		var importantFields = [];
		var fieldMap = {
			'Name':'Question Option',
			'DMAPP__SortOrder__c':'SortOrder', 
			'DMAPP__Score__c':'Score', 
			'DMAPP__Segmentation_Question__c':'Segmentation Question',
			'Id':'Id',
			'DMAPP__DealmakerID__c':'Dealmaker Id'
		};
		var spec = {
			heading: heading,
			desc :  'segQuestionOptions',
			oldJSON : original,
			newJSON : updated,
			fieldMap : fieldMap,
			diff : diffJSON,
			importantFields : importantFields,		 		
			parentObjectDealmakerId : questionDealmakerId,
			parentName : parentName,
			newJSONOrgIdPrefix : updatedOrgIdPrefix
		};
		jQuery('#SegQuestionOptionsReportViewDiv').append(ttg.objectVisualizer(spec));
 	}
 	
	function generateObjectReport(objectType, sortFieldName) {
		var cleanOriginal = filterQuestions(original, objectType);
		var cleanUpdated = filterQuestions(updated, objectType);
	    var spec = {original : cleanOriginal, updated : cleanUpdated, sortFieldName :sortFieldName};
	    sortByRequiredSortOrder(spec);
		if (objectType === 'amQuestionDetails') {
			generateAmQuestionsTable('AM Question', spec.original, spec.updated);
			jQuery('#AMQuestionsReportViewDiv').find('.jsondiffpatch-unchanged').each(function(){
				jQuery(this).css('display', (showAllFields ? 'table-row' : 'none' ));
			});
		} else {
			generateSegQuestionsTable('Segmentation Question', spec.original, spec.updated);
			jQuery('#SegQuestionsReportViewDiv').find('.jsondiffpatch-unchanged').each(function(){
				jQuery(this).css('display', (showAllFields ? 'table-row' : 'none' ));
			});

		}
	}

 	function generateAmQuestionQuicklinksReport() {		 			
 		jQuery('#AMQuestionQuicklinksReportViewDiv').empty();
 		var refIdNames = getAllQuestionIds(original, updated, 'amQuestionDetails', 'DMAPP__Order_Number__c');
 		_.each(refIdNames, function (idName, index, list) {
// 		    console.log('generateAmQuestionQuicklinksReport(): idName.originalId = ' + idName.originalId + ', idName.updatedId = ' + idName.updatedId);
			var spec = {children : original, questionId : idName.originalId, name :  'amQuestionQuicklinks' , questionIdField : 'DMAPP__AM_Question__c'};
	 		var cleanOriginal = cleanQuestionChildren(spec);
	 		spec.children = updated;
	 		spec.questionId = idName.updatedId;
	 		var cleanUpdated = cleanQuestionChildren(spec);
		    var spec = {original : cleanOriginal, updated : cleanUpdated, sortFieldName : 'DMAPP__SortOrder__c'};
		    sortByRequiredSortOrder(spec);
			if ((spec.original.length !== 0) || (spec.updated.length !== 0)) {
			    generateAmQuestionQuicklinksTable(idName.name, 'Quicklink ', spec.original, spec.updated, idName.dealmakerId);
			}
		});
		jQuery('#AMQuestionQuicklinksReportViewDiv').find('.jsondiffpatch-unchanged').each(function(){
			jQuery(this).css('display', (showAllFields ? 'table-row' : 'none' ));
		});
 	}

 	function generateSegQuestionOptionsReport() {
	 	jQuery('#SegQuestionOptionsReportViewDiv').empty();
 		var refIdNames = getAllQuestionIds(original, updated, 'segmentationQuestions', 'DMAPP__SortOrder__c');
 		_.each(refIdNames, function (idName, index, list) {
			var spec = {children : original, questionId : idName.originalId, name :  'segmentationQuestionOptions' , questionIdField : 'DMAPP__Segmentation_Question__c'};
			var cleanOriginal = cleanQuestionChildren(spec);
			spec.children = updated;
			spec.questionId = idName.updatedId;
			var cleanUpdated = cleanQuestionChildren(spec);
		    var spec = {original : cleanOriginal, updated : cleanUpdated, sortFieldName : 'DMAPP__SortOrder__c'};
		    sortByRequiredSortOrder(spec);
			if ((spec.original.length !== 0) || (spec.updated.length !== 0)) {
			    generateSegQuestionOptionsTable(idName.name, 'Option', spec.original, spec.updated, idName.dealmakerId);
			}
		});
		jQuery('#SegQuestionOptionsReportViewDiv').find('.jsondiffpatch-unchanged').each(function(){
			jQuery(this).css('display', (showAllFields ? 'table-row' : 'none' ));
		});
 	}
	
 	function getAllQuestionIds(original, updated, name, sortFieldName){
	    var originalQuestions = (_.pick(original, name))[name];
	    var updatedQuestions = (_.pick(updated, name))[name];
	    var spec = {original : originalQuestions, updated : updatedQuestions, sortFieldName :sortFieldName};
	    sortByRequiredSortOrder(spec);
	    var originalIds = getIdNameMap(spec.original);
	    var updatedIds = getIdNameMap(spec.updated);
	    var dealmakerIds;
		if (sortByUpdated) {
			dealmakerIds = _.union(_.keys(updatedIds), _.keys(originalIds)); 
		} else {
			dealmakerIds = _.union(_.keys(originalIds) , _.keys(updatedIds) ); 
		}
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
	
 	function getIdNameMap(objects) {
		var idNames = {};
		_.each(objects, function(val) {
// 			console.log('getIdNameMap(): val[idFieldName] = ' + val[idFieldName] + ', val.id = ' + val.Id );
 			idNames[val[idFieldName]] = {id : val.Id, name : val.Name, dealmakerId : val[idFieldName]};
 		});
		return idNames; 		
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
//		    		console.log('SortIds = ' + sortIds);
		    		var index;
		    		if (_.contains(sortIds, element[idFieldName])) {
		    			index = _.indexOf(sortIds, element[idFieldName]);
//			    		console.log('Found element[idFieldName] = ' + element[idFieldName] + ' at ' + index);
		    		} else {
		    			var sortOrder = _.pick(element, sortField)[sortField];
		    			index = sortIds.length + sortOrder;;
//			    		console.log('Didnt find element[idFieldName] = ' + element[idFieldName] + ', returning ' + index);
		    		}
			    	return index;
				} else {
			    	return _.pick(element, sortField)[sortField];
			    }
		    }); 
		}
	    return sortedElements;
	}

	function filterQuestions(questions, name){
 		var fields = ['CreatedBy', 'LastModifiedBy', 'Owner', 'attributes' ];
	    var cleanQuestions = _.map(_.pick(questions, name)[name], function(value, key) {
	    	var filtered = _.omit(value, fields);
	    	var type = _.pick(value['attributes'], 'type');
	    	return _.extend(filtered, type);
	    });	    
	    return cleanQuestions;
 	}
 	
	function cleanQuestionChildren(spec){
		var children  = spec.children;
		var questionId = spec.questionId; 
		var name = spec.name; 
		var questionIdField = spec.questionIdField;
		var cleanOptions ;
//		console.log('====> cleanQuestionChildren(): questionIdField = ' + questionIdField + ', questionId = ' + questionId);
		if (children && children[name]) {
				cleanOptions = filterQuestions(children, name);
//				console.log('====> cleanQuestionChildren(): cleanOptions = ' + cleanOptions);
		    	cleanOptions = _.filter(cleanOptions, function(option){    	 
//					console.log('====> cleanQuestionChildren(): found = ' + option[questionIdField]);
			    	 return option[questionIdField] === questionId; 
			    });
		}
		return cleanOptions;
	}
 	
 	function getJSONForComparision (success, error, complete) {
        var succ = function(data) { try { success(data); } finally { complete(); } };
        var err = ttg.ajaxErrorFunction(error,complete);
		ttgInvoker.invokeVFR(ttg.getController('DMAPP.AM_PlanTypeReportController.getJSONForComparision'), 
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
		updatedOrgIdPrefix = updated['orgPrefix'];
		//updateDebugJSON(original, updated, '');
		diffExists = 0;
		generatePlanDetailsReport();
		generateObjectReport('amQuestionDetails', 'DMAPP__Order_Number__c');
		generateAmQuestionQuicklinksReport();
		generateObjectReport('segmentationQuestions', 'DMAPP__SortOrder__c');
		generateSegQuestionOptionsReport();
		if (diffExists === 0) {
		    jQuery("span[id*='reportStatus']").html("Plan type is unchanged");
		} else {
		    jQuery("span[id*='reportStatus']").css('color', 'red').html("Plan Type has <strong>differences</strong>");
		}
	}
 			 
	function generate() {
    	var newData;
    	getJSONForComparision(
	            function(responseData) {
	                if (responseData !== null) {
	                	newData = JSON.parse(JSON.stringify(responseData));
	                }
	            },
	            function() { jQuery('#errormessage').text("An error occurred trying to retrieve data for update Plan Type, please reload the file and try again");/* error */ },                 
	            function() { 
	            	getJSONReport(
			            function(responseData) { 
			                if (responseData !== null) {
			                	if (newData && newData !== null) {
			                		generateReport(responseData, newData);
				                } else {
						            jQuery('#errormessage').html("No data was retrieved for the updated Plan Type, please reload the file and try again");
				                }
			                } else {
			                    jQuery('#errormessage').text("An error occurred trying to retrieve data for the current Plan Type");
			                }
			            },
			            function() { jQuery('#errormessage').text("An error occurred try to retrieve data for the current Plan Type");/* error */ },
			            function() { /* complete */ }
			        );
	            }               
	        );
    }
    
	that.generate = generate;
	that.filterQuestions = filterQuestions;
	that.cleanQuestionChildren = cleanQuestionChildren;
	that.getAllQuestionIds = getAllQuestionIds;
	that.sortElements = sortElements;
	return that;
};
