@isTest(SeeAllData=True)
private class OpportunityPopupController_TEST {

    static testMethod void OpportunityPopupController_TestMethod() {
        // TO DO: implement unit test
        
        
                /*Territory_State__c TS = new Territory_State__c();
                TS.DDM__c = userinfo.getUserId();
                TS.Account_Manager__c = userinfo.getUserId();
                TS.Territory_Manager__c = userinfo.getUserId();
                TS.Implementation_Manager__c = userinfo.getUserId();
       			TS.Implementation_Specialist__c = userinfo.getUserId();
                TS.Regional__c = userinfo.getUserId();
                
                TS.Name = 'TS';
                insert TS;*/
                
                Account A = new Account();
                A.BillingState = 'KS';
                A.BillingCity = 'Test City';
                A.BillingStreet = '123 Test'; 
                A.BillingPostalCode = '12345'; 
                A.BillingCountry = 'USA';
                A.ShippingStreet = '123 Test';
                A.ShippingState = 'KS';
                A.ShippingPostalCode = '12345';
                A.ShippingCountry = 'USA';
                A.ShippingCity = 'Test City';
                A.Name = 'test';
                A.VS_Dealer_ID__c = 1234;
                A.AccountNumber = '1234';
                insert A;
                
                Contact C = new Contact();
                C.FirstName = 'Testfirst';
                C.LastName = 'Testlast';
                C.Account = A;
                C.Phone = '9999999999';
                insert C;
                
                Opportunity O = new Opportunity();
                O.AccountId = A.Id;
                O.Name = 'test';
                O.CloseDate = system.today();
                O.Deal_Contact__c = C.Id;
                O.StageName = 'Prospect';
                O.Implementation_Contact__c = C.id;
                //O.We_Owe__c = 'test we owe';
                O.Number_of_Installments__c = '1';
                O.Amount = 1000;
                
                insert O;
                
                OpportunityLineItem OLI1 = new OpportunityLineItem(); 
                
                Product2 product = new Product2(
		        name = 'TEST');   
		        product.Quantity_Exception__c = true;
		        product.IsTraining__c = true;
		        product.requiresWelcomePacket__c = true;
		        product.ExpPaidByDealer__c = true;
		        product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
		        insert product;
            
		        /*Pricebook2 PB = [select id from Pricebook2 where name = 'Standard Price Book'];     
		        
		        PricebookEntry PBE = new PricebookEntry();
		        PBE.UnitPrice = 100.00;
		        PBE.Pricebook2Id = PB.Id;
		        PBE.Product2Id = product.Id;
		        PBE.IsActive = true;        
		        insert PBE;*/
		        
		        Product_Process__c pProc = new Product_Process__c();
		        pProc.Product__c = product.Id;
		        pProc.Milestone_1__c = 'Test1';
		        pProc.Milestone_1_Stage__c = 'Introduction';
		        pProc.Milestone_2__c = 'Test3';
		        pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';         
		        insert pProc;   
		        
		        /*OpportunityLineItem OLI = new OpportunityLineItem();
		        OLI.PricebookEntryId = PBE.Id;
		        OLI.OpportunityId = O.Id;
		        OLI.Quantity = 2;
		        OLI.TotalPrice = 100.00;
		        insert OLI;*/
        
                PageReference pageRef = Page.OpportunityPopupPage;
                pageRef.getParameters().put('id', O.Id);
                ApexPages.currentPage().getParameters().put('id', O.Id);
                Test.setCurrentPage(pageRef);
                
                ApexPages.Standardcontroller controller = new ApexPages.Standardcontroller(O);
                OpportunityPopupController OPC = new OpportunityPopupController(controller);
                
                
                OPC.Id = O.Id;
                OPC.setThisOpp();
                OPC.updateOppToNoShow();
                OPC.setId();
                OPC.getId();
                OPC.getThisAccount();
                OPC.getOppStatus();
                OPC.setShowPopupDataIntegration();
                OPC.getShowPopupDateIntegration();
                OPC.getShowPopupInactiveProducts();
                OPC.getThisOpp();
                
                
                
                
    }
    
    public static testMethod void testOppPopupController() {
                
    	/*Territory_State__c TS = new Territory_State__c();
        TS.DDM__c = userinfo.getUserId();
        TS.Account_Manager__c = userinfo.getUserId();
        TS.Territory_Manager__c = userinfo.getUserId();
        TS.Implementation_Manager__c = userinfo.getUserId();
   		TS.Implementation_Specialist__c = userinfo.getUserId();
        TS.Regional__c = userinfo.getUserId();
            
        TS.Name = 'TS';
        insert TS;*/
            
		Account A = new Account();
        A.BillingState = 'KS';
        A.BillingCity = 'Test City';
        A.BillingStreet = '123 Test'; 
        A.BillingPostalCode = '12345'; 
        A.BillingCountry = 'USA';
        A.ShippingStreet = '123 Test';
        A.ShippingState = 'KS';
        A.ShippingPostalCode = '12345';
        A.ShippingCountry = 'USA';
        A.ShippingCity = 'Test City';
        A.Name = 'test';
        A.VS_Dealer_ID__c = 1234;
        A.AccountNumber = '1234';
        insert A;
            
        Contact C = new Contact();
        C.FirstName = 'Testfirst';
        C.LastName = 'Testlast';
        C.Account = A;
        C.Phone = '9999999999';
        insert C;
            
        Opportunity O = new Opportunity();
        O.AccountId = A.Id;
        O.Name = 'test';
        O.CloseDate = system.today();
        O.Deal_Contact__c = C.Id;
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.id;
        //O.We_Owe__c = 'test we owe';
        O.Number_of_Installments__c = '1';
        O.Amount = 1000;
        
        insert O;
            
        OpportunityLineItem OLI1 = new OpportunityLineItem(); 
            
        Product2 product = new Product2(name = 'TEST');   
        product.Quantity_Exception__c = true;
        product.IsTraining__c = true;
        product.requiresWelcomePacket__c = true;
        product.ExpPaidByDealer__c = true;
        product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
     	insert product;
            
        Pricebook2 PB = [select id from Pricebook2 where name = 'Standard Price Book' limit 1];     
        
        PricebookEntry PBE = new PricebookEntry();
        PBE.UnitPrice = 100.00;
        PBE.Pricebook2Id = PB.Id;
        PBE.Product2Id = product.Id;
        PBE.IsActive = true;        
        insert PBE;
        
        Product_Process__c pProc = new Product_Process__c();
        pProc.Product__c = product.Id;
        pProc.Milestone_1__c = 'Test1';
        pProc.Milestone_1_Stage__c = 'Introduction';
        pProc.Milestone_2__c = 'Test3';
        pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';         
        insert pProc;   
        
        OpportunityLineItem OLI = new OpportunityLineItem();
        OLI.PricebookEntryId = PBE.Id;
        OLI.OpportunityId = O.Id;
        OLI.Quantity = 2;
        OLI.TotalPrice = 100.00;
        insert OLI;
        
                
                
        ApexPages.Standardcontroller controller = new ApexPages.Standardcontroller(O);
        OpportunityPopupController OPC = new OpportunityPopupController(controller);
        OPC.Id = O.Id;
        OPC.setThisOpp();
        
        
        
        PageReference pageRef = Page.OpportunityPopupPage;
        pageRef.getParameters().put('id', O.Id);
        ApexPages.currentPage().getParameters().put('id', O.Id);
        Test.setCurrentPage(pageRef);
    }
}