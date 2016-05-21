@isTest(SeeAllData=True)
private class handler_Project_test {

   static testMethod void myUnitTest2() {

          Account A = new Account();
            A.ShippingCity='test';
            A.ShippingStreet='test';
            A.ShippingState='XX';
            A.ShippingPostalCode='test';
            A.BillingState = 'XX';
            A.AccountNumber = '1';
            A.BillingCity = 'test';
            A.BillingCountry = 'USA';
            A.BillingPostalCode = '66212';
            A.BillingState = 'KS';
            A.BillingStreet = '1234';
            
            A.name = 'TestAccount';
            insert A;
            
            A.Type = 'Prospect';
            
            update A;
            string AcctId = A.Id;
            
            Contact Ctc = new Contact();
            Ctc.AccountId = A.Id;
            Ctc.FirstName = 'test';
            Ctc.LastName = 'test';
                
            insert Ctc;

            Account acc =TestData.setupAccount();
            insert acc;
            Contract  c = TestData.setupContract(acc, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
            c.LOB__c = 'VAUTO';
            c.Action__c = 'Modify';
            c.Status = 'Draft';
            insert c;
            
            
            Opportunity O  = new Opportunity();
            O.AccountId = AcctId; //set the required fields
            O.Name = 'test';
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today()+5;
            O.StageName = 'Prospect';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            O.Implementation_Contact__c = Ctc.id;
            //O.We_Owe__c = 'N/A'; 
            
            insert O; //save it to SFDC (it will rollback after your test

         //Project
            SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
            prj.Opportunity__c = O.Id;
            prj.Date_Packet_Sent__c = null;
            prj.RecordTypeId = '012700000005dgP';//implementation
            prj.Training_Included__c = TRUE;
            prj.Project_Complete_Date__c = system.today();
          //  prj.OwnerId = u_testMethodUser.Id;  
            
            insert prj;

            Project_Piece__c PP = new Project_Piece__c();
            PP.Project__c = prj.Id;
            PP.Piece_Issue__c = 'TestPiece - Sticker';
            PP.Name = 'PP-Inventory Module-LYNNTEST';
            PP.Project_Piece_Stage__c = 'Introduction';
            PP.product_name__c = 'Stockwave';
            insert PP;

            Billing_Item__c bl1 = TestData.setUpBillingItem(c, TestData.getProduct('Appraisal Tool','vAuto'));
            bl1.related_project_piece__c = PP.id;
            bl1.LOB_status__c = 'pending launch approval';
            insert bl1; 
            prj.Training_Included__c = FALSE;
            update prj;

            //Project
            SFDC_520_Quote__c prj2 = new SFDC_520_Quote__c();
            prj2.Opportunity__c = O.Id;
            prj2.Date_Packet_Sent__c = null;
            prj2.RecordTypeId = '012700000005dgP';//implementation
            prj2.Training_Included__c = TRUE;
            insert prj2;

            Project_Piece__c PP2 = new Project_Piece__c();
            PP2.Project__c = prj2.Id;
            PP2.Piece_Issue__c = 'TestPiece - Sticker';
            PP2.Name = 'PP-Inventory Module-LYNNTEST123';
           // PP2.Project_Piece_Stage__c = 'Integration';
            PP2.product_name__c = 'Stockwave';
            insert PP2;

            Billing_Item__c bl2 = TestData.setUpBillingItem(c, TestData.getProduct('Appraisal Tool','vAuto'));
            bl2.related_project_piece__c = PP2.id;
            bl2.LOB_status__c = 'Pending Needs Data';
            insert bl2; 
            prj2.Approval_Stage__c = 'Integration';
            
            update prj2;

            //Project
            SFDC_520_Quote__c prj3 = new SFDC_520_Quote__c();
            prj3.Opportunity__c = O.Id;
            prj3.Date_Packet_Sent__c = null;
            prj3.RecordTypeId = '012700000005dgP';//implementation
            prj3.Training_Included__c = TRUE;
            insert prj3;

            Project_Piece__c PP3 = new Project_Piece__c();
            PP3.Project__c = prj3.Id;
            PP3.Piece_Issue__c = 'TestPiece - Sticker';
            PP3.Name = 'PP-Inventory Module-LYNNTEST123';
           // PP2.Project_Piece_Stage__c = 'Integration';
            PP3.product_name__c = 'Stockwave';
            insert PP3;

            Billing_Item__c bl3 = TestData.setUpBillingItem(c, TestData.getProduct('Appraisal Tool','vAuto'));
            bl3.related_project_piece__c = PP3.id;
            bl3.LOB_status__c = 'Pending needs Training';
            insert bl3; 
            prj3.Approval_Stage__c = 'Training 1';
            
            update prj3;

     }

}