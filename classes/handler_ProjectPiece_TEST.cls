@isTest(SeeAllData=True)
private class handler_ProjectPiece_TEST {

    static testMethod void myUnitTest() {
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	    insert u_testMethodUser;
	    
	    System.runas(u_testMethodUser){
	    	
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
		A.BillingState = 'TS';
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
		insert A;
		
		Account updatedAccount = [select Id from Account where id =: A.Id limit 1];

		
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		     
        Product2 product = new Product2();
        product.Name = 'CRM';
        product.Quantity_Exception__c = true;
        product.IsTraining__c = true;
        product.ExpPaidByDealer__c = true;
        product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
        product.Description = 'Test Project';
        product.IsPackageParent__c = true;
		product.Production_Department__c = 'Test';
		product.Production_Issue__c = 'Test';
		product.ProdProj_Default_Owner__c = userinfo.getUserId();
		product.requiresWelcomePacket__c = true;

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
        pProc.Milestone_1__c = 'Test Milestone 1';
        pProc.Milestone_1_Stage__c = 'Completed';
        pProc.Assign_to_Role_1__c = 'DDM';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = A.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        // O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'PP-Inventory Module-';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		PP.Milestone_1_Completed__c = system.today()-4;
		PP.Milestone_3_Completed__c = system.today()-4;
		PP.Milestone_4_Completed__c = system.today()-4;
		PP.Milestone_5_Completed__c = system.today()-4;
		PP.Milestone_6_Completed__c = system.today()-4;
		PP.Milestone_9_Completed__c = system.today()-4;
		PP.Milestone_2_Completed__c = system.today()-4;
		PP.Milestone_8_Completed__c = system.today()-4;
		PP.Milestone_10_Completed__c = system.today()-4;	
		test.startTest();
			
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c,Milestone_3_Completed__c,Milestone_4_Completed__c, Number_of_Milestones__c,Milestone_5_Completed__c,Milestone_6_Completed__c,Milestone_9_Completed__c,Milestone_2_Completed__c,Milestone_8_Completed__c,Milestone_10_Completed__c from Project_Piece__c where id =: pp.Id limit 1];
		updatedPP.Milestone_1_Completed__c = system.today()-1;
		updatedPP.Milestone_3_Completed__c = system.today()-1;
		updatedPP.Milestone_4_Completed__c = system.today()-1;
		updatedPP.Milestone_5_Completed__c = system.today()-1;
		updatedPP.Milestone_6_Completed__c = system.today()-1;
		updatedPP.Milestone_9_Completed__c = system.today()-1;
		updatedPP.Milestone_2_Completed__c = system.today()-1;
		updatedPP.Milestone_8_Completed__c = system.today()-1;
		updatedPP.Milestone_10_Completed__c = system.today()-1;
        update updatedPP;
        
		updatedPP.Name = 'PP-eBay listings - 10 free';
		PP.Milestone_6_Completed__c = system.today()-4;
		updatedPP.Milestone_6_Completed__c = system.today()-2;
		PP.Milestone_2_Completed__c = system.today()-4;
		updatedPP.Milestone_2_Completed__c = system.today()-2;
		update updatedPP;
		update PP;
		
		updatedPP.Name = 'PP-Photo overlay-';
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Name = 'PP-ILM Implementation-';
		PP.Milestone_1_Completed__c = system.today()-6;
		PP.Milestone_2_Completed__c = system.today()-6;
		PP.Milestone_9_Completed__c = system.today()-6;			
		updatedPP.Milestone_1_Completed__c = system.today()-5;
		updatedPP.Milestone_2_Completed__c = system.today()-5;
		updatedPP.Milestone_9_Completed__c = system.today()-5;
		update PP;
		update updatedPP;				
		updatedPP.Name = 'PP-Email Banners-';
		updatedPP.Milestone_6_Completed__c = system.today()-2;
		update updatedPP;		
		updatedPP.Name = 'PP-Launch Coordinator-';
		updatedPP.Milestone_1_Completed__c = system.today()-3;
		updatedPP.Milestone_3_Completed__c = system.today()-3;
		updatedPP.Milestone_4_Completed__c = system.today()-3;
		updatedPP.Milestone_5_Completed__c = system.today()-3;
		updatedPP.Milestone_6_Completed__c = system.today()-3;
		updatedPP.Milestone_9_Completed__c = system.today()-3;
		updatedPP.Milestone_2_Completed__c = system.today()-3;
		updatedPP.Milestone_8_Completed__c = system.today()-3;		
		update updatedPP;	

	    }
    }
    static testMethod void myUnitTest2() {
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	    insert u_testMethodUser;
	    
	    System.runas(u_testMethodUser){
	    	
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
		A.BillingState = 'TS';
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
		insert A;
		
		Account updatedAccount = [select Id from Account where id =: A.Id limit 1];

		
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		     
        Product2 product = new Product2();
        product.Name = 'CRM';
        product.Quantity_Exception__c = true;
        product.IsTraining__c = true;
        product.ExpPaidByDealer__c = true;
        product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
        product.Description = 'Test Project';
        product.IsPackageParent__c = true;
		product.Production_Department__c = 'Test';
		product.Production_Issue__c = 'Test';
		product.ProdProj_Default_Owner__c = userinfo.getUserId();
		product.requiresWelcomePacket__c = true;

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
        pProc.Milestone_1__c = 'Test Milestone 1';
        pProc.Milestone_1_Stage__c = 'Completed';
        pProc.Assign_to_Role_1__c = 'DDM';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = A.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        // O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'PP-Desking-';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		PP.Milestone_1_Completed__c = system.today()-4;
		PP.Milestone_3_Completed__c = system.today()-4;
		PP.Milestone_4_Completed__c = system.today()-4;
		PP.Milestone_5_Completed__c = system.today()-4;
		PP.Milestone_6_Completed__c = system.today()-4;
		PP.Milestone_9_Completed__c = system.today()-4;
		PP.Milestone_2_Completed__c = system.today()-4;
		PP.Milestone_8_Completed__c = system.today()-4;
		PP.Milestone_10_Completed__c = system.today()-4;		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c,Milestone_3_Completed__c,Milestone_4_Completed__c, Number_of_Milestones__c,Milestone_5_Completed__c,Milestone_6_Completed__c,Milestone_9_Completed__c,Milestone_2_Completed__c,Milestone_8_Completed__c,Milestone_10_Completed__c from Project_Piece__c where id =: pp.Id limit 1];
		test.startTest();
		updatedPP.Milestone_1_Completed__c = system.today()-3;
		updatedPP.Milestone_3_Completed__c = system.today()-3;
		updatedPP.Milestone_4_Completed__c = system.today()-3;
		updatedPP.Milestone_5_Completed__c = system.today()-3;
		updatedPP.Milestone_6_Completed__c = system.today()-3;
		updatedPP.Milestone_9_Completed__c = system.today()-3;
		updatedPP.Milestone_2_Completed__c = system.today()-3;
		updatedPP.Milestone_8_Completed__c = system.today()-3;
		updatedPP.Milestone_10_Completed__c = system.today()-3;
        update updatedPP;
        
		updatedPP.Name = 'PP-Text messages-';
		PP.Milestone_4_Completed__c = system.today()-2;      
		update updatedPP;
		update PP;
		
		updatedPP.Milestone_1_Completed__c = system.today()-2;
		updatedPP.Milestone_3_Completed__c = system.today()-2;
		updatedPP.Milestone_5_Completed__c = system.today()-2;
		updatedPP.Milestone_6_Completed__c = system.today()-2;
		updatedPP.Milestone_9_Completed__c = system.today()-2;
		updatedPP.Milestone_2_Completed__c = system.today()-2;
		updatedPP.Milestone_8_Completed__c = system.today()-2;
		updatedPP.Milestone_10_Completed__c = system.today()-2;      

		updatedPP.Name = 'PP-AIS Rebates (Site Integration)-';
		updatedPP.Milestone_3_Completed__c = system.today()-1;
		PP.Milestone_3_Completed__c = system.today()-6;		
		update PP;				
		update updatedPP;	
		updatedPP.Name = 'PP-AIS Rebates (Desking integration) - Inventory-';
		updatedPP.Milestone_3_Completed__c = system.today();
		PP.Milestone_3_Completed__c = system.today()-5;
		update PP;	
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;			
		updatedPP.Name = 'PP-PBX Integration-';
		PP.Milestone_6_Completed__c = system.today()-8;
		updatedPP.Milestone_6_Completed__c = system.today()-4;		
		update PP;
		update updatedPP;	
		PP.Milestone_5_Completed__c = system.today()-1;		
		updatedPP.Name = 'PP-Data Append Authenticom-';
		updatedPP.Milestone_5_Completed__c = system.today()-1;
		update updatedPP;
		update PP;		
						
		test.stopTest();
	    }
    }    
    static testMethod void myUnitTest3() {
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	    insert u_testMethodUser;
	    
	    System.runas(u_testMethodUser){
	    	
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
		A.BillingState = 'TS';
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
		insert A;
		
		Account updatedAccount = [select Id from Account where id =: A.Id limit 1];

		
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		     
        Product2 product = new Product2();
        product.Name = 'CRM';
        product.Quantity_Exception__c = true;
        product.IsTraining__c = true;
        product.ExpPaidByDealer__c = true;
        product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
        product.Description = 'Test Project';
        product.IsPackageParent__c = true;
		product.Production_Department__c = 'Test';
		product.Production_Issue__c = 'Test';
		product.ProdProj_Default_Owner__c = userinfo.getUserId();
		product.requiresWelcomePacket__c = true;

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
        pProc.Milestone_1__c = 'Test Milestone 1';
        pProc.Milestone_1_Stage__c = 'Completed';
        pProc.Assign_to_Role_1__c = 'DDM';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = A.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        // O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'PP-Desking-';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		PP.Milestone_1_Completed__c = system.today()-4;
		PP.Milestone_3_Completed__c = system.today()-4;
		PP.Milestone_4_Completed__c = system.today()-4;
		PP.Milestone_5_Completed__c = system.today()-4;
		PP.Milestone_6_Completed__c = system.today()-4;
		PP.Milestone_9_Completed__c = system.today()-4;
		PP.Milestone_2_Completed__c = system.today()-4;
		PP.Milestone_8_Completed__c = system.today()-4;
		PP.Milestone_10_Completed__c = system.today()-4;		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c,Milestone_3_Completed__c,Milestone_4_Completed__c, Number_of_Milestones__c,Milestone_5_Completed__c,Milestone_6_Completed__c,Milestone_9_Completed__c,Milestone_2_Completed__c,Milestone_8_Completed__c,Milestone_10_Completed__c from Project_Piece__c where id =: pp.Id limit 1];
		test.startTest();
		updatedPP.Milestone_1_Completed__c = system.today()-3;
		updatedPP.Milestone_3_Completed__c = system.today()-3;
		updatedPP.Milestone_4_Completed__c = system.today()-3;
		updatedPP.Milestone_5_Completed__c = system.today()-3;
		updatedPP.Milestone_6_Completed__c = system.today()-3;
		updatedPP.Milestone_9_Completed__c = system.today()-3;
		updatedPP.Milestone_2_Completed__c = system.today()-3;
		updatedPP.Milestone_8_Completed__c = system.today()-3;
		updatedPP.Milestone_10_Completed__c = system.today()-3;
        update updatedPP;
        		
		updatedPP.Name = 'PP-Survey Tool-';
		updatedPP.Milestone_1_Completed__c = system.today()-1;
		update updatedPP;		
		updatedPP.Name = 'PP-Form Mapping-';
		PP.Milestone_1_Completed__c = system.today()-1;
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;		
		update PP;		

		updatedPP.Name = 'PP-CRM Implementation-';	
		updatedPP.Milestone_6_Completed__c = system.today()-2;
		updatedPP.Milestone_9_Completed__c = system.today()-2;
		updatedPP.Milestone_8_Completed__c = system.today()-2;				
		PP.Milestone_9_Completed__c = system.today()-3;
		PP.Milestone_6_Completed__c = system.today()-3;
		PP.Milestone_8_Completed__c = system.today()-3;		
		update PP;
		update updatedPP;					
		updatedPP.Milestone_6_Completed__c = system.today()-1;
		updatedPP.Milestone_9_Completed__c = system.today()-1;
		updatedPP.Milestone_8_Completed__c = system.today()-1;		
		update updatedPP;						
		test.stopTest();
	    }
    }        
}