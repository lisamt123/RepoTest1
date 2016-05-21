/*
 * Class/Method Name: eAcademyCustomerView
 * Author/Date: Dean Lukowski / March 13, 2015
 * Purpose: So customers can view training records from Brainshark for their accounts only.
 *
 */

public with sharing class eAcademyCustomerView {

	// Variables
	public String userId{get;set;}
    public User activeUser{get;set;}
	public Account account{get;set;}
	public List<eAcademy__c> eAcademies = new List<eAcademy__c>();
    public eAcademyRelatedListWrapper eARecord{get;set;}//Class
    public List<eAcademyRelatedListWrapper> eAcademyRLWrpList{get;set;}//List of records in the class
    public Integer numOfRows{get;set;}
    public Integer PageSize{get;set;}
    public Boolean AllowShowMore{get;set;}
    public Boolean displayPopUp{get;set;}
	public eAcademy__c eAInstance{get;set;}
	public String searchInput{get;set;}


	public eAcademyCustomerView(ApexPages.StandardController controller) {
		userId = UserInfo.getUserId();
		getUser();
		if(activeUser.ContactId != null){
			account = [SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Id = :activeUser.ContactId)];
		}
		else{
			account = [SELECT Id FROM Account WHERE Id IN (SELECT AccountId FROM Contact WHERE Name = :activeUser.Name) LIMIT 1];	
		}
		
		searchInput = '';
		PageSize = 25;
		AllowShowMore = true;
		geteAcademies();
	}

	// Gather User information
	public void getUser(){
		try {
			activeUser = [SELECT 	Id, Name, ContactId
						  	FROM	User
						   WHERE	Id = :userId LIMIT 1];
		}
		catch (exception e) {
			System.debug('getUser() encountered an exception: '+e.getMessage());
		}
	}
	
	public void geteAcademies(){
		try{
			eAcademies = [SELECT CreatedBy.Name, CreatedById, CreatedDate, LastModifiedBy.Name, LastModifiedById, LastModifiedDate,
								 Name, Id, Account_Name__c, Account_Name__r.Name, Date_Time__c, Dealership_Name__c, Sort3__c, Sort_Title__c,
								 Sort_ViewerInfo__c, Tracking_Code__c, ViewerInfo__c, Viewing_Time__c, View_Total_Pct_of_Duration__c,
								 View_Total_Pct_of_Slides__c, View_Total_Points__c, View_Total_Score__c, View_Total_Slides_Viewed__c,
								 View_Type__c, Vin_User_ID__c
							FROM eAcademy__c
						   WHERE Account_Name__c = :account.Id ORDER BY Sort_ViewerInfo__c Asc];
		    if(eAcademies != null && eAcademies.size() > 0){
		    	InitializeeAcademyRelatedListWrapper();
		    }
		    else{
		    	numOfRows = 0;
		    }
		}
		catch(Exception e){
			System.debug('geteAcademies() encountered exception: '+e.getMessage());
            throw e;
		}
	}

    public void InitializeeAcademyRelatedListWrapper() {
        eAcademyRLWrpList = null;
        if (eAcademies != null && eAcademies.size() > 0) {
            eAcademyRLWrpList = new List<eAcademyRelatedListWrapper>();
            for (eAcademy__c eA : eAcademies) {
                eARecord = new eAcademyRelatedListWrapper();
                if(searchInput != '' || searchInput.length() > 0){
                	if(eA.Sort_ViewerInfo__c.containsIgnoreCase(searchInput)){
                		eARecord.eAId = eA.Id;
		                eARecord.eAName = eA.Name;
		                eARecord.eASortViewerInfo = eA.Sort_ViewerInfo__c;
		                eARecord.eASortTitle = eA.Sort_Title__c;
		                eARecord.eAViewType = eA.View_Type__c;
		                eARecord.eAViewTotalScore = eA.View_Total_Score__c;
		                eAcademyRLWrpList.add(eARecord);
                	}
	            	else{
	            		continue;
	            	}
                }
                else{
	                eARecord.eAId = eA.Id;
	                eARecord.eAName = eA.Name;
	                eARecord.eASortViewerInfo = eA.Sort_ViewerInfo__c;
	                eARecord.eASortTitle = eA.Sort_Title__c;
	                eARecord.eAViewType = eA.View_Type__c;
	                eARecord.eAViewTotalScore = eA.View_Total_Score__c;
	                eAcademyRLWrpList.add(eARecord);
	            }
	            if(eAcademyRLWrpList.size() == PageSize){
	                break;
	            }
            }
        }
        if(eAcademyRLWrpList == null || eAcademyRLWrpList.size() < 1){
        	numOfRows = 0;
        }
        else{
        	numOfRows = eAcademyRLWrpList.size();
        	AllowShowMore = (eAcademyRLWrpList.size() == PageSize);
        }
    }

    // Method for pagenation of the related list
    public void showMore() {
        PageSize += 25;
        geteAcademies();
    }

    // Methods for a popup window  
    public void closePopup() {  
    	displayPopUp = false;  
    }

    public void showPopup() {
    	eAInstance = null;
    	String val = ApexPages.currentPage().getParameters().get('detailParam'); 
    	for(eAcademy__c eA : eAcademies){
    		if(eA.Id == val){
    			eAInstance = eA;
    			break;
    		}
    		else{
    			continue;
    		}
    	}     
        displayPopUp = true;    
    }

    public void search(){
    	InitializeeAcademyRelatedListWrapper();
    }

    public void cancelSearch(){
    	searchInput = '';
    	geteAcademies();
    }

    public class eAcademyRelatedListWrapper{
    	public String eAId{get;set;}
    	public String eAName{get;set;}
    	public String eASortTitle{get;set;}
    	public String eASortViewerInfo{get;set;}
    	public String eAViewTotalScore{get;set;}
    	public String eAViewType{get;set;}
    }

}