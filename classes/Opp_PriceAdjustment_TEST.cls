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
private class Opp_PriceAdjustment_TEST {

    static testMethod void testSelectLists() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
          emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
          localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
          timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
          
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
            
	        Account a = new Account();
	        a.Name = 'TestPriceAdjustment';
	        a.ShippingCity = 'Belton';
	        a.ShippingStreet = '7900 E 159th St';
	        a.ShippingState = 'MO';
	        a.AccountNumber = '565656565656';
	        a.BillingState = 'MO';
	        a.BillingCity = 'Belton';
	        a.BillingCountry = 'USA';
	        a.BillingPostalCode = '64012';
	        a.BillingStreet = '7900 E 159th St';
	        	        a.ShippingState = 'MO';
	        a.ShippingCity = 'Belton';
	        a.ShippingCountry = 'USA';
	        a.ShippingPostalCode = '64012';
	        a.ShippingStreet = '7900 E 159th St';
	        
	        insert a;
	        
	        Contact ct = new Contact();
	        ct.AccountId = a.Id;
	        ct.FirstName = 'Dean';
	        ct.LastName = 'Martin';
	        ct.Phone = '9999999999';
	        
	        insert ct;
	        
	        Opportunity opp = new Opportunity();
	        opp.AccountId = a.Id;
	        opp.Name = 'Test Price Adjustment';
	        opp.Deal_Contact__c = ct.Id;
	        opp.CloseDate = system.today();
	        opp.StageName = 'Prospect';
	        opp.Type = 'New Business';
	        opp.Salesperson__c = userinfo.getUserId();
	        opp.RecordTypeId = '01270000000Q7t7';
	        opp.TryCatchTest__c = true;
	        
	        insert opp;
	        
	        string prodName = 'CRM';
	        
	        Product2 p = new Product2();
	        p.Name = 'CRM';
	        p.Quantity_Exception__c = true;
	        p.IsTraining__c = true;
	        p.ExpPaidByDealer__c = true;
	        p.ProdProj_Default_Owner__c = userinfo.getUserId();
	        p.Description = 'website';
	        p.IsPackageParent__c = true;
	        p.Production_Department__c = 'creative';
	        p.Production_Issue__c = 'website';
	        p.requiresWelcomePacket__c = false;
	        p.Family = 'Reoccuring';
	        p.Package_Discount_Percentage__c = .55;
	        
