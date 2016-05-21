	ttg.am = ttg.am || { } 

	ttg.am.configuration = function(spec) {

		var that = {};
		that.spec = spec;
		
		var dlg, editUnitDlg;
		var userId = spec.userId || '';
		var title = spec.title || '';
		var planId = spec.planId;
		var ttgApi = spec.ttgApi; 
		var spinnerURL = spec.spinnerURL || '';
		var calendarURL = spec.calendarURL || ''
		var showSolutionFamilies = spec.showSolutionFamilies;
		var showAutoPostOption = spec.showAutoPostOption;
		var uniqueId = 1;
		var spinner;
		var readonly = spec.readonly;
		var candelete = spec.candelete;
		var inactive = spec.inactive;
		var isnewplan = spec.isnewplan;
		var clone = spec.clone;
		var onSave = spec.onSave;
		var onDelete = spec.onDelete;
		var onClone = spec.onClone;
		var onCancel = spec.onCancel;
		var defaultAccountId = spec.accountId || '';
		var defaultAccountName = spec.accountName || '';
		var useAccountGrouping = spec.useAccountGrouping;
		var dateFormat = 'yy-mm-dd';
		var MAX_REVENUE_TARGETS = 50;
		var MAX_MEMBER_ACCOUNTS = 300;
		var maxRevenueTargetReached = 'You cannot have more than ' + MAX_REVENUE_TARGETS + ' revenue targets per plan';
		var revenueTargetsChanged = 'Plan dates have changed, review yearly targets';
		var revenueTargetsChangedWarning = 'You have not set revenue targets for this plan. Hit Cancel to return to Plan Settings or hit Save to continue';
		var nonNumericRevenueTarget = 'Revenue targets must be numeric values';
		var cannotDeleteAccountMember = 'You cannot delete this account from this group. There are opportunities in the map that belong to this account';
		var revenueTargetBelowLimit = 'Revenue targets must be positive numbers';
		var revenueTargetAboveLimit = 'Targets cannot exceed 999,999,999,999';
		
		var single_acc_name;
		var single_acc_id;

        var iPad = ttg.isTouchScreen(); //navigator.userAgent.match(/iPad/i) != null;
		var isClone = false;
		
		var cfgdata;
		
		var isoCode = spec.isoCode;
		
		var accountFields;
		
		var unitSearchSpec = jQuery.extend({}, spec);
		unitSearchSpec.autosearch = false;
		unitSearchSpec.lookup = { callback: function() { /*dlg.find('#ADDUNIT').trigger('click')*/	} }
		unitSearchSpec.lookupPostDisplay = function(evt, dlg) { };
		unitSearchSpec.lookup = { 
			callback: function(selectedAccount) {
				setUnitNameField(selectedAccount.Name);
			}
		};		
		unitSearchSpec.orderedFields = ['Name', 'Owner.Name'];
		unitSearchSpec.isoCode = isoCode;
		var unitMetadataControl = ttg.metadata(unitSearchSpec);

		var addedMembers = [];
		
		var unitsById = {};
		var unitMemberAccountsMap = {};
		var unitIdToParentUnitIdMap = {};
		var parentUnitIdToDescendantUnitIds = {};
		
		var userSearchSpec = jQuery.extend({}, spec);
		userSearchSpec.autosearch = false;
		userSearchSpec.title = 'Team search';
		userSearchSpec.lookup = { 
				callback: function(v) {
					var table = dlg.find('table#MEMBERSTABLE');
					if (table.find('tr[id=\'' + v.Id + '\']').length == 0) {
						table.append(memberLine(v.Id,  v.Name, v.Title /*(v.Profile) ? v.Profile.Name : " "*/, (v.UserRole) ? v.UserRole.Name : " ", 'Edit', true));
						addedMembers.push(v);
					}
					table.parent().animate({ scrollTop: table.height() }, 100 /*"slow"*/);
				} 
		}
        userSearchSpec.lookupPostDisplay = function(evt, dlg) {
            dlg.parent().find('button[ttgbtntype="save"]').attr('ttgid', 'UserSearchSAVEBUTTON');
            dlg.parent().find('button[ttgbtntype="cancel"]').attr('ttgid', 'UserSearchCANCELBUTTON');        
        };
		var userMetadataControl = ttg.metadata(userSearchSpec);
		
		var accountMetadata = null;
	   	ttg.fetch.metadata('Account', ttgApi, function(data) {
	   		accountMetadata = _.object(_.map(data.metadata.fields, function(field) { return [field.name, field.label]; }));
	   	});
		
		
		// http://shahinalborz.se/2010/11/disable-double-click-to-prevent-multiple-execution/
		
		isNotDoubleClick = function () {
		    if (typeof (_linkEnabled) == "undefined") _linkEnabled = true;
		    setTimeout(blockClick, 100);
		    return _linkEnabled;
		}
		
		blockClick = function () {
		    _linkEnabled = false;
		    setTimeout("_linkEnabled=true", 1000);
		}
		
		function setUnitNameField(accountName) {
			var unitNameTextField = jQuery('#UNITNAME');
			var unitName = unitNameTextField.val();
			if(jQuery.trim(unitName) === '') {
				unitNameTextField.val(accountName);
			}		
		}
				
		function configure() {
			if (isNotDoubleClick()) {
				if ( clone ) {
					saveAs(spec);
				} else {
					_wrapGet (handleConfigure);
				}
			}			
		
		}
		
		function doOnCancel() {
			if(onCancel) {
				try {
					onCancel();
				} catch (e) {
					// do nothing
				}
			}
		}
		
		function handleConfigure(responseData) {
		
			addedMembers = [];
		
			unitsById = {};
			unitMemberAccountsMap = {};
			unitIdToParentUnitIdMap = {};
			parentUnitIdToDescendantUnitIds = {};		
		
			cfgdata = responseData;
			
			accountFields = responseData.accountFields
			
			// Clone returns a new Plan Id
			planId = cfgdata.planId;
			
			dateFormat = cfgdata.dateFormat;
			spec.dateFormat = cfgdata.dateFormat;
			unitSearchSpec.dateFormat = cfgdata.dateFormat;
			
			// If cloning, the old dialog still lives
			jQuery('.AMCONFIGURATION').remove();
			
			dlg = jQuery('<div>').addClass('AMCONFIGURATION');
			
			dlg.html(getDialogHTML())
        
			var buttons = [];

			if (!readonly) {
				buttons.push( { text: 'Save', click: save, ttgid: "SAVEBUTTON" } );
			}
			
			if ((planId != '') && (!readonly) && (candelete)) {
				buttons.push({ text: 'Delete', click: deletePlan, ttgid: "DELETEBUTTON", "class": "DELETE" });
			}

			buttons.push( { text: 'Cancel', click: function() { addedMembers = []; jQuery(this).dialog("close"); doOnCancel(); }, ttgid: "CANCELBUTTON" } );
			
			var height = jQuery(window).height()-50;
			var selectionHeight = 300;
			var zoneHeight = 570;
			//if (ttg.isSalesforce1()) {
			//	zoneHeight = 450;
			//}
			if (height > zoneHeight) height = zoneHeight;
			if (height < 350) height = 350;
			height += 40;
			zoneHeight += 10;
			dlg.dialog({ 
					modal: true, 
					resizable: false, 
					autoOpen: true, 
					title: title, 
					width: '600px',
					height: height,
					buttons: buttons,
                	dialogClass: ttg_salesforce1 ? 'plan_settings_container' : '', 
					close: function() { addedMembers = []; jQuery(this).dialog("close"); doOnCancel(); suicide(); }
				} 
			);
			jQuery('#AVAILABLESOLUTIONS').css('height', selectionHeight-(zoneHeight-height));
			jQuery('#SELECTEDSOLUTIONS').css('height', selectionHeight-(zoneHeight-height));
			
			jQuery('#SELECTEDUNITS').css('height', selectionHeight-(zoneHeight-height));
			jQuery('#USERS').css('height', selectionHeight-(zoneHeight-height));

			if ( cfgdata.planTypes.length > 1 ) {
			     jQuery('#PLANTYPE')
			          .append(jQuery('<option>', { value : '-1' })
			          .text('Please select a Plan Type'));
			}
			
			jQuery('#PLANTYPE').on('change', function() {
				var newValue = jQuery(this).val();
				if(newValue != '-1' && (planId == undefined || planId == '')) {
					var selectedPlanType = _.find(cfgdata.planTypes, function(planType) { return planType.id === newValue; });

					
					// Remove existing solutions in RH panel
					
					var selectedSolutions = jQuery('#SELECTEDSOLUTIONS').find('li').not(jQuery('#SELECTEDSOLUTIONS').find('li.FAMILY'));

				
					if(showSolutionFamilies) {
						jQuery.each(selectedSolutions, function(idx, selectedSolution) {
						
							var uiItem = jQuery(selectedSolution).clone();
							var itemlist = jQuery('#AVAILABLESOLUTIONS').find('ul');
    						
							var familyname = uiItem.attr('family');
    						    
						    if(uiItem.attr('others')) {
                                var ul = jQuery('#AVAILABLESOLUTIONS').find('ul').first();
                                var familyholder = ul.find('li.FAMILY[others]');
                                    
                                if(familyholder && familyholder.length) {
                                    familyholder.find('UL').append(jQuery(uiItem));
                                } else {
                                    var familyul = createFamilyHolder('Others', ul, jQuery(uiItem).closest('div').attr('id') == 'AVAILABLESOLUTIONS');
                                    familyul.closest('LI').attr('others', 'true');

                                    familyul.append(jQuery(uiItem));
                                }
                                
                                jQuery(selectedSolution).remove();
                                var senderfamilyholder = jQuery('#SELECTEDSOLUTIONS').find('li.FAMILY[others]');
                                if(! senderfamilyholder.find('UL LI').length) {
                                    senderfamilyholder.remove();
                                }
                                
						    
						    } else if(familyname) {
						        var ul = jQuery('#AVAILABLESOLUTIONS').find('ul').first();
                                var familyholder = ul.find('li.FAMILY[family="' + familyname + '"]');
						    
						           
                                if(familyholder && familyholder.length) {
                                    familyholder.find('UL').append(uiItem);
                                } else {
                                    var familyul = createFamilyHolder(familyname, ul, jQuery(uiItem).closest('div').attr('id') == 'AVAILABLESOLUTIONS');
                                    familyul.append(jQuery(uiItem));
                                }
                                
                                jQuery(selectedSolution).remove();
                                var senderfamilyholder = jQuery('#SELECTEDSOLUTIONS').find('li.FAMILY[family="' + familyname + '"]');
                                if(! senderfamilyholder.find('UL LI').length) {
                                    senderfamilyholder.remove();
                                }

						    }
    						    
						    jQuery(".SORTABLE, .SORTABLE2").sortable({connectWith: ".SORTABLE"});
						    
                            uiItem.addClass('AVAILABLE');
                            uiItem.removeClass('SELECTED');
							uiItem.find('span.TARGET').css('visibility', 'hidden');	
							uiItem.find('li.FAMILYMEMBER, li.NOFAMILY').addClass('AVAILABLE');
							uiItem.find('li.FAMILYMEMBER, li.NOFAMILY').removeClass('SELECTED');	
							uiItem.find('li.FAMILYMEMBER').find('span.TARGET').css('visibility', 'hidden');  
      
      						var span = uiItem.find('span.TARGET');
							var tooltipValue = _.find(cfgdata.availableSolutions, function(sol) { return sol.id === uiItem.attr('id'); });
							if(tooltipValue) {
								uiItem.find('.solution_info').remove();
								createInfoIcon(span, tooltipValue);
							} 						    
						    

						});
						
						selectedSolutions.remove();
						
					}
					else {
						jQuery.each(selectedSolutions, function(idx, selectedSolution) {
						
							var uiItem = jQuery(selectedSolution).clone();
							var itemlist = jQuery('#AVAILABLESOLUTIONS').find('ul');
							
							if(itemlist.find('#' + uiItem.attr('id')).length === 0) {
								itemlist.append(uiItem);
								
	                            uiItem.addClass('AVAILABLE');
	                            uiItem.removeClass('SELECTED');
								uiItem.find('span.TARGET').css('visibility', 'hidden');	
								uiItem.find('li.FAMILYMEMBER, li.NOFAMILY').addClass('AVAILABLE');
								uiItem.find('li.FAMILYMEMBER, li.NOFAMILY').removeClass('SELECTED');	
								uiItem.find('li.FAMILYMEMBER').find('span.TARGET').css('visibility', 'hidden');  
	      
	      						var span = uiItem.find('span.TARGET');
								var tooltipValue = _.find(cfgdata.availableSolutions, function(sol) { return sol.id === uiItem.attr('id'); });
								if(tooltipValue) {
									uiItem.find('.solution_info').remove();
									createInfoIcon(span, tooltipValue);
								} 
							}                           
	                            
						
						});
						selectedSolutions.remove();			
					}
					

					// Add default solutions from LH panel to RH panel
					
					var availableSolutions = null;
					_.each(selectedPlanType.solutionIds, function(solutionId) {
						var sol = jQuery('#AVAILABLESOLUTIONS').find('#' + solutionId);
						if(sol.length === 1) {
							if(availableSolutions === null) {
								availableSolutions = sol;
							}
							else {
								availableSolutions = availableSolutions.add(sol[0]);
							}
						}
					});
						
					if(availableSolutions != null) {
						if(showSolutionFamilies) {
						
							jQuery.each(availableSolutions, function(idx, availableSolution) {
						
								var uiItem = jQuery(availableSolution).clone();
								var itemlist = jQuery('#SELECTEDSOLUTIONS').find('ul');
	    						
	    						    var familyname = uiItem.attr('family');
	    						    
	    						    if(uiItem.attr('others')) {
	                                    var ul = jQuery('#SELECTEDSOLUTIONS').find('ul').first();
	                                    var familyholder = ul.find('li.FAMILY[others]');
	                                        
	                                    if(familyholder && familyholder.length) {
	                                        familyholder.find('UL').append(jQuery(uiItem));
	                                    } else {
	                                        var familyul = createFamilyHolder('Others', ul, jQuery(uiItem).closest('div').attr('id') == 'SELECTEDSOLUTIONS');
	                                        familyul.closest('LI').attr('others', 'true');
	
	                                        familyul.append(jQuery(uiItem));
	                                    }
	                                    
	                                    jQuery(availableSolution).remove();
	                                    var senderfamilyholder = jQuery('#AVAILABLESOLUTIONS').find('li.FAMILY[others]');
	                                    if(! senderfamilyholder.find('UL LI').length) {
	                                        senderfamilyholder.remove();
	                                    }
	                                    
	    						    
	    						    } else if(familyname) {
	    						        var ul = jQuery('#SELECTEDSOLUTIONS').find('ul').first();
	                                    var familyholder = ul.find('li.FAMILY[family="' + familyname + '"]');
	    						    
	    						           
	                                    if(familyholder && familyholder.length) {
	                                        familyholder.find('UL').append(uiItem);
	                                    } else {
	                                        var familyul = createFamilyHolder(familyname, ul, jQuery(uiItem).closest('div').attr('id') == 'SELECTEDSOLUTIONS');
	                                        familyul.append(jQuery(uiItem));
	                                    }
	                                    ul.find('li.FAMILY[family="' + familyname + '"]').addClass('SELECTED').removeClass('AVAILABLE');
	                                    
	                                    
	                                    jQuery(availableSolution).remove();
	                                    var senderfamilyholder = jQuery('#AVAILABLESOLUTIONS').find('li.FAMILY[family="' + familyname + '"]');
	                                    if(! senderfamilyholder.find('UL LI').length) {
	                                        senderfamilyholder.remove();
	                                    }
	
	    						    }
	    						    
	    						    jQuery(".SORTABLE, .SORTABLE2").sortable({connectWith: ".SORTABLE"});
	    						    
	    						    uiItem.addClass('SELECTED');
		                            uiItem.removeClass('AVAILABLE');
		                            uiItem.find('span.TARGET').css('visibility', 'visible');
		                            uiItem.find('li.FAMILYMEMBER, li.NOFAMILY').addClass('SELECTED');
		                            uiItem.find('li.FAMILYMEMBER, li.NOFAMILY').removeClass('AVAILABLE');
		                            uiItem.find('li.FAMILYMEMBER').find('span.TARGET').css('visibility', 'visible');
		                            
		                            var span = uiItem.find('span.TARGET');
		                            if(!readonly) {
		                                span.on('click', function() {
		                                    var icon = jQuery(this);
		                                    if(icon.hasClass('TARGETED')) {
		                                        span.parent('li').removeClass('TARGETED');
		                                        icon.removeClass('TARGETED').addClass('UNTARGETED');
		                                    }
		                                    else {
		                                        span.parent('li').addClass('TARGETED');
		                                        icon.removeClass('UNTARGETED').addClass('TARGETED');
		                                    }
		                                    
		                                    return false;
		                                });
		                            }
		
									var tooltipValue = _.find(cfgdata.availableSolutions, function(sol) { return sol.id === uiItem.attr('id'); });
									if(tooltipValue) {
										uiItem.find('.solution_info').remove();
										createInfoIcon(span, tooltipValue);
									} 
	
							});
							
							availableSolutions.remove();
						
						
						}
						else {
							
							jQuery.each(availableSolutions, function(idx, availableSolution) {
							
								var uiItem = jQuery(availableSolution).clone();
								var itemlist = jQuery('#SELECTEDSOLUTIONS').find('ul');
								
								if(itemlist.find('#' + uiItem.attr('id')).length === 0) {
									itemlist.append(uiItem);
									
		                            uiItem.addClass('SELECTED');
		                            uiItem.removeClass('AVAILABLE');
		                            uiItem.find('span.TARGET').css('visibility', 'visible');
		                            uiItem.find('li.FAMILYMEMBER, li.NOFAMILY').addClass('SELECTED');
		                            uiItem.find('li.FAMILYMEMBER, li.NOFAMILY').removeClass('AVAILABLE');
		                            uiItem.find('li.FAMILYMEMBER').find('span.TARGET').css('visibility', 'visible');
		                            
		                            var span = uiItem.find('span.TARGET');
		                            if(!readonly) {
		                                span.on('click', function() {
		                                    var icon = jQuery(this);
		                                    if(icon.hasClass('TARGETED')) {
		                                        span.parent('li').removeClass('TARGETED');
		                                        icon.removeClass('TARGETED').addClass('UNTARGETED');
		                                    }
		                                    else {
		                                        span.parent('li').addClass('TARGETED');
		                                        icon.removeClass('UNTARGETED').addClass('TARGETED');
		                                    }
		                                    
		                                    return false;
		                                });
		                            }
		
									var tooltipValue = _.find(cfgdata.availableSolutions, function(sol) { return sol.id === uiItem.attr('id'); });
									if(tooltipValue) {
										uiItem.find('.solution_info').remove();
										createInfoIcon(span, tooltipValue);
									} 
								}                           
	                                
							
							});
							availableSolutions.remove();
								
						}
					}
					
				}
			});

			jQuery.each(cfgdata.planTypes, function(key, value) {   
			     jQuery('#PLANTYPE')
			          .append(jQuery('<option>', { value : value.id })
			          .text(value.name));
			});

			if ( cfgdata.plantype != null ) {
				jQuery('#PLANTYPE').val(cfgdata.plantype);
			}
			
			// Chatter Groups
			var hasAccessToAssignedChatterGroup = false;
			if ( cfgdata.chatterGroups.length > 0 ) {
			     jQuery('#CHATTERGROUP')
			          .append(jQuery('<option>', { value : '' })
			          .text('Please select a Chatter Group'));
			}

			jQuery.each(cfgdata.chatterGroups, function(key, value) {  
				
				 if(value.id === cfgdata.chattergroupid) {
				 	hasAccessToAssignedChatterGroup = true;	
				 }
			 
			     jQuery('#CHATTERGROUP')
			          .append(
			          	jQuery('<option>', { value : value.id })
			          	.text(value.name)
			          );    
			});

			if ( cfgdata.chattergroupid != null ) {
				
				if(!hasAccessToAssignedChatterGroup) {
				     jQuery('#CHATTERGROUP')
				          .append(jQuery('<option>', { value : cfgdata.chattergroupid })
				          .text('Already associated with private group'))
				          .attr('disabled', 'disabled');						
				}
				
				jQuery('#CHATTERGROUP').val(cfgdata.chattergroupid);				
				
			}
			
            if(cfgdata.autopostchatter) {
                jQuery('#AUTO_POST_CHATTER').attr('checked', 'checked');
            }

            function createFamilyHolder(familyname, ul, selected) {
            
                   var familyul = jQuery('<ul>').addClass('ROOTSORTABLE SORTABLE2');
                   var familyli = jQuery('<li>').attr({'family': familyname})
                        .click(function() { 
                            if(jQuery(this).find('UL').hasClass('NOCLICK')) {
                                jQuery(this).find('UL').removeClass('NOCLICK');
                            } else {
                                jQuery(this).find('UL').toggle();
                                jQuery(this).toggleClass('active');
                            }
                        }).addClass('ITEM FAMILY' + (selected ? ' SELECTED' : ' AVAILABLE')).append(
                            jQuery('<span>').addClass('SOLUTIONNAME DRAGABLE').text(familyname)
                        ).append(familyul)
                        .disableSelection();
                        
                    ul.append(familyli);
                    
                    return familyul;
            }

			// Available Solutions			
			var availableSolutions = jQuery('DIV.AMCONFIGURATION').find('#AVAILABLESOLUTIONS');
			var ul = jQuery('<UL>').css('height', selectionHeight-(zoneHeight-height)).addClass('ROOTSORTABLE SORTABLE');			
			
			if(showSolutionFamilies) {
                _.each( 
                    _.groupBy(_.reject(cfgdata.availableSolutions, function(sol) { return ! sol.familyname}), function(sol) { return sol.familyname; }),
                    function(solsInFamily, familyname) {
                    
                       var familyul = createFamilyHolder(familyname, ul, false);
                       
                       _.each(solsInFamily, function(value) {
                            var span = jQuery('<span>').addClass('TARGET SOLUTION CLICKABLE').addClass('UNTARGETED'); 
                            if(value.targeted) {
                                span.removeClass('UNTARGETED').addClass('TARGETED');
                            }
                            
                            familyul.append(
                                jQuery('<li>')
                                .click(function(event) {
                                    event.stopImmediatePropagation();
                                })
                                .attr({'id': value.id, 'family': value.familyname}).addClass('ITEM AVAILABLE FAMILYMEMBER').append(
                                    span.css('visibility', 'hidden')                                    
                                ).append(
                                    jQuery('<span>').addClass('SOLUTIONNAME').text(value.name)
                                ).disableSelection()
                            );
                            
                            if(!readonly) {
                                span.on('click', function() {
                                    var icon = jQuery(this);
                                    if(icon.hasClass('TARGETED')) {
                                        span.parent('li').removeClass('TARGETED');
                                        icon.removeClass('TARGETED').addClass('UNTARGETED');
                                    }
                                    else {
                                        span.parent('li').addClass('TARGETED');
                                        icon.removeClass('UNTARGETED').addClass('TARGETED');
                                    }
                                    
                                    return false;
                                });
                            }

							createInfoIcon(span, value);

                           });

                    }
                );
                
                var nofamilyavailablesols = _.filter(cfgdata.availableSolutions, function(sol) { return ! sol.familyname});
                
                if(nofamilyavailablesols.length) {
                    var familyul = createFamilyHolder('Others', ul, false);
                    familyul.closest('LI').attr('others', 'true');
                       
                    _.each(
                        nofamilyavailablesols,
                        function(value) {
                        
                                var span = jQuery('<span>').addClass('TARGET SOLUTION CLICKABLE').addClass('UNTARGETED'); 
                                if(value.targeted) {
                                    span.removeClass('UNTARGETED').addClass('TARGETED');
                                }
                                
                                familyul.append(
                                    jQuery('<li>')
                                    .click(function(event) {
                                        event.stopImmediatePropagation();
                                    })
                                    .attr({'id': value.id, 'family': 'Others', 'others': 'true'}).addClass('ITEM AVAILABLE NOFAMILY').append(
                                        span.css('visibility', 'hidden')                                    
                                    ).append(
                                        jQuery('<span>').addClass('SOLUTIONNAME').text(value.name)
                                    ).disableSelection()
                                );
                                
                                if(!readonly) {
                                    span.on('click', function() {
                                        var icon = jQuery(this);
                                        if(icon.hasClass('TARGETED')) {
                                            span.parent('li').removeClass('TARGETED');
                                            icon.removeClass('TARGETED').addClass('UNTARGETED');
                                        }
                                        else {
                                            span.parent('li').addClass('TARGETED');
                                            icon.removeClass('UNTARGETED').addClass('TARGETED');
                                        }
                                        
                                        return false;
                                    });
                                }

								createInfoIcon(span, value);

                        }
                    );
                }
			} else {
                    _.each(
                        cfgdata.availableSolutions,
                        function(value) {
                        
                                var span = jQuery('<span>').addClass('TARGET SOLUTION CLICKABLE').addClass('UNTARGETED'); 
                                if(value.targeted) {
                                    span.removeClass('UNTARGETED').addClass('TARGETED');
                                }
                                
                                ul.append(
                                    jQuery('<li>').attr({'id': value.id}).addClass('ITEM AVAILABLE').append(
                                        span.css('visibility', 'hidden')                                    
                                    ).append(
                                        jQuery('<span>').addClass('SOLUTIONNAME').text(value.name)
                                    ).disableSelection()
                                );
                                
                                if(!readonly) {
                                    span.on('click', function() {
                                        var icon = jQuery(this);
                                        if(icon.hasClass('TARGETED')) {
                                            span.parent('li').removeClass('TARGETED');
                                            icon.removeClass('TARGETED').addClass('UNTARGETED');
                                        }
                                        else {
                                            span.parent('li').addClass('TARGETED');
                                            icon.removeClass('UNTARGETED').addClass('TARGETED');
                                        }
                                        
                                        return false;
                                    });
                                }

								createInfoIcon(span, value);

                        }
                    );
			}
			
			availableSolutions.append(ul);
			
			// Selected Solutions			
			var selectedSolutions = jQuery('DIV.AMCONFIGURATION').find('#SELECTEDSOLUTIONS');
			ul = jQuery('<UL>').css('height', selectionHeight-(zoneHeight-height)).addClass('ROOTSORTABLE SORTABLE');

            if(showSolutionFamilies) {
            
            
            
                var selectedSolsByFamily = _.groupBy(_.reject(cfgdata.selectedSolutions, function(sol) { return ! sol.familyname }), function(sol) { return sol.familyname; });
                var orderedSelectedSolsFamily = 
                    _.sortBy(
                        _.map(selectedSolsByFamily, function(value, key) {
                            return { 
                                'family': key, 
                                'sort': _.min(value, function(sol) {
                                    return sol.sortOrder;
                                }) 
                            };
                        }),
                        function(solfamily) {
                            return solfamily.sort;
                        }
                    )
                ;
            
                _.each(
                    orderedSelectedSolsFamily,
                    function(solsfamily) {
                       var familyname = solsfamily.family;
                       var solsInFamily = _.sortBy(selectedSolsByFamily[familyname], function(sol) { return sol.sortOrder });
                       
                        var familyul = createFamilyHolder(familyname, ul, true);
                       
                       _.each(solsInFamily, function(value) {
                            var span = jQuery('<span>').addClass('TARGET SOLUTION CLICKABLE').addClass('UNTARGETED'); 
                            if(value.targeted) {
                                span.removeClass('UNTARGETED').addClass('TARGETED');
                            }
                            
                            familyul.append(
                                jQuery('<li>')
                                .click(function(event) {
                                    event.stopImmediatePropagation();
                                })
                                .addClass(value.targeted ? 'TARGETED' : null).attr({'id': value.id, 'family': value.familyname}).addClass('ITEM SELECTED FAMILYMEMBER').append(
                                    jQuery('<span>').text(value.opportunityCount != 0 ? value.opportunityCount : '').addClass(value.opportunityCount != 0 ? 'OPPORTUNITYCOUNT':'')
                                ).append(
                                    span                
                                ).append(
                                    jQuery('<span>').addClass('SOLUTIONNAME').text(value.basename)
                                ).disableSelection()
                            );
                            
                            if(!readonly) {
                                span.on('click', function() {
                                    var icon = jQuery(this);
                                    if(icon.hasClass('TARGETED')) {
                                        span.parent('li').removeClass('TARGETED');
                                        icon.removeClass('TARGETED').addClass('UNTARGETED');
                                    }
                                    else {
                                        span.parent('li').addClass('TARGETED');
                                        icon.removeClass('UNTARGETED').addClass('TARGETED');
                                    }
                                    
                                    return false;
                                });
                            }

							createInfoIcon(span, value);
                           
                           });
                           
                           
                       
                    }
                );
                
                var nofamilyselectedsols = _.filter(cfgdata.selectedSolutions, function(sol) { return ! sol.familyname});
                
                if(nofamilyselectedsols.length) {
                    var familyul = createFamilyHolder('Others', ul, true);
                    familyul.closest('LI').attr('others', 'true');
                       
                    _.each(
                        nofamilyselectedsols,
                        function(value) {
                        
                                var span = jQuery('<span>').addClass('TARGET SOLUTION CLICKABLE').addClass('UNTARGETED'); 
                                if(value.targeted) {
                                    span.removeClass('UNTARGETED').addClass('TARGETED');
                                }
                                
                                familyul.append(
                                    jQuery('<li>')
                                    .click(function(event) {
                                        event.stopImmediatePropagation();
                                    })
                                    .addClass(value.targeted ? 'TARGETED' : null).attr({'id': value.id, 'family': 'Others', 'others': 'true'}).addClass('ITEM SELECTED NOFAMILY').append(
                                        jQuery('<span>').text(value.opportunityCount != 0 ? value.opportunityCount : '').addClass(value.opportunityCount != 0 ? 'OPPORTUNITYCOUNT':'')
                                    ).append(
                                        span                
                                    ).append(
                                        jQuery('<span>').addClass('SOLUTIONNAME').text(value.basename)
                                    ).disableSelection()
                                );
                                
                                if(!readonly) {
                                    span.on('click', function() {
                                        var icon = jQuery(this);
                                        if(icon.hasClass('TARGETED')) {
                                            span.parent('li').removeClass('TARGETED');
                                            icon.removeClass('TARGETED').addClass('UNTARGETED');
                                        }
                                        else {
                                            span.parent('li').addClass('TARGETED');
                                            icon.removeClass('UNTARGETED').addClass('TARGETED');
                                        }
                                        
                                        return false;
                                    });
                                }

								createInfoIcon(span, value);
                        
                        }
                    );
                }
            } else {
                    _.each(
                        cfgdata.selectedSolutions,
                        function(value) {
                        
                                var span = jQuery('<span>').addClass('TARGET SOLUTION CLICKABLE').addClass('UNTARGETED'); 
                                if(value.targeted) {
                                    span.removeClass('UNTARGETED').addClass('TARGETED');
                                }
                                
                                ul.append(
                                    jQuery('<li>').addClass(value.targeted ? 'TARGETED' : null).attr({'id': value.id}).addClass('ITEM SELECTED').append(
                                        jQuery('<span>').text(value.opportunityCount != 0 ? value.opportunityCount : '').addClass(value.opportunityCount != 0 ? 'OPPORTUNITYCOUNT':'')
                                    ).append(
                                        span                
                                    ).append(
                                        jQuery('<span>').addClass('SOLUTIONNAME').text(value.basename)
                                    ).disableSelection()
                                );
                                
                                if(!readonly) {
                                    span.on('click', function() {
                                        var icon = jQuery(this);
                                        if(icon.hasClass('TARGETED')) {
                                            span.parent('li').removeClass('TARGETED');
                                            icon.removeClass('TARGETED').addClass('UNTARGETED');
                                        }
                                        else {
                                            span.parent('li').addClass('TARGETED');
                                            icon.removeClass('UNTARGETED').addClass('TARGETED');
                                        }
                                        
                                        return false;
                                    });
                                }

								createInfoIcon(span, value);
                        
                        }
                    );
            }
            			
			
			
			selectedSolutions.append(ul);
			if (!readonly && !inactive) {
				dlg.find('LI.ITEM:not(.FAMILY)').addClass('DRAGABLE')

				jQuery( ".SORTABLE, .SORTABLE2" ).sortable({
				        tolerance: "pointer",
						connectWith: ".SORTABLE",
						receive: function( event, ui ) {
						    
						    if(showSolutionFamilies) {
    						    //Can only sort a family member within its own sorting group
                                if(jQuery(ui.item).parents('ul').hasClass('SORTABLE') && jQuery(ui.item).hasClass('FAMILYMEMBER')
                                    && jQuery(ui.sender).closest('div').attr('id') == jQuery(ui.item).closest('div').attr('id')) 
                                {
                                    jQuery(ui.sender).sortable('cancel');
                                    return;
                                }
    						
    						    var familyname = jQuery(ui.item).attr('family');
    						    
    						    if(jQuery(ui.item).attr('others')) {
                                    var ul = jQuery(ui.item).closest('UL');
                                    var familyholder = ul.find('li.FAMILY[others]');
                                
                                    //dragging whole family section over
                                    if(jQuery(ui.item).hasClass('FAMILY')) {
                                        if(familyholder && familyholder.length > 1) {
                                            var familylitokeep, familylitoremove;
                                            var sendid = jQuery(ui.sender).closest('div').attr('id');
                                            if('SELECTEDSOLUTIONS' == sendid) {
                                                familylitokeep = familyholder.filter('.SELECTED');
                                                familylitoremove = familyholder.filter('.AVAILABLE');
                                            } else {
                                                familylitokeep = familyholder.filter('.AVAILABLE');
                                                familylitoremove = familyholder.filter('.SELECTED');
                                            }
                                            
                                            familylitoremove.find('UL LI').appendTo(familylitokeep.find('UL'));
                                            familylitoremove.remove();
                                        }
                                    } else {
                                        
                                        if(familyholder && familyholder.length) {
                                            familyholder.find('UL').append(jQuery(ui.item));
                                        } else {
                                            var familyul = createFamilyHolder('Others', ul, jQuery(ui.item).closest('div').attr('id') == 'SELECTEDSOLUTIONS');
                                            familyul.closest('LI').attr('others', 'true');
    
                                            familyul.append(jQuery(ui.item));
                                        }
                                        
                                        var senderfamilyholder = jQuery(ui.sender).closest('li.FAMILY[others]');
                                        if(! senderfamilyholder.find('UL LI').length) {
                                            senderfamilyholder.remove();
                                        }
                                    }
    						    
    						    } else if(familyname) {
    						        var ul = jQuery(ui.item).closest('UL');
                                    var familyholder = ul.find('li.FAMILY[family="' + familyname + '"]');
    						    
    						        //dragging whole family section over
        						    if(jQuery(ui.item).hasClass('FAMILY')) {
        						        if(familyholder && familyholder.length > 1) {
        						            var familylitokeep, familylitoremove;
        						            var sendid = jQuery(ui.sender).closest('div').attr('id');
        						            if('SELECTEDSOLUTIONS' == sendid) {
        						                familylitokeep = familyholder.filter('.SELECTED');
        						                familylitoremove = familyholder.filter('.AVAILABLE');
        						            } else {
        						                familylitokeep = familyholder.filter('.AVAILABLE');
        						                familylitoremove = familyholder.filter('.SELECTED');
        						            }
        						            
        						            familylitoremove.find('UL LI').appendTo(familylitokeep.find('UL'));
        						            familylitoremove.remove();
        						        }
        						    } else {
        						        
                                        if(familyholder && familyholder.length) {
                                            familyholder.find('UL').append(jQuery(ui.item));
                                        } else {
                                            var familyul = createFamilyHolder(familyname, ul, jQuery(ui.item).closest('div').attr('id') == 'SELECTEDSOLUTIONS');
                                            familyul.append(jQuery(ui.item));
                                        }
                                        
                                        var senderfamilyholder = jQuery(ui.sender).closest('li.FAMILY[family="' + familyname + '"]');
                                        if(! senderfamilyholder.find('UL LI').length) {
                                            senderfamilyholder.remove();
                                        }
        						    }
    						    }
    						    
    						    jQuery(".SORTABLE, .SORTABLE2").sortable({connectWith: ".SORTABLE"});
						    }
						    var ul = ui.item.parent();
                            var div = ul.closest('div');
						
						    //TODO change, fix me up ...
							if (ui.item.find('SPAN.OPPORTUNITYCOUNT').text() != '') {

								if (div.attr('id') == 'AVAILABLESOLUTIONS') {

									alertDialog(
											'Delete Plan Solution', 
											'Warning! If saved then all solution related data will be deleted and opportunities associated with the solution may be removed from the plan.',
											{
												'Ok': function() { 
													jQuery(this).dialog('close'); 
												}
											}
									)

								}
							}
							
                            if (div.attr('id') == 'AVAILABLESOLUTIONS') {
                                ui.item.addClass('AVAILABLE');
                                ui.item.removeClass('SELECTED');
								ui.item.find('span.TARGET').css('visibility', 'hidden');
								
								jQuery(ui.item).find('li.FAMILYMEMBER, li.NOFAMILY').addClass('AVAILABLE');
								jQuery(ui.item).find('li.FAMILYMEMBER, li.NOFAMILY').removeClass('SELECTED');
								
								jQuery(ui.item).find('li.FAMILYMEMBER').find('span.TARGET').css('visibility', 'hidden');
								
                            } else {
                                ui.item.addClass('SELECTED');
                                ui.item.removeClass('AVAILABLE');
                                ui.item.find('span.TARGET').css('visibility', 'visible');
                                
                                
                                jQuery(ui.item).find('li.FAMILYMEMBER, li.NOFAMILY').addClass('SELECTED');
                                jQuery(ui.item).find('li.FAMILYMEMBER, li.NOFAMILY').removeClass('AVAILABLE');
                                
                                jQuery(ui.item).find('li.FAMILYMEMBER').find('span.TARGET').css('visibility', 'visible');
                                
                            }
						},
						start: function(event, ui) {
                            
                            if(ui.item.hasClass('FAMILY')) {
                                ui.item.find('UL').addClass('NOCLICK');
                            }
                            
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
							
							var ul = jQuery(ui.item).closest('UL.SORTABLE');
							ul.find('li.FAMILY[others]').appendTo(ul);
                     	}
						
					}
				).disableSelection();
			}
			
			
			// Units
			var unitCtrl = jQuery('DIV.AMCONFIGURATION').find('#SELECTEDUNITS').find('UL');
			if (defaultAccountId != '') {
				var child = createLI(unitCtrl, defaultAccountId, defaultAccountName, true, defaultAccountId, defaultAccountName, 0);
				
				unitCtrl.append(child);
			}
			addUnitToParent(unitCtrl, cfgdata.units, undefined)
			if (!readonly && !inactive) {
				enableUnitSorting()
			}
			
						
			if(cfgdata.units) {
				jQuery.each(cfgdata.units, function(idx, unit) {
					unitsById[unit.id] = unit;
					if(unit.memberAccounts && unit.memberAccounts.length > 0) {
						unitMemberAccountsMap[unit.id] = unit.memberAccounts;
					}		
					unitIdToParentUnitIdMap[unit.id] = unit.parentUnitId;

					if(!parentUnitIdToDescendantUnitIds[unit.parentUnitId]) {
						parentUnitIdToDescendantUnitIds[unit.parentUnitId] = [];
					}
					parentUnitIdToDescendantUnitIds[unit.parentUnitId].push(unit.id);
					
				});

			}
			
			for(var parentUnitId in parentUnitIdToDescendantUnitIds) {
				if(parentUnitIdToDescendantUnitIds.hasOwnProperty(parentUnitId)) {
					parentUnitIdToDescendantUnitIds[parentUnitId] = _.uniq(parentUnitIdToDescendantUnitIds[parentUnitId]);
				}
			}
						
			
	        jQuery( "#FROMDATE" ).datepicker({ 
	        		dateFormat: cfgdata.dateFormat,
					showOn: 'both',
					buttonImage: calendarURL,
					buttonImageOnly: true,
					disabled: readonly,
					changeMonth: true,
					changeYear: true,
	    	        onSelect: function( selectedDate ) {
						fromDateChanged();
	                },
                    onClose: function(dateText, inst) {
                        var fromDate =  jQuery( "#FROMDATE" ).datepicker('getDate');
                        fromDate.setDate(1);
                        
                        jQuery('#FROMDATE').datepicker('setDate', fromDate);
                    }
	        	}
	        ).on('change', function() {
	        	fromDateChanged();
	        });
	        

			function createInfoIcon(span, val){
				var theTooltip = val.sol_tooltip;
				if(theTooltip && theTooltip != undefined && theTooltip != '<br>'){
	              	var info_icon = jQuery('<div/>')
					              		.addClass('solution_info')
					              		.attr('id', 'NOTEINFOICON_' + val.id)
					              		.css('visibility', !iPad ? 'visible' : 'hidden')
					              		.appendTo(span.parent('li'));

		            if (!iPad) {
		                jQuery(info_icon).tooltip({ delay: 0, showURL: false, bodyHandler: function() { return jQuery('<div class="HOVERHELP">').text(theTooltip); } });
		            }
		         }			
			}
			
	        function fromDateChanged() {
	        	var fromDate =  jQuery( "#FROMDATE" ).datepicker('getDate');
	        	var toDate =  jQuery( "#TODATE" ).datepicker('getDate');
                
	        	if (fromDate > toDate) {
	        	    toDate.setMonth(fromDate.getMonth() + 1, 0);
                    toDate.setFullYear(fromDate.getFullYear());
	        		jQuery( "#TODATE" ).datepicker( "setDate", toDate );
	        	}
	        	
                fromDate = new Date(fromDate - new Date(fromDate).getTimezoneOffset() * 60000);
                toDate = new Date(toDate - new Date(toDate).getTimezoneOffset() * 60000);
	        	var error = checkRevenueTargets(fromDate, toDate, spec.fiscalYearStartMonth);
	        	showRevenueTargetError(error);
	        }
	        
	        jQuery( "#TODATE" ).datepicker({ 
	        		dateFormat: cfgdata.dateFormat,
					showOn: 'both',
					buttonImage: calendarURL,
					buttonImageOnly: true,
					disabled: readonly,
					changeMonth: true,
					changeYear: true,					
	    	        onSelect: function( selectedDate ) {
        				toDateChanged();
	                },
	        		onClose: function(dateText, inst) {
	        		    var toDate =  jQuery( "#TODATE" ).datepicker('getDate');
                        toDate.setMonth(toDate.getMonth() + 1, 0);
                        
                        jQuery('#TODATE').datepicker('setDate', toDate);
                    }
	        	}
	        ).on('change', function() {
	        	toDateChanged();
	        });
	        
	        function toDateChanged() {
	        	var fromDate =  jQuery( "#FROMDATE" ).datepicker('getDate');
	        	var toDate =  jQuery( "#TODATE" ).datepicker('getDate');
	        	
	        	toDate.setMonth(toDate.getMonth() + 1, 0);
                
	        	if (toDate < fromDate) {
                    fromDate.setMonth(toDate.getMonth(), 1);
	        		jQuery( "#FROMDATE" ).datepicker( "setDate", fromDate );
	        	}
	        	
                fromDate = new Date(fromDate - new Date(fromDate).getTimezoneOffset() * 60000);
                toDate = new Date(toDate - new Date(toDate).getTimezoneOffset() * 60000);
	        	var error = checkRevenueTargets(fromDate, toDate, spec.fiscalYearStartMonth);	    
	        	showRevenueTargetError(error);		        
	        }
	        
	        jQuery('#FROMDATE').datepicker('setDate', cfgdata.fromDate);
	        jQuery('#TODATE').datepicker('setDate', cfgdata.toDate);
			
            var currDate = new Date();
            currDate.setDate(1);
            currDate.setHours(0,0,0,0);
            
            if (planId == undefined || planId == '') {
                //jQuery( "#FROMDATE" ).datepicker("option", "minDate", currDate);
            } else {
                var fromDate = jQuery('#FROMDATE').datepicker('getDate');
                
                function isDateSelectable(date) {
                    if(date >= currDate) {
                        return [true, ''];
                    }
                    else if(fromDate.getMonth() == date.getMonth() && fromDate.getFullYear() == date.getFullYear()) {
                        return [true, ''];
                    } 
                    else if(fromDate.getMonth() < date.getMonth() && fromDate.getFullYear() == date.getFullYear()) {
                        return [true, ''];
                    }
                    else {
                        return [false, ''];
                    }
                };

            }
			
			isNotDoubleClick = function () {
			    if (typeof (_linkEnabled) == "undefined") _linkEnabled = true;
			    setTimeout(blockClick, 100);
			    return _linkEnabled;
			}
			
			blockClick = function () {
			    _linkEnabled = false;
			    setTimeout("_linkEnabled=true", 1000);
			}
			
			if (!readonly && !inactive) {
				jQuery('#UNITINPUT').autocomplete({ 
						open: unitMetadataControl.autoCompleteClear, 
						source: function (term, callback) { 
							
							var cb = function(a, b, c) { showAjaxSpinner(false); return callback(a,b,c); }

							showAjaxSpinner(true);
							
							return unitMetadataControl.autoCompleteFind('account', term, cb) 

						}, 
						select: unitMetadataControl.autoCompleteSelected
					}
				).on('keydown', function(evt) { 
						jQuery(this).parent().find('INPUT[type=\'hidden\']').val(''); 
					}
				)	
				jQuery('#SEARCHACCOUNT').click(unitMetadataControl.lookup);
				jQuery('#SEARCHACCOUNT').parent().attr('layout','account');
				jQuery('#ADDUNITLINK').click(function() { 
                   	if (isNotDoubleClick()) {
						//jQuery('#SEARCHACCOUNT').trigger('click');
						jQuery('#ADDUNIT').trigger('click', true);
					}
				});
				jQuery('#ADDUNIT').click(function(evt, useCreateNewUnit) {
					if(useCreateNewUnit) {
						addUnit(function(item) {
							createNewUnit(item);
						});
					}
					else {
						addUnit();
					}
				});
			}
			else {
				jQuery('#ADDUNITLINK').css('display', 'none')
			}
			
			var fromDateUTC = jQuery( "#FROMDATE" ).datepicker('getDate');
			fromDateUTC = new Date(fromDateUTC - new Date(fromDateUTC).getTimezoneOffset() * 60000);
			var toDateUTC = jQuery( "#TODATE" ).datepicker('getDate');
			toDateUTC = new Date(toDateUTC - new Date(toDateUTC).getTimezoneOffset() * 60000);
			checkRevenueTargets(fromDateUTC, toDateUTC, spec.fiscalYearStartMonth);
			renderRevenueTargets(cfgdata);

			//jQuery('.AMCONFIGURATION').css('overflow', 'hidden');
			
			dlg.find('#PLANNAME').val(cfgdata.planname);

			if (!readonly && !inactive) {
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

			renderMembers(cfgdata);

			setupOwnerSearch();
			
			dlg.tabs({});
			
			jQuery('SPAN#PLANSTATUS').text(inactive ? 'Inactive' : 'Active');
            
			if (readonly) {
				jQuery(dlg).find('input[type=\'text\']').attr('disabled', 'true');
				jQuery(dlg).find('#PLANTYPE').attr('disabled', 'true');
				jQuery(dlg).find('#CHATTERGROUP').attr('disabled', 'true');
			}

			jQuery(dlg).parent().find('BUTTON.DELETE').css('background', 'none').css('background-color', 'maroon');
			
		}
		
		var changesInTargets = false;
		
		function getRevenueTargetKey(fromDate, fiscalYearStartMonth) {
			if(fromDate.getUTCMonth() >= fiscalYearStartMonth) {
				return fromDate.getUTCFullYear();
			}
			else {
				return fromDate.getUTCFullYear() - 1;
			}
		}
		
		function printFormattedPeriod(yearKey, fromDate, toDate) {
			var formattedYear = (spec.usesStartDateAsFiscalYearName || spec.fiscalYearStartMonth === 0) ? yearKey : (yearKey + 1);
			if(fromDate.getUTCFullYear() === toDate.getUTCFullYear()) {
				return formattedYear + ' (' + (toDate.getUTCMonth() - fromDate.getUTCMonth() + 1)  + ' months)';
			} 
			else {
				return formattedYear + ' (' + (toDate.getUTCMonth() + (12 - fromDate.getUTCMonth()) + 1)  + ' months)';
			}		
		}
			
		function createRevenueTarget(year, beginDate, endDate, revenueTarget) {
			return {
				id: null,
				fromDate: beginDate,
				toDate: endDate,
				revenueTarget: revenueTarget,
				formattedPeriod: function() { 
					return (spec.fiscalYearStartMonth === 0 ? '' : 'FY') + printFormattedPeriod(year, this.fromDate, this.toDate);
				}
			};
		}		
		
		function checkRevenueTargets(fromDate, toDate, fiscalYearStartMonth) {
		
			var errorMsg = null;
			
			var fromYear = fromDate.getUTCFullYear();
			var fromMonth = fromDate.getUTCMonth();
			var fromDay = fromDate.getUTCDate();						
			var toYear = toDate.getUTCFullYear();
			var toMonth = toDate.getUTCMonth();
			var toDay = toDate.getUTCDate();
			
			var revenueTargets = cfgdata.revenueTargets;
			var currentRevenueTargetsSize = revenueTargets.length;
			
			var totalRevenue = 0;
			
			// Builds map with current revenue targets, using revenue target from year as key
			var currentRevenueTargets = {};
			jQuery.each(revenueTargets, function(idx, currentTarget) {
				currentRevenueTargets[getRevenueTargetKey(new Date(currentTarget.fromDate), fiscalYearStartMonth)] = currentTarget;
				totalRevenue += currentTarget.revenueTarget || 0;
			}); 			
			
			var expectedRevenuePeriods = buildRevenuePeriods(fromDate, toDate, fiscalYearStartMonth);
			
			cfgdata.revenueTargets = [];
			jQuery.each(expectedRevenuePeriods, function(idx, revenuePeriod) {
				var yearKey = getRevenueTargetKey(new Date(revenuePeriod.fromDate), fiscalYearStartMonth);
				var revenueTarget = currentRevenueTargets[yearKey];
				if(!revenueTarget) {
					revenueTarget = createRevenueTarget(yearKey, revenuePeriod.fromDate, revenuePeriod.toDate, 0);
					changesInTargets = true;
				}
				else {
					revenueTarget.fromDate = revenuePeriod.fromDate;
					revenueTarget.toDate = revenuePeriod.toDate;
					revenueTarget.revenueTarget = revenueTarget.revenueTarget || 0;
					revenueTarget.formattedPeriod = function() {
						return (spec.fiscalYearStartMonth === 0 ? '' : 'FY') + printFormattedPeriod(yearKey, this.fromDate, this.toDate);
					};
					changesInTargets = true;
				}
				cfgdata.revenueTargets.push(revenueTarget);
			}); 

			
			if(currentRevenueTargetsSize !== cfgdata.revenueTargets.length) {
				changesInTargets = true;
			}			
			
			renderRevenueTargets(cfgdata);
			
			if(changesInTargets) {
				errorMsg = revenueTargetsChanged;
			}
			
			return errorMsg;
			
		}
		
		
		function buildRevenuePeriods(fromDate, toDate, fiscalYearStartMonth) {
		
			var fromYear = fromDate.getUTCFullYear();
			var fromMonth = fromDate.getUTCMonth();
			var toYear = toDate.getUTCFullYear();
			var toMonth = toDate.getUTCMonth();
		
			var revenuePeriods = [];
			
			var moreDates = true;
			var fiscalYearEndMonth = (fiscalYearStartMonth == 0) ? 11 : fiscalYearStartMonth - 1;
			var startDate = new Date(Date.UTC(fromDate.getUTCFullYear(), fromDate.getUTCMonth(), fromDate.getUTCDate()));
			var endDate = toDate;
			var endFiscalMonthInStartDateYear = new Date(Date.UTC(startDate.getUTCFullYear(), fiscalYearEndMonth + 1, 0));
			if(endFiscalMonthInStartDateYear < startDate) {
				endFiscalMonthInStartDateYear.setUTCFullYear(endFiscalMonthInStartDateYear.getUTCFullYear() + 1);
			}
			
			while(moreDates) {
				if(endFiscalMonthInStartDateYear < endDate) {
					revenuePeriods.push(createRevenuePeriod(startDate, endFiscalMonthInStartDateYear));
                    startDate = new Date(Date.UTC(endFiscalMonthInStartDateYear.getUTCFullYear(), endFiscalMonthInStartDateYear.getUTCMonth() + 1, 1));
                    endFiscalMonthInStartDateYear.setUTCFullYear(endFiscalMonthInStartDateYear.getUTCFullYear() + 1);					
				}
				else if(endFiscalMonthInStartDateYear == endDate) {
					revenuePeriods.push(createRevenuePeriod(startDate, endFiscalMonthInStartDateYear));
					moreDates = false;
				}
				else {
					revenuePeriods.push(createRevenuePeriod(startDate, endDate));
					moreDates = false;
				}
			}
			
			return revenuePeriods;
			
			function createRevenuePeriod(startDate, endDate) {
				var beginDate = new Date(Date.UTC(startDate.getUTCFullYear(), startDate.getUTCMonth(), startDate.getUTCDate()));
				var finishDate = new Date(Date.UTC(endDate.getUTCFullYear(), endDate.getUTCMonth(), endDate.getUTCDate()));;    // CHECK LOCALE!!!
				return {
					fromDate: beginDate,
					toDate: finishDate
				};									
			}										
					
		}	
		
	
		function showRevenueTargetError(error) {
			if(error) {
				jQuery('#revenueTargetValidationErrorDiv').show().css('display', 'inline').text(error);
			}
			else {
				jQuery('#revenueTargetValidationErrorDiv').hide().text('');
			}
		}

		function enableUnitSorting() {
			// Reset

			//jQuery('DIV.AMCONFIGURATION').find('#SELECTEDUNITS').find('UL').sortable('destroy');

			jQuery('DIV.AMCONFIGURATION').find('#SELECTEDUNITS').find('UL').sortable({

				

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
					jQuery('DIV.AMCONFIGURATION').find('#SELECTEDUNITS').css('display', 'none')
					jQuery('DIV.AMCONFIGURATION').find('#SELECTEDUNITS').css('display', '')
					
					
					

             	}
			}).disableSelection().setEdgesAutoScrollable();
		}
		
		
		function computeTotalRevenueTarget() {
			var totalRevenue = 0;
			jQuery.each(cfgdata.revenueTargets, function(idx, target) {
				totalRevenue += target.revenueTarget || 0;
			});
			cfgdata.formattedRevenueTarget = formatRevenueTarget(Math.round(totalRevenue));				
			jQuery('td.totalRevenueTarget').text(cfgdata.formattedRevenueTarget);			
		}

		function renderRevenueTargets(cfgdata) {
		
			dlg.find('#SCORECARDTARGETS').empty();
			
			var revenueTargetsTitle = jQuery('<div>').addClass('revenueTargetsTitle').text('Annual Revenue Targets:');
			
			var table = jQuery('<table/>').attr('id', 'TARGETSTABLE');
			
			function renderMainTable() {
				table.empty();
				jQuery.each(cfgdata.revenueTargets, function(key, target) {
					var targetRevenueCell = jQuery('<td/>').addClass('revenueTargetCell').text(formatRevenueTarget(Math.round(target.revenueTarget)));				
					table.append(jQuery('<tr/>')
						.append(jQuery('<td/>').text((typeof target.formattedPeriod === 'function') ? target.formattedPeriod() : target.formattedPeriod))
						.append(targetRevenueCell)
					);
				});
				table.append(jQuery('<tr/>', {'class': 'totalRevenueTargetRow'}).append(jQuery('<td/>').text('Plan Target')).append(jQuery('<td/>', {'class': 'totalRevenueTarget'}).text(cfgdata.formattedRevenueTarget)));
			}
			
			renderMainTable();
			
			var targetConfigButton = jQuery('<button/>', {id: 'targetConfigButton'}).text('Edit Revenue Targets').on('click', function() {

				var dialogRevenueTargets = _.map(cfgdata.revenueTargets, function(targetToCopy) { return jQuery.extend(true, {}, targetToCopy); } );
				var revenueTargetDialog = jQuery('<div/>').dialog({
					modal: true,
					resizable: false, 
					title: 'Edit Revenue Targets',
					width: 'auto',
					buttons: [
							{ 
								text: 'Save', 
								click: function() { 
									cfgdata.revenueTargets = dialogRevenueTargets;
									renderMainTable();
									computeTotalRevenueTarget();
									jQuery(this).dialog("close");
								},
								id: 'editTargetsOkButton', 
								ttgid: "EDIT_TARGETS_OKBUTTON" 
							},
							{ 
								text: 'Cancel', 
								click: function() {
									jQuery(this).dialog("close");
								}, 
								ttgid: "EDIT_TARGET_CANCELBUTTON" 
							}							
							], 
					close: function() {
						jQuery(this).remove();
					}  
				});
				
				
				var editTable = jQuery('<table/>').attr('id', 'EDITTARGETSTABLE');
				var editTargetsDialogErrorMsg = jQuery('<div/>', {id: 'editTargetsDialogErrorMsg'});
				var todayYear = new Date().getFullYear();
				jQuery.each(dialogRevenueTargets, function(key, target) {
					var targetRevenueInput = null; 
					
					targetRevenueInput = jQuery('<input/>', {type: 'text'}).val(Math.round(target.revenueTarget)).on('change', function() {
						if(!jQuery.isNumeric(jQuery(this).val())) {
							editTargetsDialogErrorMsg.text(nonNumericRevenueTarget).show().css('display','inline');
							jQuery('#editTargetsOkButton').button().button('disable');
							jQuery('.totalRevenueTargetDialog').text('-');
							return;							
						}
						target.revenueTarget = parseFloat(jQuery(this).val() || 0);
						if(target.revenueTarget < 0) {
							editTargetsDialogErrorMsg.text(revenueTargetBelowLimit).show().css('display','inline');
							jQuery('#editTargetsOkButton').button().button('disable');
							jQuery('.totalRevenueTargetDialog').text('-');
							return;
						}							
						else if(target.revenueTarget >= 1000000000000) {
							editTargetsDialogErrorMsg.text(revenueTargetAboveLimit).show().css('display','inline');
							jQuery('#editTargetsOkButton').button().button('disable');
							jQuery('.totalRevenueTargetDialog').text('-');
							return;
						}
						else {
							editTargetsDialogErrorMsg.hide();
							jQuery('#editTargetsOkButton').button().button('enable');
						}
						var targetInputs = editTable.find('input[type=text]');
						var totalRevenue = 0;
						targetInputs.each(function(idx, targetInput) {
							totalRevenue += parseFloat(jQuery(targetInput).val() || '0');
						});
						targetInputs = editTable.find('span.readOnlyTargetRevenueDialog');
						targetInputs.each(function(idx, targetInput) {
							totalRevenue += parseFloat(jQuery(targetInput).text() || '0');
						});							
						jQuery('.totalRevenueTargetDialog').text(formatRevenueTarget(Math.round(totalRevenue)));
					});
					
					editTable.append(jQuery('<tr/>')
						.append(jQuery('<td/>').text((typeof target.formattedPeriod === 'function') ? target.formattedPeriod() : target.formattedPeriod))
						.append(jQuery('<td/>').append(targetRevenueInput)));
				});	
				editTable.append(jQuery('<tr/>', {'class': 'totalRevenueTargetRow'}).append(jQuery('<td/>').text('Plan Target')).append(jQuery('<td/>', {'class': 'totalRevenueTargetDialog'}).text(cfgdata.formattedRevenueTarget)));				
				revenueTargetDialog.append(editTable);	
				revenueTargetDialog.append(editTargetsDialogErrorMsg.hide());		
				
				
				revenueTargetDialog.dialog('open');
				changesInTargets = false;
				jQuery('#revenueTargetValidationErrorDiv').hide().text('');
				
				
			}).addClass('ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only');
			
			
			var revenueTargetValidationErrorDiv = jQuery('<div/>', {id: 'revenueTargetValidationErrorDiv'});
			
			dlg.find('#SCORECARDTARGETS').append(revenueTargetsTitle).append(table).append(jQuery('<div/>').append(readonly ? null : targetConfigButton).append(revenueTargetValidationErrorDiv.hide()));
			
			computeTotalRevenueTarget();
			
						
		}	
		
		function formatRevenueTarget(quantity) {
			var quantity = quantity.toString();
			var formattedQuantity = '';
			var counter = 0;
			var counter2 = 0;
			for(counter = quantity.length; counter > 0; counter--) {
				if(formattedQuantity.length > 0 && counter2 % 3 === 0) {
					formattedQuantity = ((cfgdata && cfgdata.revenueCurrencySeparator) ? cfgdata.revenueCurrencySeparator : '') + formattedQuantity;
				}
				formattedQuantity = quantity[counter-1] + formattedQuantity;	
				counter2++;
			}
			return ((cfgdata && cfgdata.revenueCurrencySymbol) ? cfgdata.revenueCurrencySymbol : '') + formattedQuantity;
		}		
		
		function packageRevenueTargets() {
			jQuery.each(cfgdata.revenueTargets, function(idx, revenueTarget) {
				revenueTarget.fromDate = jQuery.datepicker.formatDate('yy-mm-dd', new Date(revenueTarget.fromDate - (-revenueTarget.fromDate.getTimezoneOffset() * 60000)));
				revenueTarget.toDate = jQuery.datepicker.formatDate('yy-mm-dd', new Date(revenueTarget.toDate - (-revenueTarget.toDate.getTimezoneOffset() * 60000)));
			});
			return cfgdata.revenueTargets;
		}		
			
		
		function renderMembers(cfgdata) {
			
			var table = jQuery('<table/>').addClass('opportunities').attr('id', 'MEMBERSTABLE');
			table.append(
				jQuery('<tr/>').append(
					jQuery('<th/>').text('Member')
				).append(
					jQuery('<th/>').text('Title')
				).append(
					jQuery('<th/>').text('Role')
				).append(
					jQuery('<th/>').text('Access').css('width','100px')
				).append(
					jQuery('<th/>').css('width','20px')
				)
			)

			jQuery.each(cfgdata.members, function(key, value) {
					table.append(
						memberLine(value.ownerId, value.name, value.title, value.role, value.permission, value.candelete)
					)
				}
			)
			
			dlg.find('#USERS').append(table);
			dlg.find('#USERS').append(jQuery('<BR/>'));
			if (!readonly && !inactive) {
				dlg.find('#USERS').attr('layout','user').scrollTop(0);

                var filterResultCallback = function(user) {
                    var currentMembers = cfgdata.members;
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
				jQuery('<span>').append(createButton().attr('value', 'New').click(function(){userMetadataControl.lookup.call(dlg.find('#USERS'), filterResultCallback, null, true);})).attr('layout','user').insertAfter(dlg.find('#USERS'))
			}
		}

		function memberLine(id, title, name, role, permission, candelete) {

			var optionRead = jQuery('<option>').attr('value', 'Read').text('Read only')
			var optionReadWrite = jQuery('<option>').attr('value', 'Edit').text('Read/Write')
			
			if (permission=='Read') optionRead.attr('selected', 'true');
			if (permission=='Edit') optionReadWrite.attr('selected', 'true');
				
			var tr = jQuery('<tr>').attr('id', id);
			
			tr.append(jQuery('<td>').text(title));
			
			tr.append(jQuery('<td>').text(name));
			
			tr.append(jQuery('<td>').text(role));

			var select = jQuery('<select>').append(
				optionReadWrite
			).append(
				optionRead
			).append(
				permission=='Default' ? jQuery('<option>').text('Default').attr('selected', 'true') : null
			)
			
			if (readonly || inactive || (id == userId && permission=='Read')) select.attr('disabled', 'true');
			
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
		
		function deleteMember() {

			var id = jQuery(this).parent().parent().attr('id');
			alertDialog(
					'Delete Team Member', 
					'Warning! This user will no longer have access to the account plan. Do you want to proceed?',
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

        	return jQuery('<input/>').attr('type','button').addClass('ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only');
        	                                    
        }
        
		
		
		function addUnit(callback) {
			var unitId = jQuery(this).parent().find('INPUT[type=\'hidden\']').val(); 
			var unitName = jQuery(this).parent().find('INPUT[type=\'text\']').val() || '';
			if(unitName.length > 80) {
			    unitName = unitName.substring(0, 80)
			}
			var ctrl = dlg.find('#SELECTEDUNITS UL').first();
			var item = createLI(ctrl, unitId, unitName, true, unitId, unitName, 0)
			ctrl.append(item);
			jQuery('DIV.AMCONFIGURATION').find('#SELECTEDUNITS').find('UL').sortable().sortable('refresh');

			jQuery(this).parent().find('INPUT[type=\'hidden\']').val(''); 
			jQuery(this).parent().find('INPUT[type=\'text\']').val('');
						
			if(callback) {
				callback(item);
			}
			
			return item;
		}

		function updateUnitType(unitItem, isParent) {
			// change style of parent (no target etc)
			if(isParent) {
				unitItem.children('.TARGET.TARGET_UNIT.TARGETED').addClass('WASTARGETED').removeClass('TARGETED');
				unitItem.children('.TARGET.TARGET_UNIT.UNTARGETED').addClass('WASUNTARGETED').removeClass('UNTARGETED');
				unitItem.children('.TARGET.TARGET_UNIT').addClass('PARENT');
				unitItem.children('.UNITNAME').addClass('PARENT');
			} else {
				unitItem.children('.WASTARGETED').addClass('TARGETED').removeClass('WASTARGETED');
				unitItem.children('.WASUNTARGETED').addClass('UNTARGETED').removeClass('WASUNTARGETED');
				unitItem.children('.TARGET.TARGET_UNIT').removeClass('PARENT');
				unitItem.children('.UNITNAME').removeClass('PARENT');
			}
		}

		function addUnitToParent(ctrl, units, parentId) {
		    jQuery.each(units, function(key, value) {
					if (value.parentUnitId == parentId) {
						var li = createLI(ctrl, value.id, value.name, false, value.accountId, value.accountName, value.opportunityCount, (value.memberAccounts && value.totalMemberAccounts.length > 0), value.accountType, value.targeted);
						var ul = li.children('ul').first();
						if (parentId == undefined) {
							jQuery(li).find('.UNITNAME').first().addClass('TOPLEVEL');
						} else {
							updateUnitType(jQuery('LI#'+parentId+'.ITEM.UNITID'), true);
						}
						ctrl.append(li);
						addUnitToParent(ul, units, value.id);
					}
				}
			)
		}

		function packageUnits(pack, parentId) {

			
			var ctrl;
			if (parentId == undefined) {
				ctrl= dlg.find('#SELECTEDUNITS UL').first();
			}
			else {
				ctrl= dlg.find('#SELECTEDUNITS UL[uid=' + parentId + ']').first();
			}
			
			var children = ctrl.children();
			jQuery.each(children, function(key, value) {
					
					value = jQuery(value);
					var id = value.attr('id');
					var accountId = value.attr('accountId');
					var uid = value.attr('uid');
					var unitId = value.attr('id');
					
					var obj = { 
						sortOrder: key, 
						parentUnitId: parentId, 
						uid: uid, 
						accountId: accountId, 
						name: jQuery(value).find('.UNITNAME').first().text(),
						memberAccounts: unitMemberAccountsMap[unitId || uid] || []
					};
					
					if(jQuery(value).find('.TARGET').length > 0) {
						obj.targeted = jQuery(value).find('.TARGET').first().hasClass('TARGETED');
					}
					else {
						obj.targeted = false;
					}
					
					if (value.hasClass('ACCOUNTID')) {

						// New
						obj.id = null;
					}
					else {
					
						// Old
						obj.id = id;
		
					}

					pack.push(obj)
					
					packageUnits(pack, uid);
					
				}
			)
			
			
		}
		
		function createLI(container, id, name, newUnit, accountId, accountName, opportunityCount, hasMemberAccounts, unitAccountType, targeted) {
			var uid = uniqueId++;
			
			var item = jQuery('<LI>').addClass('ITEM').addClass(newUnit ? 'ACCOUNTID': 'UNITID').attr('id', newUnit ? uid : id).attr('accountId', accountId).attr('uid', uid).attr('accountName', accountName).append(
						jQuery('<UL>').attr('uid', uid).attr('id', accountId)
					).disableSelection();

            var depth = container.parentsUntil("div#SELECTEDUNITS",'ul').length || 0;

			var ul = item.find('UL').first();
			
			var targetedSpan = jQuery('<span>').addClass('TARGET TARGET_UNIT').addClass(targeted ? 'TARGETED' : 'UNTARGETED');
			targetedSpan.insertBefore(ul);
			
			jQuery('<span>').addClass('UNITNAME').addClass(newUnit ? 'AVAILABLE': 'SELECTED').text(name).insertBefore(ul);
			if (opportunityCount > 0) {
			    jQuery('<span>').addClass('UNITOPPORTUNITYCOUNT').text(opportunityCount).insertBefore(ul)
		    }
			if (unitAccountType && unitAccountType !== '?') {
			    jQuery('<span>').addClass('UNITOPPORTUNITYCOUNT UNITACCOUNTTYPE').text(unitAccountType).insertBefore(ul)
		    }		    
			if (!readonly && !inactive) {
				if (opportunityCount == 0 &&  depth < 2) {
				    jQuery('<A>')
				        .text('Add')
				        .addClass('ADD')
				        .click(createChild)
				        .insertBefore(ul);
			    }
				jQuery('<A>').text('Edit').addClass('EDIT').click(editUnit).insertBefore(ul);
				jQuery('<A>').css('display', 'none').text('Create').addClass('CREATE').click(editUnit).insertBefore(ul);
				jQuery('<A>').addClass('DELETE').text('Delete').click(function() {
					deleteUnit(jQuery(this).parent())
				}).insertBefore(ul);
				targetedSpan.addClass('CLICKABLE').on('click', function() {
					var icon = jQuery(this);
					if(icon.hasClass('TARGETED')) {
						icon.removeClass('TARGETED').addClass('UNTARGETED');
					}
					else {
						icon.removeClass('UNTARGETED').addClass('TARGETED');
					}
				});
			}

			jQuery('<br>').insertBefore(ul)
			jQuery('<span>').addClass('ACCOUNTNAME').text(hasMemberAccounts ? '(Multiple Accounts)' : '(' + (accountName || 'No Access') + ')').insertBefore(ul)

			return item;
		
		}
		
		function createChild() {

			var parent = jQuery(this).parent();
			var unitName = parent.attr('accountname');
			var unitId = parent.attr('accountId');
			
			var ctrl = jQuery(this).parent().children('UL').first();
			var child = createLI(ctrl, unitId, unitName, true, unitId, unitName, 0);
			ctrl.append(child);

			updateUnitType(parent, true);

			child.children('.CREATE').trigger('click');
			
		}
		
		function editUnit() {
			
			var memberAccountLimitMsgShown = false;
		
			var isCreate = jQuery(this).hasClass('CREATE');

			var li = jQuery(this).parent();
			
			var parentUid = li.parent().parent().attr('id');
			
			var grandParentUid = li.parent().parent().parent().parent().attr('id');
			
			var uid = li.attr('uid');
			var unitId = li.attr('id');

			var unitMemberAccounts = jQuery.extend(true, [], unitMemberAccountsMap[unitId || uid] || []);
			
			var deletedAccounts = [];
			
			var ancestorUnitMemberAccounts = getAncestorUnitMemberAccounts(unitId, parentUid, grandParentUid);
			
			var parentId = li.parent().attr('uid');
			var isUnderAccountGroup = ancestorUnitMemberAccounts && ancestorUnitMemberAccounts.length > 0;


			var name = li.find('.UNITNAME').first().text();
			var accountName = li.attr('accountname');
			var accountId = li.attr('accountid');
			editUnitDlg = jQuery('<div>').addClass('UNITEDITDLG');
			editUnitDlg.html('<table>'+
					'<tr><td><span class="EDITUNITLABEL">Name:</span></td><td><input type="TEXT" id="UNITNAME" autocorrect="off" maxlength="80" size="80"/></td></tr>' +
					//'<tr><td><span class="EDITUNITLABEL">Parent:</span></td><td><select id="UNITPARENT"><option/></select></td></tr>' +
					((useAccountGrouping) ? '<tr><td><span class="EDITUNITLABEL">Type:</span></td><td><select id="UNIT_TYPE"><option value="single" selected="selected">Single Account</option><option value="multiple">Account Group</option></select></td></tr>' : '') +
					'<tr id="EDIT_UNIT_ROW"><td><span class="EDITUNITLABEL">Account:</span></td><td>' +
						'<input type="text" id="EDIT_UNITINPUT"  maxlength="80" size="80"/>' +
						'<input type="hidden" id="EDIT_UNITINPUT_ID"/>' +
						'<a id="EDIT_SEARCHACCOUNT" class="MAGNIFY"/>' +
					'</td></tr>' +
					'</table>' +
					'<select id="UNITPARENT" style="display:none;"><option/></select>' +
					(
					(useAccountGrouping)
					? 
					'<div id="unitMemberAccountsContainer">'+
						'<div id="unitMemberAccountsSlideContainer">'+
							'<div id="unitMemberAccountsTableScroll">'+
								'<table id="unitMemberAccountsTable">'+
									'<tr><th>Member Account</th><th>Account Id</th>' + buildAccountFieldHeaders() + '<th></th></tr>' +
								'</table>' +
							'</div>' +
							'<div id="unitMemberAccountsButtonBar">'+			
								'<input type="button" id="unitMemberAccountsAddButton" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Add Account"/>'+
								'<input type="hidden" id="unitMemberAccountsAddedAccount"/>' +
								'<span id="unitMemberAccountsNumberLabel"/>' +
							'</div>' +
						'</div>' +
					'</div>' 
					: 
					''
					) +
					
			'');
			
			
			
			var membersContainer = editUnitDlg.find('#unitMemberAccountsSlideContainer');
			var editUnitRow = editUnitDlg.find('#EDIT_UNIT_ROW');
			if(!accountId || unitMemberAccounts.length > 0 || isUnderAccountGroup) {
				editUnitDlg.find('#UNIT_TYPE').val('multiple');
				editUnitRow.hide();
				membersContainer.show();
			}
			else {
				editUnitDlg.find('#UNIT_TYPE').val('single');
				editUnitRow.show();
				membersContainer.hide();
			}
			
			editUnitDlg.find('#UNIT_TYPE').on('change', function() {
			
				if(jQuery(this).val() === 'multiple') {
					editUnitRow.hide();

					var single_acc_id = editUnitDlg.find('#EDIT_UNITINPUT_ID').val();
					var single_acc_name = editUnitDlg.find('#EDIT_UNITINPUT').val();
					
				    if(single_acc_id) {
				    	var single_acc =  {
							accountId : single_acc_id,
                        	accountName: single_acc_name
						};
							    
					unitMemberAccounts.push(single_acc);
					renderUnitMemberAccountsTable();
							
					}
					membersContainer.show();
				}
				else {
					editUnitRow.show();
					membersContainer.hide();
				}
				
			});			
			
			
			if(unitIdToParentUnitIdMap[unitId] && (!ancestorUnitMemberAccounts || ancestorUnitMemberAccounts.length === 0)) {
				editUnitDlg.find('#unitMemberAccountsAddButton')
					.attr('disabled', 'disabled')
					.button()	
					.button('disable')
					.addClass('ui-button-disabled ui-state-disabled');
			} else {

				editUnitDlg.find('#unitMemberAccountsAddButton')
					.removeAttr('disabled')
					.button()
					.button('enable')
					.removeClass('ui-button-disabled ui-state-disabled');	
			}
						
			var isUnit = li.hasClass('UNITID');
			var isAccount = li.hasClass('ACCOUNTID');
			
			editUnitDlg.find('#UNITPARENT').on('change', function() {
				var addAccountButton = editUnitDlg.find('#unitMemberAccountsAddButton');
				if(!jQuery(this).val() || jQuery(this).val().trim() === '') {
					if(addAccountButton) {
						addAccountButton.removeAttr('disabled').removeClass('ui-state-disabled');
					}
				}
				else {
					if(addAccountButton) {
						addAccountButton.attr('disabled', 'disabled').addClass('ui-state-disabled');
					}
				}
			});
			
			var buttons = [
							{
								text: 'Save', ttgid: "EDIT_UNIT_SAVEBUTTON", 
								click: function() {
									var accountName = editUnitDlg.find('#EDIT_UNITINPUT').val() 
									var accountId = editUnitDlg.find('#EDIT_UNITINPUT_ID').val()
									var accountType = editUnitDlg.find('#UNIT_TYPE').val();
									var parentId = li.parent().attr('uid');																		
									if (accountId == '' && accountType !== 'multiple' || accountType == 'multiple' && unitMemberAccounts.length <= 0 && !parentId) {
										// Feck, they've modified the account name and haven't selected anything!

										alertDialog(
												'Error', 
												'Account selection wasn\'t confirmed.  Please select the account from the list that displays below the input or use the search button to select an account',
												{
													'Ok': function() {
														jQuery(this).dialog('close'); 
													}
												}
										)
										
										return;
									} else if ((ancestorUnitMemberAccounts && ancestorUnitMemberAccounts.length === 0) && (unitMemberAccounts && unitMemberAccounts.length === 0) && accountType == 'multiple') {
										// Feck, they've modified the account name and haven't selected anything!

										alertDialog(
												'Error', 
												'Account selection wasn\'t confirmed.  Please select the accounts using the Add Account button',
												{
													'Ok': function() {
														jQuery(this).dialog('close'); 
													}
												}
										)
										
										return;
									}

									var units = [];
									unitMemberAccountsMap[unitId || uid] = unitMemberAccounts;
									
									if(deletedAccounts && deletedAccounts.length > 0) {
										for(var i = 0; i < deletedAccounts.length; i++) {
											var unitIdsWithDeletedMemberAccount = [];
											getChildUnitsContainingMemberAccount(unitIdsWithDeletedMemberAccount, unitId, deletedAccounts[i]);
											for(var j = 0; j < unitIdsWithDeletedMemberAccount.length; j++) {
												unitMemberAccountsMap[unitIdsWithDeletedMemberAccount[j]] = _.filter(unitMemberAccountsMap[unitIdsWithDeletedMemberAccount[j]], function(member) { return member.accountId !== deletedAccounts[i]; });
											}
										}
									}
									
									
									packageUnits(units, undefined)
									
									var unitname = jQuery.trim(editUnitDlg.find('#UNITNAME').val());
									if (unitname == '') {
										alertDialog(
												'Error', 
												'Unit name is required',
												{
													'Ok': function() { 
														jQuery(this).dialog('close'); 
													}
												}
										)
										return;
									}
										
									var clash = false;
									jQuery.each(units, function(key, value) {
						
											if (value.name.toLowerCase() == unitname.toLowerCase() && value.uid != uid) {
												clash = true;
											}
										
										}
						
									)
									if (clash) {

										alertDialog(
												'Error', 
												'Unit names must be unique',
												{
													'Ok': function() { 
														jQuery(this).dialog('close'); 
													}
												}
										)
										return;

									}
									
									if(accountType === 'multiple') {
										accountId = '';
										accountName = '';
									}
									else {
										unitMemberAccountsMap[unitId || uid] = [];
									}									
									
									var parentUnitId = jQuery(li).parent().parent().attr('id');  
									if(!parentUnitIdToDescendantUnitIds[parentUnitId]) {
										parentUnitIdToDescendantUnitIds[parentUnitId] = [];
									}
									parentUnitIdToDescendantUnitIds[parentUnitId].push(unitId);
									parentUnitIdToDescendantUnitIds[parentUnitId] = _.uniq(parentUnitIdToDescendantUnitIds[parentUnitId]);
									if(!unitsById[unitId]) {
										unitsById[unitId] = { id: unitId, name: unitname, parentUnitId:parentUnitId };
									}
										
									if(unitIdToParentUnitIdMap[unitId]) {
										unitIdToParentUnitIdMap[unitId] = parentUnitId;
									}
																	


									jQuery(li).attr('accountid', accountId)
									jQuery(li).attr('accountname', accountName)
									jQuery(li).children('SPAN.ACCOUNTNAME').text(accountType === 'multiple' ? '(Multiple Accounts)' : '(' + accountName + ')');
									jQuery(li).find('.UNITNAME').first().text(editUnitDlg.find('#UNITNAME').val());
									var newParentId = editUnitDlg.find('#UNITPARENT').val();
		
									parentId = parentId || '';
		
									if (parentId != newParentId) {
									
										var newparent;
										if (newParentId != '') {
											newparent = jQuery(dlg).find('UL[uid=' + newParentId + ']');
											jQuery(li).find('.UNITNAME').first().removeClass('TOPLEVEL');
											
											var depth = newparent.parentsUntil("div#SELECTEDUNITS",'ul').length;
											
											if(depth < 2) {
                                                 if(jQuery(li).find('a.ADD').length == 0 && 
                                                      jQuery(li).find('span.UNITOPPORTUNITYCOUNT').length == 0) 
                                                 {
                                                     var ul = jQuery(li).find('UL').first();
                                                     jQuery('<A>')
                                                        .text('Add')
                                                        .addClass('ADD')
                                                        .click(createChild)
                                                        .insertBefore(ul);
                                                }
											} else {
											    jQuery(li).find('a.ADD').remove();
											}
										}
										else {
											newparent = jQuery(dlg).find('UL#ROOTUNITSORTING');
											jQuery(li).find('.UNITNAME').first().addClass('TOPLEVEL');
											
											if(jQuery(li).find('a.ADD').length == 0 && 
											     jQuery(li).find('span.UNITOPPORTUNITYCOUNT').length == 0) 
											{
	                                            var ul = jQuery(li).find('UL').first();
	                                            jQuery('<A>')
                                                    .text('Add')
                                                    .addClass('ADD')
                                                    .click(createChild)
                                                    .insertBefore(ul);
											}
										}
										newparent.append(jQuery(li));
										
									}
		
									enableUnitSorting()

									//jQuery(this).dialog("close");
									editUnitDlg.remove();  
								}
								
								
							},
							{ 
								text: 'Cancel', 
								click: function() { 
									if (isCreate) { 
										//jQuery(li).remove();
										deleteUnit(li);
									} 
									jQuery(this).dialog("close") 
								}, 
								ttgid: "EDIT_UNIT_CANCELBUTTON" 
							}
						];
						
						
			if(checkForDuplicatedAccounts(unitMemberAccountsMap[unitId] || [])) {
				return;
			}
						
			editUnitDlg.dialog({ 
					modal: true, 
					resizable: false, 
					autoOpen: true, 
					title: isCreate ? 'Add Unit' : 'Edit Unit',
					width: 'auto',
					buttons: buttons, 
					height: 410,
					close: function() {
					 	if(isCreate) { 
							jQuery(li).remove();
						} 
						editUnitDlg.remove(); 
					}
				} 
			);
			
			// TODO
			if(ttg.isSalesforce1()) {
				jQuery('#UNITNAME').blur();
			}

			findPotentialParents(uid, editUnitDlg.find('#UNITPARENT'), 0);

			if(!(isCreate)) {
				editUnitDlg.find('#UNITNAME').val(name);				
				renderUnitMemberAccountsTable();
			}
			editUnitDlg.find('#UNITPARENT').val(parentId)


			editUnitDlg.find('#EDIT_UNITINPUT').val(accountName);
			editUnitDlg.find('#EDIT_UNITINPUT_ID').val(accountId);
			
			var childUnitMetadataControl = ttg.metadata(unitSearchSpec);
	
			editUnitDlg.find('#EDIT_UNITINPUT').autocomplete({ 
					open: function() {
						jQuery('.ui-autocomplete').addClass('scrolledAutocomplete');
						childUnitMetadataControl.autoCompleteClear();
					},  
					source:	function (term, callback) { 
						
						var cb = function(a, b, c) { showAjaxSpinner(false); return callback(a,b,c); }
						
						showAjaxSpinner(true);
						
						return childUnitMetadataControl.autoCompleteFind('account', term, cb)
						
					}, 
					select: function(event, ui) {
						childUnitMetadataControl.autoCompleteSelected.call(editUnitDlg.find('#EDIT_UNITINPUT'), event, ui);
						if(ui.item.Name) {
							setUnitNameField(ui.item.Name);
						}
					} 
				}
			).on('keydown', function(evt) { 
					jQuery(this).parent().find('INPUT[type=\'hidden\']').val(''); 
				}
			)	
			
			if (isCreate || (isAccount && !isUnit)) {
				editUnitDlg.find('#EDIT_SEARCHACCOUNT').click(editSearchAccount);
				editUnitDlg.find('#EDIT_SEARCHACCOUNT').parent().attr('layout','account');
			} else {
				editUnitDlg.find('#EDIT_UNITINPUT').attr('disabled', 'disabled');
				editUnitDlg.find('#EDIT_SEARCHACCOUNT').attr('disabled', 'disabled').hide();
			}
			
			
			var unitTypeDropdown = editUnitDlg.find('#UNIT_TYPE');
			unitTypeDropdown.attr('disabled', 'disabled');
			
			// Only top-level units with no children should allow for type change
			// Not committed toplevel units have a numeric unitId

			if(!parentId && (!parentUnitIdToDescendantUnitIds[unitId] || parentUnitIdToDescendantUnitIds[unitId].length === 0) && jQuery.isNumeric(unitId)) {
				unitTypeDropdown.removeAttr('disabled');
			}

			if(unitTypeDropdown.val()=='single' && !parentId){
				unitTypeDropdown.removeAttr('disabled');					
			}
						
			// that doesn't work for not committed toplevel units with children
			
			
			var unitMemberAccountSearchSpec = jQuery.extend({}, that.spec);
			unitMemberAccountSearchSpec.title = 'Unit Member Account Search';
			unitMemberAccountSearchSpec.autosearch = true;
			unitMemberAccountSearchSpec.multiSelect = true;
			unitMemberAccountSearchSpec.isoCode = isoCode;
			unitMemberAccountSearchSpec.lookup = { 
				callback: function(v) {
					if(unitMemberAccounts && unitMemberAccounts.length >= MAX_MEMBER_ACCOUNTS) {
						if(!memberAccountLimitMsgShown) {
							memberAccountLimitMsgShown = true;
							showMemberAccountLimitMsg('Some accounts were not added');
						}
						return;
					}
					var addedAccount = {
						accountId : v.Id,
                        accountName: v.Name
					};
					if(accountFields) {
						for(var aField in accountFields) {
							if(accountFields.hasOwnProperty(aField)) {
								addedAccount.accountFields = addedAccount.accountFields || {};
								addedAccount.accountFields[aField] = v[aField];
							}
						}
					}
					unitMemberAccounts.push(addedAccount);
					renderUnitMemberAccountsTable();
				} 
			};

		   unitMemberAccountSearchSpec.restrict = {'account': function() {
		   														var ret = '';
														   		var existingAccountIds = [];
														   		var existingAncestorAccountIds = [];
														   		
														        var currentMembers = unitMemberAccounts;
												                for(var i = 0; i < currentMembers.length; i++) {
												                	existingAccountIds.push('\'' + currentMembers[i].accountId + '\'');
												                }          
														        
														        if(existingAccountIds.length > 0) {
														        	ret = ' AND Id NOT IN (' + existingAccountIds.join() + ') ';
														        }
														        
												                if(ancestorUnitMemberAccounts && ancestorUnitMemberAccounts.length > 0) {
												                    for(var i = 0; i < ancestorUnitMemberAccounts.length; i++) {
												                    	existingAncestorAccountIds.push('\'' + ancestorUnitMemberAccounts[i] + '\'');
												                    }
												                }	
												                
												                var existingAncestorAccountIdsWhichAreNotCurrentMembers = _.difference(existingAncestorAccountIds, existingAccountIds);	
												                
														        if(existingAncestorAccountIdsWhichAreNotCurrentMembers.length > 0) {
														        	ret = ' AND Id IN (' + existingAncestorAccountIdsWhichAreNotCurrentMembers.join() + ') ';
														        }
														        else {
														        	if(existingAncestorAccountIdsWhichAreNotCurrentMembers.length === 0 && existingAncestorAccountIds.length > 0) {
														        		ret = ' AND Name = \'dummy_name_to_return_no_results\'';
														        	}
														        }										                											        
														        
														        return ret;
														         
														   }
		   };
			
			var unitMemberAccountSearchSpecMetadataControl = ttg.metadata(unitMemberAccountSearchSpec);			
			
			editUnitDlg.find('#unitMemberAccountsAddButton').click(editSearchUnitMemberAccount);
			editUnitDlg.find('#unitMemberAccountsAddButton').parent().attr('layout','account');


			function renderUnitMemberAccountsTable() {			
				if(useAccountGrouping) {
					var membersTable = editUnitDlg.find('#unitMemberAccountsTable');										

					membersTable.find('tr:not(:first)').remove();
					unitMemberAccounts.sort(function(a, b) {
						return (a.accountName < b.accountName) ? -1 : 1;
					});

					jQuery.each(unitMemberAccounts, function(idx, accountMember) {
						var row = jQuery('<tr/>').append(jQuery('<td/>').append(jQuery('<a/>', {href: '/' + accountMember.accountId, target: '_blank'}).text(accountMember.accountName).attr('ttgid', 'TBLMEMBERACCOUNT_name')))
											     .append(jQuery('<td/>').text(accountMember.accountId).attr('ttgid', 'TBLMEMBERACCOUNT_id'));
						if(accountFields) {
							for(var aField in accountFields) {
								if(accountFields.hasOwnProperty(aField)) {
									row.append(jQuery('<td/>').text(accountMember.accountFields ? accountMember.accountFields[aField] : ''));
								}
							}
						}
						membersTable.append(row.append(jQuery('<td/>').append(jQuery('<a/>').attr('ttgid', 'TBLMEMBERACCOUNT_modifier').addClass('DELETE').text('').click(function() { cascadeDeleteUnitMemberAccount(accountMember.accountId, accountMember.hasOpps); })))
										   );
					});			

					var ancestorMembers = 0;
					if(unitMemberAccounts && unitMemberAccounts.length > 0) {
						ancestorMembers = unitMemberAccounts.length;
					}
					else {
						ancestorMembers = getAncestorUnitMemberAccounts(unitId, li.parent().parent().attr('id'), li.parent().parent().parent().parent().attr('id')).length;
					}
					editUnitDlg.find('#unitMemberAccountsNumberLabel').text(ancestorMembers > 0 ? ancestorMembers + ' accounts associated with this plan unit' : 'No accounts associated with this plan unit');
				}
				
			}
			
			function editSearchUnitMemberAccount() {
				memberAccountLimitMsgShown = false;
				if(unitMemberAccounts && unitMemberAccounts.length >= MAX_MEMBER_ACCOUNTS) {
					showMemberAccountLimitMsg();
					return;
				}
                var filterResultCallback = function(account) {
                    return false;
                }
                
                var toautosearch = editUnitDlg.find('#UNITPARENT').val() || '';
                toautosearch = !(toautosearch.trim() === '');
                var localspec = jQuery.extend({}, unitMemberAccountSearchSpec);
                localspec.autosearch = toautosearch;
                var localSearch = ttg.metadata(localspec);
				localSearch.lookup.call(editUnitDlg.find('#unitMemberAccountsAddButton'), filterResultCallback, null, true);
			}
			
			function getChildUnitsContainingMemberAccount(units, unitId, accountId) {
				var childUnits = parentUnitIdToDescendantUnitIds[unitId];
				if(childUnits && childUnits.length > 0) {
					for(var i = 0; i < childUnits.length; i++) {
						var childUnitId = childUnits[i];
						if(unitMemberAccountsMap[childUnitId]) {
							var matchingMemberAccounts = _.where(unitMemberAccountsMap[childUnitId], {accountId: accountId});
							if(matchingMemberAccounts && matchingMemberAccounts.length > 0) {
								units.push(childUnitId);
							}
						}
						getChildUnitsContainingMemberAccount(units, childUnitId, accountId)
					}
				}
				else {
					return units;
				}
			}
			
			function cascadeDeleteUnitMemberAccount(accountId, hasOpps) {
				var unitIdsWithThatMemberAccount = [];
				getChildUnitsContainingMemberAccount(unitIdsWithThatMemberAccount, unitId, accountId);
				if(unitIdsWithThatMemberAccount && unitIdsWithThatMemberAccount.length > 0) {
					var unitsWithThatMemberAccount = [];
					var unitNames = [];
					for(var i = 0; i < unitIdsWithThatMemberAccount.length; i++) {
						unitsWithThatMemberAccount.push(unitsById[unitIdsWithThatMemberAccount[i]]);
						unitNames = _.pluck(unitsWithThatMemberAccount, 'name');
					}
					var accountName = _.where(unitMemberAccountsMap[unitId], {accountId: accountId})[0].accountName;
					var dialogDiv = jQuery('<div>').text('The following units have ' + accountName + ' as a member account:');
					dialogDiv.append(jQuery('<br/>'));
					jQuery.each(unitNames, function(idx, unitName) {
						dialogDiv.append(jQuery('<div>').text(' - ' + unitName));
					});
					dialogDiv.append(jQuery('<br/>'));
					dialogDiv.append(jQuery('<div>').text('The account will be deleted from all these units. Are you sure?'));
					dialogDiv.dialog({
						modal: true,
						width: '450px',
						title: 'Account included in child units',
						buttons: {
							'Ok' : function() { 
								doDeleteUnitMemberAccounts(accountId, hasOpps);
								dialogDiv.dialog('close'); 
							},
							'Cancel' : function() { dialogDiv.dialog('close'); }
						},
						close: function() { dialogDiv.remove() }
					});					
				}
				else {
					doDeleteUnitMemberAccounts(accountId, hasOpps);
				}
			}	
			
			function doDeleteUnitMemberAccounts(accountId, hasOpps) {	
				for(var i = 0; i < unitMemberAccounts.length; i++) {
					if(unitMemberAccounts[i].accountId === accountId) {
						unitMemberAccounts.splice(i, 1);
						break;
					}	
				}
				deletedAccounts.push(accountId);
				renderUnitMemberAccountsTable();			
			}		

			function editSearchAccount() {
				var	fndOpportunites = false;
	
	            //TODO fix up
	
				jQuery.each(li.find('.UNITOPPORTUNITYCOUNT'), function(key, value) {
				
						if (jQuery(value).text() != '') {
							fndOpportunites = true;
						}
					}
				);
	
				if (fndOpportunites) {
					
					alertDialog(
							'Edit Plan Unit', 
							'Warning! If the Account is changed, all unit related data will be deleted and opportunities associated with the unit will be removed from the plan. Do you want to proceed?',
							{
								'No': function() {
									jQuery(this).dialog('close'); 
									return;
								},
								'Yes': function() {
									jQuery(this).dialog('close'); 
									childUnitMetadataControl.lookup.call(editUnitDlg.find('#EDIT_SEARCHACCOUNT'));
								}
							}
					);
				} else {
					childUnitMetadataControl.lookup.call(editUnitDlg.find('#EDIT_SEARCHACCOUNT'));
				}
				
			}
		}

		function findPotentialParents(childId, selectCtrl, level, parentId) {
			
			var ctrl;
			if (parentId == undefined) {
				ctrl= dlg.find('#SELECTEDUNITS UL').first();
			}
			else {
				ctrl= dlg.find('#SELECTEDUNITS UL[uid='+ parentId +']').first();
			}
			
			var children = ctrl.children();
			jQuery.each(children, function(key, value) {
					
					value = jQuery(value);
					if (value.is('LI')) {
						var uid = value.attr('uid');
						if (uid != childId) {
							var name = value.find('.UNITNAME').first().text()
							
							//TODO fix up
							
							var opportunityCount = value.children('.UNITOPPORTUNITYCOUNT').first().text()
							
                            var depth = ctrl.parentsUntil("div#SELECTEDUNITS",'ul').length || 0;
                            //goes from parent id
							var option = jQuery('<option>').text(name).attr('value', uid).css('padding-left', level + 'em')
							if (opportunityCount != '' || depth > 1) {
								option.attr('disabled', 'true');
							}
							jQuery(selectCtrl).append(option);
	
							findPotentialParents(childId, selectCtrl, level+1, uid)
						}
					}
					
				}
			);
			
			if(level === 0 && selectCtrl.find('option').length === 1) {
				selectCtrl.attr('disabled', 'disabled');
				selectCtrl.find('option').text('None');
			}
			
			
		}

			function getAncestorUnitMemberAccounts(unitId, parentUnitId, grandParentUid) {
				var parentUnitId = unitIdToParentUnitIdMap[unitId] || parentUnitId;
				if(parentUnitId) {
					var parentUnitMemberAccounts = unitMemberAccountsMap[parentUnitId];
					if(parentUnitMemberAccounts && parentUnitMemberAccounts.length > 0) {
						return _.pluck(parentUnitMemberAccounts, 'accountId');
					}
					else {
						return getAncestorUnitMemberAccounts(parentUnitId, grandParentUid);
					}
				}
				return [];
			}
			
			function buildAccountFieldHeaders() {
				var ret = '';
				if(accountFields) {
					for(var aField in accountFields) {
						if(accountFields.hasOwnProperty(aField)) {
							ret += '<th>' + accountMetadata[aField] + '</th>';
						}
					}
				}
				return ret;
			}	
			
			
			
			function checkForDuplicatedAccounts(memberAccounts) {
			
				if(checkMemberAccountsDuplicates(_.pluck(memberAccounts, 'accountId'))) {
					var warningDialogDiv = jQuery('<div>').text('There are duplicated member accounts in this unit. Please remove inconsistent data using Salesforce admin pages');
					warningDialogDiv.dialog({
						modal: true,
						title: 'Inconsistent data',
						buttons: {
							'Ok' : function() { warningDialogDiv.dialog('close'); }
						},
						close: function() { warningDialogDiv.remove() }
					});
					return true;
				}	
				
				return false;		
		
				function checkMemberAccountsDuplicates(accountList) {
					if(accountList && accountList.length > 1) {
						var duplicatedFreeAccountList = _.uniq(accountList);
						if(duplicatedFreeAccountList.length !== accountList.length) {
							return true;
						}
					}
					return false;
				}			
			
			}
			
			function showMemberAccountLimitMsg(additionalMsg) {
				var dialogDiv = jQuery('<div>').text('You can only add 300 member accounts to an unit');
				dialogDiv.append(jQuery('<br/>'));
				if(additionalMsg) {
					dialogDiv.append(jQuery('<div>').text(additionalMsg)).append(jQuery('<br/>'));
				}
				dialogDiv.dialog({
					modal: true,
					width: '325px',
					title: 'Member accounts limit exceeded',
					buttons: {
						'Ok' : function() { dialogDiv.dialog('close'); }
					},
					close: function() { dialogDiv.remove(); }
				});				
			}			

		function createNewUnit(item) {
			
			var memberAccountLimitMsgShown = false;

			var li = item;
			
			var uid = li.attr('uid');
			var unitId = li.attr('id');

			var unitMemberAccounts = [];
			
			var deletedAccounts = [];


			var name = li.find('.UNITNAME').first().text();
			var accountName = li.attr('accountname');
			var accountId = li.attr('accountid');
			editUnitDlg = jQuery('<div>').addClass('UNITEDITDLG');
			editUnitDlg.html('<table>'+
					'<tr><td><span class="EDITUNITLABEL">Name:</span></td><td><input type="TEXT" id="UNITNAME" maxlength="80" size="80"/></td></tr>' +
					((useAccountGrouping) ? '<tr><td><span class="EDITUNITLABEL">Type:</span></td><td><select id="UNIT_TYPE"><option value="single" selected="selected">Single Account</option><option value="multiple">Account Group</option></select></td></tr>' : '') +
					'<tr id="EDIT_UNIT_ROW"><td><span class="EDITUNITLABEL">Account:</span></td><td>' +
						'<input type="text" id="EDIT_UNITINPUT"  maxlength="80" size="80"/>' +
						'<input type="hidden" id="EDIT_UNITINPUT_ID"/>' +
						'<a id="EDIT_SEARCHACCOUNT" class="MAGNIFY"/>' +
					'</td></tr>' +
					'</table>' +
					(
					(useAccountGrouping)
					? 
					'<div id="unitMemberAccountsContainer">'+
						'<div id="unitMemberAccountsSlideContainer">'+
							'<div id="unitMemberAccountsTableScroll">'+
								'<table id="unitMemberAccountsTable">'+
									'<tr><th>Member Account</th><th>Account Id</th>' + buildAccountFieldHeaders() + '<th></th></tr>' +
								'</table>' +
							'</div>' +
							'<div id="unitMemberAccountsButtonBar">'+			
								'<input type="button" id="unitMemberAccountsAddButton" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" value="Add Account"/>'+
								'<input type="hidden" id="unitMemberAccountsAddedAccount"/>' +
								'<span id="unitMemberAccountsNumberLabel"/>' +
							'</div>' +
						'</div>' +
					'</div>' 
					: 
					''
					) +
					
			'');
			
			var membersContainer = editUnitDlg.find('#unitMemberAccountsSlideContainer');
			membersContainer.hide();
			
			editUnitDlg.find('#UNIT_TYPE').on('change', function() {
				var editUnitRow = editUnitDlg.find('#EDIT_UNIT_ROW');
				if(jQuery(this).val() === 'multiple') {
					editUnitRow.hide();
					membersContainer.show();
				}
				else {
					editUnitRow.show();
					membersContainer.hide();
				}
				
			});
			
			
			if(unitIdToParentUnitIdMap[unitId]) {
				editUnitDlg.find('#unitMemberAccountsAddButton').attr('disabled', 'disabled').button().button('disable').addClass('ui-button-disabled ui-state-disabled');	
			}
			else {
				editUnitDlg.find('#unitMemberAccountsAddButton').removeAttr('disabled').button().button('enable').removeClass('ui-button-disabled ui-state-disabled');	
			}
			
			var isUnit = li.hasClass('UNITID');
			var isAccount = li.hasClass('ACCOUNTID');
			
			editUnitDlg.find('#UNITPARENT').on('change', function() {
				var addAccountButton = editUnitDlg.find('#unitMemberAccountsAddButton');
				if(!jQuery(this).val() || jQuery(this).val().trim() === '') {
					if(addAccountButton) {
						addAccountButton.removeAttr('disabled').removeClass('ui-state-disabled');
					}
				}
				else {
					if(addAccountButton) {
						addAccountButton.attr('disabled', 'disabled').addClass('ui-state-disabled');
					}
				}
			});
			
			var buttons = [
							{
								text: 'Save', ttgid: "EDIT_UNIT_SAVEBUTTON", 
								click: function() {
								
									var accountName = editUnitDlg.find('#EDIT_UNITINPUT').val();
									var accountId = editUnitDlg.find('#EDIT_UNITINPUT_ID').val();
									var accountType = editUnitDlg.find('#UNIT_TYPE').val();									
									if (accountId == '' && accountType !== 'multiple' || accountType == 'multiple' && unitMemberAccounts.length <= 0){									
										// Feck, they've modified the account name and haven't selected anything!

										alertDialog(
												'Error', 
												'Account selection wasn\'t confirmed.  Please select the account from the list that displays below the input or use the search button to select an account',
												{
													'Ok': function() {
														jQuery(this).dialog('close'); 
													}
												}
										)
										
										return;
									} else if ((unitMemberAccounts && unitMemberAccounts.length === 0) && accountType == 'multiple') {
										// Feck, they've modified the account name and haven't selected anything!

										alertDialog(
												'Error', 
												'Account selection wasn\'t confirmed.  Please select the accounts using the Add Account button',
												{
													'Ok': function() {
														jQuery(this).dialog('close'); 
													}
												}
										)
										
										return;
									}

									
									var units = [];
									unitMemberAccountsMap[unitId || uid] = unitMemberAccounts;

									packageUnits(units, undefined)
									
									var unitname = jQuery.trim(editUnitDlg.find('#UNITNAME').val());
									if (unitname == '') {
										alertDialog(
												'Error', 
												'Unit name is required',
												{
													'Ok': function() { 
														jQuery(this).dialog('close'); 
													}
												}
										)
										return;
									}
										
									var clash = false;
									jQuery.each(units, function(key, value) {
						
											if (value.name.toLowerCase() == unitname.toLowerCase() && value.uid != uid) {
												clash = true;
											}
										
										}
						
									)
									if (clash) {

										alertDialog(
												'Error', 
												'Unit names must be unique',
												{
													'Ok': function() { 
														jQuery(this).dialog('close'); 
													}
												}
										)
										return;

									}
									
									if(accountType === 'multiple') {
										accountId = '';
										accountName = '';
									}
									else {
										unitMemberAccountsMap[unitId || uid] = [];
									}
									
									
									if(!unitsById[unitId]) {
										unitsById[unitId] = { id: unitId, name: unitname, parentUnitId:null };
									}
	
									if(unitIdToParentUnitIdMap[unitId]) {
										unitIdToParentUnitIdMap[unitId] = null;
									}


									jQuery(li).attr('accountid', accountId)
									jQuery(li).attr('accountname', accountName)
									jQuery(li).children('SPAN.ACCOUNTNAME').text(accountType === 'multiple' ? '(Multiple Accounts)' : '(' + accountName + ')');
									jQuery(li).find('.UNITNAME').first().text(editUnitDlg.find('#UNITNAME').val());
									
									enableUnitSorting()

									editUnitDlg.remove(); 
								}
								
								
							},
							{ 
								text: 'Cancel', 
								click: function() { 
									jQuery(li).remove();
									jQuery(this).dialog("close") 
								}, 
								ttgid: "EDIT_UNIT_CANCELBUTTON" 
							}
						];
						
						
			if(checkForDuplicatedAccounts(unitMemberAccountsMap[unitId] || [])) {
				return;
			}
						
			editUnitDlg.dialog({ 
					modal: true, 
					resizable: false, 
					autoOpen: true, 
					title: 'Add Unit',
					width: 'auto',
					height: 410,
					buttons: buttons, 
					close: function() {
						jQuery(li).remove();
						editUnitDlg.remove(); 
					}   
				} 
			);

			editUnitDlg.find('#EDIT_UNITINPUT').val(accountName); 
			editUnitDlg.find('#EDIT_UNITINPUT_ID').val(accountId); 

			var childUnitMetadataControl = ttg.metadata(unitSearchSpec);
	
			editUnitDlg.find('#EDIT_UNITINPUT').autocomplete({ 
					open: function() {
						jQuery('.ui-autocomplete').addClass('scrolledAutocomplete');
						childUnitMetadataControl.autoCompleteClear();
					}, 
					source:	function (term, callback) { 
						
						var cb = function(a, b, c) { showAjaxSpinner(false); return callback(a,b,c); }
						
						showAjaxSpinner(true);
						
						return childUnitMetadataControl.autoCompleteFind('account', term, cb)
						
					}, 
					select: function(event, ui) {
						childUnitMetadataControl.autoCompleteSelected.call(editUnitDlg.find('#EDIT_UNITINPUT'), event, ui);
						if(ui.item.Name) {
							setUnitNameField(ui.item.Name);
						}
					} 
				}
			).on('keydown', function(evt) { 
					jQuery(this).parent().find('INPUT[type=\'hidden\']').val(''); 
				}
			)	
			

			editUnitDlg.find('#EDIT_SEARCHACCOUNT').click(editSearchAccount);
			editUnitDlg.find('#EDIT_SEARCHACCOUNT').parent().attr('layout','account');			
			editUnitDlg.find('#unitMemberAccountsContainer').show();
			
			
			var unitMemberAccountSearchSpec = jQuery.extend({}, that.spec);
			unitMemberAccountSearchSpec.title = 'Unit Member Account Search';
			unitMemberAccountSearchSpec.autosearch = true;
			unitMemberAccountSearchSpec.multiSelect = true;
			unitMemberAccountSearchSpec.isoCode = isoCode;
			unitMemberAccountSearchSpec.lookup = { 
				callback: function(v) {
					if(unitMemberAccounts && unitMemberAccounts.length >= MAX_MEMBER_ACCOUNTS) {
						if(!memberAccountLimitMsgShown) {
							memberAccountLimitMsgShown = true;
							showMemberAccountLimitMsg('Some accounts were not added');
						}
						return;
					}
					var addedAccount = {
						accountId : v.Id,
                        accountName: v.Name
					};
					if(accountFields) {
						for(var aField in accountFields) {
							if(accountFields.hasOwnProperty(aField)) {
								addedAccount.accountFields = addedAccount.accountFields || {};
								addedAccount.accountFields[aField] = v[aField];
							}
						}
					}
					unitMemberAccounts.push(addedAccount);
					renderUnitMemberAccountsTable();
				} 
			};

		   unitMemberAccountSearchSpec.restrict = {'account': function() {
		   														var ret = '';
														   		var existingAccountIds = [];
														   		
														        var currentMembers = unitMemberAccounts;
												                for(var i = 0; i < currentMembers.length; i++) {
												                	existingAccountIds.push('\'' + currentMembers[i].accountId + '\'');
												                }          
														        
														        if(existingAccountIds.length > 0) {
														        	ret = ' AND Id NOT IN (' + existingAccountIds.join() + ') ';
														        }									                											        
														        
														        return ret;
														         
														   }
		   };
			
			var unitMemberAccountSearchSpecMetadataControl = ttg.metadata(unitMemberAccountSearchSpec);			
			
			editUnitDlg.find('#unitMemberAccountsAddButton').click(editSearchUnitMemberAccount);
			editUnitDlg.find('#unitMemberAccountsAddButton').parent().attr('layout','account');

			
			function renderUnitMemberAccountsTable() {
				if(useAccountGrouping) {				
					var membersTable = editUnitDlg.find('#unitMemberAccountsTable');
					membersTable.find('tr:not(:first)').remove();
					unitMemberAccounts.sort(function(a, b) {
						return (a.accountName < b.accountName) ? -1 : 1;
					});
					jQuery.each(unitMemberAccounts, function(idx, accountMember) {
						var row = jQuery('<tr/>').append(jQuery('<td/>').append(jQuery('<a/>', {href: '/' + accountMember.accountId, target: '_blank'}).text(accountMember.accountName).attr('ttgid', 'TBLMEMBERACCOUNT_name')))
											     .append(jQuery('<td/>').text(accountMember.accountId).attr('ttgid', 'TBLMEMBERACCOUNT_id'));
						if(accountFields) {
							for(var aField in accountFields) {
								if(accountFields.hasOwnProperty(aField)) {
									row.append(jQuery('<td/>').text(accountMember.accountFields ? accountMember.accountFields[aField] : ''));
								}
							}
						}
						membersTable.append(row.append(jQuery('<td/>').append(jQuery('<a/>').attr('ttgid', 'TBLMEMBERACCOUNT_modifier').addClass('DELETE').text('').click(function() { doDeleteUnitMemberAccounts(accountMember.accountId, accountMember.hasOpps); })))
										   );
					});			
					editUnitDlg.find('#unitMemberAccountsNumberLabel').text(unitMemberAccounts.length > 0 ? unitMemberAccounts.length + ' accounts associated with this plan unit' : 'No accounts associated with this plan unit');
				}
			}
			
			
			function editSearchUnitMemberAccount() {
				memberAccountLimitMsgShown = false;
				if(unitMemberAccounts && unitMemberAccounts.length >= MAX_MEMBER_ACCOUNTS) {
					showMemberAccountLimitMsg();
					return;
				}
                var filterResultCallback = function(account) {
                    return false;
                }
                
                var toautosearch = editUnitDlg.find('#UNITPARENT').val() || '';
                toautosearch = !(toautosearch.trim() === '');
                var localspec = jQuery.extend({}, unitMemberAccountSearchSpec);
                localspec.autosearch = toautosearch;
                var localSearch = ttg.metadata(localspec);
				localSearch.lookup.call(editUnitDlg.find('#unitMemberAccountsAddButton'), filterResultCallback, null, true);
			}

			
			function doDeleteUnitMemberAccounts(accountId, hasOpps) {	
				for(var i = 0; i < unitMemberAccounts.length; i++) {
					if(unitMemberAccounts[i].accountId === accountId) {
						unitMemberAccounts.splice(i, 1);
						break;
					}	
				}
				deletedAccounts.push(accountId);
				renderUnitMemberAccountsTable();			
			}		

			function editSearchAccount() {
				childUnitMetadataControl.lookup.call(editUnitDlg.find('#EDIT_SEARCHACCOUNT'));
			}
		}
		
		
		function deleteUnit(li) {
			var	fndOpportunites = false;
			
			var unitId = jQuery(li).attr('id');
			var parentUnitId = jQuery(li).parent().parent().attr('id');  
			//TODO FIX UP ...
			
			jQuery.each(li.find('.UNITOPPORTUNITYCOUNT'), function(key, value) {
			
					if (jQuery(value).text() != '') {
						fndOpportunites = true;
					}
				}
			)
			if (fndOpportunites) {
				
				alertDialog(
						'Delete Plan Unit', 
						'Warning! All unit related data will be deleted and opportunities associated with the unit will be removed from the plan. Do you want to proceed?',
						{
							'Yes': function() {
								cleanUnitMaps(unitId, parentUnitId);
								jQuery(li).remove(); 
								jQuery(this).dialog('close'); 
							},
							'No': function() {
								jQuery(this).dialog('close'); 
							}
						}
				)

			}
			else {
				cleanUnitMaps(unitId, parentUnitId);
				var hasSibilings = li.siblings('LI.ITEM.UNITID').size() > 0;
				li.remove();
				updateUnitType(jQuery('LI#'+parentUnitId+'.ITEM.UNITID'), hasSibilings);
			}
		}
		
		function cleanUnitMaps(unitId, parentUnitId) {
			if(parentUnitIdToDescendantUnitIds[parentUnitId]) {
				parentUnitIdToDescendantUnitIds[parentUnitId] = _.filter(parentUnitIdToDescendantUnitIds[parentUnitId], function(childId) { return unitId !== childId; });
				if(parentUnitIdToDescendantUnitIds[unitId]) {
					delete parentUnitIdToDescendantUnitIds[unitId];
				}
				if(unitsById[unitId]) {
					delete unitsById[unitId];
				}
			}		
		}
		
		function deletePlan() {

			alertDialog(
				'Delete Account Plan', 
				'Warning! All plan related data will be deleted and all opportunities associated with the plan will be removed. Do you want to proceed?',
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

		function saveAs(cfgdata) {
			dlg = jQuery('<div>').addClass('AMCOPY');

            var xvar = iPad ? 220 : 420;
            var yvar = iPad ? 230 : 230;

            var detailDiv = jQuery('<div/>', {id: 'planCopyDetail'});
            var nameLabel = jQuery('<span/>', {id: 'planCopyNameLabel'}).text('Name: ');
			var validationDiv = jQuery('<div/>').addClass('planCloneError').text('Plan name is a mandatory field');

            var planname = cfgdata.planname.length > 72 ? cfgdata.planname.substring(0,72) : cfgdata.planname;
            var nameInput = jQuery('<input/>', {id: 'planCopyNameInput', type: 'text', maxlength: 80, size: 60}).val(planname + ' (clone)');
            detailDiv.append(nameLabel).append(nameInput).append(validationDiv.hide());

            dlg.dialog({
                modal: true,
                title: 'Plan Clone',
                dialogClass: ttg_salesforce1 ? 'planCloneDialog' : '',
                autoOpen: false,
                position: [jQuery(document).width() / 2 - xvar, yvar],
                width: '620px',
                buttons: {
                        
                        'Save' : {
                            id: 'planCopyDialogSave',
                            click: function() {
                            	var planName = nameInput.val();
                            	if(!planName || planName.trim().length === 0) {
                            		validationDiv.show();
                            		return;
                            	}
                            	else {
                            		validationDiv.hide();
                            	}
								jQuery('#planCopyDialogSave').attr('disabled', 'true');
								_wrapClone (planName, refreshPageClone);
                            },
                            text: 'Save'
                        },
                        'Cancel' : {
                            id: 'planCopyDialogCancel',
                            click: function() {
                                dlg.dialog('close');
                            },
                            text: 'Cancel'
                        }
                }, open: function() {               
                	
                	jQuery('#planCopyNameInput').select();
                	
                	if (ttg.isSalesforce1()) {                	
						
						jQuery('#planCopyNameInput').blur();
					}                
                }
            });

			dlg.append(detailDiv);
			
            dlg.dialog('open').css('min-height', '80px');				
		}
		

		function save() {
			var availableSolutions = dlg.find('#AVAILABLESOLUTIONS');
			var removedItems = availableSolutions.find('LI.AVAILABLE');
			var removed = [];
			var fndRemoved = false;
			var solution;

			jQuery.each(removedItems, function(key, value) {
	
					solution = {id: jQuery(value).attr('id') };
					removed.push( solution );
					fndRemoved = true;

				} 
			)
			var selectedSolutions = dlg.find('#SELECTEDSOLUTIONS');
			var addedItems = showSolutionFamilies ? selectedSolutions.find('LI.FAMILYMEMBER, LI.NOFAMILY') : selectedSolutions.find('LI');
			var added = [];
			var fndAdded = false;
			var sortOrder = 1;
			jQuery.each(addedItems, function(key, value) {
					
					solution = {id: jQuery(value).attr('id'), sortOrder: sortOrder++, targeted: jQuery(value).find('span.TARGETED').length > 0 };
					//solution = {id: jQuery(value).attr('id'), sortOrder: sortOrder++, targeted: jQuery(value).find('input:checked').length > 0 };
					added.push (solution) ;
					fndAdded = true;
			
				} 
			)
		
			var units = [];
			packageUnits(units, undefined)
			
			var params = { }
			params.plantype = dlg.find('#PLANTYPE').val();
			params.chattergroupid = dlg.find('#CHATTERGROUP').val();
			params.autopostchatter = showAutoPostOption ? dlg.find('#AUTO_POST_CHATTER').is(':checked') : false;
			params.planname = jQuery.trim(dlg.find('#PLANNAME').val());
			
			try {
				params.fromDate = jQuery.datepicker.parseDate(dateFormat, dlg.find('#FROMDATE').val());
			}
			catch(e) {
				dlg.find('A[href=\'#tabs-1\']').trigger('click');
				alertDialog(
						'Error', 
						'From date is invalid',
						{
							'Ok': function() { 
								jQuery(this).dialog('close'); 
							}
						}
				)
				return;
				
			}
			
			try {
				params.toDate = jQuery.datepicker.parseDate(dateFormat, dlg.find('#TODATE').val());
			}
			catch(e) {
				dlg.find('A[href=\'#tabs-1\']').trigger('click');
				alertDialog(
						'Error', 
						'To date is invalid',
						{
							'Ok': function() { 
								jQuery(this).dialog('close'); 
							}
						}
				)

				return;
				
			}

			params.fromDate = jQuery.datepicker.formatDate('yy-mm-dd', params.fromDate);
			params.toDate = jQuery.datepicker.formatDate('yy-mm-dd', params.toDate);

			
			if (fndAdded) params.addedSolutions = added
			if (fndRemoved) params.removedSolutions = removed
			params.units = units
			params.members = packageMembers();
			params.ownerId = dlg.find('#OWNERINPUT_ID').val(); 

			// Validation
			
			// max number of plan team members is 300
			var myContents = dlg.find('table#MEMBERSTABLE').find('TR');
            var totalMembersSize = 0;
            
            jQuery.each(myContents, function(key, value) {
            	
            	var id = jQuery(value).attr('id')
				if (id != undefined) {
            		totalMembersSize++;
            	}
            })

			if ( totalMembersSize > 300 ) {

				dlg.find('A[href=\'#tabs-4\']').trigger('click');
				alertDialog(
						'Error', 
						'Max number of plan team members is 300',
						{
							'Ok': function() { 
								jQuery(this).dialog('close'); 
							}
						}
				)

				return;
			}
			
			if ( !params.plantype || params.plantype == '-1' ) {

				// We need a plan type
				dlg.find('A[href=\'#tabs-1\']').trigger('click');
				alertDialog(
						'Error', 
						'Enter a plan type',
						{
							'Ok': function() { 
								jQuery(this).dialog('close'); 
							}
						}
				)

				return;
			}
			
			if(new Date(params.toDate).getUTCFullYear() - new Date(params.fromDate).getUTCFullYear() + 1 > MAX_REVENUE_TARGETS) {
			
				dlg.find('A[href=\'#tabs-1\']').trigger('click');
				alertDialog(
						'Error', 
						maxRevenueTargetReached,
						{
							'Ok': function() { 
								jQuery(this).dialog('close'); 
							}
						}
				)

				return;
			}			
			
			if(changesInTargets && (planId == undefined || planId == '')) {
			
				dlg.find('A[href=\'#tabs-1\']').trigger('click');
				alertDialog(
						'Error', 
						revenueTargetsChangedWarning,
						[
						    {
							    text: 'Save',
							    click: function() { 
								    jQuery(this).dialog('close'); 
								    finishSaving();
							    },
							    ttgid:   'RevenueErrorSAVEBUTTON'
							},
							{
							    text: 'Cancel',
							    click: function() { 
								    jQuery(this).dialog('close'); 
								    return;
							    },
							    ttgid: 'RevenueErrorCANCELBUTTON'
							}
						]
				)
			}	
			else {
				finishSaving();
			}		

			function finishSaving() {
			
				if (params.planname == '') {
	
					// We need a plan name
					dlg.find('A[href=\'#tabs-1\']').trigger('click');
					alertDialog(
							'Error', 
							'Enter a plan name',
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
							'New plan owner wasn\'t confirmed.  Please select the owner from the list that displays below the input or use the search button to select the owner',
							{
								'Ok': function() { 
									jQuery(this).dialog('close'); 
								}
							}
					)
					return;
				}
				
				
				// Unique plan names
				params.units.sort(function(a, b) {
					if (a.name < b.name) return -1;
					if (a.name > b.name) return 1;
					return 0;
					}
				);
				
				var clash = false;
				var preName = '';
				jQuery.each(params.units, function(key, value) {
	
					if (value.name.toLowerCase() == preName.toLowerCase()) clash = true;
						preName = value.name;
					}
	
				)
	
				if (clash) {
					dlg.find('A[href=\'#tabs-3\']').trigger('click');
					alertDialog(
							'Error', 
							'Unit names must be unique',
							{
								'Ok': function() { 
									jQuery(this).dialog('close'); 
								}
							}
					)
					return;
				}			
				
				
				// Date range
	
				if (params.fromDate == '' || params.toDate == '') {
					dlg.find('A[href=\'#tabs-1\']').trigger('click');
	
					alertDialog(
							'Error', 
							'Date fields are required',
							{
								'Ok': function() { 
									jQuery(this).dialog('close'); 
								}
							}
					)
					return;
				}
				
				if (params.fromDate > params.toDate) {
					dlg.find('A[href=\'#tabs-1\']').trigger('click');
	
					alertDialog(
							'Error', 
							'From date must be before to date',
							{
								'Ok': function() { 
									jQuery(this).dialog('close'); 
								}
							}
					)
					return;
				}
				
	            
				if (planId == undefined || planId == '') {
					var now = new Date();
					var from = dlg.find('#FROMDATE').datepicker('getDate');
					var to = dlg.find('#TODATE').datepicker('getDate');
	
					if (to < now) {
						dlg.find('A[href=\'#tabs-1\']').trigger('click');
	
						alertDialog(
								'Warning', 
								'This plan will not be active as the to date is in the past.  Continue?',
								{
									'Yes': function() {
										params.revenueTargets = packageRevenueTargets();
										_wrapPutPost ({ param: params} , refreshPage);
										jQuery(this).dialog('close'); 
									},
									'No': function() {
										jQuery(this).dialog('close'); 
									}
								}
						)
						return;
					}
				}
				
				params.revenueTargets = packageRevenueTargets();				
			
				_wrapPutPost ({ param: params} , refreshPage)
			
			}

			//jQuery('DIV.AMCONFIGURATION').find('#SELECTEDUNITS').find('UL').sortable('destroy');

			//STOP GAP SOLUTION TO ACCOUNT PLAN DIALOG ERROR
			//jQuery('[tabindex=-1]').hide();	
		}

		/* IF S1 IS PRESENT, S1 NAVIGATION OVERRIDES STANDARD NAVIGATION */		
		function refreshPageClone(responseData) {
			var thisURL = '/apex/DMAPP__am_opp_map_app?id=' + encodeURIComponent(responseData.planId) + "&" + (new Date()).getTime();	
			if (jQuery(".salesforce1")[0]){
				sforce.one.navigateToURL(thisURL)								
			}else{
				top.location.href=thisURL;
			}
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
					
					spinner = jQuery('<div>').css('z-index', '1000001').css('position', 'absolute');
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
					error(a, b, c)
				}
				catch(e) {
					
				}
				
				suicide();
				

			}

			var ret = function (result) { 

			}
			

			ttgApi.genericAjaxPut('OpportunityMapAdmin', planId, params, callback, err, ret);

		}

		function _wrapGet (callback, error) {

			showAjaxSpinner(true);
			
			var ret = function (result) { showAjaxSpinner(false);  }

			ttgApi.genericAjaxGet('OpportunityMapAdmin', planId, callback, error, ret);

		}

		function _wrapClone (newCloneName, callback, error) {

			isClone = true;
			
			showAjaxSpinner(true);
			
			var ret = function (result) { showAjaxSpinner(false);  }

			ttgApi.planClone(planId, newCloneName, callback, error, ret);

		}

		function _wrapDelete (callback, error) {

			showAjaxSpinner(true);
			
			var ret = function (result) { showAjaxSpinner(false);  }

			ttgApi.genericAjaxDelete('OpportunityMapAdmin', planId, callback, error, ret);

		}

		function preventClicksOnDialog(enable) {

			if (enable) { 
                var width = dlg.find('#DISABLECLICKS').parent().width();
                var height = dlg.find('#DISABLECLICKS').parent().height();

				dlg.find('#DISABLECLICKS').click( function(event) {event.stopPropagation(); } );

				dlg.find('#DISABLECLICKS').width(width);
				dlg.find('#DISABLECLICKS').height(height);
				
				dlg.parent().find('BUTTON').attr('disabled', 'true')
				dlg.parent().find('A').attr('disabled', 'true')
				dlg.parent().find('INPUT').attr('disabled', 'true')
				dlg.parent().find('SELECT').attr('disabled', 'true')
			}
			else {
				dlg.parent().find('BUTTON').attr('disabled', 'false')
				dlg.parent().find('A').attr('disabled', 'false')
				dlg.parent().find('INPUT').attr('disabled', 'false')
				dlg.parent().find('SELECT').attr('disabled', 'false')
				dlg.find('#DISABLECLICKS').width(0);
				dlg.find('#DISABLECLICKS').height(0);
			}
		}
		



		function setupOwnerSearch() {
			var ownerSearchSpec = jQuery.extend({}, that.spec);

			ownerSearchSpec.autosearch = false;
			ownerSearchSpec.lookup = { callback: function(owner) { } };
			
            if ( cfgdata.ownerId ) {
                 ownerSearchSpec.previouslySelectedId = cfgdata.ownerId;
            }

			var ownerMetadataControl = ttg.metadata(ownerSearchSpec);
			if (!readonly) {
				dlg.find('#OWNERINPUT').autocomplete({ 
						open: ownerMetadataControl.autoCompleteClear,
						minLength	: 3, 
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
				     	console.log('SEARCHOWNER click()');
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

			dlg.find('#OWNERINPUT').val(cfgdata.ownerName); 
			dlg.find('#OWNERINPUT_ID').val(cfgdata.ownerId); 
			
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
				        '<li><a href="#tabs-2">Solutions</a></li>' +
				        '<li><a href="#tabs-3">Units</a></li>' +
				        '<li><a href="#tabs-4">Team</a></li>' +				        
				        '<div id="planSettingsHelp" class="smartOMHelpLink">' + 
				        	'<a id="#TASHELPLINK_SETTINGS" onclick="javascript: ttg.am.showSettingsHelp();">Help</a>' + 
				        '</div>' +
				    '</ul>' +
			
					'<div class="tabs-spacer"></div>' +
					'<div id="tabs-1">' +
						'<div class="GENERALTAB">' + 
							'<table class="DATERANGE">' +
								'<tr>' + 
									'<td><span class="LABEL">Type:</span>' +
									'<td><select id="PLANTYPE"/>' +
								'</tr>' +
								'<tr>' + 
									'<td><span class="LABEL">Name:</span>' +
									'<td><input type="TEXT" id="PLANNAME" size="60" maxlength="80"/>' +
								'</tr>' +
								'<tr>' + 
									'<td><span class="LABEL">Owner:</span>' +
									'<td>' +
										'<span>' +
											'<input type="text" id="OWNERINPUT" size="60" maxlength="80" style="width:92%;"/>' +
											'<a class="MAGNIFY" id="SEARCHOWNER"/ style="position: absolute;">' +
											'<input type="hidden" id="OWNERINPUT_ID"/>' +
										'</span>' +
									'</td>' +
								'</tr>' +
								'<tr>' + 
									'<td><span class="LABEL">From:</td>' +
									'<td><input type="text" id="FROMDATE" size="10" maxlength="10"/></td>' +
								'</tr>' +
								'<tr>' + 
								'<td><span class="LABEL">To:</td>' +
								'<td><input type="text" id="TODATE" size="10" maxlength="10"/></td>' +
							'</tr>' +
							'<tr>' + 
								'<td><span class="LABEL">Status:</td>' +
								'<td><span id="PLANSTATUS"/></td>' +
							'</tr>' +
							'<tr>' + 
								'<td><span class="LABEL">Chatter Group:</span></td>' +
								'<td><select id="CHATTERGROUP"/>' + (showAutoPostOption ? '<span class="AUTO_POST_CHATTER_CONTAINER"><span class="AUTO_POST_CHATTER_LABEL">Auto chat plan performance</span><input id="AUTO_POST_CHATTER" type="checkbox"/></SPAN>' : '') + '</td>' +
							'</tr>' +							
							'</table>' +
							'<div id="SCORECARDTARGETS"></div>' +
						'</div>' +
					'</div>' +
					'<div id="tabs-2" style="width:530px;">' +
						'<div class="DRAGGINGFORDUMMIES">To add solutions to the plan, select the solution name from the \'Available\' list below and drag it onto the \'Selected\' list. Click the \'Target\' icon beside the Solutions you want to focus on.</div>' +
						'<div class="DRAGGINGFORDUMMIES">Solutions which have directly associated opportunities are indicated with a tick. (Note additional solutions may be related to an opportunity via Product-Solution mapping if that functionality is in use).</div>' +
						(showSolutionFamilies ?
						    '<div class="DRAGGINGFORDUMMIES">Solutions are grouped under \'Solution Families\'. You can drag a single solution or the entire family at once. Solutions may be reordered within a Family but not moved to another Family.</div>'
						    :
						    ''
						) +
						'<span class="LABEL" style="float:left">Available<br/><div id="AVAILABLESOLUTIONS"/></span>' +
						'<span class="LABEL" style="float:right">Selected<br/><div id="SELECTEDSOLUTIONS"/></span>' +
					'</div>' +
					'<div id="tabs-3">' +
					    '<div class="DRAGGINGFORDUMMIES UNITINFO">Units which have associated opportunities are indicated with a tick.\nWhere segmentation mapping has been carried out for a unit, its quadrant [A,B,C,D] is also indicated beside the unit name.</div>' +
						'<div id="ADDUNITS">' +
							'<input type="text" id="UNITINPUT"/>' +
							'<input type="hidden" id="UNITINPUT_ID"/>' +
							'<input type="button" id="SEARCHACCOUNT" value="Search" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>' +
							'<input type="button" id="ADDUNIT" value="Add" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>' +
						'</div>' +
						'<div id="SELECTEDUNITS" class="UNITSORTABLE">' +
							'<UL id="ROOTUNITSORTING"/>' +
						'</div>' +
						'<div style="text-align:left;margin-top: 2px;">' +
							'<input ttgid="NEWMEMBERBUTTON" type="button" id="ADDUNITLINK" value="New" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"/>' +
						'</div>' +
					'</div>' +
					'<div id="tabs-4">' +
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
        that.checkRevenueTargets = checkRevenueTargets;
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