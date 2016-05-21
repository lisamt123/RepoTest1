@isTest(SeeAllData=True)
private class UpdateCaseStage_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	//Set your controller
        	UpdateCaseStage controller = new UpdateCaseStage();
        	
        	test.startTest();
        	
        	
        	
        	test.stopTest();
        }
    }
    
    
    public static testmethod void testUpdateCaseStage()
	{
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
		
		Contact newContact = new Contact();
		newContact.AccountId = A.Id;
		newContact.LastName = 'test';
		newContact.FirstName = 'firstname';
		newContact.Phone = '9999999999';
		insert newContact;
		
		Case C = new Case();
		
		C.AccountId = A.Id;
		C.Contact = newContact;
		C.Origin = 'Phone';
		C.Reason = 'Billing';
		C.X1_What_is_happening__c = 'TEST TEST TEST TEST TEST';
		C.X2_What_did_you_expect_to_happen__c = 'TEST TEST TEST TEST TEST';
		C.X3_When_did_it_start_happening__c = 'TEST TEST TEST TEST TEST';
		C.X4_What_do_you_think_the_problem_is__c = 'TEST TEST TEST TEST TEST';
		C.X5_What_have_you_tried_so_far__c = 'TEST TEST TEST TEST TEST';
		C.Third_Party__c = A.Id;
		insert C;
		
		Case_Runner__c CR = new Case_Runner__c();
		CR.Case__c = C.Id;
		CR.Escalated_To__c = 'Client Issues';
		CR.Escalation_Type__c = 'General Questions';
		Cr.Runner_Action__c = 'Comment';
		
		insert CR;
		
		CR.Escalated_To__c = 'DMS';
		update CR;
		//Cr.Escalated_To__c = 'Development';
		//update CR;
		//CR.Escalated_To__c = 'DDM';
		
		Case_Runner__c CR2 = new Case_Runner__c();
		CR2.Case__c = C.Id;
		CR.Runner_Action__c = 'Assign';
		CR.Assigned_To__c = userinfo.getUserId();
		insert CR2;		
		
		Case_Runner__c CR3 = new Case_Runner__c();
		CR3.Case__c = C.Id;
		CR3.Runner_Action__c = 'Resolved';
		CR3.Defect_Id__c = 'TEST';
		CR3.Feature_Request_Id__c = 'TEST';
		insert CR3;
		
		Case_Runner__c CR4 = new Case_Runner__c();
		CR4.Case__c = C.Id;
		CR4.Runner_Action__c = 'Unresolved';
		insert CR4;
		
		/*
		Case_Runner__c CR5 = new Case_Runner__c();
		CR5.Case__c = C.Id;
		CR5.Runner_Action__c = 'NMP';
		insert CR5;
		*/
		
		Case_Runner__c CR6 = new Case_Runner__c();
		CR6.Case__c = C.Id;
		CR6.Runner_Action__c = 'Escalate';
		CR6.Escalated_To__c = 'Exports';
		//insert CR6;
	}
	
	public static testmethod void testUpdateCaseStage2()
	{
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
		
		Contact newContact = new Contact();
		newContact.AccountId = A.Id;
		newContact.LastName = 'test';
		newContact.FirstName = 'firstname';
		newContact.Phone = '9999999999';
		insert newContact;
		
		Case C = new Case();
		
		C.AccountId = A.Id;
		C.Contact = newContact;
		C.Origin = 'Phone';
		C.Reason = 'Billing';
		C.X1_What_is_happening__c = 'TEST TEST TEST TEST TEST';
		C.X2_What_did_you_expect_to_happen__c = 'TEST TEST TEST TEST TEST';
		C.X3_When_did_it_start_happening__c = 'TEST TEST TEST TEST TEST';
		C.X4_What_do_you_think_the_problem_is__c = 'TEST TEST TEST TEST TEST';
		C.X5_What_have_you_tried_so_far__c = 'TEST TEST TEST TEST TEST';
		C.Third_Party__c = A.Id;
		insert C;
		
		Case_Runner__c CR = new Case_Runner__c();
		CR.Case__c = C.Id;
		CR.Escalated_To__c = 'Client Issues';
		CR.Escalation_Type__c = 'General Questions';
		Cr.Runner_Action__c = 'Issue Rejected';
		insert CR;
		
		CR.Escalated_To__c = 'DMS';
		update CR;
		//Cr.Escalated_To__c = 'Development';
		//update CR;
		CR.Escalated_To__c = 'DDM';
		
		
		//Procore - adding list to handle bulk dml 
		List<Case_Runner__c> insertCaseRunners = new List<Case_Runner__c>();
		
		Case_Runner__c CR7 = new Case_Runner__c();
		CR7.Case__c = C.Id;
		CR7.Runner_Action__c = 'Escalate';
		//CR7.Escalated_To__c = 'DDM';
		CR7.Escalated_To__c = 'Level 3 Support';
		//insert CR7;
		insertCaseRunners.add(CR7);
		
		Case_Runner__c CR8 = new Case_Runner__c();
		CR8.Case__c = C.Id;
		CR8.Runner_Action__c = 'Issue Rejected';
		CR8.Escalated_To__c = 'L2';
		//insert CR8;
		//insertCaseRunners.add(CR8);
		
		Case_Runner__c CR9 = new Case_Runner__c();
		CR9.Case__c = C.Id;
		CR9.Runner_Action__c = 'Additional Information Needed';
		//insert CR9;
		//insertCaseRunners.add(CR9);
		
		Case_Runner__c CR10 = new Case_Runner__c();
		CR10.Case__c = C.Id;
		CR10.Runner_Action__c = 'Submitting Additional Information';
		//insert CR10;
		//insertCaseRunners.add(CR10);
		
		Case_Runner__c CR11 = new Case_Runner__c();
		CR11.Case__c = C.Id;
		CR11.Runner_Action__c = 'Issue Rejected';
		//insert CR11;
		//insertCaseRunners.add(CR11);
		
		Case_Runner__c CR12 = new Case_Runner__c();
		CR12.Case__c = C.Id;
		CR12.Runner_Action__c = 'Resolved';
		CR12.RecordTypeId = '012700000005eL7';
		CR12.Case_Description__c = 'TEST';
		CR12.Defect_Id__c = 'TEST';
		CR12.Assigned_To__c = Userinfo.getUserId();
		//insert CR12;
		//insertCaseRunners.add(CR12);
		
		insert insertCaseRunners;
		
	}
	
}