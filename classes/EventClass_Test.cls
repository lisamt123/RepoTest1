@isTest
private class EventClass_Test {

    static testMethod void myUnitTest() {
    	Account testAcct = TestData.setupAccount();
    	Contact testContact = TestData.setupContact();
    	insert testAcct;
    	insert testContact;
    	Opportunity testOptty = TestData.setupOpportunity(testAcct, testContact);
        insert testOptty;
        testOptty.StageName = 'Closed or Lost';
        testOptty.Opportunity_Names__c = 'Hardware';
        testOptty.Reason_Closed_Lost__c = 'Service Cancelled';
        update testOptty;

        Event testEvent = TestData.setupEvent(testContact, testOptty);
        insert testEvent;
        testEvent.Exception_Salesperson__c = 'Jonathan Smithton';
        update testEvent;
    }
    
    static testMethod void myUnitTest2(){
    	Account testAcct = TestData.setupAccount();
    	Contact testContact = TestData.setupContact();
    	insert testAcct;
    	insert testContact;
    	Opportunity testOptty = TestData.setupOpportunity(testAcct, testContact);
        insert testOptty;
        testOptty.Opportunity_Names__c = 'Fulfillment';
        testOptty.Reason_Closed_Lost__c = 'Service Cancelled';
        update testOptty;
        SFDC_520_Quote__c testProject = TestData.setupProject(testOptty);
        insert testProject;

        Event testEvent = TestData.setupEvent(testContact, testOptty);
		testEvent.WebEx_Topic__c = 'CRM;ILM;Inventory;MPT;Desking;ACH Bank Withdrawal';
		testEvent.Exception_Salesperson__c = null;
		testEvent.Salesperson_Exception__c = false;
		testEvent.Webexer_Webex_Rating__c = '1 star';
		testEvent.Webexer_Webex_Rating_Notes__c = 'test';
		testEvent.Regional_Webex_Rating__c = '1 star';
		testEvent.Regional_Webex_Rating_Notes__c = 'test';

        test.startTest();
    	insert testEvent;
    	testEvent.Subject = 'Completed';
    	update testEvent;
    	
    	delete testEvent;
    	
    	undelete testEvent;
    	
    	Event ee = TestData.setupEvent(testContact, testOptty);
    	ee.Subject ='onsite';
    	ee.Webex_Topic__c = 'test';
    	ee.WebEx_With__c = 'test';
    	ee.WhatId = testProject.Id;
    	ee.EndDateTime = ee.StartDateTime.addMinutes(60);
    	ee.DurationInMinutes = 60;
    	insert ee;
    	
    	test.stopTest();
    }
    
    static testMethod void myUnitTest3(){
    	Account testAcct = TestData.setupAccount();
    	Contact testContact = TestData.setupContact();
    	insert testAcct;
    	insert testContact;
    	Opportunity testOptty = TestData.setupOpportunity(testAcct, testContact);
        insert testOptty;
        testOptty.StageName = 'Closed or Lost';
        testOptty.Opportunity_Names__c = 'Hardware';
        testOptty.Reason_Closed_Lost__c = 'Service Cancelled';
        update testOptty;
        SFDC_520_Quote__c testProject = TestData.setupProject(testOptty);
        insert testProject;

        Event testEvent = TestData.setupEvent(testContact, testOptty);
        testEvent.Subject = 'haystak demo';
		testEvent.WebEx_Topic__c = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa';
		insert testEvent;
		testEvent.Exception_Salesperson__c = 'Jonathan Smithton';
		update testEvent;
	}
}