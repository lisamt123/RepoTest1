public class UpdateCaseStage {

//This method sets the case status, various related dates, and other escalation information when it is called.
//Currently it is called when a Case Runner is created. (05/06/2014)
	public static void updateCaseStage(Case_Runner__c r) {
				
		Case c = [SELECT Id, Assigned_To__c, OwnerId, Escalation_Type__c, Escalate_To__c, Feature_request_ID__c, Escalated_to_Development_By__c, Prior_Queue__c, Prior_Prior_Queue__c 
				  FROM Case 
				  WHERE Id = :r.Case__c 
				  limit 1];	

//Default variable set - If "Runner Action" is not Comment, set the case "Status" variable equal to the "Runner Action". This may be changed before the 
//DML commit (marked by STATUS VARIABLE OVERRIDE in the comments).
		if(r.Runner_Action__c != 'Comment') {
			
			c.Status = r.Runner_Action__c;
		}

//If the runner's "Escalation Type" is not blank, set the case's "Escalation Type" equal to the runner's.
		if(r.Escalation_Type__c != null) {
			
			c.Escalation_Type__c = r.Escalation_Type__c;
		}

//If the "Runner Action" is escalate, set the case field "Escalation Required" to TRUE, blank out the case's "Assigned To", then check the following:
//	- If the runner is being escalated to Website Support, L3-Website Support, DMS, Exports, Client Issues, DDM, L3 Support, or a queue that contains L2,
//		set the case's "Date Escalated" to TODAY.
//	- If the runner is being escalated to L3 Support, set the case's "Escalated to L3 by" user lookup to whoever is creating this runner. 	
		if(r.Runner_Action__c == 'Escalate') {
	

			if(r.Escalated_To__c == 'Website Support' || r.Escalated_To__c == 'L3-Website Support') {
				
				c.Date_Escalated__c= system.today();
			}
			
			if(r.Escalated_To__c == 'DMS') {
				
				c.Date_Escalated__c = system.today();
			}
			
			if(r.Escalated_To__c == 'Exports') {
				
				c.Date_Escalated__c = system.today();
			}
			
			if(r.Escalated_To__c == 'Client Issues') {
				
				c.Date_Escalated__c = system.today();
			}
			
			if(r.Escalated_To__c == 'L3 Support') {
				
				c.Date_Escalated__c = system.today();
				c.Escalated_to_Development_By__c = r.CreatedById;	
			}
				
			if(r.Escalated_To__c == 'DDM') {
				
				c.Date_Escalated__c = system.today();
			}
			
			if(r.Escalated_To__c.contains('L2')) {
				
				c.Date_Escalated__c = system.today();
			}
			
			c.Escalation_Required__c = true;
			c.Assigned_To__c = null;
		} 

//If the "Runner Action" is Additional Information Needed, set the case's "Date Info Requested" to TODAY.			
		if(r.Runner_Action__c == 'Additional Information Needed') {
			
			c.Date_Info_Requested__c = system.today();
		}

//If the "Runner Action" is Submitting Additional Information, set the case's "Date Info Submitted" to TODAY.						
		if(r.Runner_Action__c == 'Submitting Additional Information') {
			
			c.Date_Info_Submitted__c = system.today();
		}

//If the "Runner Action" is Issue Rejected, set the case's "Date Rejected", set the case "Status" to Rejected, assign the case to 
//whoever escalated the case to Dev ("Assigned To", not Owner), and create a new task for follow-up on the case.
//Assign the task to whoever escalated it to Dev, or if nobody did, to the case's Owner.
//STATUS VARIABLE OVERRIDE
		if(r.Runner_Action__c == 'Issue Rejected') {
				
			c.Date_Rejected__c = system.today();
			c.Status = 'Rejected';
			c.Assigned_To__c = c.Escalated_to_Development_By__c;
			
			Task newTask = new Task();
			
			if(c.Escalated_to_Development_By__c != null) {
				
				newTask.OwnerId = c.Escalated_to_Development_By__c;
			}
			else {
				
				newTask.OwnerId = c.OwnerId;
			}
			
			newTask.Subject = 'WFT-Rejected Case needs follow up';
			newTask.WhatId = c.Id;
			newTask.Description = 'Please review the Dev notes - if the problem truly is a dev issue "Unresolve" the case with your notes that support why this is a defect.  If the problem is not a Dev Issue - escalate to the proper queue for resolution.';				
			newTask.ActivityDate = system.today();
			
			insert newTask;				
		}

//If the "Runner Action" is Resolved, QA, or Resolved from Development, set the case's "Date Resolved" to TODAY and the "Case Resolution" to the value of the Runner Request.
//If a "Case Type" was set on the Runner, set the case's "Type" to that value. If a "Case Reason" was set on the Runner, set the case's "Case Reason" to that value.
//If the "Runner Action" was Resolved from Development, set the case's "Escalate To" to different values based on "Prior Queue". 
//If no routing found, set the case's "Escalate To" to the value of "Prior Prior Queue". 
		if(r.Runner_Action__c == 'Resolved' || r.Runner_Action__c == 'QA' || r.Runner_Action__c =='Resolved from Development') {
			
			c.Date_Resolved__c = system.today();
			c.Case_Resolution__c = r.Runner_Request__c;
			
			if(R.Case_Type__c != null) {
				
				c.Type = R.Case_Type__c;
			}
			
			if(R.Case_Reason__c != null) {
				
				c.Reason = R.Case_Reason__c;
			}
			/* Removing code to reset Escalate_To__c when the Runner_Action__c is set to Resolved from Development
				this will now be done through workflow
			if(r.Runner_Action__c == 'Resolved from Development') {
				if(c.Prior_Queue__c != null){
					if(c.Prior_Queue__c == 'Implementation') {
						
						c.Escalate_To__c = c.Prior_Queue__c;
					}
					else if(c.Prior_Queue__c.startsWith('L3-WEB-')) {
						
						c.Escalate_To__c = 'L3-WEB-WAMs';
					}
					else{
						
						c.Escalate_To__c = c.Prior_Prior_Queue__c;
					}
				}
			}*/
		}

//If the "Runner Action" is Unresolved, set the case's "Date Unresolved" to TODAY. If the current value of the "Prior Queue" is Development and the,
//"Prior Prior Queue" is L3 Support, change it to L3 Support.
		if(r.Runner_Action__c == 'Unresolved') {
			
			c.Date_Unresolved__c = system.today();
			if(c.Prior_Queue__c != null){
				if(c.Prior_Queue__c == 'Development' && c.Prior_Prior_Queue__c == 'L3 Support') {
					
					c.Escalate_To__c = 'L3 Support';
				}
			}
		}

//If the "Runner Action" is Redirect, set the case's "Date Redirected" to TODAY, and the case's "Status" to Redirected.
//If the "Prior Queue" was Feature Request, change the "Escalate To" to VinPros; otherwise, set it to the "Prior Queue".
//STATUS VARIABLE OVERRIDE
		if(r.Runner_Action__c == 'Redirect') {
			
			c.Date_Redirected__c = system.today();
			c.Status = 'Redirected';
			if(c.Prior_Queue__c != null){
				if(c.Prior_Queue__c == 'Feature Request') {
					
					c.Escalate_To__c = 'VinPros';
				}
				else {
					
					c.Escalate_To__c = c.Prior_Queue__c;
				}
			}			
		}

//If the "Runner Action" is No Dev Work to Do, set the case's "Date Ret'd to Support" to TODAY, and the case's "Status" to Returned from Development.
//Set the case's "Escalate To" to different values based on "Prior Queue". If no routing found, set the case's "Escalate To" to the value of "Prior Prior Queue". 
//STATUS VARIABLE OVERRIDE
		if(r.Runner_Action__c == 'No Dev Work to Do') {
			
			c.Date_Ret_d_to_Support__c = system.today();
			c.Status = 'Returned from Development';
			if(c.Prior_Queue__c != null){
				if(c.Prior_Queue__c == 'Implementation') {
						
						c.Escalate_To__c = c.Prior_Queue__c;
					}
					else if(c.Prior_Queue__c.startsWith('L3-WEB-')) {
						
						c.Escalate_To__c = 'L3-WEB-WAMs';
					}
					else{
						
						c.Escalate_To__c = c.Prior_Prior_Queue__c;
					}
			}
		}
		

//If the Runner's "Assigned To" is not blank, change the case's "Assigned To" to match.
		if(r.Assigned_To__c != null) {
			
			c.Assigned_To__c = r.Assigned_To__c;					
		}

//If the Runner's "Escalated To" is not blank, change the case's "Escalated To" to match.
		if(r.Escalated_To__c != null) {
			
			c.Escalate_To__c = r.Escalated_To__c;
		}

//If the Runner has a "Feature Request ID", change the case's "Feature Request ID" to match.
		if(r.Feature_Request_Id__c != null) {
			
			c.Feature_request_ID__c=r.Feature_Request_Id__c;
		}

//UPDATE CASE DML ACTION
		update c;	
	}	


//This method only runs if the Runner has a "Defect ID" and its "Record Type" is Resolve. It searches for a case that is related to the runner, then updates the
//RUNNER's "Case Description" to match the case's "Description". If that case's "Defect ID" is blank, it sets the CASE's "Defect ID" to match the Runner's.
//Warning: Currently this only fires off of a Case Runner being created or updated, NOT from a case edit. This means that the Runner must be edited and saved AGAIN.
//Another note: The Case Description field on the runner does not appear to be used anywhere. We can probably do away with that code. The Defect ID is only
//referenced by a handful of reports.
	public static void updateCaseDescriptionOnRunner(Case_Runner__c r) { 


		if(r.RecordTypeId == '012700000005eL7' && r.Defect_Id__c != null) {
			
			Case D = [SELECT Id, Defect__c, Description 
					  FROM Case 
					  WHERE Id = :r.Case__c];
					  
			r.Case_Description__c = D.Description;
				
			if(D.Defect__c == null) {
				
				D.Defect__c = r.Defect_Id__c;
				
				update D;
			}
		}
	}
	
//This method is a changeless asynchronous edit-save on any Cases passed to it.
	@future	public static void updateRelatedCases(Map<String, String> caseIDs) {
		
		List<Case> updateCases = [SELECT Id FROM Case WHERE Id IN :CaseIDs.keyset()];
		
		update updateCases;
	}	

}