@isTest
private class Contact_Test {
	
	@isTest static void test_SetvAutoAccount_Create_vAutoBUUser() {
		Account a = TestData.setupAccount();
		insert a;
		User u = TestData.setupUser();
		u.Business_Unit__c = 'VAT';
		update u;
		System.runAs(u){

			Contact c = TestData.setupContact(a, null);
			insert c;
			c = [Select Id, vAuto_Account__c , AccountId from Contact where Id=: c.Id];
			System.assert(c.vAuto_Account__c == c.AccountId,'vAuto_Account__c is not populated');
		}
	}

	@isTest static void test_SetvAutoAccount_Edit_vAutoBUUser() {
		Account a = TestData.setupAccount();
		insert a;
		User u = TestData.setupUser();
		u.Business_Unit__c = 'VAT';
		update u;
		Contact c = TestData.setupContact(a, null);
		insert c;
		//reset the vAuto_Account__c filed to test trigger funtionality for sure.
		c.vAuto_Account__c = null;
		update c;		
		System.runAs(u){
			c.FirstName = 'TestFirstNameChanged';
			update c;
			c = [Select Id, vAuto_Account__c , AccountId from Contact where Id=: c.Id];
			System.assert(c.vAuto_Account__c == c.AccountId,'vAuto_Account__c is not populated');
		}
	}

	@isTest static void test_SetvAutoAccount_Create_NonvAutoBUUser() {
		Account a = TestData.setupAccount();
		insert a;
		User u = TestData.setupUser();
		u.Business_Unit__c = 'VIN';
		update u;
		System.runAs(u){

			Contact c = TestData.setupContact(a, null);
			insert c;
			c = [Select Id, vAuto_Account__c , AccountId from Contact where Id=: c.Id];
			System.assert(c.vAuto_Account__c ==null,'vAuto_Account__c is not populated');
		}
	}

	@isTest static void test_SetvAutoAccount_Edit_NonvAutoBUUser() {
		Account a = TestData.setupAccount();
		insert a;
		User u = TestData.setupUser();
		u.Business_Unit__c = 'VIN';
		update u;
		Contact c = TestData.setupContact(a, null);
		insert c;
		//reset the vAuto_Account__c filed to test trigger funtionality for sure.
		c.vAuto_Account__c = null;
		update c;		
		System.runAs(u){
			c.FirstName = 'TestFirstNameChanged';
			update c;
			c = [Select Id, vAuto_Account__c , AccountId from Contact where Id=: c.Id];
			System.assert(c.vAuto_Account__c == null,'vAuto_Account__c is not populated');
		}
	}


	
}