@isTest(SeeAllData=true)
private class vAutoSubscriberProductInfo_Test {
	
	@isTest static void test_method_one() {
		// Setup test data
		Integer DATA_SET_SIZE = 6;

		Account testAcct = TestData.setupAccount();
		testAcct.RecordType = [SELECT Id, Name FROM RecordType WHERE SobjectType='Account' AND Name = 'Dealer' LIMIT 1];
		insert testAcct;

		Contact testContact = TestData.setupContact();
		insert testContact;

		Opportunity testOpp = TestData.setupOpportunity(testAcct, testContact);
		insert testOpp;

		RecordType rt = [SELECT Id, Name FROM RecordType WHERE SobjectType='Contract' AND Name = 'ADD' LIMIT 1];
		Contract testContract = TestData.setupContract(testAcct, rt);
		testContract.Contract_Type__c = 'vAuto';
		insert testContract;

		List<Product2> productList = new List<Product2>();

		Product2 testProduct = TestData.getProduct();
		testProduct.Product_Suite__c = 'Auction Genius';
		testProduct.Base_Product__c = true;
		productList.add(testProduct);

		Product2 testProduct1 = TestData.getProduct();
		testProduct1.Product_Suite__c = 'Provision';
		testProduct1.Base_Product__c = true;
		productList.add(testProduct1);

		Product2 testProduct2 = TestData.getProduct();
		testProduct2.Product_Suite__c = 'Conquest';
		testProduct2.Base_Product__c = true;
		productList.add(testProduct2);

		Product2 testProduct3 = TestData.getProduct();
		testProduct3.Product_Suite__c = 'KBB PAR Used';
		testProduct3.Base_Product__c = true;
		productList.add(testProduct3);

		Product2 testProduct4 = TestData.getProduct();
		testProduct4.Product_Suite__c = 'KBB PAR New';
		testProduct4.Base_Product__c = true;
		productList.add(testProduct4);

		Product2 testProduct5 = TestData.getProduct();
		testProduct5.Product_Suite__c = 'Test';
		testProduct5.Base_Product__c = true;
		productList.add(testProduct5);

		insert productList;

        List<Billing_Item__c> biList = new List<Billing_Item__c>();
		RecordType rt2 = [SELECT Id, Name FROM RecordType WHERE SobjectType='Billing_Item__c' AND Name = 'ADD' LIMIT 1];
		for(Integer i = 0; i < DATA_SET_SIZE; i++) {
			biList.add(
				new Billing_Item__c(
					Contract__c = testContract.Id,
        			Product_Sold__c = productList[i].Id,
					Subscriber_Account__c = testAcct.Id,
					LOB_Status__c = 'Good',
					Legacy_Active_Date__c = System.today(),
					RecordType = rt2
				)
			);
		}
		insert biList;

		Test.startTest();

		Test.setCurrentPageReference(new PageReference('/'));
		ApexPages.currentPage().getParameters().put('id', testAcct.Id);
		ApexPages.StandardController controller = new ApexPages.StandardController(testAcct);
		vAutoSubscriberProductInfo ctrl = new vAutoSubscriberProductInfo(controller);
		system.assert(ctrl.numOfRows == 6);
		system.assert(ctrl.SAWrapList.size() == 5);



		Test.stopTest();
	}
}