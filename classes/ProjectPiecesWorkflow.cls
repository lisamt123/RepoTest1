public class ProjectPiecesWorkflow {
		


//======================================================Mark All Tasks on Piece Completion==============================
	/*
	public static void runWorkflowRules(Project_Piece__c p, Project_Piece__c oldPiece, Task[] closeTasksList, SFDC_520_Quote__c Project) {		
		
		system.debug('runWorkflow p.Project_Piece_Stage__c = ' + p.Project_Piece_Stage__c);
		
		if(p.Project_Piece_Stage__c == 'Completed' || p.Project_Piece_Stage__c == 'Cancelled' || 
		   p.Project_Piece_Stage__c == 'Awaiting Website Approval-Customer' || p.RecordTypeId == '01270000000Q3Vc') {
		
			if(oldPiece.Project_Piece_Stage__c != 'Completed' || oldPiece.Project_Piece_Stage__c != 'Cancelled' || 
			   oldPiece.Project_Piece_Stage__c != 'Awaiting Website Approval-Customer' || oldPiece.RecordTypeId != '01270000000Q3Vc') {
			   	
				//Find and Close all Open tasks now that the piece is marked "Completed"
				LIST<Task> closeTasks = new LIST<Task>();					
			
				for(Task close: closeTasksList) {
					
					close.Status = 'Completed';
					close.Date_Time_Completed__c = System.now();
					closeTasks.add(close);
				}
				
				update closeTasks;
				
				//This piece has been marked completed. Find out if there are any more that are NOT marked Completed...if not, then mark project "Completed"
				//SFDC_520_Quote__c Project = [select id, name, Approval_Stage__c from SFDC_520_Quote__c where id = : p.Project__c limit 1];
				//update Project;
				if(Project.Approval_Stage__c != 'GO LIVE' || Project.Approval_Stage__c != 'Work Complete') {
					
					integer OpenPiece = [SELECT count() 
										 FROM Project_Piece__c 
										 WHERE Project__c = :Project.Id 
										 AND Project_Piece_Stage__c != 'Completed' 
										 AND Project_Piece_Stage__c != 'Cancelled' 
										 AND Project_Piece_Stage__c != 'Awaiting Website Approval-Customer' 
										 AND RecordTypeId != '01270000000Q3Vc' 
										 AND Id != :p.Id];
										 
					system.debug('runWorkflow OpenPiece = ' + OpenPiece);
					
					if(OpenPiece == 0) {
						
						if(Project.Approval_Stage__c != 'GO LIVE') {
						
	                        if(Project.Project_Type__c == 'Fulfillment') {
	                        	
						 		Project.Approval_Stage__c = 'GO LIVE';
						 		Project.End_Date__c = system.today();
	                    	}
	                   		else {
	                    		
	                    		if(Project.Approval_Stage__c != 'Work Complete') {
	                    		
	                        		Project.Approval_Stage__c = 'Work Complete';
	                        		Project.Project_Complete_Date__c = system.today();
	                    		}
	                        }
						}
					}
					
					update Project;						
				}
			} 
		}             
	}
	*/
	
	//public static void runWorkflowRules2(Project_Piece__c p, Project_Piece__c oldPiece, Task[] closeTasksList, SFDC_520_Quote__c Project) {		
	public static void runWorkflowRules(List<Project_Piece__c> projectPieces, Map<Id, Project_Piece__c> oldProjectPieces, List<Task> relatedTasks, List<SFDC_520_Quote__c> projects) {
		
		List<Task> updateCloseTasks = new List<Task>();
		List<SFDC_520_Quote__c> updateProjects = new List<SFDC_520_Quote__c>();
		
		for(Project_Piece__c pp : projectPieces) {
			
			if(pp.Project_Piece_Stage__c == 'Completed' || pp.Project_Piece_Stage__c == 'Cancelled' ||
			   pp.Project_Piece_Stage__c == 'Awaiting Website Approval-Customer' || pp.RecordTypeId == '01270000000Q3Vc') {
			
				Project_Piece__c oldPiece = oldProjectPieces.get(pp.Id);
				
				if(oldPiece.Project_Piece_Stage__c != 'Completed' || oldPiece.Project_Piece_Stage__c != 'Cancelled' ||
				   oldPiece.Project_Piece_Stage__c != 'Awaiting Website Approval-Customer' || oldPiece.RecordTypeId != '01270000000Q3Vc') {
				   	
			   		for(Task t : relatedTasks) {
					
						if(t.WhatId == pp.Id) {
							
							t.Status = 'Completed';
							t.Date_Time_Completed__c = system.now();
							
							updateCloseTasks.add(t);
						}	
			   		}
			   		
			   		SFDC_520_Quote__c project = new SFDC_520_Quote__c();
			   		
			   		for(SFDC_520_Quote__c p : projects) {
					
						if(p.Id == pp.Project__c) {
							
							project = p;
							break;
						}
			   		}
			   		
			   		//if(project.Approval_Stage__c != 'GO LIVE' || project.Approval_Stage__c != 'Work Complete') {
			   		if(project.Approval_Stage__c != 'GO LIVE' && project.Approval_Stage__c != 'Work Complete' && project.Approval_Stage__c != 'Cancelled' && project.Approval_Stage__c != 'Completed') {
			   			
			   			integer OpenPiece = [SELECT count()
			   								 FROM Project_Piece__c
			   								 WHERE Project__c = :project.Id 
											 AND Project_Piece_Stage__c != 'Completed' 
											 AND Project_Piece_Stage__c != 'Cancelled' 
											 AND Project_Piece_Stage__c != 'Awaiting Website Approval-Customer' 
											 AND RecordTypeId != '01270000000Q3Vc' 
											 AND Id != :pp.Id];
											 
				 		if(OpenPiece == 0) {
				 			
				 			//if(project.Approval_Stage__c != 'GO LIVE' && project.Approval_Stage__c != 'Cancelled') {
				 				
				 				if(project.Project_Type__c == 'Fulfillment') {
				 					
				 					project.Approval_Stage__c = 'GO LIVE';
				 					project.End_Date__c = system.today();
				 					
				 					updateProjects.add(project);
				 				}
				 				else {
				 					
				 					//if(project.Approval_Stage__c != 'Work Complete') {
				 						
				 						project.Approval_Stage__c = 'Work Complete';
				 						project.Project_Complete_Date__c = system.today();
				 						
				 						updateProjects.add(project);
				 					//}
				 				}
				 			//}
				 		}
			   		}
			   	}    	
	   		}
		}
		
		update updateCloseTasks;
		update updateProjects;
	}
		
	
	
	
}