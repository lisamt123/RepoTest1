global with sharing class job_updateBilledRecRev implements Database.Batchable<sObject> {
	
	public String query;
	
	global job_updateBilledRecRev() {
		
		query = 'SELECT Id, Billed_Recurring_Revenue__c FROM Account';
		
	}
	
	
	/* ---------
	Start
	--------- */
	global Database.QueryLocator start(Database.Batchablecontext BC) {
		
		return Database.getQueryLocator(query);
	}
	
	/* --------
	Execute
	-------- */
	global void execute(Database.Batchablecontext BC, List<Account> scope) {
		
		Set<Id> accountIds = new Set<Id>();
		
		for(Account a : scope) {
			 
			accountIds.add(a.Id);
		}
		
		Map<Id, List<Contract>> acctIdContractMap = new Map<Id, List<Contract>>();
		
		for(Contract c : [SELECT Id, Contract_Total__c, AccountId 
						  FROM Contract 
						  WHERE AccountId IN :accountIds]) {
						  	
			if(acctIdContractMap.containsKey(c.AccountId)) {
				
				acctIdContractMap.get(c.AccountId).add(c);
			}
			else {
				
				acctIdContractMap.put(c.AccountId, new List<Contract>{c});
			}			  	
		}
		
		List<Account> updateAccounts = new List<Account>();
		
		for(Account a : scope) {
			
			if(acctIdContractMap.get(a.Id) != null) {
				
				List<Contract> loopContracts = acctIdContractMap.get(a.Id);
				
				Decimal bRecRev = 0;
				
				for(Contract c : loopContracts) {
					
					bRecRev += c.Contract_Total__c;
				}
				
				a.Billed_Recurring_Revenue__c = bRecRev;
				 
				updateAccounts.add(a);
			}
		}
		
		update updateAccounts;
	}
	
	/* -------
	Finish
	------- */
	global void finish(Database.Batchablecontext BC) {  
        
        
        AsyncApexJob a = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed,
            				TotalJobItems, CreatedBy.Email
            			  FROM AsyncApexJob WHERE Id = :BC.getJobId()];

        string message = 'The Billed Recurring Revenue batch Apex job processed ' + a.TotalJobItems + ' batches with '+ a.NumberOfErrors + ' failures.';

        // Send an email to the Apex job's submitter notifying of job completion.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {a.CreatedBy.Email, 'dean.lukowski@vinsolutions.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Salesforce Batch Billed Recurring Revenue Job ' + a.Status);
        mail.setPlainTextBody(message);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
		
		//
	}

}