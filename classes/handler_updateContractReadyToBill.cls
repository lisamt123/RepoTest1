public with sharing class handler_updateContractReadyToBill {
	
	public static void updateRelatedBillingItemsReadyToBill(List<Contract> contracts) {
		
		Set<Id> contractIds = new Set<Id>();
		
		for(Contract c : contracts) {
								//add 012V00000000FaA
			if(c.RecordTypeId == '01270000000Q9vU' && c.Ready_To_Bill__c == true) {
				
				contractIds.add(c.Id);
			}
		}
		
		if(contractIds.size() > 0) {
		
			List<Billing_Item__c> updateBillingItems = new List<Billing_Item__c>();
			
			updateBillingItems = [SELECT Id, Ready_To_Bill__c
								  FROM Billing_Item__c
								  WHERE Contract__c IN :contractIds];
								  
			for(Billing_Item__c bi : updateBillingItems) {
				
				bi.Ready_To_Bill__c = true;
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