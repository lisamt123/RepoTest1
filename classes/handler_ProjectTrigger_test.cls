@isTest(SeeAllData=True)
private class handler_ProjectTrigger_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com', Team_Name__c = 'Test Name');
            
        insert u_testMethodUser;
        
        User u_testMethodUser2 = new User(alias = 'testMet2', email = 'testMetho2dUser@salesforce.com',
            emailencodingkey = 'UTF-8', lastname = 'Test Method User2', languagelocalekey = 'en_US',
            localesidkey = 'en_US', profileid = pro.Id, 
            timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser2@salesforce.com', Team_Name__c = 'Test Name2');
        
        insert u_testMethodUser2;
        
        System.runas(u_testMethodUser) {
            
            //Set your controller
            handler_ProjectTrigger controller = new handler_ProjectTrigger();
            
            /*Territory_State__c TS = new Territory_State__c();
            TS.Name = 'XX';
            TS.Account_Manager__c = userinfo.getUserId();
            TS.DDM__c = userinfo.getUserId();
            TS.Regional__c = userinfo.getUserId();
            TS.Implementation_Manager__c = userinfo.getUserId();
            TS.Implementation_Specialist__c = userinfo.getUserId();     
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
            O.CloseDate = System.today()+5;
            O.StageName = 'Prospect';
            O.Type = 'New Business';
            O.Salesperson__c = userinfo.getUserId();
            O.Implementation_Contact__c = Ctc.id;
            //O.We_Owe__c = 'N/A'; 
            
            insert O; //save it to SFDC (it will rollback after your test
            O.Multi_Installments_Approved__c=true;
            O.Number_of_Installments__c = '3';
            O.Amount= 1200;
            update O; //THIS WILL FIRE YOUR UPDATE TRIGGER, and make sure it's included in the test
            O.Amount = 1500;
            OpportunityClass.UpdateInvoiceInformation(O);
            update O;
        	Product2 product = [select Id, Related_Product__c,ProdProj_Default_Owner__c, isActive from Product2 where isActive = true AND (Related_Product__c = null OR Related_Product__c = '') limit 1];            

        	PricebookEntry PBE = [select id, Product2Id, Pricebook2Id, IsActive, UnitPrice, UseStandardPrice from PricebookEntry where IsActive = true AND Product2Id =: product.Id limit 1];
                      
        	OpportunityLineItem OLI = new OpportunityLineItem();
        	OLI.PricebookEntryId = PBE.Id;
        	OLI.Quantity = 1;       
        	OLI.ActualDescription__c = 'website';
        	OLI.OpportunityId = O.id;       
        	OLI.TotalPrice = 1000.00;       
        	insert OLI;            
            
            //Project
            SFDC_520_Quote__c prj = new SFDC_520_Quote__c();
            prj.Opportunity__c = O.Id;
            prj.Date_Packet_Sent__c = null;
            prj.RecordTypeId = '012700000005dgP';//implementation
            prj.Training_Included__c = TRUE;
            prj.OwnerId = u_testMethodUser.Id;  
            
            insert prj;
            
            Project_Piece__c PP = new Project_Piece__c();
            PP.Project__c = prj.Id;
            PP.Piece_Issue__c = 'TestPiece - Sticker';
            PP.Name = 'PP-Inventory Module-LYNNTEST';
            PP.Project_Piece_Stage__c = 'Introduction';
            insert PP;
            
            PP.Name ='PP-ILM Implementation-LYNNTEST';     
            update PP;      
             
            PP.Name ='PP-Launch Coordinator-LYNNTEST';     
            update PP;  
            
            PP.Name ='PP-Text messages-LYNNTEST';     
            update PP; 
                                       
            test.startTest();
            product.ProdProj_Default_Owner__c = '00570000001es9g';
            system.debug('TEST Project Owner change');
			update product;                              
            prj.OwnerID = '00570000001es9g';
            update prj;
            

            //Could not create a perfect storm to test updateProjectMilestoneNA 
			//Installments
			//Adding installment to get updateProjectMilestoneNA to run
			//Installment__c I = new Installment__c();
			//I.Opportunity__c = O.id;
			//I.Confirmed__c	= true;	
			//I.Paid__c = system.today();	
			//insert I;		
            //O.RecordTypeId = '01270000000Q9Me';
            //O.StageName = 'Closed or Won';          
            //update O;            
            //system.debug('TEST updateProjectMilestoneNA');
			

            // add a delete case
            delete PP;
            delete prj;
            
            
            u_testMethodUser.Team_Name__c = 'Name Name';
            update u_testMethodUser;
  
       
            test.stopTest();
        }
    }

}