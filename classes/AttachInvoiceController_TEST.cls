/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seeAllData=true)
private class AttachInvoiceController_TEST {

  public static testmethod void testInvoicesingle(){
  		
  	 /*Account A = new Account();
  	 
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
		
	Opportunity O = new Opportunity();
		O.AccountId = A.Id;
		O.Name = 'TEST Attachment';
		O.StageName = 'Prospect';
		O.Type = 'New Business';
		O.CloseDate = system.Today();
		
		insert O;
		
	PageReference pref = Page.AttachInvoice;
	pref.getParameters().put('id', O.id);
	Test.setCurrentPage(pref);
	
	
	
	//body = Blob.valueOf('TEST TEXT');
	ApexPages.StandardController cont = new ApexPages.Standardcontroller(O);
	
	AttachInvoiceController aic = new AttachInvoiceController(cont);
	
	Test.startTest();
	
	
	
	pref = aic.attachInvoice();
	
	test.stopTest();*/
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
		o.Name = 'TEST Custom Settings';
		o.Type = 'New Business';
		o.StageName = 'Prospect';
		o.CloseDate = system.today();
		o.Salesperson__c = userinfo.getUserId();
		o.Project_Exception__c = false;
		o.Discount_Approval_Status__c = 'Approved';
		o.Deal_Contact__c = conId;
		o.ValidationRules__c = true;
		
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
	    
	   	//Installment__c i = new Installment__c();
	   	//i.Opportunity__c = o.Id;
	   	//i.Paid__c = system.today();
	   	//i.Confirmed__c = true;
	   	
	   	//insert i;
	    
	    PageReference pref = Page.AttachInvoice;
		pref.getParameters().put('id', o.id);
		Test.setCurrentPage(pref);
		
		//body = Blob.valueOf('TEST TEXT');
		ApexPages.StandardController cont = new ApexPages.Standardcontroller(o);	
		AttachInvoiceController aic = new AttachInvoiceController(cont);
		
	    test.startTest();
	 		pref = aic.attachInvoice();
	    test.stopTest(); 
		
  }
}