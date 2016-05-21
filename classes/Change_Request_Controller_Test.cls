@isTest
private class Change_Request_Controller_Test {
	
	//Create a Change Request from scratch
	@isTest static void testChangeRequestCreation() {
		User testUser = TestData.setupUser();

		Test.startTest();

		System.runAs(testUser){

			ApexPages.standardController controller;
			Change_Request_Controller ctrl = new Change_Request_Controller(controller);
			//Select lists for code coverage
			List<SelectOption> var1 = ctrl.availableBU;
        	List<SelectOption> var2 = ctrl.availablePriority;
        	List<SelectOption> var3 = ctrl.availableChangeType;
        	List<SelectOption> var5 = ctrl.availableTier;
        	ctrl.selectedChangeType = 'Add/New';
        	List<SelectOption> var6 = ctrl.availableChangeTypeDetails;
        	ctrl.selectedChangeType = 'Change';
        	var6 = ctrl.availableChangeTypeDetails;
        	ctrl.selectedChangeType = 'Remove';
        	var6 = ctrl.availableChangeTypeDetails;
        	ctrl.selectedChangeType = '--None--';

			//Check that fields are populated from user record.
			system.assertNotEquals(ctrl.selectedBU, '');
			system.assertNotEquals(ctrl.CRObj.Department__c, '');

			//First Save to test Validation rules
			ctrl.Submit();
			system.assertEquals(ctrl.crvw.changeTypeRequired, true);
			system.assertEquals(ctrl.crvw.subjectRequired, true);
			system.assertEquals(ctrl.crvw.requestDetailsRequired, true);

			//Fill in first required fields with a value in selectedChangeType to call validation rule on changeTypeDetails
			ctrl.selectedChangeType = 'Add/New';
			ctrl.CRObj.Subject__c = 'A string to test the subject line.';
			ctrl.CRObj.Request_Details__c = 'A string to test the required field.';
			ctrl.Submit();
			system.assertEquals(ctrl.crvw.changeTypeDetailsRequired, true);

			//Fill in last required field to allow a save to process
			ctrl.selectedChangeTypeDetails = 'Report/Dashboard';
			ctrl.Submit();

		}

		Test.stopTest();

	}
	
	@isTest static void testChangeRequestWithAttachment() {
		User testUser = TestData.setupUser();

		Test.startTest();

		System.runAs(testUser){

			ApexPages.standardController controller;
			Change_Request_Controller ctrl = new Change_Request_Controller(controller);

			//Click Submit and Add Attachment
			ctrl.AddAtts();
			system.assertEquals(ctrl.isValid, false);
			system.assertEquals(ctrl.attachments, false);

			//Fill required fields to go to Multiple Attachments page
			ctrl.selectedChangeType = 'Access/Permissions';
			ctrl.CRObj.Subject__c = 'A string to test the subject line.';
			ctrl.CRObj.Request_Details__c = 'A string to test the required field.';
			ctrl.AddAtts();
			system.assertEquals(ctrl.attachments, true);

		}

		Test.stopTest();
	}

	@isTest static void testAfterAChangeRequestHasBeenCreated() {
		User testUser1 = TestData.setupUser();
		User testUser2 = TestData.setupUser();
		Change_Request__c testCR = new Change_Request__c(Change_Type__c = 'Access/Permissions',
															Tier_Level__c = 'Tier 1',
															Subject__c = 'A string to test the subject line.',
															Request_Details__c = 'A string to test teh required field.');
		Database.SaveResult SR1 = Database.insert(testCR);
    	Id CRId = SR1.getId();
    	Change_Request__History history = new Change_Request__History(ParentId = CRId, Field = 'created');
    	Database.SaveResult SR2 = Database.insert(history);

		Test.startTest();

		System.runAs(testUser2){

			ApexPages.currentPage().getParameters().put('CRId', CRId);
			ApexPages.standardController controller;
			Change_Request_Controller ctrl = new Change_Request_Controller(controller);

			//Click the Assign To Me button
			//ctrl.AssignToMe();
			//system.assertNotEquals(ctrl.CRObj.Owner.Name, ctrl.CRObj.Assigned_To__c);

			//Click the Escalate button
			ctrl.showPopup();
			ctrl.selectedTier = 'Tier 1';
			ctrl.CRObj.Tier_Change_Reason__c = 'Test string to test tier escalation.';
			ctrl.closePopup();
			system.assertEquals(ctrl.crvw.tierLevelRequired, true);
			ctrl.selectedTier = 'Tier 2';
			ctrl.CRObj.Tier_Change_Reason__c = '';
			ctrl.closePopup();
			system.assertEquals(ctrl.crvw.tierChangeReasonRequired, true);
			ctrl.selectedTier = 'Tier 2';
			ctrl.CRObj.Tier_Change_Reason__c = 'Test string to test tier escalation.';
			ctrl.saveEscalate();
			system.assertEquals(ctrl.crvw.tierChangeReasonRequired, false);
			system.assertEquals(ctrl.crvw.tierLevelRequired, false);

			//Testing Work Notest
			ApexPages.currentPage().getParameters().put('CRId', CRId);
			Change_Request_Controller ctrl2 = new Change_Request_Controller(controller);
			ctrl2.CRObj.Work_Notes__c = 'Test string to test work notes and generate more code coverage.';
			ctrl2.Submit();
			ctrl2.CRObj.Work_Notes__c = 'Test string to test work notes and generate more code coverage.';
			ctrl2.CRObj.Work_Notes_History__c = 'Test string to test work notes and generate more code coverage.';
			ctrl2.CRObj.Change_Request_Status__c = 'Duplicate';
			ctrl2.SubmitNew();
			system.assertNotEquals(ctrl2.CRObj.Work_Notes_History__c, '');
			system.assertEquals(ctrl2.crvw.duplicateCRRequired, true);
			pageReference var1 = ctrl2.Cancel();
			pageReference var2 = ctrl2.EditCR();

		}

		Test.stopTest();
	}
	
}