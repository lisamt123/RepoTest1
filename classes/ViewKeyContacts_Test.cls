@isTest
private class ViewKeyContacts_Test {
	
	@isTest static void testPopulateRelatedList() {
		// Setup test data
		Account testAcct = TestData.setupAccount();
		insert testAcct;
		Contact testContact = TestData.setupContact(testAcct, 'vAuto');
		insert testContact;
		POA__c testPOA = TestData.setupPOA(testAcct, 'vAuto');
		insert testPOA;

		Test.startTest();

		Test.setCurrentPageReference(new PageReference('/'));
		ApexPages.currentPage().getParameters().put('id', testPOA.Id);
		ApexPages.StandardController controller = new ApexPages.StandardController(testPOA);
		ViewKeyContacts ctrl = new ViewKeyContacts(controller);
		
		system.assertNotEquals(ctrl.POAId, null);
		system.assertNotEquals(ctrl.poaObj, null);
		system.assertNotEquals(ctrl.poaAccount, null);
		system.assertNotEquals(ctrl.keyContacts, null);
		ctrl.Refresh();
		Test.stopTest();

	}
	
}