@isTest(SeeAllData=True)
private class ProjectClasses_test {

    static testMethod void myUnitTest() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	/*Account testAccount = [SELECT Id, Implementation_Date__c FROM Account LIMIT 1];
        	
        	testAccount.Implementation_Date__c = null;
        	update testAccount;
        	
        	
        	
        	Territory_State__c TS = new Territory_State__c();
	  		TS.Name = 'XX';
			TS.Account_Manager__c = userinfo.getUserId();
			TS.DDM__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
	        TS.Implementation_Specialist__c = userinfo.getUserId();		
			insert TS;
	  		
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
	        A.BillingState = 'TS';
	        A.BillingStreet = '1234';
			
			A.name = 'TestAccount';
							
			insert A;
			
			
			Contact Ctc = new Contact();
			Ctc.AccountId = A.Id;
			Ctc.FirstName = 'test';
			Ctc.LastName = 'test';
				
			insert Ctc;*/
			UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
	        String acctId = testId.UnitTestAccountId__c;
			String rtId = testId.UnitTestOppRecordTypeId__c;
			String conId = testId.UnitTestContactId__c;
			String pbeId = testId.UnitTestPBEid__c;
			String pbId = testId.UnitTestPriceBookId__c;
			String prod2 = testId.UnitTestProduct2Id__c;
			String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
			
			/*Opportunity O  = new Opportunity();
			O.AccountId = acctId; //set the required fields 
			O.Name = 'test';
			O.Deal_Contact__c = conId;
			O.CloseDate = System.today();
			O.StageName = 'Prospect';
			O.Type = 'New Business';
			O.Salesperson__c = userinfo.getUserId();
			O.Implementation_Contact__c = conId;
			//O.We_Owe__c = 'N/A'; 
			
			insert O; //save it to SFDC (it will rollback after your test*/
			Opportunity o = new Opportunity();
			o.AccountId = acctId;
			o.RecordTypeId = rtId;
			o.Name = 'TEST Custom Settings';
			o.Type = 'New Business';
			o.StageName = 'Prospect';
			o.CloseDate = system.today();
			o.Salesperson__c = userinfo.getUserId();
			o.Project_Exception__c = false;
			o.Discount_Approval_Status__c = 'Approved';
			o.Deal_Contact__c = conId;
			
			insert o;
			
			//Project
			SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
			prj.Opportunity__c = o.Id;
			prj.Date_Packet_Sent__c = null;
			prj.RecordTypeId = '012700000005dgP';
			prj.Training_Included__c = TRUE;		
			
			insert prj;
			
			
			Project_Piece__c PP = new Project_Piece__c();
			PP.Project__c = prj.Id;
			PP.Piece_Issue__c = 'TestPiece - Sticker';
			PP.Name = 'VinSticker';
			PP.Project_Piece_Stage__c = 'Introduction';
			insert PP;
        	
        	
        	//Set your controller
        	ProjectClasses controller = new ProjectClasses();
        	
        	test.startTest();
        	
        	ProjectClasses.updateImplementationDate(acctId);
        	
        	ProjectClasses.updateCancelledProjectPieces(prj);
        	
        	test.stopTest();
        //}
    }
    
    
    
    public static testMethod void TestProject() {
    	
        /*Territory_State__c TS = new Territory_State__c();
        TS.Name = 'TS';
        TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();        
        insert TS;*/
        
        Account A = new Account();
        A.Name = 'test';
        A.BillingCity = 'test';
        A.BillingCountry = 'USA';
        A.BillingPostalCode = '66212';
        A.BillingState = 'KS'; 
        A.BillingStreet = '1234';
        A.ShippingCity = 'test';
        A.ShippingCountry = 'USA';
        A.ShippingPostalCode = '66212';
        A.ShippingState = 'KS'; 
        A.ShippingStreet = '1234';
        
        insert A;

        Opportunity O = new Opportunity();
        O.AccountId = A.Id;
        O.Type = 'New Business';
        O.Name = 'test';
        O.CloseDate = System.today();
        O.StageName = 'Prospect';
        
        insert O;

        SFDC_520_Quote__c Proj = new SFDC_520_Quote__c();
        Proj.Opportunity__c = O.Id;
        Proj.RecordTypeId = '012700000005dgP';
        insert Proj;
        
        Project_Piece__c PP2 = new Project_Piece__c();
        PP2.OwnerId = userinfo.getUserId();
        PP2.Piece_Issue__c = 'test';
        PP2.Name = 'test';
        PP2.RecordTypeId = '012700000005e2z' ;
        PP2.Project__c = proj.Id;
        PP2.Requirements_Gathered__c = null;
        PP2.Contact_Made__c = null;
        PP2.Design_Completed__c = null;
        PP2.Proof_Approved__c = null;
        PP2.Uploaded_Printed_Shipped__c =null;
        PP2.Project_Piece_Stage__c = 'Requirement Gathering';
        //insert PP2;
        
        Project_Piece__c PP = new Project_Piece__c();
        PP.OwnerId = userinfo.getUserId();
        PP.Piece_Issue__c = 'test';
        PP.Name = 'test';
        PP.RecordTypeId = '012700000005e2z' ;
        PP.Project__c = proj.Id;
        PP.Requirements_Gathered__c = null;
        PP.Contact_Made__c = null;
        PP.Design_Completed__c = null;
        PP.Proof_Approved__c = null;
        PP.Uploaded_Printed_Shipped__c =null;
        PP.Project_Piece_Stage__c = 'Requirement Gathering';
        //insert PP;
         
               
        Task t = new Task();
        t.WhatId = Proj.Id;
        t.Subject = 'Send Packet';
        t.Status = 'Not Started';
        t.Type = 'Task';
        insert t;
        
        Task t2 = new Task();
        t2.WhatId = Proj.Id;
        t2.Subject = 'WFT-Intro Call/Intro Email/Send Packet';
        t2.Status = 'Not Started';
        t2.Type = 'Task';
        insert t2;
        
        Proj.Date_Packet_Sent__c = system.today();
        
        update Proj;   
        
        proj.Date_Graphics_Obtained__c = system.today();
        
        update proj;
        
        proj.Date_Packet_Ret_d__c = system.today();
        update proj;
        
        
        
    }
}