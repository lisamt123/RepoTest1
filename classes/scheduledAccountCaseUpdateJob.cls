global class scheduledAccountCaseUpdateJob implements Database.Batchable<sobject>
{
	global final String Query;
	global final String Entity;
	global final String Field;
	global final String Value;
		
	global scheduledAccountCaseUpdateJob (String q)
	{
		Query = q;
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC)
	{
		return Database.getQueryLocator(Query);
	}
	
	global void execute(Database.BatchableContext BC, LIST<Account> scope)
	{
		for (Account a: scope)
		{
			double totalCaseValues = 0;
			LIST<Case> accountCases = [select Id, Status, AccountId, Case_Value__c from Case where AccountId =: a.Id];
			for (Case thisCase: accountCases)
			{
				totalCaseValues += thisCase.Case_Value__c;
			}			
			a.Total_Cases__c = totalCaseValues;
		}
		update scope;
	}
	
	global void finish(Database.BatchableContext BC)
	{
		// Get the ID of the AsyncApexJob representing this batch job  
		// from Database.BatchableContext.  
		// Query the AsyncApexJob object to retrieve the current job's information.  
		
		AsyncApexJob a = [Select Id, Status, NumberOfErrors, JobItemsProcessed,
		  TotalJobItems, CreatedBy.Email
		  from AsyncApexJob where Id =:BC.getJobId()];
		// Send an email to the Apex job's submitter notifying of job completion.  
		
		Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		String[] toAddresses = new String[] {a.CreatedBy.Email};
		mail.setToAddresses(toAddresses);
		mail.setSubject('Batch Apex Account Case Update ' + a.Status);
		mail.setPlainTextBody
		('The batch Apex job processed ' + a.TotalJobItems +
		' batches with '+ a.NumberOfErrors + ' failures.');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
	public static testmethod void testAccountCaseUpdate()
	{
		user u = new user();
		u.LastName = 'TEST';
		u.Alias = 'TEST';
		u.Email = 'TEST@TEST.COM';
		u.Username = 'testvinsolutionsuser@vinsolutions.com';
		u.CommunityNickname = 'TESTUSERTEST';
		u.ProfileId = '00e70000000wzXQ';
		u.EmailEncodingKey = 'UTF-8';
		u.TimeZoneSidKey= 'America/Chicago';
		u.LocaleSidKey= 'en_US';
		u.LanguageLocaleKey= 'en_US';
		
		insert u;
		
		List <Account> accns = new List<Account>();
	    for(integer i = 0; i<50; i++)
	    {
	    	Account a = new Account(name='testAccount'+'i', 
	                   Ownerid = u.ID, BillingCity = 'test', BillingCountry = 'USA', BillingPostalCode = '66212',
	                   BillingState = 'TS', BillingStreet = '1234'); 
	    	accns.add(a);
	    }
   		
   		//insert accns;  
   		
   		Test.StartTest();
   		String query = 'select Id, Status__c, Total_Cases__c from Account where OwnerId = U.Id';
		scheduledAccountCaseUpdateJob batchApex = new scheduledAccountCaseUpdateJob(query);
		ID batchprocessid = Database.executeBatch(batchApex, 2);
   		
   		
		
		
		
		
	} 
 
}