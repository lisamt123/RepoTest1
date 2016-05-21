@isTest
private class eAcademyCustomerView_Test {
	
	@isTest static void test_method_one() {
		Account testAcct = TestData.setupAccount();
		insert testAcct;
		Contact testCon = TestData.setupContact(testAcct, 'VIN');
		testCon.FirstName = 'James';
		testCon.LastName = 'Bond';
		testCon.MotoSnap_User_Id__c = 'TestID';
		insert testCon;
		User testUser = TestData.setupUser('Vin Overage Customer Portal Manager', 'Customer');
		testUser.FirstName = 'James';
		testUser.LastName = 'Bond';
		testUser.ContactId = testCon.Id;
		insert testUser;
		User testUser2 = TestData.setupUser();
		testUser2.FirstName = 'James';
		testUser2.LastName = 'Bond';
		update testUser2;
		eAcademy__c eA1 = new eAcademy__c(Account_Name__c = testAcct.Id,
											Sort_ViewerInfo__c = 'Bond, James',
											ViewerInfo__c = 'Bond, James',
											Sort_Title__c = 'Test Class 1',
											View_Total_Score__c = '100',
											Vin_User_ID__c = 'TestID');
		insert eA1;
		eAcademy__c eA2 = new eAcademy__c(Account_Name__c = testAcct.Id,
											Sort_ViewerInfo__c = 'Bond, James',
											ViewerInfo__c = 'Bond, James',
											Sort_Title__c = 'Test Class 2',
											View_Total_Score__c = '90',
											Vin_User_ID__c = 'TestID');
		insert eA2;
		eAcademy__c eA3 = new eAcademy__c(Account_Name__c = testAcct.Id,
											Sort_ViewerInfo__c = 'Bond, James',
											ViewerInfo__c = 'Bond, James',
											Sort_Title__c = 'Test Class 3',
											View_Total_Score__c = '80',
											Vin_User_ID__c = 'TestID');
		insert eA3;

		Test.startTest();

		//As a portal user
		system.runAs(testUser){
			ApexPages.standardController controller;
			eAcademyCustomerView ctrl = new eAcademyCustomerView(controller);
			system.assertEquals(3, ctrl.eAcademyRLWrpList.size());
			ctrl.showMore();
			ApexPages.currentPage().getParameters().put('detailParam', eA1.Id);
			ctrl.showPopup();
			ctrl.closePopup();
			ctrl.searchInput = 'xyz';
			ctrl.search();
			ctrl.searchInput = 'Bond';
			ctrl.search();
			ctrl.cancelSearch();
		}

		//As an admin user
		system.runAs(testUser2){
			ApexPages.standardController controller;
			eAcademyCustomerView ctrl1 = new eAcademyCustomerView(controller);
			system.assertEquals(3, ctrl1.eAcademyRLWrpList.size());
		}

		Test.stopTest();

	}
	
}