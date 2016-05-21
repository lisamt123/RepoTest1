@isTest
private class Inst_TEST {

	public String acctId {get; set;}

    static testMethod void usingCustomSettingsTest1() {
        
    	Account testAcct = TestData.setupAccount();
    	Contact testContact = TestData.setupContact();
    	insert testAcct;
    	insert testContact;
    	Opportunity testOppty = TestData.setupOpportunity(testAcct, testContact);
    	insert testOppty;
    	PricebookEntry testPBE = TestData.setupPricebookEntry();
    	insert testPBE;
    	OpportunityLineItem testOLI = TestData.setupOpportunityLineItem(testPBE, testOppty);
    	insert testOLI;
    	SFDC_520_Quote__c testProject = TestData.setupProject(testOppty);
    	insert testProject;
    	/*
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'CRM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    */
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    /*
    static testMethod void usingCustomSettingsTest2() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings ILM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Hardware';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest3() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings Inventory';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Add On';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest4() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Advanced Inventory with MPT';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest5() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'ILM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest6() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Digital Marketing Package';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest7() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Fulfillment';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest8() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Training';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest9() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Website - Kore 360';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest10() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Printed Materials';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest11() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Fulfillment Coop';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest12() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'OEM Website';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest13() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Product Swap';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTest14() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Haystak DM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeId;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }*/
    
    /*static testMethod void usingCustomSettingsTest15() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtId;
		o.Name = 'CRMaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'ILM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdWeb;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Web - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }*/
    
    /*static testMethod void usingCustomSettingsTestT1T2() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'CRMaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'ILM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.T1T2__c = true;
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		//o.Project_Generated__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Web - WAS';
	    
	    //insert prj;
	    
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	   	o.RecordTypeId = rtIdT1T2;
	   	update o;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }*//*
    static testMethod void usingCustomSettingsTestT1T2_2() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'CRM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_3() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings ILM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Hardware';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_4() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings Inventory';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Add On';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_5() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Advanced Inventory with MPT';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_6() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'ILM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_7() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Digital Marketing Package';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_8() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Fulfillment';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_9() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Training';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_10() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Website - Kore 360';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_11() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Printed Materials';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_12() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Fulfillment Coop';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_13() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'OEM Website';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_14() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Product Swap';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_15() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'TEST Custom Settings CRM';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'Haystak DM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdT1T2;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Imp - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }
    
    static testMethod void usingCustomSettingsTestT1T2_16() {
        
        UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        String acctId = testId.UnitTestAccountId__c;
		String rtId = testId.UnitTestOppRecordTypeId__c;
		String conId = testId.UnitTestContactId__c;
		String pbeId = testId.UnitTestPBEid__c;
		String pbId = testId.UnitTestPriceBookId__c;
		String prod2 = testId.UnitTestProduct2Id__c;
		String projRtIdImp = testId.UnitTestProjectRecordTypeImp__c;
		String prod2Web = testId.UnitTestProduct2IdWeb__c;
		String pbeIdWeb = testId.UnitTestPBEidWeb__c;
		String pbeIdT1T2 = testId.UnitTestPBEidT1T2__c;
		String prod2T1T2 = testId.UnitTestProduct2IdT1T2__c;
		String pbIdT1T2 = testId.UnitTestPriceBookIdT1T2__c;
		String rtIdT1T2 = testId.UnitTestOpportunityRecordTypeIDT1T2__c;
		
		Opportunity o = new Opportunity();
		o.AccountId = acctId;
		o.RecordTypeId = rtIdT1T2;
		o.Name = 'CRMaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
		o.Type = 'New Business';
		o.Opportunity_Names__c = 'ILM';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = true;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		
		insert o;
	    
	    OpportunityLineItem oli = new OpportunityLineItem();
	    oli.PricebookEntryId = pbeIdWeb;
	    oli.OpportunityId = o.Id;
	    oli.Quantity = 1;
	    oli.TotalPrice = 0.00;
	    
	    insert oli; 
	        
	    o.Stage_Type__c = 'Closed or Won';
	    o.Number_of_Installments__c = '1';
	    o.Implementation_Contact__c = conId;
	    o.CRM_Vendor__c = 'AAX';
	    o.DMS_Vendor__c = 'AAX';
	    o.ILM_Vendor__c = 'AAX';
	    o.Inventory_Vendor__c = 'AAX';
	    o.Pricing_Vendor__c = 'AAX';
	    o.Website_Vendor__c = 'AAX';
	    
	    SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
	    prj.Opportunity__c = o.Id;
	    prj.Date_Packet_Sent__c = null;
	    prj.RecordTypeId = projRtIdImp;
	    prj.Training_Included__c = true;
	    prj.Project_Worth__c = 1000;
	    prj.Name = 'Web - WAS';
	    
	    insert prj;
	    
	    update o;
	    
	   	Installment__c i = new Installment__c();
	   	i.Opportunity__c = o.Id;
	   	i.Paid__c = system.today();
	   	i.Confirmed__c = true;
	   	
	   	insert i;
	    
	    test.startTest();
	    
	    test.stopTest(); 
        
    }*/
}