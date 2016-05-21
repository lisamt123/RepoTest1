@isTest(SeeAllData=True)
private class DealerFeaturesWebService_test {

    static testMethod void myUnitTest() {
        
        /*Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {*/
       	
        	UnitTestUtilities__c testId = UnitTestUtilities__c.getValues('UnitTestIds');
        	String acctId = testId.UnitTestAccountId__c;

        	DealerFeaturesWebService controller = new DealerFeaturesWebService();
        	
        	
        	test.startTest();
        	
        	controller.accountId = acctId;
        	controller.updateAccount();
        	controller.updateAccountId();
        	controller.queryLineItems();
        	controller.assignPrice();
        	controller.rando();
        	
        	test.stopTest();
        //}
    }

    static testMethod void testJSONWrapper() {
        DealerFeaturesWebService.JSONWrapper jsonWrap = new DealerFeaturesWebService.JSONWrapper(0, '00DQ000000GJxlb', '00001', '1');
        System.assertEquals(jsonWrap.rowCount, 0);
        System.assertEquals(jsonWrap.salesforceId, '00DQ000000GJxlb');
        System.assertEquals(jsonWrap.invoiceItemId, '00001');
        System.assertEquals(jsonWrap.orderNumber, '1');
    }
}