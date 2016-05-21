@isTest(SeeAllData=True)
private class admin_ctrl_releaseNotes2_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	
        	Change_Request__c c = new Change_Request__c();
        	c.Request_Details__c = 'Owner(Mark Ross) Test Test Test';
        	c.Publish_to_Release_Notes__c = 'No';
        	c.Date_Completed__c = Date.newInstance(2013, 03, 08);
        	
        	insert c;
        	
        	
        	ApexPages.currentPage().getParameters().put('fromDatePicker', '03/03/2013');
        	ApexPages.currentPage().getParameters().put('toDatePicker', '03/25/2013');
        	
        	ApexPages.currentPage().getParameters().put('publishCRId', c.Id);
        	
        	
        	//Set your controller
        	admin_ctrl_releaseNotes2 controller = new admin_ctrl_releaseNotes2();
        	
        	test.startTest();
        	
        	controller.toggleSort();
        	controller.nullPR();
        	controller.publishCR();
        	controller.runFilter();
        	
        	
        	test.stopTest();
        }
    }
}