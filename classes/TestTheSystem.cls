@isTest
private class TestTheSystem 
{

    static testMethod void myUnitTest() 
    {
  		
  		/*Territory_State__c TS = new Territory_State__c(); 
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();		
		insert TS;*/
  		
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
		TEST.startTest();				
		insert A;
		
		A.Type = 'Prospect';
		
		update A;
		TEST.stopTest();
		string AcctId = A.Id;
		
		Contact Ctc = new Contact();
		Ctc.AccountId = A.Id;
		Ctc.FirstName = 'test';
		Ctc.LastName = 'test';
		Ctc.Phone = '9999999999';
			
		insert Ctc;
		
		
		Opportunity O  = new Opportunity();
		O.AccountId = AcctId; //set the required fields
		O.Name = 'test';
		O.Deal_Contact__c = Ctc.id;
		O.CloseDate = System.today();
		O.StageName = 'Prospect';
		O.Type = 'New Business';
		O.Salesperson__c = userinfo.getUserId();
		O.ValidationRules__c = true;
		O.Implementation_Contact__c = Ctc.id;
		// O.We_Owe__c = 'N/A'; 
		
		insert O; //save it to SFDC (it will rollback after your test
		
		Competition__c comp = new Competition__c();
		comp.Opportunity__c = O.Id;
		comp.Name = 'N/A';
		
		insert comp;
		
		O.Multi_Installments_Approved__c=true;
		O.StageName = 'Closed or Won';
		O.Number_of_Installments__c = '3';
		O.ValidationRules__c = true;
		O.CRM_Vendor__c = 'AAX';
		O.DMS_Vendor__c = 'AAX';
		O.ILM_Vendor__c = 'AAX';
		O.Inventory_Vendor__c = 'AAX';
		O.Pricing_Vendor__c = 'AAX';
		O.Website_Vendor__c = 'AAX';
		O.Amount= 1200;
		update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
		O.Amount = 1500;
		OpportunityClass.UpdateInvoiceInformation(O);
		update O;
		
		//Project
		SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
		prj.Opportunity__c = O.Id;
		prj.Date_Packet_Sent__c = null;
		//prj.RecordTypeId = '012700000005dgP';
		prj.RecordTypeId = StaticData.getInstance().ProjectRecTypesMapByDevName.get('Implementation').Id;
		prj.Training_Included__c = TRUE;
		prj.Name = 'Test Project';		
		
		insert prj;
		system.debug('===============>>> Project = ' + prj);
		
					
		Task T1  = new Task();
		T1.Subject = 'Send Packet'; //set the required fields
		T1.WhatId= prj.Id;
		T1.Status='Not Started';
		T1.Type = 'Task';
		
		insert T1; //save it to SFDC (it will rollback after your test
		T1.Status='Completed';
		update T1; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
		
		
		Case CS = new Case();
		CS.AccountId = A.Id;
		CS.ContactId = Ctc.Id;
		CS.Origin = 'Phone';
		CS.Reason = 'Billing';
		CS.Status = 'new';
		CS.Escalate_To__c = null;
		CS.Assigned_To__c = null;
		CS.X1_What_is_happening__c = 'I don\'t know';
		CS.X2_What_did_you_expect_to_happen__c = 'I don\'t know';
		CS.X3_When_did_it_start_happening__c = 'I don\'t know';
		CS.X4_What_do_you_think_the_problem_is__c = 'I don\'t know';
		CS.X5_What_have_you_tried_so_far__c = 'I don\'t know';
		
		insert CS;
		
		
		Attachment Att = new Attachment();
		Att.ParentId = CS.id;
		Att.Body = blob.valueOf('test');
		Att.ContentType = 'jpeg';
		Att.Name = 'test';
		
		insert Att;
		
		Case CS2child = new Case();
		CS2child.AccountId = A.Id;
		CS2child.ContactId = Ctc.Id;
		CS2child.Origin = 'Phone';
		CS2child.Reason = 'Billing';
		CS2child.Status = 'new';
		CS2child.Escalate_To__c = null;
		CS2child.Assigned_To__c = null;
		CS2child.X1_What_is_happening__c = 'I don\'t know';
		CS2child.X2_What_did_you_expect_to_happen__c = 'I don\'t know';
		CS2child.X3_When_did_it_start_happening__c = 'I don\'t know';
		CS2child.X4_What_do_you_think_the_problem_is__c = 'I don\'t know';
		CS2child.X5_What_have_you_tried_so_far__c = 'I don\'t know';
		CS2child.ParentId = CS.Id;
		insert CS2child;
		
		Task T2 = new Task();
		T2.WhatId = CS.Id;
		T2.Subject = 'O/G';
		T2.Status = 'Completed';
		T2.Type = 'Task';
		//insert T2;
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Project__c = prj.Id;
		PP.Piece_Issue__c = 'TestPiece - Sticker';
		PP.Name = 'VinSticker';
		PP.Project_Piece_Stage__c = 'Introduction';
		insert PP;
		system.debug('===============>>> Project Piece = ' + PP);
	
		Project_Comment__c PjctC = new Project_Comment__c();
		PjctC.Comments__c = 'test';
		//PjctC.Project__c = prj.Id;
		//PjctC.Project_Piece__c = PP.Id;	
	
		insert PjctC;
		
		Project_Piece__c PP2 = new Project_Piece__c();
        PP2.OwnerId = userinfo.getUserId();
        PP2.Piece_Issue__c = 'test';
        PP2.Name = 'test';
        PP2.RecordTypeId = '012700000005e2u' ;
        PP2.Project__c = prj.Id;
        PP2.Requirements_Gathered__c = null;
        PP2.Contact_Made__c = null;
        PP2.Design_Completed__c = null;
        PP2.Proof_Approved__c = null;
        PP2.Uploaded_Printed_Shipped__c =null;
        PP2.Project_Piece_Stage__c = 'Requirement Gathering';
        //insert PP2;
        
        Project_Piece__c PP3 = new Project_Piece__c();
        PP3.OwnerId = userinfo.getUserId();
        PP3.Piece_Issue__c = 'test';
        PP3.Name = 'test';
        PP3.RecordTypeId = '012700000005e2u' ;
        PP3.Project__c = prj.Id;
        PP3.Requirements_Gathered__c = null;
        PP3.Contact_Made__c = null;
        PP3.Design_Completed__c = null;
        PP3.Proof_Approved__c = null;
        PP3.Uploaded_Printed_Shipped__c =null;
        PP3.Project_Piece_Stage__c = 'Requirement Gathering';
        //insert PP3;
         
               
        /*Task T3 = new Task();
        T3.WhatId = prj.Id;
        T3.Subject = 'Send Packet';
        T3.Status = 'Not Started';
        T3.Type = 'Task';
        insert T3;
        
        Task T4 = new Task();
        T4.WhatId = prj.Id;
        T4.Subject = 'WFT-Intro Call/Intro Email/Send Packet';
        T4.Status = 'Not Started';
        T4.Type = 'Task';
        insert T4;*/
        //2012-06-01
		//ProCore commented out prj DML for deployment of real time weighted rankings
        prj.Date_Packet_Sent__c = system.today();
        //update prj;   
        
        prj.Date_Graphics_Obtained__c = system.today();
        //update prj;
        
        //prj.Date_Packet_Ret_d__c = system.today();
        //update prj;
        
        LIST<Event> newEvents = new LIST<Event>();
                        
        Event E1  = new Event();
		E1.Subject = 'webex'; //set the required field
		E1.StartDateTime = System.now();
		E1.EndDateTime = System.now();
		E1.WhatId = O.Id;
		E1.WhoId = Ctc.Id;
		
		E1.Exception_Salesperson__c = 'Jonathan Player';
		E1.Salesperson_Exception__c = true;
		//newEvents.add(E1);
		//insert E1; //save it to SFDC (it will rollback after your test
		//update E1; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
			
				
		Event E2  = new Event();
		E2.Subject = 'webex'; //set the required field
		E2.WebEx_Topic__c = 'Nickel Pro; Nickel Plus; Bronze; Silver; Gold; Platinum; DIY; ILM; Website; CRM; Diamond';		
		E2.StartDateTime = System.now();
		E2.EndDateTime = System.now();
		E2.WhoId = Ctc.Id;
		E2.WebEx_Level__c = 'Initial';
		E2.WhatId=O.Id;
		E2.Exception_Salesperson__c = null;
		E2.Salesperson_Exception__c = false;
		newEvents.add(E2);
		//insert E2; //save it to SFDC (it will rollback after your test
		//update E2; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
		//delete E2;
		//undelete E2;
		
		
		Event E3 = new Event();
		E3.Subject = 'onsite';
		E3.WebEx_Topic__c = 'test';
		E3.WebEx_With__c = 'test';
		E3.WhatId = prj.id;
		E3.DurationInMinutes = 60;
		E3.StartDateTime = system.now();
		//insert E3;
		//newEvents.add(E3);
		
		Event E4  = new Event();
		E4.Subject = 'webex meeting'; //set the required field
		E4.StartDateTime = System.now();
		E4.EndDateTime = System.now();
		E4.WhoId = Ctc.Id;
		E4.WhatId=O.Id;
		E4.Exception_Salesperson__c = 'Jonathan Player';
		E4.Salesperson_Exception__c = true;
		//insert E4; //save it to SFDC (it will rollback after your test
		//update E4; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
		//newEvents.add(E4);
		
		//insert newEvents;
		
		//update newEvents;
		//delete newEvents;
		//undelete newEvents;
		
		//PieceWorkflow
		/*SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = O.Id;
		Pro.Account__c = A.Id;
		//Pro.DDM__c = userinfo.getuserId();
		insert Pro;
				
		Project_Piece__c PP4 = new Project_Piece__c();
		PP4.Project__c = Pro.Id;
		PP4.Piece_Issue__c = 'TestPiece - Sticker';
		PP4.Name = 'VinSticker';
		insert PP4;
		
		//Reset Fields
		PP4.Project_Piece_Stage__c = 'Introduction';
		PP4.Contact_Made__c = null;
		PP4.Requirements_Gathered__c = null;
		PP4.Design_Completed__c = null;
		PP4.Proof_Approved__c = null;
		PP4.Uploaded_Printed_Shipped__c = null;
		//update PP4;*/	
										
		Case_Runner__c R = new Case_Runner__c();
		R.Runner_Action__c = 'Escalate';
		R.Escalated_To__c = 'Creative';
		R.Assigned_To__c = userinfo.getUserId();
		R.Case__c = CS.Id;
		 
		//insert R;  
 	   	
 	   	
				
    }
    
    
    //................................................
    //...."TestInstallments"
    //To be deleted.. this method has been moved to 
    //..Installment_TEST.cls
    //................................................
    public static testmethod void TestInstallments()
    {
    	/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();		
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
		
		A.Type = 'Prospect';
		
		update A;
		
		string AcctId = A.Id;
		
		Contact Ctc = new Contact();
		Ctc.AccountId = A.Id;
		Ctc.FirstName = 'test';
		Ctc.LastName = 'test';
		Ctc.Phone = '9999999999';
				
		insert Ctc;
		
		Opportunity O  = new Opportunity();
		O.AccountId = AcctId; //set the required fields
		O.ValidationRules__c = true;
		O.Name = 'test';
		O.Deal_Contact__c = Ctc.id;
		O.CloseDate = System.today();
		O.StageName = 'Prospect';
		O.Type = 'New Business';
		O.Salesperson__c = userinfo.getUserId();
		
		insert O; //save it to SFDC (it will rollback after your test
		
		Competition__c comp = new Competition__c();
		comp.Opportunity__c = O.Id;
		comp.Name = 'N/A';
		
		insert comp;
		
		O.Multi_Installments_Approved__c=true;
		O.StageName = 'Closed or Won';
		O.Number_of_Installments__c = '3';
		O.Implementation_Contact__c = Ctc.id;
		O.Deal_Contact__c = Ctc.id;
		O.ValidationRules__c = true;
		O.CRM_Vendor__c = 'AAX';
		O.DMS_Vendor__c = 'AAX';
		O.ILM_Vendor__c = 'AAX';
		O.Inventory_Vendor__c = 'AAX';
		O.Pricing_Vendor__c = 'AAX';
		O.Website_Vendor__c = 'AAX';
		// O.We_Owe__c = 'test';
		O.Amount = 1200;
		O.Multi_Installments_Approved__c= true;
		update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
		
		//Installments
		//Installment__c I = new Installment__c();
		//I.Opportunity__c = O.id;
		//insert I;
		
		//I.Paid__c = system.today();
		//update I;
		//delete I;
		
		Case CS = new Case();
		CS.AccountId = A.Id;
		CS.ContactId = Ctc.Id;
		CS.Origin = 'Phone';
		CS.Reason = 'Billing';
		CS.Status = 'new';
		CS.Escalate_To__c = null;
		CS.Assigned_To__c = null;
		CS.X1_What_is_happening__c = 'I don\'t know';
		CS.X2_What_did_you_expect_to_happen__c = 'I don\'t know';
		CS.X3_When_did_it_start_happening__c = 'I don\'t know';
		CS.X4_What_do_you_think_the_problem_is__c = 'I don\'t know';
		CS.X5_What_have_you_tried_so_far__c = 'I don\'t know';
		insert CS;
		
		//2012-06-01
		//ProCore commented out case runner DML for deployment of real time weighted rankings
		Case_Runner__c R2 = new Case_Runner__c();
		R2.Case__c = CS.Id;
		R2.Escalated_To__c = 'DMS';
		R2.Escalation_Type__c = 'General Questions';
		//insert R2;
 	  	
 	  	Case_Runner__c R3 = new Case_Runner__c();
		R3.Case__c = CS.Id;
 	  	R3.Escalated_To__c ='Development';
 	  	R3.Escalation_Type__c = 'General Questions'; 	  	
 	  	//insert R3;
 	  	
 	   	Case_Runner__c R5 = new Case_Runner__c();
		R5.Case__c = CS.Id;
 	   	R5.Escalated_To__c ='Level 2-Dev';
 	   	R5.Runner_Action__c ='Additional Information Needed';
 	   	//insert R5;
 	   	
 	   	Case_Runner__c R4 = new Case_Runner__c();
		R4.Case__c = CS.Id;
 	   	R4.Escalated_To__c ='DDM';
 	   	R4.Runner_Action__c ='Submitting Additional Information';
 	   	//insert R4;		   	
 	   	
 	   	Case_Runner__c Rn = new Case_Runner__c();
		Rn.Runner_Action__c = 'Resolved';
		Rn.Case__c = CS.Id;
		Rn.RecordTypeId ='012700000005eL7';
		Rn.Defect_Id__c = '1234';
		//insert Rn;    	
		
		
    }
    
