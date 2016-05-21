@isTest
private class generatemoreload_test {

    static testMethod void myUnitTest(){
    	Account testAcct = TestData.setupAccount();
    	Contact testContact = TestData.setupContact();
    	insert testAcct;
    	insert testContact;
    	Opportunity testOppty = TestData.setupOpportunity(testAcct, testContact);
    	testOppty.Implementation_Contact__c = testContact.Id;
    	testOppty.Load_Counter__c = 4;
    	insert testOppty;
    	Product2 testProduct = TestData.getProduct();
    	testProduct.Subject_to_Load__c = true;
    	insert testProduct;
    	PricebookEntry testPBE = TestData.setupPricebookEntry(testProduct);
    	insert testPBE;
    	Product_Process__c testProcess = TestData.getProductProcess(testProduct);
        testProcess.Milestone_1__c = '';
        testProcess.Milestone_1_Stage__c = '';
    	insert testProcess;
    	SFDC_520_Quote__c testProject = TestData.setupProject(testOppty);
    	insert testProject;
    	OpportunityLineItem testOLI = TestData.setupOpportunityLineItem(testPBE, testOppty);
    	testOLI.Override_Related_Product__c = true;

		ApexPages.currentPage().getParameters().put('opportunityId', testOppty.Id);
		
		//Set your controller
		generatemoreload cont = new generatemoreload();
		
		test.startTest();
		insert testOLI;
		cont.backToOpp();
		cont.nullPR();
		cont.checkLoadToGenerate();
		
		//cont.opportunity.Load_Counter__c = 4;
		cont.amountToGenerate = 5;
		cont.availableLoad = 10;
        cont.doLoad();
        testProcess.Milestone_1__c = 'Test1';
        testProcess.Milestone_1_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_2__c = 'Test2';
        testProcess.Milestone_2_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_3__c = 'Test3';
        testProcess.Milestone_3_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_4__c = 'Test4';
        testProcess.Milestone_4_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_5__c = 'Test5';
        testProcess.Milestone_5_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_6__c = 'Test6';
        testProcess.Milestone_6_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_7__c = 'Test7';
        testProcess.Milestone_7_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_8__c = 'Test8';
        testProcess.Milestone_8_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_9__c = 'Test9';
        testProcess.Milestone_9_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_10__c = 'Test10';
        testProcess.Milestone_10_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
        testProcess.Milestone_3__c = 'Test3';
        testProcess.Milestone_3_Stage__c = 'Introduction';
        update testProcess;
        cont.doLoad();
		
		test.stopTest();
    }
    
     
}