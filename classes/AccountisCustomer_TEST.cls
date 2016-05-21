@isTest(SeeAllData=True)
private class AccountisCustomer_TEST {
	/*
	static testMethod void AccountisCustomer_TestMethod() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	Territory_State__c TS = new Territory_State__c();
	  		TS.Name = 'XX';
			TS.Account_Manager__c = userinfo.getUserId();
			TS.DDM__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
	        TS.Implementation_Specialist__c = userinfo.getUserId();	
	        TS.Website_Manager__c = userInfo.getUserId();	
			insert TS;
        	
        	Account a = new Account();
			a.ShippingCity = 'test';
			a.shippingStreet = 'test';
        	a.ShippingState = 'xx';
        	a.ShippingPostalCode = '12345';
        	a.BillingState = 'xx';
        	a.AccountNumber = '1';
        	a.BillingCity = 'test';
        	a.BillingCountry = 'USA';
        	a.BillingPostalCode = '12345';
        	a.BillingState = 'XX';
        	a.BillingStreet = '1234';
        	//a.Type = 'Customer';
        	a.Territory_State__c = TS.Id;
        	
        	a.name = 'Test Account';
        	insert a;
        	
        	a.Type = '';
        	
        	update a;
        	
        	string AcctId = a.Id;
        	
        	Contact Ctc = new Contact();
			Ctc.AccountId = A.Id;
			Ctc.FirstName = 'test';
			Ctc.LastName = 'test';
			
			insert Ctc;
		 
		 	Opportunity O  = new Opportunity();
			O.AccountId = AcctId; //set the required fields
			O.Name = 'test';
			O.Deal_Contact__c = Ctc.id;
			O.CloseDate = System.today();
			O.StageName = 'Closed or Won';
			O.Type = 'New Business';
			O.Salesperson__c = userinfo.getUserId();
			O.Implementation_Contact__c = Ctc.id;
			O.We_Owe__c = 'N/A'; 
			
			insert O;
        }
    }
	*/
}