    public static testmethod void MyUnitTest2()
    {
    	/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();		
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
		
		A.Type = 'Prospect';
		
		update A;
		
		Contact Ctc = new Contact();
		Ctc.AccountId = A.Id;
		Ctc.FirstName = 'test';
		Ctc.LastName = 'test';
		Ctc.Phone = '9999999999';
				
		insert Ctc;
		
		Opportunity O  = new Opportunity();
		O.AccountId = A.Id; //set the required fields
		O.Name = 'test';
		O.Deal_Contact__c = Ctc.id;
		O.CloseDate = System.today();
		O.ValidationRules__c = true;
		O.StageName = 'Prospect';
		O.Type = 'New Business';
		O.Salesperson__c = userinfo.getUserId();
		O.Implementation_Contact__c = Ctc.id;
		// O.We_Owe__c = 'test';		
		insert O; //save it to SFDC (it will rollback after your test
		O.Multi_Installments_Approved__c=true;
		O.StageName = 'Closed or Won';
		O.ValidationRules__c = true;
		
		Demo__c D = new Demo__c();
 	   	D.Opportunity__c = O.Id;
 	   	D.Name = 'test';
 	   	insert D;
 	   	
 	   	update D;
 	   	
 	   	delete D;
 	   	
 	   	SFDC_Service_Timecard__c TC = new SFDC_Service_Timecard__c();
 	   	TC.Contact__c = Ctc.Id;
 	   	TC.attendeeID__c = Ctc.Id; 
 	   	TC.OwnerId = userinfo.getUserId();
 	   	
 	   	insert TC;
 	   	
 	   	 TC.Class_Status__c = 'Completed';
        update TC;
 	   	
    }
    public static testmethod void TestBeforeDelete()
    {
    	/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
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
		
		Contact Ctc = new Contact();
		Ctc.AccountId = A.Id;
		Ctc.FirstName = 'test';
		Ctc.LastName = 'test';
		Ctc.Phone = '9999999999';
				
		insert Ctc;
		
		Opportunity O  = new Opportunity();
		O.AccountId = A.Id; //set the required fields
		O.Name = 'test';
		O.Deal_Contact__c = Ctc.id;
		O.CloseDate = System.today();
		O.ValidationRules__c = true;
		O.StageName = 'Prospect';
		O.Type = 'New Business';
		O.Salesperson__c = userinfo.getUserId();
		O.Implementation_Contact__c = Ctc.id;
		// O.We_Owe__c = 'test';		
		insert O; //save it to SFDC (it will rollback after your test
		
		Demo__c D = new Demo__c();
		D.Opportunity__c = O.Id;
		D.Name = 'Test';
		D.Webexer__c = userinfo.getUserId();
		
		insert D;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = O.Id;
		Pro.Account__c = A.Id;
		//Pro.DDM__c = userinfo.getuserId();
		insert Pro;
				
		Project_Piece__c PP4 = new Project_Piece__c();
		PP4.Project__c = Pro.Id;
		PP4.Piece_Issue__c = 'TestPiece - Sticker';
		PP4.Name = 'VinSticker';
		insert PP4;
		
		
		delete PP4;
		
		delete Pro;
		
		delete D;
		
		delete O;
		
		
	
    
    }
   /* public static TestMethod void testOppClone()
    {
    	Territory_State__c TS = new Territory_State__c();
        TS.DDM__c = userinfo.getUserId();
        TS.Name = 'TS';
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();            
        insert TS;
            
        Account A = new Account();
        A.BillingState = 'TS';
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
        A.BillingState = 'TS';
        A.BillingStreet = '1234';
        insert A;
            
        Contact C = new Contact();
        C.FirstName = 'test';
        C.LastName = 'testing';
        C.AccountId = A.Id;
        insert C;
            
            
        string opptyName = 'CRM';
            
        Opportunity O = new Opportunity();
        O.AccountId = A.Id;
        O.Name = opptyName;
        O.CloseDate = system.today();
        O.StageName = 'Prospect';
        insert O;
        
        Competition__c comp = new Competition__c();
		comp.Opportunity__c = O.Id;
		comp.Name = 'N/A';
		
		insert comp;
            

        string prodName = 'CRM';
        
        Product2 product = new Product2(
        name = prodName);   
        product.Quantity_Exception__c = true;
        product.IsTraining__c = true;
        product.ExpPaidByDealer__c = true;
        product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
        product.Description = 'website';
        product.IsPackageParent__c = true;
		product.Production_Department__c = 'creative';
		product.Production_Issue__c = 'website';
		product.ProdProj_Default_Owner__c = userinfo.getUserId();
		product.requiresWelcomePacket__c = true;
		product.Related_Product__c = null;
		product.Package_Discount_Percentage__c = .55;

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
        OLI.Quantity = 1;
        OLI.TotalPrice = 100.00;
        OLI.Override_Related_Product__c = true;
        insert OLI;
           
        O.Implementation_Contact__c = C.Id;
        O.Deal_Contact__c = C.Id;
        O.CRM_Vendor__c = 'AAX';
		O.DMS_Vendor__c = 'AAX';
		O.ILM_Vendor__c = 'AAX';
		O.Inventory_Vendor__c = 'AAX';
		O.Pricing_Vendor__c = 'AAX';
		O.Website_Vendor__c = 'AAX';
        // O.We_Owe__c = 'test';
        O.Multi_Installments_Approved__c = True;
        O.Stage_Type__c = 'Invoice Approved';
         
        update O;
        
        O.Inactive_Product_Override__c = true;
        O.Number_of_Installments__c = '1';
        O.StageName = 'Closed or Won';
        O.Override_Related_Product__c = true;
        update O;
 

        PageReference testStart = Page.Opportunity_Clone;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('id', O.Id);
	       
	    ApexPages.StandardController controller = new ApexPages.StandardController(O);
	}*/
	
