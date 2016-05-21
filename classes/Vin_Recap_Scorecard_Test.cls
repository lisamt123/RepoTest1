/*
 * Class/Method Name: Vin_Recap_Scorecard_Test
 * Author/Date: Dean Lukowski August 27, 2015
 * Purpose: To test the contorller Vin_Recap_Scorecard
 */

@isTest
private class Vin_Recap_Scorecard_Test {

	@isTest static void testVinRecapScorecard() {
		// Set up Data
		User testUser = TestData.setupUser();

		Account testAccount = TestData.setupAccount();
		insert testAccount;

		Contact testContact = TestData.setupContact();
		insert testContact;

		Opportunity testOpp = TestData.setupOpportunity(testAccount, testContact);
		testOpp.OwnerId = testUser.Id;
		insert testOpp;

		SFDC_520_Quote__c testProject = TestData.setupProject(testOpp);
		testProject.Build_Type__c = 'Data Split;Upgrade';
		testProject.Project_Type2__c = 'CRM';
		insert testProject;

		Recap__c testRecap = new Recap__c();
		testRecap.Project__c = testProject.Id;

		Training__c testTraining = new Training__c();
		testTraining.RecordTypeId = Schema.SObjectType.Training__c.getRecordTypeInfosByName().get('Travel').getRecordTypeId();
		testTraining.Training_Type__c = 'New Install';
		testTraining.Number_of_Days_This_Training__c = 1;
		testTraining.Related_Project__c = testProject.Id;
		testTraining.Assigned_Trainer__c = testUser.Id;
		insert testTraining;

		Test.startTest();

		// First Test: Open page without a Recap Id or Project Id
		Test.setCurrentPageReference(new PageReference('/'));
		ApexPages.StandardController controller = new ApexPages.StandardController(testRecap);
		Vin_Recap_Scorecard ctrl = new Vin_Recap_Scorecard(controller);
		List<Apexpages.Message> msgs = Apexpages.getMessages();
		Boolean b = false;
		for(Apexpages.Message msg : msgs){
			if(msg.getDetail().contains('no project')) b = true;
		}
		System.assert(b);

		// Second Test: New page with Project Id
		ApexPages.currentPage().getParameters().put('Project', testProject.Id);
		Vin_Recap_Scorecard ctrl2 = new Vin_Recap_Scorecard(controller);
		System.assertNotEquals(ctrl2.Project, null);
		ctrl2.RecapObj.Project__c = testProject.Id;

		// Third Test: Run getDueDate and Save methods
		// Set fields from visualforce page
		ctrl2.field = 'Users_Entered_Due_Date__c';
		ctrl2.setDays = 'Users_Entered_Set_Days_Due__c';
		ctrl2.RecapObj.Users_Entered_Set_Days_Due__c = Integer.valueOf(Recap__c.Users_Entered_Set_Days_Due__c.getDescribe().getDefaultValueFormula()) + 1;
		// Get the due date on page load
		Date testDateBefore = ctrl2.RecapObj.Users_Entered_Due_Date__c;
		// Run getDueDate method
		ctrl2.getDueDate();
		// Check that the date was changed by the method
		System.assertEquals(testDateBefore.addDays(1), ctrl2.RecapObj.Users_Entered_Due_Date__c);
		// Same methods, add for code coverage
		ctrl2.field = 'VT_Admin_Class_Due_Date__c';
		ctrl2.setDays = 'VT_Admin_Class_Set_Days_Due__c';
		ctrl2.RecapObj.VT_Admin_Class_Set_Days_Due__c = Integer.valueOf(Recap__c.VT_Admin_Class_Set_Days_Due__c.getDescribe().getDefaultValueFormula()) + 1;
		ctrl2.getVirtualDueDate();
		ctrl2.field = 'PT_Scheduled_Custom_Reports_Due_Date__c';
		ctrl2.setDays = 'PT_Scheduled_Custom_Reports_Set_Days_Due__c';
		ctrl2.RecapObj.PT_Scheduled_Custom_Reports_Set_Days_Due__c = Integer.valueOf(Recap__c.PT_Scheduled_Custom_Reports_Set_Days_Due__c.getDescribe().getDefaultValueFormula()) + 1;
		ctrl2.getOnSiteDueDate();
		// Save the record
		ctrl2.Save();
		Database.SaveResult SR1 = Database.insert(testRecap);
		Id testRecapId = SR1.getId();
		System.assert(ctrl2.isValid);

		// Fourth Test: Load page with existing Recap
		ApexPages.currentPage().getParameters().put('RecapId', testRecapId);
		Vin_Recap_Scorecard ctrl3 = new Vin_Recap_Scorecard(controller);
		System.assertNotEquals(ctrl3.RecapId, null);
		SFDC_520_Quote__c projectCall = [Select CreatedDate From SFDC_520_Quote__c Where Id =: testProject.Id];
		Datetime testCreatedDate = projectCall.CreatedDate.addDays(-30);
		ctrl3.RecapObj.VT_Admin_Class_Due_Date__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.VT_Manager_Class_Due_Date__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.VT_Sales_Classes_Due_Date__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.VT_Additional_Admin_Settings_Due_Date__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.VT_Appraisal_Service_Settings_Due__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.PT_Scheduled_Custom_Reports_Due_Date__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.PT_ROI_Settings_Configured_Due_Date__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.PT_Processes_Enabled_Due_Date__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.PT_Inventory_Verified_Due_Date__c = Date.valueOf(testCreatedDate);
		ctrl3.RecapObj.PT_CRM_DMS_Matching_Due_Date__c = Date.valueOf(testCreatedDate);
		// Fifth Test: Enter data for formulas and save to test formulas
		
		// These fields set the formula for LC_Score_New__c
		ctrl3.selectedLUE = 'Yes';
		ctrl3.selectedASV = 'Yes';
		ctrl3.selectedPTV = 'Yes';
		ctrl3.selectedLDV = 'No';
        ctrl3.selectedLPT = 'N/A';
        ctrl3.selectedDMS = 'N/A';
        ctrl3.selectedDLF = 'N/A';
        ctrl3.selectedUPL = 'N/A';
        ctrl3.selectedVER = 'N/A';
	    ctrl3.selectedLDP = 'N/A';
        ctrl3.selectedDTR = 'N/A';
        ctrl3.selectedDR1 = 'N/A';
        ctrl3.selectedFTP = 'N/A';
        ctrl3.selectedIGC = 'N/A';
        ctrl3.selectedCAR = 'N/A';
        ctrl3.selectedMES = 'N/A';
        ctrl3.selectedCBS = 'N/A';
        ctrl3.selectedICT = 'N/A';
        ctrl3.selectedILU = 'N/A';
        ctrl3.selectedTLS = 'N/A';
	    ctrl3.selectedLA1 = 'N/A';
	    ctrl3.selectedLA2 = 'N/A';
	    ctrl3.selectedLA3 = 'N/A';
		// These fields set the formula for Implementation_Score_New__c
		ctrl3.selectedIIV = 'Yes';
		ctrl3.selectedIBA = 'Yes';
		ctrl3.selectedSFV = 'Yes';
		ctrl3.selectedISA = 'No';
        ctrl3.selectedIBB = 'N/A';
        ctrl3.selectedIIC = 'N/A';
        ctrl3.selectedISU = 'N/A';
        ctrl3.selectedICR = 'N/A';
	    ctrl3.selectedCNC = 'N/A';
        ctrl3.selectedISO = 'N/A';
        ctrl3.selectedISE = 'N/A';
        ctrl3.selectedIOP = 'N/A';
        ctrl3.selectedIDE = 'N/A';
        ctrl3.selectedIAI = 'N/A';
        ctrl3.selectedIPB = 'N/A';
        ctrl3.selectedIDA = 'N/A';
        ctrl3.selectedICA = 'N/A';
        ctrl3.selectedITR = 'N/A';
	    ctrl3.selectedILV = 'N/A';
	    ctrl3.selectedIXT = 'N/A';
	    ctrl3.selectedIA1 = 'N/A';
	    ctrl3.selectedIA2 = 'N/A';
	    ctrl3.selectedIA3 = 'N/A';
		// These fields set the formula for Creative_Score__c
		ctrl3.selectedPOC = 'Yes';
		ctrl3.selectedEBC = 'Yes';
		ctrl3.selectedIP1 = 'Yes';
		ctrl3.selectedIP2 = 'No';
    	ctrl3.selectedIP3 = 'N/A';
		// These fields set the formula for VT_Dealer_Grade__c
        ctrl3.selectedODH = '4';
        ctrl3.selectedAEI = '3';
        ctrl3.selectedMEI = '2';
        ctrl3.selectedSEI = '1';
		// These fields set the formula for PT_Dealer_Grade__c
        ctrl3.selectedPOT = '4';
        ctrl3.selectedDGE = '3';
        ctrl3.selectedDME = '2';
        ctrl3.selectedPSE = '1';
		// These fields set the formula for VT_Score__c and part of VT_On_Time_Score__c
		ctrl3.selectedACC = 'Yes';
		ctrl3.selectedMCC = 'Yes';
		ctrl3.selectedSCC = 'Yes';
		ctrl3.selectedASC = 'Yes';
		ctrl3.selectedSSM = 'No';
		ctrl3.selectedDCS = 'N/A';
		ctrl3.selectedDFS = 'N/A';
		ctrl3.selectedVLA = 'N/A';
		ctrl3.selectedVLS = 'N/A';
		ctrl3.selectedACS = 'N/A';
		ctrl3.selectedVRS = 'N/A';
		ctrl3.selectedVTC = 'N/A';
		ctrl3.selectedVA1 = 'N/A';
		ctrl3.selectedVA2 = 'N/A';
		ctrl3.selectedVA3 = 'N/A';
		// These fields set the formula for VT_Score__c and part of PT_On_Time_Score__c
		ctrl3.selectedSCR = 'Yes';
		ctrl3.selectedRSC = 'Yes';
		ctrl3.selectedPPE = 'Yes';
		ctrl3.selectedPPC = 'Yes';
		ctrl3.selectedULC = 'No';
		ctrl3.selectedLAC = 'N/A';
		ctrl3.selectedLSC = 'N/A';
		ctrl3.selectedDVF = 'N/A';
		ctrl3.selectedPIV = 'N/A';
		ctrl3.selectedCDM = 'N/A';
		ctrl3.selectedALF = 'N/A';
		ctrl3.selectedAH1 = 'N/A';
		ctrl3.selectedAH2 = 'N/A';
		ctrl3.selectedAH3 = 'N/A';
		ctrl3.selectedPTC = 'N/A';
		//Set up to test VT_On_Time_Score__c
		ctrl3.RecapObj.VT_Admin_Class_Completed_Date__c = ctrl3.RecapObj.VT_Admin_Class_Due_Date__c.addDays(-1);
		ctrl3.RecapObj.VT_Manager_Class_Complete_Date__c = ctrl3.RecapObj.VT_Manager_Class_Due_Date__c.addDays(-1);
		ctrl3.RecapObj.VT_Sales_Classes_Complete_Date__c = ctrl3.RecapObj.VT_Sales_Classes_Due_Date__c.addDays(-1);
		ctrl3.RecapObj.VT_Additional_Admin_Settings_Comp_Date__c = ctrl3.RecapObj.VT_Additional_Admin_Settings_Due_Date__c.addDays(1);
		ctrl3.RecapObj.VT_Appraisal_Service_Settings_Comp_Date__c = ctrl3.RecapObj.VT_Appraisal_Service_Settings_Due__c.addDays(1);
		//Set up to test VT_On_Time_Score__c
		ctrl3.RecapObj.PT_Scheduled_Custom_Reports_Complete__c = ctrl3.RecapObj.PT_Scheduled_Custom_Reports_Due_Date__c.addDays(-1);
		ctrl3.RecapObj.PT_ROI_Settings_Configured_Complete_Date__c = ctrl3.RecapObj.PT_ROI_Settings_Configured_Due_Date__c.addDays(-1);
		ctrl3.RecapObj.PT_Processes_Enabled_Complete_Date__c = ctrl3.RecapObj.PT_Processes_Enabled_Due_Date__c.addDays(-1);
		ctrl3.RecapObj.PT_Inventory_Verified_Complete_Date__c = ctrl3.RecapObj.PT_Inventory_Verified_Due_Date__c.addDays(1);
		ctrl3.RecapObj.PT_CRM_DMS_Matching_Complete_Date__c = ctrl3.RecapObj.PT_CRM_DMS_Matching_Due_Date__c.addDays(1);
		ctrl3.Save();
		//Need to open the record again to get the Total_Score_New__c
		ApexPages.currentPage().getParameters().put('RecapId', testRecapId);
		Vin_Recap_Scorecard ctrl4 = new Vin_Recap_Scorecard(controller);
		ctrl4.Save();
		//Query record to get formula field values
		Recap__c recapCall = [Select Creative_Answered_New__c, Creative_Score_Count_New__c, LC_Score_New__c, Implementation_Score_New__c,
									 Creative_Score_New__c, Total_Score_New__c, VT_Dealer_Grade__c, PT_Dealer_Grade__c, VT_Score__c,
									 PT_Score__c, VT_Admin_Class_Completed_On_Time__c, VT_On_Time_Score__c, PT_On_Time_Score__c,
									 Implementation_Answered_New__c, Implementation_Score_Count_New__c, LC_Score_Count_New__c, LC_Answered_New__c
								From Recap__c
							   Where Id = :testRecapId];
		// Total_Score_New__c is set from LC_Score_New__c, Implementation_Score_New__c, and Creative_Score__c
		System.assertEquals(75.00, recapCall.Total_Score_New__c);
		System.assertEquals(2.50, recapCall.VT_Dealer_Grade__c);
		System.assertEquals(2.50, recapCall.PT_Dealer_Grade__c);
		System.assertEquals(80.0, recapCall.VT_Score__c);
		System.assertEquals(80.0, recapCall.PT_Score__c);
		System.assertEquals(60.0, recapCall.VT_On_Time_Score__c);
		System.assertEquals(100.0, recapCall.PT_On_Time_Score__c);

		ApexPages.currentPage().getParameters().put('RecapId', testRecapId);
		Vin_Recap_Scorecard ctrl5 = new Vin_Recap_Scorecard(controller);
		// Same methods, add for code coverage
		ctrl5.Cancel();
		ctrl5.EditScorecard();
		ctrl5.field = 'Users_Entered_Due_Date__c';
		ctrl5.setDays = 'Users_Entered_Set_Days_Due__c';
		ctrl2.RecapObj.Users_Entered_Set_Days_Due__c = Integer.valueOf(Recap__c.Users_Entered_Set_Days_Due__c.getDescribe().getDefaultValueFormula()) + 1;
		ctrl5.RecapObj.Users_Entered_Set_Days_Due__c = Integer.valueOf(Recap__c.Users_Entered_Set_Days_Due__c.getDescribe().getDefaultValueFormula()) + 1;
		ctrl5.getDueDate();
		ctrl5.field = 'VT_Admin_Class_Due_Date__c';
		ctrl5.setDays = 'VT_Admin_Class_Set_Days_Due__c';
		ctrl5.RecapObj.VT_Admin_Class_Set_Days_Due__c = Integer.valueOf(Recap__c.VT_Admin_Class_Set_Days_Due__c.getDescribe().getDefaultValueFormula()) + 1;
		ctrl5.getVirtualDueDate();
		ctrl5.field = 'PT_Scheduled_Custom_Reports_Due_Date__c';
		ctrl5.setDays = 'PT_Scheduled_Custom_Reports_Set_Days_Due__c';
		ctrl5.RecapObj.PT_Scheduled_Custom_Reports_Set_Days_Due__c = Integer.valueOf(Recap__c.PT_Scheduled_Custom_Reports_Set_Days_Due__c.getDescribe().getDefaultValueFormula()) + 1;
		ctrl5.getOnSiteDueDate();
		ctrl5.CloneRecord();
		
  		Test.stopTest();
	}

