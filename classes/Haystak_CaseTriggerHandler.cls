/**
 * @author			Pranav Raulkar
 * @date            28/05/2015
 * @version			1.0
 * @description     Handler class for the Haystak_CaseTrigger.
 */
public with sharing class Haystak_CaseTriggerHandler {
	/**
	 * @author			Pranav Raulkar
	 * @date            28/05/2015
	 * @version			1.0
	 * @description     This method updates the opportunity with the related (via Project__c) case count.
	 */
	public static void updateCaseCountOnPOA() {
		if(Trigger.isExecuting) {
			// Make sure we initialize the case list depending on the proper event
			List<Case> caseList;
			if(Trigger.isInsert || Trigger.isUndelete || Trigger.isUpdate) {
				caseList = (List<Case>) Trigger.new;
			} else {
				caseList = (List<Case>) Trigger.old;
			}
			
			// Create a unique set of POA ids
			Set<Id> poaIdSet = new Set<Id>();
			for(Case c : caseList) {
				poaIdSet.add(c.POA__c);
			}
			
			// Get all the cases for unique POA's
			List<POA__c> poaCaseList = [SELECT Id, Case_Count__c, (SELECT Id FROM Tickets__r) 
									    FROM POA__c c
									    WHERE Id IN :poaIdSet];
			
			// Set the POA case count
			for(POA__c poa : poaCaseList) {
				poa.Case_Count__c = poa.Tickets__r == null ? 0 : poa.Tickets__r.size();
			}
			
			try {
				// Update the POAs
				update poaCaseList;	
			} catch(Exception ex) {
				System.debug('## Exception: ' + ex.getStackTraceString());
			}			
		}
	}
}