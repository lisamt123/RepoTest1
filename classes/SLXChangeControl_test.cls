@isTest(SeeAllData=true)
private class SLXChangeControl_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	//Set your controller
        	SLXChangeControl controller = new SLXChangeControl();
        	
        	SLX__Change_Control__c c = new SLX__Change_Control__c();
        	c.Link_to_Record__c = 'link';
        	insert c;
        	
        	
        	test.startTest();
        	
        	
        	
        	test.stopTest();
        }
    }
}