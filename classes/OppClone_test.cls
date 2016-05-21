@isTest(SeeAllData=True)
private class OppClone_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Dev Admin'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	/*
        	Change_Request__c c = new Change_Request__c();
        	c.Request_Details__c = 'Owner(Mark Ross) Test Test Test';
        	c.Publish_to_Release_Notes__c = 'No';
        	c.Date_Completed__c = Date.newInstance(2013, 03, 08);
        	
        	insert c;
        	
        	
        	ApexPages.currentPage().getParameters().put('fromDatePicker', '03/03/2013');
        	ApexPages.currentPage().getParameters().put('toDatePicker', '03/25/2013');
        	
        	ApexPages.currentPage().getParameters().put('publishCRId', c.Id);
        	
        	*/
        	
        	/*Territory_State__c TS = new Territory_State__c();
	  		TS.Name = 'TS';
			TS.Account_Manager__c = userinfo.getUserId();
			TS.DDM__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
	        TS.Implementation_Specialist__c = userinfo.getUserId();	
	        TS.Website_Manager__c = userInfo.getUserId();	
			insert TS;*/
	  		
	  		
	  		Account A = new Account();
			A.ShippingCity='test';
			A.ShippingStreet='test';
			A.ShippingState='KS';
			A.ShippingPostalCode='test';
			A.BillingState = 'KS';
			A.AccountNumber = '1';
			A.BillingCity = 'test';
	        A.BillingCountry = 'USA';
	        A.BillingPostalCode = '66212';
	        A.BillingState = 'KS';
	        A.BillingStreet = '1234';
			
			A.name = 'TestAccount';
							
			insert A;
			
			
			//A.Type = 'Prospect';
			
			//update A;
			
			
			
			Contact Ctc = new Contact();
			Ctc.AccountId = A.Id;
			Ctc.FirstName = 'test';
			Ctc.LastName = 'test';
			Ctc.Phone = '9999999999';
					
			insert Ctc;
			
			
			Opportunity O  = new Opportunity();
			O.AccountId = A.Id; 
			O.Name = 'testILM';
			
			O.Deal_Contact__c = Ctc.id;
			O.CloseDate = system.today();
			O.StageName = 'Prospect';
			O.Type = 'New Business';
			O.Salesperson__c = userinfo.getUserId();
			O.ValidationRules__c = true;
			//O.RecordTypeId = '012S00000008rGjIAI';   //generalsales//01270000000Q7t7  //t1/t2//01270000000Q9Me
			O.RecordTypeId = '01270000000Q7t7';
			//O.Initial_Load__c = 5; 
			O.TryCatchTest__c = true;
			O.Add_Deposit__c = 'No';
			O.Deposit_Amount__c = 1;
			insert O; 
			
			Competition__c comp = new Competition__c();
			comp.Opportunity__c = O.Id;
			comp.Name = 'N/A';
		
			insert comp;
			

			Project_Definition__c projDef = new Project_Definition__c();
			projDef.Name = 'TestProjeDefinition';
			projDef.Project_Category__c = 'Websites';
			projDef.POA_Type__c = 'Vin Website';//'Account Mgmt POA';

			projDef.Project_Priority__c = 0;
			projDef.Project_Record_Type__c = 'Websites';
			projDef.isActive__c = true;
			insert projDef;

			string prodName = 'CRM';
        
	        Product2 product = new Product2();
	        product.Name = 'CRM';   
	        product.Quantity_Exception__c = true;
	        product.IsTraining__c = true;
	        product.ExpPaidByDealer__c = true;
	        product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
	        product.Description = 'website';
	        product.IsPackageParent__c = false;
			product.Production_Department__c = 'creative';
			product.Production_Issue__c = 'website';
			product.ProdProj_Default_Owner__c = userinfo.getUserId();
			product.requiresWelcomePacket__c = true;
			product.Related_Product__c = null;
			product.Family = 'Reoccuring';
			product.Project_Definition__c  = projDef.Id;
	
	        insert product;
	        
	        Product2 product4 = new Product2();
	        product4.Name = 'Standalone Website';   
	        product4.Quantity_Exception__c = true;
	        product4.IsTraining__c = true;
	        product4.ExpPaidByDealer__c = true;
	        product4.ProdProj_Default_Owner__c = userinfo.getUserId();                   
	        product4.Description = 'website';
	        product4.IsPackageParent__c =  true;
			product4.Production_Department__c = 'creative';
			product4.Production_Issue__c = 'website';
			product4.ProdProj_Default_Owner__c = userinfo.getUserId();
			product4.requiresWelcomePacket__c = true;
			product4.Related_Product__c = null;
			product4.Family = 'Reoccuring';
			product4.Project_Definition__c  = projDef.Id;
	
	        insert product4;
	        
	        Product2 product5 = new Product2();
	        product5.Name = 'Standalone Website onetime fee';   
	        product5.Quantity_Exception__c = true;
	        product5.IsTraining__c = true;
	        product5.ExpPaidByDealer__c = true;
	        product5.ProdProj_Default_Owner__c = userinfo.getUserId();                   
	        product5.Description = 'website';
	        product5.IsPackageParent__c =  true;
			product5.Production_Department__c = 'creative';
			product5.Production_Issue__c = 'website';
			product5.ProdProj_Default_Owner__c = userinfo.getUserId();
			product5.requiresWelcomePacket__c = true;
			product5.Related_Product__c = null;
			product5.Family = 'Reoccuring';
			product5.Project_Definition__c  = projDef.Id;
	
	        insert product5;
	        
	        
	            
	        Pricebook2 PB = [select Id from Pricebook2 where Name = 'Standard Price Book' limit 1];     
	            
	        PricebookEntry PBE = new PricebookEntry();
	        //PBE.Name = 'Inventory Light';
	        PBE.UnitPrice = 100.00;
	        PBE.Pricebook2Id = PB.Id;
	        PBE.Product2Id = product.Id;
	        PBE.IsActive = true;   
	        
	        insert PBE;
			
			
			OpportunityLineItem OLI = new OpportunityLineItem();
	        OLI.PricebookEntryId = PBE.Id;
	        OLI.OpportunityId = O.Id;
	        OLI.Quantity = 1;
	        OLI.TotalPrice = 100.00;
	        //OLI.Override_Related_Product__c = true;
	        insert OLI;
		
			O.Opportunity_Names__c = 'Hardware';
			O.Multi_Installments_Approved__c=true;
			O.StageName = 'Closed or Won';
			O.Number_of_Installments__c = '1';
			O.Implementation_Contact__c = Ctc.id;
			O.ValidationRules__c = true;
			O.Deal_Contact__c = Ctc.id;
			O.CRM_Vendor__c = 'AAX';
			O.DMS_Vendor__c = 'AAX';
			O.ILM_Vendor__c = 'AAX';
			O.Inventory_Vendor__c = 'AAX';
			O.Pricing_Vendor__c = 'AAX';
			O.Website_Vendor__c = 'AAX';
			//O.We_Owe__c = 'test';
			O.Amount = 1200;
			O.Multi_Installments_Approved__c= true;
			O.Discount_Approval_Status__c = 'Approved';
			O.Add_Deposit__c = 'No';
			O.Deposit_Amount__c = 1;
			update O; 
			
			//Installments
			//Installment__c I = new Installment__c();
			//I.Opportunity__c = O.id;
			//insert I;
			
			
			//I.Paid__c = system.today();
			//I.Payment_Type__c = 'ACH';
			//update I;
			//delete I;
        	
        	
        	
        	//Page Params
        	ApexPages.currentPage().getParameters().put('oppId', O.Id);
        	
        	
        	//Set your controller
        	OppClone controller = new OppClone();
        	
        	
        	test.startTest();
        	
        	
        	controller.performClone();
        	controller.nullPR();
        	/*
        	controller.toggleSort();
        	controller.nullPR();
        	controller.publishCR();
        	controller.runFilter();
        	*/
        	
        	test.stopTest();
        }
    }
}