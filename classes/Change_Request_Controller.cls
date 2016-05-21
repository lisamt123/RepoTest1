/*
 * Class/Method Name: Change_Request_Controller
 * Author/Date: Dean Lukowski September 15, 2014
 * Purpose: Create a dynamic page for a better user experience and data management.
 */

public with sharing class Change_Request_Controller {

	// Class Variables
	public static String NONESELECT = '--None--';
    public Boolean isValid{get;set;}
    public String CRId{get;set;}
    public String userId{get;set;}
    public User activeUser{get;set;}
    public String assignedName{get;set;}
    public Boolean editable{get;set;}
    public Boolean createNew = false;
    public Boolean attachments = false;
    public Boolean showAttButton{get;set;}
    public Boolean showCancelButton{get;set;}
    public Boolean showSaveEscalate{get;set;}
    public boolean displayPopup {get; set;} 
    public Change_Request__c CRObj{get;set;}
    public String createdDateStr {get;set;}
    public String lastModDateStr {get;set;}
    public CRValidationWrapper crvw{get;set;}
    public String retURL{
    	get {
            if (retURL == null){
            	retURL = ApexPages.currentPage().getParameters().get('retURL');
            	} 
            return retURL;
        }
        private set;
    }
	// Boolean check user profiles to determine field visability on the page
	public boolean isAdminUser{
        get{
            //check custom setting for profile
            CR_Visibility__c instance = CR_Visibility__c.getInstance(UserInfo.getUserId());
            if(instance.Grant_Visibility__c) {
                return true;
            }
            else{
                instance = CR_Visibility__c.getInstance(UserInfo.getProfileId());
            }
            if(instance.Grant_Visibility__c){
            	return true;
            }
            else{
            	return false;
            }
        }
        set;
    }
	// Change Request Details Section
	public String selectedBU{get;set;}   
    public String department{get;set;}
	public String selectedPriority{get;set;} 
	public String selectedChangeType{get;set;}
	public String selectedChangeTypeDetails{get;set;}
	public String selectedTier{get;set;}
    public String currentTier{get;set;} // Used to check it the tier is changed
    // Internal Notes Section
    public String currentWorkNotes{get;set;} 
    public String currentWorkNotesHistory{get;set;}
    public String changeTierReason{get;set;}
    public String raiseHandNotes{get;set;}
    // Custom Object History Related List
    public List<Change_Request__History> CRHistories{get;set;}//List of History
    public ChangeRequestHistoryWrapper CRHistory{get;set;}//Class
    public List<ChangeRequestHistoryWrapper> CRHistoriesWrpList{get;set;}//List of records in the class
    private static final DescribeSObjectResult CRObjectToken = Change_Request__c.sObjectType.getDescribe();
    private static final Map<String, Schema.SObjectField> CRFieldMap = CRObjectToken.fields.getMap();
    public Integer numOfHistoryRows{get;set;}
    public integer PageSize {get;set;}
    public boolean AllowShowMore {get;set;}

	// Constructor
	public Change_Request_Controller(ApexPages.StandardController controller) {
        CRId = ApexPages.currentPage().getParameters().get('CRId');
        if(CRId == null){
            CRId = ApexPages.currentPage().getParameters().get('id');
        }
		userId = UserInfo.getUserId();
		showAttButton = (CRid == null) ? true : false;
		showCancelButton = (retURL == null && CRid == null) ? false : true;
		showSaveEscalate = (CRid != null) ? true : false;

        getUser();
        getCRObj();

        if(CRObj.Assigned_To__c != null){
        	assignedName = CRObj.Assigned_To__r.Name;
        }
        if (CRObj.CreatedDate != null){
        	createdDateStr = string.valueof(CRObj.CreatedDate);
        }
        if (CRObj.LastModifiedDate != null){
        	lastModDateStr = string.valueof(CRObj.LastModifiedDate);
        }

        PageSize = 5;   
        AllowShowMore = true;
        getCRHistories();
        InitializeUIComponents();
	}

	// Set up the page 
    private void InitializeUIComponents(){
        crvw = new CRValidationWrapper();

	// Change Request Detail Section  
		if(CRid != null){
			selectedBU = CRObj.BU__c;
            department = CRObj.Department__c;
			selectedPriority = CRObj.Priority__c;
			selectedChangeType = CRObj.Change_Type__c;
			selectedChangeTypeDetails = CRObj.Change_Type_Details__c;
			selectedTier = CRObj.Tier_Level__c;
			currentTier = selectedTier;
            CRObj.Tier_Change_Reason__c = null;
            raiseHandNotes = CRObj.Raise_Hand_Notes__c;
		}
		else{
			selectedBU = activeUser.CompanyName;
			department = activeUser.Department;
			selectedPriority = '3-Warm'; // Setting the default value
			selectedTier = 'Tier 1'; // Setting the default value
			currentTier = selectedTier;
            raiseHandNotes = '';
		}

	// Internal Notes Section
		if(CRid != null){
			currentWorkNotes = CRObj.Work_Notes__c;
			currentWorkNotesHistory = CRObj.Work_Notes_History__c;
			changeTierReason = '';
		}
		else{
			currentWorkNotes = '';
			currentWorkNotesHistory = '';
			changeTierReason = '';
		}

    }   

	// Gather User information
	public void getUser(){
		try {
			activeUser = [SELECT 	Name, CompanyName, Department
						  	FROM	User
						   WHERE	Id = :userId LIMIT 1];
		}
		catch (exception e) {
			System.debug('getUser() encountered an exception: '+e.getMessage());
		}
	}

	// Set up page with existing Change Request or with a new empty Change Request upon page load
    public void getCRObj() {
        try {
        	if (CRId != null) {
				CRObj = [SELECT	Name, CreatedBy.Name, CreatedById, CreatedDate, LastModifiedBy.Name, LastModifiedById, LastModifiedDate,
								Owner.Name, RecordType.Name, Project__c, Assigned_To__c, Assigned_To__r.Name, Assigned_To_Email__c, BU__c, Change_Request_Status__c,
								Change_Type__c, Change_Type_Details__c, Date_Completed__c, Date_Needed_By__c, Date_Requested__c, Department__c,
								Estimated_Date_of_Completion__c, Link_to_Record__c, LOE_Hours__c, Parent_Change__c, Priority__c, Raise_Hand__c, Raise_Hand_Notes__c,
								Related_Object__c, Request_Details__c, Release_Notes_Details__c, Tier_Change_Reason__c, Tier_Level__c,
								Work_Notes__c, Work_Notes_History__c, Subject__c, Parent_Change__r.Name, Order__c, Review_Date__c
                    	FROM 	Change_Request__c
                    	WHERE 	Id = :CRId LIMIT 1];
        	}
        	else {
        		CRObj = new Change_Request__c();
	            createdDateStr = '';
	            lastModDateStr = '';
        	}
        }
        catch (exception e) {
            System.debug('getCRObj() encountered exception: '+e.getMessage());
            throw e;
        }
    }

    // Query for Change Request Field History
    public void getCRHistories(){
        DateTime dLastCreatedDate = null;
        try{
            CRHistories = [SELECT Id, Field, NewValue, OldValue, CreatedDate, CreatedById, CreatedBy.Name
                             FROM Change_Request__History
                            WHERE ParentId = :CRId ORDER BY CreatedDate DESC, Id DESC];
            if (CRHistories != null && CRHistories.size() > 0) {
                InitializeChangeRequestHistoryWrapper();
            }
            else{
                numOfHistoryRows = 0;
            }
        }
        catch(Exception e){
            System.debug('getCRHistories() encountered exception: '+e.getMessage());
            throw e;
        }
    }

    public void InitializeChangeRequestHistoryWrapper() {
        CRHistoriesWrpList = null;
        if (CRHistories != null && CRHistories.size() > 0) {
            CRHistoriesWrpList = new List<ChangeRequestHistoryWrapper>();
            for (Change_Request__History crh : CRHistories) {
                CRHistory = new ChangeRequestHistoryWrapper();
                CRHistory.CRHidVal = crh.Id;
                CRHistory.CRHCreatedByName = crh.CreatedBy.Name;
                CRHistory.CRHCreatedDate = crh.CreatedDate.format();
                CRHistory.CRHField = crh.Field;
                system.debug('==================================>>>>> CRHistory.CRHField = ' + CRHistory.CRHField);
                CRHistory.CRHFieldLabel = getFieldLabel(crh.Field);
                CRHistory.CRHNewValue = String.valueOf(crh.NewValue);
                CRHistory.CRHOldValue = String.valueOf(crh.OldValue);
                CRHistory.CRHActionFormat = getActionFormat(crh);
                system.debug('==================================>>>>> CRHistory.CRHFieldLabel = ' + CRHistory.CRHFieldLabel);
                system.debug('==================================>>>>> CRHistory.CRHNewValue = ' + CRHistory.CRHNewValue);
                system.debug('==================================>>>>> CRHistory.CRHOldValue = ' + CRHistory.CRHOldValue);
                system.debug('==================================>>>>> crh.Field = ' + crh.Field);
                if(CRHistory.CRHField != 'Request_Details__c' && !CRHistory.CRHField.equalsIgnoreCase('created')){
                    if(CRHistory.CRHNewValue != null && !CRHistory.CRHNewValue.startsWith('0057')){
                        system.debug('==================================>>>>> added New !0057  ' + !CRHistory.CRHNewValue.startsWith('0057'));
                        CRHistoriesWrpList.add(CRHistory);
                    }
                    else if(CRHistory.CRHOldValue != null && !CRHistory.CRHOldValue.startsWith('0057')){
                        system.debug('==================================>>>>> added Old !0057  ' + !CRHistory.CRHOldValue.startsWith('0057'));
                        CRHistoriesWrpList.add(CRHistory);
                    }
                }
                else{
                    system.debug('==================================>>>>> added else');
                    CRHistoriesWrpList.add(CRHistory);
                }
                if(CRHistoriesWrpList.size() == PageSize){
                    break;
                }
            }
        }
        AllowShowMore = (CRHistoriesWrpList.size() == PageSize);
    }

    public String getFieldLabel(String fieldName){
        String CRFieldLabel;
        for (String label : CRFieldMap.keySet()){
            if(fieldName == label){
                CRFieldLabel = CRFieldMap.get(label).getDescribe().getLabel();
            }
        }
            return CRFieldLabel;
    }

    private string getActionFormat(Change_Request__History crh) {
        string sActionFormat = 'Changed {1}';
        if (crh.newValue != null && crh.oldValue == null) {
            sActionFormat = 'Changed {1} to {3}.';    
        }
        else if (crh.newValue != null && crh.oldValue != null) {
            sActionFormat = 'Changed {1} from {2} to {3}.';   
        }
        else if (crh.Field != null && crh.Field.equalsIgnoreCase('created')) {
            sActionFormat = 'Created.';
        }

        return sActionFormat;
    }

    // Method for pagenation of change request history related list
    public void showMore() {
        PageSize += 5;
        getCRHistories();
    }
      
	// Picklists
	// Change Request Details Section
	public List<SelectOption> availableBU {
        get{
            if (availableBU == null) {
                availableBU = new List<SelectOption>();
                List<Schema.PicklistEntry> picklistEntries = Change_Request__c.BU__c.getDescribe().getPicklistValues();
                for (Schema.PicklistEntry entry : picklistEntries) {
                    availableBU.add(new SelectOption(entry.getLabel(), entry.getValue()));
                }
            }
            return availableBU;
        }
        private set;
    }

    public List<SelectOption> availablePriority {
        get{
            if (availablePriority == null) {
                availablePriority = new List<SelectOption>();
                List<Schema.PicklistEntry> picklistEntries = Change_Request__c.Priority__c.getDescribe().getPicklistValues();
                for (Schema.PicklistEntry entry : picklistEntries) {
                    availablePriority.add(new SelectOption(entry.getLabel(), entry.getValue()));
                }
            }
            return availablePriority;
        }
        private set;
    }

    public List<SelectOption> availableChangeType {
        get{
            if (availableChangeType == null) {
                availableChangeType = new List<SelectOption>();
                availableChangeType.add(new SelectOption(NONESELECT, NONESELECT));
                List<Schema.PicklistEntry> picklistEntries = Change_Request__c.Change_Type__c.getDescribe().getPicklistValues();
                for (Schema.PicklistEntry entry : picklistEntries) {
                    availableChangeType.add(new SelectOption(entry.getLabel(), entry.getValue()));
                }
            }
            return availableChangeType;
        }
        private set;
    }

    public List<SelectOption> availableChangeTypeDetails {
        get{
        	availableChangeTypeDetails = new List<SelectOption>();
            availableChangeTypeDetails.add(new SelectOption(NONESELECT, NONESELECT));
            if (selectedChangeType == 'Add/New'){
            	availableChangeTypeDetails.add(new SelectOption('Report/Dashboard', 'Report/Dashboard'));
            	availableChangeTypeDetails.add(new SelectOption('Product', 'Product'));
            	availableChangeTypeDetails.add(new SelectOption('Email Template', 'Email Template'));
            	availableChangeTypeDetails.add(new SelectOption('Business Process', 'Business Process'));
            	availableChangeTypeDetails.add(new SelectOption('Fields/Page Layout', 'Fields/Page Layout'));
            	availableChangeTypeDetails.add(new SelectOption('Other', 'Other'));
            }
            else if (selectedChangeType == 'Change'){
            	availableChangeTypeDetails.add(new SelectOption('Report/Dashboard', 'Report/Dashboard'));
            	availableChangeTypeDetails.add(new SelectOption('Data Correction', 'Data Correction'));
            	availableChangeTypeDetails.add(new SelectOption('Email Alerts/Notifications', 'Email Alerts/Notifications'));
            	availableChangeTypeDetails.add(new SelectOption('Business Process', 'Business Process'));
            	availableChangeTypeDetails.add(new SelectOption('Fields/Page Layout', 'Fields/Page Layout'));
            	availableChangeTypeDetails.add(new SelectOption('Other', 'Other'));
            }
            else if (selectedChangeType == 'Remove'){
            	availableChangeTypeDetails.add(new SelectOption('Users', 'Users'));
            	availableChangeTypeDetails.add(new SelectOption('Email Alerts/Notifications', 'Email Alerts/Notifications'));
            	availableChangeTypeDetails.add(new SelectOption('Business Process', 'Business Process'));
            	availableChangeTypeDetails.add(new SelectOption('Fields/Page Layout', 'Fields/Page Layout'));
            	availableChangeTypeDetails.add(new SelectOption('Other', 'Other'));
            }
            return availableChangeTypeDetails;
        }
        private set;
    }

    public List<SelectOption> availableTier {
        get{
            if (availableTier == null) {
                availableTier = new List<SelectOption>();
                List<Schema.PicklistEntry> picklistEntries = Change_Request__c.Tier_Level__c.getDescribe().getPicklistValues();
                for (Schema.PicklistEntry entry : picklistEntries) {
                    availableTier.add(new SelectOption(entry.getLabel(), entry.getValue()));
                }
            }
            return availableTier;
        }
        private set;
    }



	// Action Methods    
    public pageReference Submit() {
        validate();
        if (!isValid) {
        	if(attachments){
        		ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.INFO, 'Please fill out the Change Request first. Then click Submit and Add Attachments instead of Submit.');
        		ApexPages.addMessage(myMsg);
        		attachments = false;
        		return null;
        	}
            return null;
        }
        
	// Change Request Detail Section
		CRObj.BU__c = selectedBU;
        CRObj.Department__c = department;
		CRObj.Priority__c = selectedPriority;
		CRObj.Tier_Level__c = selectedTier;
		if (selectedChangeType != null && selectedChangeType != NONESELECT){
			CRObj.Change_Type__c = selectedChangeType;
		}
		if (selectedChangeTypeDetails != null && selectedChangeTypeDetails != NONESELECT){
			CRObj.Change_Type_Details__c = selectedChangeTypeDetails;
		}
        if (raiseHandNotes != '' && raiseHandNotes != null){
            if(raiseHandNotes.length() > 255){
                raiseHandNotes = raiseHandNotes.substring(0,255);
            }
        }
        CRObj.Raise_Hand_Notes__c = raiseHandNotes;

		updateWorkNotes();

	// Internal Notes Section
		if (currentWorkNotesHistory != null && currentWorkNotesHistory != ''){
			CRObj.Work_Notes_History__c = currentWorkNotesHistory;
		}

		changeTierReason = '';
		CRObj.Work_Notes__c = null;

        Database.Upsertresult SR = database.upsert(CRObj);
        if(!SR.isSuccess()){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Database update Failed.');
            ApexPages.addMessage(myMsg);
            return null;
        }
        
        if (!createNew && !attachments) {
            EntitySubscription insertOwner = new EntitySubscription();
	        PageReference newCRPage = new PageReference('/apex/Change_Request_RO');
	        Map<string, string> params = newCRPage.getParameters();
	        params.put('CRId', SR.getId());
	        return newCRPage.setRedirect(true);
        }
        else if(!createNew && attachments){
            EntitySubscription insertOwner = new EntitySubscription();
    		PageReference attPage = new PageReference('/apex/Multiple_Attachments');
    		Map<string, string> params = attPage.getParameters();
    		params.put('sobjId', SR.getId());
    		return attPage.setRedirect(true);
        }
        else {
            EntitySubscription insertOwner = new EntitySubscription();
			PageReference newCRPage = new PageReference('/apex/Change_Request');
	        return newCRPage.setRedirect(true);
		}
		return null;
    }
    
    public pageReference SubmitNew(){
    	createNew = true;
        PageReference page = Submit();
        return page;
    }

    // Method to go to a seperate page to add attachments.
    // A save is necessary to get and Id to add the attachments to.
    public pageReference AddAtts(){
    	attachments = true;
        PageReference page = Submit();
        return page;
    }
    
	// Method to return to the read only page.
	public pageReference Cancel(){
		if(retURL != null && retURL != ''){
    			return new PageReference(retURL);
		}
    	else{
    		PageReference CRROPage = new PageReference('/apex/Change_Request_RO');
	        Map<string, string> params = CRROPage.getParameters();
	        params.put('CRId', CRId);
	        return CRROPage.setRedirect(true);
		}
    }

	// Method to go to the Change Request Edit Page from the RO (read only) page.
    public pageReference EditCR() {
        PageReference CREditPage = new PageReference('/apex/Change_Request');
        Map<string, string> editParams = CREditPage.getParameters();
        editParams.put('CRId', CRId);
        return CREditPage.setRedirect(true);
    }

    // Method to quickly assign the Change Request to an Admin
    public pageReference AssignToMe(){
    	CRObj.Assigned_To__c = activeUser.Id;
    	assignedName = activeUser.Name;
    	Database.Upsertresult SR = database.upsert(CRObj);
        if(!SR.isSuccess()){
            ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Database update Failed.');
            ApexPages.addMessage(myMsg);
            return null;
        }
        PageReference CRROPage = new PageReference('/apex/Change_Request_RO');
            Map<string, string> params = CRROPage.getParameters();
            params.put('CRId', CRId);
            return CRROPage.setRedirect(true);
    }

    // Method for a popup window when clicking escalate button  
    public void closePopup() {  
    	crvw.tierLevelRequired = false;
    	crvw.tierChangeReasonRequired = false;
    	if (currentTier != selectedTier
    		&& (CRObj.Tier_Change_Reason__c == null || CRObj.Tier_Change_Reason__c == '')){
    		crvw.tierChangeReasonRequired = true;
    		displayPopup = true;
    	}  
    	else if ((CRObj.Tier_Change_Reason__c != null && CRObj.Tier_Change_Reason__c != '')
    		&& currentTier == selectedTier){
    		crvw.tierLevelRequired = true;
    		displayPopup = true;
    	}
    	else{
 			changeTierReason = CRObj.Tier_Change_Reason__c;
    		displayPopup = false; 
    	}   
    }

    public void showPopup() {        
        displayPopup = true;    
    }

    public void saveEscalate() {
        closePopup();
        if(!displayPopup && (currentTier != selectedTier)){
            Submit();
        }
    }

	 // Method to take ChangeTierReason and add it to Work Notes
	 private void updateWorkNotes(){
	 	// The date format is mm-dd-yyyy hh:mm
	 	Datetime d = System.now();
	 	String timestamp = '' + d.month() + '-' +d.day() + '-' + d.year()+ ' ' +d.hour() + ':' +d.minute()  ;
	 	String timeFormat = d.formatGmt(timestamp);

	// Internal Notes Section
	 	currentWorkNotes = CRObj.Work_Notes__c;

	 	if(changeTierReason != null && changeTierReason != ''){
	 		if(currentWorkNotesHistory != null && currentWorkNotesHistory != ''){
	 			currentWorkNotesHistory = timeFormat + ' -->  ' + currentTier + ' --> ' + selectedTier + '  ' + activeUser.Name + ' :   ' + changeTierReason + ' /\n' + currentWorkNotesHistory;
	 		}
	 		else{
	 			currentWorkNotesHistory = timeFormat + ' -->  ' + currentTier + ' --> ' + selectedTier + '  ' + activeUser.Name + ' :   ' + changeTierReason;
	 		}
	 	}

	 	if(currentWorkNotes != null && currentWorkNotes != ''){
	 		if(currentWorkNotesHistory != null && currentWorkNotesHistory != ''){
	 			currentWorkNotesHistory = timeFormat + ' --> ' + selectedTier + '  ' + activeUser.Name + ' :   ' + currentWorkNotes + ' /\n' + currentWorkNotesHistory;
	 		}
	 		else{
	 			currentWorkNotesHistory = timeFormat + ' --> ' + selectedTier + '  ' + activeUser.Name + ' :   ' + currentWorkNotes;
	 		}
	 	}
	 }  
    
	// Validation Methods    
    private void validate() {
        isValid = true;
        ChangeRequestDetailsSection();
    }
    
    public void ChangeRequestDetailsSection(){
    	crvw.changeTypeRequired = false;
    	crvw.changeTypeDetailsRequired = false;
        crvw.subjectRequired = false;
    	crvw.requestDetailsRequired = false;
        crvw.duplicateCRRequired = false;
    	
    	if (selectedChangeType == null || selectedChangeType == NONESELECT){
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'A Change Type is Required.'));
    		crvw.changeTypeRequired = true;
    		isValid = false;
    	}
    	if (selectedChangeType == 'Add/New'
    		|| selectedChangeType == 'Change'
    		|| selectedChangeType == 'Remove'){
    		if (selectedChangeTypeDetails == null || selectedChangeTypeDetails == NONESELECT){
    			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'A Change Type Detail is Required.'));
	    		crvw.changeTypeDetailsRequired = true;
	    		isValid = false;
    		}
    	}
        if (CRObj.Change_Request_Status__c == 'Duplicate'
            && CRObj.Parent_Change__c == null){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'A duplicate change request reference is required.'));
            crvw.duplicateCRRequired = true;
            isValid = false;
        }
        if (CRObj.Subject__c == null || CRObj.Subject__c == ''){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'A Subject is Required.'));
            crvw.subjectRequired = true;
            isValid = false;
        }
    	if (CRObj.Request_Details__c == null || CRObj.Request_Details__c == ''){
    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Request Details are Required.'));
    		crvw.requestDetailsRequired = true;
    		isValid = false;
    	}
    	
    }
       
    public class CRValidationWrapper{
	// Change Request Details Section
		public Boolean changeTypeRequired{get;set;}
		public Boolean changeTypeDetailsRequired{get;set;}
        public Boolean subjectRequired{get;set;}
		public Boolean requestDetailsRequired{get;set;}
		public Boolean tierChangeReasonRequired{get;set;}
		public Boolean tierLevelRequired{get;set;}
        public Boolean duplicateCRRequired{get;set;}
    }

    public class ChangeRequestHistoryWrapper{
    // Change Request History Related List
        public String CRHidVal{get;set;}
        public String CRHCreatedByName{get;set;}
        public String CRHCreatedDate{get;set;}
        public String CRHField{get;set;}
        public String CRHFieldLabel{get;set;}
        public String CRHNewValue{get;set;}
        public String CRHOldValue{get;set;}
        public String CRHActionFormat{get;set;}

    }
}