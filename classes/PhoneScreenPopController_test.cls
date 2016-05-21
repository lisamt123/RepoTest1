@isTest
private class PhoneScreenPopController_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;

        Id [] fixedSearchResults= new Id[1];
        fixedSearchResults[0] = '001x0000003G89h';
        Test.setFixedSearchResults(fixedSearchResults);

        
        System.runas(u_testMethodUser) {
        	
        	ApexPages.currentPage().getParameters().put('phonenumber', '8009807488');
        	
        	//Set your controller
        	PhoneScreenPopController controller = new PhoneScreenPopController();
        	
        	test.startTest();
        	
        	controller.getTheseContactsIdMap();
        	controller.getTheseAccountsIdMap();
        	controller.getTheseObjectsIdMap();
        	controller.getRelatedAccounts();
        	controller.getRelatedContacts();
        	controller.getRelatedCases();
        	controller.getRelatedOpportunities();
        	controller.getRelatedProjects();
        	
        	
        	test.stopTest();
        }
    }
}