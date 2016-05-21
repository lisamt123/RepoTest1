@isTest
public with sharing class TestData {


    public static Boolean isMotoSnapCalloutSuccess = true;
    public static Boolean isMotoSnapTimeOutError = true;
     public  static Account setupAccount(){ 
        Account a = new Account();
        a.Name = 'test';
        a.AccountNumber = '1';
        a.BillingCity = 'Oakbrook Terrace';
        a.BillingCountry = 'USA';
        a.BillingState = 'IL';
        a.BillingStreet = '1901 S. Meyers Suite 700';
        a.BillingPostalCode = '60181';
        a.ShippingCity = 'Oakbrook Terrace';
        a.ShippingCountry = 'USA';
        a.ShippingState = 'IL';
        a.ShippingStreet = '1901 S. Meyers Suite 700';
        a.ShippingPostalCode = '60181';
        a.SVOC_Id__c  = 'TestData';
        return a;
    }

    public static Opportunity setupOpportunity(Account a, Contact c){
        Opportunity oppty = new Opportunity(Name = 'Test Opportunity',
                                            AccountId = a.Id,
                                            RecordTypeId = StaticData.getInstance().OpportunityRecTypesMapByDevName.get('General_Sales').Id,
                                            Type = 'New Business',
                                            StageName = 'Prospect',
                                            CloseDate = system.today(),
                                            Salesperson__c = userinfo.getUserId(),
                                            Project_Exception__c = false,
                                            Discount_Approval_Status__c = 'Approved',
                                            Deal_Contact__c = c.Id);
        return oppty;
    }

    public static OpportunityLineItem setupOpportunityLineItem(PricebookEntry pbe, Opportunity oppty){
        OpportunityLineItem OpptyLI = new OpportunityLineItem(PricebookEntryId = pbe.Id,
                                                                OpportunityId = oppty.Id,
                                                                Quantity = 1,
                                                                TotalPrice = 1.00);
        return OpptyLI;
    }  

    public static String generateRandomString(Integer len) {
    final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789abcdefghijklmnopqrstuvwxyz';
    String randStr = '';
    while (randStr.length() < len) {
       Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), 62);
       randStr += chars.substring(idx, idx+1);
    }
    return randStr; 
}
  
    public  static Contact setupContact(){
        Contact c = new Contact();
        c.FirstName = 'TestFirstName';
        c.LastName = 'TestLastName';
        c.Phone = '234-234-2345';
        return c;
    }

    public  static Contact setupContact(String firstName, String lastName){
        Contact c = new Contact();
        c.FirstName = firstName;
        c.LastName = lastName;
        c.Phone = '234-234-2345';
        return c;
    }

    public  static Contact setupContact(Account a, String bu){
        Contact c = new Contact();
        c.FirstName = 'TestFirstName';
        c.LastName = 'TestLastName';
        c.Phone = '234-234-2345';
        c.AccountId = a.Id;
        c.Business_Unit__c = bu;
        return c;
    }

    public static User setupUser(){     
       
        List <Profile> p = [Select Name, Id From Profile where name like '%VinSystem Admin%' limit 1];
        List <UserRole> ur = [Select Name, Id From UserRole where name like '%Business Analyst%' limit 1];

        Long randomNumber = Math.mod (Math.mod (System.currentTimeMillis(), 1000000) , 989898989);
        
        User u = new User(email = 'testuser@testorg.com',
                            alias='u' + randomNumber ,
                            emailencodingkey='UTF-8',
                            lastname='Testing',
                            languagelocalekey='en_US',
                            localesidkey='en_US',
                            profileid = p[0].Id,
                            timezonesidkey='America/Los_Angeles', 
                            username='unittestuser'+randomNumber+'@testorg.com');
        
        insert u;   
        return u;   
    }

    public static User setupUser(String profile, String role){     
       
        profile = '%'+profile+'%';
        role = '%'+role+'%';

        List <Profile> p = [Select Name, Id From Profile where name like :profile limit 1];
        List <UserRole> ur = [Select Name, Id From UserRole where name like :role limit 1];

        Long randomNumber = Math.mod (Math.mod (System.currentTimeMillis(), 1000000) , 989898989);
        
        User u = new User(email = 'testuser@testorg.com',
                            alias='u' + randomNumber ,
                            emailencodingkey='UTF-8',
                            lastname='Testing',
                            languagelocalekey='en_US',
                            localesidkey='en_US',
                            profileid = p[0].Id,
                            timezonesidkey='America/Los_Angeles', 
                            username='unittestuser'+randomNumber+'@testorg.com');
           
        return u;   
    }

    public static Product2 getProduct(){
        Product2 pr = new Product2(Name = 'Test Product',
                   Proposal_Grouping__c = 'A-Package',
                 Proposal_Sort_Order__c = 1,
                   Grouping_Category__c = 'CRM');
       return pr;
    }

    public   static Product2 getProduct(String productName, String productBU){
      system.debug('=======================>>>>>>>>> productName = ' + productName);
      system.debug('=======================>>>>>>>>> productBU = ' + productBU);
       List<Product2> products = [Select Id, Name from Product2 where Name =: productName And product_BU__c =: productBU];
       system.debug('=======================>>>>>>>>> products list = ' + products);
       if(products== null || products.size() ==0){
           new CoxAutomotiveException('Could not find vAuto Product: '+productName);
           system.debug('=======================>>>>>>>>> Query result = ' + [Select Id, Name from Product2 where Name ='Advanced Inventory with Website and MPT Package' And product_BU__c ='VinSolutions']);
       }
       Product2 pr = products[0];
       return pr;
    }

    public static PricebookEntry setupPricebookEntry(){
        Product2 prod = new Product2(Name = 'Desking', Family = 'CRM');
        insert prod;
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                            Product2Id = prod.Id,
                                                             UnitPrice = 10000,
                                                              IsActive = true);
        return standardPrice;
    }

    public static PricebookEntry setupPricebookEntry(Product2 prod){
        Id pricebookId = Test.getStandardPricebookId();
        PricebookEntry standardPrice = new PricebookEntry(Pricebook2Id = pricebookId,
                                                            Product2Id = prod.Id,
                                                             UnitPrice = 10000,
                                                              IsActive = true);
        return standardPrice;
    }
    
    public static  PricebookEntry getPricebookEntry(Product2 p,String priceBookName){
        List<PricebookEntry> priceBookEntry = [SELECT Id, Pricebook2Id, UnitPrice, ProductCode, Product2Id, Name FROM PricebookEntry where Pricebook2.Name =: priceBookName and Product2Id =: p.Id];
        if(priceBookEntry == null || priceBookEntry.size() ==0){
           new CoxAutomotiveException('Could not find entry in Pricebook vAuto 2014 for product '+p.Name);
       }
       
     PricebookEntry pe = priceBookEntry[0];
     return pe;
        
    }

    public static SFDC_520_Quote__c setupProject(Opportunity oppty){
            SFDC_520_Quote__c project = new SFDC_520_Quote__c(Name = 'IMP - WAS',
                                                    Opportunity__c = oppty.Id,
                                               Date_Packet_Sent__c = null,
                                                      RecordTypeId = StaticData.getInstance().ProjectRecTypesMapByDevName.get('Non_WPP').Id,
                                              Training_Included__c = true,
                                                  Project_Worth__c = 1000);
        return project;
    }

    public static Project_Piece__c setupProjectPiece(SFDC_520_Quote__c p){
      Project_Piece__c PP = new Project_Piece__c(Project__c = p.Id,
                                             Piece_Issue__c = 'TestPiece - Sticker',
                                                       Name = 'VinSticker',
                                     Project_Piece_Stage__c = 'Introduction');
      return PP;
    }

    public static Project_Comment__c setupProComment(SFDC_520_Quote__c p, Project_Piece__c pp){
      Project_Comment__c pc = new Project_Comment__c(Comments__c = 'test',
                                                      Project__c = p.Id,
                                                Project_Piece__c = pp.Id);
      return pc;
    }

    public static Product_Process__c getProductProcess(Product2 p){
        Product_Process__c proc = new Product_Process__c(Product__c = p.Id,
                                                     Milestone_1__c = 'Test1',
                                               Milestone_1_Stage__c = 'Introduction');
        return proc;
    }

    public static POA__c setupPOA(Account a, String recordTypeName){
        POA__c poa = new POA__c(RecordTypeId = StaticData.getInstance().POARecTypesMapByDevName.get(recordTypeName).Id,
                                        Name = 'Test POA',
                                   Dealer__c = a.Id);
        return poa;
    }

    public static Contract setupContract(Account a, RecordType recType){
            Contract ctr = new Contract();
            ctr.AccountId = a.Id;
            ctr.RecordTypeId = recType.Id;
            return ctr;
    }
    

    public static Billing_Item__c setUpBillingItem(Contract c, Product2 p){    
        Billing_Item__c bl = new Billing_Item__c();
        bl.Contract__c = c.Id;
        bl.Product_Sold__c = p.Id;
        return bl;
    } 

    public static Lead setupLead(){
        Lead l = new Lead(LastName = 'TestLastName',
                         FirstName = 'TestFirstName',
                  Customer_Type__c = 'Dealer',
                   Lot_Size_New__c = '1-15',
                  Lot_Size_Used__c = '1-15',
                    Franchise_1__c = 'Acura',
                           Website = 'http://dangeloautosales.com/',
                           Company = 'TestCompany',
                  Business_Unit__c = 'VinSolutions',
                            Status = 'Qualified',
                        LeadSource = 'ATG');
        return l;
    }

    public static Case setupCase(Account a, Contact c){
        Case CS = new Case(AccountId = a.Id,
                           ContactId = c.Id,
                              Origin = 'Phone',
                              Reason = 'Billing',
                              Status = 'New',
                            Priority = '1 - Hot (Fix It Now)');
        return CS;
    }

    public static Case setupCaseWithParent(Account a, Contact c, Case pc){
        Case CS = new Case(AccountId = a.Id,
                           ContactId = c.Id,
                            ParentId = pc.Id,
                              Origin = 'Phone',
                              Reason = 'Billing',
                              Status = 'New',
                            Priority = '1 - Hot (Fix It Now)');
        return CS;
    }

    public static Event setupEvent(Contact c, Opportunity o){
        Event e = new Event(Subject = 'webex',
                      StartDateTime = system.now(),
                        EndDateTime = system.now(),
                              WhoId = c.Id,
                             WhatId = o.Id,
           Exception_Salesperson__c = 'Test User',
           Salesperson_Exception__c = true);    
        return e;
    }

    public static Task setupTaskProject(SFDC_520_Quote__c project){
        Task t = new Task(Subject = 'Send Packet',
                           WhatId = project.Id,
                           Status = 'Not Started',
                             Type = 'Task');
        return t;
    }

    public static Task setupTaskCase(Case c){
        Task t = new Task(Subject = 'Send Packet',
                           WhatId = c.Id,
                           Status = 'Not Started',
                             Type = 'Task');
        return t;
    }

    public static Attachment setupAttachment(sObject obj){
        Attachment Att = new Attachment(ParentId = obj.Id,
                                            Body = blob.valueOf('test'),
                                     ContentType = 'jpeg',
                                            Name = 'test');
        return Att;
    }  
}