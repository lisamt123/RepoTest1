@isTest(SeeAllData=True)
private class handler_updateUsersRelatedProjects_test {

    static testMethod void myUnitTest() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com', Team_Name__c = 'Test Name');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
        	
        	//Set your controller
        	handler_updateUsersRelatedProjects controller = new handler_updateUsersRelatedProjects();
        	
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
			O.ValidationRules__c = true;
			O.StageName = 'Prospect';
			O.Type = 'New Business';
			O.Salesperson__c = userinfo.getUserId();
			O.Implementation_Contact__c = Ctc.id;
			//O.We_Owe__c = 'N/A'; 
			
			insert O; //save it to SFDC (it will rollback after your test
			
			Competition__c comp = new Competition__c();
			comp.Opportunity__c = O.Id;
			comp.Name = 'N/A';
			
			insert comp;
			
			O.Multi_Installments_Approved__c=true;
			O.StageName = 'Closed or Won';
			O.Number_of_Installments__c = '3';
			O.ValidationRules__c = true;
			O.Amount= 1200;
			O.CRM_Vendor__c = 'AAX';
			O.DMS_Vendor__c = 'AAX';
			O.ILM_Vendor__c = 'AAX';
			O.Inventory_Vendor__c = 'AAX';
			O.Pricing_Vendor__c = 'AAX';
			O.Website_Vendor__c = 'AAX';
			update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
			O.Amount = 1500;
			OpportunityClass.UpdateInvoiceInformation(O);
			update O;
			
			//Project
			SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
			prj.Opportunity__c = O.Id;
			prj.Date_Packet_Sent__c = null;
			prj.RecordTypeId = '012700000005dgP';
			prj.Training_Included__c = TRUE;		
			
			insert prj;
        	
        	
        	
        	
        	//u_testMethodUser.Team_Name__c = 'Name Name';
        	//update u_testMethodUser;
        	
        	
        	
        	
        	//test.startTest();
        	
        	//test.stopTest();
        //}
    }
}