public with sharing class handler_updateContractCancel {
	
	public static void updateRelatedBillingItemsCancel(List<Contract> contracts) {
		
		Set<Id> contractIds = new Set<Id>();
		
		for(Contract c : contracts) {
									//cancelled 012V00000000FaB
			if(c.RecordTypeId == '01270000000Q9vW') {
				
				contractIds.add(c.Id);
			}
		}
		
		if(contractIds.size() > 0) {
			
			List<Billing_Item__c> updateBillingItems = new List<Billing_Item__c>();
			
			updateBillingItems = [SELECT Id, RecordTypeId, End_Date__c, Contract__c, Action__c
								  FROM Billing_Item__c
								  WHERE Contract__c IN :contractIds];
			
			for(Contract c : contracts) {
				
				for(Billing_Item__c bi : updateBillingItems) {
		  		
		  			if(bi.Contract__c == c.Id) {
		  				
		  				bi.Action__c = 'Cancelled';
		  				bi.RecordTypeId = '01270000000Q9wT'; //cancelled 012V00000000FmG
		  				bi.End_Date__c = c.EndDate; 
		  			}
		  		}
			}
			
			try {
				
				update updateBillingItems;
				
				//Exception Testing and handling
	        	if(utility.throwExceptionError() == true){
	        		string Ex = null;
	        		Ex.tolowercase();
	        	}
			}
			catch(Exception e) {
				//do nothing
			}			  
		  	
		}
	}
}