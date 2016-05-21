var _rulesProcessor = 
	{
		_thinkingHTML: '',
		
		ruleSteps: null,
		
		currentRulePartIndex: 1,
		
		currentRulePartType: null,
		
		keyTracker : {},
		
		positionTracker: null,
		
		isNextRulepartCount: false,
		
		isUpcomingRulepartCount: false,
		
		isSameEntityType: false,
		
		rulePartConditionMatched: false,
		
		isJoinrulepart: false,
		
		joinRulePartno: null,
		
		doesNotInclude: true,
		
		ruleAdviceMap: {},
		
		executionNo: 0,
		
		logger: '',
		
		processRules: function(oppViewData, ruleData)
		{
			//_rulesProcessor.logMessage(JSON.stringify(oppViewData, null, '\t'));
			this.keyTracker = {};
			_rulesProcessor.ruleAdviceMap = {};
			this.executionNo=0;
			var o = ruleData.coachrules.coachrule;
			if(typeof o=='object' && _rulesProcessor.isArray(o)){
				for (var prop in o) {
					if (typeof o[prop] == "object"){
						_rulesProcessor.processRuleParts(oppViewData, o[prop]);
					}
				}
			}
			else if(typeof o=='object' && !_rulesProcessor.isArray(o)){
				_rulesProcessor.processRuleParts(oppViewData, o);
			}				
			
			if (!_rulesProcessor.hasConsole()) {
				var adviceObj = {};
				adviceObj.advice = this.logger;
				_rulesProcessor.ruleAdviceMap['logs'] = adviceObj;
			}
			
			return _rulesProcessor.ruleAdviceMap;
			
			
		}
		,
		
		processRuleParts: function(oppViewData, rule)
		{
			
			var oppViewDataCopy = _rulesProcessor.clone(oppViewData);
			var rulepart = rule.coachruleparts.coachrulepart;
			//if((rule.executionorder>29 && rule.executionorder<31) && rule.executionorder!=15){
			if(rule.executionorder!=15){
			//_rulesProcessor.logMessage('RULE NUMBER IS '+ rule.executionorder);
			var upcomingRulepartCountArray = [];
			if(typeof rulepart=='object' && _rulesProcessor.isArray(rulepart)){
				// Check to see if any upcoming ruleparts is a count rulepart that is counting current ruleparts entities
				this.isUpcomingRulepartCount = false;
				for(rulePartIndex=0; rulePartIndex<rulepart.length; rulePartIndex++){
					
					// Check to see if the next rulepart is a count rulepart. Also check if it is of same entity type
					this.isNextRulepartCount = false;
					this.isSameEntityType = false;
					if(rulePartIndex < rulepart.length-1){
						var nextRulePart = rulepart[rulePartIndex+1].rulepart;
						if(nextRulePart.indexOf('.count')!=-1){
							
							this.isNextRulepartCount = rulepart[rulePartIndex].rulepart.indexOf(nextRulePart.substring(0, nextRulePart.indexOf('.count')))!=-1;
						}	
						//var rulePartCountPrefix = nextRulePart.substring(0, nextRulePart.indexOf('.count'));
						
						var thisRulePartAsArray = rulepart[rulePartIndex].rulepart.split('.');
						var thisEntityRulepart='';
						// Build entity part of rulepart
						for(var thisRulePartAsArrayIndex=0; thisRulePartAsArrayIndex < thisRulePartAsArray.length-2; thisRulePartAsArrayIndex++){
							thisEntityRulepart+=thisRulePartAsArray[thisRulePartAsArrayIndex]+'.';
						}
						
						var nextRulePartAsArray = nextRulePart.split('.');
						var nextEntityRulepart='';
						// Build entity part of rulepart
						for(var nextRulePartAsArrayIndex=0; nextRulePartAsArrayIndex < nextRulePartAsArray.length-2; nextRulePartAsArrayIndex++){
							nextEntityRulepart+=nextRulePartAsArray[nextRulePartAsArrayIndex]+'.';
						}
						
						if(nextEntityRulepart==thisEntityRulepart){
							this.isSameEntityType = true;
						}
						
					}
					for(var upcomingRulepartIndex = rulePartIndex+1; upcomingRulepartIndex<rulepart.length; upcomingRulepartIndex++){
						var upcomingRulePart = rulepart[upcomingRulepartIndex].rulepart;
						//console.log(upcomingRulePart+' rulepart.length '+rulepart.length+' rulePartIndex '+rulePartIndex+' upcomingRulepartIndex '+upcomingRulepartIndex);
						var rulePartCountPrefix = upcomingRulePart.substring(0, upcomingRulePart.indexOf('.count'));
						if(upcomingRulePart.indexOf('.count')!=-1 && rulepart[rulePartIndex].rulepart.indexOf(rulePartCountPrefix)!=-1){
							if(upcomingRulepartCountArray.length>0){
								var found = false;
								for(var upcomingRulepartCountArrayIndex=0; upcomingRulepartCountArrayIndex < upcomingRulepartCountArray.length; upcomingRulepartCountArrayIndex++){
									//console.log(upcomingRulepartCountArray[upcomingRulepartCountArrayIndex]+' === '+upcomingRulePart);
									if(upcomingRulepartCountArray[upcomingRulepartCountArrayIndex]==upcomingRulePart){
										found=true;
										break;
									}
								}
								if(!found){
									// Add it to array
									upcomingRulepartCountArray.push(upcomingRulePart);
								}
							}
							else{
								// Add it to array
								upcomingRulepartCountArray.push(upcomingRulePart);
							}
							
							//var rulePartCountSuffix = upcomingRulePart.substring(0, upcomingRulePart.indexOf('.count'));
							//console.log('rulePartCountSuffix '+rulePartCountSuffix+' '+rulepart[rulePartIndex].rulepart);
							
							//this.isUpcomingRulepartCount = rulepart[rulePartIndex].rulepart.indexOf(rulePartCountSuffix)!=-1;
							
							
						}							
					}	
					
					for(var upcomingRulepartCountArrayIndex=0; upcomingRulepartCountArrayIndex < upcomingRulepartCountArray.length; upcomingRulepartCountArrayIndex++){
						if(upcomingRulepartCountArray[upcomingRulepartCountArrayIndex] == rulepart[rulePartIndex].rulepart){
							upcomingRulepartCountArray.splice(upcomingRulepartCountArrayIndex, 1);
						}
					}
					
					if(upcomingRulepartCountArray.length>0){
						this.isUpcomingRulepartCount = true;
					}else{
						this.isUpcomingRulepartCount = false;
					}
					// Check if next rulepart is the same entity type as at least 1 of the cont ruleparts
					if(rulePartIndex < rulepart.length-1){					
																	
						var thisRulePartAsArray = rulepart[rulePartIndex].rulepart.split('.');
						var thisEntityRulepart='';
						// Build entity part of rulepart
						for(var thisRulePartAsArrayIndex=0; thisRulePartAsArrayIndex < thisRulePartAsArray.length-2; thisRulePartAsArrayIndex++){
							thisEntityRulepart+=thisRulePartAsArray[thisRulePartAsArrayIndex]+'.';
						}
						
						for(var upcomingRulepartCountArrayIndex=0; upcomingRulepartCountArrayIndex < upcomingRulepartCountArray.length; upcomingRulepartCountArrayIndex++){
							
							var countRulePartAsArray = upcomingRulepartCountArray[upcomingRulepartCountArrayIndex].split('.');
							var countEntityRulepart='';
							// Build entity part of rulepart
							for(var countRulePartAsArrayIndex=0; countRulePartAsArrayIndex < countRulePartAsArray.length-2; countRulePartAsArrayIndex++){
								countEntityRulepart+=countRulePartAsArray[countRulePartAsArrayIndex]+'.';
							}
							
							if(thisEntityRulepart==countEntityRulepart){
								this.isSameEntityType = true;
								break;
							}
						}						
					}
					
					
					this.currentRulePartIndex=rulePartIndex+1;
					// Add placeholder for each rulepart
					this.keyTracker[this.currentRulePartIndex-1]={};
					_rulesProcessor.processRulePart(rulepart[rulePartIndex], oppViewDataCopy);
					
					if(rulePartIndex==rulepart.length-1){
						if(this.rulePartConditionMatched){
							//_rulesProcessor.logMessage('RULE '+rule.executionorder+' >>>>>>> PASS');
							this.executionNo++;
							var adviceObj = {};
							adviceObj.advice = rule.ruleadvice;
							adviceObj.executionorder = rule.executionorder;
							adviceObj.remainingOppData = oppViewDataCopy;
							_rulesProcessor.ruleAdviceMap['cr_' +rule.id] = adviceObj;
						}
						else{
							//_rulesProcessor.logMessage('RULE '+rule.executionorder+' >>>>>>> FAIL');
						}
					}
				}
			}
			else if(typeof rulepart=='object' && !_rulesProcessor.isArray(rulepart)){
				this.currentRulePartIndex=1;
				// Add placeholder for each rulepart
				this.keyTracker[this.currentRulePartIndex-1]={};
				_rulesProcessor.processRulePart(rulepart, oppViewDataCopy);
				if(this.rulePartConditionMatched){
					//_rulesProcessor.logMessage('RULE '+rule.executionorder+' >>>>>>> PASS');
					var adviceObj = {};
					adviceObj.advice = rule.ruleadvice;
					adviceObj.executionorder = rule.executionorder;
					adviceObj.remainingOppData = oppViewDataCopy;
					_rulesProcessor.ruleAdviceMap['cr_' +rule.id] = adviceObj;
				}
				else{
					//_rulesProcessor.logMessage('RULE '+rule.executionorder+' >>>>>>> FAIL');
				}
			}
			}
		}
		,
		
		processRulePart: function(rulepart, oppViewDataCopy)
		{
			this.isJoinrulepart=false;
			this.doesNotInclude=true;
			var rulepartvalue = rulepart.rulepart;
			this.currentRulePartType = rulepart.primitivetype;
			this.joinRulePartno = rulepart.joinrulepartno;
			if(this.joinRulePartno!=-1){
				this.isJoinrulepart=true;
			}

			//_rulesProcessor.logMessage(rulepartvalue);
			if(this.currentRulePartIndex == 1 || this.rulePartConditionMatched){
				this.rulePartConditionMatched = false;
				this.ruleSteps = rulepartvalue.split('.');
				this.positionTracker=new Array();
				_rulesProcessor.traverseDataView(oppViewDataCopy, '', 0);
				//_rulesProcessor.logMessage('TTTTTTTTTTT '+JSON.stringify(oppViewDataCopy, null, '\t'));
			}
			
		}
		,
		
		traverseDataView: function(o, rootOfBranch, depth)
		{
			var foundElement=false;
			for (var prop in o) {
				// If we find ruleSteps index at this level, then we want to walk down that tree branch by taking each index in the array and tring to find it
				if(this.ruleSteps[0]==prop){
					//_rulesProcessor.logMessage(this.ruleSteps[0]+'=='+prop + ' type '+typeof o[prop]);
					_rulesProcessor.traverseDataBranch(o, 0, o, prop);
					if(!foundElement){
						foundElement=true;
						break;
					}
				}
				// Otherwise, keep searching
				else if (typeof o[prop] == "object") {
					var firstElFound = _rulesProcessor.traverseDataView(o[prop], prop, depth+1);
					if(firstElFound){
						foundElement=true;
						break;
					}
				} 
			}	
			
			//_rulesProcessor.logMessage('depth '+depth+' foundElement '+foundElement+', '+this.ruleSteps[this.ruleSteps.length-1]+', '+' isUpcomingRulepartCount '+this.isUpcomingRulepartCount+', isNextRulepartCount '+this.isNextRulepartCount+', '+this.ruleSteps[this.ruleSteps.length-1]);
			// If we can't find the element and we are done searching and we are trying to find out the count, then we know the count is 0
			if(depth==0 && !foundElement && (this.ruleSteps[this.ruleSteps.length-2].indexOf('count')!=-1 || this.isUpcomingRulepartCount)){
				if((this.isNextRulepartCount  && this.isSameEntityType) || (this.isUpcomingRulepartCount && this.isSameEntityType)){
					this.rulePartConditionMatched = true;
				}else{	
					var fireRule = _rulesProcessor.assertRule(this.ruleSteps[this.ruleSteps.length-1], 0, null);
					if(fireRule && !this.rulePartConditionMatched){
						this.rulePartConditionMatched = true;
						foundElement=false;
					}
				}
			}
			return foundElement;
		}
		,
		
		traverseDataBranch: function(currentLeaf, dotNotatedIndex, rootOfBranch, currentLeafsParent)
		{
			if(currentLeaf == null) return;
		
			for (i=dotNotatedIndex; i< this.ruleSteps.length-1; i++) {
				var childProperty = this.ruleSteps[i];
				var ruletypeIsCount=false;
				if((this.ruleSteps.length-1)-(dotNotatedIndex+1)==1 && this.ruleSteps[dotNotatedIndex+1]=='count'){
					ruletypeIsCount = true;
				}
				//_rulesProcessor.logMessage(childProperty+' '+typeof currentLeaf[childProperty]);
				if(typeof currentLeaf[childProperty] != 'undefined' && currentLeaf[childProperty] != null){
					//console.log(childProperty+' adding to '+this.positionTracker+' currentLeafsParent is '+currentLeafsParent +' type '+typeof currentLeaf[childProperty]);
					this.positionTracker.push(childProperty);
					
					if (typeof currentLeaf[childProperty] == "object") {
						// If array, loop through array indexes
						if(_rulesProcessor.isArray(currentLeaf[childProperty])){
							currentLeaf = currentLeaf[childProperty];
							// Add an empty array to relevant keyTracker rulepart
							var relevantRulepart = this.keyTracker[this.currentRulePartIndex-1];
							relevantRulepart[childProperty] = [];
							
							for (var currentArrayIndexObj in currentLeaf) {
								if(typeof currentLeaf[currentArrayIndexObj] != 'undefined' && typeof currentLeaf[currentArrayIndexObj] == "object" && currentLeaf[currentArrayIndexObj] != null && this.doesNotInclude){
									this.positionTracker.push(childProperty+'.'+currentArrayIndexObj);
									
									// If the next index is the 2nd last index of the rulepart array and it is equal to count, then we want to count the indexes left in the data view,
									// otherwise continue walking the branch using the next index of the rulepart array
									if(!ruletypeIsCount){
										//console.log(childProperty+'.'+currentArrayIndexObj+ ' XXXXXXXXXX '+JSON.stringify(currentLeaf[currentArrayIndexObj], null, '\t'));
										
										if(this.isJoinrulepart){
											var rulepartRef = this.keyTracker[this.joinRulePartno];
											var arrayOfKeys = rulepartRef[childProperty];
											if(_rulesProcessor.isArray(arrayOfKeys)){
												var matchFound = _rulesProcessor.executeJoinrulepart(arrayOfKeys, currentLeaf[currentArrayIndexObj].id);
												
												if(matchFound){
													_rulesProcessor.traverseDataBranch(currentLeaf[currentArrayIndexObj], dotNotatedIndex+1, rootOfBranch, childProperty+'.'+currentArrayIndexObj);
												}else{
													_rulesProcessor.updatepositionTrackerAndDeleteProp(rootOfBranch, 0, childProperty+'.'+currentArrayIndexObj, false);
													this.rulePartConditionMatched = false;
												}
											}else{
												_rulesProcessor.traverseDataBranch(currentLeaf[currentArrayIndexObj], dotNotatedIndex+1, rootOfBranch, childProperty+'.'+currentArrayIndexObj);	
											}
										}else{
											_rulesProcessor.traverseDataBranch(currentLeaf[currentArrayIndexObj], dotNotatedIndex+1, rootOfBranch, childProperty+'.'+currentArrayIndexObj);	
										}
											
										// Build up a obj that stores all id's for this array if rule fires
										if(this.rulePartConditionMatched && typeof currentLeaf[currentArrayIndexObj] != 'undefined' && typeof currentLeaf[currentArrayIndexObj] == "object" && currentLeaf[currentArrayIndexObj] != null){
											var rulepartObj = this.keyTracker[this.currentRulePartIndex-1];
											var currentObj = rulepartObj[childProperty];
											currentObj.push(currentLeaf[currentArrayIndexObj].id);
										}
										
										if((this.ruleSteps.length-1)-(dotNotatedIndex+1)==1 && this.ruleSteps[this.ruleSteps.length-1].indexOf('doesnotinclude')!=-1 && this.rulePartConditionMatched == false){
											this.doesNotInclude = false;
											break;
										}else if(!this.isNextRulepartCount && (this.ruleSteps[this.ruleSteps.length-1].indexOf('notequals')==-1 && this.ruleSteps[this.ruleSteps.length-1].indexOf('isnotoneof')==-1) && this.doesNotInclude){
											this.rulePartConditionMatched = true;
										}
									}
									
									// This function tracks where we are in the data tree and removes properties from the tree that do not fulfill the rulepart 
									_rulesProcessor.updatepositionTrackerAndDeleteProp(rootOfBranch, 0, childProperty+'.'+currentArrayIndexObj, null);
									
								}
								
							}					
							
							if(this.doesNotInclude){
								// Count the number of properties or children left below current position in the tree 
								var propertyCounter=0;
								for (var currentArrayIndexObj in currentLeaf) {
									if(typeof currentLeaf[currentArrayIndexObj] != 'undefined' && typeof currentLeaf[currentArrayIndexObj] == "object" && currentLeaf[currentArrayIndexObj] != null){
										propertyCounter++;
									}
								}
							
								//console.log('propertyCounter is at '+propertyCounter+' for '+JSON.stringify(currentLeaf, null, '\t')+' childProperty '+childProperty);
								// If the rulepart is a 'count' rulepart
								if(ruletypeIsCount){
									var fireRule = _rulesProcessor.assertRule(this.ruleSteps[dotNotatedIndex+2], propertyCounter);
									
									//console.log('fireRule '+fireRule);
									if(fireRule && !this.rulePartConditionMatched){
										this.rulePartConditionMatched = true;
									}
									
								}else if(this.isNextRulepartCount){
									this.rulePartConditionMatched = true;
								}
							
								// We can base whether the rulePartConditionMatched has been met off the number of elements left in the array 
								if(!ruletypeIsCount && !this.isNextRulepartCount){
									if(propertyCounter==0){
										if(this.ruleSteps[this.ruleSteps.length-1].indexOf('notequals')!=-1 || this.ruleSteps[this.ruleSteps.length-1].indexOf('isnotoneof')!=-1){
											/* Commenting out for now as causing probs in opp 2 for rule DR36: Attack strategy with no Compelling Event */
											//this.rulePartConditionMatched = true;
										}else if(this.isUpcomingRulepartCount && this.isSameEntityType){
											this.rulePartConditionMatched = true;
										}else{
											this.rulePartConditionMatched = false;
										}
									}else{
										if((this.ruleSteps.length-1)-(dotNotatedIndex+1)==1 && this.ruleSteps[this.ruleSteps.length-1].indexOf('doesnotinclude')==-1){
											this.rulePartConditionMatched = true;
										}
									}
								}
							
								//_rulesProcessor.logMessage('propertyCounter '+propertyCounter);
								// If there are no props left at this level, then the currentLeafsParent of this prop should also be deleted
								if(propertyCounter==0){
									//console.log('currentLeafsParent '+currentLeafsParent);
									_rulesProcessor.updatepositionTrackerAndDeleteProp(rootOfBranch, 0, currentLeafsParent, false);
									if(ruletypeIsCount){
										//this.rulePartConditionMatched = true;
									}
								}
								break;
							}
									
						}else{
							if(this.isJoinrulepart){
								var rulepartRef = this.keyTracker[this.joinRulePartno];
								var arrayOfKeys = rulepartRef[childProperty];
								if(_rulesProcessor.isArray(arrayOfKeys)){
									var matchFound = _rulesProcessor.executeJoinrulepart(arrayOfKeys, currentLeaf[childProperty].id);
								
									if(matchFound){
										_rulesProcessor.traverseDataBranch(currentLeaf[childProperty], dotNotatedIndex+1, rootOfBranch, currentLeafsParent);	
									}else{
										_rulesProcessor.updatepositionTrackerAndDeleteProp(rootOfBranch, 0, currentLeafsParent, false);
										this.rulePartConditionMatched = false;
									}
								}else{
									_rulesProcessor.traverseDataBranch(currentLeaf[childProperty], dotNotatedIndex+1, rootOfBranch, currentLeafsParent);	
								}
							
							}else{
								if(ruletypeIsCount){
									// If the rulepart is a count and type is object, but not array, then we know that the number of objects at this time is 1
									var fireRule = _rulesProcessor.assertRule(this.ruleSteps[this.ruleSteps.length-1], 1);
									if(fireRule && !this.rulePartConditionMatched){
										this.rulePartConditionMatched = true;
									}
								}else if(this.isUpcomingRulepartCount && this.isSameEntityType){
									_rulesProcessor.traverseDataBranch(currentLeaf[childProperty], dotNotatedIndex+1, rootOfBranch, currentLeafsParent);
									this.rulePartConditionMatched = true;
								}else{
									_rulesProcessor.traverseDataBranch(currentLeaf[childProperty], dotNotatedIndex+1, rootOfBranch, currentLeafsParent);
								}
							}							
							
							// Build up a obj that stores all id's for this array if rule fires
							if(this.rulePartConditionMatched && currentLeaf[childProperty] != null && typeof currentLeaf[childProperty] != 'undefined' && typeof currentLeaf[childProperty] == "object"){
								if(currentLeaf[childProperty] != null) {
									if(typeof currentLeaf[childProperty].id != 'undefined'){
										var rulepartObj = this.keyTracker[this.currentRulePartIndex-1];
										rulepartObj[childProperty] = [];
										var currentObj = rulepartObj[childProperty];
										currentObj.push(currentLeaf[childProperty].id);
									}
								}
							}
							break;
						}
						
					}else if(typeof currentLeaf[childProperty] == "string" || typeof currentLeaf[childProperty] == "number" || typeof currentLeaf[childProperty] == "boolean"){
						//Possibility that we can get into this condition as a type string if we have an empty complex element e.g. <coachopportunitiesview><coachopportunityview>***<competitors/>***</coachopportunityview></coachopportunitiesview>
						// We need to check that we are on the last index relevant to the viewdata i.e. opp.amount or contacts.contact.buyerroles.buyerrole
						// If so we can carry on
						if(dotNotatedIndex == (this.ruleSteps.length-2)){
							i++;
							var fireRule = _rulesProcessor.assertRule(this.ruleSteps[i], currentLeaf[childProperty]);
							//_rulesProcessor.logMessage('fireRule '+fireRule+' '+(currentLeaf[childProperty])+' '+this.positionTracker+' currentLeafsParent '+currentLeafsParent);
							_rulesProcessor.updatepositionTrackerAndDeleteProp(rootOfBranch, 0, currentLeafsParent, fireRule);
							this.rulePartConditionMatched = fireRule;
							
							// In the edge case like rule 9 when there is only 1 contact in org chart, but the last rulepart needs to be checked, so this forces us to the last rulepart
							if(this.isNextRulepartCount || (this.isUpcomingRulepartCount && this.isSameEntityType)){
								this.rulePartConditionMatched = true;
							}
							//********** Commented back in as we want to stop searching object when we find the primitive i.e. 'contacts.contact.politicalstatus.equals(1)'. When
							// 'politicalstatus' is found in the contact object we do not want to continue searching it
							break;
						}else if(dotNotatedIndex < (this.ruleSteps.length-2)){
							if(this.ruleSteps[this.ruleSteps.length-2].indexOf('count')!=-1){
								// If the dotNotatedIndex is less than this.ruleSteps.length-2, then we have an empty element as described above
								// If the rulepart is also a count rulepart ten we can assume that the count on this element is 0.
								var fireRule = _rulesProcessor.assertRule(this.ruleSteps[this.ruleSteps.length-1], 0);
								this.rulePartConditionMatched = fireRule;
							}
							else if(this.isNextRulepartCount || (this.isUpcomingRulepartCount && this.isSameEntityType)){
								this.rulePartConditionMatched = true;
							}
							
							
						}
											
					}
				}else{
					if(ruletypeIsCount){
						var fireRule = _rulesProcessor.assertRule(this.ruleSteps[this.ruleSteps.length-1], 0);
						if(fireRule && !this.rulePartConditionMatched){
							this.rulePartConditionMatched = true;
						}
					}else if(dotNotatedIndex == (this.ruleSteps.length-2) && (this.ruleSteps[this.ruleSteps.length-1].indexOf('notequals')!=-1 || this.ruleSteps[this.ruleSteps.length-1].indexOf('isnotoneof')!=-1)){
						this.rulePartConditionMatched = true;
					}else if(this.isNextRulepartCount || this.isUpcomingRulepartCount){
						this.rulePartConditionMatched = true;
					}
					//console.log('XXXXXXXXXXXX '+currentLeafsParent+' XX '+childProperty+' rootOfBranch '+rootOfBranch+' positionTracker '+this.positionTracker+' dotNotatedIndex '+dotNotatedIndex+' ruleSteps '+this.ruleSteps);
					_rulesProcessor.updatepositionTrackerAndDeleteProp(rootOfBranch, 0, currentLeafsParent, false);
					break;
				}
			}
		}
		,
		
		updatepositionTrackerAndDeleteProp: function(rootOfBranch, positionTrackerIndex, currentLeafsParent, fireRule){
			for (i=positionTrackerIndex; i< this.positionTracker.length; i++) {
				var value = this.positionTracker[i];
				// If the array value has a '.' in it, then we need to just use the right hand side of the '.' for the match on the typeof
				if(value.indexOf('.')!=-1){
					value = value.substring(value.indexOf('.')+1, value.length);
				}
				
				if(typeof rootOfBranch[value] != 'undefined' && rootOfBranch[value] != null){
					// If the array value has a '.' in it, then we need to switch back to orig value so as to match up with currentLeafsParent
					if(this.positionTracker[i].indexOf('.')!=-1){
						value = this.positionTracker[i];
					}				
					//console.log(value + '==' + currentLeafsParent);
					if(value == currentLeafsParent){
						//console.log('value '+value+' positionTracker '+positionTracker+' positionTrackerIndex '+positionTrackerIndex+' currentLeafsParent '+' fireRule '+fireRule+' '+value+' == '+currentLeafsParent);	
						// Remove every index following
						var index = i;
						var numindexestodelete = this.positionTracker.length - index;
						this.positionTracker.splice(index, numindexestodelete);
						if(fireRule==false){
							// If the array value has a '.' in it, then we need to just use the right hand side of the '.' for the match on the typeof
							if(value.indexOf('.')!=-1){
								value = value.substring(value.indexOf('.')+1, value.length);
							}
							delete rootOfBranch[value];
						}
					}
					else{
						// If the array value has a '.' in it, then we need to just use the right hand side of the '.' for the match on the typeof
						if(value.indexOf('.')!=-1){
							value = value.substring(value.indexOf('.')+1, value.length);
						}
						_rulesProcessor.updatepositionTrackerAndDeleteProp(rootOfBranch[value], positionTrackerIndex+1, currentLeafsParent, fireRule);
					}
				}
			}
		}
		, 
		
		assertRule: function(rulevalues, actualvalue) {
			operators = {
				lessthan : '<',
				greaterthan : '>',
				higherthan : '<',
				equals : '==',
				notequals : '!=',
				contains : 'indexOf',
				isoneof: 'isOneOf',
				isnotoneof: 'isNotOneOf',
				doesnotinclude: '!='
			}
			
			/* If rulevalues is a string, then make sure actual value is also a string */
			if(rulevalues.indexOf('(\'')!=-1){
				actualvalue = '\''+actualvalue+'\'';
			}
					
			var ruleval = rulevalues.substring(rulevalues.indexOf('(')+1, rulevalues.indexOf(')'));
			
			/* Check if rulevalue is a list of values or just 1*/
			var rulevalue = ruleval.split('|');
			var operator = operators[rulevalues.substring(0, rulevalues.indexOf('('))];
			var assertionMet = false;
			//console.log('before: '+rulevalues+' operator '+operator+' type '+typeof actualvalue);
			for(x=0; x < rulevalue.length; x++){
				
				// If its a date type
				if(this.currentRulePartType!='undefined' && this.currentRulePartType==10){
					//_rulesProcessor.logMessage('TYYYYYYYYPE '+this.currentRulePartType+' actualvalue '+actualvalue+' getRuleValueDate '+_rulesProcessor.getRuleValueDate(ruleval));
					var actualvaluedate = _rulesProcessor.parseDate(actualvalue);
					var rulevaldate = _rulesProcessor.parseDate(_rulesProcessor.getRuleValueDate(ruleval));
					var evaluation=actualvaluedate + operator + rulevaldate;
					//_rulesProcessor.logMessage('evaluation '+evaluation);
					/* Logic required to handle lists of 'equal' and 'not equal' conditions */
					if(eval(evaluation)){
						assertionMet = true;
					}else{
						assertionMet = false;
					}
				}else{
					if(operator=='indexOf' || operator=='notIndexOf'){
						if(typeof actualvalue=='number'){
							//_rulesProcessor.logMessage('evaluation '+actualvalue+'=='+rulevalue[x]);
							if(operator=='indexOf' && actualvalue==rulevalue[x]){
								assertionMet = true;
								break;
							}else if(operator=='notIndexOf'){
								if(actualvalue == rulevalue[x]){
									assertionMet = true;
									break;
								}else{
									assertionMet = false;
								}							
							}
						}else if(typeof actualvalue=='string'){
							//_rulesProcessor.logMessage(actualvalue.toLowerCase()+'.indexOf('+rulevalue[x]+')!=-1');
							if(operator=='indexOf' && actualvalue.toLowerCase().indexOf(rulevalue[x].toLowerCase())!=-1){
								assertionMet = true;
								break;
							}else if(operator=='notIndexOf'){
								if(actualvalue.toLowerCase().indexOf(rulevalue[x].toLowerCase())==-1){
									//assertionMet = false;
									assertionMet = true;
								}else{
									//assertionMet = true;
									assertionMet = false;
									break;
								}
							}
						}
					}
					else{
						if(typeof actualvalue=='string'){
							/* Logic required to handle lists of 'equal' and 'not equal' conditions */
							if(operator=='==' || operator=='isOneOf'){
								//_rulesProcessor.logMessage('evaluation '+actualvalue+'=='+rulevalue[x].toLowerCase());
								if(actualvalue.toLowerCase()==rulevalue[x].toLowerCase()){
									assertionMet = true;
									if(operator=='isOneOf'){
										break;
									}
								}else{
									assertionMet = false;
								}
								
							}else if(operator=='!=' || operator=='isNotOneOf'){
								//_rulesProcessor.logMessage(actualvalue.toLowerCase()+'!='+rulevalue[x].toLowerCase());
								//assertionMet = true;
								if(actualvalue.toLowerCase()!=rulevalue[x].toLowerCase()){
									assertionMet = true;
									//assertionMet = false;
								}else{
									assertionMet = false;
									//assertionMet = true;
									if(operator=='isNotOneOf'){
										break;
									}
								}
							}
						}
						else if(typeof actualvalue=='number' || typeof actualvalue=='boolean'){
							var operatorVal = operator;
							if(operator=='isOneOf'){
								operatorVal = '==';
							}else if(operator=='isNotOneOf'){
								operatorVal = '!=';
							}
							var evaluation=actualvalue + operatorVal + rulevalue[x].toLowerCase();
							//_rulesProcessor.logMessage('evaluation '+evaluation);
							/* Logic required to handle lists of 'equal' and 'not equal' conditions */
							if(eval(evaluation)){
								assertionMet = true;
								if(operator=='isOneOf'){
									break;
								}
							}else{
								assertionMet = false;
								if(operator=='isNotOneOf'){
									break;
								}
							}
						}
					}
				}
					
			}
			return assertionMet;
		}
		,
		
		executeJoinrulepart: function(arrayOfKeys, currentLeavesId){
			var matchFound=false;
			for (var indexValue in arrayOfKeys) {
				if(typeof arrayOfKeys[indexValue] != "function"){
					if(arrayOfKeys[indexValue]==currentLeavesId){
						matchFound=true;
						break;
					}													
				}
			}
			if(matchFound){
				return true;
			}else{
				return false;
			}
			
		}
		,
		
		clone: function(obj)
		{
			if(obj == null || typeof(obj) != 'object')
				return obj;

			var temp = obj.constructor(); // changed

			for(var key in obj)
				temp[key] = _rulesProcessor.clone(obj[key]);
			return temp;
		}
		,
		isArray: function(what) {
			return Object.prototype.toString.call(what) === '[object Array]';
		}
		,
		parseDate: function(d) {
			return (
	            d.constructor === Date ? Date.parse(d) :
	            d.constructor === Array ? Date.parse(new Date(d[0],d[1],d[2])) :
	            d.constructor === Number ? Date.parse(new Date(d)) :
	            d.constructor === String ? Date.parse(d) :
	            typeof d === "object" ? Date.parse(new Date(d.year,d.month,d.date)) :
	            NaN
	        );
		},
		getRuleValueDate: function(numberOfDays) {
			var dateObj = new Date();
			if(numberOfDays>0){
				var newtimems=dateObj.getTime()+(numberOfDays*24*60*60*1000);
				dateObj.setTime(newtimems);
			}
			return dateObj;
		},
		logMessage: function(msg){
			if (!_rulesProcessor.hasConsole()) {
				this.logger += msg+'\n';
			}else{
				console.log(msg);
			}

		},
		hasConsole: function(){
			if (typeof console == "undefined") {
				return false;
			}else{
				return true;
			}
		}
	}