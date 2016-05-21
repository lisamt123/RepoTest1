public with sharing class Story_Creation_From_FR {

	// Class Variables
	public static String NONESELECT = '--None--';
    public Boolean isValid{get;set;}
    public Boolean createNew = false;
    public Boolean approved{get;set;}
    public Boolean allFRApproved{get;set;}
    public String CRId{get;set;}
    public String storyFR{get;set;}
    public String storyTR{get;set;}
    public String profileID{get;set;}
    public String buildName{get;set;}
    public String removeStoryID{get;set;}
    public String viewStoryID{get;set;}
    public NonRoutineValidationWrapper nrv{get;set;}
    public Change_Request__c CRObj{get;set;}
    public agf__ADM_Work__c WorkObj{get;set;}
	public StoriesWrapperClass swc{get;set;}
	public FRWrapperClass frwc{get;set;}
    public List<Functional_Requirement__c> existingFRs{get;set;} // List of functional requirements for the change request
	public List<Functional_Requirement__c> frsToUpdate{get;set;} // List of functional requirements that need to be updated after a story is created
    public List<agf__ADM_Work__c> existingStories{get;set;} // List of Stories/Work created for the change request
	public List<StoriesWrapperClass> storyWrpList{get;set;} 
	public List<FRWrapperClass> frWrpList{get;set;}
	public Integer numOfexistingStories{get;set;}

    // Constructor
	public Story_Creation_From_FR(ApexPages.StandardController controller) {
    	CRId = ApexPages.currentPage().getParameters().get('CRId');
    	createNew = false;
    	storyFR = 'Functional Requirements:\n';
    	storyTR = 'Technical Requirements:\n';
        if(CRId == null){
        	CRId = ApexPages.currentPage().getParameters().get('id');
        	// Display error message if there is still no Change Request Id to associate with the page.
        	if(CRId == null){
            	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'No Change Request Id was found.'));
        	}
        }
        if(CRId != null){
        	approved = true;
            allFRApproved = false; // Set to false for dynamic display of checkbox on page
        	WorkObj = new agf__ADM_Work__c();
        	getCRObj();
        	getFRs();
        	getExistingStories();
	        if (CRObj.Change_Type__c != 'Feature' && CRObj.Change_Type__c != 'Break-Fix'){
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'The Change Type on the Change Request must be set to Feature or Break-Fix.'));
	    	}
	    	if(CRObj.Change_Type__c == 'Feature' && CRObj.CR_Approved__c == false){
	    		approved = false;
	    		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'The Change Request must be Approved first before stories can be created.'));
	    	}
        }
        
        InitializeUIComponents();
	}

	// Set up the page 
    private void InitializeUIComponents(){
        nrv = new NonRoutineValidationWrapper();
        if(existingFRs != null && existingFRs.size() >0){
	        for(Functional_Requirement__c fr : existingFRs){
	        	if(fr.User_Approval__c == false){
	        		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'You have Functional Requirements that have not been approved. You will not be able to create any stories until they are all approved.'));
                    allFRApproved = true;
	        		break;
	        	}
	        }
            InitializeFRWrapper();
        }
        else{
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Return to the Change Request. Functional Requirements need to be created before using this page.'));
        }
	}

	// Set up page with existing Change Request upon page load
    public void getCRObj() {
        try {
			CRObj = [SELECT	Name, Assigned_To__c, Assigned_To__r.Name, BU__c, Change_Type__c, Order__c, Category__c, Sub_Category__c,
							Details__c, BU_Impact__c, CR_Approved__c, View_Details__c, Change_Request_Status__c
                	FROM 	Change_Request__c
                	WHERE 	Id = :CRId LIMIT 1];
        }
        catch (exception e) {
            System.debug('getCRObj() encountered exception: '+e.getMessage());
            throw e;
        }
    }

    // Grab Functional Requirements for Change Request
    public void getFRs() {
        try {
        	existingFRs = [SELECT	Id, Name, Functional_Requirement__c, Technical_Requirement__c, User_Approval__c,
									Change_Request__c, Created_Story__c, Story__c
		                	 FROM 	Functional_Requirement__c
		                	WHERE 	Change_Request__c = :CRId AND Created_Story__c = false];
        }
        catch (exception e) {
        	existingFRs = null;
            System.debug('getFRs() encountered exception: '+e.getMessage());
            throw e;
        }
    }

    // Set up list of Functional Requirements to be displayed on page
    public void InitializeFRWrapper(){
    	frWrpList = null;
    	if(existingFRs != null && existingFRs.size() > 0){
    		frWrpList = new List<FRWrapperClass>();
    		for(Functional_Requirement__c fr : existingFRs){
    			frwc = new FRWrapperClass();
    			frwc.frIdVal = fr.Id;
    			frwc.frName = fr.Name;
    			// Setting the value to disable the Checkbox on the VF page.
    			frwc.approved = allFRApproved;
    			frwc.selected = false;
    			frwc.functionalRequirement = fr.Functional_Requirement__c;
    			frwc.technicalRequirement = fr.Technical_Requirement__c;
    			frWrpList.add(frwc);
    		}
    	}
    }

	// Grab Work(Story) object for Related list
    public void getExistingStories() {
        try {
			existingStories = [SELECT	Id, Name, Change_Request_ID__c, As_a__c, I_need_a__c, so_that_I_can__c, agf__Details__c
			                	 FROM 	agf__ADM_Work__c
			                	WHERE 	Change_Request_ID__c = :CRId];
        }
        catch (exception e) {
        	existingStories = null;
        	numOfexistingStories = 0;
            System.debug('getExistingStories() encountered exception: '+e.getMessage());
            throw e;
        }

        numOfexistingStories = existingStories == null ? 0 : existingStories.size();
        InitalizeStoriesWrapperClass();
    }

    // Set up list of Stories to display on page
    public void InitalizeStoriesWrapperClass(){
        storyWrpList = null;
        if(existingStories.size() > 0 && existingStories != null){
            storyWrpList = new List<StoriesWrapperClass>();
            for(agf__ADM_Work__c st : existingStories){
                swc = new StoriesWrapperClass();
                swc.stIdVal = st.Id;
                swc.stName = st.Name;
                swc.stSubject = 'As a ' + st.As_a__c + ', I need a ' + st.I_need_a__c + ', so that I can ' + st.so_that_I_can__c;
                swc.stFRs = st.agf__Details__c.substringBetween(storyFR, storyTR);
                storyWrpList.add(swc);
            }
        }
    }

    // Action Methods    
    public pageReference Save() {
    	frsToUpdate = new List<Functional_Requirement__c>();
        validate();
        if (!isValid) {
            return null; // Do not save or update anything if there are validation errors
        }

        FormatStoryDescription(frsToUpdate); // Format strings
        
        WorkObj = CreateStroy();
        if(WorkObj != null){
            Database.Upsertresult SR = database.upsert(WorkObj);
            if(!SR.isSuccess()){
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Database insert/update Failed.'));
                return null;
            }
            else{
                CRObj.Change_Request_Status__c = 'In Progress';
                update CRObj;
            }
            // Add the Story Id to the functional requirements
            for(Functional_Requirement__c fr : frsToUpdate){
                fr.Story__c = SR.Id;
                fr.Created_Story__c = true;
                update fr; // If the Functional Requirement was selected and added to a story, update the record so it doesn't appear again.
            }
            
            if (!createNew) {
    	        PageReference newCRPage = Cancel();
    	        return newCRPage.setRedirect(true);
            }
            else {
    			PageReference newCRPage = new PageReference('/apex/Story_Creation_From_FR');
    	        Map<string, string> params = newCRPage.getParameters();
    	        params.put('CRId', CRId);
    	        return newCRPage.setRedirect(true);
    		}
        }
		return null;
    }
    
    public pageReference SaveNew(){
    	createNew = true;
        PageReference page = Save();
        return page;
    }

    // Method to return to the read only page.
	public pageReference Cancel(){
		PageReference returnToCR = new PageReference('/'+CRId);
        return returnToCR.setRedirect(true);
    }

    // Methods for the story related list
    public PageReference recordView(){ 
        String strval = ApexPages.currentPage().getParameters().get('viewParam');
        PageReference detailPg = new PageReference ('/' + strval );
        return detailPg.setRedirect(true);
    }

    public PageReference StoryDelete() { 
        if (removeStoryID == null || removeStoryID == ''){
            //this should never happen
            System.debug('StoryDelete encountered a null or empty Story ID to be deleted');
        }
        else {
            try {
                List<agf__ADM_Work__c> myDoomedStory = [Select id from agf__ADM_Work__c where Id = :removeStoryID limit 1];
                List<Functional_Requirement__c> unAssignFromStory = [Select id, Created_Story__c from Functional_Requirement__c Where Story__c =: myDoomedStory];
                if(myDoomedStory != null && myDoomedStory.size() == 1){
                    delete myDoomedStory[0];
                    getExistingStories();
                    InitalizeStoriesWrapperClass();
                    for(Functional_Requirement__c fr : unAssignFromStory){
                        fr.Created_Story__c = false;
                        update fr;
                    }
                    PageReference refreshPage = new PageReference('/apex/Story_Creation_From_FR');
                    Map<string, string> params = refreshPage.getParameters();
                    params.put('CRId', CRId);
                    return refreshPage.setRedirect(true);
                }
            }
            catch(Exception e){
                System.debug('StoryDelete encountered exception: '+e.getMessage());
                throw e;
            }
        }
        return null;
    }

    // Validation Methods    
    private void validate() {
        isValid = true;
        StorySubjectSection();
        FRSection();
    }

    public void StorySubjectSection(){
    	nrv.asARequired = false;
    	nrv.iNeedaRequired = false;
    	nrv.soThatICanRequired = false;
    	
    	if (WorkObj.As_a__c == null || WorkObj.As_a__c.trim() == '') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'The As a Field is required.'));
            nrv.asARequired = true;
            isValid = false;
        }
    	if (WorkObj.I_need_a__c == null || WorkObj.I_need_a__c.trim() == '') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'The I need a Field is required.'));
            nrv.iNeedaRequired = true;
            isValid = false;
        }
    	if (WorkObj.so_that_I_can__c == null || WorkObj.so_that_I_can__c.trim() == '') {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'The so that I can Field is required.'));
            nrv.soThatICanRequired = true;
            isValid = false;
        }
	}

	public void FRSection(){
		nrv.noFRAttachedToStory = false;

        if(frWrpList != null){
    		for(FRWrapperClass wc : frWrpList){
            	if(wc.selected == true){
            		for(Functional_Requirement__c fr : existingFRs){
            			if(wc.frIdVal == fr.Id){
            				frsToUpdate.add(fr); // Seperate out the functional requirements that have been selected
            			}
            		}
            	}
            }
        }
        if(frsToUpdate.size() < 1){
        	ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'You cannot create a story without a Functional Requirement.'));
            nrv.noFRAttachedToStory = true;
            isValid = false;
        }
	}

    // Format strings to populate the Description section of the stories
    public void FormatStoryDescription(List<Functional_Requirement__c> frsToFormat){
		Integer i = 1;
		for(Functional_Requirement__c fr : frsToFormat){
			storyFR = storyFR + i + '.  ' + fr.Functional_Requirement__c + '\n';
			if(fr.Technical_Requirement__c != null && fr.Technical_Requirement__c.trim() != ''){
				storyTR = storyTR + i + '.  ' + fr.Technical_Requirement__c + '\n';
			i++;
			}
		}
    }

    // Create the story from the Change Request and Functional Requirements.
    public agf__ADM_Work__c CreateStroy(){
    	profileID = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin' LIMIT 1].Id;
      	if(CRObj.BU_Impact__c == 'Yes'){
      		buildName = 'CrossBU' + CRObj.Change_Type__c;
      	}
        else if(CRObj.BU__c == 'Cox Automotive'){
            buildName = '';
        }
      	else{
      		buildName = CRObj.BU__c + CRObj.Change_Type__c;
      	}
      	WorkObj.RecordTypeId = Schema.SObjectType.agf__ADM_Work__c.getRecordTypeInfosByName().get('User Story').getRecordTypeId();
      	try{
      		WorkObj.agf__Product_Tag__c = [SELECT Id FROM agf__ADM_Product_Tag__c WHERE Name = 'SSG' LIMIT 1].Id;
      	}
      	catch(exception e){
      		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'The Product Tag SSG is missing in Agile Accelerator. Go to Agile Accelerator and create the Product Tag.'));
            return null;
      	}
      	try{
      		WorkObj.agf__Assignee__c = [SELECT Id FROM User WHERE Title = 'Agile Lead' AND ProfileId =: profileID LIMIT 1].Id;
      	}
      	catch(exception e){
      		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'A user with the Title: Agile Lead and Profile: VinSystem Admin, must be in the system.'));
            return null;
      	}
      	try{
            if(buildName != ''){
      		    WorkObj.agf__Scheduled_Build__c = [SELECT Id FROM agf__ADM_Build__c WHERE Name =: buildName LIMIT 1].Id;
            }
      	}
      	catch(exception e){
      		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'A Build with the name ' + buildName + ' needs to be created in Agile Accelerator.'));	
            return null;
      	}
      	if(CRObj.Change_Type__c == 'Break-Fix'){
      		try{
      			WorkObj.agf__Sprint__c = [SELECT Id FROM agf__ADM_Sprint__c WHERE agf__Days_Remaining__c NOT IN ('Not Started','Closed') LIMIT 1].Id;
      		}
      		catch(exception e){
        		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'For a Break-Fix story, there needs to be an active sprint. Go to Agile Accelerator and create an active sprint.'));
                return null;
      		}
      	}
        WorkObj.agf__QA_Engineer__c = CRObj.Assigned_To__c;
      	WorkObj.agf__Subject__c = CRObj.Change_Type__c + ' - ' + CRObj.BU__c + ' - ' + CRObj.View_Details__c;
      	WorkObj.agf__Details__c = 'Story Subject: As a ' + WorkObj.As_a__c + ', I need a ' + WorkObj.I_need_a__c + ', so that I can ' + WorkObj.so_that_I_can__c + '\n\n' + CRObj.Details__c + '\n\n' + storyFR + '\n\n' + storyTR + '\n\nList of Components:\n';
      	WorkObj.Change_Request_ID__c = CRId;
      	WorkObj.Priority_Order__c = CRObj.Order__c;
      	
      	return WorkObj;
    }

	public class NonRoutineValidationWrapper{
	// Story Subject Section
		public Boolean asARequired{get;set;}
		public Boolean iNeedaRequired{get;set;}
		public Boolean soThatICanRequired{get;set;}
		public Boolean noFRAttachedToStory{get;set;}
    }

    public class FRWrapperClass{
    	public Boolean approved{get;set;}
    	public Boolean selected{get;set;}
    	public String frIdVal{get;set;}
    	public String frName{get;set;}
    	public String functionalRequirement{get;set;}
    	public String technicalRequirement{get;set;}
    }

    public class StoriesWrapperClass{
        public String stIdVal{get;set;}
        public String stName{get;set;}
        public String stSubject{get;set;}
        public String stFRs{get;set;}
    }
}