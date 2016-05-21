/**
 * @author			Pranav Raulkar
 * @date            29/05/2015
 * @version			1.0
 * @description     Handler class for the Haystak_TaskTrigger.
 */
public with sharing class Haystak_TaskTriggerHandler {
	/**
	 * @author			Pranav Raulkar
	 * @date            28/05/2015
	 * @version			1.0
	 * @description     This method updates the opportunity with the related task count.
	 */
	public static void updateTaskCountOnPOA() {
		if(Trigger.isExecuting) {
			System.debug('=================>>>>>> entered Haystak_TaskTriggerHandler Trigger.isExecuting');
			// Make sure we initialize the Task list depending on the proper event
			List<Task> taskList;
			if(Trigger.isInsert || Trigger.isUpdate) {
				taskList = (List<Task>) Trigger.new;
			} else {
				taskList = (List<Task>) Trigger.old;
			}
			
			// Get the POA object prefix as we want to count only Tasks related to POA object
			Schema.DescribeSObjectResult dsr = POA__c.sObjectType.getDescribe();
			String objectPrefix = dsr.getKeyPrefix();
			
			// Create a set of unique POAs
			Set<Id> poaSet = new Set<Id>();
			
			System.debug('===================>>>>>> taskList.size() = ' + taskList.size());
			for(Task ta : taskList) {
				if(ta.WhatId != null && String.valueOf(ta.WhatId).startsWith(objectPrefix)) {
					poaSet.add(ta.WhatId);
				}
			}
			
			// Get the total number of tasks related to POA
			// Only select open tasks.
			System.debug('===================>>>>>> poaSet.size() = ' + poaSet.size());
			List<POA__c> poaList = [SELECT Id, Activity_Count__c, 
									 (Select Id FROM Tasks Where IsClosed = false)
									 FROM POA__c
									 WHERE Id IN :poaSet];
			for(POA__c poa : poaList) {
				poa.Activity_Count__c = (poa.Tasks == null ? 0 : poa.Tasks.size());
				System.debug('======================>>>> poa.Tasks.size() in Haystak_TaskTriggerHandler = ' + poa.Tasks.size());
				System.debug('======================>>>> Activity_Count__c in Haystak_TaskTriggerHandler = ' + poa.Activity_Count__c);
			}
			
			try {
				// Update the POAs
				update poaList;	
			} catch(Exception ex) {
				System.debug('## Exception: ' + ex.getStackTraceString());
			}
		}
	}
}