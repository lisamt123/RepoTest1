@isTest(SeeAllData=true)
private class DataIntegrationController_TEST {

    static testMethod void DataIntegrationController_TestMethod() {

        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
        
        Opportunity O = new Opportunity();
        O.AccountId = acctId;
        O.Name = 'Test';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        insert O;
    
        SFDC_520_Quote__c Proj = new SFDC_520_Quote__c();
        Proj.Account__c = acctId;
        Proj.Opportunity__c = O.Id;
        insert Proj;
        
        Product2 p = new Product2();
        p.name = 'Data Integration';
        insert p;
        
        Product_Process__c pp = new Product_Process__c();
        pp.name = 'Data Integration';
        insert pp;
        
        PageReference testStart = Page.Data_Integration;
        Test.setCurrentPage(testStart);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(Proj);
        ApexPages.currentPage().getParameters().put('id', Proj.Id);
        
       DataIntegrationController DI = new DataIntegrationController(controller);
       
       Id Id = DI.getId();
       SFDC_520_Quote__c testProj = DI.getThisProject();
       Account testAccount = DI.getThisAccount();
       boolean pieceExists = DI.getPieceExists();
       DI.generateProjectPiece();
       pieceExists = DI.getPieceExists();
       
       DI.setRequestType('Inventory');
       DI.updateProjectPiece();
       sObject sObj = o;
        
       List<selectOption> options = DI.getPickValues(sObj, 'StageName', 'Something');
       string notes = DI.getNotes();
       DI.setNotes(notes);
       DI.getRequestType();
       DI.getRequestOptions();
       DI.getPieceRunnerHistory();
       DI.getThisProject();
       DI.goToPiece();
       DI.returnToProject();
       
        
    }
}