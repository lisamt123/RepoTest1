@isTest(SeeAllData=True)
private class Installment_TEST {
    
    
   static testMethod void myUnitTest1() {
        
       /* Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            
            
            //A.Type = 'Prospect';
            
            //update A;
                       
            
            Contact Ctc = new Contact();
            Ctc.AccountId = A.Id;
            Ctc.FirstName = 'test';
            Ctc.LastName = 'test';
                    
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
            
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   //generalsales//01270000000Q7t7  //t1/t2//01270000000Q9Me
            O.RecordTypeId = '01270000000Q7t7';
            //O.Initial_Load__c = 5; 
            O.TryCatchTest__c = true;
            O.Project_Exception__c = true; //added for code coverage
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; 
            
            Competition__c comp = new Competition__c();
            comp.Opportunity__c = O.Id;
            comp.Name = 'N/A';
            
            insert comp;
            
            string prodName = 'CRM';
        
            Product2 p = new Product2();
            p.Name = 'Email Banner';
            p.Quantity_Exception__c = false;
            p.IsTraining__c = false;
            p.ExpPaidByDealer__c = true;
            p.ProdProj_Default_Owner__c = userinfo.getUserId();
            p.Description = 'Email Banner';
            p.IsPackageParent__c = false;
            p.Production_Department__c = 'creative';
            p.Production_Issue__c = 'email Banner';
            p.requiresWelcomePacket__c = false;
            p.Family = 'Reoccuring';
            p.Package_Discount_Percentage__c = .55;
    
            insert p;
            
            
                
            Pricebook2 PB = [select Id from Pricebook2 where Name = 'Standard Price Book' limit 1];     
                
            PricebookEntry PBE = new PricebookEntry();
            //PBE.Name = 'Inventory Light';
            PBE.UnitPrice = 100.00;
            PBE.Pricebook2Id = PB.Id;
            PBE.Product2Id = p.Id;
            PBE.IsActive = true;   
            
            insert PBE;
            
            
            OpportunityLineItem OLI = new OpportunityLineItem();
            OLI.PricebookEntryId = PBE.Id;
            OLI.OpportunityId = O.Id;
            OLI.Quantity = 1;
            OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            insert OLI;
        
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '1';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.CRM_Vendor__c = 'AAX';
            O.DMS_Vendor__c = 'AAX';
            O.ILM_Vendor__c = 'AAX';
            O.Inventory_Vendor__c = 'AAX';
            O.Pricing_Vendor__c = 'AAX';
            O.Website_Vendor__c = 'AAX';
            // O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; 
            
          //Project inserted for code coverage
          SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
          prj.Opportunity__c = O.Id;
          prj.Date_Packet_Sent__c = null;
          prj.RecordTypeId = '012700000005dgP';
          prj.Training_Included__c = TRUE;    
          prj.Name = 'IMP-LMG' ;
     
          
          insert prj;
      
      
          Project_Piece__c PP = new Project_Piece__c();
          PP.Project__c = prj.Id;
          PP.Piece_Issue__c = 'TestPiece - Sticker';
          PP.Name = 'VinSticker';
          PP.Project_Piece_Stage__c = 'Introduction';
          insert PP;
          
          O.Project_Exception__c = true;
          update O;
           
                            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            
            
            I.Paid__c = system.today();
            I.Confirmed__c = true;
            
           	update I; /// uncomment later NCJ 5/31/13
            //delete I;
            
            
            test.startTest();
            
            
            
            test.stopTest();
            
        }*/
    }
    
    
    
