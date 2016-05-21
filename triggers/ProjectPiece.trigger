trigger ProjectPiece on Project_Piece__c (before update, after insert, after update) {
	
	            /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('ProjectPiece')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  
	
	if(trigger.isAfter && (trigger.isInsert || trigger.isUpdate)) {
		
	
		handler_ProjectPiece.autofollow(trigger.new);
		
		
		if(trigger.isUpdate) {
			
			handler_ProjectPiece.updateProjectMilestoneComplete(trigger.old, trigger.new);
		}
	}
	
	if(trigger.isUpdate && (trigger.isBefore || trigger.isAfter)) {
		
		
		LIST<Messaging.Singleemailmessage> emails = new LIST<Messaging.Singleemailmessage>();
		LIST<Task> newTasksInstance = new LIST<Task>();	
			
		if(trigger.isBefore && trigger.isUpdate) {//&&userinfo.getuserId().contains('00570000001KnjC'))
		
			//Make a list of all Project Pieces being updated, their related processes, and the process tasks	
			MAP<ID, Project_Piece__c> thesePieces = new MAP<Id, Project_Piece__c>();
			MAP<ID, Project_Piece__c> theseProcess = new MAP<Id, Project_Piece__c>();
			MAP<ID, Project_Piece__c> theseTStates = new MAP<Id, Project_Piece__c>();
			
			for(Project_Piece__c PrjPc : trigger.new) {
				
				thesePieces.put(PrjPc.Id, PrjPc);
				theseProcess.put(PrjPc.Product_Process__c, PrjPc);
				//theseTStates.put(PrjPc.Territory_State_Id__c, PrjPc);
				theseTStates.put(PrjPc.Account__c, PrjPc);
			}
			
			
			
			LIST<Task> newTasks = new LIST<Task>();
	        LIST<Product_Process__c> productProcesses = new LIST<Product_Process__c>();
	        LIST<Product_Process_Task__c> productProcessTasks = new LIST<Product_Process_Task__c>();                      
	        
	        //Find and Close all related Open Tasks
	        /*for(Task openTasks: 
	        [select id, Status, whatId 
	        from Task 
	        where whatId IN: thesePieces.keySet() 
	        and Status!='Completed' 
	        and Subject like 'WFT%'])
	        {
	        	//openTasks.Status = 'Completed';
	        	//openTasks.Date_Time_Completed__c = system.now();
	        	newTasks.add(openTasks);
	        }*/
	        //Store Data for the related Product Process
	        for(Product_Process__c pPrcss : [SELECT p.Product__c, p.Notify_Imp_Contact_Template_Id__c, 
	        										p.Notify_Imp_Contact_Upon_Completion__c,
	        										p.Number_of_Milestones__c, 
	        										p.Id, p.Suppress_Territory_Manager_Tasks__c,
	        										p.Suppress_Regional_Tasks__c, 
	        										p.Suppress_Project_Owner_Tasks__c,
	        										p.Suppress_Implementation_Manager_Tasks__c, 
	        										p.Suppress_Dealer_Advocate_Tasks__c, 
	        										p.Suppress_DDM_Tasks__c,
		    											(Select Id, IsDeleted, Name, CreatedDate, 
			    											CreatedById, Task_Description__c, LastModifiedDate, 
			    											Assigned_To__c, Assigned_To__r.Email, LastModifiedById, 
			    											SystemModstamp, Product_Process__c, Process_Milestone__c, 
			    											Completion_Timeframe__c, Assign_to_Role__c
			    										 FROM Product_Process_Tasks__r) 
    									    FROM Product_Process__c p 
	    									WHERE Id IN : theseProcess.keySet()]) {
	    										
	        	productProcesses.add(pPrcss);
	        	
	        	for(Product_Process_task__c tsk : pPrcss.Product_Process_Tasks__r) { 
	        		 
			    	productProcessTasks.add(tsk);	    			
	    		}        	
	        }		
			
			LIST<Account> theseTS = [SELECT a.Territory_State__r.Id, a.Territory_State__r.Implementation_Manager__c, 
										 a.Territory_State__r.Territory_Manager__c, a.Territory_State__r.Account_Manager__c, 
										 a.Territory_State__r.Regional__c, a.Territory_State__r.DDM__c, 
										 a.Exception_DDM__c, a.Exception_Account_Manager__r.Email,
										 a.Territory_State__r.Implementation_Manager__r.Email, a.Territory_State__r.Territory_Manager__r.Email,
										 a.Territory_State__r.Account_Manager__r.Email, a.Exception_DDM__r.Email, a.Territory_State__r.DDM__r.Email 
									 FROM Account a
									 WHERE Id IN : theseTStates.keySet()];		
			
			if(Trigger.isUpdate) {
				
				for(Project_Piece__c PP : trigger.new) {
					
					Project_Piece__c oPP = trigger.oldMap.get(PP.Id);
				
					if(PP.OwnerId == oPP.OwnerId && PP.Piece_Status__c != 'Closed' && 
					   PP.CreatedDate >= DateTime.newInstance(Date.newInstance(2010,03,25), Time.newInstance(12, 0, 0, 0))) {						
											
			        	Product_Process__c productProcessesInstance = new Product_Process__c();
				        LIST<Product_Process_Task__c> productProcessTasksInstance = new LIST<Product_Process_Task__c>();			       
						
						Account thisTS;						
						
						for(Account thisState : theseTS) {
							
							if(PP.Territory_State_Id__c == thisState.Territory_State__r.Id) {
								
								thisTS = thisState;
							}
						}
						
						for(Task sendTasks : newTasks) {
							
							if(sendTasks.WhatId == PP.Id) {	
															
								sendTasks.Status = 'Completed';
	    						sendTasks.Date_Time_Completed__c = system.now();        						
								newTasksInstance.add(sendTasks);
							}
						}
						
						for(Product_Process__c sendProcess : productProcesses) {
							
							if(sendProcess.Id == PP.Product_Process__c) {
								
								productProcessesInstance = sendProcess;
							}
						}
						
						for(Product_Process_Task__c sendPPTasks : productProcessTasks) {	
													
							if(sendPPTasks.Product_Process__c == PP.Product_Process__c) {	
															
								productProcessTasksInstance.add(sendPPTasks);
							}
						}
												
						if(PP.Completed_Milestones__c > oPP.Completed_Milestones__c ||
						   (PP.Start_Process__c != null && oPP.Start_Process__c == null) || 
						   (PP.Project_Piece_Stage__c == 'Completed' && oPP.Project_Piece_Stage__c != 'Completed')) { 
						
							ProjectPieceProcess.generateTasks(PP, oPP, newTasksInstance, productProcessesInstance, 
							productProcessTasksInstance, thisTS, emails);
					   	}
						
						
					}													
				}
			}
			
			if(trigger.isBefore && trigger.isUpdate) {
				
				for(Project_Piece__c PP : trigger.new) {
					
					if(PP.Number_of_Milestones__c >= 1 && PP.CreatedDate >= DateTime.newInstance(Date.newInstance(2010, 03, 25), Time.newInstance(12, 0, 0, 0))) {
						
						if(PP.Number_of_Milestones__c == 1) {
							
							PP.RecordTypeId = '01270000000Q4Ux';
						}
						
						if(PP.Number_of_Milestones__c == 2) {
							
							PP.RecordTypeId = '01270000000Q4V2';
						}
						
						if(PP.Number_of_Milestones__c == 3) {
							
							PP.RecordTypeId = '01270000000Q4V7';
						}
						
						if(PP.Number_of_Milestones__c == 4) {
							
							PP.RecordTypeId = '01270000000Q4VC';
						}
						
						if(PP.Number_of_Milestones__c == 5) {
							
							PP.RecordTypeId = '01270000000Q4VH';
						}
						
						if(PP.Number_of_Milestones__c == 6) {
							
							PP.RecordTypeId = '01270000000Q4Uy';
						}
						
						if(PP.Number_of_Milestones__c == 7) {
							
							PP.RecordTypeId = '01270000000Q4Uz';
						}
						
						if(PP.Number_of_Milestones__c == 8) {
							
							PP.RecordTypeId = '01270000000Q4VM';
						}
						
						if(PP.Number_of_Milestones__c == 9) {
							
							PP.RecordTypeId = '01270000000Q4VR';
						}
						
						if(PP.Number_of_Milestones__c == 10) {
							
							PP.RecordTypeId = '01270000000Q4V0';
						}					
					}
				}
			}
		}			
	
		/*if(emails.size()>0)
		{
			try
			{
				Messaging.sendEmail(emails , TRUE); 
			}
			catch(Exception Ex)
			{
				system.debug(Ex);
			}
		}*/
		if(newTasksInstance != null) {
			
			try {
				
				upsert newTasksInstance;
			}
			catch(Exception Ex) {
				
				system.debug(Ex);	
			}
		}
		
		if(trigger.isAfter && trigger.isUpdate) {
			
			//Phased Implementation Updates
			
			for(Project_Piece__c PP : trigger.new) {
				
				Project_Piece__c oPP = trigger.oldMap.get(PP.Id);
		
				if(pp.Name.tolowercase().contains('inventory module') || pp.Name.tolowercase().contains('inventory light')) {
					
					if(oPP.Project_Piece_Stage__c != 'Completed' && PP.Project_Piece_Stage__c == 'Completed') {
						
						PhasedImplementationUpdate.UpdateInventoryModuleComplete(PP.Id);
					}
					
					if(pp.Number_of_Milestones__c >= 10) {
						
						if(PP.Milestone_10__c.tolowercase().contains('received completed inventory verification')) {	
													
							if(oPP.Milestone_10_Completed__c == null && PP.Milestone_10_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 9) {
													
						if(PP.Milestone_9__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_9_Completed__c == null && PP.Milestone_9_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 8) {
						if(PP.Milestone_8__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_8_Completed__c == null && PP.Milestone_8_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 7) {
						
						if(PP.Milestone_7__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_7_Completed__c == null && PP.Milestone_7_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 6) {
						
						if(PP.Milestone_6__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_6_Completed__c == null && PP.Milestone_6_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 5) {
						
						if(PP.Milestone_5__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_5_Completed__c == null && PP.Milestone_5_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 4) {
						
						if(PP.Milestone_4__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_4_Completed__c == null && PP.Milestone_4_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 3) {
						
						if(PP.Milestone_3__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_3_Completed__c == null && PP.Milestone_3_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 2) {
						
						if(PP.Milestone_2__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_2_Completed__c == null && PP.Milestone_2_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 1) {
						
						if(PP.Milestone_1__c.tolowercase().contains('received completed inventory verification')) {
														
							if(oPP.Milestone_1_Completed__c == null && PP.Milestone_1_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateInventoryVerification(PP.Id);
							}
						}
					}					
				}
				
				if(pp.Name.tolowercase().contains('ilm')) {
					
					if(oPP.Project_Piece_Stage__c != 'Completed' && PP.Project_Piece_Stage__c == 'Completed') {
						
						PhasedImplementationUpdate.UpdateILMComplete(PP.Id);
					}
					
					if(pp.Number_of_Milestones__c >= 10) {
						
						if(PP.Milestone_10__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_10_Completed__c == null && PP.Milestone_10_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 9) {
													
						if(PP.Milestone_9__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_9_Completed__c == null && PP.Milestone_9_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 8) {
						
						if(PP.Milestone_8__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_8_Completed__c == null && PP.Milestone_8_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 7) {
						
						if(PP.Milestone_7__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_7_Completed__c == null && PP.Milestone_7_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 6) {
						
						if(PP.Milestone_6__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_6_Completed__c == null && PP.Milestone_6_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 5) {
						
						if(PP.Milestone_5__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_5_Completed__c == null && PP.Milestone_5_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 4) {
						
						if(PP.Milestone_4__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_4_Completed__c == null && PP.Milestone_4_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 3) {
						
						if(PP.Milestone_3__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_3_Completed__c == null && PP.Milestone_3_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 2) {
						
						if(PP.Milestone_2__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_2_Completed__c == null && PP.Milestone_2_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 1) {
						
						if(PP.Milestone_1__c.tolowercase().contains('gather prospect data')) {
														
							if(oPP.Milestone_1_Completed__c == null && PP.Milestone_1_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateProspectDataReceived(PP.Id);
							}
						}
					}
				}
				
				if(pp.Name.tolowercase().contains('crm')) {
					
					if(oPP.Project_Piece_Stage__c != 'Completed' && PP.Project_Piece_Stage__c == 'Completed') {
						
						PhasedImplementationUpdate.UpdateCRMComplete(PP.Id);
					}
				}
				
				if(pp.Name.tolowercase().contains('data integration')) {
							
					if(pp.Number_of_Milestones__c >= 10) {
						
						if(PP.Milestone_10__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_10_Completed__c == null && PP.Milestone_10_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 9) {
													
						if(PP.Milestone_9__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_9_Completed__c == null && PP.Milestone_9_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 8) {
						
						if(PP.Milestone_8__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_8_Completed__c == null && PP.Milestone_8_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 7) {
						
						if(PP.Milestone_7__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_7_Completed__c == null && PP.Milestone_7_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 6) {
						
						if(PP.Milestone_6__c.tolowercase().contains('connection made')) {		
												
							if(oPP.Milestone_6_Completed__c == null && PP.Milestone_6_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 5) {
						
						if(PP.Milestone_5__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_5_Completed__c == null && PP.Milestone_5_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 4) {
						
						if(PP.Milestone_4__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_4_Completed__c == null && PP.Milestone_4_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 3) {
						
						if(PP.Milestone_3__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_3_Completed__c == null && PP.Milestone_3_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 2) {
						
						if(PP.Milestone_2__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_2_Completed__c == null && PP.Milestone_2_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
					
					if(pp.Number_of_Milestones__c >= 1) {
						
						if(PP.Milestone_1__c.tolowercase().contains('connection made')) {
														
							if(oPP.Milestone_1_Completed__c == null && PP.Milestone_1_Completed__c != null) {
								
								PhasedImplementationUpdate.UpdateDMSAccessed(PP.Id);
							}
						}
					}
				}
			}
		}
	}
	
	if(trigger.isBefore && trigger.isUpdate) {
		
		
		
		/*
		//Find the User Offices
		string TM;
		string TF;
		string TA;
		string PS;
		string PSemail;
		string PSname;
		string Clk;
		string Clkemail;
		string VCA; 
					
		for(User U : [SELECT Id, VinCamera_Assets__c, FirstName, LastName,Email, Manager_of_Training__c,In_charge_of_Printing_Shipping__c,
							Travel_Financer__c,Travel_Arranger__c, Click_to_Chat_Specialist__c 
					  FROM User 
					  WHERE Manager_of_Training__c = true 
					  OR Travel_Financer__c = true 
					  OR Travel_Arranger__c = true 
					  OR In_charge_of_Printing_Shipping__c = true 
					  OR Click_to_Chat_Specialist__c = true 
					  OR VinCamera_Assets__c = true]) {
					  	
				if(U.Manager_of_Training__c == true) {
					
					TM = U.id;
				}
				
				if(U.Travel_Arranger__c == true) {
					
					TA = U.id;
				}
				
				if(U.Travel_Financer__c == true) {
					
					TF = U.id;
				}
				
				if(U.In_charge_of_Printing_Shipping__c == true) {
					
					PS = U.id;
					PSname = U.FirstName + ' ' + U.LastName;
					PSemail = U.email;
				}
				
				if(U.Click_to_Chat_Specialist__c == true) {
					
					Clk = U.id;
					Clkemail= U.email;
				}
				
				if(U.VinCamera_Assets__c == true) {
					
					VCA = U.id;				
				}
			}
			
			*/
			
			
			MAP<Id, Project_Piece__c> thesePieceProjects = new MAP<Id, Project_Piece__c>();
			MAP<Id, Project_Piece__c> thesePieceTasks = new MAP<Id, Project_Piece__c>();	
			
			for(Project_Piece__c thisPiece : Trigger.new) {
				
				thesePieceProjects.put(thisPiece.Project__c, thisPiece);	
				thesePieceTasks.put(thisPiece.Id, thisPiece);	
			}
			
			LIST<SFDC_520_Quote__c> theseProjects = [SELECT Id, name, Approval_Stage__c, Project_Type__c 
												     FROM SFDC_520_Quote__c 
													 WHERE Id IN : thesePieceProjects.keySet()];
			
			LIST<Task> allRelatedOpenTasks = [SELECT id, Date_Time_Completed__c, WhatId, Status 
											  FROM Task 
											  WHERE WhatId IN : thesePieceTasks.keySet() 
											  AND Status != 'Completed'];
				
			
			ProjectPiecesWorkflow.runWorkflowRules(trigger.new, trigger.oldMap, allRelatedOpenTasks, theseProjects);
			
			/*
			for(Project_Piece__c P : trigger.new) {
				
				Project_Piece__c O = trigger.oldMap.get(P.Id);			
				SFDC_520_Quote__c currentProject = new SFDC_520_Quote__c();
				LIST<Task> currentOpenTasks = new LIST<Task>();
				
				for(SFDC_520_Quote__c thisProject : theseProjects) {
					
					if(thisProject.Id == P.Project__c) {
						
						currentProject = thisProject;
					}
				}
				
				for(Task thisTask: allRelatedOpenTasks) {
					
					if(thisTask.WhatId == P.Id) {
						
						currentOpenTasks.add(thisTask);
					}	
				}		
				
				if(P.OwnerId == O.OwnerId) {
					
					
					//if(P.RecordTypeId == '012700000005e2u') {//Default Issues
					
						//ProjectPiecesWorkflow.runDefaultIssues(P, O, TM, TF,TA, PS, PSemail, Clk, Clkemail, currentOpenTasks, currentProject);
					//}
					
							
					
					//END PRODUCT SPECIFIC PROCESSES LIST	
				 	////if(Utility.isProjectUpdate == null || Utility.isProjectUpdate == false) {
						
					ProjectPiecesWorkflow.runWorkflowRules(P, O, currentOpenTasks, currentProject);//Universal Workflow
				 	////}
				 	
				}
			}
			*/
	}
}