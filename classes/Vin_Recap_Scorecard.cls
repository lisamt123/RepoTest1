/*
 * Class/Method Name: Vin_Recap_Scorecard
 * Author/Date: Dean Lukowski August 27, 2015
 * Purpose: VIN CR-00011208: Build Visualforce page for the new recap layout.
 */


public with sharing class Vin_Recap_Scorecard {

 // Class Variables
	public static String NONESELECT = '--None--';
    public Boolean isValid{get;set;}
    public Boolean setPicklistDefaults{get;set;}
    public Boolean resetLaunchAndImplementationDefaultSetDaysDue{get;set;}
    public Boolean resetVirtualDefaultSetDaysDue{get;set;}
    public Boolean resetOnSiteDefaultSetDaysDue{get;set;}
    public RecapValidationWrapper rvw{get;set;}
    public String clonedRecord{get;set;}
    public String field{get;set;}
    public String setDays{get;set;}
    public String createdDateStr {get;set;}
    public String lastModDateStr {get;set;}
    // Recap Info
    public String RecapId{get;set;}
    public String newRecapId{get;set;}
    public Recap__c RecapObj{get;set;}
    public String rt{get;set;}
    // Project Info
    public Id projectId{get;set;}
    public SFDC_520_Quote__c Project{get;set;}
    public Date projectCreatedDate{get;set;}
    public Date projectAlternateStart{get;set;}
    public Date projectTrainingStart{get;set;}
    public Date projectTrainingEnd{get;set;}
    public Date projectVirtualTrainingStart{get;set;}
    public Date oldProjectStartDate{get;set;}
    public Date oldVirtualStartDate{get;set;}
    public Date oldTrainingStartDate{get;set;}
    public Date projectDueDate{get;set;}
    public String projectStartDate{get;set;}
    public String virtualTrainingStartDate{get;set;}
    public String trainingStartDate{get;set;}
    public String projectName{get;set;}
    public String projectOwner{get;set;}
    public String projectAcctId{get;set;}
    public String projectAcctName{get;set;}
    public String projectAcctDealerID{get;set;}
    public String projectOppId{get;set;}
    public String projectOppName{get;set;}
    public String projectBuildType{get;set;}
    public String projectSpecialist{get;set;}
    public String projectLaunchConsultant{get;set;}
    public String projectVinPerformanceManagerName{get;set;}
    public String projectRegionalSalesManagerName{get;set;}
    public String projectVirtualTrainerName{get;set;}
    public List<Training__c> TrainingLinks{get;set;}
    public String trainingLinkId{get;set;}
    public String trainingLinkName{get;set;}
    public String trainingAssignedTrainer{get;set;}

    // Scores Section
    public Double totalScoreCount{get;set;}
    public Double totalScoreAnswered{get;set;}
    public Double totalScore{get;set;}

    // Launch Consultant Section
    public String selectedLUE{get;set;}
    public String selectedASV{get;set;}
    public String selectedLPT{get;set;}
    public String selectedPTV{get;set;}
    public String selectedDMS{get;set;}
    public String selectedDLF{get;set;}
    public String selectedLDV{get;set;}
    public String selectedUPL{get;set;}
    public String selectedVER{get;set;}
    public String selectedLDP{get;set;}
    public String selectedDTR{get;set;}
    public String selectedDR1{get;set;}
    public String selectedFTP{get;set;}
    public String selectedIGC{get;set;}
    public String selectedCAR{get;set;}
    public String selectedMES{get;set;}
    public String selectedCBS{get;set;}
    public String selectedICT{get;set;}
    public String selectedILU{get;set;}
    public String selectedTLS{get;set;}
    public String selectedLA1{get;set;}
    public String selectedLA2{get;set;}
    public String selectedLA3{get;set;}

    // Implementation Consultant Section
    public String selectedIIV{get;set;}
    public String selectedIBB{get;set;}
    public String selectedIIC{get;set;}
    public String selectedISU{get;set;}
    public String selectedIBA{get;set;}
    public String selectedICR{get;set;}
    public String selectedSFV{get;set;}
    public String selectedCNC{get;set;}
    public String selectedISO{get;set;}
    public String selectedISA{get;set;}
    public String selectedISE{get;set;}
    public String selectedIOP{get;set;}
    public String selectedIDE{get;set;}
    public String selectedIAI{get;set;}
    public String selectedIPB{get;set;}
    public String selectedIDA{get;set;}
    public String selectedICA{get;set;}
    public String selectedITR{get;set;}
    public String selectedILV{get;set;}
    public String selectedIXT{get;set;}
    public String selectedIA1{get;set;}
    public String selectedIA2{get;set;}
    public String selectedIA3{get;set;}

    // Creative Section
    public String selectedPOC{get;set;}
    public String selectedEBC{get;set;}
    public String selectedIP1{get;set;}
    public String selectedIP2{get;set;}
    public String selectedIP3{get;set;}

    // Virtual Trainer Section
    public Integer vtOnTimeAnswered{get;set;}
    public Integer vtOnTimeScoreCount{get;set;}
    public String selectedODH{get;set;}
    public String selectedACC{get;set;}
    public String selectedAEI{get;set;}
    public String selectedMCC{get;set;}
    public String selectedMEI{get;set;}
    public String selectedSCC{get;set;}
    public String selectedSEI{get;set;}
    public String selectedASC{get;set;}
    public String selectedSSM{get;set;}
    public String selectedDCS{get;set;}
    public String selectedDFS{get;set;}
    public String selectedVLA{get;set;}
    public String selectedVLS{get;set;}
    public String selectedACS{get;set;}
    public String selectedVRS{get;set;}
    public String selectedVTC{get;set;}
    public String selectedVA1{get;set;}
    public String selectedVA2{get;set;}
    public String selectedVA3{get;set;}

    //Product Trainer Section
    public Integer ptOnTimeAnswered{get;set;}
    public Integer ptOnTimeScoreCount{get;set;}
    public String selectedPOT{get;set;}
    public String selectedDGE{get;set;}
    public String selectedDME{get;set;}
    public String selectedPSE{get;set;}
    public String selectedSCR{get;set;}
    public String selectedRSC{get;set;}
    public String selectedPPE{get;set;}
    public String selectedPPC{get;set;}
    public String selectedULC{get;set;}
    public String selectedLAC{get;set;}
    public String selectedLSC{get;set;}
    public String selectedDVF{get;set;}
    public String selectedPIV{get;set;}
    public String selectedCDM{get;set;}
    public String selectedALF{get;set;}
    public String selectedAH1{get;set;}
    public String selectedAH2{get;set;}
    public String selectedAH3{get;set;}
    public String selectedPTC{get;set;}

	// Constructor
	public Vin_Recap_Scorecard(ApexPages.StandardController controller) {
		setPicklistDefaults = false;
        resetLaunchAndImplementationDefaultSetDaysDue = false;
        resetVirtualDefaultSetDaysDue = false;
        resetOnSiteDefaultSetDaysDue = false;
        totalScoreCount = 0;
        totalScoreAnswered = 0;
		RecapId = ApexPages.currentPage().getParameters().get('RecapId');
        if(RecapId == null){
            RecapId = ApexPages.currentPage().getParameters().get('id');
            projectId = ApexPages.currentPage().getParameters().get('Project');
            rt = ApexPages.currentPage().getParameters().get('RecordType');
        }
        clonedRecord = ApexPages.currentPage().getParameters().get('clonedRecord');
        if(clonedRecord == 'true'){   
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Your record was successfully cloned.');
            ApexPages.addMessage(myMsg);
        }
        getRecapObj();
        getTrainingObjLink();
        InitializeUIComponents();
	}

	// Set up the page 
    private void InitializeUIComponents(){
    	// rvw is for setting up custom validations for the page, if requested
        rvw = new RecapValidationWrapper();
        if(setPicklistDefaults){setDefaults();}
        else{setValues();}

        // Project Info Section
        if(RecapObj.OwnerId == null){
            RecapObj.OwnerId = UserInfo.getUserId();
        }
    	RecapObj.Data_Consultant__c = projectOwner;
    	RecapObj.Implementation_Project_Manager__c = projectSpecialist;
    	RecapObj.Launch_Consultant__c = projectLaunchConsultant;
        RecapObj.Product_Trainer__c = trainingAssignedTrainer;


		// Scores Section
		// This formula replaces the one that is in the RecapTrigger
		if(RecapObj.LC_Score_New__c != null){
            totalScoreCount = totalScoreCount + RecapObj.LC_Score_Count_New__c;
            totalScoreAnswered = totalScoreAnswered + RecapObj.LC_Answered_New__c;
        }
		if(RecapObj.Implementation_Score_New__c != null){
            totalScoreCount = totalScoreCount + RecapObj.Implementation_Score_Count_New__c;
            totalScoreAnswered = totalScoreAnswered + RecapObj.Implementation_Answered_New__c;
        }
		if(RecapObj.Creative_Score_New__c != null){
			totalScoreCount = totalScoreCount + RecapObj.Creative_Score_Count_New__c;
            totalScoreAnswered = totalScoreAnswered + RecapObj.Creative_Answered_New__c;
        }
        if(totalScoreAnswered > 0){
            totalScore = (totalScoreCount / totalScoreAnswered) * 100;
        }

        // Virtual Trainer Section
        RecapObj.VT_On_Time_Score__c = getVTOnTimeScore();

        // On-Site Training Section
        RecapObj.PT_On_Time_Score__c = getPTOnTimeScore();

        // System Info Section
        if (RecapObj.CreatedDate != null){
        	createdDateStr = string.valueof(RecapObj.CreatedDate);
        }
        if (RecapObj.LastModifiedDate != null){
        	lastModDateStr = string.valueof(RecapObj.LastModifiedDate);
        }
    }   

	// Set up page with existing Recap or with a new empty Recap upon page load
    public void getRecapObj() {
        try {
        	if (RecapId != null) {
				RecapObj = [SELECT	Name, CreatedBy.Name, CreatedById, CreatedDate, LastModifiedBy.Name, LastModifiedById, LastModifiedDate,
									Owner.Name, OwnerId, RecordType.Name, RecordTypeId, Project__c, Project__r.Id, Project__r.Name,
									Project__r.Vin_Performance_Manager__c, Project__r.Vin_Performance_Manager__r.Id, Project__r.Account__r.Id,
									Project__r.Vin_Performance_Manager__r.Name, Project__r.Owner.Name, Account_Name__c, Dealer_ID__c, 
									Data_Consultant__c, Project__r.Assigned_Specialist__r.Name, Implementation_Project_Manager__c,
									Launch_Consultant__c, Project__r.Launch_Coordinator__r.Name,
									Project__r.Trainer_4__r.Name, Project_Start_Date__c, Project_Start_Date_New__c,
									Project__r.Opportunity__c, Project__r.Opportunity__r.Id, Project__r.Opportunity__r.Name,
									Project__r.Build_Type__c, Project__r.Opportunity__r.Owner.Name,
									Project__r.CreatedDate, Project__r.Alternate_Start_Date__c, Project__r.Confirmed_Training_Start__c,
									Project__r.Confirmed_Training_End__c, Project__r.Virtual_Training_Start_Date__c, q1__c, Q1_Notes__c,
									Users_Entered_Due_Date__c, Users_Entered_Set_Days_Due__c, Users_Entered_Completed_Date__c, R01__c,
                                    Admin_Settings_verification_form_notes__c, Admin_Settings_Set_Days_Due__c, Admin_Settings_Verification_Form_Due_Dat__c,
                                    Admin_Settings_Ver_Complete_Date__c, q16__c, Q16_Notes__c, Processes_and_Templates_Verification__c,
                                    Processes_verification_form_notes__c, Processes_and_Temp_Set_Days_Due__c, Processes_and_Templates_Verification_Due__c,
                                    Processes_and_Templates_Verified_Date__c, R07__c, Desking_configuration_from_DMS_notes__c, R08__c,
                                    Desking_configuration_fees_notes__c, Desking_Verification__c, Desking_verification_form_notes__c,
                                    Desking_Verification_Set_Days_Due__c, Desking_Verification_Due_Date__c, Desking_Verification_Completed_Date__c,
                                    Inventory_Verified_Set_Days_Due__c, R05__c, Uploaded_forms_notes__c, q21__c, Q21_Notes__c, DMS_Push__c,
                                    DMS_push_notes__c, DMS_Push_Set_Days_Due__c, DMS_Push_Due__c, DMS_Push_Completed_Date__c, q24__c, Q24_Notes__c,
                                    DT_R1_Push_Set_Days_Due__c, Sales_Report_Verification_Set_Days_Due__c, DT_R1_Push_Due__c, DT_R1_Push_Completed_Date__c,
                                    LC_Ad_Hoc_1__c, LC_Ad_Hoc_1_Notes__c, LC_Ad_Hoc_2__c, LC_Ad_Hoc_2_Notes__c, LC_Ad_Hoc_3__c, lC_Ad_Hoc_3_Notes__c,
                                    LC_Answered_New__c, LC_Score_Count_New__c, LC_Score_New__c, q2__c, Q2_Notes__c, Inventory_Verification_Due_Date__c,
                                    Inventory_Verification_Completed_Date__c, q8__c, Q8_Notes__c, q4__c, Q4_Notes__c, q34__c, Q34_Notes__c, q7__c, Q7_Notes__c,
                                    q5__c, Q5_Notes__c, q6__c, Q6_Notes__c, CarFax_AutoCheck_Due_Date__c, Carfax_Autocheck_Setup_Completed_Date__c,
                                    Carfax_Autocheck_Set_Days_Due__c, BAC_and_Dealer_Code_Set_Days_Due__c, Success_Fail_Verification_Set_Days_Due__c,
                                    q13__c, Q13_Notes__c, BAC_and_Dealer_Code_Due__c, BAC_Dealer_Code_Completed_Date__c, q12__c, Q12_Notes__c,
                                    Success_Fail_Verification__c, Success_Fail_verification_form_notes__c, Success_Fail_Verification_Due_Date__c,
                                    CRM_Notes_Completed__c, CRM_Notes_Completed_Notes__c, q19__c, Q19_Notes__c, R14__c, Sales_report_notes__c,
                                    Sales_Report_Verification_Due_Date__c, Success_Fail_Verification_Completed_Date__c, q20__c, Q20_Notes__c, R17__c,
                                    Open_ROs_notes__c, q23__c, Q23_Notes__c, DT_RT_1_Enabled_Tested__c, DT_Route_1_push_notes__c, q26__c, Q26_Notes__c,
                                    Text_Messaging_Due_Date__c, Text_Messaging_Set_Days_Due__c, q27__c, Q27_Notes__c, AIS_Rebates_Due_Date__c,
                                    AIS_Rebates_Set_Days_Due__c, q28__c, Q28_Notes__c, PBX_Setup_Due_Date__c, PBX_Setup_Set_Days_Due__c, R18__c,
                                    Data_appends_Diamond_Accounts_notes__c, q29__c, Q29_Notes__c, Credit_Bureau_Setup_Due_Date__c, Credit_Bureau_Set_Days_Due__c,
                                    q30__c, Q30_Notes__c, Call_Provider_Call_Tracking_Due__c, Call_Provider_Call_Tracking_Set_Days_Due__c, q31__c, Q31_Notes__c, 
                                    Trade_Appraisal_Push_Due_Date__c, Trade_Appraisal_Set_Days_Due__c, Lot_Vantage__c, Lot_Vantage_Notes__c,
                                    Lot_Vantage_Due_Date__c, Lot_Vantage_Set_Days_Due__c, Target__c, Target_Notes__c, Limited_Users__c, Limited_Users_Notes__c,
                                    xTime__c, xTime_Notes__c, Test_Lead_Submitted__c, Test_Lead_Submitted_Notes__c, IC_Ad_Hoc_1__c, IC_Ad_Hoc_1_Notes__c,
                                    IC_Ad_Hoc_2__c, IC_Ad_Hoc_2_Notes__c, IC_Ad_Hoc_3__c, IC_Ad_Hoc_3_Notes__c, Implementation_Score_New__c, q11__c, Q11_Notes__c,
                                    q15__c, Q15_Notes__c, IPM_Ad_Hoc_1__c, IPM_Ad_Hoc_1_Notes__c, IPM_Ad_Hoc_2__c, IPM_Ad_Hoc_2_Notes__c, IPM_Ad_Hoc_3__c,
                                    IPM_Ad_Hoc_3_Notes__c, Creative_Score_New__c, Total_Score_New__c, VT_Overall_Dealer_Health__c, VT_Overall_Dealer_Health_Notes__c,
                                    VT_Admin_Class_Complete__c, VT_Admin_Class_Complete_Notes__c, VT_Admin_Class_Due_Date__c, VT_Admin_Class_Set_Days_Due__c,
                                    VT_Admin_Class_Completed_Date__c, VT_Admin_Engagement_and_Interaction__c, VT_Admin_Engagement_Notes__c,
                                    VT_Manager_Class_Complete__c, VT_Manager_Class_Complete_Notes__c, VT_Manager_Class_Set_Days_Due__c, VT_Manager_Class_Due_Date__c,
                                    VT_Manager_Class_Complete_Date__c, VT_Manager_Engagement_and_Interaction__c, VT_Manager_Engagement_Notes__c,
                                    VT_Sales_Classes_Complete__c, VT_Sales_Classes_Notes__c, VT_Sales_Classes_Set_Days_Due__c, VT_Sales_Classes_Due_Date__c,
                                    VT_Sales_Classes_Complete_Date__c, VT_Sales_Engagement_and_Interaction__c, VT_Sales_Engagement_Notes__c,
                                    VT_Products_Purchased_Issues__c, VT_Additional_Admin_Settings_Complete__c, VT_Additional_Admin_Settings_Notes__c,
                                    VT_Additional_Admin_Set_Days_Due__c, VT_Additional_Admin_Settings_Due_Date__c, VT_Additional_Admin_Settings_Comp_Date__c,
                                    VT_Appraisal_Service_Settings_Mapped__c, VT_Appraisal_Service_Settings_Notes__c, VT_Appraisal_Service_Set_Days_Due__c, 
                                    VT_Appraisal_Service_Settings_Due__c, VT_Appraisal_Service_Settings_Comp_Date__c, VT_Dynamic_Comments_Setup__c,
                                    VT_Dynamic_Comments_Setup_Notes__c, VT_Dynamic_Comments_Set_Days_Due__c, VT_Dynamic_Comments_Setup_Due__c,
                                    VT_Dynamic_Comments_Setup_Complete_Date__c, VT_Dealer_Form_Settings__c, VT_Dealer_Form_Settings_Notes__c,
                                    VT_Dealer_Form_Set_Days_Due__c, VT_Dealer_Form_Settings_Due_Date__c, VT_Dealer_Forms_Settings_Complete_Date__c, 
                                    VT_Lead_Assignment_Complete__c, VT_Lead_Assignment_Complete_Notes__c, VT_Lead_Assignment_Set_Days_Due__c,
                                    VT_Lead_Assignment_Due_Date__c, VT_Lead_Assignment_Complete_Date__c, VT_Lead_Settings_Complete__c,
                                    VT_Lead_Settings_Complete_Notes__c, VT_Lead_Settings_Set_Days_Due__c, VT_Lead_Settings_Due_Date__c,
                                    VT_Lead_Settings_Complete_Date__c, VT_Add_Customer_Settings__c, VT_Add_Customer_Settings_Notes__c,
                                    VT_Add_Customer_Set_Days_Due__c, VT_Add_Customer_Settings_Due__c, VT_Add_Customer_Settings_Complete_Date__c, 
                                    VT_Road_to_the_Sale_Complete__c, VT_Road_to_the_Sale_Notes__c, VT_Road_to_the_Sale_Set_Days_Due__c, VT_Road_to_the_Sale_Due_Date__c, 
                                    VT_Road_to_the_Sale_Complete_Date__c, VT_Items_Not_Complete_Open_Tickets__c, Virtual_Training_Complete__c,
                                    Virtual_Training_Complete_Notes__c, Virtual_Training_Set_Days_Due__c, Virtual_Training_Due_Date__c,
                                    Virtual_Training_Complete_Date__c, VT_Ad_Hoc_1__c, VT_Ad_Hoc_1_Notes__c, VT_Ad_Hoc_2__c, VT_Ad_Hoc_2_Notes__c, VT_Ad_Hoc_3__c,
                                    VT_Ad_Hoc_3_Notes__c, PT_Overall_Dealer_Health__c, PT_Overall_Dealer_Health_Notes__c, PT_DP_GM_Engagement__c,
                                    PT_DP_GM_Engagement_Notes__c, PT_Sales_Desk_Managers_Engagement__c, PT_Sales_Desk_Managers_Engagement_Notes__c,
                                    PT_Salespeople_Engagement__c, PT_Salespeople_Engagement_Notes__c, PT_VinChampion__c, PT_Number_of_Tickets_Opened__c, 
                                    PT_Tickets_Opened_Notes__c, PT_Scheduled_Custom_Reports__c, PT_Scheduled_Custom_Reports_Notes__c, PT_Scheduled_Custom_Reports_Set_Days_Due__c,
                                    PT_Scheduled_Custom_Reports_Due_Date__c, PT_Scheduled_Custom_Reports_Complete__c, PT_ROI_Settings_Configured__c,
                                    PT_ROI_Settings_Configured_Notes__c, PT_ROI_Settings_Configured_Set_Days_Due__c, PT_ROI_Settings_Configured_Due_Date__c,
                                    PT_ROI_Settings_Configured_Complete_Date__c, PT_Processes_Enabled__c, PT_Processes_Enabled_Notes__c, PT_Processes_Enabled_Set_Days_Due__c,
                                    PT_Processes_Enabled_Due_Date__c, PT_Processes_Enabled_Complete_Date__c, PT_Processes_Customized__c, PT_Processes_Customized_Notes__c,
                                    PT_User_List_Configuration__c, PT_User_List_Configuration_Notes__c, PT_Lead_Assignment_Configuration__c, PT_Lead_Assignment_Configuration_Notes__c,
                                    PT_Lead_Settings_Configuration__c, PT_Lead_Settings_Configuration_Notes__c, PT_Desking_Verified_and_Push_Functioning__c,
                                    PT_Desking_and_Push_Notes__c, PT_Inventory_Verified__c, PT_Inventory_Verified_Notes__c, PT_Inventory_Verified_Set_Days_Due__c,
                                    PT_Inventory_Verified_Due_Date__c, PT_Inventory_Verified_Complete_Date__c, PT_CRM_DMS_Matching_Review__c, PT_CRM_DMS_Matching_Notes__c,
                                    PT_CRM_DMS_Matching_Set_Days_Due__c, PT_CRM_DMS_Matching_Due_Date__c, PT_CRM_DMS_Matching_Complete_Date__c,
                                    PT_Active_Leads_No_Future_Follow_up__c, PT_Active_Leads_No_Future_Notes__c, PT_Active_Leads_No_Future_Set_Days_Due__c,
                                    PT_Active_Leads_No_Future_Due_Date__c, PT_Active_Leads_No_Future_Completed_Date__c, PT_Sales_Opportunity_1__c, PT_Sales_Opportunity_2__c, 
                                    PT_Sales_Opportunity_3__c, PT_Sales_Opportunity_4__c, PT_Ad_Hoc_1__c, PT_Ad_Hoc_1_Notes__c, PT_Ad_Hoc_2__c, PT_Ad_Hoc_2_Notes__c,
                                    PT_Ad_Hoc_3__c, PT_Ad_Hoc_3_Notes__c, Product_Training_Complete__c, Product_Trainer_Comments__c, Product_Training_Complete_Set_Days_Due__c,
                                    Product_Training_Complete_Due_Date__c, Product_Training_Completed_Date__c, Product_Training_Complete_On_Time__c, 
                                    PT_Active_Leads_No_Future_On_Time__c, PT_CRM_DMS_Matching_On_Time__c, PT_Inventory_Verified_On_Time__c, PT_Processes_Enabled_On_Time__c,
                                    PT_ROI_Settings_Configured_On_Time__c, PT_Scheduled_Custom_Reports_On_Time__c, Virtual_Training_Complete_On_Time__c,
                                    VT_Add_Customer_Settings_On_Time__c, VT_Additional_Admin_Settings_On_Time__c, VT_Admin_Class_Completed_On_Time__c, 
                                    VT_Appraisal_Service_Settings_On_Time__c, VT_Dealer_Form_Settings_On_Time__c, VT_Dynamic_Comments_Setup_On_Time__c, 
                                    VT_Lead_Assignment_Complete_On_Time__c, VT_Lead_Settings_Complete_On_Time__c, VT_Manager_Class_Complete_On_Time__c, 
                                    VT_Road_to_the_Sale_On_Time__c, VT_Sales_Classes_Complete_On_Time__c, Product_Trainer__c, Virtual_Trainer__c, VT_Answered__c,
                                    VT_Score_Count__c, VT_Score__c, VT_Dealer_Grade__c, Implementation_Answered_New__c, Implementation_Score_Count_New__c,
                                    VT_On_Time_Score__c, PT_Dealer_Grade__c, PT_Answered__c, PT_Score_Count__c, PT_Score__c, PT_On_Time_Score__c, Creative_Answered_New__c,
                                    Creative_Score_Count_New__c, Set_Project_Start_Date__c, Set_Virtual_Training_Start_Date__c, Set_Training_Start_Date__c,
                                    Project__r.Project_Due_Date__c, VT_Dealer_Grade_Count__c, VT_Dealer_Grade_Answered__c, PT_Dealer_Grade_Count__c, PT_Dealer_Grade_Answered__c
                    	      FROM 	Recap__c
                    	     WHERE 	Id = :RecapId LIMIT 1];
        	    InitializeProjectInfo();
                //IF the Project Alternate Start Date is null then use the Project's created date
                if(projectAlternateStart != null){
                    projectStartDate = 'Alternate_Start_Date__c';
                    oldProjectStartDate = Date.newInstance(projectAlternateStart.year(), projectAlternateStart.month(), projectAlternateStart.day());
                }
                else{
                    projectStartDate = 'CreatedDate';
                    oldProjectStartDate = Date.newInstance(projectCreatedDate.year(), projectCreatedDate.month(), projectCreatedDate.day());
                }
                //If the Project Start Date has changed then update the default dates
                if(oldProjectStartDate != RecapObj.Set_Project_Start_Date__c){
                    resetLaunchAndImplementationDefaultSetDaysDue = true;
                    getProjectInfo();
                    InitializeLaunchAndImplementationDefaultDates();
                }
                //IF the Project's Virtual Training Start Date is null then use the Project's created date
                if(projectVirtualTrainingStart != null){
                    virtualTrainingStartDate = 'Virtual_Training_Start_Date__c';
                    oldVirtualStartDate = Date.newInstance(projectVirtualTrainingStart.year(), projectVirtualTrainingStart.month(), projectVirtualTrainingStart.day());
                }
                else{
                    virtualTrainingStartDate = 'CreatedDate';
                    oldVirtualStartDate = Date.newInstance(projectCreatedDate.year(), projectCreatedDate.month(), projectCreatedDate.day());
                }
                //If the Virtual Training Start Date has changed then update the default dates
                if(oldVirtualStartDate != RecapObj.Set_Virtual_Training_Start_Date__c){
                    resetVirtualDefaultSetDaysDue = true;
                    getProjectInfo();
                    InitializeVirtualDefaultDates();
                }
                //IF the Project's Training Start Date is null then use the Project's Due date
                if(projectTrainingStart != null){
                    trainingStartDate = 'Confirmed_Training_Start__c';
                    oldTrainingStartDate = Date.newInstance(projectTrainingStart.year(), projectTrainingStart.month(), projectTrainingStart.day());
                }
                else{
                    trainingStartDate = 'Project_Due_Date__c';
                    oldTrainingStartDate = Date.newInstance(projectDueDate.year(), projectDueDate.month(), projectDueDate.day());
                }
                //If the Training Start Date has changed then update the default dates
                if(oldTrainingStartDate != RecapObj.Set_Training_Start_Date__c){
                    resetOnSiteDefaultSetDaysDue = true;
                    getProjectInfo();
                    InitializeOnSiteDefaultDates();
                }
        	}

            // If not an existing Recap then create a new Recap and pull project info from parent project
        	else {
        		setPicklistDefaults = true;
                getProjectInfo();
                InitializeProjectInfo();
        		RecapObj = new Recap__c();
                //IF the Project Alternate Start Date is null then use the Project's created date
                if(projectAlternateStart != null){
                    projectStartDate = 'Alternate_Start_Date__c';
                }
                else{
                    projectStartDate = 'CreatedDate';
                }
                //IF the Project's Virtual Training Start Date is null then use the Project's created date
                if(projectVirtualTrainingStart != null){
                    virtualTrainingStartDate = 'Virtual_Training_Start_Date__c';
                }
                else{
                    virtualTrainingStartDate = 'CreatedDate';
                }
                //IF the Project's Training Start Date is null then use the Project's Due date
                if(projectTrainingStart != null){
                    trainingStartDate = 'Confirmed_Training_Start__c';
                }
                else{
                    trainingStartDate = 'Project_Due_Date__c';
                }
                // If there is no Project data then there is no Project CreatedDate, skip InitializeDefaultDates
                if(Project != null){
                    resetLaunchAndImplementationDefaultSetDaysDue = true;
                    resetVirtualDefaultSetDaysDue = true;
                    resetOnSiteDefaultSetDaysDue = true;
                    InitializeLaunchAndImplementationDefaultDates();
                    InitializeVirtualDefaultDates();
                    InitializeOnSiteDefaultDates();
                }
        	}
        }
        catch (exception e) {
            System.debug('getRecapObj() encountered exception: '+e.getMessage());
            throw e;
        }
    }

    // Query for Project Info for a new Recap upon page load
    public void getProjectInfo() {
        try {
            if (projectId != null) {
                Project = [SELECT   Id, Name, CreatedDate, Vin_Performance_Manager__c, Vin_Performance_Manager__r.Name, Trainer_4__r.Name,
                					Opportunity__c, Opportunity__r.Id, Opportunity__r.Name, Build_Type__c, Opportunity__r.Owner.Name,
                					Alternate_Start_Date__c, Confirmed_Training_Start__c, Confirmed_Training_End__c, Virtual_Training_Start_Date__c,
                					Account__c, Account__r.Id, Account__r.Name, Account__r.AccountNumber, Owner.Name, Assigned_Specialist__r.Name, 
                					Launch_Coordinator__r.Name, Project_Due_Date__c
                              FROM  SFDC_520_Quote__c
                             WHERE  Id = :projectId LIMIT 1];
            }
            else {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There is no project for this Recap. Use the Create Scorecard button on Recap Related list on an existing project.');
                ApexPages.addMessage(myMsg);
            }
        }
        catch (exception e) {
            System.debug('getProjectInfo() encountered exception: '+e.getMessage());
            throw e;
        }
    }

    // Query for Training Object Link
    public void getTrainingObjLink() {
    	TrainingLinks = new List<Training__c>();
        try {
            if (projectId != null) {
                TrainingLinks = [SELECT  Id, Name, RecordType.Name, Training_Type__c, Number_of_Days_This_Training__c, Related_Project__c, Assigned_Trainer__r.Name
                              	  FROM  Training__c
                             	 WHERE  Related_Project__c = :projectId
                             	   AND 	RecordType.Name = 'Travel'
                             	   AND 	Training_Type__c = 'New Install'
                              ORDER BY 	Number_of_Days_This_Training__c DESC];
            }
            else if(RecapObj.Project__r.Id != null){
            	TrainingLinks = [SELECT  Id, Name, RecordType.Name, Training_Type__c, Number_of_Days_This_Training__c, Related_Project__c, Assigned_Trainer__r.Name
                              	  FROM  Training__c
                             	 WHERE  Related_Project__c = :projectId
                             	   AND 	RecordType.Name = 'Travel'
                             	   AND 	Training_Type__c = 'New Install'
                              ORDER BY 	Number_of_Days_This_Training__c DESC];
            }
            else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'There is no project for this Recap. Unable to find an associated Training Record.');
                ApexPages.addMessage(myMsg);
            }
        }
        catch (exception e) {
            System.debug('getTrainingObjLink() encountered exception: '+e.getMessage());
            throw e;
        }
        // Get the training record with the most Number_of_Days_This_Training__c and use if for the link
        if(TrainingLinks.size() > 0){
        	trainingLinkId = TrainingLinks[0].Id;
        	trainingLinkName = TrainingLinks[0].Name;
            trainingAssignedTrainer = TrainingLinks[0].Assigned_Trainer__r.Name;
        }
        // Otherwise display no record found
        else{
        	trainingLinkId = '';
        	trainingLinkName = 'No Record Found';
            trainingAssignedTrainer = '';
        }
    }

    // Need to Setup page with project info for a new Recap that hasn't been saved
    public void InitializeProjectInfo() {
    	// If this is a new Recap, set variables from project
    	if(RecapId == null && projectId != null){
	        projectName = Project.Name;
	        projectOwner = Project.Owner.Name;
	        projectCreatedDate = Date.valueOf(Project.CreatedDate);
            projectDueDate = Project.Project_Due_Date__c;
	        projectAlternateStart = Project.Alternate_Start_Date__c;
	        projectAcctId = Project.Account__r.Id;
	        projectAcctName = Project.Account__r.Name;
	        projectAcctDealerID = Project.Account__r.AccountNumber;
	        projectOppId = Project.Opportunity__r.Id;
	        projectOppName = Project.Opportunity__r.Name;
	        projectBuildType = Project.Build_Type__c;
	        if(projectBuildType != null && projectBuildType != ''){
        		projectBuildType = getSplitString(projectBuildType);
        	}	
	        projectTrainingStart = Project.Confirmed_Training_Start__c;
	        projectTrainingEnd = Project.Confirmed_Training_End__c;
	        projectVirtualTrainingStart = Project.Virtual_Training_Start_Date__c;
	        projectSpecialist = Project.Assigned_Specialist__r.Name;
	        projectLaunchConsultant = Project.Launch_Coordinator__r.Name;
	        projectVinPerformanceManagerName = Project.Vin_Performance_Manager__r.Name;
	        projectRegionalSalesManagerName = Project.Opportunity__r.Owner.Name;
	        projectVirtualTrainerName = Project.Trainer_4__r.Name;
        }
        // If this is an existing Recap, set variables from the Recap
        else if(RecapId != null){
    		projectId = RecapObj.Project__r.Id;
        	projectName = RecapObj.Project__r.Name;
        	projectOwner = RecapObj.Project__r.Owner.Name;
	        projectCreatedDate = Date.valueOf(RecapObj.Project__r.CreatedDate);
            projectDueDate = RecapObj.Project__r.Project_Due_Date__c;
	        projectAlternateStart = RecapObj.Project__r.Alternate_Start_Date__c;
	        projectAcctId = RecapObj.Project__r.Account__r.Id;
	        projectAcctName = RecapObj.Account_Name__c;
	        projectAcctDealerID = RecapObj.Dealer_ID__c;
	        projectOppId = RecapObj.Project__r.Opportunity__r.Id;
	        projectOppName = RecapObj.Project__r.Opportunity__r.Name;
	        projectBuildType = RecapObj.Project__r.Build_Type__c;
	        if(projectBuildType != null && projectBuildType != ''){
        		projectBuildType = getSplitString(projectBuildType);
        	}
	        projectTrainingStart = RecapObj.Project__r.Confirmed_Training_Start__c;
	        projectTrainingEnd = RecapObj.Project__r.Confirmed_Training_End__c;
	        projectVirtualTrainingStart = RecapObj.Project__r.Virtual_Training_Start_Date__c;
	        projectSpecialist = RecapObj.Project__r.Assigned_Specialist__r.Name;
	        projectLaunchConsultant = RecapObj.Project__r.Launch_Coordinator__r.Name;
	        projectVinPerformanceManagerName = RecapObj.Project__r.Vin_Performance_Manager__r.Name;
	        projectRegionalSalesManagerName = RecapObj.Project__r.Opportunity__r.Owner.Name;
	        projectVirtualTrainerName = RecapObj.Project__r.Trainer_4__r.Name;
        }
    }

    // Retrieve the default values of the Set Days Due Fields to set the default Due Dates
    public void InitializeLaunchAndImplementationDefaultDates() {
        if(resetLaunchAndImplementationDefaultSetDaysDue){
            resetConsultantAndImplementationDefaults();
        }
        // Launch Consultant Section
        RecapObj.Users_Entered_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Users_Entered_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Admin_Settings_Verification_Form_Due_Dat__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Admin_Settings_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Processes_and_Templates_Verification_Due__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Processes_and_Temp_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Desking_Verification_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Desking_Verification_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.DMS_Push_Due__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.DMS_Push_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.DT_R1_Push_Due__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.DT_R1_Push_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.CarFax_AutoCheck_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Carfax_Autocheck_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Text_Messaging_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Text_Messaging_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Credit_Bureau_Setup_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Credit_Bureau_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        // Implementation Consultant Section
        RecapObj.Inventory_Verification_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Inventory_Verified_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.BAC_and_Dealer_Code_Due__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.BAC_and_Dealer_Code_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Success_Fail_Verification_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Success_Fail_Verification_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Sales_Report_Verification_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Sales_Report_Verification_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.AIS_Rebates_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.AIS_Rebates_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.PBX_Setup_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.PBX_Setup_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Call_Provider_Call_Tracking_Due__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Call_Provider_Call_Tracking_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Trade_Appraisal_Push_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Trade_Appraisal_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Lot_Vantage_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(integer.valueof(Recap__c.Lot_Vantage_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
    }

    public void InitializeVirtualDefaultDates(){
        if(resetVirtualDefaultSetDaysDue){
            resetVirtualDefaults();
        }
         // Virtual Trainer Section
        RecapObj.VT_Admin_Class_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Admin_Class_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Manager_Class_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Manager_Class_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Sales_Classes_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Sales_Classes_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Additional_Admin_Settings_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Additional_Admin_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Appraisal_Service_Settings_Due__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Appraisal_Service_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Dynamic_Comments_Setup_Due__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Dynamic_Comments_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Dealer_Form_Settings_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Dealer_Form_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Lead_Assignment_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Lead_Assignment_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Lead_Settings_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Lead_Settings_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Add_Customer_Settings_Due__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Add_Customer_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.VT_Road_to_the_Sale_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.VT_Road_to_the_Sale_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Virtual_Training_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(integer.valueof(Recap__c.Virtual_Training_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
    }

    public void InitializeOnSiteDefaultDates(){
        if(resetOnSiteDefaultSetDaysDue){
            resetOnSiteDefaults();
        }
        // On-Site Training Section
        RecapObj.PT_Scheduled_Custom_Reports_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(trainingStartDate)).addDays(integer.valueof(Recap__c.PT_Scheduled_Custom_Reports_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.PT_ROI_Settings_Configured_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(trainingStartDate)).addDays(integer.valueof(Recap__c.PT_ROI_Settings_Configured_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.PT_Processes_Enabled_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(trainingStartDate)).addDays(integer.valueof(Recap__c.PT_Processes_Enabled_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.PT_Inventory_Verified_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(trainingStartDate)).addDays(integer.valueof(Recap__c.PT_Inventory_Verified_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.PT_CRM_DMS_Matching_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(trainingStartDate)).addDays(integer.valueof(Recap__c.PT_CRM_DMS_Matching_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.PT_Active_Leads_No_Future_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(trainingStartDate)).addDays(integer.valueof(Recap__c.PT_Active_Leads_No_Future_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
        RecapObj.Product_Training_Complete_Due_Date__c = Date.valueOf(Date.valueOf(Project.get(trainingStartDate)).addDays(integer.valueof(Recap__c.Product_Training_Complete_Set_Days_Due__c.getDescribe().getDefaultValueFormula())));
    }

     public void resetConsultantAndImplementationDefaults() {
        // Launch Consultant Section
        RecapObj.Users_Entered_Set_Days_Due__c = integer.valueof(Recap__c.Users_Entered_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Admin_Settings_Set_Days_Due__c = integer.valueof(Recap__c.Admin_Settings_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Processes_and_Temp_Set_Days_Due__c = integer.valueof(Recap__c.Processes_and_Temp_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Desking_Verification_Set_Days_Due__c = integer.valueof(Recap__c.Desking_Verification_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.DMS_Push_Set_Days_Due__c = integer.valueof(Recap__c.DMS_Push_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.DT_R1_Push_Set_Days_Due__c = integer.valueof(Recap__c.DT_R1_Push_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Carfax_Autocheck_Set_Days_Due__c = integer.valueof(Recap__c.Carfax_Autocheck_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Text_Messaging_Set_Days_Due__c = integer.valueof(Recap__c.Text_Messaging_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Credit_Bureau_Set_Days_Due__c = integer.valueof(Recap__c.Credit_Bureau_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        // Implementation Consultant Section
        RecapObj.Inventory_Verified_Set_Days_Due__c = integer.valueof(Recap__c.Inventory_Verified_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.BAC_and_Dealer_Code_Set_Days_Due__c = integer.valueof(Recap__c.BAC_and_Dealer_Code_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Success_Fail_Verification_Set_Days_Due__c = integer.valueof(Recap__c.Success_Fail_Verification_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Sales_Report_Verification_Set_Days_Due__c = integer.valueof(Recap__c.Sales_Report_Verification_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.AIS_Rebates_Set_Days_Due__c = integer.valueof(Recap__c.AIS_Rebates_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.PBX_Setup_Set_Days_Due__c = integer.valueof(Recap__c.PBX_Setup_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Call_Provider_Call_Tracking_Set_Days_Due__c = integer.valueof(Recap__c.Call_Provider_Call_Tracking_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Trade_Appraisal_Set_Days_Due__c = integer.valueof(Recap__c.Trade_Appraisal_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Lot_Vantage_Set_Days_Due__c = integer.valueof(Recap__c.Lot_Vantage_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
    }

    public void resetVirtualDefaults() {
        // Virtual Trainer Section
        RecapObj.VT_Admin_Class_Set_Days_Due__c = integer.valueof(Recap__c.VT_Admin_Class_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Manager_Class_Set_Days_Due__c = integer.valueof(Recap__c.VT_Manager_Class_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Sales_Classes_Set_Days_Due__c = integer.valueof(Recap__c.VT_Sales_Classes_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Additional_Admin_Set_Days_Due__c = integer.valueof(Recap__c.VT_Additional_Admin_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Appraisal_Service_Set_Days_Due__c = integer.valueof(Recap__c.VT_Appraisal_Service_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Dynamic_Comments_Set_Days_Due__c = integer.valueof(Recap__c.VT_Dynamic_Comments_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Dealer_Form_Set_Days_Due__c = integer.valueof(Recap__c.VT_Dealer_Form_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Lead_Assignment_Set_Days_Due__c = integer.valueof(Recap__c.VT_Lead_Assignment_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Lead_Settings_Set_Days_Due__c = integer.valueof(Recap__c.VT_Lead_Settings_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Add_Customer_Set_Days_Due__c = integer.valueof(Recap__c.VT_Add_Customer_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.VT_Road_to_the_Sale_Set_Days_Due__c = integer.valueof(Recap__c.VT_Road_to_the_Sale_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Virtual_Training_Set_Days_Due__c = integer.valueof(Recap__c.Virtual_Training_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
    
    }
    public void resetOnSiteDefaults() {
        // On-Site Training Section
        RecapObj.PT_Scheduled_Custom_Reports_Set_Days_Due__c = integer.valueof(Recap__c.PT_Scheduled_Custom_Reports_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.PT_ROI_Settings_Configured_Set_Days_Due__c = integer.valueof(Recap__c.PT_ROI_Settings_Configured_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.PT_Processes_Enabled_Set_Days_Due__c = integer.valueof(Recap__c.PT_Processes_Enabled_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.PT_Inventory_Verified_Set_Days_Due__c = integer.valueof(Recap__c.PT_Inventory_Verified_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.PT_CRM_DMS_Matching_Set_Days_Due__c = integer.valueof(Recap__c.PT_CRM_DMS_Matching_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.PT_Active_Leads_No_Future_Set_Days_Due__c = integer.valueof(Recap__c.PT_Active_Leads_No_Future_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
        RecapObj.Product_Training_Complete_Set_Days_Due__c = integer.valueof(Recap__c.Product_Training_Complete_Set_Days_Due__c.getDescribe().getDefaultValueFormula());
    }

    // Method to set the picklist default values when the page first opens
    public void setDefaults(){
    	// Launch Consultant Section
        selectedLUE = 'N/A';
        selectedASV = 'N/A';
        selectedLPT = 'N/A';
	    selectedPTV = 'N/A';
        selectedDMS = 'N/A';
        selectedDLF = 'N/A';
	    selectedLDV = 'N/A';
        selectedUPL = 'N/A';
        selectedVER = 'N/A';
	    selectedLDP = 'N/A';
        selectedDTR = 'N/A';
        selectedDR1 = 'N/A';
        selectedFTP = 'N/A';
        selectedIGC = 'N/A';
        selectedCAR = 'N/A';
        selectedMES = 'N/A';
        selectedCBS = 'N/A';
        selectedICT = 'N/A';
        selectedILU = 'N/A';
        selectedTLS = 'N/A';
	    selectedLA1 = 'N/A';
	    selectedLA2 = 'N/A';
	    selectedLA3 = 'N/A';
	    // Implementation Consultant Section
        selectedIIV = 'N/A';
        selectedIBB = 'N/A';
        selectedIIC = 'N/A';
        selectedISU = 'N/A';
        selectedIBA = 'N/A';
        selectedICR = 'N/A';
	    selectedSFV = 'N/A';
	    selectedCNC = 'N/A';
        selectedISO = 'N/A';
        selectedISA = 'N/A';
        selectedISE = 'N/A';
        selectedIOP = 'N/A';
        selectedIDE = 'N/A';
        selectedIAI = 'N/A';
        selectedIPB = 'N/A';
        selectedIDA = 'N/A';
        selectedICA = 'N/A';
        selectedITR = 'N/A';
	    selectedILV = 'N/A';
	    selectedIXT = 'N/A';
	    selectedIA1 = 'N/A';
	    selectedIA2 = 'N/A';
	    selectedIA3 = 'N/A';
	    // Creative Section
        selectedPOC = 'N/A';
        selectedEBC = 'N/A';
    	selectedIP1 = 'N/A';
    	selectedIP2 = 'N/A';
    	selectedIP3 = 'N/A';
    	// Virtual Trainer Section
        selectedODH = 'N/A';
    	selectedACC = 'N/A';
        selectedAEI = 'N/A';
		selectedMCC = 'N/A';
        selectedMEI = 'N/A';
		selectedSCC = 'N/A';
        selectedSEI = 'N/A';
		selectedASC = 'N/A';
		selectedSSM = 'N/A';
		selectedDCS = 'N/A';
		selectedDFS = 'N/A';
		selectedVLA = 'N/A';
		selectedVLS = 'N/A';
		selectedACS = 'N/A';
		selectedVRS = 'N/A';
		selectedVTC = 'N/A';
		selectedVA1 = 'N/A';
		selectedVA2 = 'N/A';
		selectedVA3 = 'N/A';
    	// On-Site Training Section
        selectedPOT = 'N/A';
        selectedDGE = 'N/A';
        selectedDME = 'N/A';
        selectedPSE = 'N/A';
		selectedSCR = 'N/A';
		selectedRSC = 'N/A';
		selectedPPE = 'N/A';
		selectedPPC = 'N/A';
		selectedULC = 'N/A';
		selectedLAC = 'N/A';
		selectedLSC = 'N/A';
		selectedDVF = 'N/A';
		selectedPIV = 'N/A';
		selectedCDM = 'N/A';
		selectedALF = 'N/A';
		selectedAH1 = 'N/A';
		selectedAH2 = 'N/A';
		selectedAH3 = 'N/A';
		selectedPTC = 'N/A';
    }

    // Method to set the picklist saved values
    public void setValues(){
    	// Launch Consultant Section
        selectedLUE = RecapObj.q1__c;
        selectedASV = RecapObj.R01__c;
        selectedLPT = RecapObj.q16__c;
	    selectedPTV = RecapObj.Processes_and_Templates_Verification__c;
        selectedDMS = RecapObj.R07__c;
        selectedDLF = RecapObj.R08__c;
	    selectedLDV = RecapObj.Desking_Verification__c;
        selectedUPL = RecapObj.R05__c;
        selectedVER = RecapObj.q21__c;
	    selectedLDP = RecapObj.DMS_Push__c;
        selectedDTR = RecapObj.q24__c;
        selectedDR1 = RecapObj.DT_RT_1_Enabled_Tested__c;
        selectedFTP = RecapObj.q34__c;
        selectedIGC = RecapObj.q7__c;
        selectedCAR = RecapObj.q6__c;
        selectedMES = RecapObj.q26__c;
        selectedCBS = RecapObj.q29__c;
        selectedICT = RecapObj.Target__c;
        selectedILU = RecapObj.Limited_Users__c;
        selectedTLS = RecapObj.Test_Lead_Submitted__c;
	    selectedLA1 = RecapObj.LC_Ad_Hoc_1__c;
	    selectedLA2 = RecapObj.LC_Ad_Hoc_2__c;
	    selectedLA3 = RecapObj.LC_Ad_Hoc_3__c;
	    // Implementation Consultant Section
        selectedIIV = RecapObj.q2__c;
        selectedIBB = RecapObj.q8__c;
        selectedIIC = RecapObj.q4__c;
        selectedISU = RecapObj.q5__c;
        selectedIBA = RecapObj.q13__c;
        selectedICR = RecapObj.q12__c;
	    selectedSFV = RecapObj.Success_Fail_Verification__c;
	    selectedCNC = RecapObj.CRM_Notes_Completed__c;
        selectedISO = RecapObj.q19__c;
        selectedISA = RecapObj.R14__c;
        selectedISE = RecapObj.q20__c;
        selectedIOP = RecapObj.R17__c;
        selectedIDE = RecapObj.q23__c;
        selectedIAI = RecapObj.q27__c;
        selectedIPB = RecapObj.q28__c;
        selectedIDA = RecapObj.R18__c;
        selectedICA = RecapObj.q30__c;
        selectedITR = RecapObj.q31__c;
	    selectedILV = RecapObj.Lot_Vantage__c;
	    selectedIXT = RecapObj.xTime__c;
	    selectedIA1 = RecapObj.IC_Ad_Hoc_1__c;
	    selectedIA2 = RecapObj.IC_Ad_Hoc_2__c;
	    selectedIA3 = RecapObj.IC_Ad_Hoc_3__c;
	    // Creative Section
        selectedPOC = RecapObj.q11__c;
        selectedEBC = RecapObj.q15__c;
    	selectedIP1 = RecapObj.IPM_Ad_Hoc_1__c;
    	selectedIP2 = RecapObj.IPM_Ad_Hoc_2__c;
    	selectedIP3 = RecapObj.IPM_Ad_Hoc_3__c;
    	// Virtual Trainer Section
        selectedODH = RecapObj.VT_Overall_Dealer_Health__c;
    	selectedACC = RecapObj.VT_Admin_Class_Complete__c;
        selectedAEI = RecapObj.VT_Admin_Engagement_and_Interaction__c;
		selectedMCC = RecapObj.VT_Manager_Class_Complete__c;
        selectedMEI = RecapObj.VT_Manager_Engagement_and_Interaction__c;
		selectedSCC = RecapObj.VT_Sales_Classes_Complete__c;
        selectedSEI = RecapObj.VT_Sales_Engagement_and_Interaction__c;
		selectedASC = RecapObj.VT_Additional_Admin_Settings_Complete__c;
		selectedSSM = RecapObj.VT_Appraisal_Service_Settings_Mapped__c;
		selectedDCS = RecapObj.VT_Dynamic_Comments_Setup__c;
		selectedDFS = RecapObj.VT_Dealer_Form_Settings__c;
		selectedVLA = RecapObj.VT_Lead_Assignment_Complete__c;
		selectedVLS = RecapObj.VT_Lead_Settings_Complete__c;
		selectedACS = RecapObj.VT_Add_Customer_Settings__c;
		selectedVRS = RecapObj.VT_Road_to_the_Sale_Complete__c;
		selectedVTC = RecapObj.Virtual_Training_Complete__c;
		selectedVA1 = RecapObj.VT_Ad_Hoc_1__c;
		selectedVA2 = RecapObj.VT_Ad_Hoc_2__c;
		selectedVA3 = RecapObj.VT_Ad_Hoc_3__c;
    	// On-Site Training Section
        selectedPOT = RecapObj.PT_Overall_Dealer_Health__c;
        selectedDGE = RecapObj.PT_DP_GM_Engagement__c;
        selectedDME = RecapObj.PT_Sales_Desk_Managers_Engagement__c;
        selectedPSE = RecapObj.PT_Salespeople_Engagement__c;
    	selectedSCR = RecapObj.PT_Scheduled_Custom_Reports__c;
    	selectedRSC = RecapObj.PT_ROI_Settings_Configured__c;
    	selectedPPE = RecapObj.PT_Processes_Enabled__c;
    	selectedPPC = RecapObj.PT_Processes_Customized__c;
    	selectedULC = RecapObj.PT_User_List_Configuration__c;
    	selectedLAC = RecapObj.PT_Lead_Assignment_Configuration__c;
    	selectedLSC = RecapObj.PT_Lead_Settings_Configuration__c;
    	selectedDVF = RecapObj.PT_Desking_Verified_and_Push_Functioning__c;
    	selectedPIV = RecapObj.PT_Inventory_Verified__c;
    	selectedCDM = RecapObj.PT_CRM_DMS_Matching_Review__c;
    	selectedALF = RecapObj.PT_Active_Leads_No_Future_Follow_up__c;
    	selectedAH1 = RecapObj.PT_Ad_Hoc_1__c;
    	selectedAH2 = RecapObj.PT_Ad_Hoc_2__c;
    	selectedAH3 = RecapObj.PT_Ad_Hoc_3__c;
    	selectedPTC = RecapObj.Product_Training_Complete__c;
    }
     
    // Action Methods    
    public PageReference getDueDate(){
        if(setDays != null){
    		if(RecapId == null && projectId != null){
            	RecapObj.put(field, Date.valueOf(Date.valueOf(Project.get(projectStartDate)).addDays(Integer.valueOf(RecapObj.get(setDays)))));
            }
            else if(RecapId != null){
            	RecapObj.put(field, Date.valueOf(Date.valueOf(RecapObj.Project__r.get(projectStartDate)).addDays(Integer.valueOf(RecapObj.get(setDays)))));
            }
        }
		return null;
    }    
    public PageReference getVirtualDueDate(){
        if(setDays != null){
            if(RecapId == null && projectId != null){
                RecapObj.put(field, Date.valueOf(Date.valueOf(Project.get(virtualTrainingStartDate)).addDays(Integer.valueOf(RecapObj.get(setDays)))));
            }
            else if(RecapId != null){
                RecapObj.put(field, Date.valueOf(Date.valueOf(RecapObj.Project__r.get(virtualTrainingStartDate)).addDays(Integer.valueOf(RecapObj.get(setDays)))));
            }
        }
        return null;
    }    
    public PageReference getOnSiteDueDate(){
        if(setDays != null){
            if(RecapId == null && projectId != null){
                RecapObj.put(field, Date.valueOf(Date.valueOf(Project.get(trainingStartDate)).addDays(Integer.valueOf(RecapObj.get(setDays)))));
            }
            else if(RecapId != null){
                RecapObj.put(field, Date.valueOf(Date.valueOf(RecapObj.Project__r.get(trainingStartDate)).addDays(Integer.valueOf(RecapObj.get(setDays)))));
            }
        }
        return null;
    }
    // Split the string by ; and add spaces
    public String getSplitString(String sType){
    	List<String> s = sType.split(';');
		for (Integer i = 0; i <= s.size()-1; i++) {
			if(i == 0){
				sType = s[i];
			}
			else{
				sType = sType + ';  ' + s[i];
			}
		}
		return sType;
    }

    public PageReference Save() {
    	validate();
        
	// Project Details Section
		RecapObj.Project__c = projectId;
        RecapObj.Product_Trainer__c = trainingAssignedTrainer;
        if(RecapId == null && projectId != null){
            RecapObj.Set_Project_Start_Date__c = Date.valueOf(Project.get(projectStartDate));
            RecapObj.Set_Virtual_Training_Start_Date__c = Date.valueOf(Project.get(virtualTrainingStartDate));
            RecapObj.Set_Training_Start_Date__c = Date.valueOf(Project.get(trainingStartDate));
        }
        else if(RecapId != null){
            RecapObj.Set_Project_Start_Date__c = Date.valueOf(RecapObj.Project__r.get(projectStartDate));
            RecapObj.Set_Virtual_Training_Start_Date__c = Date.valueOf(RecapObj.Project__r.get(virtualTrainingStartDate));
            RecapObj.Set_Training_Start_Date__c = Date.valueOf(RecapObj.Project__r.get(trainingStartDate));
        }
	// Scores Section
		if(totalScore != null){
			RecapObj.Total_Score_New__c = totalScore;
		}

	// Launch Consultant Section
        RecapObj.q1__c = selectedLUE;
        RecapObj.R01__c = selectedASV;
        RecapObj.q16__c = selectedLPT;
		RecapObj.Processes_and_Templates_Verification__c = selectedPTV;
        RecapObj.R07__c = selectedDMS;
        RecapObj.R08__c = selectedDLF;
	    RecapObj.Desking_Verification__c = selectedLDV;
        RecapObj.R05__c = selectedUPL;
        RecapObj.q21__c = selectedVER;
	    RecapObj.DMS_Push__c = selectedLDP;
        RecapObj.q24__c = selectedDTR;
        RecapObj.DT_RT_1_Enabled_Tested__c = selectedDR1;
        RecapObj.q34__c = selectedFTP;
        RecapObj.q7__c = selectedIGC;
        RecapObj.q6__c = selectedCAR;
        RecapObj.q26__c = selectedMES;
        RecapObj.q29__c = selectedCBS;
        RecapObj.Target__c = selectedICT;
        RecapObj.Limited_Users__c = selectedILU;
        RecapObj.Test_Lead_Submitted__c = selectedTLS;
	    RecapObj.LC_Ad_Hoc_1__c = selectedLA1;
	    RecapObj.LC_Ad_Hoc_2__c = selectedLA2;
	    RecapObj.LC_Ad_Hoc_3__c = selectedLA3;

    // Implementation Consultant Section
        RecapObj.q2__c = selectedIIV;
        RecapObj.q8__c = selectedIBB;
        RecapObj.q4__c = selectedIIC;
        RecapObj.q5__c = selectedISU;
        RecapObj.q13__c = selectedIBA;
        RecapObj.q12__c = selectedICR;
	    RecapObj.Success_Fail_Verification__c = selectedSFV;
	    RecapObj.CRM_Notes_Completed__c = selectedCNC;
        RecapObj.q19__c = selectedISO;
        RecapObj.R14__c = selectedISA;
        RecapObj.q20__c = selectedISE;
        RecapObj.R17__c = selectedIOP;
        RecapObj.q23__c = selectedIDE;
        RecapObj.q27__c = selectedIAI;
        RecapObj.q28__c = selectedIPB;
        RecapObj.R18__c = selectedIDA;
        RecapObj.q30__c = selectedICA;
        RecapObj.q31__c = selectedITR;
	    RecapObj.Lot_Vantage__c = selectedILV;
	    RecapObj.xTime__c = selectedIXT;
	    RecapObj.IC_Ad_Hoc_1__c = selectedIA1;
	    RecapObj.IC_Ad_Hoc_2__c = selectedIA2;
	    RecapObj.IC_Ad_Hoc_3__c = selectedIA3;

    // Creative Section
        RecapObj.q11__c = selectedPOC;
        RecapObj.q15__c = selectedEBC;
    	RecapObj.IPM_Ad_Hoc_1__c = selectedIP1;
    	RecapObj.IPM_Ad_Hoc_2__c = selectedIP2;
    	RecapObj.IPM_Ad_Hoc_3__c = selectedIP3;

	// Virtual Trainer Section
        RecapObj.VT_Overall_Dealer_Health__c = selectedODH;
		RecapObj.VT_Admin_Class_Complete__c = selectedACC;
        RecapObj.VT_Admin_Engagement_and_Interaction__c = selectedAEI;
		RecapObj.VT_Manager_Class_Complete__c = selectedMCC;
        RecapObj.VT_Manager_Engagement_and_Interaction__c = selectedMEI;
		RecapObj.VT_Sales_Classes_Complete__c = selectedSCC;
        RecapObj.VT_Sales_Engagement_and_Interaction__c = selectedSEI;
		RecapObj.VT_Additional_Admin_Settings_Complete__c = selectedASC;
		RecapObj.VT_Appraisal_Service_Settings_Mapped__c = selectedSSM;
		RecapObj.VT_Dynamic_Comments_Setup__c = selectedDCS;
		RecapObj.VT_Dealer_Form_Settings__c = selectedDFS;
		RecapObj.VT_Lead_Assignment_Complete__c = selectedVLA;
		RecapObj.VT_Lead_Settings_Complete__c = selectedVLS;
		RecapObj.VT_Add_Customer_Settings__c = selectedACS;
		RecapObj.VT_Road_to_the_Sale_Complete__c = selectedVRS;
		RecapObj.Virtual_Training_Complete__c = selectedVTC;
		RecapObj.VT_Ad_Hoc_1__c = selectedVA1;
		RecapObj.VT_Ad_Hoc_2__c = selectedVA2;
		RecapObj.VT_Ad_Hoc_3__c = selectedVA3;

	// On-Site Training Section
        RecapObj.PT_Overall_Dealer_Health__c = selectedPOT;
        RecapObj.PT_DP_GM_Engagement__c = selectedDGE;
        RecapObj.PT_Sales_Desk_Managers_Engagement__c = selectedDME;
        RecapObj.PT_Salespeople_Engagement__c = selectedPSE;
    	RecapObj.PT_Scheduled_Custom_Reports__c = selectedSCR;
    	RecapObj.PT_ROI_Settings_Configured__c = selectedRSC;
    	RecapObj.PT_Processes_Enabled__c = selectedPPE;
    	RecapObj.PT_Processes_Customized__c = selectedPPC;
    	RecapObj.PT_User_List_Configuration__c = selectedULC;
    	RecapObj.PT_Lead_Assignment_Configuration__c = selectedLAC;
    	RecapObj.PT_Lead_Settings_Configuration__c = selectedLSC;
    	RecapObj.PT_Desking_Verified_and_Push_Functioning__c = selectedDVF;
    	RecapObj.PT_Inventory_Verified__c = selectedPIV;
    	RecapObj.PT_CRM_DMS_Matching_Review__c = selectedCDM;
    	RecapObj.PT_Active_Leads_No_Future_Follow_up__c = selectedALF;
    	RecapObj.PT_Ad_Hoc_1__c = selectedAH1;
    	RecapObj.PT_Ad_Hoc_2__c = selectedAH2;
    	RecapObj.PT_Ad_Hoc_3__c = selectedAH3;
		RecapObj.Product_Training_Complete__c = selectedPTC;

        Database.Upsertresult SR = database.upsert(RecapObj);
        if(!SR.isSuccess()){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Database update Failed.');
            ApexPages.addMessage(myMsg);
            return null;
        }
        else {
	        PageReference recapPage = new PageReference('/apex/Vin_Recap_Scorecard_RO');
	        Map<string, string> params = recapPage.getParameters();
	        params.put('id', SR.getId());
	        return recapPage.setRedirect(true);
        }
		return null;
    }

    public PageReference Cancel() {
        PageReference recapPage = new PageReference('/apex/Vin_Recap_Scorecard_RO');
        Map<string, string> params = recapPage.getParameters();
        params.put('id', RecapId);
        return recapPage.setRedirect(true);
    }

    public PageReference EditScorecard() {
        PageReference recapPage = new PageReference('/apex/Vin_Recap_Scorecard');
        Map<string, string> params = recapPage.getParameters();
        params.put('RecapId', RecapId);
        return recapPage.setRedirect(true);
    }

    public PageReference CloneRecord() {
        Savepoint sp = Database.setSavepoint();
        Recap__c newRecap;
        try{
            newRecap = RecapObj.clone(false, true, false, false);
            newRecap.RecordTypeId = Schema.SObjectType.Recap__c.getRecordTypeInfosByName().get('Master Final').getRecordTypeId();
            newRecap.OwnerId = UserInfo.getUserId();
            insert newRecap;
            newRecapId = newRecap.Id;
        }
        catch (Exception e){
            Database.rollback(sp);
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Cloning record Failed, because:   ' + e);
            ApexPages.addMessage(myMsg);
            return null;
        }
        PageReference recapPage = new PageReference('/apex/Vin_Recap_Scorecard_RO');
        Map<string, string> params = recapPage.getParameters();
        params.put('clonedRecord', 'true');
        params.put('id', newRecap.Id);
        return recapPage.setRedirect(true);
    }

    // Method to get a score for On Time in the Virtual Trainers Section
    public double getVTOnTimeScore(){
    	vtOnTimeAnswered = 0;
    	vtOnTimeScoreCount = 0;
    	if(RecapObj.VT_Admin_Class_Completed_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Manager_Class_Complete_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Sales_Classes_Complete_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Additional_Admin_Settings_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Appraisal_Service_Settings_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Dynamic_Comments_Setup_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Dealer_Form_Settings_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Lead_Assignment_Complete_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Lead_Settings_Complete_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Add_Customer_Settings_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.VT_Road_to_the_Sale_On_Time__c == 'Yes'){vtOnTimeAnswered++;}
		if(RecapObj.Virtual_Training_Complete_On_Time__c == 'Yes'){vtOnTimeAnswered++;}

		if(RecapObj.VT_Admin_Class_Complete__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Manager_Class_Complete__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Sales_Classes_Complete__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Additional_Admin_Settings_Complete__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Appraisal_Service_Settings_Mapped__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Dynamic_Comments_Setup__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Dealer_Form_Settings__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Lead_Assignment_Complete__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Lead_Settings_Complete__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Add_Customer_Settings__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.VT_Road_to_the_Sale_Complete__c != 'N/A'){vtOnTimeScoreCount++;}
		if(RecapObj.Virtual_Training_Complete__c != 'N/A'){vtOnTimeScoreCount++;}

		// Dividing vtOnTimeAnswered by vtOnTimeScoreCount to get the percentage and then multiplyiing by 100 to move the decimal place.
		if(vtOnTimeScoreCount != 0){
			return((Double.valueOf(vtOnTimeAnswered)/Double.valueOf(vtOnTimeScoreCount)) * 100);
		}
		else{
			return 0;
		}
    }

    // Method to get a score for On Time in the On-Site Training Section
    public double getPTOnTimeScore(){
    	ptOnTimeAnswered = 0;
    	ptOnTimeScoreCount = 0;
    	if(RecapObj.PT_Scheduled_Custom_Reports_On_Time__c == 'Yes'){ptOnTimeAnswered++;}
		if(RecapObj.PT_ROI_Settings_Configured_On_Time__c == 'Yes'){ptOnTimeAnswered++;}
		if(RecapObj.PT_Processes_Enabled_On_Time__c == 'Yes'){ptOnTimeAnswered++;}
		if(RecapObj.PT_Inventory_Verified_On_Time__c == 'Yes'){ptOnTimeAnswered++;}
		if(RecapObj.PT_CRM_DMS_Matching_On_Time__c == 'Yes'){ptOnTimeAnswered++;}
		if(RecapObj.PT_Active_Leads_No_Future_On_Time__c == 'Yes'){ptOnTimeAnswered++;}
		if(RecapObj.Product_Training_Complete_On_Time__c == 'Yes'){ptOnTimeAnswered++;}

		if(RecapObj.PT_Scheduled_Custom_Reports__c != 'N/A'){ptOnTimeScoreCount++;}
		if(RecapObj.PT_ROI_Settings_Configured__c != 'N/A'){ptOnTimeScoreCount++;}
		if(RecapObj.PT_Processes_Enabled__c != 'N/A'){ptOnTimeScoreCount++;}
		if(RecapObj.PT_Inventory_Verified__c != 'N/A'){ptOnTimeScoreCount++;}
		if(RecapObj.PT_CRM_DMS_Matching_Review__c != 'N/A'){ptOnTimeScoreCount++;}
		if(RecapObj.PT_Active_Leads_No_Future_Follow_up__c != 'N/A'){ptOnTimeScoreCount++;}
		if(RecapObj.Product_Training_Complete__c != 'N/A'){ptOnTimeScoreCount++;}

		// Dividing ptOnTimeAnswered by ptOnTimeScoreCount to get the percentage and then multiplyiing by 100 to move the decimal place.
		if(ptOnTimeScoreCount != 0){
			return((Double.valueOf(ptOnTimeAnswered)/Double.valueOf(ptOnTimeScoreCount)) * 100);
		}
		else{
			return 0;
		}
    }

    // Picklist value methods
    // Yes, No, N/A Picklists
    public List<SelectOption> availableYesNo {
        get{
            if (availableYesNo == null) {
                availableYesNo = new List<SelectOption>();
                availableYesNo.add(new SelectOption('Yes', 'Yes'));
                availableYesNo.add(new SelectOption('No', 'No'));
                availableYesNo.add(new SelectOption('N/A', 'N/A'));
            }
            return availableYesNo;
        }
        private set;
    }
    // Rating Picklists
    public List<SelectOption> availableRating {
        get{
            if (availableRating == null) {
                availableRating = new List<SelectOption>();
                availableRating.add(new SelectOption(NONESELECT, NONESELECT));
                availableRating.add(new SelectOption('1', '1'));
                availableRating.add(new SelectOption('2', '2'));
                availableRating.add(new SelectOption('3', '3'));
                availableRating.add(new SelectOption('4', '4'));
                availableRating.add(new SelectOption('5', '5'));
            }
            return availableRating;
        }
        private set;
    }
   

	// Validation Methods
	// placed in case stakeholders ask for custom validation rules    
    private void validate() {
        isValid = true;
        RecapLaunchConsultantSection();
    }
    
    public void RecapLaunchConsultantSection(){
    	
    }
      
    public class RecapValidationWrapper{
		
    }

}// End class Vin_Recap_Scorecard