   /* static testMethod void myUnitTest2() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            
            
            //A.Type = 'Prospect';
            
            //update A;
            
            
            
            Contact Ctc = new Contact();
            Ctc.AccountId = A.Id;
            Ctc.FirstName = 'test';
            Ctc.LastName = 'test';
                    
            insert Ctc;
            
            
            Opportunity O  = new Opportunity();
            O.AccountId = A.Id; 
            O.Name = 'testILM';
            
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            O.Type = 'New Business'; //was 'Existing Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   //generalsales//01270000000Q7t7  //t1/t2//01270000000Q9Me
            O.RecordTypeId = '01270000000Q9Me';
            O.Initial_Load__c = 5; 
            O.TryCatchTest__c = true;
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '1';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.CRM_Vendor__c = 'AAX';
            O.DMS_Vendor__c = 'AAX';
            O.ILM_Vendor__c = 'AAX';
            O.Inventory_Vendor__c = 'AAX';
            O.Pricing_Vendor__c = 'AAX';
            O.Website_Vendor__c = 'AAX';
            // O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            O.Project_Generated__C = false;
            O.Discount_Approval_Status__c = 'Approved';
                        
            insert O;
            
            Competition__c comp = new Competition__c();
            comp.Opportunity__c = O.Id;
            comp.Name = 'N/A';
            
            insert comp;
            
            system.debug('Bazinga.... 5: ' + Limits.getQueries());
            
            string prodName = 'CRM';
        
            Product2 p = new Product2();
            p.Name = 'Email Banner';
            p.Quantity_Exception__c = false;
            p.IsTraining__c = false;
            p.ExpPaidByDealer__c = true;
            p.ProdProj_Default_Owner__c = userinfo.getUserId();
            p.Description = 'Email Banner';
            p.IsPackageParent__c = false;
            p.Production_Department__c = 'creative';
            p.Production_Issue__c = 'email Banner';
            p.requiresWelcomePacket__c = false;
            p.Family = 'Reoccuring';
            p.Package_Discount_Percentage__c = .55;
    
            insert p;
            
            system.debug('Bazinga.... 6: ' + Limits.getQueries());
            
                
            Pricebook2 PB = [select Id from Pricebook2 where Name = 'Standard Price Book' limit 1];     
                
            PricebookEntry PBE = new PricebookEntry();
            //PBE.Name = 'Inventory Light';
            PBE.UnitPrice = 100.00;
            PBE.Pricebook2Id = PB.Id;
            PBE.Product2Id = p.Id;
            PBE.IsActive = true;   
            
            insert PBE;
            
            system.debug('Bazinga.... 7: ' + Limits.getQueries());
            
            OpportunityLineItem OLI = new OpportunityLineItem();
            OLI.PricebookEntryId = PBE.Id;
            OLI.OpportunityId = O.Id;
            OLI.Quantity = 1;
            OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            insert OLI;
        
            system.debug('Bazinga....start opp update: ' + Limits.getQueries());
            
 
            //update O; 
            
                      
            system.debug('Bazinga....end opp update: ' + Limits.getQueries());
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            I.Paid__c = system.today();
            I.Confirmed__c = true;            
            insert I;
            
            system.debug('Bazinga.... 8: ' + Limits.getQueries());
                        
            test.startTest();
                                              
            test.stopTest();
            
        }
    }
    
    
    
    
   static testMethod void myUnitTest3() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            A.BillingState = 'XX';
            A.BillingStreet = '1234';
            A.Type = 'Prospect';            
            A.name = 'TestAccount';
                            
            insert A;
            
            
            //update A;
            
            string AcctId = A.Id;
            
            Contact Ctc = new Contact();
            Ctc.AccountId = A.Id;
            Ctc.FirstName = 'test';
            Ctc.LastName = 'test';
                    
            insert Ctc;
            
            Opportunity O  = new Opportunity();
            O.AccountId = AcctId; //set the required fields
            O.Name = 'testILM';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Prospect';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5; 
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
            
            
            string prodName = 'CRM';
        
            Product2 product = new Product2(
            name = prodName);   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            User testUser = [select Id, Name from User where Id = '00570000001K9aoAAC'];
            product.ProdProj_Default_Owner__c = testUser.Id; //userinfo.getUserId();             
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
    
            insert product;
                
            Pricebook2 PB = [select id from Pricebook2 where name = 'Standard Price Book' limit 1];     
                
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 100.00;
            PBE.Pricebook2Id = PB.Id;
            PBE.Product2Id = product.Id;
            PBE.IsActive = true;   
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;

            //insert OLI;        
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            // O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            //I.Paid2__c = system.today();
            I.Paid__c = system.today();
            I.Confirmed__c = true;            
            insert I;
            
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //delete I;

            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
    
   
    static testMethod void myUnitTest4() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId();     
            TS.Website_Manager__c = userInfo.getUserId();
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
            A.Type = 'Prospect';
            
            insert A;
            
            string AcctId = A.Id;
            
            Contact Ctc = new Contact();
            Ctc.AccountId = A.Id;
            Ctc.FirstName = 'test';
            Ctc.LastName = 'test';
                    
            insert Ctc;
            
            Opportunity O  = new Opportunity();
            O.AccountId = AcctId; //set the required fields
            O.Name = 'CRM';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.Paid__c = 'Yes';
            O.Contract_Generated__c = false;
            // O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.TryCatchTest__c = true;
            //O.Project_Exception__c = true;
            O.Project_Exception__c = false;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
            
            
            string prodName = 'CRM';
        
            Product2 product = new Product2();
            product.Name = 'CRM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            //product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = '00570000001K9ao';
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            
            product.Name = 'Websites';
                       
            insert product;
                
            Pricebook2 PB = [select id from Pricebook2 where name = 'Standard Price Book' limit 1];     
                
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 100.00;
            PBE.Pricebook2Id = PB.Id;
            PBE.Product2Id = product.Id;
            PBE.IsActive = true;   
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            // O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= false;
            update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            I.Paid__c = system.today();
            I.Confirmed__c = true;
            I.Installment_Number__c = 1;
            insert I;
            
            //I.Paid__c = system.today();
            //I.Confirmed__c = true;
            //update I;
            //delete I;
    
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
    
    
    
    
    
    static testMethod void myUnitTest5() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
                            
            
            A.Type = 'Prospect';
            
            insert A;
            
            string AcctId = A.Id;
            
            Contact Ctc = new Contact();
            Ctc.AccountId = A.Id;
            Ctc.FirstName = 'test';
            Ctc.LastName = 'test';
                    
            insert Ctc;
            
            Opportunity O  = new Opportunity();
            O.AccountId = AcctId; //set the required fields
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            //O.RecordTypeId = '01270000000Q7t7';
            O.RecordTypeId ='01270000000Q9Me';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            // O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Hardware';
            O.TryCatchTest__c = true;
            O.Project_Exception__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Inventory Light';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'Inventory Light';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            User testUser = [select Id, Name from User where Name = 'Rebecca Villa' LIMIT 1];
            product.ProdProj_Default_Owner__c = testUser.Id; //userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.requiresWelcomePacket__c = true;
            //product.Project_Separation__c = 'Implementation';
            product.ProdProj_Default_Owner__c = '00570000001K9ao';
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
            product.Name = 'DIY';
    
            insert product;
            
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            OpportunityLineItem OLI = new OpportunityLineItem();
            OLI.PricebookEntryId = PBE.Id;
            OLI.OpportunityId = O.Id;
            OLI.Quantity = 1;
            OLI.TotalPrice = 100.00;
            OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            insert OLI;
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            // O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
          //Project inserted for code coverage
          SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
          prj.Opportunity__c = O.Id;
          prj.Date_Packet_Sent__c = null;
          prj.RecordTypeId = '012700000005dgP';
          prj.Training_Included__c = TRUE;    
          prj.Name = 'WEB-LMG' ;
     
          
          insert prj;
      
      
          Project_Piece__c PP = new Project_Piece__c();
          PP.Project__c = prj.Id;
          PP.Piece_Issue__c = 'TestPiece - Sticker';
          PP.Name = 'VinSticker';
          PP.Project_Piece_Stage__c = 'Introduction';
          insert PP;
          
          O.Project_Exception__c = true;
          O.Project_Generated__c = false;
          update O;
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            I.Confirmed__c = true;
            I.Paid__c = system.today();
            
            insert I;
            
            //update I;
            //delete I;
            
            ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(I);
           Installment ins = new Installment();
            
            test.startTest();
            
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTest6() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Add On';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'Website';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
            //product.Project_Separation__c = 'Implementation';
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
           // OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;

            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
    
    
    static testMethod void myUnitTest7() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'CRM';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'CRM';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM CRM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;

            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
    
    
    
    
    static testMethod void myUnitTest8() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'CRM';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;
        
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
    
    
    static testMethod void myUnitTest9() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'ILM';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;
        
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
    
   
    static testMethod void myUnitTest10() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Hardware';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;

            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTest11() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId();     
            TS.Website_Manager__c = userInfo.getUserId();
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Digital Marketing Package';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;
            
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
   
    static testMethod void myUnitTest12() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId();     
            TS.Website_Manager__c = userInfo.getUserId();
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Fulfillment';
            O.Campaign_Type__c = 'Test';
            O.Fulfillment_Timeline__c = 'Standard';
            O.Campaign_Start_Date__c = system.Today().addDays(30);
            O.Campaign_End_Date__c = system.Today().addDays(60);
            O.Mailer_Notes__c = 'TEST';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;

            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
   
    static testMethod void myUnitTest13() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'OEM Website';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;

            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
   
    static testMethod void myUnitTest14() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Website';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;
            
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
    
    static testMethod void myUnitTest15() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Printed Materials';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;
            
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
  
    static testMethod void myUnitTest16() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Fulfillment Coop';
            O.Campaign_Type__c = 'Test';
            O.Fulfillment_Timeline__c = 'Standard';
            O.Campaign_Start_Date__c = system.Today().addDays(30);
            O.Campaign_End_Date__c = system.Today().addDays(60);
            O.Mailer_Notes__c = 'TEST';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = userinfo.getUserId();
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            I.Paid2__c = system.today();
            update I;
            //delete I;
        
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
   
    static testMethod void myUnitTest17() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            O.Name = 'testCRM - Hardware - Add On - Bronze Solution - ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            O.RecordTypeId = '01270000000Q9Me';   
            //O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Hardware';
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            insert O; //save it to SFDC (it will rollback after your test
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = '00570000001hDvQ';
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
    
            insert product;
            
            product.Name = 'DIY';
            
            //update product;
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
            
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            //insert I;
            
            I.Paid2__c = system.today();
            //update I;
            //delete I;
                        
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
   
    static testMethod void myUnitTest18() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId();
            TS.Website_Manager__c = userInfo.getUserId();   
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
            
            
                
            Pricebook2 standardPB = [SELECT Id FROM Pricebook2 WHERE isStandard = true]; 
            
            Pricebook2 t1t2 = new Pricebook2();
            //t1t2.Family = 'Reoccuring';
            t1t2.IsActive = true;
            t1t2.Name = 'Tier1/Tier2';
            insert t1t2;    
             
            Product2 product = new Product2();
            product.Name = 'ILM';   
            product.Quantity_Exception__c = true;
            product.IsTraining__c = true;
            product.ExpPaidByDealer__c = true;
            product.ProdProj_Default_Owner__c = userinfo.getUserId();                   
            product.Description = 'website';
            product.IsPackageParent__c = true;
            product.Production_Department__c = 'creative';
            product.Production_Issue__c = 'website';
            product.ProdProj_Default_Owner__c = '00570000001hDvQ';
            product.requiresWelcomePacket__c = true;
            product.Related_Product__c = null;
            product.Family = 'Reoccuring';
            product.isActive = true;
            //product.Project_Separation__c = 'Websites';
    
            insert product;
            
            Product_Process__c pProc = new Product_Process__c();
            pProc.Product__c = product.Id;
            pProc.Milestone_1__c = 'Test Milestone';
            pProc.Milestone_1_Stage__c = 'Completed';
            pProc.Assign_to_Role_1__c = 'DDM';
            pProc.Milestone_2__c = 'Test Milestone';
            pProc.Milestone_2_Stage__c = 'Completed';
            pProc.Assign_to_Role_2__c = 'DDM';
            pProc.Milestone_3__c = 'Test Milestone';
            pProc.Milestone_3_Stage__c = 'Completed';
            pProc.Assign_to_Role_3__c = 'DDM';
            pProc.Milestone_4__c = 'Test Milestone';
            pProc.Milestone_4_Stage__c = 'Completed';
            pProc.Assign_to_Role_4__c = 'DDM';
            pProc.Milestone_5__c = 'Test Milestone';
            pProc.Milestone_5_Stage__c = 'Completed';
            pProc.Assign_to_Role_5__c = 'DDM';
            pProc.Milestone_6__c = 'Test Milestone';
            pProc.Milestone_6_Stage__c = 'Completed';
            pProc.Assign_to_Role_6__c = 'DDM';
            pProc.Milestone_7__c = 'Test Milestone';
            pProc.Milestone_7_Stage__c = 'Completed';
            pProc.Assign_to_Role_7__c = 'DDM';
            pProc.Milestone_8__c = 'Test Milestone';
            pProc.Milestone_8_Stage__c = 'Completed';
            pProc.Assign_to_Role_8__c = 'DDM';
            pProc.Milestone_9__c = 'Test Milestone';
            pProc.Milestone_9_Stage__c = 'Completed';
            pProc.Assign_to_Role_9__c = 'DDM';
            pProc.Milestone_10__c = 'Test Milestone';
            pProc.Milestone_10_Stage__c = 'Completed';
            pProc.Assign_to_Role_10__c = 'DDM';
            
            insert pProc;
            
            
            PricebookEntry standardPrice = new PricebookEntry();
            standardPrice.UnitPrice = 100.00;
            standardPrice.Pricebook2Id = standardPB.Id;
            standardPrice.Product2Id = product.Id;
            standardPrice.IsActive = true; 
            standardPrice.UseStandardPrice = false;  
            insert standardPrice;
            
            PricebookEntry PBE = new PricebookEntry();
            PBE.UnitPrice = 1000.00;
            PBE.Pricebook2Id = t1t2.Id;
            PBE.Product2Id = product.Id;
            PBE.isActive = true;
            insert PBE;
            
            Opportunity O  = new Opportunity();
            O.AccountId = AcctId; //set the required fields
            O.Name = 'DIY ';
            //
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = System.today();
            O.StageName = 'Closed or Won';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   
            O.RecordTypeId = '01270000000Q7t7';
            O.Initial_Load__c = 5;
            O.PAID__c = 'Yes';
            O.Contract_Generated__c = true;
            O.We_Owe__c = 'N/A';
            O.Implementation_Contact__c = Ctc.Id;
            O.Package_Type__c = 'With Website';
            O.Opportunity_Names__c = 'Training';
            O.Number_of_Installments__c = '1';
            O.Phased_Project__c = true;
            O.TryCatchTest__c = true;
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; //save it to SFDC (it will rollback after your test
            
            SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
            proj.Opportunity__c = O.Id;
            proj.Name = 'Mailer';
            
            insert proj;
            
            Project_Piece__c pp = new Project_Piece__c();
            pp.Name = 'Mailer';
            pp.Project__c = proj.Id;
            pp.Product_Process__c = pProc.Id;
            pp.Piece_Issue__c = 'Test';
            pp.Account__c = A.Id;
            
            insert pp;
            
            
            //OpportunityLineItem OLI = new OpportunityLineItem();
            //OLI.PricebookEntryId = PBE.Id;
            //OLI.OpportunityId = O.Id;
            //OLI.Quantity = 1;
            //OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            //OLI.Quantity_Exception__c = 'True';
            //OLI.PricebookEntry.Product2.Family = 'Reoccuring';
            //insert OLI;
            
                        
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '3';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            I.Installment_Amount__c = 25000;
            I.Payment_Type__c = 'ACH';
            I.Installment_Number__c = 1;
            I.Installment_Due_Date__c = system.today();
            insert I;
            
            I.Paid2__c = system.today();
            //update I;
            //delete I;
   
            
            
            //Set your controller
            Installment controller = new Installment();
            
            test.startTest();
            
            
            
            test.stopTest();
        }
    }
 
    static testMethod void myUnitTest19() {
        system.debug('BAZINGA.......WTF');
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB', 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
            
        insert u_testMethodUser;
        

        
        System.runas(u_testMethodUser) {
            
            
            Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId(); 
            TS.Website_Manager__c = userInfo.getUserId();   
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
            A.Type = 'Prospect';
                            
            insert A;
            
              
            
            Contact Ctc = new Contact();
            Ctc.AccountId = A.Id;
            Ctc.FirstName = 'test';
            Ctc.LastName = 'test';
                    
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
            
            O.Deal_Contact__c = Ctc.id;
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            //O.RecordTypeId = '012S00000008rGjIAI';   //generalsales//01270000000Q7t7  //t1/t2//01270000000Q9Me
            O.RecordTypeId = '01270000000Q7t7';
            //O.Initial_Load__c = 5; 
            O.TryCatchTest__c = true;
            O.Project_Exception__c = true; //added for code coverage
            O.Discount_Approval_Status__c = 'Approved';
            
            insert O; 
            
            Competition__c comp = new Competition__c();
            comp.Opportunity__c = O.Id;
            comp.Name = 'N/A';
            
            insert comp;
            
            string prodName = 'CRM';
        
            Product2 p = new Product2();
            p.Name = 'Email Banner';
            p.Quantity_Exception__c = false;
            p.IsTraining__c = false;
            p.ExpPaidByDealer__c = true;
            p.ProdProj_Default_Owner__c = userinfo.getUserId();
            p.Description = 'Email Banner';
            p.IsPackageParent__c = false;
            p.Production_Department__c = 'creative';
            p.Production_Issue__c = 'email Banner';
            p.requiresWelcomePacket__c = false;
            p.Family = 'Reoccuring';
            p.Package_Discount_Percentage__c = .55;
    
            insert p;
            
            
                
            Pricebook2 PB = [select Id from Pricebook2 where Name = 'Standard Price Book' limit 1];     
                
            PricebookEntry PBE = new PricebookEntry();
            //PBE.Name = 'Inventory Light';
            PBE.UnitPrice = 100.00;
            PBE.Pricebook2Id = PB.Id;
            PBE.Product2Id = p.Id;
            PBE.IsActive = true;   
            
            insert PBE;
            
            
            OpportunityLineItem OLI = new OpportunityLineItem();
            OLI.PricebookEntryId = PBE.Id;
            OLI.OpportunityId = O.Id;
            OLI.Quantity = 1;
            OLI.TotalPrice = 100.00;
            //OLI.Override_Related_Product__c = true;
            insert OLI;
        
            
            O.Opportunity_Names__c = 'Hardware';
            O.Multi_Installments_Approved__c=true;
            O.StageName = 'Closed or Won';
            O.Number_of_Installments__c = '1';
            O.Implementation_Contact__c = Ctc.id;
            O.Deal_Contact__c = Ctc.id;
            O.CRM_Vendor__c = 'AAX';
            O.DMS_Vendor__c = 'AAX';
            O.ILM_Vendor__c = 'AAX';
            O.Inventory_Vendor__c = 'AAX';
            O.Pricing_Vendor__c = 'AAX';
            O.Website_Vendor__c = 'AAX';
            // O.We_Owe__c = 'test';
            O.Amount = 1200;
            O.Multi_Installments_Approved__c= true;
            //update O; 
            
          //Project inserted for code coverage
          SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
          prj.Opportunity__c = O.Id;
          prj.Date_Packet_Sent__c = null;
          prj.RecordTypeId = '012700000005dgP';
          prj.Training_Included__c = TRUE;    
          prj.Name = 'IMP-LMG' ;
     
          
          insert prj;
      
      
          Project_Piece__c PP = new Project_Piece__c();
          PP.Project__c = prj.Id;
          PP.Piece_Issue__c = 'TestPiece - Sticker';
          PP.Name = 'VinSticker';
          PP.Project_Piece_Stage__c = 'Introduction';
          insert PP;
          
          O.Project_Exception__c = true;
          O.Discount_Approval_Status__c = 'Approved';
          update O;
           
                            
            //Installments
            Installment__c I = new Installment__c();
            I.Opportunity__c = O.id;
            insert I;
            
            
            
            I.Paid__c = system.today();
            I.Confirmed__c = true;
            
            update I; /// uncomment later NCJ 5/31/13
            //delete I;
            
            
            test.startTest();
                 
            
            test.stopTest();
            
        }
    }*/
    
}