	/*public static TestMethod void testPhasedImplementation()
	{
		Territory_State__c TS = new Territory_State__c();
        TS.DDM__c = userinfo.getUserId();
        TS.Name = 'TS';
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();            
        insert TS;
            
        Account A = new Account();
        A.BillingState = 'TS';
        A.Name = 'test';
        A.AccountNumber = '1234';
        A.ShippingStreet = '1234';
        A.ShippingState = 'TS';
        A.ShippingPostalCode = '66212';
        A.ShippingCountry = 'USA';
        A.ShippingCity = 'test';
        insert A;
            
        Contact C = new Contact();
        C.FirstName = 'test';
        C.LastName = 'testing';
        C.AccountId = A.Id;
        insert C;
        
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
        
        SFDC_520_Quote__c P = new SFDC_520_Quote__c();
        P.Opportunity__c = O.Id;
		P.Date_Packet_Sent__c = null;
		P.RecordTypeId = '012700000005dgP';
		P.Training_Included__c = TRUE;
		insert P;
		
		String prodName = 'Inventory Module';
		
		Product2 product = new Product2(
        name = prodName);   
        product.Quantity_Exception__c = true;
        product.IsTraining__c = true;
        product.ExpPaidByDealer__c = true;
        product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
        product.Description = 'Inventory Module';
        product.IsPackageParent__c = true;
		product.Production_Department__c = 'Implementation';
		product.Production_Issue__c = 'Inventory Module';
		product.ProdProj_Default_Owner__c = userinfo.getUserId();
		product.requiresWelcomePacket__c = true;

        insert product;
        
        product2 dataIntegrationProduct = new Product2 (
        name = 'Data Integration',
        ProdProj_Default_Owner__c = userinfo.getUserId(),                   
        Description = 'Inventory Module',
        IsPackageParent__c = true,
		Production_Department__c = 'Implementation',
		Production_Issue__c = 'Inventory Module',
		requiresWelcomePacket__c = true);
		
		insert dataIntegrationProduct;
        
            
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
        		
		Project_Piece__c PP1 = new Project_Piece__c();
		PP1.Project__c = P.Name;
		PP1.Name = 'Inventory Module';
		PP1.Product_Name__c = product.Name;
		PP1.Product_Process__c = pProc.Name;
		PP1.Piece_Issue__c = 'Inventory Module';
		insert PP1;
		
		
		PP1.Milestone_1_Completed__c = system.today();
		update PP1;
		
		PP1.Milestone_2_Completed__c = system.today();
		update PP1;
		
		
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
				
		for (integer i = 1; i>=10; i++)
		{
			Product_Process__c newProcess = new Product_Process__c();
			Project_Piece__c newPP = new Project_Piece__c();
			newProcess.Product__c = dataIntegrationProduct.Id;
			if (i>=1)
			{
				newProcess.Milestone_1_Stage__c = 'Configuration';				
				if (i==1)
				{
					newProcess.Milestone_1__c = 'Connection Made';
					newPP.Product_Process__c = newProcess.Name;
				}
				else 
				{
					newProcess.Milestone_1__c = 'Configuration';
				}
			}
			newProcess.Product__c = dataIntegrationProduct.Id;
			if (i>=2)
			{
				newProcess.Milestone_2_Stage__c = 'Configuration';				
				if (i==2)
				{
					newProcess.Milestone_2__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_2__c = 'Configuration';
				}
			}
			if (i>=3)
			{
				newProcess.Milestone_3_Stage__c = 'Configuration';				
				if (i==3)
				{
					newProcess.Milestone_3__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_3__c = 'Configuration';
				}
			}
			if (i>=4)
			{
				newProcess.Milestone_4_Stage__c = 'Configuration';				
				if (i==4)
				{
					newProcess.Milestone_4__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_4__c = 'Configuration';
				}
			}
			if (i>=5)
			{
				newProcess.Milestone_5_Stage__c = 'Configuration';				
				if (i==5)
				{
					newProcess.Milestone_5__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_5__c = 'Configuration';
				}
			}	
			if (i>=6)
			{
				newProcess.Milestone_6_Stage__c = 'Configuration';				
				if (i==6)
				{
					newProcess.Milestone_6__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_6__c = 'Configuration';
				}
			}
			if (i>=7)
			{
				newProcess.Milestone_7_Stage__c = 'Configuration';				
				if (i==7)
				{
					newProcess.Milestone_7__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_7__c = 'Configuration';
				}
			}
			if (i>=8)
			{
				newProcess.Milestone_8_Stage__c = 'Configuration';				
				if (i==8)
				{
					newProcess.Milestone_8__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_8__c = 'Configuration';
				}
			}	
			if (i>=9)
			{
				newProcess.Milestone_9_Stage__c = 'Configuration';				
				if (i==9)
				{
					newProcess.Milestone_9__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_9__c = 'Configuration';
				}
			}	
			if (i>=10)
			{
				newProcess.Milestone_10_Stage__c = 'Configuration';				
				if (i==10)
				{
					newProcess.Milestone_10__c = 'Connection Made';
				}
				else 
				{
					newProcess.Milestone_10__c = 'Configuration';
				}
				newPP.Product_Process__c = newProcess.Name;
				tenPieces.add(newPP);
				tenProcesses.add(newProcess);
			}
		}
		insert tenProcesses;
		insert tenPieces;
				
	} */
	
	
    
}