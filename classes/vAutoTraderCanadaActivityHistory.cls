public with sharing class vAutoTraderCanadaActivityHistory {

	public Id acctId{get;set;}
	public List<Task> taskHistories{get;set;}
	public List<Event> eventHistories{get;set;}
	public ActivityHistoryClass actHistory{get;set;}//Class
	public List<ActivityHistoryClass> combineTasksAndEvents{get;set;}//List of Tasks and Events using the class ActivityHistoryClass
    public List<ActivityHistoryClass> actHistoriesWrpList{get;set;}//a shortened List of records in the class
    public Integer numOfHistoryRows{get;set;}
    public integer PageSize{get;set;}
    public boolean AllowShowMore{get;set;}  
    public String removeItemId{get;set;}
    public Date dt{get;set;}

	private ApexPages.StandardController stdController;

	// Constructor
	public vAutoTraderCanadaActivityHistory(ApexPages.StandardController stdController) {
		this.stdController = stdController;
		PageSize = 5;   
        AllowShowMore = true;
        dt = System.today();
		try {
			acctId = stdController.getId();
		}
		catch(StringException ex) {}

		if(acctId == null || acctId.getSobjectType() != Account.sObjectType) {
			addError('The id parameter is required and must be a valid Account Id.');
			return;
		}
		else{
			getvAutoActivityHistories();
		}
	}

	// Query for vAuto Account Activity History
    public void getvAutoActivityHistories(){
        try{
            taskHistories = [SELECT Id, WhoId, Who.Name, Subject, Preview__c, WhatId, What.Name, ActivityDate,
            					   	OwnerId, Owner.Name, LastModifiedDate, Business_Unit__c, AccountId, Status
							   FROM Task
                              WHERE AccountId = :acctId AND Business_Unit__c = 'vAuto'
                                                        AND (isClosed = true OR isArchived = true)
                                                        ORDER BY ActivityDate Desc ALL ROWS];
                                                        //(Status = 'Completed' OR Status = 'Cancelled') Status != 'Open'
        }
        catch(Exception e){
            System.debug('getvAutoActivityHistories() taskHistories encountered exception: '+e.getMessage());
            throw e;
        }
        try{
            eventHistories = [SELECT Id, WhoId, Who.Name, Subject, Preview__c, WhatId, What.Name, ActivityDate,
            					   	OwnerId, Owner.Name, LastModifiedDate, Business_Unit__c, AccountId, EndDateTime
							    FROM Event
                               WHERE AccountId = :acctId AND Business_Unit__c = 'vAuto'
                                                         AND (EndDateTime < :dt OR isArchived = true)
                                                         ORDER BY ActivityDate Desc ALL ROWS];
                                                         // 
        }
        catch(Exception e){
            System.debug('getvAutoActivityHistories() eventHistories encountered exception: '+e.getMessage());
            throw e;
        }
        if ((taskHistories != null && taskHistories.size() > 0)
        	|| (eventHistories != null && eventHistories.size() > 0)) {
            InitializeActivityHistoryWrapper();
            numOfHistoryRows = taskHistories.size() + eventHistories.size();
        }
        else{
            numOfHistoryRows = 0;
        }
    }

    public void InitializeActivityHistoryWrapper() {
        combineTasksAndEvents = null;
        actHistoriesWrpList = null;
        if ((taskHistories != null && taskHistories.size() > 0)
        	|| (eventHistories != null && eventHistories.size() > 0)) {
            combineTasksAndEvents = new List<ActivityHistoryClass>();
        }
        if (taskHistories != null && taskHistories.size() > 0) {
            for (Task activity : taskHistories) {
            	ACTHistory = new ActivityHistoryClass();
            	ACTHistory.ahTask = true;
            	ACTHistory.ahID = activity.Id;
                ACTHistory.ahSubject = activity.Subject;
                ACTHistory.ahPreview = activity.Preview__c;
                ACTHistory.ahWhoId = activity.WhoId;
                ACTHistory.ahWhoName = activity.Who.Name;
                ACTHistory.ahWhatId = activity.WhatId;
                ACTHistory.ahWhatName = activity.What.Name;
                ACTHistory.ahDueDate = activity.ActivityDate;
        System.debug('======================>>>> ACTHistory.ahDueDate = ' + ACTHistory.ahDueDate);
        System.debug('======================>>>> activity.ActivityDate = ' + activity.ActivityDate);
                ACTHistory.ahOwnerId = activity.OwnerId;
                ACTHistory.ahOwnerName = activity.Owner.Name;
                ACTHistory.ahModifiedDate = activity.LastModifiedDate.format();
                ACTHistory.ahBU = activity.Business_Unit__c;
                combineTasksAndEvents.add(ACTHistory);
            }
        }
        if (eventHistories != null && eventHistories.size() > 0) {
            for (Event activity : eventHistories) {
            	ACTHistory = new ActivityHistoryClass();
            	ACTHistory.ahTask = false;
            	ACTHistory.ahID = activity.Id;
                ACTHistory.ahSubject = activity.Subject;
                ACTHistory.ahPreview = activity.Preview__c;
                ACTHistory.ahWhoId = activity.WhoId;
                ACTHistory.ahWhoName = activity.Who.Name;
                ACTHistory.ahWhatId = activity.WhatId;
                ACTHistory.ahWhatName = activity.What.Name;
                ACTHistory.ahDueDate = activity.ActivityDate;
        System.debug('======================>>>> ACTHistory.ahDueDate = ' + ACTHistory.ahDueDate);
        System.debug('======================>>>> activity.ActivityDate = ' + activity.ActivityDate);
                ACTHistory.ahOwnerId = activity.OwnerId;
                ACTHistory.ahOwnerName = activity.Owner.Name;
                ACTHistory.ahModifiedDate = activity.LastModifiedDate.format();
                ACTHistory.ahBU = activity.Business_Unit__c;
                combineTasksAndEvents.add(ACTHistory);
            }
        }
        System.debug('======================>>>> combineTasksAndEvents.size() = ' + combineTasksAndEvents.size());
        if(combineTasksAndEvents != null && combineTasksAndEvents.size() > 0){
        	// Re-sort the new combined class list to match the query order by above.
        	combineTasksAndEvents.sort();
        System.debug('======================>>>> combineTasksAndEvents.size() = ' + combineTasksAndEvents.size());
        	// set the number of records to display
        	numberOfRecordsToDisplay();
        }
    }

    // Method for pagenation of change request history related list
    public void showMore() {
        PageSize += 10;
        numberOfRecordsToDisplay();
    }

    public void gotoList(){
    	// After combining tasks and events and sorting them get the top ones for display on page for pagenation
        actHistoriesWrpList = new List<ActivityHistoryClass>();
        System.debug('======================>>>> combineTasksAndEvents.size() = ' + combineTasksAndEvents.size());
        for(ActivityHistoryClass ahc : combineTasksAndEvents){
        	actHistoriesWrpList.add(ahc);
        }
        System.debug('======================>>>> actHistoriesWrpList.size() = ' + actHistoriesWrpList.size());
        AllowShowMore = false;
    }

    public void numberOfRecordsToDisplay(){
        // After combining tasks and events and sorting them get the top ones for display on page for pagenation
        actHistoriesWrpList = new List<ActivityHistoryClass>();
        System.debug('======================>>>> combineTasksAndEvents.size() = ' + combineTasksAndEvents.size());
        for(ActivityHistoryClass ahc : combineTasksAndEvents){
        	actHistoriesWrpList.add(ahc);
        	if(actHistoriesWrpList.size() == PageSize){
                break;
            }
        }
        AllowShowMore = (actHistoriesWrpList.size() == PageSize);
	}

	public PageReference doDeleteAction(){ 
        if(removeItemId == null || removeItemId == ''){
            //this should never happen
            System.debug('doDeleteAction encountered a null or empty ID to be deleted');
        }
        else {
            try {
                List<Task> myDoomedTask = [SELECT Id FROM Task WHERE Id = :removeItemId limit 1];
                List<Event> myDoomedEvent = [SELECT Id FROM Event WHERE Id = :removeItemId limit 1];
                if(myDoomedTask != null && myDoomedTask.size() == 1){
                    delete myDoomedTask[0];
                    if(AllowShowMore == false){
                    	getvAutoActivityHistories();
                    	gotoList();
                    }
                    else{
                    	getvAutoActivityHistories();
                    }
                }
                else if(myDoomedEvent != null && myDoomedEvent.size() == 1){
                	delete myDoomedEvent[0];
                    if(AllowShowMore == false){
                    	getvAutoActivityHistories();
                    	gotoList();
                    }
                    else{
                    	getvAutoActivityHistories();
                    }
                }
            }
            catch(Exception e){
                System.debug('doDeleteAction encountered exception: '+e.getMessage());
                throw e;
            }
        }
        return null;
    }

    public class ActivityHistoryClass implements Comparable{
    	// added implements Comparable to allow the use of the compareTo method to sort a list of this class
    	public Boolean ahTask{get;set;}
    	public String ahID{get;set;}
        public String ahSubject{get;set;}
        public String ahPreview{get;set;}
        public String ahWhoId{get;set;}
        public String ahWhoName{get;set;}
        public String ahOwnerId{get;set;}
        public String ahOwnerName{get;set;}
        public Date ahDueDate{get;set;}
        public String ahWhatId{get;set;}
        public String ahWhatName{get;set;}
        public String ahModifiedDate{get;set;}
        public String ahBU{get;set;}

        // Method used to sort lists of this class by ahDueDate
        public Integer compareTo(Object objToCompare){
        	// Cast argument to AccountHistoryWrapper
        	ActivityHistoryClass ahc = (ActivityHistoryClass)objToCompare;
        	// The return value of 0 indicates that both elements are equal.
        	Integer returnValue = 0;
        	
	        if(ahDueDate >  ahc.ahDueDate){
	            // I want this to sort in a decending order so if greater = -1; to switch to ascending change to 1
	            returnValue = -1;
	        }
	        else if(ahDueDate < ahc.ahDueDate){
	            // I want this to sort in a decending order so if less = 1; to switch to ascending change to -1
	        	returnValue = 1;
	        }
        	return returnValue;
        }
    }

    private void addError(String msg) {
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
	}

}