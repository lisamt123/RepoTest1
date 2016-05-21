@isTest
private class CreateCertificationClass_Test {

    static testMethod void myUnitTest() {
    	User testUser = TestData.setupUser('VinSystem Admin', 'Business Analyst');
    	Contact testContact = TestData.setupContact();
    	testContact.Certifications_Issued__c = 'BD Agent';
    	insert testContact;
        System.runas(testUser) {
        	
	    	Classes__c testClass1 = new Classes__c();
	    	testClass1.Name = 'Sales Consultant Level 1';
	    	insert testClass1;
	    	Classes__c testClass2 = new Classes__c();
	    	testClass2.Name = 'Sales Consultant Level 2';
	    	insert testClass2;
	    	Classes__c testClass3 = new Classes__c();
	    	testClass3.Name = 'Sales Consultant Level 3';
	    	insert testClass3;
	    	
	    	Online_Class__c testOnlineClass1 = new Online_Class__c();
	    	testOnlineClass1.Name = 'Test1';
	    	testOnlineClass1.Class__c = testClass1.Id;
	    	insert testOnlineClass1;
	    	Online_Class__c testOnlineClass2 = new Online_Class__c();
	    	testOnlineClass2.Name = 'Test2';
	    	testOnlineClass2.Class__c = testClass2.Id;
	    	insert testOnlineClass2;
	    	Online_Class__c testOnlineClass3 = new Online_Class__c();
	    	testOnlineClass3.Name = 'Test3';
	    	testOnlineClass3.Class__c = testClass3.Id;
	    	insert testOnlineClass3;
	    	
	    	
	    	SFDC_Service_Timecard__c tc1 = new SFDC_Service_Timecard__c();
	    	tc1.Contact__c = testcontact.Id;
	    	tc1.Online_Class__c = testOnlineClass1.Id;
	    	tc1.Class_Status__c = 'Completed';
	    	insert tc1;
	    	SFDC_Service_Timecard__c tc2 = new SFDC_Service_Timecard__c();
	    	tc2.Contact__c = testcontact.Id;
	    	tc2.Online_Class__c = testOnlineClass2.Id;
	    	tc2.Class_Status__c = 'Completed';
	    	insert tc2;
	    	SFDC_Service_Timecard__c tc3 = new SFDC_Service_Timecard__c();
	    	tc3.Contact__c = testcontact.Id;
	    	tc3.Online_Class__c = testOnlineClass3.Id;
	    	tc3.Class_Status__c = 'Completed';
	    	insert tc3;
	    	
        	//Set your controller
        	CreateCertificationClass cccTest = new CreateCertificationClass();
	    	CreateCertificationClass.CreateCertification(new List<Id>{testcontact.Id});
        	
        	test.startTest();
        	
        	
        	test.stopTest();
        }
    }
    
    static testMethod void myUnitTest2() {
        User testUser = TestData.setupUser('VinSystem Admin', 'Business Analyst');
    	Contact testContact = TestData.setupContact();
    	testContact.Certifications_Issued__c = null;
    	insert testContact;
        System.runas(testUser) {
	    	
	    	Classes__c testClass1 = new Classes__c();
	    	testClass1.Name = 'Sales Consultant Level 1';
	    	insert testClass1;
	    	Classes__c testClass2 = new Classes__c();
	    	testClass2.Name = 'Sales Consultant Level 2';
	    	insert testClass2;
	    	Classes__c testClass3 = new Classes__c();
	    	testClass3.Name = 'Sales Consultant Level 3';
	    	insert testClass3;
	    	
	    	Online_Class__c testOnlineClass1 = new Online_Class__c();
	    	testOnlineClass1.Name = 'Test1';
	    	testOnlineClass1.Class__c = testClass1.Id;
	    	insert testOnlineClass1;
	    	Online_Class__c testOnlineClass2 = new Online_Class__c();
	    	testOnlineClass2.Name = 'Test2';
	    	testOnlineClass2.Class__c = testClass2.Id;
	    	insert testOnlineClass2;
	    	Online_Class__c testOnlineClass3 = new Online_Class__c();
	    	testOnlineClass3.Name = 'Test3';
	    	testOnlineClass3.Class__c = testClass3.Id;
	    	insert testOnlineClass3;
	    	
	    	
	    	SFDC_Service_Timecard__c tc1 = new SFDC_Service_Timecard__c();
	    	tc1.Contact__c = testcontact.Id;
	    	tc1.Online_Class__c = testOnlineClass1.Id;
	    	tc1.Class_Status__c = 'Completed';
	    	insert tc1;
	    	SFDC_Service_Timecard__c tc2 = new SFDC_Service_Timecard__c();
	    	tc2.Contact__c = testcontact.Id;
	    	tc2.Online_Class__c = testOnlineClass2.Id;
	    	tc2.Class_Status__c = 'Completed';
	    	insert tc2;
	    	SFDC_Service_Timecard__c tc3 = new SFDC_Service_Timecard__c();
	    	tc3.Contact__c = testcontact.Id;
	    	tc3.Online_Class__c = testOnlineClass3.Id;
	    	tc3.Class_Status__c = 'Completed';
	    	insert tc3;
	    	
        	//Set your controller
        	CreateCertificationClass cccTest = new CreateCertificationClass();
	    	CreateCertificationClass.CreateCertification(new List<Id>{testContact.Id});
        	
        	test.startTest();
        	
        	
        	test.stopTest();
        }
    }
    
}