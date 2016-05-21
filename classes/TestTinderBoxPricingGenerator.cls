/***************************************************************************************************
Name        : TestTinderBoxPricingGenerator 
Created By  : TinderBox 
Email       : developer@tinderbox.com
Created Date: July 24, 2013
Description : Builds a multi-part pricing table based on specific conditions 
              for opportunity product records.
******************************************************************************************************/

@isTest(seeAllData=true)
private class TestTinderBoxPricingGenerator {
/*
    static testMethod void testListInsert() {
        List<Integer> ints = new List<Integer>();
        ints.add(1);
        ints.add(2);
        ints.add(3);

        ints.add(0, 4);
        System.assertEquals(4, ints.size());
        System.assertEquals(4, ints.get(0));
        System.assertEquals(1, ints.get(1));
        System.assertEquals(2, ints.get(2));
        System.assertEquals(3, ints.get(3));
    }
    
    static testMethod void testBuildPricingTable() {

        tinderbox__TinderBox__c oTinderBoxSettings = tinderbox__TinderBox__c.getInstance();
		oTinderBoxSettings.tinderbox__Generate_Custom_Pricing__c = true;
        oTinderBoxSettings.tinderbox__Pricing_HTML_Field__c = 'Triggered_Pricing_HTML__c';
//        update oTinderBoxSettings;

		// ---------- BEGIN SET UP ---------- //
        Pricebook2  standardPb = [select id, name, isActive from Pricebook2 where IsStandard = true limit 1];

		Pricebook2 pbk1 = new Pricebook2 (Name='Test Pricebook Entry 1',Description='Test Pricebook Entry 1', isActive=true);
		insert pbk1;

        Product2 p2 = new Product2(Name='Test Product',isActive=true);
        insert p2;
 
        PricebookEntry pbe = new PricebookEntry(Pricebook2Id=standardPb.Id, Product2Id=p2.Id, UnitPrice=99, isActive=true);
        insert pbe;

  		Opportunity opp  = new Opportunity(Name = 'Test Opportunity',
			CloseDate = System.today(), StageName = 'Prospect',
	        Pricebook2Id = pbe.Pricebook2Id);
		insert opp;

        // set up OpportunityLineItem and Verify that the results are as expected.
        OpportunityLineItem oli = new OpportunityLineItem(PriceBookEntryId=pbe.Id, OpportunityId=opp.Id, Quantity=1,
                                                          TotalPrice=99);
        insert oli;

        System.assertEquals(opp.CustomPricing__c, null);
        TinderBoxPricingGenerator.buildOpportunityPricingHTML(opp);
        System.debug(opp.CustomPricing__c);
        System.assertNotEquals(opp.CustomPricing__c, null);
    }
*/
}