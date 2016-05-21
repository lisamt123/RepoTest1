@isTest
private class handler_caseTrigger_Test {
	
	@isTest static void testInsertingCase() {
		Account testAccount = TestData.setupAccount();
		insert testAccount;
		Contact testContact = TestData.setupContact(testAccount, 'Shared');
		insert testContact;
		Case testCase = TestData.setupCase(testAccount, testContact);
		Database.SaveResult SR1 = Database.insert(testCase);
		System.assertEquals(true, SR1.isSuccess());
	}
	
	@isTest static void testInsertParentInsertUpdateChild() {
		Account testAccount = TestData.setupAccount();
		insert testAccount;
		Contact testContact = TestData.setupContact(testAccount, 'Shared');
		insert testContact;
		Case testParentCase = TestData.setupCase(testAccount, testContact);
		Database.SaveResult SR1 = Database.insert(testParentCase);

		Test.startTest();

		//insert child with parent
		Case testChildCase1 = TestData.setupCaseWithParent(testAccount, testContact, testParentCase);
		Database.SaveResult SR2 = Database.insert(testChildCase1);
		System.assertEquals(true, SR1.isSuccess());
		System.assertEquals(true, SR2.isSuccess());

		//insert child then update with parent
		Case testChildCase2 = TestData.setupCase(testAccount, testContact);
		Database.SaveResult SR3 = Database.insert(testChildCase2);
		System.assertEquals(true, SR3.isSuccess());
		testChildCase2.ParentId = SR1.getId();
		Database.UpsertResult UR1 = Database.upsert(testChildCase2);
		System.assertEquals(true, UR1.isSuccess());

		Test.stopTest();
	}

	@isTest static void testUpdateChildrenWithChangesToParent() {
		Account testAccount = TestData.setupAccount();
		insert testAccount;
		Contact testContact = TestData.setupContact(testAccount, 'Shared');
		insert testContact;
		Case testParentCase = TestData.setupCase(testAccount, testContact);
		Database.SaveResult SR1 = Database.insert(testParentCase);
		//insert children
		Case testChildCase1 = TestData.setupCaseWithParent(testAccount, testContact, testParentCase);
		Database.SaveResult SR2 = Database.insert(testChildCase1);
		Case testChildCase2 = TestData.setupCaseWithParent(testAccount, testContact, testParentCase);
		Database.SaveResult SR3 = Database.insert(testChildCase2);
		System.assertEquals(true, SR1.isSuccess());
		System.assertEquals(true, SR2.isSuccess());
		System.assertEquals(true, SR3.isSuccess());

		Test.startTest();

		testParentCase.Escalation_Type__c = 'Test Case';
		testParentCase.Escalate_To__c = 'Gatekeeper';
		testParentCase.Status = 'Escalate';
		testParentCase.Date_Escalated__c = date.Today();
		testParentCase.X1_What_is_happening__c = 'This a test.';
		testParentCase.X2_What_did_you_expect_to_happen__c = 'This a test.';
		testParentCase.X3_When_did_it_start_happening__c = 'This a test.';
		testParentCase.X4_What_do_you_think_the_problem_is__c = 'This a test.';
		testParentCase.X5_What_have_you_tried_so_far__c = 'This a test.';
		Database.UpsertResult UR1 = Database.upsert(testParentCase);
		System.assertEquals(true, UR1.isSuccess());

		Test.stopTest();
	}

	@isTest static void testvAutoCaseInsert() {
		Account testAccount = TestData.setupAccount();
		insert testAccount;
		Contact testContact = TestData.setupContact(testAccount, 'vAuto');
		insert testContact;
		Case testCase = TestData.setupCase(testAccount, testContact);
		testCase.RecordTypeId = StaticData.getInstance().CaseRecTypesMapByName.get('vAuto Support').Id;
		testCase.vAuto_Case_Reason__c = 'ADP Write Back';
		testCase.vAuto_Product_Line__c = 'Appraisal Tool';
		Database.SaveResult SR1 = Database.insert(testCase);
		System.assertEquals(true, SR1.isSuccess());
	}	

	@isTest static void testCaseWithTask() {
		Account testAccount = TestData.setupAccount();
		insert testAccount;
		Contact testContact = TestData.setupContact(testAccount, 'Shared');
		insert testContact;
		Case testCase = TestData.setupCase(testAccount, testContact);
		Database.SaveResult SR1 = Database.insert(testCase);
		System.assertEquals(true, SR1.isSuccess());
		Task testTask = TestData.setupTaskCase(testCase);
		testTask.Subject = 'Email: 0';
		Database.SaveResult SR2 = Database.insert(testTask);
		System.assertEquals(true, SR1.isSuccess());

		Test.startTest();

		//update the case to cover the task code
		Database.UpsertResult UR1 = Database.upsert(testCase);
		System.assertEquals(true, UR1.isSuccess());
		//update the task to get the last lines
		testTask.Subject = 'Resolve Notice Sent to Customer';
		Database.UpsertResult UR2 = Database.upsert(testTask);
		System.assertEquals(true, UR2.isSuccess());
		//update the case again to get the coverage
		//Note: I think this task code should be in the task trigger not the case
		Database.UpsertResult UR3 = Database.upsert(testCase);
		System.assertEquals(true, UR3.isSuccess());

		Test.stopTest();
	}
}