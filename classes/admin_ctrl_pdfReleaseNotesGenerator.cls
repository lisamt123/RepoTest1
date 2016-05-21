public with sharing class admin_ctrl_pdfReleaseNotesGenerator {
	
	//start and end date passed via querystring
	
	//example..
	//?fromDate=2013-03-03&toDate=2013-03-25
	
	//display all CRs w/ publish to release notes = true... and in the date range passed
	//..
	
	
	//get a list of CRs.. display and group them by related object
	//..
	public string tFromDate {get;set;}
	public string tToDate {get;set;}
	
	public string fromDate {get;set;}
	public string toDate {get;set;}
	
	public string crSoql {get;set;}
	
	public List<Change_Request__c> changeRequests {get;set;}
	
	
	public admin_ctrl_pdfReleaseNotesGenerator() {
		
		fromDate = ApexPages.currentPage().getParameters().get('fromDate');
		toDate = ApexPages.currentPage().getParameters().get('toDate');
		
		tFromDate = fromDate.substring(5, 7) + '/' + fromDate.substring(8, 10) + '/' + fromDate.substring(0, 4);
		tToDate = toDate.substring(5, 7) + '/' + toDate.substring(8, 10) + '/' + toDate.substring(0, 4);
		
		crSoql = 'SELECT Id, Name, Publish_to_Release_Notes__c, Related_Object__c, Release_Notes_Details__c, Subject__c, Date_Completed__c FROM Change_Request__c WHERE Publish_to_Release_Notes__c = \'Yes\'';
		
		runQuery();
	}
	
	
	
	
	public void runQuery() {
		
		changeRequests = Database.query(crSoql + ' AND Date_Completed__c >= ' + fromDate + ' AND Date_Completed__c <= ' + toDate + ' ORDER BY Related_Object__c, Date_Completed__c ASC');
		
		organizeTable();
	}
	
	
	public void organizeTable() {
		
		//create map method instead mapping related object to record
		
		releaseNotesTables = new List<releaseNotesTable>();
		
		string tObjectName = '';
		
		List<Change_Request__c> tCRs;
		
		for(Change_Request__c cr : changeRequests) {
			
			system.debug('Bazinga... crName: ' + cr.Name);
			system.debug('Bazinga... crRelatedObject: ' + cr.Related_Object__c);
			
			if(cr.Related_Object__c != tObjectName) {
				
				system.debug('Bazinga... 1');
				
				if(tCRs != null) {
					
					system.debug('Bazinga... 2');
					
					releaseNotesTables.add(new releaseNotesTable(tObjectName, tCRs));
				}
				
				system.debug('Bazinga... 3');
				
				tCRs = new List<Change_Request__c>();
				
				tObjectName = cr.Related_Object__c;
				tCRs.add(cr);
			}
			else {
				
				system.debug('Bazinga... 4');
				
				tCRs.add(cr);
			}
		}
		
		releaseNotesTables.add(new releaseNotesTable(tObjectName, tCRs));
	}
	
	
	
	//
	//..
	public List<releaseNotesTable> releaseNotesTables {get;set;}
	
	public class releaseNotesTable {
		
		public string objectName {get;set;}
		
		public List<Change_Request__c> relatedCRs {get;set;}
		
		public releaseNotesTable(string tmpObjectName, List<Change_Request__c> tmpRelatedCRs) {
			
			objectName = tmpObjectName;
			
			relatedCRs = tmpRelatedCRs;
		}
	}
	
	
	
	
	
	
	
	
}