trigger TerritoryStateUserUpdate on Territory_State__c (after update) {
	
	list<Territory_State__c> tsStateChanges = trigger.new; 
	list<Territory_State__c> tsStateChangesOld = trigger.old;
	list<String> statesChanged = new list<String>();
	list<Territory_State__c> TSStatesToUpdate = new list<Territory_State__c>();
	for(Territory_State__c TS: tsStateChanges){
		for(Territory_State__c TSO: tsStateChangesOld){
			
			if(TS.Id == TSO.Id){
				if(TS.Website_AM__c != TSO.Website_AM__c || /*TS.Account_Manager__c != TSO.Account_Manager__c ||*/ TS.VinPro_Manager__c != TSO.VinPro_Manager__c){
					statesChanged.add(TS.Name);
					TSStatesToUpdate.add(TS);
				}
			}
		}
	}
	
	list<Account> acctsToUpdate = [SELECT BillingState
								   FROM Account
								   WHERE BillingState IN : statesChanged];
								   
	for(Territory_State__c TS: TSStatesToUpdate){
		
		for(Account A: acctsToUpdate){
			
			/*A.VinPro2__c = TS.Account_Manager__c;*/
			A.WAM2__c = TS.Website_AM__c;
			/*A.DDM2__c = TS.DDM__c;
			A.VinPro_Manager2__c = TS.Account_Manager__r.Reports_To__c; */
		}
	}
	update acctsToUpdate;
}