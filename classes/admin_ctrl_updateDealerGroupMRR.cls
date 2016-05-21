public with sharing class admin_ctrl_updateDealerGroupMRR {
	
	public list<Billing_Item__c> allBillingItems = new list<Billing_Item__c>();
	
	public list<Billing_Item__c> billingItems {get;set;}
	//public list<Billing_Item__c> debugBillingItems{get;set;}
	
	public string debugBillingItemId {get;set;}
	
	public string billingItemsSize {get;set;}
	//public string debugBillingItemsSize {get;set;}
	
	public admin_ctrl_updateDealerGroupMRR() {
		
		updateBillingItems();
	}
	
	public void btnUpdate_Click() {
		
		job_updateDealerGroupMRR j = new job_updateDealerGroupMRR();
		Id jId = Database.executeBatch(j, 20);
	}
	
	public void btnStartBilledJob() {
		
		job_updateBilledRecRev j = new job_updateBilledRecRev();
		Id jId = Database.executeBatch(j);
	}
	
	public void btnDeactivate_Click() {
		
		job_updateDelayStop j = new job_updateDelayStop();
		Id jId = Database.executeBatch(j, 1);
	}
	
	public PageReference peformDebug() {
		
		doDebug();
		updateBillingItems();
		
		return null;
	}
	
	public void doDebug() {
		
		if(debugBillingItemId != null) {
		
			Billing_Item__c updateBillingItem = new Billing_Item__c();
			
			for(Billing_Item__c bi : billingItems) {
				
				if(bi.Id == debugBillingItemId) {
					
					updateBillingItem = bi;
					updateBillingItem.Debug__c = true;
					break;
				}
			}
			
			update updateBillingItem;
		}
	}
	
	
	public void updateBillingItems() {
		
		allBillingItems = [SELECT Id, End_Date__c, MSDelayRemovedDONOTCHANGE__c, Debug__c FROM Billing_Item__c WHERE MSDelayRemovedDONOTCHANGE__c = true OR Debug__c = true];
		
		billingItems = new list<Billing_Item__c>();
		//debugBillingItems = new list<Billing_Item__c>();
		
		for(Billing_Item__c bi : allBillingItems) {
			
			if(bi.MSDelayRemovedDONOTCHANGE__c == true) {
				
				billingItems.add(bi);
			}
			
			//if(bi.Debug__c == true) {
				
				//debugBillingItems.add(bi);
			//}
		}
		
		billingItemsSize = string.valueof(billingItems.size());
		//debugBillingItemsSize = string.valueof(debugBillingItems.size());
	}
}