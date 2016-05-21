@isTest
private class job_updateDealerGroupMRR_test {

    static testMethod void myUnitTest() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
        	
        	
        	
        	/*Territory_State__c TS = new Territory_State__c();
	  		TS.Name = 'XX';
			TS.Account_Manager__c = userinfo.getUserId();
			TS.DDM__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
	        TS.Implementation_Specialist__c = userinfo.getUserId();	
	        TS.Website_Manager__c = userInfo.getUserId();	
			insert TS;*/
        	
        	Account A = new Account();
        	A.ShippingCity='test';
			A.ShippingStreet='test';
			A.ShippingState='XX';
			A.ShippingPostalCode='test';
			A.BillingState = 'XX';
			A.AccountNumber = '1';
			A.BillingCity = 'test';
        	A.BillingCountry = 'USA';
        	A.BillingPostalCode = '66212';
        	A.BillingState = 'KS';
        	A.BillingStreet = '1234';
			A.name = 'TestAccount';
			
        	insert A;
        	
        	Account A2 = new Account();
        	A2.ShippingCity='test';
			A2.ShippingStreet='test';
			A2.ShippingState='KS';
			A2.ShippingPostalCode='test';
			A2.BillingState = 'KS';
			A2.AccountNumber = '1';
			A2.BillingCity = 'test';
        	A2.BillingCountry = 'USA';
        	A2.BillingPostalCode = '66212';
        	A2.BillingState = 'KS';
        	A2.BillingStreet = '1234';
			A2.name = 'TestAccount';
			A2.ParentId = A.Id;
			
        	//insert A2;
        	
        	
        	test.startTest();
        	
        	//job_updateDealerGroupMRR testJob = new job_updateDealerGroupMRR();
        	//ID batchprocessid = database.executeBatch(testJob);
        	
        	
        	
        	test.stopTest();
        //}
    }
}