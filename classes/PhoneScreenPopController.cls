public with sharing class PhoneScreenPopController {
	public String incomingNumber {get; set;}
	public LIST<Account> relatedAccounts {get; set;}
	public LIST<Contact> relatedContacts {get; set;}
	public LIST<Case> relatedCases {get; set;}
	public LIST<Opportunity> relatedOpportunities {get; set;}
	public LIST<SFDC_520_Quote__c> relatedProjects {get; set;}
	public Map<Id, String> theseObjectsIdMap {get; set;}
	public Map<Id, Contact> theseContactsIdMap {get; set;}
	public Map<Id, Account> theseAccountsIdMap {get; set;}
	
	public LIST<LIST<sObject>> theseObjectsQuery {get; set;}
	
		
	
	public PhoneScreenPopController ()
	{
		init();
	}
	
	public void init(){
		
		populateIncomingNumber();
		if (incomingNumber.length() > 9)
		{
			setTheseObjectsQuery();
			setTheseObjectsIdMap();
			setRelatedContacts();
			setRelatedAccounts();
			
			setTheseContactsIdMap();
			setTheseAccountsIdMap();					
			
			setRelatedCases();
			setRelatedOpportunities();		
			setRelatedProjects();
		}
	}
	
	
	public Map<Id, Contact> getTheseContactsIdMap(){
		return theseContactsIdMap;
	}
	
	public Map<Id, Account> getTheseAccountsIdMap(){
		return theseAccountsIdMap;
	}
	
	public Map<Id, String> getTheseObjectsIdMap(){
		return theseObjectsIdMap;
	}	
	public LIST<Account> getRelatedAccounts(){
		return relatedAccounts;
	}
	public LIST<Contact> getRelatedContacts(){
		return relatedContacts;
	}
	public LIST<Case> getRelatedCases(){
		return relatedCases;
	}
	public LIST<Opportunity> getRelatedOpportunities(){
		return relatedOpportunities;
	}
	public LIST<SFDC_520_Quote__c> getRelatedProjects(){
		return relatedProjects;
	}

	
	public void setTheseObjectsQuery(){
		if(incomingNumber != null)
		{
			String searchquery='FIND \'' + incomingNumber + '*\' IN ALL FIELDS RETURNING Account, Case, Contact';
			theseObjectsQuery = search.query(searchQuery);	
		}
				
	}
	
	public void setTheseObjectsIdMap(){
		theseObjectsIdMap = new MAP<Id, String>();
		for (LIST<sObject> theseListObjects: theseObjectsQuery)
		{
			for (sObject thisObject: theseListObjects)
			{
				system.debug('thisObject.Id DEBUG: '+ thisObject.Id);
				theseObjectsIdMap.put(thisObject.Id, null);
			}			
		}
	}
	
	public void setTheseContactsIdMap(){
		theseContactsIdMap = new MAP<Id, Contact>(relatedContacts);		
	}
	
	public void setTheseAccountsIdMap(){
		theseAccountsIdMap = new MAP<Id, Account>(relatedAccounts);
	}
	public void setRelatedAccounts(){
		relatedAccounts = [select Id, Name, Phone, BillingCity, BillingState, AccountNumber from Account where Id IN :theseObjectsIdMap.keyset()];				
	}
	public void setRelatedContacts(){
		relatedContacts = [select Id, Name, Phone, MobilePhone,AssistantPhone, 	HomePhone, account_name__c, OtherPhone, AccountId 
		from Contact where Id IN :theseObjectsIdMap.keyset()];				
	}
	public void setRelatedCases(){
		relatedCases = [select Id, CaseNumber, Subject, ContactId, AccountId, Status, CreatedDate from Case 
		where (ContactId IN: theseContactsIdMap.keyset() OR AccountId IN: theseAccountsIdMap.keyset()) AND
		CreatedDate > :(system.today()-30) ORDER BY CreatedDate DESC limit 20];
		
		//relatedCases = [select Id, AccountId, CaseNumber, Subject from Case where Id IN :theseObjectsIdMap.keyset()];		
	}
	public void setRelatedOpportunities(){
		relatedOpportunities = [select Id, AccountId, CreatedDate from Opportunity where (Deal_Contact__c IN: theseContactsIdMap.keyset() OR Implementation_Contact__c IN :theseContactsIdMap.keyset()) AND CreatedDate > :(system.today()-30) ORDER BY CreatedDate DESC limit 20];
		
	}
	public void setRelatedProjects(){		
		relatedProjects = [select Id, Account__c, Contact__c, Implementation_Manager__c, Project_Name__c, CreatedDate from SFDC_520_Quote__c where 
		(Contact__c IN: theseContactsIdMap.keyset() OR Implementation_Manager__c IN: theseContactsIdMap.keyset()) ORDER BY CreatedDate DESC limit 20];	
	}
	
	public PageReference populateIncomingNumber()
	{
		incomingNumber = Apexpages.currentPage().getParameters().get('phonenumber');
		return null;	
	}
	
}