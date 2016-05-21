@isTest
public with sharing class OpportunityProductClass 
{
	/*
	public static testmethod void TestOpptyLineItems()
	{
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
		
		A.Type = 'Prospect';
		
		update A;
		
		string AcctId = A.Id;
		
		Contact Ctc = new Contact();
		Ctc.AccountId = A.Id;
		Ctc.FirstName = 'test';
		Ctc.LastName = 'test';
				
		insert Ctc;
		Opportunity O  = new Opportunity();
		O.AccountId = AcctId; //set the required fields
		O.Name = 'test';
		O.Deal_Contact__c = Ctc.id;
		O.CloseDate = System.today();
		O.StageName = 'Prospect';
		O.Type = 'New Business';
		O.Salesperson__c = userinfo.getUserId();
		O.Implementation_Contact__c = Ctc.id;
		O.We_Owe__c = 'N/A'; 
		
		insert O; //save it to SFDC (it will rollback after your test
		
		/*
		Product2 PT2 = new Product2();
		PT2.Description = 'test';
		PT2.Name = 'test';
		PT2.Family = 'setup';
		PT2.IsActive = true;		
		Insert PT2;
		
		Pricebook2 PB2 = new Pricebook2();
		PB2.Name = 'test';
		PB2.IsActive = true;
		PB2.Description = 'test';			
		insert PB2;		
		 *//*
		PricebookEntry PBE = [select id, Product2Id, Pricebook2Id, IsActive, UnitPrice, UseStandardPrice from PricebookEntry where IsActive = true limit 1];
				
		OpportunityLineItem OLI = new OpportunityLineItem();
		OLI.PricebookEntryId = PBE.Id;
		OLI.Quantity = 1;		
		OLI.ActualDescription__c = 'website';
		OLI.OpportunityId = O.id;		
		OLI.TotalPrice = 10.00;
		insert OLI;
	}
	*/
}