	@isTest static void testVinRecapScorecardAdditionalCodeCoverage() {
		// Set up Data
		User testUser = TestData.setupUser();

		Account testAccount = TestData.setupAccount();
		insert testAccount;

		Contact testContact = TestData.setupContact();
		insert testContact;

		Opportunity testOpp = TestData.setupOpportunity(testAccount, testContact);
		testOpp.OwnerId = testUser.Id;
		insert testOpp;

		SFDC_520_Quote__c testProject = TestData.setupProject(testOpp);
		testProject.Build_Type__c = 'Data Split;Upgrade';
		testProject.Project_Type2__c = 'CRM';
		insert testProject;
		SFDC_520_Quote__c projectCall = [Select CreatedDate, Alternate_Start_Date__c, Virtual_Training_Start_Date__c,
												Confirmed_Training_Start__c
										   From SFDC_520_Quote__c
										  Where Id =: testProject.Id];
		testProject.Alternate_Start_Date__c = projectCall.CreatedDate.Date().addDays(10);
		testProject.Virtual_Training_Start_Date__c = projectCall.CreatedDate.date().addDays(10);
		testProject.Confirmed_Training_Start__c = projectCall.CreatedDate.date().addDays(10);
		update testProject;

		Recap__c testRecap = new Recap__c();
		testRecap.Project__c = testProject.Id;
		insert testRecap;

		Training__c testTraining = new Training__c();
		testTraining.RecordTypeId = Schema.SObjectType.Training__c.getRecordTypeInfosByName().get('Travel').getRecordTypeId();
		testTraining.Training_Type__c = 'New Install';
		testTraining.Number_of_Days_This_Training__c = 1;
		testTraining.Related_Project__c = testProject.Id;
		testTraining.Assigned_Trainer__c = testUser.Id;
		insert testTraining;

		Test.startTest();

		// First Test: Clone message
		Test.setCurrentPageReference(new PageReference('/'));
		ApexPages.StandardController controller = new ApexPages.StandardController(testRecap);
		ApexPages.currentPage().getParameters().put('clonedRecord', 'true');
		ApexPages.currentPage().getParameters().put('id', testRecap.Id);
		Vin_Recap_Scorecard ctrl2 = new Vin_Recap_Scorecard(controller);
		List<Apexpages.Message> msgs2 = Apexpages.getMessages();


		Test.setCurrentPageReference(new PageReference('/'));
		ApexPages.StandardController controller2 = new ApexPages.StandardController(testRecap);
		ApexPages.currentPage().getParameters().put('Project', testProject.Id);
		Vin_Recap_Scorecard ctrl3 = new Vin_Recap_Scorecard(controller2);

		// Call picklist values for code coverage
		List<SelectOption> var1 = ctrl3.availableYesNo;
		List<SelectOption> var2 = ctrl3.availableRating;
	
  		Test.stopTest();
	}
}