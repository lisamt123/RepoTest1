@isTest(SeeAllData=True)
private class OpportunityClass_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        
        
        }
    }
    
    public static TestMethod void testInvoiceInformation()
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
        A.BillingState = 'TS';
        A.BillingCity = 'Test City';
        A.BillingStreet = '123 Test'; 
        A.BillingPostalCode = '12345'; 
        A.BillingCountry = 'USA';
        A.ShippingStreet = '123 Test';
        A.ShippingState = 'KS';
        A.ShippingPostalCode = '12345';
        A.ShippingCountry = 'USA';
        A.ShippingCity = 'Test City';
        A.Name = 'test';
        A.VS_Dealer_ID__c = 1234;
        A.AccountNumber = '1234';
        try{
        insert A;
        } catch(Exception e){
        
        }
        Contact C = new Contact();
        C.FirstName = 'Testfirst';
        C.LastName = 'Testlast';
        C.Account = A;
        try{
        insert C;
        } catch(DmlException e) {
        	
        	
        	
        }
        Opportunity O = new Opportunity();
        O.AccountId = A.Id;
        O.Name = 'test';
        O.CloseDate = system.today();
        O.Deal_Contact__c = C.Id;
        O.StageName = 'Prospect';
        O.Implementation_Contact__c = C.id;
        //O.We_Owe__c = 'test we owe';
        O.Number_of_Installments__c = '1';
        O.Amount = 1000;
        
        insert O;
        
        Product2 product = [select Id, Related_Product__c, isActive from Product2 where isActive = true AND (Related_Product__c = null OR Related_Product__c = '') limit 1];            
        

        PricebookEntry PBE = [select id, Product2Id, Pricebook2Id, IsActive, UnitPrice, UseStandardPrice from PricebookEntry where IsActive = true AND Product2Id =: product.Id limit 1];
        
        
                
    
                
        OpportunityLineItem OLI = new OpportunityLineItem();
        OLI.PricebookEntryId = PBE.Id;
        OLI.Quantity = 1;       
        OLI.ActualDescription__c = 'website';
        OLI.OpportunityId = O.id;       
        OLI.TotalPrice = 1000.00;       
        insert OLI;
        
        Test.startTest();
        OLI.Override_Related_Product__c = true;
        update OLI;
        
        O.StageName = 'Closed or Won';
        O.Inactive_Product_Override__c = true;
       
		try {       
        update O;
		} Catch(Exception e) {
			
		}
        //OpportunityClass.GenerateInstallments(O);
        //OpportunityClass.UpdateInvoiceInformation(O);
        
        O.Multi_Installments_Approved__c = true;
        O.Number_of_Installments__c = '2';
        O.Invoice_Generated__c = false;
        
        try{
        update O;}
        catch(Exception e){
        	
        	
        }
        
        O.StageName = 'Prospect';
        try{
        update O;
        } catch(Exception e) {
        	
        	
        }
        
        O.StageName = 'Closed or Won';
        try {
        update O; 
        }catch(DmlException e) {
        	
        }
        
        //OpportunityClass.UpdateInstallments(O);                 
        //OpportunityClass.UpdateInvoiceInformation(O);
        test.stopTest();
    }
}