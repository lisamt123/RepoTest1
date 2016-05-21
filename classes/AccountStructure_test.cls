@isTest(SeeAllData=True)
private class AccountStructure_test {

    static testMethod void myUnitTest() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	//Set your controller
        	AccountStructure controller = new AccountStructure();
        	
        	String testId = 'test';
        	
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
	        A.BillingState = 'TS';
	        A.BillingStreet = '1234';
			
			A.name = 'TestAccount';
						
			insert A;
        	
        	
        	
        	test.startTest();
        	
        	controller.setcurrentId(A.Id);
        	
        	controller.getObjectStructure();
        	
        	test.stopTest();
        }*/
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
        
        AccountStructure con = new AccountStructure();
        
        test.startTest();
        
        con.setcurrentId(acctId);
        con.getObjectStructure();
        
        test.stopTest();
        
    }
}