@isTest
private class vAutoTraderCanadaActivityHistory_Test {
	
	@isTest static void test_ActivityHistory_Page() {
		// Setup test data
		Integer DATA_SET_SIZE = 10;
		Account testAcct = TestData.setupAccount();
		insert testAcct;
		User testUser = TestData.setupUser();
		testUser.CompanyName = 'vAuto';
		update testUser;
		Contact testContact = TestData.setupContact(testAcct, 'vAuto');
		insert testContact;
		POA__c testPOA = TestData.setupPOA(testAcct, 'vAuto');
		insert testPOA;
		 // Setup Task Data
        List<Task> taskList = new List<Task>();
        List<Event> eventList = new List<Event>();

        for(Integer i = 0; i < DATA_SET_SIZE; i++) {
            taskList.add(new Task(
                OwnerId = testUser.Id,
                WhoId = testContact.Id,
                Subject = 'Subject ' + i,
                Preview__c = 'Preview Test',
                ActivityDate = System.today(),
                Status = 'Completed',
                Priority = 'Low',
                WhatId = testPOA.Id
            ));
        } 
        insert taskList;

        // Setup Event Data
        for(Integer i = 0; i < DATA_SET_SIZE - 5; i++) {
            eventList.add(new Event(
            	RecordTypeId = Schema.SObjectType.Event.getRecordTypeInfosByName().get('vAuto').getRecordTypeId(),
                OwnerId = testUser.Id,
                WhoId = testContact.Id,
                Subject = 'Subject ' + i,
                Preview__c = 'Preview Test',
                ActivityDateTime = System.today().addDays(-2),
                EndDateTime = System.today().addDays(-2),
                DurationInMinutes = 0,
                WhatId = testPOA.Id
            ));
        } 
        insert eventList;

		Test.startTest();

		Test.setCurrentPageReference(new PageReference('/'));
		ApexPages.currentPage().getParameters().put('id', testAcct.Id);
		ApexPages.StandardController controller = new ApexPages.StandardController(testAcct);
		vAutoTraderCanadaActivityHistory ctrl = new vAutoTraderCanadaActivityHistory(controller);
		
		system.assertNotEquals(ctrl.acctId, null);
		system.assertEquals(15, ctrl.combineTasksAndEvents.size());
		system.assertEquals(5, ctrl.actHistoriesWrpList.size());
		ctrl.showMore();
		system.assertEquals(15, ctrl.actHistoriesWrpList.size());

		ctrl.removeItemId = taskList[0].Id;
		ctrl.doDeleteAction();
		system.assertEquals(14, ctrl.actHistoriesWrpList.size());

		ctrl.AllowShowMore = false;
		ctrl.removeItemId = taskList[1].Id;
		ctrl.doDeleteAction();
		system.assertEquals(13, ctrl.actHistoriesWrpList.size());

		ctrl.removeItemId = eventList[0].Id;
		ctrl.doDeleteAction();
		system.assertEquals(12, ctrl.actHistoriesWrpList.size());

		ctrl.AllowShowMore = true;
		ctrl.removeItemId = eventList[1].Id;
		ctrl.doDeleteAction();
		system.assertEquals(11, ctrl.actHistoriesWrpList.size());

		ctrl.gotoList();

		Test.stopTest();

	}
	
}