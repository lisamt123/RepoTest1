@isTest(SeeAllData=True)
private class ProjectPieceReconciliation_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	//Set your controller
        	//ProjectPieceReconciliation controller = new ProjectPieceReconciliation();
        	
        	test.startTest();
        	
        	//ProjectPieceReconciliation.reconcile();
        	
        	test.stopTest();
        }
    }
    
    public static testmethod void testRec()
  	{
  		
        for(integer i=0;i<2;i++)
        {
  			/*Territory_State__c TS = new Territory_State__c();
            TS.DDM__c = userinfo.getUserId();
            TS.Name = 'TS';
			TS.Implementation_Manager__c = userinfo.getUserId();
        	TS.Implementation_Specialist__c = userinfo.getUserId();            
            insert TS;*/
            
            Account A = new Account();
            A.BillingState = 'KS';
            A.Name = 'test';
            A.AccountNumber = '1234';
            A.ShippingStreet = '1234';
            A.ShippingState = 'TS';
            A.ShippingPostalCode = '66212';
            A.ShippingCountry = 'USA';
            A.ShippingCity = 'test';
            A.BillingCity = 'test';
            A.BillingCountry = 'USA';
            A.BillingPostalCode = '66212';
            A.BillingState = 'KS';
            A.BillingStreet = '1234';
            insert A;
            
            Contact C = new Contact();
            C.FirstName = 'test';
            C.LastName = 'testing';
            C.AccountId = A.Id;
            C.Phone = '9999999999';
            insert C;
            
            string opptyName = 'test';
            if(i==0) opptyName = 'CRM';
            if(i==1) opptyName = 'ILM';
            if(i==2) opptyName = 'Inventory Light';
            if(i==3) opptyName = 'DIY';         
            
            Opportunity O = new Opportunity();
            O.AccountId = A.Id;
            O.Name = opptyName;
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            insert O;
            
            SFDC_520_Quote__c Proj = new SFDC_520_Quote__c();
            Proj.Name = 'TEST PROJECT';
            Proj.Opportunity__c = O.Id;
            
            insert Proj;
            
            string prodName = 'test';
            if(i==0) prodName = 'CRM';
            if(i==1) prodName = 'ILM';
            if(i==2) prodName = 'Inventory Light';
            if(i==3) prodName = 'DIY';  
            
            Product2 product = new Product2(
            name = prodName);   
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
            //insert OLI;
            
            O.Implementation_Contact__c = C.Id;
            O.Deal_Contact__c = C.Id;
            //O.We_Owe__c = 'test';
            //O.Number_of_Installments__c = '1';
            //update O;
            
            O.Inactive_Product_Override__c = true;
            O.StageName = 'Closed or Won';
            //update O;
            
            //if(i==1)
           // {
                //Installment__c Ins = new Installment__c(); //[select id, Paid__c from Installment__c where Opportunity__c =: O.Id order by Installment_Due_Date__c asc limit 1];//new Installment__c();
                //Ins.Opportunity__c = O.id;
                //Ins.OwnerId = '00570000001eX7eAAE';
                //insert Ins;
                
                //Ins.Paid__c = system.today();
                //update Ins;
            //}   
        
        
      
        
        PageReference testStart = Page.ProjectPieceReconciliation;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', O.Id);
        
        ApexPages.StandardController controller = new ApexPages.StandardController(O);
        
        ProjectPieceReconciliation PPR = new ProjectPieceReconciliation(controller);
       
       
       
       PPR.initList();
       PPR.getOLIs();
       PPR.getPPs();
       
       		//PPR.reconcile();
            
        }
       
  	}
  	
  	public static testmethod void testRec2()
  	{
  		
        for(integer i=2;i<4;i++)
        {
  			/*Territory_State__c TS = new Territory_State__c();
            TS.DDM__c = userinfo.getUserId();
            TS.Name = 'TS';
			TS.Implementation_Manager__c = userinfo.getUserId();
        	TS.Implementation_Specialist__c = userinfo.getUserId();            
            insert TS;*/
            
            Account A = new Account();
            A.BillingState = 'TS';
            A.Name = 'test';
            A.AccountNumber = '1234';
            A.ShippingStreet = '1234';
            A.ShippingState = 'KS';
            A.ShippingPostalCode = '66212';
            A.ShippingCountry = 'USA';
            A.ShippingCity = 'test';
            A.BillingCity = 'test';
            A.BillingCountry = 'USA';
            A.BillingPostalCode = '66212'; 
            A.BillingState = 'KS';
            A.BillingStreet = '1234';
            insert A;
            
            Contact C = new Contact();
            C.FirstName = 'test';
            C.LastName = 'testing';
            C.AccountId = A.Id;
            C.Phone = '9999999999';
            insert C;
            
            string opptyName = 'test';
            if(i==0) opptyName = 'CRM';
            if(i==1) opptyName = 'ILM';
            if(i==2) opptyName = 'Inventory Light';
            if(i==3) opptyName = 'DIY';         
            
            Opportunity O = new Opportunity();
            O.AccountId = A.Id;
            O.Name = opptyName;
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            insert O;
            
            SFDC_520_Quote__c Proj = new SFDC_520_Quote__c();
            Proj.Name = 'TEST PROJECT';
            Proj.Opportunity__c = O.Id;
            
            insert Proj;
            
            string prodName = 'test';
            if(i==0) prodName = 'CRM';
            if(i==1) prodName = 'ILM';
            if(i==2) prodName = 'Inventory Light';
            if(i==3) prodName = 'DIY';  
            
            Product2 product = new Product2(
            name = prodName);   
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
            //insert OLI;
            
            O.Implementation_Contact__c = C.Id;
            O.Deal_Contact__c = C.Id;
           // O.We_Owe__c = 'test';
            //O.Number_of_Installments__c = '1';
            //update O;
            
            O.Inactive_Product_Override__c = true;
            O.StageName = 'Closed or Won';
            //update O;
            
            if(i==3)
            {
                //Installment__c Ins = new Installment__c(); //[select id, Paid__c from Installment__c where Opportunity__c =: O.Id order by Installment_Due_Date__c asc limit 1];//new Installment__c();
                //Ins.Opportunity__c = O.id;
                //Ins.OwnerId = '00570000001eX7eAAE';
                //insert Ins;
                
                //Ins.Paid__c = system.today();
                //update Ins;
	            SFDC_520_Quote__c deleteProject = [select Id, Opportunity__c from SFDC_520_Quote__c where Opportunity__c =: O.Id limit 1];
	            LIST<Project_Piece__c> deletePieces = [select Id, Project__c from Project_Piece__c where Project__c =: deleteProject.Id];
	            
	            delete deletePieces;
	            
            }
                    
	        PageReference testStart = Page.ProjectPieceReconciliation;
			Test.setCurrentPage(testStart);
			
			ApexPages.currentPage().getParameters().put('Id', O.Id);
	        
	        ApexPages.StandardController controller = new ApexPages.StandardController(O);
	        
	        ProjectPieceReconciliation PPR = new ProjectPieceReconciliation(controller);
       
       
       
	       /*PPR.initList();
	       PPR.getOLIs();
	       PPR.getPPs();*/
       
       
            
        }
       
  	}
}