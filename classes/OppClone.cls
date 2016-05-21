public with sharing class OppClone {
	
	public string oppId {get;set;}
	
	public string clonedOppName {get;set;}
	
	public boolean showNewURL {get;set;}
	
	
	public Opportunity clonedOpp {get;set;}
	
	
	public OppClone() {
		
		clonedOpp = new Opportunity();
		
		showNewURL = false;
		
		oppId = ApexPages.currentPage().getParameters().get('oppId');
		
		queryOppOlis();
	}
	
	public list<newClonedLink> newLinks {get;set;}
	
	public class newClonedLink {
		
		public string oppId {get;set;}
		public string oppName {get;set;}
		
		public newClonedLink(string tOppId, string tOppName) {
			
			oppId = tOppId;
			oppName = tOppName;
		}
	}
	
	
	public Opportunity originalOpp {get;set;}
	public List<OpportunityLineItem> originalOlis {get;set;}
	
	
	public void queryOppOlis() {
		
		newLinks = new List<newClonedLink>();
		
		originalOpp = [SELECT Id, Name, CloseDate, AccountId, Account.Name, Opportunity_Names__c, National_Rep__c, Package_Type__c
					   FROM Opportunity
					   WHERE Id = :oppId];
					   
		//clonedOppName = originalOpp.Name + ' - Clone';
		
		
		originalOlis = [SELECT Id, UserPriceChange__c, Quantity, OpportunityId, UnitPrice, PriceBookEntryId, ProductId__c,
							IsPackageChild__c, Package_Discount_Percentage__c, Source_Package_Product__c, Product_Name__c,
							Generated_by_Product_Flow__c
						FROM OpportunityLineItem
						WHERE OpportunityId = :oppId];
						
		clonedOpp = originalOpp;				
	}
	
	public PageReference performClone() {
		
		showNewURL = true; 
		cloneOpp();
		
		return null;
	}
	
	
	public List<OpportunityLineItem> clonedOlis {get;set;}
	
	public void cloneOpp() {
		
		
		
		//clonedOpp = new Opportunity();
		clonedOlis = new List<OpportunityLineItem>();
		
		clonedOpp.Id = null;
		
		clonedOpp.Opportunity_Names__c = originalOpp.Opportunity_Names__c;
		
		if(clonedOpp.AccountId == null) {
			
			clonedOpp.AccountId = originalOpp.AccountId;
			
			clonedOppName = originalOpp.Account.Name + ' - ' + originalOpp.Opportunity_Names__c;
		}
		else {
			
			clonedOppName = clonedOpp.Account.Name + ' - ' + clonedOpp.Opportunity_Names__c;
		}
		
		clonedOpp.StageName = 'Prospect';
		clonedOpp.Name = clonedOppName;
		clonedOpp.CloseDate = originalOpp.CloseDate;
		clonedOpp.National_Rep__c = originalOpp.National_Rep__c;
		clonedOpp.Package_Type__c = originalOpp.Package_Type__c;
		
		system.debug('Bazinga... clonedOpp.Name: ' + clonedOpp.Name);
		
		insert clonedOpp;
		
		
		for(OpportunityLineItem oli : originalOlis) {
			
			OpportunityLineItem cloneOli = new OpportunityLineItem();
			
			cloneOli.OpportunityId = clonedOpp.Id;
						
			cloneOli.Quantity = oli.Quantity;
			cloneOli.UnitPrice = oli.UnitPrice;
			cloneOli.PriceBookEntryId = oli.PriceBookEntryId;
			cloneOli.IsPackageChild__c = oli.IsPackageChild__c;
			cloneOli.Package_Discount_Percentage__c = oli.Package_Discount_Percentage__c;
			
			cloneOli.IsBeingCloned__c = true;
			cloneOli.UserPriceChange__c = true;
			cloneOli.Source_Package_Product__c = oli.Source_Package_Product__c;
			//Code to turn off validtion rule, Opportunity Product Validation Rule: CannotCreateVinDIWithoutFlow,  when cloning
			if(String.valueOf(oli.Product_Name__c).contains('Data Integration')){
				cloneOli.Generated_by_Product_Flow__c = true;
			}
			clonedOlis.add(cloneOli);
		}
		
		insert clonedOlis;
		
		string newCloneOppName = [SELECT Id, Name FROM Opportunity WHERE Id = :clonedOpp.Id].Name;
		
		newLinks.add(new newClonedLink(clonedOpp.Id, newCloneOppName));
		
		//
		string message = 'User Id: ' + UserInfo.getUserId() + ' ... User Name: ' + UserInfo.getUserName(); 
	
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
        mail.setToAddresses(toAddresses);
        mail.setSubject('Opp Clone performed');
        mail.setPlainTextBody(message);
        
        try {
        	
        	//Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        catch(Exception e) {
        	
        }
	}
	
	
	
	public void nullPR() {
		
		//return null;
	}
	
	
	/*
	
	 - build the new opportunity name using the "account name - opportunity type"
	
	
	- Check UserPriceChange on OLIs when cloning, then uncheck them afterwards
	- Reset Stage to Prospect
	- Reset Paid_1 to No
	- Clear out Paid Date_1
	- Clear out Proposals Sent, Proposal Previewed
	- Clear out # Webex Events
	- Uncheck InstallmentsGenerated, Contract Generated, Project Exception, Project Generated
	- Reset Confirmed to No
	
	
	*/
}