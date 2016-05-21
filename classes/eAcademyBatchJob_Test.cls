@isTest
private class eAcademyBatchJob_Test {
	
	static testmethod void test() {
		Account testAcct = TestData.setupAccount();
		insert testAcct;
		Contact testCon = TestData.setupContact(testAcct, 'VIN');
		testCon.MotoSnap_User_Id__c = 'TestID';
		insert testCon;

       // Load some test eAcademy__c records from a static resource to be deleted by the batch job.
       List<sObject> ls = Test.loadData(eAcademy__c.sObjectType, 'eAcademyTestData');
       System.assert(ls.size() == 10);
       Test.startTest();
       eAcademyBatchJob eb = new eAcademyBatchJob();
       Database.executeBatch(eb);
       Test.stopTest();

       // Verify eAcademy__c records got deleted 
       Integer i = [SELECT COUNT() FROM eAcademy__c];
       System.assertEquals(i, 0);
    }
	
}