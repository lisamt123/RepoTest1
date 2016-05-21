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
@isTest
private class handler_billingItemUpdateBillType_test {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        UserRole role = [SELECT Id From UserRole WHERE Name = 'Director of Sales'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com',
        	UserRoleId = role.Id);
        	
        insert u_testMethodUser;
        
        //UserRoleId
        
        System.runas(u_testMethodUser) {*/
        	
        	
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
							
			insert A;
			
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
			//O.RecordTypeId = '012S00000008rGjIAI';   //generalsales//01270000000Q7t7  //t1/t2//01270000000Q9Me
			O.RecordTypeId = '01270000000Q7t7';
			//O.Initial_Load__c = 5; 
			O.TryCatchTest__c = true;
			insert O;

			
			Contract ctr = new Contract();
			ctr.AccountId = A.Id;
			ctr.RecordTypeId = '01270000000Q9vW';
			insert ctr;
					
			Billing_Item__c bi1 = new Billing_Item__c(Contract__c = ctr.Id,Product_Sold__c = '01t70000004ZFKw');
			//bi1.Contract__c = ctr.Id;
			//bi1.Product_Sold__c = '01t70000004ZFKw'; //Other
			insert bi1;
			
			Billing_Item__c bi5 = new Billing_Item__c(Contract__c = ctr.Id,Product_Sold__c ='01t70000004ZJVT');
			//bi5.Contract__r.AccountId  = A.Id;
			//bi5.Product_Sold__c = '01t70000004ZJVT'; //Inventory
			//bi5.Contract__r = ctr;
			insert bi5;			
						
			Billing_Item__c bi4 = new Billing_Item__c(Contract__c = ctr.Id,Product_Sold__c ='01t70000004ZFMy');
			//bi4.Contract__r = ctr;			
			//bi4.Product_Sold__c = '01t70000004ZFMy'; //website
			insert bi4;		

			Billing_Item__c bi3 = new Billing_Item__c(Contract__c = ctr.Id,Product_Sold__c ='01t70000004ZFL1');
			//bi3.Contract__r = ctr;						
			//bi3.Product_Sold__c = '01t70000004ZFL1'; //ILM
			insert bi3;			
						
			//Billing_Item__c bi2 = new Billing_Item__c(Contract__c = ctr.Id,Product_Sold__c ='01t70000004ZFJp');
			//bi2.Contract__r = ctr;						
			bi3.Product_Sold__c = '01t70000004ZFJp'; //CRM
			update bi3;
			
			
			
			test.startTest();
        	handler_updateContractCancel.updateRelatedBillingItemsCancel(new List<Contract> { ctr });        	
        	test.stopTest();
        //}        
    }
}