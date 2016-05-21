@isTest
private class Attachments_TEST {

    static testMethod void Attachments_TestMethod() {
        Account testAcct = TestData.setupAccount();
		Contact testCont = TestData.setupContact();
		insert testAcct;
		insert testCont;
        Opportunity testOppty = TestData.setupOpportunity(testAcct, testCont);
		insert testOppty;
        SFDC_520_Quote__c testProject = TestData.setupProject(testOppty);
		insert testProject;
		Task T1 = TestData.setupTaskProject(testProject);
		insert T1; //save it to SFDC (it will rollback after your test
		T1.Status = 'Completed';
		update T1; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
		Case CS = TestData.setupCase(testAcct, testCont);
		insert CS;
		Attachment att = TestData.setupAttachment(CS);
		insert att;
	    test.startTest();
	    
	    test.stopTest();
    }
}