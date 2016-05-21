public with sharing class admin_ctrl_releaseNotes2 {
	
	private string crSoql {get;set;}
	
	//the current sort direction. defaults to asc
    public String sortDir {
        
        get { if (sortDir == null) {  sortDir = 'ASC'; } return sortDir;    }
        set; 
    }
    
    //the current field to sort by. defaults to name
    public String sortField {
        
        get { if (sortField == null) { sortField = 'Name'; } return sortField;   }
        set;
    }
	
	public integer crQty {get;set;}
	
	public List<Change_Request__c> changeRequests {get;set;}
	
	public Date fromDate {get;set;}
	//public Date toDate {get;set;}
	
	public string debugCrSoql {
		
		get { return crSoql; }
		set;
	}
	
	public admin_ctrl_releaseNotes2() { 
		
		crSoql = 'SELECT Id, Name, Date_Completed__c, Change_Request_Status__c, Owner.Name, Subject__c, Publish_to_Release_Notes__c FROM Change_Request__c WHERE Publish_to_Release_Notes__c = \'No\' AND Change_Request_Status__c = \'Completed\'';
		
		runQuery();
	}
	
	//toggles the sorting of query from asc<-->desc
    public void toggleSort() {
    
        //simply toggle the direction
        sortDir = sortDir.equals('ASC') ? 'DESC' : 'ASC';
    
        //run the query again
        runQuery();
    }
	
	public void runQuery() {
		
		try {
			
			changeRequests = Database.query(crSoql + ' ORDER BY ' + sortField + ' ' + sortDir + ' LIMIT 1000');
			
			crQty = changeRequests.size();
		}
		catch(Exception e) {
			
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Ooops!... ' + e));
		}
	}
	
	/*
	public PageReference runSearch() {
		
		string crName = Apexpages.currentPage().getParameters().get('crName');
		
		crSoql = 'SELECT Id, Name, Date_Completed__c, CR_Search_Formula__c, Owner.Name, Subject__c, Publish_to_Release_Notes__c FROM Change_Request__c WHERE Publish_to_Release_Notes__c = \'No\'';
		
		if(!crName.equals('')) {
			
			crSoql += ' AND CR_Search_Formula__c LIKE \'%'+String.escapeSingleQuotes(crName)+'%\'';
		}
		
		runQuery();
		
		return null;
	}
	*/
	
	
	public string fromDatePicker {get;set;}
	public string toDatePicker {get;set;}
	
	public PageReference runFilter() {
		
		fromDatePicker = Apexpages.currentPage().getParameters().get('fromDatePicker');
		toDatePicker = Apexpages.currentPage().getParameters().get('toDatePicker');
		
		crSoql = 'SELECT Id, Name, Date_Completed__c, Change_Request_Status__c, Release_Notes_Details__c, Owner.Name, Subject__c, Publish_to_Release_Notes__c FROM Change_Request__c WHERE Publish_to_Release_Notes__c = \'No\' AND Change_Request_Status__c = \'Completed\'';
		
		if(!fromDatePicker.equals('')) {
			
			Date d;
			
			Integer month_num = Integer.valueOf(fromDatePicker.subString(0, fromDatePicker.indexOf('/', 0)));
			Integer date_num = Integer.valueOf(fromDatePicker.subString(fromDatePicker.indexOf('/', 0) + 1, fromDatePicker.indexOf('/', fromDatePicker.indexOf('/', 0) + 1)));
			Integer year_num = Integer.valueOf(fromDatePicker.subString(fromDatePicker.indexOf('/', 0) + fromDatePicker.indexOf('/', fromDatePicker.indexOf('/', 0) + 1), fromDatePicker.length())); 
			
			d = date.newinstance(year_num, month_num, date_num);
			
			string s = string.valueOf(d);
			
			s = s.substring(0, 10);
			
			fromDatePicker = s;
			
			crSoql += ' AND Date_Completed__c >= ' + s;
		}
		
		if(!toDatePicker.equals('')) {
			
			Date d;
			
			Integer month_num = Integer.valueOf(toDatePicker.subString(0, toDatePicker.indexOf('/', 0)));
			Integer date_num = Integer.valueOf(toDatePicker.subString(toDatePicker.indexOf('/', 0) + 1, toDatePicker.indexOf('/', toDatePicker.indexOf('/', 0) + 1)));
			Integer year_num = Integer.valueOf(toDatePicker.subString(toDatePicker.indexOf('/', 0) + toDatePicker.indexOf('/', toDatePicker.indexOf('/', 0) + 1), toDatePicker.length())); 
			
			d = date.newinstance(year_num, month_num, date_num);
			
			string s = string.valueOf(d);
			
			s = s.substring(0, 10);
			
			toDatePicker = s;
			
			crSoql += ' AND Date_Completed__c <= ' + s;
		}
		
		runQuery();
		
		return null;
	}
	
	
	
	
	public string publishCRId {get;set;}
	
	public PageReference publishCR() {
		
		publishToReleaseNotes();
		
		runQuery();
		
		return null;
	}
	
	public void publishToReleaseNotes() {
		
		if(publishCRId != null) {
			
			for(Change_Request__c cr : changeRequests) {
				
				if(cr.Id == publishCRId) {
					
					cr.Publish_to_Release_Notes__c = 'Yes';
					
					break;
				}
			}
			
			update changeRequests;
		}
	}
	
	/*
	public PageReference runFilter() {
		
		string fromDatePicker = Apexpages.currentPage().getParameters().get('fromDatePicker');
		string toDatePicker = Apexpages.currentPage().getParameters().get('toDatePicker');
		
		rnSoql = 'SELECT Id, Name, Body__c, Start_Date__c, End_Date__c, Published_Date__c FROM Release_Note__c WHERE Name != null';
		
		if(!fromDatePicker.equals('')) {
			
			Date d;
			
			Integer month_num = Integer.valueOf(fromDatePicker.subString(0, fromDatePicker.indexOf('/', 0)));
			Integer date_num = Integer.valueOf(fromDatePicker.subString(fromDatePicker.indexOf('/', 0) + 1, fromDatePicker.indexOf('/', fromDatePicker.indexOf('/', 0) + 1)));
			Integer year_num = Integer.valueOf(fromDatePicker.subString(fromDatePicker.indexOf('/', 0) + fromDatePicker.indexOf('/', fromDatePicker.indexOf('/', 0) + 1), fromDatePicker.length())); 
			
			d = date.newinstance(year_num, month_num, date_num);
			
			string s = string.valueOf(d);
			
			s = s.substring(0, 10);
			
			rnSoql += ' AND Published_Date__c >= ' + s;
		}
		
		if(!toDatePicker.equals('')) {
			
			Date d;
			
			Integer month_num = Integer.valueOf(toDatePicker.subString(0, toDatePicker.indexOf('/', 0)));
			Integer date_num = Integer.valueOf(toDatePicker.subString(toDatePicker.indexOf('/', 0) + 1, toDatePicker.indexOf('/', toDatePicker.indexOf('/', 0) + 1)));
			Integer year_num = Integer.valueOf(toDatePicker.subString(toDatePicker.indexOf('/', 0) + toDatePicker.indexOf('/', toDatePicker.indexOf('/', 0) + 1), toDatePicker.length())); 
			
			d = date.newinstance(year_num, month_num, date_num);
			
			string s = string.valueOf(d);
			
			s = s.substring(0, 10);
			
			rnSoql += ' AND Published_Date__c <= ' + s;
		}
		
		runQuery();
		
		return null;
	}
	*/
	
	
	public PageReference nullPR() {
		
		return null;
	}
}