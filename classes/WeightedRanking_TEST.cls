@isTest
private class WeightedRanking_TEST {

    static testMethod void WeightedRanking_TestMethod() {
        // TO DO: implement unit test
     		
     		
     		/*Territory_State__c TS = new Territory_State__c();
	  		TS.Name = 'XX';
			TS.Account_Manager__c = userinfo.getUserId();
			TS.DDM__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
	        TS.Implementation_Specialist__c = userinfo.getUserId();	
	        TS.Website_Manager__c = userInfo.getUserId();	
			insert TS;*/
     		
     		Account a = new Account();
        	a.ShippingCity = 'test';
        	a.shippingStreet = 'test';
        	a.ShippingState = 'KS';
        	a.ShippingPostalCode = '12345';
        	a.BillingState = 'KS';
        	a.AccountNumber = '1';
        	a.BillingCity = 'test';
        	a.BillingCountry = 'USA';
        	a.BillingPostalCode = '12345';
        	a.BillingState = 'KS';
        	a.BillingStreet = '1234';
        	a.Flag_for_Heat__c = true;
        	a.Implementation_Date__c = system.today() - 30;
        	a.Special_Account_Status__c = 'DAB Heat';
        	a.Heat_Notes__c = 'Test notes here';
        	a.name = 'Test Account';
        	a.Type = 'Prospect';
        	//a.Territory_State__c = TS.Id;
        	//a.Special_Account_Status__c = 'DAB Hest';
        	
        	insert a;
        	string aid = a.Id;
        	
        	Contact ct = new Contact();
        	ct.AccountId = a.Id;
        	ct.FirstName = 'test';
        	ct.LastName = 'test';
        	ct.Phone = '9999999999';
        	
        	insert ct;
        	
        	Case c = new Case();
        
        	c.AccountId = a.Id;
        	c.ContactId = ct.Id;
        	c.Origin = 'Phone';
        	c.Reason = 'Lead Issue'; 
        	c.Status = 'new';
        	c.Priority = '3 - Cold (Fix in the future)';
        	c.Has_Been_Flagged_Manager__c = true;
        	c.Has_Been_Flagged__c = true;
        	c.Super_Priority__c = '1 - Hot';
        	c.Force_High__c = true;
        	
        	
        	insert c;
        	
        	Case c2 = new Case();
        
        	c2.AccountId = a.Id;
        	c2.ContactId = ct.Id;
        	c2.Origin = 'Phone';
        	c2.Reason = 'Lead Issue';
        	c2.Status = 'new';
        	c2.Priority = '3 - Cold (Fix in the future)';
        	c2.Has_Been_Flagged_Manager__c = true;
        	c2.Has_Been_Flagged__c = true;
        	c2.parentId = c.Id;
        	c2.Super_Priority__c = '1 - Hot';
        	c2.Force_High__c = true;
        	insert c2;
        	
        	WeightedRanking wr = new WeightedRanking();
        	wr.CalculateParentRanking(new Set<Id>{c.Id});
        	wr.CalculateChildRanking(new Set<Id>{c2.Id});
        	
    }
  
}