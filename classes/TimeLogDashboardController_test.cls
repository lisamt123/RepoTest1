@isTest(SeeAllData=True)
private class TimeLogDashboardController_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	PageReference testStart = Page.TimeLogDashboard;
            Test.setCurrentPage(testStart);
        	
        	//Set your controller
        	TimeLogDashboardController controller = new TimeLogDashboardController();
        	
        	test.startTest();
        	
        	controller.getIpAddress();
        	
        	
        	controller.setRequestType('Login/Logout');
            controller.updateTimeLogIn();
            controller.updateTimeLogOut();
            controller.setRequestType('Break 1');
            controller.updateTimeLogIn();
            controller.updateTimeLogOut();
            controller.setRequestType('Break 2');
            controller.updateTimeLogIn();
            controller.updateTimeLogOut();
            controller.setRequestType('Lunch');
            controller.updateTimeLogIn();
            controller.updateTimeLogOut();
            
            
            controller.getColor();
            controller.getThisTimeLog();
            controller.getRequestOptions();
            controller.getRequestType();
            controller.getCurrentStatus();
        	
        	
        	test.stopTest();
        }
    }
}