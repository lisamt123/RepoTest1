var ttg = ttg || {};

ttg.SObjectVisualizer = function(spec) {
    var that = {};
    that.spec = spec;
    
    var id = spec.id;
	var heading = spec.heading || '';
	var desc = spec.desc || 'Element';
	var oldJSON = spec.oldJSON;
	var newJSON = spec.newJSON;
	var fieldMap = spec.fieldMap;
	var diff = spec.diff;
	var importantFields = spec.importantFields;
	var idFieldName = spec.idFieldName || 'Id';
	var tableSpec = spec.table;
	var showAllFields = spec.showAllFields;
	var showAllElements = spec.showAllElements;
	var originalOrgIdPrefix = spec.originalOrgIdPrefix;
	var updatedOrgIdPrefix = spec.updatedOrgIdPrefix;
	var parentObjectId = spec.parentObjectId;
	var parentName = spec.parentName;
	var parentObjectDealmakerId = spec.parentObjectDealmakerId;
	var controllerName = spec.controllerName;
	var insertMethod = spec.insertMethod || 'insertObject';
	var mainTable;
	var originalElements = [];
	var newElements = [];
	var idMap = {};

	function tableRenderer(spec) {		 
	    var that = {};

		var rows = [];
		var changed = false;

		function hasChanged() {
			return changed;
		}

		function getRows() {
			return rows;
		}

		function addRow(row) {
           	// console.log('tableRenderer.addRow(): Adding Row ');
			rows.push(row);
			if (row.hasChanged()) {
				changed = true;
			}
		}

		function render() {
           	// console.log('tableRenderer.render(): Row  length = ' + rows.length);
			tableSpec.className = 'jsondiffpatch-object-table-unchanged';
			tableSpec.style = 'display: none;';
			if (changed) {
				tableSpec.className = 'jsondiffpatch-object-table-changed';				
				tableSpec.style = 'display: table-row;';
			}
			if (showAllElements) {
				tableSpec.style = 'display: table-row;';
			}
			var table = createTable(tableSpec);
	        _.each(rows, function (row) { 
	        	table.appendChild(row.render());
	        });
	        return table;
		}

		that.getRows = getRows;
		that.addRow = addRow;
		that.render = render;
		return that;
	}

	function rowRenderer(spec) {		 
	    var that = {};

	    var index = spec.index;
		var originalValue = spec.originalValue;
		var newValue = spec.newValue;
		var changed = false;

		function hasChanged() {
			return changed;
		}

		function render() {
//	        console.log('Row Renderer: render row ' + index);
			var className = 'jsondiffpatch-item-row-unchanged';
			var style = 'display: none;';
			if (showAllElements) {
				style = 'display: table-row;';
			}

	        var tdOriginal = createElement('td');
	        var tdNew = createElement('td');
	        if (!_.isUndefined(originalValue)) {
//		        console.log('Row Renderer: appendChild ' +  originalValue);
		        tdOriginal.appendChild(originalValue.render());
				if (originalValue.getDiffType() !== 'Unchanged') {
					className = 'jsondiffpatch-item-row-changed';
					style = 'display: table-row;';
				}
		    }
	        if (!_.isUndefined(newValue)) {
		        tdNew.appendChild(newValue.render());
				if (newValue.getDiffType() !== 'Unchanged') {
					className = 'jsondiffpatch-item-row-changed';
					style = 'display: table-row;';
				}
		    }
	        // console.log('Row Renderer: render row ' + index + ', className = ' + className + ', style = ' + style);
	        var itemRow = createElement('tr', className, style);
	        itemRow.appendChild(tdOriginal);
	        itemRow.appendChild(tdNew);
	        return itemRow;
		}

      	if (!_.isUndefined(originalValue)) {
	        // console.log('rowRenderer: originalValue.getDiffType() = ' + originalValue.getDiffType() );
			if (originalValue.getDiffType() !== 'Unchanged') {
				changed = true;
			}
	    }
        if (!_.isUndefined(newValue)) {
	        // console.log('rowRenderer: newValue.getDiffType() = ' + newValue.getDiffType() );
			if (newValue.getDiffType() !== 'Unchanged') {
				changed = true;
			}
	    }

        //console.log('processArray: originalValue = ' + originalValue.getDiffType() + ', newValue = ' + newValue.getDiffType());
		that.originalValue = originalValue;
		that.newValue = newValue;
		that.render = render;
		that.hasChanged = hasChanged;
		return that;
	}
	
	var elementRenderer = function (spec) {
	    var that = {};
	    that.spec = spec;

		var elementJSON = spec.elementJSON;
		var index = spec.index;
		var elementType = spec.elementType;
		var diffType = 'Unchanged';
		var dealmakerId = (elementJSON && elementJSON[idFieldName]);
		var objectId = (elementJSON && elementJSON.Id) || '';
		var changedFields;
		var title = (elementJSON && elementJSON.Name) || '';
		var tableClassName = 'jsondiffpatch-item-table';
		var tableStyle = 'display: table;';
		var elementName = (elementJSON && elementJSON.Name) || '';

		function getDiffType() {
			return diffType;
		}
		
		function generateElementRow(name, value, className, important) {
			var style;
			if (showAllFields) {
				style = 'display: table-row;';
			} else if (className === 'jsondiffpatch-unchanged' && important === '') {
				style = 'display: none;';
			}

	    	var row = createElement('tr',  className + important, style);    	
	        row.appendChild(createPropertyNameCell(name)); 
		    row.appendChild(createPropertyValueCell(value, className + '-' +  elementType + important));
		    row.appendChild(createElement('td'));
		    row.id = name;
		    return row;
		}

		function generateRows(index, elementJSON) {
	    	var rows = [];
	    	if (elementJSON) {
		    	var props = _.keys(elementJSON);
		    	props.sort();
//	    	    console.log('generateRows: props = ' + props + ', props.length = ' + props.length);
	    	    for (var propIndex in props) {
	    	    	var prop = props[propIndex];
	                if (elementJSON.hasOwnProperty(prop)) {
//		    	    	console.log('generateRows: index = ' + propIndex + ', prop ' + prop + ', elementJSON[prop] = ' + elementJSON[prop]);
		                if (propRequiredInReport(prop)) {
		                	var row;
	//                		console.log('generateRows(): changedFields = ' + changedFields );
		                	if (changedFields && _.has(changedFields, prop) ) {
		                		var fieldDiff = changedFields[prop];
	//	                		console.log('generateRows(): got changedFields, index = ' + index + ', prop ' + prop + ', fieldDiff = ' + fieldDiff);
		                		var value;
								if (fieldDiff instanceof Array ) {
	//								console.log('generateRows(): got array, prop = ' + prop + ', diff.length = ' + fieldDiff.length + ', text diff = ' + fieldDiff[0]);
									if ((fieldDiff.length === 3) && (fieldDiff[2] === 2)) {
	//									console.log('generateRows(): prop = ' + prop + ' text diff = ' + fieldDiff[0]);
	//									console.log('generateRows(): prop = ' + prop + ' elementJSON[prop] = ' + elementJSON[prop]);
										value = elementJSON[prop];
									} else {
										var valueIndex = (elementType === 'original' ? 0 : 1);
										value = fieldDiff[valueIndex];
	//									console.log('generateRows: got value, index = ' + index + ', prop ' + prop + ', modified, value = ' + value);
									}
								}

								row = generateElementRow(prop, value, 'jsondiffpatch-modified', '');		                		
			                } else {
				                var important = '';        
				                if (_.contains(importantFields, prop)) {
				                	important = ' jsondiffpatch-important';
				                }
	//		        	    	console.log('generateRows: index = ' + index + ', prop ' + prop + ', unchanged, value = ' + elementJSON[prop]);
					            row = generateElementRow(prop, elementJSON[prop], 'jsondiffpatch-unchanged', important);
			                }
			                rows.push(row);
		                }
	                }
	            }	    		
	    	}
		    return rows;
	    }
		
		function propRequiredInReport(prop) {
			return (prop !== idFieldName) && (prop !== 'Id') && (prop !== 'type') && !(/__AM_Question__c$/.test(prop)) && !(/__Segmentation_Question__c$/.test(prop))
				&& !(/__Quicklink__c$/.test(prop)) && !(/__Plan_Type__c$/.test(prop));
		}

		function render() {
			console.log('render: array element ' + index + ': type = ' + elementType + ', dealmakerId = ' + dealmakerId + ', tableClassName = ' + tableClassName);
			console.log('render: array element create table id ' + id + ': className = ' + tableClassName + ', title = ' + elementName);
	        var objectTable = createTable({id : dealmakerId, className : tableClassName, style : tableStyle, columns : [{name: title, 'width': '50%'}, {name: '', width: '50%'}]});
	    	if (diffType === 'Add') {
				var addBtn = jQuery('<input/>', {'class':'btn', 'id': 'add_' + desc + index, 'type':'button', 'value':'Add', 'style':"float: right;"});
				jQuery(objectTable).find(".jsondiffpatch-object-table-header th:last").append(addBtn).click(function(eventObject){ jQuery('#' + eventObject.target.id).prop('disabled', true).addClass( 'ui-state-disabled' ); insertObject(eventObject); });
			} else if (diffType === 'NotFound') {
				var deleteBtn = jQuery('<input/>', {'class':'btn', 'id': 'delete_' + desc + index, 'type':'button', 'value':'Delete', 'style':"float: right;"});
				jQuery(objectTable).find(".jsondiffpatch-object-table-header th:last").append(deleteBtn).click(function(eventObject){ deleteObject(objectId); });
			}

	        _.each(generateRows(index, elementJSON), function (row) {objectTable.appendChild(row);});
	        return objectTable;
		}
				
		function insertObject(eventObject) {
        	invokeInsertObject(
		            function(responseData) { /* success */ },
		            function() { /* error */ 					
		            	jQuery('#' + eventObject.target.id).prop('disabled', false).removeClass( 'ui-state-disabled' );
		            	jQuery('#errormessage').text("An error occurred try to create a new object"); },
		            function() { /* complete */ }
		        );
		}
        
		function invokeInsertObject(success, error, complete) {
	        var succ = function(data) { try { success(data); } finally { complete(); } };
	        var err = ttg.ajaxErrorFunction(error,complete);
	        var insertSpec = {
	        		type : elementJSON.type, 
	        		parentObjectId : parentObjectId,
	        		parentObjectDealmakerId : parentObjectDealmakerId,
	        		objectJSON : JSON.stringify(_.omit(elementJSON, 'type')), 
	        		originalOrgPrefix : updatedOrgIdPrefix
	        	};
	        console.log('invokeInsertObject(): invokeVFR ' + ttg.vfpclass + controllerName + '.' + insertMethod + ', type = ' + insertSpec.type + ', parentObjectId = ' + insertSpec.parentObjectId + ', parentObjectDealmakerId = ' + insertSpec.parentObjectDealmakerId);
			ttgInvoker.invokeVFR(ttg.getController(ttg.vfpclass + controllerName + '.' + insertMethod), 
				insertSpec, 
	        	function(result, event) { 
					if (event.type === 'exception') { 
	                    ttg.ajaxErrorFunction(error, complete, {
	                    	title : 'Parent object doesn\'t exist',
	        				msg : jQuery('<span>').text(event.message)
	                    })({responseMsg : ''},event);
					} else {
						succ(result); 
					} 
				}, 
			{escape: false});
		}

		function getId() {
			return dealmakerId;
		}

		function deleteObject(objectId) {
//	        console.log('deleteObject(): objectId = ' + objectId);
			redirectToDetailPageAction(objectId);
		}

		function markAsChanged(diff, changeType) {
			if (diffType !== 'Changed') {
				for (var prop in diff) {
					if (_.has(diff, prop)) {
		                if (propRequiredInReport(prop)) {
		        			diffType = 'Changed';
							tableClassName = 'jsondiffpatch-item-table-changed';
							tableStyle = 'display: table;';
		        			changedFields = diff;
		        			if (changeType) {
		        				title += ': ' + changeType;
		        			}
							// console.log('markAsChanged(): prop = ' + prop + ', diff = ' + diff + ', diffType = ' + diffType + ', changeType = ' + changeType + ', title = ' + title);
		        			break;
		                }
					}
				}
			}
		}
		 		 
		function markAsMovedFrom(index) {
			title += ': Candidate to move from #' + (index + 1);
			tableClassName = 'jsondiffpatch-item-table-moved-new';
			tableStyle = 'display: table;';
		}		 

		function markAsMovedTo(index) {
			title += ': Candidate to move to #' + (index + 1);
			tableClassName = 'jsondiffpatch-item-table-moved-original';
			tableStyle = 'display: table;';
		}		 

		function markAsAdded() {
			diffType = 'Add';
			title += ': Candidate for addition';
			tableClassName = 'jsondiffpatch-item-table-added';
			tableStyle = 'display: table;';
		}

		function markAsNotFound() {
			diffType = 'NotFound';
			title += ': Candidate for deletion';
			tableClassName = 'jsondiffpatch-item-table-notfound-original';
			tableStyle = 'display: table;';
		}

		that.render = render;
		that.markAsAdded = markAsAdded;
		that.markAsChanged = markAsChanged;
		that.markAsMovedFrom = markAsMovedFrom;
		that.markAsMovedTo = markAsMovedTo;
		that.markAsNotFound = markAsNotFound;
		that.getId = getId;
		that.getDiffType = getDiffType;
		that.elementJSON = elementJSON;
		return that;
	};
	
	function processDiff() {
        if (diff) {
	        _.each(_.keys(diff), function (prop) { 
	            if (prop !== '_t') {
					var oldIndex;
			        var newIndex;
			        var id;
			        var diffOriginal;
			        var currentDiff = diff[prop];
					// console.log('----> processDiff: prop ' + prop);
					if (prop.slice(0, 1) === '_') {
						diffOriginal = true;
						oldIndex = parseInt(prop.replace( /^\D+/g, ''), 10) ;
						id = oldJSON[oldIndex][idFieldName] || '';
						oldIndex =  typeof idMap[id] === 'undefined' ? 'undefined' : idMap[id].originalIndex;
						newIndex =  typeof idMap[id] === 'undefined' ? 'undefined' : idMap[id].newIndex;
					} else {
						diffOriginal = false;
						id = newJSON[prop][idFieldName] || '';
						oldIndex =  typeof idMap[id] === 'undefined' ? 'undefined' : idMap[id].originalIndex;
						newIndex =  typeof idMap[id] === 'undefined' ? 'undefined' : idMap[id].newIndex;
					}
				    // console.log('----> processDiff: prop ' + prop + ', diffOriginal = '  + diffOriginal + ' id =' + id + ', oldIndex = ' + oldIndex + ', newIndex = ' + newIndex);

					if (currentDiff instanceof Array ) {
						if (currentDiff.length === 1) {
			        		// console.log('----> processDiff: diff item ' + prop + ' added, updating newElement ' + newIndex);
							newElements[newIndex].markAsAdded();
						} else if (currentDiff.length === 2) {
			        		// console.log('----> processDiff: diff item ' + prop + ' modified');
						} else if (currentDiff[2] === 0) {
							// console.log('----> processDiff: diff item ' + prop + ', Not Found, updating originalElement ' + oldIndex);
							originalElements[oldIndex].markAsNotFound();
						} else if (currentDiff[2] === 3) {
							// console.log('----> processDiff: diff item ' + prop + ' moved, updating originalElement ' + oldIndex + ' Moved to newElement' + newIndex + ', currentDiff[1] = ' + currentDiff[1]);
							newIndex = currentDiff[1];
							originalElements[oldIndex].markAsMovedTo(newIndex);
							newElements[newIndex].markAsMovedFrom(oldIndex);
			        	}
					} else {
			         // 	_.each(_.keys(currentDiff), function (field) { 
				        //  	console.log('----> processDiff: diff item ' + prop + ', originalElement ' + oldIndex + ' changed, field updated ' + field + ', value = ' + currentDiff[field]);
				        // });	
			            originalElements[oldIndex].markAsChanged(currentDiff, 'Changed');
			            newElements[newIndex].markAsChanged(currentDiff, 'Changed');
					}
	            }
	        });
        }        
	}
	 
	function getLabel(name) {
		var fieldName = name.replace(originalOrgIdPrefix + '__', '').replace(updatedOrgIdPrefix + '__', '').toLowerCase();
		var label = name;
		if (fieldMap && fieldMap[fieldName]) {
			label = fieldMap[fieldName];
		} else {
		//	console.log('-------> getLabel: did not find mapping for fieldName = ' + fieldName + ', name = ' + name);
		}
		return label;
	}
	
	function createPropertyNameCell(name) {
		var td = createElement('td', 'jsondiffpatch-property-name');	
		td.appendChild(document.createTextNode(getLabel(name)));	
		return td;
	}

	function createPropertyValueCell(value, className) {
        var td = createElement('td', className);
        var jsono = typeof value !== 'undefined' ? JSON.stringify(value) : (value + ' (JSON not found)');
        jsono = jsono.replace(/"/g,'');
//		console.log('createPropertyValueCell: value ' + jsono)        	
		td.appendChild(document.createTextNode(jsono));
		return td;
	}


	function generateMemberRow(name, className, original, modified) {
		var style;
    	var important = '';        
        if (_.contains(importantFields, name)) {
        	important = ' jsondiffpatch-important';
        } else if (className === 'jsondiffpatch-unchanged') {
			style = 'display: none;';
		}
		if (showAllFields) {
			style = 'display: table-row;';
		}
    	var row = createElement('tr',  className + important, style);    	
        row.appendChild(createPropertyNameCell(name));
        if (typeof modified === 'undefined') {
	        row.appendChild(createPropertyValueCell(original, className + '-member-original' + important));
	        row.appendChild(createPropertyValueCell(original, className + '-member-newJSON' + important));
	    } else {
        	row.appendChild(createPropertyValueCell(original, className + '-member-original'));
        	row.appendChild(createPropertyValueCell(modified, className + '-member-newJSON'));
	    }
	    row.id = name;
	    return row;
	}
	
	function processMember(prop, oldJSON, diff, table) {
		// console.log('processMemberChanged: object -> prop = ' + prop);
	    if (diff && _.has(diff, prop)) {
		    // console.log('processMemberChanged: object -> prop = ' + prop + ' modified');
	    	table.appendChild(generateMemberRow(prop, 'jsondiffpatch-modified', diff[prop][0], diff[prop][1]));
	    } else {
		    // console.log('processMemberChanged: object -> prop = ' + prop + ' unchanged');
			table.appendChild(generateMemberRow(prop, 'jsondiffpatch-unchanged', oldJSON[prop]));	    	
	    }
	}
			

	function createElement(type, className, style, id) {
		var elem = document.createElement(type);
		if (typeof className !== 'undefined') {
			elem.setAttribute('class', className);
		}
		if (typeof style !== 'undefined') {
			elem.setAttribute('style', style);
		}
		return elem;
	}
	
	function createTable(spec) {
		var row = createElement('tr', 'jsondiffpatch-object-table-header');
		_.each(spec.columns,  function(column){ 
				var th = createElement('th');
				th.appendChild(document.createTextNode(column.name));
				th.scope = 'col';
				th.width = column.width;
				row.appendChild(th);
			});
		var table = createElement('table', spec.className || 'jsondiffpatch-object-table', spec.style);
		table.appendChild(row);
		table.id = spec.id || '';	
		return table; 
	}

    function processArray() {
    	var index = 0;
        var toInsert = [];
        var removedIndices = [];
        var moveTargets = [];

        for (index = 0; index < oldJSON.length; index++) {
			if (diff && diff['_' + index]) {
				// item removed or moved
                if (diff['_' + index][2] === 3) {
                    toInsert[diff['_' + index][1]] = { prop: '_' + index, from: index };
					// console.log('processArray(): Added insertion for "' + index + '", id = ' + oldJSON[index][idFieldName] + ' MOVED to ' + diff['_' + index][1] + ', Id = ' + newJSON[diff['_' + index][1]][idFieldName] );
            	} else {
                	// console.log('processArray(): old index ' + index + ' REMOVED, Id = ' + oldJSON[index][idFieldName]);
                }
                removedIndices[index] = true;
			} else {
				// console.log('processArray(): old index ' + index + ' NOT moved, Id = ' + oldJSON[index][idFieldName]);
			}
            originalElements.push(elementRenderer({index : index, elementJSON : oldJSON[index], elementType : 'original'}));
            newElements.push(elementRenderer({index : index, elementJSON : oldJSON[index], elementType : 'newJSON'}));
        }

		// console.log('\n\n');
		// traceToInsert(toInsert);
  //       traceElements(originalElements, newElements);

		if (diff) {
		    _.each(_.keys(diff), function (prop) { 
		        if (prop !== '_t') {
		            if (prop.slice(0, 1) !== '_') {
		                index = parseInt(prop, 10);
		                if (diff[prop].length === 3) { // MOVE
			                toInsert[index] = { prop: prop, from: toInsert[index] && toInsert[index].from };
							// console.log('processArray(): Added insertion for MOVE at ' + index + ', from "' +  toInsert[index].from + '", id = ' + diff[prop][0][idFieldName]);
						} else { // INSERT or change
							if (_.isArray(diff[prop])) {
								toInsert[index] = { prop: prop, from: undefined };
								// console.log('processArray(): Added insertion for INSERT at ' + index + ', from "' +  toInsert[index].from + '", id = ' + newJSON[prop][idFieldName]);								
							} else {
								var offset = _.reduce(_.first(removedIndices, index), function(memo, num){ return memo + num; }, 0);
						        newElements.splice(index + offset, 1, elementRenderer({index : index + offset, elementJSON : newJSON[prop], elementType : 'newJSON'}));
								// console.log('processArray(): Updated element for Change at index ' + index + ', offset = ' + offset + ', id = ' + newJSON[prop][idFieldName]);
							}
						}
		            }
		        }
		    });
		}
		// console.log('\n\n');
		// console.log('\n\n');
		// console.log('processArray: removedIndices [' + removedIndices + ']');
		// traceToInsert(toInsert);
  //       traceElements(originalElements, newElements);

        var insertedOffset = 0;
        var indexOffset = 0;
        for (index = 0; index < toInsert.length; index++) {
            if (removedIndices[index]) {
				// console.log('processArray: removing updated element at ' + index  + '+' + indexOffset);
		        newElements.splice(index + indexOffset, 1, elementRenderer({index : index + indexOffset, elementJSON : undefined, elementType : 'original'}));
                indexOffset++;
            }
            var insertion = toInsert[index];
            if (typeof insertion !== 'undefined') {
				// console.log('processArray: inserting for ' + index);
                var prop = insertion.prop;
                var oldIndex = prop;
                if (insertion.from) {
                    oldIndex = insertion.from;
                } else {
                    if (prop.slice(0, 1) === '_') {
                        oldIndex = prop.slice(1);
                    }
                }
                oldIndex = parseInt(oldIndex, 10);
				// console.log('processArray: inserting updated element at ' + index  + '+' + indexOffset + ', oldIndex = ' + oldIndex);
		        originalElements.splice(index + indexOffset, 0, elementRenderer({index : index + indexOffset, elementJSON : undefined, elementType : 'original'}));
		        newElements.splice(index + indexOffset, 0, elementRenderer({index : index, elementJSON : newJSON[index], elementType : 'newJSON'}));
		        insertedOffset++;
		        // updateIdMap(index + indexOffset, idMap);
            }
        }

        for (index = toInsert.length; index < removedIndices.length; index++) {
            if (removedIndices[index]) {
				// console.log('processArray: removing updated element after toInsert processed at ' + index  + '+' + insertedOffset);
		        newElements.splice(index + insertedOffset, 1, elementRenderer({index : index + insertedOffset, elementJSON : undefined, elementType : 'original'}));
            }
		}

		// console.log('\n\n');
        // traceElements(originalElements, newElements);

        for (index = 0; index < originalElements.length; index++) {
        	var id;
        	if ((typeof originalElements[index] !== undefined) && (originalElements[index].getId() !== undefined)) {
        		id = originalElements[index].getId();
        		idMap[id] = idMap[id] || {};
            	idMap[id].originalIndex = index;
        	}
        	if ((typeof newElements[index] !== undefined) && (newElements[index].getId() !== undefined)) {
        		id = newElements[index].getId();
        		idMap[id] = idMap[id] || {};
        		idMap[id].newIndex = index;	
        	}
        }    	

        processDiff();

        var table = tableRenderer();
        for (index = 0; index < originalElements.length; index++) {
           	// console.log('processArray: Adding Row ' + index);
            table.addRow(rowRenderer({index : index, originalValue : originalElements[index], newValue : newElements[index]}));
        }    	

  //        _.each(_.keys(idMap), function (key) { 
  //         	console.log('processArray: idMap key = ' + key + ', original = ' + idMap[key].originalIndex + ', new = ' + idMap[key].newIndex);
  //        });
		// console.log('\n\n');
  //       console.log('processArray: rows ' + rows.length);
		// console.log('\n\n');

		return table;        
    }

    function traceElements(originalElements, newElements) {
        console.log('traceElements(): originalElements.length = '  + originalElements.length + ', newElements.length = '  + newElements.length);
        for (var index = 0; index < originalElements.length; index++) {
        	var originalElementId = (typeof originalElements[index] !== undefined ? originalElements[index].getId() : undefined);
        	var newElementId = (typeof newElements[index] !== undefined ? newElements[index].getId() : undefined);
         	console.log('traceElements: originalElements[' + index + '] = {Id: ' +originalElementId + '}, newElements[' + index + '] = {Id : ' + newElementId + '}');
        }    	
		console.log('\n\n');
    }

    function traceToInsert(toInsert) {
		console.log('traceToInsert: toInsert.length = ' + toInsert.length);
        for (var index = 0; index < toInsert.length; index++) {
        	var prop = (toInsert[index] !== undefined ? toInsert[index].prop : undefined);
        	var from = (toInsert[index] !== undefined ? toInsert[index].from : undefined);
         	console.log('traceToInsert: toInsert[' + index + '] prop = ' + prop + ', from = ' + from);
        }
		console.log('\n\n');
	}

	function propRequiredInReport(prop) {
		return (prop !== idFieldName) && (prop !== 'Id') && (prop !== 'type');
	}

	function  processSingleObjectDiff(){
       	// unchanged props
        if (_.isObject(oldJSON)) {
        	var keys = _.filter(_.keys(oldJSON), function(key) { 
        			return !(key === '_t' || key === idFieldName || key === 'Id');
        		});
            _.each(keys, function(prop) {
            	if (propRequiredInReport(prop)) {
				    processMember(prop, oldJSON, diff, getMainTable());            		
            	}
            });
        }
        return getMainTable();
	}

	function getMainTable() {
		if (!mainTable) {
			mainTable = createTable(tableSpec);
		}
		return mainTable;
	}

	function render() {
		
        if (_.isArray(oldJSON) && _.isArray(newJSON)) {
	        // console.log('render(): processArray: ' + desc);
        	table = processArray();
        	mainTable  = table.render();
        } else if (_.isObject(oldJSON) && _.isObject(newJSON)) {
//	        console.log('render(): processSingleObjectDiff: ' + desc);
        	processSingleObjectDiff();
        } else {
        	throw new TypeError('Different types of JSON were passed for comparision');	
        }
        return getMainTable();
	}

	that.processArray = processArray;
	that.render = render;
	that.elementRenderer = elementRenderer;
	that.rowRenderer = rowRenderer;
	that.getMainTable = getMainTable;
	return that;
};

ttg.objectVisualizer = function(spec) {
	spec.idFieldName = 'DMAPP__DealmakerID__c';
	var name = '';
	if (!_.isUndefined(spec.parentName)) {
		name = spec.parentName + ': ';
	}
	spec.table = {
			id : spec.heading + 's',
			columns : [{name: name + 'Original', 'width': '50%'}, {name: 'Import Version', width: '50%'}],
		};
    var visualizer = ttg.SObjectVisualizer(spec);
	return visualizer.render();
};

ttg.objectDetailsVisualizer = function(spec) {
	spec.idFieldName = 'DMAPP__DealmakerID__c';
	spec.table = {
			id : spec.heading,
			columns : [{name: spec.tableName, 'width': '50%'}, {name: 'Original', width: '25%'}, {name: 'Import Version', width: '25%'}],
		};
    var visualizer = ttg.SObjectVisualizer(spec);
	return visualizer.render();
};