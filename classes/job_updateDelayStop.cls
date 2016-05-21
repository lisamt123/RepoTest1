global with sharing class job_updateDelayStop implements Database.Batchable<sObject>, Database.AllowsCallouts { 
	
	global integer items {get;set;}
	global integer totalItems {get;set;}
	
	// Constructor
	global job_updateDelayStop() {
		
		items = 0;
		totalItems = 0;
	}
	
	// Start
	global Database.QueryLocator start(Database.Batchablecontext BC) {
		
		return Database.getQueryLocator([SELECT Id, Debug__c, End_Date__c, MSDelayRemovedDONOTCHANGE__c, Contract__c, Vin_Dealer_Id__c, Product_Code__c FROM Billing_Item__c WHERE MSDelayRemovedDONOTCHANGE__c = true]);
	}
	
	// Execute
	global void execute(Database.Batchablecontext BC, List<Billing_Item__c> scope) {
		
		List<Billing_Item__c> updateBillingItems = new List<Billing_Item__c>();
		
		for(Billing_Item__c bi : scope) {
			
			if(bi.End_Date__c < system.today()) {
				
				bi.MSDelayRemovedDONOTCHANGE__c = false;
				//bi.Debug__c = true;
				
				updateBillingItems.add(bi);
				
				items++;
			}
		}
		
		totalItems = scope.size();
		
		handler_BillingItem.prepareDataForActivateDeactivateFeaturesCallout(true, false, updateBillingItems);
		
		update updateBillingItems;
	}
	
	// Finish
	global void finish(Database.Batchablecontext BC) {
		
		AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
            				TotalJobItems, CreatedBy.Email
            			  FROM AsyncApexJob WHERE Id = :BC.getJobId()];

        string message = 'Delay Stop batch apex job: processed ' + a.JobItemsProcessed + ' out of ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.';

        // Send an email to the Apex job's submitter notifying of job completion.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'maggie.jolitz@vinsolutions.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Salesforce Batch Delay Stop Job ' + a.Status);
        mail.setPlainTextBody(message);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
	}
	
}