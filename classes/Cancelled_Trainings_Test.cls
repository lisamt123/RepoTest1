@isTest
private class Cancelled_Trainings_Test {
	
	@isTest static void test_UpdatingPOA() {
		// Implement test code
		Account a = TestData.setupAccount();
		insert a;
		 POA__c poa = TestData.setupPOA(a,'vAuto');
		 insert poa;

		RecordType poaRecordType = StaticData.getInstance().POARecTypesMapByName.get('vAuto');
    

		 User u =  TestData.setupUser('VinSystem Admin', 'Business Analyst');
		 Cancelled_Trainings__c ct = new Cancelled_Trainings__c();
		 ct.Account__c = a.Id;
		 ct.Trainer__c = u.Id;
		 ct.Train_1_Sale__c = false;
		 ct.Reason__c  = 'Testing';

		   List<POA__c> existingPOA = [Select Id from POA__c where Dealer__c =:ct.Account__c and  RecordTypeId =: poaRecordType.Id and status__c != 'Churned'];  
        system.assert(existingPOA != null,'No POA found');
        system.assert(existingPOA.size() > 0,'No POA found');

		 insert ct;
		  ct = [Select Id,POA__c from  Cancelled_Trainings__c where Id =:ct.Id];
		 system.assert(ct.POA__c == poa.Id,'POA is not assigned');
		
		 ct.Train_1_Sale__c = true;
		 update ct;
		 ct = [Select Id,POA__c from  Cancelled_Trainings__c where Id =:ct.Id];
		 system.assert(ct.POA__c == poa.Id,'POA is not assigned');


		 //update with another account with no POA
		Account a1 = TestData.setupAccount();
		a1.SVOC_Id__c  = 'TestData1';
		a1.AccountNumber  = '2';
		insert a1;
		 ct.Account__c = a1.Id;
		 update ct;
		 ct = [Select Id,POA__c from  Cancelled_Trainings__c where Id =:ct.Id];
		 system.assert(ct.POA__c == null,'POA is not removed');

	}

	
}