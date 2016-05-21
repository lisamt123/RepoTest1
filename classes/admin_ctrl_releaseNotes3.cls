public with sharing class admin_ctrl_releaseNotes3 {
	
	
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
    
    public string newChatterPostId {get;set;}
    public boolean showChatterLink {get;set;}
	
	public integer crQty {get;set;}
	
	public List<Change_Request__c> changeRequests {get;set;}
	
	public Date fromDate {get;set;}
	//public Date toDate {get;set;}
	
	public string debugCrSoql {
		
		get { return crSoql; }
		set;
	}
	
	public admin_ctrl_releaseNotes3() { 
		
		
		newChatterPostId = Apexpages.currentPage().getParameters().get('newChatterPostId');
		
		if(newChatterPostId != null) {
			
			showChatterLink = true;
		}
		else {
			
			showChatterLink = false;
		}
		
		//crSoql = 'SELECT Id, Name, Date_Completed__c, Release_Notes_Details__c, CR_Search_Formula__c, Owner.Name, Subject__c, Publish_to_Release_Notes__c FROM Change_Request__c WHERE Publish_to_Release_Notes__c = \'Yes\'';
		crSoql = 'SELECT Id, Name, Date_Completed__c, Change_Request_Status__c, Release_Notes_Details__c, Owner.Name, Subject__c, Publish_to_Release_Notes__c FROM Change_Request__c WHERE Publish_to_Release_Notes__c = \'Yes\' AND Change_Request_Status__c = \'Completed\'';
		
		runQuery();
	}
	
	//toggles the sorting of query from asc<-->desc
    public void toggleSort() {
    
        //simply toggle the direction
        sortDir = sortDir.equals('ASC') ? 'DESC' : 'ASC';
    
        //run the query again
        runQuery();
    }
	
	/* -----------------------------------
    search/sort/filter variables/methods
    ----------------------------------- */
	
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
		
		crSoql = 'SELECT Id, Name, Date_Completed__c, Release_Notes_Details__c, CR_Search_Formula__c, Owner.Name, Subject__c, Publish_to_Release_Notes__c FROM Change_Request__c WHERE Publish_to_Release_Notes__c = \'Yes\'';
		
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
		
		crSoql = 'SELECT Id, Name, Date_Completed__c, Change_Request_Status__c, Release_Notes_Details__c, Owner.Name, Subject__c, Publish_to_Release_Notes__c FROM Change_Request__c WHERE Publish_to_Release_Notes__c = \'Yes\' AND Change_Request_Status__c = \'Completed\'';
		
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
	
	
	/* -------------------------
    PDF Generate methods
    ------------------------- */
    public string chatterBody {get;set;}
	
	public PageReference createPDF() {
		
		PageReference pdf = Page.admin_pdfReleaseNotesGenerator;
		
		pdf.getParameters().put('fromDate', fromDatePicker);
		pdf.getParameters().put('toDate', toDatePicker);
		
		//the contents of the attachment from the pdf
		Blob body;
		
		body = pdf.getContent();
		
		
		//Release_Note__c newRN = new Release_Note__c();
		//newRN.Body__c = body.toString();
		//newRN.Body__c = EncodingUtil.base64Encode(body);
		
		//insert newRN;
		
		//string toDate = toDatePicker.substring(5, 7) + '/' + toDatePicker.substring(8, 10) + '/' + toDatePicker.substring(0, 4);
		
		//vin group id: 0F97000000001Ei
		//api user id: 00570000001fBU9
		//mark user id: 00570000001fuQH
		
		FeedItem post = new FeedItem();
		post.ParentId = '0F97000000001Ei';
		post.Body = chatterBody;
		post.CreatedById = '00570000001fBU9';
		post.Type = 'ContentPost';
		post.ContentData = body;
		post.ContentFileName = 'Release Notes ' + toDatePicker.substring(5, 7) + '-' + toDatePicker.substring(8, 10) + '-' + toDatePicker.substring(0, 4) + '.pdf';
		
		insert post;
		
		
		//return new PageReference('/' + newRN.Id);
		
		return new PageReference('/apex/admin_ReleaseNotes3?newChatterPostId=' + post.Id).setRedirect(true);
		
		
		/*
		//create new attachment
		Attachment attach = new Attachment();
		attach.Body = body;
		attach.Name = 'TestName.pdf';
		attach.IsPrivate = false;
		attach.contentType = 'pdf';
		//attach the pdf to the release notes
		attach.ParentId = newRN.Id;
		
		insert attach;
		*/
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
    /* -------------------------
    Un-Publish variables
    ------------------------- */
	
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
					
					cr.Publish_to_Release_Notes__c = 'No';
					
					break;
				}
			}
			
			update changeRequests;
		}
	}
	
	
	
	
	 /* -------------------------
    Modal Dialog variables
    ------------------------- */
    //the current change request displayed in modal
    public Change_Request__c changeRequest {get;set;}
    
    public string selectedChangeRequestId {get;set;}
    
    public PageReference openModal() {
    	
    	assignSelectedCRModal();
    	
    	return null;
    }
    
    public void assignSelectedCRModal() {
    	
    	changeRequest = new Change_Request__c();
    	
    	for(Change_Request__c cr : changeRequests) {
    		
    		if(cr.Id == selectedChangeRequestId) {
    			
    			changeRequest = cr;
    		}
    	}
    }
    
    public PageReference closeModal() {
    	
    	saveModal();
    	
    	PageReference pr = new PageReference('/apex/admin_ReleaseNotes3');
    	return pr.setRedirect(true);
    }
	
	public void saveModal() {
		
		update changeRequest;
	}
	
	
	
	public PageReference nullPR() {
		
		
		string fromDate = fromDatePicker.substring(5, 7) + '/' + fromDatePicker.substring(8, 10) + '/' + fromDatePicker.substring(0, 4);
		string toDate = toDatePicker.substring(5, 7) + '/' + toDatePicker.substring(8, 10) + '/' + toDatePicker.substring(0, 4);
		
		
		chatterBody = 'Here are the Salesforce Release Notes for work completed on ' + fromDate + ' through ' + toDate + '. Have a good day!';
		
		
		return null;
	}
}