@isTest
private class pdfInvoiceSave_test {

    static testMethod void myUnitTest() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
            
            //Set your controller
            /*Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
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
            
            //update A;
            string AcctId = A.Id;
            
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
            O.StageName = 'Prospect';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            O.Implementation_Contact__c = Ctc.id;
            //O.We_Owe__c = 'N/A'; 
            
            insert O;
            
            
            test.startTest();
            
            ApexPages.currentPage().getParameters().put('id', O.Id);
            
            pdfInvoiceSave controller = new pdfInvoiceSave();
            
            controller.getPdfName();
            controller.savePdf();
                      
            
            test.stopTest();
        //}
    }
}