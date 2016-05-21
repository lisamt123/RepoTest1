@isTest(SeeAllData=true)
private class UpdatePieceStage_test {

    static testMethod void myUnitTest() {
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];        
        UserRole role = [SELECT Id From UserRole WHERE Name = 'Director of Sales'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com',
            UserRoleId = role.Id);
                        
        insert u_testMethodUser;
        
                
        System.runas(u_testMethodUser) {*/
            
            //Set your controller
            UpdatePieceStage controller = new UpdatePieceStage();            
            
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
            
            Opportunity O = new Opportunity();
            O.AccountId = A.Id;
            O.Name = 'test';
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            insert O;
            
            Product2 product = new Product2(
            name = 'test');     
            insert product;
            
            SFDC_520_Quote__c P = new SFDC_520_Quote__c();
            P.Opportunity__c = O.id;
            User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];        
            insert P;
            
            Project_Piece__c PP = new Project_Piece__c();
            PP.Project__c = P.Id;
            PP.Piece_Issue__c = 'test';
            PP.RecordTypeId = '01270000000Q4V0';
            PP.Name = 'PP-Website - landing page-';
            insert PP;
            
            LIST<Project_Runner__c> testPRs = new LIST<Project_Runner__c>();
            
            Project_Runner__c PR = new Project_Runner__c();
            PR.Project_Piece__c = PP.Id;
            PR.Designer__c = Userinfo.getUserId();
            PR.Event_Date_Time__c = system.now();
            PR.Event_End_Date_Time__c = system.now();
            PR.Runner_Action__c = 'Request';
            PR.Runner_Type__c = 'Comp';
            insert PR;
            
            test.startTest();
            // original PR action/type is Request/Comp, need to change action to Start, Submit, Approve
            
            PR.Runner_Action__c = 'Start';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            PR.Runner_Action__c = 'Submit';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            PR.Runner_Action__c = 'Approve';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           

            test.stopTest();
            
        //}
    }
    static testMethod void myUnitTest2() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        UserRole role = [SELECT Id From UserRole WHERE Name = 'Director of Sales'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com',
            UserRoleId = role.Id);
                        
        insert u_testMethodUser;
        
                
        System.runas(u_testMethodUser) {*/
            
            //Set your controller
            UpdatePieceStage controller = new UpdatePieceStage();            
            
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
            
            Opportunity O = new Opportunity();
            O.AccountId = A.Id;
            O.Name = 'test';
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            insert O;
            
            Product2 product = new Product2(
            name = 'test');     
            insert product;
            
            SFDC_520_Quote__c P = new SFDC_520_Quote__c();
            P.Opportunity__c = O.id;
            User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];        
            insert P;
            
            Project_Piece__c PP = new Project_Piece__c();
            PP.Project__c = P.Id;
            PP.Piece_Issue__c = 'test';
            PP.RecordTypeId = '01270000000Q4V0';
            PP.Name = 'PP-Website - landing page-';
            insert PP;
            
            LIST<Project_Runner__c> testPRs = new LIST<Project_Runner__c>();
            
            Project_Runner__c PR = new Project_Runner__c();
            PR.Project_Piece__c = PP.Id;
            PR.Designer__c = Userinfo.getUserId();
            PR.Event_Date_Time__c = system.now();
            PR.Event_End_Date_Time__c = system.now();
            PR.Runner_Action__c = 'Request';
            PR.Runner_Type__c = 'Correction';
            insert PR;
            
            test.startTest();
            // original PR action/type is Request/Correction, need to change action to Start, Submit, Approve
            
            PR.Runner_Action__c = 'Start';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            PR.Runner_Action__c = 'Submit';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            PR.Runner_Action__c = 'Approve';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            
            test.stopTest();
            
        //}
    }
    static testMethod void myUnitTest3() {
        
       /* Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        UserRole role = [SELECT Id From UserRole WHERE Name = 'Director of Sales'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com',
            UserRoleId = role.Id);
                        
        insert u_testMethodUser;
        
                
        System.runas(u_testMethodUser) {*/
            
            //Set your controller
            UpdatePieceStage controller = new UpdatePieceStage();            
            
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
            
            Opportunity O = new Opportunity();
            O.AccountId = A.Id;
            O.Name = 'test';
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            insert O;
            
            Product2 product = new Product2(
            name = 'test');     
            insert product;
            
            SFDC_520_Quote__c P = new SFDC_520_Quote__c();
            P.Opportunity__c = O.id;
            User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];        
            insert P;
            
            Project_Piece__c PP = new Project_Piece__c();
            PP.Project__c = P.Id;
            PP.Piece_Issue__c = 'test';
            PP.RecordTypeId = '01270000000Q4V0';
            PP.Name = 'PP-Website - landing page-';
            insert PP;
            
            LIST<Project_Runner__c> testPRs = new LIST<Project_Runner__c>();
            
            Project_Runner__c PR = new Project_Runner__c();
            PR.Project_Piece__c = PP.Id;
            PR.Designer__c = Userinfo.getUserId();
            PR.Event_Date_Time__c = system.now();
            PR.Event_End_Date_Time__c = system.now();
            PR.Runner_Action__c = 'Request';
            PR.Runner_Type__c = 'Revision';
            insert PR;
            
            test.startTest();
            // original PR action/type is Request/Correction, need to change action to Start, Submit, Approve
            
            PR.Runner_Action__c = 'Start';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            PR.Runner_Action__c = 'Submit';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            PR.Runner_Action__c = 'Approve';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            test.stopTest();
            
        //}
    }    
    static testMethod void myUnitTest4() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        UserRole role = [SELECT Id From UserRole WHERE Name = 'Director of Sales'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com',
            UserRoleId = role.Id);
                        
        insert u_testMethodUser;
        
                
        System.runas(u_testMethodUser) {*/
            
            //Set your controller
            UpdatePieceStage controller = new UpdatePieceStage();            
            
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
            
            Opportunity O = new Opportunity();
            O.AccountId = A.Id;
            O.Name = 'test';
            O.CloseDate = system.today();
            O.StageName = 'Prospect';
            insert O;
            
            Product2 product = new Product2(
            name = 'test');     
            insert product;
            
            SFDC_520_Quote__c P = new SFDC_520_Quote__c();
            P.Opportunity__c = O.id;
            User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];         
            insert P;
            
            Project_Piece__c PP = new Project_Piece__c();
            PP.Project__c = P.Id;
            PP.Piece_Issue__c = 'test';
            PP.RecordTypeId = '01270000000Q4V0';
            PP.Name = 'PP-Website - landing page-';
            insert PP;
            
            LIST<Project_Runner__c> testPRs = new LIST<Project_Runner__c>();
            
            Project_Runner__c PR = new Project_Runner__c();
            PR.Project_Piece__c = PP.Id;
            PR.Designer__c = Userinfo.getUserId();
            PR.Event_Date_Time__c = system.now();
            PR.Event_End_Date_Time__c = system.now();
            PR.Runner_Action__c = 'Request';
            PR.Runner_Type__c = 'Site';
            insert PR;
            
            test.startTest();
            // original PR action/type is Request/Correction, need to change action to Start, Submit, Approve
            
            PR.Runner_Action__c = 'Start';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            PR.Runner_Action__c = 'Submit';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            PR.Runner_Action__c = 'Approve';
            update PR;    
            UpdatePieceStage.updatePieceStage(PR);           
            test.stopTest();
            
        }
    //}        
}