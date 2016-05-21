@isTest
public with sharing class ProjectPieceProcessTest {
	public static testmethod void test1MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
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
        O.ValidationRules__c = true;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		
		
	}
	
	public static testmethod void test2MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
        pProc.Assign_to_Role_1__c = 'Dealer Advocate';
        pProc.Milestone_2__c = 'Test Milestone 2';
        pProc.Milestone_2_Stage__c = 'Completed';
        pProc.Assign_to_Role_2__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		
		
	}
	public static testmethod void test3MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
        pProc.Assign_to_Role_1__c = 'DDM';
        pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
        pProc.Assign_to_Role_2__c = 'Dealer Advocate';
        pProc.Milestone_3__c = 'Test Milestone 2';
        pProc.Milestone_3_Stage__c = 'Completed';
        pProc.Assign_to_Role_3__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		
		
	}
	public static testmethod void test4MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
        pProc.Assign_to_Role_1__c = 'Project Manager';
		pProc.Milestone_2__c = 'Test Milestone 2';
        pProc.Milestone_2_Stage__c = 'Configuration';
        pProc.Assign_to_Role_2__c = 'DDM';
        pProc.Milestone_3__c = 'Test Milestone 3';
        pProc.Milestone_3_Stage__c = 'Configuration';
        pProc.Assign_to_Role_3__c = 'Dealer Advocate';
        pProc.Milestone_4__c = 'Test Milestone 4';
        pProc.Milestone_4_Stage__c = 'Completed';
        pProc.Assign_to_Role_4__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		
		
	}
	
	public static testmethod void test5MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Regional';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
        pProc.Assign_to_Role_2__c = 'Project Owner';
		pProc.Milestone_3__c = 'Test Milestone 2';
        pProc.Milestone_3_Stage__c = 'Configuration';
        pProc.Assign_to_Role_3__c = 'DDM';
        pProc.Milestone_4__c = 'Test Milestone 3';
        pProc.Milestone_4_Stage__c = 'Configuration';
        pProc.Assign_to_Role_4__c = 'Dealer Advocate';
        pProc.Milestone_5__c = 'Test Milestone 4';
        pProc.Milestone_5_Stage__c = 'Completed';
        pProc.Assign_to_Role_5__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		
		
	}
	
	public static testmethod void test6MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Territory Manager';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Regional';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
        pProc.Assign_to_Role_3__c = 'Project Owner';
		pProc.Milestone_4__c = 'Test Milestone 2';
        pProc.Milestone_4_Stage__c = 'Configuration';
        pProc.Assign_to_Role_4__c = 'DDM';
        pProc.Milestone_5__c = 'Test Milestone 3';
        pProc.Milestone_5_Stage__c = 'Configuration';
        pProc.Assign_to_Role_5__c = 'Dealer Advocate';
        pProc.Milestone_6__c = 'Test Milestone 4';
        pProc.Milestone_6_Stage__c = 'Completed';
        pProc.Assign_to_Role_6__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		
		
	}
	public static testmethod void test7MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Implementation Manager';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Territory Manager';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Regional';
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
        pProc.Assign_to_Role_4__c = 'Project Owner';
		pProc.Milestone_5__c = 'Test Milestone 2';
        pProc.Milestone_5_Stage__c = 'Configuration';
        pProc.Assign_to_Role_5__c = 'DDM';
        pProc.Milestone_6__c = 'Test Milestone 3';
        pProc.Milestone_6_Stage__c = 'Configuration';
        pProc.Assign_to_Role_6__c = 'Dealer Advocate';
        pProc.Milestone_7__c = 'Test Milestone 4';
        pProc.Milestone_7_Stage__c = 'Completed';
        pProc.Assign_to_Role_7__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		
		
	}
	public static testmethod void test8MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Dealer Advocate';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Implementation Manager';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Territory Manager';
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Regional';
		pProc.Milestone_5__c = 'Test Milestone 1';
        pProc.Milestone_5_Stage__c = 'Configuration';
        pProc.Assign_to_Role_5__c = 'Project Owner';
		pProc.Milestone_6__c = 'Test Milestone 2';
        pProc.Milestone_6_Stage__c = 'Configuration';
        pProc.Assign_to_Role_6__c = 'DDM';
        pProc.Milestone_7__c = 'Test Milestone 3';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'Dealer Advocate';
        pProc.Milestone_8__c = 'Test Milestone 4';
        pProc.Milestone_8_Stage__c = 'Completed';
        pProc.Assign_to_Role_8__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		
		
	}
	public static testmethod void test9MilestoneComplete()
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'DDM';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Dealer Advocate';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Implementation Manager';
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Territory Manager';
		pProc.Milestone_5__c = 'Test Milestone 1';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Regional';
		pProc.Milestone_6__c = 'Test Milestone 1';
        pProc.Milestone_6_Stage__c = 'Configuration';
        pProc.Assign_to_Role_6__c = 'Project Owner';
		pProc.Milestone_7__c = 'Test Milestone 2';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'DDM';
        pProc.Milestone_8__c = 'Test Milestone 3';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'Dealer Advocate';
        pProc.Milestone_9__c = 'Test Milestone 4';
        pProc.Milestone_9_Stage__c = 'Completed';
        pProc.Assign_to_Role_9__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		
		
	}
	
	/* ----------------------------------------------------------------------------------------
	
	public static testmethod void test10MilestoneComplete1()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
						
		Account updatedAccount = [select Id, DDM__c, Account_Manager__c from Account where id =: A.Id limit 1];
			
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Project Owner';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'DDM';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Dealer Advocate';
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Implementation Manager';
		pProc.Milestone_5__c = 'Test Milestone 1';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Territory Manager';
		pProc.Milestone_6__c = 'Test Milestone 1';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Regional';
		pProc.Milestone_7__c = 'Test Milestone 1';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'Project Owner';
		pProc.Milestone_8__c = 'Test Milestone 2';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'DDM';
        pProc.Milestone_9__c = 'Test Milestone 3';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'Dealer Advocate';
        pProc.Milestone_10__c = 'Test Milestone 4';
        pProc.Milestone_10_Stage__c = 'Completed';
        pProc.Assign_to_Role_10__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		
		
	}
	public static testmethod void test10MilestoneComplete2()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
						
		Account updatedAccount = [select Id, DDM__c, Account_Manager__c from Account where id =: A.Id limit 1];
			
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Regional';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Project Owner';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'DDM';
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Dealer Advocate';
		pProc.Milestone_5__c = 'Test Milestone 1';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Implementation Manager';
		pProc.Milestone_6__c = 'Test Milestone 1';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Territory Manager';
		pProc.Milestone_7__c = 'Test Milestone 1';
        pProc.Milestone_7_Stage__c = 'Configuration';
		pProc.Assign_to_Role_7__c = 'Regional';
		pProc.Milestone_8__c = 'Test Milestone 1';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'Project Owner';
		pProc.Milestone_9__c = 'Test Milestone 2';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'DDM';
        pProc.Milestone_10__c = 'Test Milestone 3';
        pProc.Milestone_10_Stage__c = 'Configuration';
        pProc.Assign_to_Role_10__c = 'Dealer Advocate';
                
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		
		
	}
	public static testmethod void test10MilestoneComplete3()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
						
		Account updatedAccount = [select Id, DDM__c, Account_Manager__c from Account where id =: A.Id limit 1];
			
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Territory Manager';		
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Regional';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Project Owner';
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'DDM';
		pProc.Milestone_5__c = 'Test Milestone 1';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Dealer Advocate';
		pProc.Milestone_6__c = 'Test Milestone 1';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Implementation Manager';
		pProc.Milestone_7__c = 'Test Milestone 1';
        pProc.Milestone_7_Stage__c = 'Configuration';
		pProc.Assign_to_Role_7__c = 'Territory Manager';
		pProc.Milestone_8__c = 'Test Milestone 1';
        pProc.Milestone_8_Stage__c = 'Configuration';
		pProc.Assign_to_Role_8__c = 'Regional';
		pProc.Milestone_9__c = 'Test Milestone 1';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'Project Owner';
		pProc.Milestone_10__c = 'Test Milestone 2';
        pProc.Milestone_10_Stage__c = 'Configuration';
        pProc.Assign_to_Role_10__c = 'DDM';

                
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		
		
	}
	public static testmethod void test10MilestoneComplete4()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
						
		Account updatedAccount = [select Id, DDM__c, Account_Manager__c from Account where id =: A.Id limit 1];
			
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Implementation Manager';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Territory Manager';		
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Regional';
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Project Owner';
		pProc.Milestone_5__c = 'Test Milestone 1';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'DDM';
		pProc.Milestone_6__c = 'Test Milestone 1';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Dealer Advocate';
		pProc.Milestone_7__c = 'Test Milestone 1';
        pProc.Milestone_7_Stage__c = 'Configuration';
		pProc.Assign_to_Role_7__c = 'Implementation Manager';
		pProc.Milestone_8__c = 'Test Milestone 1';
        pProc.Milestone_8_Stage__c = 'Configuration';
		pProc.Assign_to_Role_8__c = 'Territory Manager';
		pProc.Milestone_9__c = 'Test Milestone 1';
        pProc.Milestone_9_Stage__c = 'Configuration';
		pProc.Assign_to_Role_9__c = 'Regional';
		pProc.Milestone_10__c = 'Test Milestone 1';
        pProc.Milestone_10_Stage__c = 'Configuration';
        pProc.Assign_to_Role_10__c = 'Project Owner';

                
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		
		
	}
	
	public static testmethod void test10MilestoneComplete5()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
						
		Account updatedAccount = [select Id, DDM__c, Account_Manager__c from Account where id =: A.Id limit 1];
			
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Dealer Advocate';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Implementation Manager';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Territory Manager';		
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Regional';
		pProc.Milestone_5__c = 'Test Milestone 1';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Project Owner';
		pProc.Milestone_6__c = 'Test Milestone 1';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'DDM';
		pProc.Milestone_7__c = 'Test Milestone 1';
        pProc.Milestone_7_Stage__c = 'Configuration';
		pProc.Assign_to_Role_7__c = 'Dealer Advocate';
		pProc.Milestone_8__c = 'Test Milestone 1';
        pProc.Milestone_8_Stage__c = 'Configuration';
		pProc.Assign_to_Role_8__c = 'Implementation Manager';
		pProc.Milestone_9__c = 'Test Milestone 1';
        pProc.Milestone_9_Stage__c = 'Configuration';
		pProc.Assign_to_Role_9__c = 'Territory Manager';
		pProc.Milestone_10__c = 'Test Milestone 1';
        pProc.Milestone_10_Stage__c = 'Configuration';
		pProc.Assign_to_Role_10__c = 'Regional';
		                
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		
		
	}
	
		public static testmethod void test10MilestoneComplete6()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
						
		Account updatedAccount = [select Id, DDM__c, Account_Manager__c from Account where id =: A.Id limit 1];
			
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'DDM';
		pProc.Milestone_2__c = 'Test Milestone 1';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'Dealer Advocate';
		pProc.Milestone_3__c = 'Test Milestone 1';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Implementation Manager';
		pProc.Milestone_4__c = 'Test Milestone 1';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Territory Manager';		
		pProc.Milestone_5__c = 'Test Milestone 1';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Regional';
		pProc.Milestone_6__c = 'Test Milestone 1';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Project Owner';
		pProc.Milestone_7__c = 'Test Milestone 1';
        pProc.Milestone_7_Stage__c = 'Configuration';
		pProc.Assign_to_Role_7__c = 'DDM';
		pProc.Milestone_8__c = 'Test Milestone 1';
        pProc.Milestone_8_Stage__c = 'Configuration';
		pProc.Assign_to_Role_8__c = 'Dealer Advocate';
		pProc.Milestone_9__c = 'Test Milestone 1';
        pProc.Milestone_9_Stage__c = 'Configuration';
		pProc.Assign_to_Role_9__c = 'Implementation Manager';
		pProc.Milestone_10__c = 'Test Milestone 1';
        pProc.Milestone_10_Stage__c = 'Configuration';
		pProc.Assign_to_Role_10__c = 'Territory Manager';
				                
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
        insert O;   
		
		SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
		proj.Opportunity__c = O.Id;
		proj.Name = 'test project';
		insert proj;
		
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Name = 'test';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		
		
	}
	---------------------------------------------------------------------------------------- */
	
	public static testMethod void testInventoryModulePIupdate1to5()	
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
		pProc.Milestone_1__c = 'received complete inventory verification';
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Project Owner';
		pProc.Milestone_2__c = 'received complete inventory verification';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'DDM';
		pProc.Milestone_3__c = 'received complete inventory verification';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Dealer Advocate';
		pProc.Milestone_4__c = 'received complete inventory verification';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Implementation Manager';
		pProc.Milestone_5__c = 'received complete inventory verification';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Territory Manager';
		pProc.Milestone_6__c = 'received complete inventory verification';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Regional';
		pProc.Milestone_7__c = 'received complete inventory verification';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'Project Owner';
		pProc.Milestone_8__c = 'received complete inventory verification';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'DDM';
        pProc.Milestone_9__c = 'received complete inventory verification';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'Dealer Advocate';
        pProc.Milestone_10__c = 'received complete inventory verification';
        pProc.Milestone_10_Stage__c = 'Completed';
        pProc.Assign_to_Role_10__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'inventory module';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		test.startTest();
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		test.stopTest();		
	}
	
	public static testMethod void testInventoryModulePIupdate6to10()	
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
		pProc.Milestone_1__c = 'received complete inventory verification';
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Project Owner';
		pProc.Milestone_2__c = 'received complete inventory verification';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'DDM';
		pProc.Milestone_3__c = 'received complete inventory verification';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Dealer Advocate';
		pProc.Milestone_4__c = 'received complete inventory verification';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Implementation Manager';
		pProc.Milestone_5__c = 'received complete inventory verification';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Territory Manager';
		pProc.Milestone_6__c = 'received complete inventory verification';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Regional';
		pProc.Milestone_7__c = 'received complete inventory verification';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'Project Owner';
		pProc.Milestone_8__c = 'received complete inventory verification';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'DDM';
        pProc.Milestone_9__c = 'received complete inventory verification';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'Dealer Advocate';
        pProc.Milestone_10__c = 'received complete inventory verification';
        pProc.Milestone_10_Stage__c = 'Completed';
        pProc.Assign_to_Role_10__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'inventory module';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		test.startTest();
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		test.stopTest();		
	}
	
	public static testMethod void testILMPIupdate1to5()	
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
		pProc.Milestone_1__c = 'gather prospect data';
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Project Owner';
		pProc.Milestone_2__c = 'gather prospect data';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'DDM';
		pProc.Milestone_3__c = 'gather prospect data';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Dealer Advocate';
		pProc.Milestone_4__c = 'gather prospect data';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Implementation Manager';
		pProc.Milestone_5__c = 'gather prospect data';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Territory Manager';
		pProc.Milestone_6__c = 'gather prospect data';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Regional';
		pProc.Milestone_7__c = 'gather prospect data';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'Project Owner';
		pProc.Milestone_8__c = 'gather prospect data';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'DDM';
        pProc.Milestone_9__c = 'gather prospect data';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'Dealer Advocate';
        pProc.Milestone_10__c = 'gather prospect data';
        pProc.Milestone_10_Stage__c = 'Completed';
        pProc.Assign_to_Role_10__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'ilm';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		test.startTest();
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		test.stopTest();		
	}
	
	public static testMethod void testILMPIupdate6to10()	
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
		pProc.Milestone_1__c = 'gather prospect data';
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Project Owner';
		pProc.Milestone_2__c = 'gather prospect data';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'DDM';
		pProc.Milestone_3__c = 'gather prospect data';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Dealer Advocate';
		pProc.Milestone_4__c = 'gather prospect data';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Implementation Manager';
		pProc.Milestone_5__c = 'gather prospect data';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Territory Manager';
		pProc.Milestone_6__c = 'gather prospect data';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Regional';
		pProc.Milestone_7__c = 'gather prospect data';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'Project Owner';
		pProc.Milestone_8__c = 'gather prospect data';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'DDM';
        pProc.Milestone_9__c = 'gather prospect data';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'Dealer Advocate';
        pProc.Milestone_10__c = 'gather prospect data';
        pProc.Milestone_10_Stage__c = 'Completed';
        pProc.Assign_to_Role_10__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'ilm';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		test.startTest();
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		test.stopTest();		
	}
	
	public static testMethod void testCRMPIupdate1to5()	
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
		pProc.Milestone_1__c = 'connection made';
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Project Owner';
		pProc.Milestone_2__c = 'connection made';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'DDM';
		pProc.Milestone_3__c = 'connection made';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Dealer Advocate';
		pProc.Milestone_4__c = 'connection made';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Implementation Manager';
		pProc.Milestone_5__c = 'connection made';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Territory Manager';
		pProc.Milestone_6__c = 'connection made';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Regional';
		pProc.Milestone_7__c = 'connection made';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'Project Owner';
		pProc.Milestone_8__c = 'connection made';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'DDM';
        pProc.Milestone_9__c = 'connection made';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'Dealer Advocate';
        pProc.Milestone_10__c = 'connection made';
        pProc.Milestone_10_Stage__c = 'Completed';
        pProc.Assign_to_Role_10__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'crm';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		test.startTest();
		updatedPP.Milestone_1_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_2_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_3_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_4_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_5_Completed__c = system.today();
		update updatedPP;
		test.stopTest();		
	}
	
	public static testMethod void testCRMPIupdate6to10()	
	{
		Territory_State__c TS = new Territory_State__c();
		/*TS.Account_Manager__c = userinfo.getUserId();*/
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
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
		C.Phone = '9999999999';
		insert C;
		
		string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
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
		pProc.Milestone_1__c = 'connection made';
        pProc.Milestone_1_Stage__c = 'Configuration';
		pProc.Assign_to_Role_1__c = 'Project Owner';
		pProc.Milestone_2__c = 'connection made';
        pProc.Milestone_2_Stage__c = 'Configuration';
		pProc.Assign_to_Role_2__c = 'DDM';
		pProc.Milestone_3__c = 'connection made';
        pProc.Milestone_3_Stage__c = 'Configuration';
		pProc.Assign_to_Role_3__c = 'Dealer Advocate';
		pProc.Milestone_4__c = 'connection made';
        pProc.Milestone_4_Stage__c = 'Configuration';
		pProc.Assign_to_Role_4__c = 'Implementation Manager';
		pProc.Milestone_5__c = 'connection made';
        pProc.Milestone_5_Stage__c = 'Configuration';
		pProc.Assign_to_Role_5__c = 'Territory Manager';
		pProc.Milestone_6__c = 'connection made';
        pProc.Milestone_6_Stage__c = 'Configuration';
		pProc.Assign_to_Role_6__c = 'Regional';
		pProc.Milestone_7__c = 'connection made';
        pProc.Milestone_7_Stage__c = 'Configuration';
        pProc.Assign_to_Role_7__c = 'Project Owner';
		pProc.Milestone_8__c = 'connection made';
        pProc.Milestone_8_Stage__c = 'Configuration';
        pProc.Assign_to_Role_8__c = 'DDM';
        pProc.Milestone_9__c = 'connection made';
        pProc.Milestone_9_Stage__c = 'Configuration';
        pProc.Assign_to_Role_9__c = 'Dealer Advocate';
        pProc.Milestone_10__c = 'connection made';
        pProc.Milestone_10_Stage__c = 'Completed';
        pProc.Assign_to_Role_10__c = 'Implementation Manager';
        
        insert pProc;
                
        Opportunity O = new Opportunity();
        O.AccountId = updatedAccount.Id;
        O.Name = 'Test Opportunity';
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.Id;
        O.ValidationRules__c = true;
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
		PP.Name = 'crm';
		PP.Project__c = proj.Id;
		PP.Product_Process__c = PProc.Id; 
		PP.Piece_Issue__c = 'test';
		PP.Account__c = updatedAccount.Id;
		
		insert PP;
		
		Project_Piece__c updatedPP = [select id, Milestone_1_Completed__c, Number_of_Milestones__c from Project_Piece__c where id =: pp.Id limit 1];
		
		test.startTest();
		updatedPP.Milestone_6_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_7_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_8_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_9_Completed__c = system.today();
		update updatedPP;
		updatedPP.Milestone_10_Completed__c = system.today();
		update updatedPP;
		test.stopTest();		
	}
	
	
	
}