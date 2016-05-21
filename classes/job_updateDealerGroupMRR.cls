global with sharing class job_updateDealerGroupMRR implements Database.Batchable<sObject> {
	
	global job_updateDealerGroupMRR() {
		
		
	}
	
	
	/* ---------
	Start
	--------- */
	global Database.QueryLocator start(Database.Batchablecontext BC) {
		
		return Database.getQueryLocator([SELECT Id, Billed_Recurring_Revenue__c, Dealer_Group_MRR__c FROM Account WHERE parentId = null]);
	}
	
	/* --------
	Execute
	-------- */
	global void execute(Database.Batchablecontext BC, List<Account> scope) {
		
		for(Account a : scope) {
			
			List<Account> childAccounts = new List<Account>();
			
			try {
				childAccounts = [SELECT Id, Billed_Recurring_Revenue__c, Dealer_Group_MRR__c, ParentId FROM Account WHERE ParentId = :a.Id];
			}
			catch(Exception e) {
				//do nothing
			}
			
			Map<Id, Account> cAccounts = new Map<Id, Account>(childAccounts);
			
			Boolean childsExist = false;
			
			List<Account> newChildAccounts = new List<Account>();
			
			while(childsExist == false) {
				
				newChildAccounts = [SELECT Id, Billed_Recurring_Revenue__c, Dealer_Group_MRR__c, ParentId FROM Account WHERE ParentId IN :cAccounts.keyset()];
				
				for(Account nA : newChildAccounts) {
					
					childAccounts.add(nA);
				}
				
				cAccounts = new Map<Id, Account>(newChildAccounts);
				
				if(newChildAccounts.size() == 0) {
					childsExist = true;
				}
			}
			
			
			
			Decimal dgMrr = 0;
			
			if(a.Billed_Recurring_Revenue__c != null) {
				
				dgMrr += a.Billed_Recurring_Revenue__c;
			}
			
			if(childAccounts.size() > 0) {
				for(Account ca : childAccounts) {
					
					if(ca.Billed_Recurring_Revenue__c != null) {
						
						dgMrr += ca.Billed_Recurring_Revenue__c;
					}
				}
			}
			
			a.Dealer_Group_MRR__c = dgMrr;
			
			if(childAccounts.size() > 0) {
				for(Account ca : childAccounts) {
				
					ca.Dealer_Group_Mrr__c = dgMrr;
				}
			}
			
			try	{
				update a;
			}
			catch(Exception e) {
				//do nothing
			}
			
			try {
				update childAccounts;
			}
			catch(Exception e) {
				//do nothing
			}
		}
	}
	
	/* -------
	Finish
	------- */
	global void finish(Database.Batchablecontext BC) {  
        
        
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
            				TotalJobItems, CreatedBy.Email
            			  FROM AsyncApexJob WHERE Id = :BC.getJobId()];

        string message = 'The Dealer Group MRR batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.';

        // Send an email to the Apex job's submitter notifying of job completion.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email, 'dean.lukowski@vinsolutions.com', 'paul.duryee@vinsolutions.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Salesforce Batch Dealer Group MRR Job ' + a.Status);
        mail.setPlainTextBody(message);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });  
		
		//
	}
}