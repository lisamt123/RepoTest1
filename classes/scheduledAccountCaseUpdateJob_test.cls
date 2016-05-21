@isTest
private class scheduledAccountCaseUpdateJob_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	
        	
        	
        	test.startTest();
        	
        	String query = 'testQuery';
        	
        	scheduledAccountCaseUpdateJob testJob = new scheduledAccountCaseUpdateJob(query);
        	
        	ID batchprocessid = database.executeBatch(testJob);
        	
        	
        	
        	test.stopTest();
        }
    }
}