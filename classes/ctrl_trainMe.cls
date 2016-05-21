public with sharing class ctrl_trainMe {
	
	public string parentCRSubject {get;set;}
	public string parentCRId {get;set;}
	
	public string subject {get;set;}
	
	public string requestDetails {get;set;}
	
	
	public ctrl_trainMe() {
		
		parentCRSubject = Apexpages.currentPage().getParameters().get('parentCRSubject');
		parentCRId = Apexpages.currentPage().getParameters().get('parentCRId');
		
		
		subject = 'Training requested - ' + parentCRSubject;
		
		requestDetails = 'Assistance requested on associated Change Request';
	}
	
	public PageReference saveCR() {
		
		Change_Request__c newCR = new Change_Request__c();
		
		newCR.Subject__c = subject;
		newCR.Change_Type__c = 'Salesforce Training';
		newCR.Publish_to_Release_Notes__c = 'No';
		newCR.Request_Details__c = requestDetails;
		newCR.Parent_Change__c = parentCRId;
		
		insert newCR;
		
		PageReference pr = new PageReference('/' + newCR.Id);
        return pr.setRedirect(true);
	}
	
	
	public PageReference nullPR() {
		
		return null;
	}

}