	        insert p;
	        
	        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE Name='Standard Price Book' limit 1];
	        
	        PricebookEntry pbe = new PricebookEntry();
	        pbe.UnitPrice = 10000.00;
	        pbe.Pricebook2Id = pb.Id;
	        pbe.Product2Id = p.Id;
	        pbe.IsActive = true;
	        
	        insert pbe;
	        
	        OpportunityLineItem oli = new OpportunityLineItem();
	        oli.PricebookEntryId = pbe.Id;
	        oli.OpportunityId = opp.Id;
	        oli.Quantity = 1;
	        oli.ValidationRules__c = true;
	        oli.TotalPrice = 10000.00;
	        
	        //insert oli;
	        
	        opp.Opportunity_Names__c = 'Hardware';
	        opp.StageName = 'Negotiation/Review';
	        opp.Implementation_Contact__c = ct.Id;
	        opp.Deal_Contact__c = ct.Id;
	        //opp.We_Owe__c = 'N/A';
	        opp.Amount = 10000.00;
	        
	        //update opp;
	        
	        
	        ApexPages.Standardcontroller sc = new ApexPages.StandardController(opp);
	        ApexPages.currentPage().getParameters().put('oppId', opp.Id);
	        Opp_PriceAdjustment opa = new Opp_PriceAdjustment(sc);
	        
	        test.startTest();
	        opa.getIncDec();
	        opa.getPerFlat();
	        opa.typeChange();
	        
	        opa.typeOfAdjustment = 'Decrease';
	        opa.typeOfRate = 'Percentage';
	        opa.rateType();
	        
	        opa.typeOfAdjustment = 'Decrease';
	        opa.typeOfRate = 'Flat';
	        opa.rateType();
	        
	        opa.typeOfAdjustment = 'Increase';
	        opa.typeOfRate = 'Percentage';
	        opa.rateType();
	        
	        opa.typeOfAdjustment = 'Increase';
	        opa.typeOfRate = 'Flat';
	        opa.rateType();
	        
	        opa.returnToOpp();
	        
	        test.stopTest();
       // }
    }
    
    static testMethod void testCalculations() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
          emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
          localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
          timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
          
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
            
	        Account a = new Account();
	        a.Name = 'TestPriceAdjustment';
	        a.ShippingCity = 'Belton';
	        a.ShippingStreet = '7900 E 159th St';
	        a.ShippingState = 'MO';
	        a.AccountNumber = '565656565656';
	        a.BillingState = 'MO';
	        a.BillingCity = 'Belton';
	        a.BillingCountry = 'USA';
	        a.BillingPostalCode = '64012';
	        a.BillingStreet = '7900 E 159th St';
	        	        a.ShippingState = 'MO';
	        a.ShippingCity = 'Belton';
	        a.ShippingCountry = 'USA';
	        a.ShippingPostalCode = '64012';
	        a.ShippingStreet = '7900 E 159th St';
	        
	        insert a;
	        
	        Contact ct = new Contact();
	        ct.AccountId = a.Id;
	        ct.FirstName = 'Dean';
	        ct.LastName = 'Martin';
	        ct.Phone = '9999999999';
	        
	        insert ct;
	        
	        Opportunity opp = new Opportunity();
	        opp.AccountId = a.Id;
	        opp.Name = 'Test Price Adjustment';
	        opp.Deal_Contact__c = ct.Id;
	        opp.CloseDate = system.today();
	        opp.StageName = 'Prospect';
	        opp.Type = 'New Business';
	        opp.Salesperson__c = userinfo.getUserId();
	        opp.RecordTypeId = '01270000000Q7t7';
	        opp.TryCatchTest__c = true;
	        
	        insert opp;
	        
	        string prodName = 'CRM';
	        
	        Product2 p = new Product2();
	      	p.Name = 'Platimum 1 Package';
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
	        
	        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE Name='Standard Price Book' limit 1];
	        
	        PricebookEntry pbe = new PricebookEntry();
	        pbe.UnitPrice = 10000.00;
	        pbe.Pricebook2Id = pb.Id;
	        pbe.Product2Id = p.Id;
	        pbe.IsActive = true;
	        
	        insert pbe;
	        
	        OpportunityLineItem oli = new OpportunityLineItem();
	        oli.PricebookEntryId = pbe.Id;
	        oli.OpportunityId = opp.Id;
	        oli.Quantity = 1;
	        oli.ValidationRules__c = true;
	        oli.TotalPrice = 10000.00;
	        //oli.Setup_Fee__c = true;
	        
	        insert oli;
	        
	        OpportunityLineItem oli1 = new OpportunityLineItem();
	        oli1.PricebookEntryId = pbe.Id;
	        //oli.PricebookEntryId = '01s70000000MZ4f';
	        oli1.OpportunityId = opp.Id;
	        oli1.Quantity = 1;
	        oli1.TotalPrice = 1000;
	        oli1.ValidationRules__c = true;
	        oli1.Setup_Fee__c = true;
	        
	        insert oli1;
	        
	        opp.Opportunity_Names__c = 'Hardware';
	        opp.StageName = 'Negotiation/Review';
	        opp.Implementation_Contact__c = ct.Id;
	        opp.Deal_Contact__c = ct.Id;
	        //opp.We_Owe__c = 'N/A';
	        opp.Amount = 10000.00;
	        
	        update opp;
        
	        ApexPages.Standardcontroller sc = new ApexPages.StandardController(opp);
	        ApexPages.currentPage().getParameters().put('oppId', opp.Id);
	        Opp_PriceAdjustment opa = new Opp_PriceAdjustment(sc);
	        
	        test.startTest();
	        
	        opa.mrrPercent = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.trainPercent = 10.00;
	        opa.calculateDecPer();
	        
	        opa.mrrPercent = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.trainPercent = 10.00;
	        opa.calculateIncPer();
	        
	        opa.mrrFlat = 100.00;
	        opa.oneTimeFlat = 100.00;
	        opa.setUpFlat = 100.00;
	        opa.trainFlat = 100.00;
	        opa.calculateDecFlat();
	        
	        opa.mrrFlat = 100.00;
	        opa.oneTimeFlat = 100.00;
	        opa.setUpFlat = 100.00;
	        opa.trainFlat = 100;
	        opa.calculateIncFlat();
	        
	        opa.totalPercentageIncrease();
	        opa.mrrph2 = 1;
	        
	        opa.totalPercentageDiscount();
	        opa.mrrph2 = opa.oppInfo.Monthly_Recurring_Fees__c;
	        opa.suph2 = opa.oppInfo.Setup_Fees__c;
	        opa.totalPercentageDiscount();
	        opa.totalFlatDiscount();
	        opa.totalFlatIncrease();
	        opa.realTimeTotalFlatIncrease();
	        
	        opa.totalPercentageDiscount();
	        opa.mrrph2 = opa.oppInfo.Monthly_Recurring_Fees__c + 100;
	        opa.suph2 = opa.oppInfo.Setup_Fees__c + 100;
	        opa.otph2 = opa.oppInfo.One_Time_Fees2__c + 100;
	        opa.trph2 = opa.oppInfo.Total_Training__c + 100;
	        opa.totalPercentageDiscount();
	        opa.totalFlatDiscount();
	        opa.totalFlatIncrease();
	        opa.realTimeTotalFlatIncrease();
	        opa.realTimeTotalFlatDiscount();
	        opa.totalPercentageIncrease();
	        opa.realTimeTotalPercentageIncrease();
	        
	        opa.mrrph2 = 1;
	        opa.realTimeTotalDiscountPercentage();
	        opa.totalPercentageDiscount();
	        
	        test.stopTest();
        //}
    }
    
    static testMethod void testSubmits() {
        
       /* Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
          emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
          localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
          timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
          
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
            
	        Account a = new Account();
	        a.Name = 'TestPriceAdjustment';
	        a.ShippingCity = 'Belton';
	        a.ShippingStreet = '7900 E 159th St';
	        a.ShippingState = 'MO';
	        a.AccountNumber = '565656565656';
	        a.BillingState = 'MO';
	        a.BillingCity = 'Belton';
	        a.BillingCountry = 'USA';
	        a.BillingPostalCode = '64012';
	        a.BillingStreet = '7900 E 159th St';
	        	        a.ShippingState = 'MO';
	        a.ShippingCity = 'Belton';
	        a.ShippingCountry = 'USA';
	        a.ShippingPostalCode = '64012';
	        a.ShippingStreet = '7900 E 159th St';
	        
	        insert a;
	        
	        Contact ct = new Contact();
	        ct.AccountId = a.Id;
	        ct.FirstName = 'Dean';
	        ct.LastName = 'Martin';
	        ct.Phone = '9999999999';
	        
	        insert ct;
	        
	        Opportunity opp = new Opportunity();
	        opp.AccountId = a.Id;
	        opp.Name = 'Test Price Adjustment';
	        opp.Deal_Contact__c = ct.Id;
	        opp.CloseDate = system.today();
	        opp.StageName = 'Prospect';
	        opp.Type = 'New Business';
	        opp.Salesperson__c = userinfo.getUserId();
	        opp.RecordTypeId = '01270000000Q7t7';
	        opp.TryCatchTest__c = true;
	        
	        insert opp;
	        
	        string prodName = 'CRM';
	        
	        Product2 p = new Product2();
	        p.Name = 'Platimum 1 Package';
	        p.Quantity_Exception__c = true;
	        p.IsTraining__c = true;
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
	        
	        Product2 pp = new Product2();
	        pp.Name = 'Bronze 1 Package';
	        pp.Quantity_Exception__c = true;
	        pp.IsTraining__c = false;
	        //pp.ProductIsParent = 'T';
	        pp.ExpPaidByDealer__c = true;
	        pp.ProdProj_Default_Owner__c = userinfo.getUserId();
	        pp.Description = 'Bronze Package';
	        pp.IsPackageParent__c = true;
	        pp.Production_Department__c = 'package';
	        pp.Production_Issue__c = 'package';
	        pp.requiresWelcomePacket__c = false;
	        pp.Family = 'Monthly Reoccuring';
	        pp.Package_Discount_Percentage__c = .79;
	        
	        insert pp;
	        
	        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE Name='Standard Price Book' limit 1];
	        
	        PricebookEntry pbe = new PricebookEntry();
	        pbe.UnitPrice = 10000.00;
	        pbe.Pricebook2Id = pb.Id;
	        pbe.Product2Id = p.Id;
	        pbe.IsActive = true;
	        
	        insert pbe;
	        
	        PricebookEntry pbe1 = new PricebookEntry();
	        pbe1.UnitPrice = 5999.99;
	        pbe1.Pricebook2Id = pb.Id;
	        pbe1.Product2Id = pp.Id;
	        pbe1.IsActive = true;
	        
	        insert pbe1;
	        
	        OpportunityLineItem oli = new OpportunityLineItem();
	        oli.PricebookEntryId = pbe.Id;
	        //oli.PricebookEntryId = '01s70000000MZ4f';
	        oli.OpportunityId = opp.Id;
	        oli.Quantity = 1;
	        oli.ValidationRules__c = true;
	        oli.TotalPrice = 10000.00;
	        
	        //oli.Setup_Fee__c = true;
	        
	        insert oli;
	        
	        OpportunityLineItem oli1 = new OpportunityLineItem();
	        oli1.PricebookEntryId = pbe.Id;
	        oli1.OpportunityId = opp.Id;
	        oli1.Quantity = 1;
	        oli1.TotalPrice = 1000;
	        oli1.ValidationRules__c = true;
	        oli1.Setup_Fee__c = true;
	        
	        insert oli1;
	        
	        opp.Opportunity_Names__c = 'Hardware';
	        opp.StageName = 'Negotiation/Review';
	        opp.Implementation_Contact__c = ct.Id;
	        opp.Deal_Contact__c = ct.Id;
	        //opp.We_Owe__c = 'N/A';
	        opp.Amount = 10000.00;
	        
	        //update opp;
        
	        ApexPages.Standardcontroller sc = new ApexPages.StandardController(opp);
	        ApexPages.currentPage().getParameters().put('oppId', opp.Id);
	        Opp_PriceAdjustment opa = new Opp_PriceAdjustment(sc);
	        
	        test.startTest();
	        
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.mrrDPCPH = 1;
	        opa.mrrph2 = 1;
	        opa.returnToOppSubDecPer();
	        
	         opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.mrrDPCPH = 0;
	        opa.mrrph2 = 1;
	        
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.mrrDPCPH = 1;
	        //opa.otDPCPH = 1;
	        //opa.otph = 1;
	        opa.suDPCPH = 1;
	        opa.suph = 1;
	        opa.suph2 = 10000;
	        //opa.trDPCPH = 1;
	        
	        opa.mrrph2 = 10000;
	        opa.returnToOppSubDecPer();
	        
	      opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.mrrDPCPH = 1;
	        //opa.otDPCPH = 1;
	        //opa.otph = 1;
	        opa.suDPCPH = 1;
	        opa.suph = 1;
	        opa.suph2 = opa.oppInfo.Setup_Fees__c;
	        //opa.trDPCPH = 1;
	        
	        opa.mrrph2 = 10000;
	        opa.returnToOppSubDecPer();
	        
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.returnToOppSubIncPer();
	        
	        opa.mrrph2 = 10000;
	        opa.returnToOppSubDecPer();
	        
	        opa.mrrDPCPH = 1;
	        opa.mrrph2 = 1;
	        opa.suph2 = 1;
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.returnToOppSubIncPer();
	        
	        opa.mrrDPCPH = 0;
	        opa.suDPCPH = 0;
	        opa.mrrph2 = 1;
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.returnToOppSubIncPer();
	        
	        opa.mrrFlat = 100;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        //opa.returnToOppSubDecFlat();
	        
	        opa.mrrFlat = 100;
	        opa.mrrDPCPH = 1;
	        opa.suDPCPH = 1;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        //opa.returnToOppSubDecFlat();
	        
	        opa.mrrFlat = 100;
	        opa.mrrph2 = 10000;
	        opa.suph2 = opa.oppInfo.Setup_Fees__c;
	        opa.mrrDPCPH = 1;
	        opa.suDPCPH = 1;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        //opa.returnToOppSubDecFlat();
	        
	        /*opa.mrrFlat = 100;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubIncFlat();
	        
	        /*opa.mrrFlat = 100;
	        opa.mrrDPCPH = 1;
	        opa.suDPCPH = 1;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubIncFlat();
	        
	        opa.mrrFlat = 100;
	        opa.mrrph2 = 10000;
	        opa.suph2 = opa.oppInfo.Setup_Fees__c;
	        opa.mrrDPCPH = 1;
	        opa.suDPCPH = 1;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubIncFlat();*/

	        //opa.totalPercentageDiscount();
	        
	        test.stopTest();
	        
        //}
    }
    
    static testMethod void testSubmitsInc() {
        
        User u_testMethodUser = TestData.setupUser();
        
        System.runas(u_testMethodUser) {
            
	        Account a = new Account();
	        a.Name = 'TestPriceAdjustment';
	        a.ShippingCity = 'Belton';
	        a.ShippingStreet = '7900 E 159th St';
	        a.ShippingState = 'MO';
	        a.AccountNumber = '565656565656';
	        a.BillingState = 'MO';
	        a.BillingCity = 'Belton';
	        a.BillingCountry = 'USA';
	        a.BillingPostalCode = '64012';
	        a.BillingStreet = '7900 E 159th St';
	        	        a.ShippingState = 'MO';
	        a.ShippingCity = 'Belton';
	        a.ShippingCountry = 'USA';
	        a.ShippingPostalCode = '64012';
	        a.ShippingStreet = '7900 E 159th St';
	        
	        insert a;
	        
	        Contact ct = new Contact();
	        ct.AccountId = a.Id;
	        ct.FirstName = 'Dean';
	        ct.LastName = 'Martin';
	        ct.Phone = '9999999999';
	        
	        insert ct;
	        
	        Opportunity opp = new Opportunity();
	        opp.AccountId = a.Id;
	        opp.Name = 'Test Price Adjustment';
	        opp.Deal_Contact__c = ct.Id;
	        opp.CloseDate = system.today();
	        opp.StageName = 'Prospect';
	        opp.Type = 'New Business';
	        opp.Salesperson__c = userinfo.getUserId();
	        opp.RecordTypeId = '01270000000Q7t7';
	        opp.TryCatchTest__c = true;

	        
	        insert opp;
	        
	        string prodName = 'CRM';
	        
	        Product2 p = new Product2();
	        p.Name = 'Platimum 1 Package';
	        p.Quantity_Exception__c = true;
	        p.IsTraining__c = true;
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
	        
	        Product2 pp = new Product2();
	        pp.Name = 'Bronze 1 Package';
	        pp.Quantity_Exception__c = true;
	        pp.IsTraining__c = false;
	        //pp.ProductIsParent = 'T';
	        pp.ExpPaidByDealer__c = true;
	        pp.ProdProj_Default_Owner__c = userinfo.getUserId();
	        pp.Description = 'Bronze Package';
	        pp.IsPackageParent__c = true;
	        pp.Production_Department__c = 'package';
	        pp.Production_Issue__c = 'package';
	        pp.requiresWelcomePacket__c = false;
	        pp.Family = 'Monthly Reoccuring';
	        pp.Package_Discount_Percentage__c = .79;
	        
	        insert pp;
	        
	        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE Name='Standard Price Book' limit 1];
	        
	        PricebookEntry pbe = new PricebookEntry();
	        pbe.UnitPrice = 10000.00;
	        pbe.Pricebook2Id = pb.Id;
	        pbe.Product2Id = p.Id;
	        pbe.IsActive = true;

	        
	        insert pbe;
	        
	        PricebookEntry pbe1 = new PricebookEntry();
	        pbe1.UnitPrice = 5999.99;
	        pbe1.Pricebook2Id = pb.Id;
	        pbe1.Product2Id = pp.Id;
	        pbe1.IsActive = true;
	        
	        insert pbe1;
	        
	        OpportunityLineItem oli = new OpportunityLineItem();
	        oli.PricebookEntryId = pbe.Id;
	        //oli.PricebookEntryId = '01s70000000MZ4f';
	        oli.OpportunityId = opp.Id;
	        oli.Quantity = 1;
	        oli.ValidationRules__c = true;
	        oli.TotalPrice = 10000.00;

	        
	        //oli.Setup_Fee__c = true;
	        
	        insert oli;
	        
	        OpportunityLineItem oli1 = new OpportunityLineItem();
	        oli1.PricebookEntryId = pbe.Id;
	        oli1.OpportunityId = opp.Id;
	        oli1.Quantity = 1;
	        oli1.ValidationRules__c = true;
	        oli1.TotalPrice = 1000;
	        oli1.Setup_Fee__c = true;
	        //oli1.Product_Family_Workflow__c = 'Setup fee';
	        
	        Database.SaveResult SR1 = Database.insert(oli1);
	        
	        opp.Opportunity_Names__c = 'Hardware';
	        opp.StageName = 'Negotiation/Review';
	        opp.Implementation_Contact__c = ct.Id;
	        opp.Deal_Contact__c = ct.Id;
	        //opp.We_Owe__c = 'N/A';
	        opp.Amount = 10000.00;


	        
	        //update opp;
        	system.debug('=========================================>>>>>>> opp.Id = ' + opp.Id);
	        ApexPages.Standardcontroller sc = new ApexPages.StandardController(opp);
	        ApexPages.currentPage().getParameters().put('oppId', opp.Id);
	        Opp_PriceAdjustment opa = new Opp_PriceAdjustment(sc);
	        
	        test.startTest();
	        
	        opa.otph2 = 112233;
	        opa.totalsDisablePriceChange();
	        
	        /*opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.mrrDPCPH = 1;
	        opa.mrrph2 = 1;
	        opa.returnToOppSubDecPer();
	        
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.mrrDPCPH = 1;
	        //opa.otDPCPH = 1;
	        //opa.otph = 1;
	        opa.suDPCPH = 1;
	        opa.suph = 1;
	        opa.suph2 = 10000;
	        //opa.trDPCPH = 1;
	        
	        opa.mrrph2 = 10000;
	        opa.returnToOppSubDecPer();
	        
	     	opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.mrrDPCPH = 1;
	        //opa.otDPCPH = 1;
	        //opa.otph = 1;
	        opa.suDPCPH = 1;
	        opa.suph = 1;
	        opa.suph2 = opa.oppInfo.Setup_Fees__c;
	        //opa.trDPCPH = 1;
	        
	        opa.mrrph2 = 10000;
	        opa.returnToOppSubDecPer();
	        
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.returnToOppSubIncPer();
	        
	        opa.mrrph2 = 10000;
	        opa.returnToOppSubDecPer();
	        
	        opa.mrrDPCPH = 1;
	        opa.mrrph2 = 1;
	        opa.suph2 = 1;
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.returnToOppSubIncPer();
	        
	        opa.mrrDPCPH = 0;
	        opa.suDPCPH = 0;
	        opa.mrrph2 = 1;
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.returnToOppSubIncPer();
	        
	        opa.mrrFlat = 100;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubDecFlat();
	        
	        opa.mrrFlat = 100;
	        opa.mrrDPCPH = 1;
	        opa.suDPCPH = 1;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubDecFlat();
	        
	        opa.mrrFlat = 100;
	        opa.mrrph2 = 10000;
	        opa.suph2 = opa.oppInfo.Setup_Fees__c;
	        opa.mrrDPCPH = 1;
	        opa.suDPCPH = 1;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubDecFlat();*/

	        opa.mrrFlat = 100;
	        opa.mrrDPCPH = 1;
	        opa.suDPCPH = 1;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        //opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubIncFlat();
	        
	        opa.mrrFlat = 100;
	        opa.mrrph2 = 10000;
	        opa.suph2 = opa.oppInfo.Setup_Fees__c;
	        opa.mrrDPCPH = 1;
	        opa.suDPCPH = 1;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        //opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubIncFlat();
			
			//opa.totalPercentageDiscount();
			opa.resetDecPer();
			opa.resetDecFlat();
			opa.resetIncPer();
			opa.resetIncFlat();
			
	        
	        test.stopTest();
	        
        }
    }
    
    static testMethod void testCalculationsMore() {
        /*
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
          emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
          localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
          timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
          
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
            
	        Account a = new Account();
	        a.Name = 'TestPriceAdjustment';
	        a.ShippingCity = 'Belton';
	        a.ShippingStreet = '7900 E 159th St';
	        a.ShippingState = 'MO';
	        a.AccountNumber = '565656565656';
	        a.BillingState = 'MO';
	        a.BillingCity = 'Belton';
	        a.BillingCountry = 'USA';
	        a.BillingPostalCode = '64012';
	        a.BillingStreet = '7900 E 159th St';
	        	        a.ShippingState = 'MO';
	        a.ShippingCity = 'Belton';
	        a.ShippingCountry = 'USA';
	        a.ShippingPostalCode = '64012';
	        a.ShippingStreet = '7900 E 159th St';
	        
	        insert a;
	        
	        Contact ct = new Contact();
	        ct.AccountId = a.Id;
	        ct.FirstName = 'Dean';
	        ct.LastName = 'Martin';
	        ct.Phone = '9999999999';
	        
	        insert ct;
	        
	        Opportunity opp = new Opportunity();
	        opp.AccountId = a.Id;
	        opp.Name = 'Test Price Adjustment';
	        opp.Deal_Contact__c = ct.Id;
	        opp.CloseDate = system.today();
	        opp.StageName = 'Prospect';
	        opp.Type = 'New Business';
	        opp.Salesperson__c = userinfo.getUserId();
	        opp.RecordTypeId = '01270000000Q7t7';
	        opp.TryCatchTest__c = true;
	        
	        insert opp;
	        
	        string prodName = 'CRM';
	        
	        Product2 p = new Product2();
	      	p.Name = 'Platinum 1 Package';
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
	        
	        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE Name='Standard Price Book' limit 1];
	        
	        PricebookEntry pbe = new PricebookEntry();
	        pbe.UnitPrice = 10000.00;
	        pbe.Pricebook2Id = pb.Id;
	        pbe.Product2Id = p.Id;
	        pbe.IsActive = true;
	        
	        insert pbe;
	        
	        OpportunityLineItem oli = new OpportunityLineItem();
	        oli.PricebookEntryId = pbe.Id;
	        oli.OpportunityId = opp.Id;
	        oli.Quantity = 1;
	        oli.ValidationRules__c = true;
	        oli.TotalPrice = 10000.00;
	        //oli.Setup_Fee__c = true;
	        
	        insert oli;
	        
	        OpportunityLineItem oli1 = new OpportunityLineItem();
	        oli1.PricebookEntryId = pbe.Id;
	        //oli.PricebookEntryId = '01s70000000MZ4f';
	        oli1.OpportunityId = opp.Id;
	        oli1.Quantity = 1;
	        oli1.ValidationRules__c = true;
	        oli1.TotalPrice = 1000;
	        oli1.Setup_Fee__c = true;
	        
	        insert oli1;
	        
	        opp.Opportunity_Names__c = 'Hardware';
	        opp.StageName = 'Negotiation/Review';
	        opp.Implementation_Contact__c = ct.Id;
	        opp.Deal_Contact__c = ct.Id;
	        //opp.We_Owe__c = 'N/A';
	        opp.Amount = 10000.00;
	        
	        update opp;
        
	        ApexPages.Standardcontroller sc = new ApexPages.StandardController(opp);
	        ApexPages.currentPage().getParameters().put('oppId', opp.Id);
	        Opp_PriceAdjustment opa = new Opp_PriceAdjustment(sc);
	        
	        test.startTest();
	        
	        opa.mrrph2 = 1;
	        opa.suph2 = 1;
	        opa.totalFlatDiscount();
	        opa.mrrFlat = 100;
	        opa.setUpFlat = 100;
	        opa.realTimeTotalFlatDiscount();
	        opa.totalPercentageDiscount();
	        
	        
	        test.stopTest();
        //}
    }
    
     static testMethod void moreTests() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
          emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
          localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
          timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
          
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
            
	        Account a = new Account();
	        a.Name = 'TestPriceAdjustment';
	        a.ShippingCity = 'Belton';
	        a.ShippingStreet = '7900 E 159th St';
	        a.ShippingState = 'MO';
	        a.AccountNumber = '565656565656';
	        a.BillingState = 'MO';
	        a.BillingCity = 'Belton';
	        a.BillingCountry = 'USA';
	        a.BillingPostalCode = '64012';
	        a.BillingStreet = '7900 E 159th St';
	        	        a.ShippingState = 'MO';
	        a.ShippingCity = 'Belton';
	        a.ShippingCountry = 'USA';
	        a.ShippingPostalCode = '64012';
	        a.ShippingStreet = '7900 E 159th St';
	        
	        insert a;
	        
	        Contact ct = new Contact();
	        ct.AccountId = a.Id;
	        ct.FirstName = 'Dean';
	        ct.LastName = 'Martin';
	        ct.Phone = '9999999999';
	        
	        insert ct;
	        
	        Opportunity opp = new Opportunity();
	        opp.AccountId = a.Id;
	        opp.Name = 'Test Price Adjustment';
	        opp.Deal_Contact__c = ct.Id;
	        opp.CloseDate = system.today();
	        opp.StageName = 'Prospect';
	        opp.Type = 'New Business';
	        opp.Salesperson__c = userinfo.getUserId();
	        opp.RecordTypeId = '01270000000Q7t7';
	        opp.TryCatchTest__c = true;
	        
	        insert opp;
	        
	        string prodName = 'CRM';
	        
	        Product2 p = new Product2();
	      	p.Name = 'Platimum 1 Package';
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
	        
	        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE Name='Standard Price Book' limit 1];
	        
	        PricebookEntry pbe = new PricebookEntry();
	        pbe.UnitPrice = 10000.00;
	        pbe.Pricebook2Id = pb.Id;
	        pbe.Product2Id = p.Id;
	        pbe.IsActive = true;
	        
	        insert pbe;
	        
	        OpportunityLineItem oli = new OpportunityLineItem();
	        oli.PricebookEntryId = pbe.Id;
	        oli.OpportunityId = opp.Id;
	        oli.Quantity = 1;
	        oli.ValidationRules__c = true;
	        oli.TotalPrice = 10000.00;
	        //oli.Setup_Fee__c = true;
	        
	        insert oli;
	        
	        OpportunityLineItem oli1 = new OpportunityLineItem();
	        oli1.PricebookEntryId = pbe.Id;
	        //oli.PricebookEntryId = '01s70000000MZ4f';
	        oli1.OpportunityId = opp.Id;
	        oli1.Quantity = 1;
	        oli1.TotalPrice = 1000;
	        oli1.ValidationRules__c = true;
	        oli1.Setup_Fee__c = true;
	        
	        insert oli1;
	        
	        opp.Opportunity_Names__c = 'Hardware';
	        opp.StageName = 'Negotiation/Review';
	        opp.Implementation_Contact__c = ct.Id;
	        opp.Deal_Contact__c = ct.Id;
	        //opp.We_Owe__c = 'N/A';
	        opp.Amount = 10000.00;
	        
	        update opp;
        
	        ApexPages.Standardcontroller sc = new ApexPages.StandardController(opp);
	        ApexPages.currentPage().getParameters().put('oppId', opp.Id);
	        Opp_PriceAdjustment opa = new Opp_PriceAdjustment(sc);
	        
	        test.startTest();
	        
	        opa.mrrph2 = 1;
	        opa.suph2 = 1;
	        opa.totalFlatDiscount();
	        opa.mrrFlat = 100;
	        opa.setUpFlat = 100;
	        opa.realTimeTotalFlatDiscount();
	        opa.totalPercentageDiscount();
	        
	        
	        opa.mrrPercent = 10.00;
	        opa.mrrPercentPH = 10.00;
	        opa.oneTimePercent = 10.00;
	        opa.oneTimePercentPh = 10.00;
	        opa.setUpPercent = 10.00;
	        opa.setUpPercentPH = 10.00;
	        opa.trainPercent = 10.00;
	        opa.trainPercentPH = 10.00;
	        opa.mrrDPCPH = 1;
	        opa.mrrph2 = 1;
	        opa.otDPCPH = 1;
	        opa.trDPCPH = 1;
	        opa.trph2 = opa.oppInfo.Total_Training__c;
	        opa.otph = 1;
	        opa.otph2 = opa.oppInfo.One_Time_Fees2__c;
	        opa.submitDecPer();
	        test.stopTest();
	        
       // }
        
     }

    static testMethod void testSubmitsInc2() {
        
        User u_testMethodUser = TestData.setupUser();
        
        System.runas(u_testMethodUser) {
            
	        Account a = new Account();
	        a.Name = 'TestPriceAdjustment';
	        a.ShippingCity = 'Belton';
	        a.ShippingStreet = '7900 E 159th St';
	        a.ShippingState = 'MO';
	        a.AccountNumber = '565656565656';
	        a.BillingState = 'MO';
	        a.BillingCity = 'Belton';
	        a.BillingCountry = 'USA';
	        a.BillingPostalCode = '64012';
	        a.BillingStreet = '7900 E 159th St';
	        	        a.ShippingState = 'MO';
	        a.ShippingCity = 'Belton';
	        a.ShippingCountry = 'USA';
	        a.ShippingPostalCode = '64012';
	        a.ShippingStreet = '7900 E 159th St';
	        
	        insert a;
	        
	        Contact ct = new Contact();
	        ct.AccountId = a.Id;
	        ct.FirstName = 'Dean';
	        ct.LastName = 'Martin';
	        ct.Phone = '9999999999';
	        
	        insert ct;
	        
	        Opportunity opp = new Opportunity();
	        opp.AccountId = a.Id;
	        opp.Name = 'Test Price Adjustment';
	        opp.Deal_Contact__c = ct.Id;
	        opp.CloseDate = system.today();
	        opp.StageName = 'Prospect';
	        opp.Type = 'New Business';
	        opp.Salesperson__c = userinfo.getUserId();
	        opp.RecordTypeId = '01270000000Q7t7';
	        opp.TryCatchTest__c = true;

	        
	        insert opp;
	        
	        string prodName = 'CRM';
	        
	        Product2 p = new Product2();
	        p.Name = 'Platimum 1 Package';
	        p.Quantity_Exception__c = true;
	        p.IsTraining__c = true;
	        p.ExpPaidByDealer__c = true;
	        p.ProdProj_Default_Owner__c = userinfo.getUserId();
	        p.Description = 'Email Banner';
	        p.IsPackageParent__c = false;
	        p.Production_Department__c = 'creative';
	        p.Production_Issue__c = 'email Banner';
	        p.requiresWelcomePacket__c = false;
	        p.Family = 'Setup fee';
	        p.Package_Discount_Percentage__c = .55;
	        
	        insert p;

	        Product2 p2 = TestData.getProduct();
	        p2.Family = 'Monthly Reoccuring';
	        /*
	        Product2 pp = new Product2();
	        pp.Name = 'CRM with Website Limited Users Package';
	        pp.Quantity_Exception__c = true;
	        //pp.ProductIsParent = 'T';
	        pp.ExpPaidByDealer__c = true;
	        pp.ProdProj_Default_Owner__c = userinfo.getUserId();
	        pp.Description = 'Bronze Package';
	        pp.IsPackageParent__c = true;
	        pp.Production_Department__c = 'package';
	        pp.Production_Issue__c = 'package';
	        pp.requiresWelcomePacket__c = false;
	        pp.Family = 'Monthly Reoccuring';
	        pp.Package_Discount_Percentage__c = .79;
	        */
	        insert p2;

	        Product2 p3 = TestData.getProduct();
	        p3.Family = 'One Time';
	        p3.IsTraining__c = true;
	        insert p3;
	        
	        Pricebook2 pb = [SELECT Id FROM Pricebook2 WHERE Name='Standard Price Book' limit 1];
	        
	        PricebookEntry pbe = new PricebookEntry();
	        pbe.UnitPrice = 10000.00;
	        pbe.Pricebook2Id = pb.Id;
	        pbe.Product2Id = p.Id;
	        pbe.IsActive = true;

	        
	        insert pbe;
	        
	        PricebookEntry pbe2 = new PricebookEntry();
	        pbe2.UnitPrice = 5999.99;
	        pbe2.Pricebook2Id = pb.Id;
	        pbe2.Product2Id = p2.Id;
	        pbe2.IsActive = true;
	        
	        insert pbe2;

	        PricebookEntry pbe3 = new PricebookEntry();
	        pbe3.UnitPrice = 5999.99;
	        pbe3.Pricebook2Id = pb.Id;
	        pbe3.Product2Id = p3.Id;
	        pbe3.IsActive = true;
	        insert pbe3;
	        
	        OpportunityLineItem oli = new OpportunityLineItem();
	        oli.PricebookEntryId = pbe2.Id;
	        //oli.PricebookEntryId = '01s70000000MZ4f';
	        oli.OpportunityId = opp.Id;
	        oli.Quantity = 1;
	        oli.ValidationRules__c = true;
	        oli.TotalPrice = 1000.00;

	        
	        //oli.Setup_Fee__c = true;
	        
	        insert oli;
	        
	        OpportunityLineItem oli1 = new OpportunityLineItem();
	        oli1.PricebookEntryId = pbe.Id;
	        oli1.OpportunityId = opp.Id;
	        oli1.Quantity = 1;
	        oli1.ValidationRules__c = true;
	        oli1.TotalPrice = 1000;
	        oli1.Setup_Fee__c = true;
	        
	        Database.SaveResult SR1 = Database.insert(oli1);

	        OpportunityLineItem oli3 = new OpportunityLineItem();
	        oli3.PricebookEntryId = pbe3.Id;
	        //oli.PricebookEntryId = '01s70000000MZ4f';
	        oli3.OpportunityId = opp.Id;
	        oli3.Quantity = 3;
	        oli3.ValidationRules__c = true;
	        oli3.TotalPrice = 10000.00;
	        insert oli3;
	        
	        opp.Opportunity_Names__c = 'Hardware';
	        opp.StageName = 'Negotiation/Review';
	        opp.Implementation_Contact__c = ct.Id;
	        opp.Deal_Contact__c = ct.Id;
	        //opp.We_Owe__c = 'N/A';
	        opp.Amount = 10000.00;


	        
	        //update opp;
        	system.debug('=========================================>>>>>>> opp.Id = ' + opp.Id);
	        ApexPages.Standardcontroller sc = new ApexPages.StandardController(opp);
	        ApexPages.currentPage().getParameters().put('oppId', opp.Id);
	        Opp_PriceAdjustment opa = new Opp_PriceAdjustment(sc);
	        
	        test.startTest();
	        
	        opa.otph2 = 112233;
	        opa.totalsDisablePriceChange();
	        opa.mrrFlat = 100;
	        opa.oneTimeFlat = opa.oppInfo.One_Time_Fees2__c;
	        opa.setUpFlat = 100;
	        opa.trainFlat = opa.oppInfo.Total_Training__c;
	        opa.returnToOppSubIncFlat();

	        opa.mrrFlat = 100.00;
	        opa.oneTimeFlat = 0;
	        opa.setUpFlat = 100.00;
	        opa.trainFlat = 100.00;
	        opa.calculateDecFlat();

	        opa.returnToOppSubDecFlat();
			
	        
	        test.stopTest();
	        
        }
    }

}