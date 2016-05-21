@isTest(SeeAllData=true)
private class Accounts_TEST {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	//Set your controller
        	//Accounts controller = new Accounts();
        	
        	
        	Account a = new Account(Name = 'Test', AccountNumber = '1', BillingStreet = '123 Elm', BillingState = 'KS', BillingCity = 'Test', BillingPostalCode ='66212', ShippingStreet = '123 Elm', ShippingState = 'KS', ShippingCity = 'Test', ShippingPostalCode ='66212');
        	
        	//insert territoryState;
        	insert a;
        	
        	test.startTest();
        	
        	//Accounts.SetState(a);
        	
        	//Accounts.setVinProManager(a);
        	
        	List<Account> accts = new List<Account>();
        	
        	accts.add(a); 
        	
        	//handler_Account.setWAMsetDDMsetVinPro(accts);  
        	
        	test.stopTest();
        	
        	
        }
    }
}