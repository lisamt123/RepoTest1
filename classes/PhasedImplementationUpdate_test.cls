@isTest(SeeAllData=True)
private class PhasedImplementationUpdate_test {

    static testMethod void myUnitTest() {

        User u_testMethodUser = TestData.setupUser();
        /*
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;*/
        
        System.runas(u_testMethodUser) {
        	
        	Project_Piece__c testPP = [SELECT Id, Project__c FROM Project_Piece__c LIMIT 1];
        	
        	Date sD = date.today();
        	Date eD = date.today();
        	
        	sD.addDays(2);
        	
        	
        	//Set your controller
        	PhasedImplementationUpdate controller = new PhasedImplementationUpdate();
        	
        	test.startTest();
        	
        	PhasedImplementationUpdate.GetPieceProject(testPP);
        	
        	PhasedImplementationUpdate.UpdateInventoryModuleComplete(testPP.Id);
        	PhasedImplementationUpdate.UpdateDMSAccessed(testPP.Id);
        	PhasedImplementationUpdate.UpdateCRMComplete(testPP.Id);
        	PhasedImplementationUpdate.UpdateILMComplete(testPP.Id);
        	PhasedImplementationUpdate.UpdateInventoryVerification(testPP.Id);
        	
        	PhasedImplementationUpdate.CreateTrainingEvents(sD, eD, u_testMethodUser.Id, testPP.Id);
        	
        	
        	test.stopTest();
        }
    }
}