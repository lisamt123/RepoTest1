@isTest(SeeAllData=true)
private class handler_ChangeRequest_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        Profile pro2 = [SELECT Id From Profile WHERE Name = 'VinSystem Admin'];
        
        User u_testMethodUser = new User(alias = 'testMeth',
                                            email = 'testMethodUser@salesforce.com',
                                            emailencodingkey = 'UTF-8',
                                            lastname = 'Test Method User',
                                            languagelocalekey = 'en_US',
                                            localesidkey = 'en_US',
                                            profileid = pro.Id,
                                            timezonesidkey = 'America/Los_Angeles',
                                            username = 'testMethodUser@salesforce.com');
        User u_testMethodUser2 = new User(alias = 'testMet2',
                                            email = 'testMethodUser2@salesforce.com',
                                            emailencodingkey = 'UTF-8',
                                            lastname = 'Test Method User2',
                                            languagelocalekey = 'en_US',
                                            localesidkey = 'en_US',
                                            profileid = pro2.Id,
                                            timezonesidkey = 'America/Los_Angeles',
                                            username = 'testMethodUser2@salesforce.com');
        insert u_testMethodUser;
        insert u_testMethodUser2;
        
        System.runas(u_testMethodUser) {
        	
        	//Set your controller
        	handler_ChangeRequest controller = new handler_ChangeRequest();
        	
        	Change_Request__c c = new Change_Request__c();
        	c.Request_Details__c = 'Owner(Mark Ross) Test Test Test';
        	insert c;
            c.OwnerId = u_testMethodUser2.Id;
            update c;
            c.Are_All_Stories_Closed__c = true;
        	c.Change_Request_Status__c = 'Closed';
        	update c;
        	
        	test.startTest();
        	
        	
        	
        	test.stopTest();
        }
    }
}