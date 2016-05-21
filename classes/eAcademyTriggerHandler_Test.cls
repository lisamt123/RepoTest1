@isTest
private class eAcademyTriggerHandler_Test {
	
	@isTest static void testWithMotoSnapIdSync() {
		Account testAccount = TestData.setupAccount();
		insert testAccount;
		Contact testContact = TestData.setupContact(testAccount, 'Shared');
		testContact.MotoSnap_User_Id__c = 'TestID';
		insert testContact;
		eAcademy__c testeAcademy = new eAcademy__c(Sort_ViewerInfo__c = 'Test, Johnny',
  														ViewerInfo__c = 'Test, Johnny',
  														Vin_User_ID__c = 'TestID',//Inserting a matching sync
										  				Dealership_Name__c = 'Test Dealership',
										  				Tracking_Code__c = 'Code',
										  				Date_Time__c = datetime.now(),
  														Sort_Title__c = 'Quick help',
										  				Sort3__c = 'Sorted',
										  				Viewing_Time__c = '35',
										  				View_Type__c = 'Test',
										  				View_Total_Pct_of_Duration__c = '50',
										  				View_Total_Slides_Viewed__c = '10',
										  				View_Total_Pct_of_Slides__c = '35',
										  				View_Total_Points__c = '20',
										  				View_Total_Score__c = '50');
		Database.SaveResult SR1 = Database.insert(testeAcademy);
		System.assert(true, SR1.isSuccess());

	}
	
	@isTest static void testWithOUTMotoSnapIdSync() {
		Account testAccount = TestData.setupAccount();
		insert testAccount;
		Contact testContact = TestData.setupContact(testAccount, 'Shared');
		testContact.MotoSnap_User_Id__c = 'TestID';
		insert testContact;
		eAcademy__c testeAcademy = new eAcademy__c(Sort_ViewerInfo__c = 'Test, Johnny',
  														ViewerInfo__c = 'Test, Johnny',
  														Vin_User_ID__c = 'IDTest', //Inserting a non-matching sync
										  				Dealership_Name__c = 'Test Dealership',
										  				Tracking_Code__c = 'Code',
										  				Date_Time__c = datetime.now(),
  														Sort_Title__c = 'Quick help',
										  				Sort3__c = 'Sorted',
										  				Viewing_Time__c = '35',
										  				View_Type__c = 'Test',
										  				View_Total_Pct_of_Duration__c = '50',
										  				View_Total_Slides_Viewed__c = '10',
										  				View_Total_Pct_of_Slides__c = '35',
										  				View_Total_Points__c = '20',
										  				View_Total_Score__c = '50');
		Database.SaveResult SR1 = Database.insert(testeAcademy);
		System.assert(true, SR1.isSuccess());
	}
	
}