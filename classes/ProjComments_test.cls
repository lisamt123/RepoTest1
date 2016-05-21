@isTest
private class ProjComments_test {

    static testMethod void myUnitTest() {
        
	        Account testAcct = TestData.setupAccount();
	        Contact testContact = TestData.setupContact();
	        insert testAcct;
	        insert testContact;
	        Opportunity testOppty = TestData.setupOpportunity(testAcct, testContact);
	        insert testOppty;
	        SFDC_520_Quote__c testProject = TestData.setupProject(testOppty);
	        insert testProject;
	        Project_Piece__c testPP = TestData.setupProjectPiece(testProject);
	        insert testPP;
	        Project_Comment__c testComment = TestData.setupProComment(testProject, testPP);
	        insert testComment;
			
			Project_Comment__c[] pjcArray = new Project_Comment__c[]{testComment};
        	
        	//Set your controller
        	ProjComments controller = new ProjComments();
        	
        	test.startTest();
        	
        	ProjComments.UpdateLastComment(pjcArray);

        	test.stopTest();
    }
    
    
    static testMethod void myUnitTest2() {
        
        	Account testAcct = TestData.setupAccount();
	        Contact testContact = TestData.setupContact();
	        insert testAcct;
	        insert testContact;
	        Opportunity testOppty = TestData.setupOpportunity(testAcct, testContact);
	        insert testOppty;
	        SFDC_520_Quote__c testProject = TestData.setupProject(testOppty);
	        insert testProject;
	        Project_Piece__c testPP = TestData.setupProjectPiece(testProject);
	        insert testPP;
	        Project_Comment__c testComment = TestData.setupProComment(testProject, testPP);
	        testComment.Comments__c = 'testtesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttesttest';
	        insert testComment;
			
			Project_Comment__c[] pjcArray = new Project_Comment__c[]{testComment};
        	
        	//Set your controller
        	ProjComments controller = new ProjComments();
        	
        	test.startTest();
        	
        	ProjComments.UpdateLastComment(pjcArray);

        	test.stopTest();
    }
}