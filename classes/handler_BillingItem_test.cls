@isTest(SeeAllData=true)
private class handler_BillingItem_test {
    public static testMethod void Test_MototosnapStop_Sucess() {
    	Account testAcct =TestData.setupAccount();
		insert testAcct;

		Contract testContract = TestData.setupContract(testAcct, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
		testContract.LOB__c = 'VINSOLUTIONS';
		testContract.Status = 'Draft';
		testContract.Vin_Dealer_Id__c = '5886';
		insert testContract;

		Billing_Item__c bl1 = TestData.setUpBillingItem(testContract, TestData.getProduct('700 Credit Inc','VinSolutions'));
		bl1.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('Process_Stop').Id;
		insert bl1;	

		Test.startTest();
		// Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MotosnapCalloutMock());
        TestData.isMotoSnapCalloutSuccess = true;

        // Updating the recordType on the Billing_Item__c causes the trigger to fire the HTTP.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
		bl1.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('CANCEL').Id;
		bl1.End_Date__c = system.today();
		Database.update(bl1);

		Test.stopTest();

		//Check if a succesful log was created with a success
		List<Billing_Log__c> logs = [Select Log_Status__c,Log_Message__c,Billing_Item__c from Billing_Log__c where Billing_Item__c=: bl1.Id];
		system.assertEquals('Processed', logs[0].Log_Status__c);
		system.assertNotEquals(logs[0].Log_Message__c, null);

    }
    public static testMethod void Test_MototosnapStop_Error() {
    	Account testAcct =TestData.setupAccount();
		insert testAcct;

		Contract testContract = TestData.setupContract(testAcct, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
		testContract.LOB__c = 'VINSOLUTIONS';
		testContract.Status = 'Draft';
		testContract.Vin_Dealer_Id__c = '5886';
		insert testContract;

		Billing_Item__c bl1 = TestData.setUpBillingItem(testContract, TestData.getProduct('700 Credit Inc','VinSolutions'));
		bl1.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('Process_Stop').Id;
		insert bl1;	

		Test.startTest();
		// Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MotosnapCalloutMock());
        TestData.isMotoSnapCalloutSuccess = false;
        TestData.isMotoSnapTimeOutError = true;

        // Updating the recordType on the Billing_Item__c causes the trigger to fire the HTTP.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
		bl1.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('CANCEL').Id;
		bl1.End_Date__c = system.today();
		Database.update(bl1);
		
		Test.stopTest();

		//Check if a succesful log was created with an error
		List<Billing_Log__c> logs = [Select Log_Status__c,Log_Message__c,Billing_Item__c from Billing_Log__c where Billing_Item__c=: bl1.Id];
		system.assertEquals('Error', logs[0].Log_Status__c);
		system.assertNotEquals(logs[0].Log_Message__c, null);

    }
    public static testMethod void Test_MototosnapActive_Error() {
		Account testAcct =TestData.setupAccount();
		insert testAcct;

		Contract testContract = TestData.setupContract(testAcct, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
		testContract.LOB__c = 'VINSOLUTIONS';
		testContract.Status = 'Draft';
		testContract.Vin_Dealer_Id__c = '5886';
		insert testContract;

		Billing_Item__c bl1 = TestData.setUpBillingItem(testContract, TestData.getProduct('700 Credit Inc','VinSolutions'));
		bl1.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id;
		insert bl1;	

		Test.startTest();
		// Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MotosnapCalloutMock());
        TestData.isMotoSnapCalloutSuccess = false;
        TestData.isMotoSnapTimeOutError = true;

        // Updating the recordType on the Billing_Item__c causes the trigger to fire the HTTP.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
		bl1.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('MODIFY').Id;
		Database.update(bl1);
		
		Test.stopTest();

		//Check if a succesful log was created with an error
		List<Billing_Log__c> logs = [Select Log_Status__c,Log_Message__c,Billing_Item__c from Billing_Log__c where Billing_Item__c=: bl1.Id];
		system.assertEquals('Error', logs[0].Log_Status__c);
		system.assertNotEquals(logs[0].Log_Message__c, null);
	}

    public static testMethod void Test_MototosnapActive_Success() {
    	Account testAcct =TestData.setupAccount();
		insert testAcct;

		Contract testContract = TestData.setupContract(testAcct, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
		testContract.LOB__c = 'VINSOLUTIONS';
		testContract.Status = 'Draft';
		testContract.Vin_Dealer_Id__c = '5886';
		insert testContract;

		Billing_Item__c bl1 = TestData.setUpBillingItem(testContract, TestData.getProduct('700 Credit Inc','VinSolutions'));
		bl1.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id;
		insert bl1;	

		Test.startTest();
		// Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new MotosnapCalloutMock());
        TestData.isMotoSnapCalloutSuccess = true;

        // Updating the recordType on the Billing_Item__c causes the trigger to fire the HTTP.
        // This causes a fake response to be sent
        // from the class that implements HttpCalloutMock. 
		bl1.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('MODIFY').Id;
		Database.update(bl1);

		Test.stopTest();

		//Check if a succesful log was created with a success
		List<Billing_Log__c> logs = [Select Log_Status__c,Log_Message__c,Billing_Item__c from Billing_Log__c where Billing_Item__c=: bl1.Id];
		system.assertEquals('Processed', logs[0].Log_Status__c);
		system.assertNotEquals(logs[0].Log_Message__c, null);

    }
}