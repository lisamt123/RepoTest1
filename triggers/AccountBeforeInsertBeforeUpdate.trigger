trigger AccountBeforeInsertBeforeUpdate on Account (before insert, before update) {
	Map<String, List<Account>> acctZipMap = new Map<String, List<Account>>();
	Map<String, List<Account>> acctStateMap = new Map<String, List<Account>>();
	List<Account> allAccts = new List<Account>();

	if(Advanced_Team_Management__c.getOrgDefaults().Enable_Account_Team_Triggers__c) {
		for(Account acct : trigger.new) {
			Account old = trigger.isUpdate ? trigger.oldMap.get(acct.Id) : new Account();

			if(acct.Zip_Postal_Code__c != old.Zip_Postal_Code__c || (acct.Zip_Postal_Code__c == null && acct.ShippingPostalCode != null) || (acct.Zip_Postal_Code__c == null && acct.ShippingState != null) || acct.ShippingPostalCode != old.ShippingPostalCode || acct.ShippingState != old.ShippingState || acct.Update_Team_Members__c) {
				acct.Zip_Postal_Code__c = null;
				allAccts.add(acct);
			}
		}

		if(!allAccts.isEmpty()) {
			District__c unknown;
			
			try {
				unknown = [SELECT Id, Region__c FROM District__c WHERE Unknown_District__c = true LIMIT 1];
			} catch(QueryException ex) {
				unknown = new District__c();
			}

			for(Account acct : allAccts) {
				acct.VAT_District__c = unknown.Id;
				acct.VIN_District__c = unknown.Id;
				acct.HAY_District__c = unknown.Id;
				acct.VAT_Region__c = unknown.Region__c;
				acct.VIN_Region__c = unknown.Region__c;
				acct.HAY_Region__c = unknown.Region__c;

				if(acct.ShippingPostalCode != null) {
					String shippingPostalCode = acct.ShippingPostalCode.length() >= 5 ? acct.ShippingPostalCode.substring(0,5) : acct.ShippingPostalCode;
					List<Account> accts = acctZipMap.containsKey(shippingPostalCode) ? acctZipMap.get(shippingPostalCode) : new List<Account>();
					accts.add(acct);
					acctZipMap.put(shippingPostalCode, accts);
					System.debug(System.loggingLevel.Info, shippingPostalCode);
				}
			}

			if(!acctZipMap.isEmpty()) {
				Map<String, Id> zipMap = new Map<String, Id>();
				Map<String, Map<String, Related_Zip_Postal_Code__c>> relZipMap = new Map<String, Map<String, Related_Zip_Postal_Code__c>>();

				for(Zip_Postal_Code__c zip : [SELECT Id, Name FROM Zip_Postal_Code__c WHERE Name IN :acctZipMap.keySet()]) {
					zipMap.put(zip.Name, zip.Id);
				}

				if(!zipMap.isEmpty()) {
					for(Related_Zip_Postal_Code__c relZip : [SELECT Id, Zip_Postal_Code__c, Zip_Postal_Code__r.Name, District__c, District__r.Region__c, District__r.Business_Unit__r.Name FROM Related_Zip_Postal_Code__c WHERE Zip_Postal_Code__c IN :zipMap.values()]) {
						Map<String, Related_Zip_Postal_Code__c> relZipUnitMap = relZipMap.containsKey(relZip.Zip_Postal_Code__r.Name) ? relZipMap.get(relZip.Zip_Postal_Code__r.Name) : new Map<String, Related_Zip_Postal_Code__c>();
						relZipUnitMap.put(relZip.District__r.Business_Unit__r.Name, relZip);
						relZipMap.put(relZip.Zip_Postal_Code__r.Name, relZipUnitMap);
					}
				}

				for(String zip : acctZipMap.keySet()) {
					List<Account> accts = acctZipMap.get(zip);

					for(Account acct : accts) {
						String shippingPostalCode = acct.ShippingPostalCode.length() >= 5 ? acct.ShippingPostalCode.substring(0,5) : acct.ShippingPostalCode;

						if(zipMap.containsKey(shippingPostalCode)) {
							acct.Zip_Postal_Code__c = zipMap.get(shippingPostalCode);
						}

						if(relZipMap.containsKey(shippingPostalCode)) {
							Map<String, Related_Zip_Postal_Code__c> relZipUnitMap = relZipMap.get(shippingPostalCode);

							acct.VAT_District__c = relZipUnitMap.containsKey('VAT') ? relZipUnitMap.get('VAT').District__c : acct.VAT_District__c;					
							acct.VIN_District__c = relZipUnitMap.containsKey('VIN') ? relZipUnitMap.get('VIN').District__c : acct.VIN_District__c;
							acct.HAY_District__c = relZipUnitMap.containsKey('HAY') ? relZipUnitMap.get('HAY').District__c : acct.HAY_District__c;
							acct.VAT_Region__c = relZipUnitMap.containsKey('VAT') ? relZipUnitMap.get('VAT').District__r.Region__c : acct.VAT_Region__c;
							acct.VIN_Region__c = relZipUnitMap.containsKey('VIN') ? relZipUnitMap.get('VIN').District__r.Region__c : acct.VIN_Region__c;
							acct.HAY_Region__c = relZipUnitMap.containsKey('HAY') ? relZipUnitMap.get('HAY').District__r.Region__c : acct.HAY_Region__c;
						}
					}
				}
			}

			for(Account acct : allAccts) {
				if(acct.VAT_District__c == unknown.Id || acct.VIN_District__c == unknown.Id || acct.HAY_District__c == unknown.Id || acct.VAT_Region__c == unknown.Region__c || acct.VIN_Region__c == unknown.Region__c || acct.HAY_Region__c == unknown.Region__c) {
					List<Account> stateAccts = acctStateMap.containsKey(acct.ShippingState) ? acctStateMap.get(acct.ShippingState) : new List<Account>();
					stateAccts.add(acct);
					acctStateMap.put(acct.ShippingState, stateAccts);
				}
			}

			acctStateMap.remove(null);

			if(!acctStateMap.isEmpty()) {
				Set<Id> stateIds = new Set<Id>();
				Map<String, Map<String, Related_State_Province__c>> relStateMap = new Map<String, Map<String, Related_State_Province__c>>();

				for(State_Province__c state : [SELECT Id FROM State_Province__c WHERE Name IN :acctStateMap.keySet()]) {
					stateIds.add(state.Id);
				}

				if(!stateIds.isEmpty()) {
					for(Related_State_Province__c relState : [SELECT Id, State_Province__c, State_Province__r.Name, District__c, District__r.Region__c, District__r.Business_Unit__r.Name FROM Related_State_Province__c WHERE State_Province__c IN :stateIds]) {
						Map<String, Related_State_Province__c> relStateUnitMap = relStateMap.containsKey(relState.State_Province__r.Name) ? relStateMap.get(relState.State_Province__r.Name) : new Map<String, Related_State_Province__c>();
						relStateUnitMap.put(relState.District__r.Business_Unit__r.Name, relState);
						relStateMap.put(relState.State_Province__r.Name, relStateUnitMap);
					}
				}

				for(String state : acctStateMap.keySet()) {
					List<Account> accts = acctStateMap.get(state);

					for(Account acct : accts) {
						if(relStateMap.containsKey(acct.ShippingState)) {
							Map<String, Related_State_Province__c> relStateUnitMap = relStateMap.get(acct.ShippingState);

							acct.VAT_District__c = relStateUnitMap.containsKey('VAT') && acct.VAT_District__c == unknown.Id ? relStateUnitMap.get('VAT').District__c : acct.VAT_District__c;					
							acct.VIN_District__c = relStateUnitMap.containsKey('VIN') && acct.VIN_District__c == unknown.Id ? relStateUnitMap.get('VIN').District__c : acct.VIN_District__c;
							acct.HAY_District__c = relStateUnitMap.containsKey('HAY') && acct.HAY_District__c == unknown.Id ? relStateUnitMap.get('HAY').District__c : acct.HAY_District__c;
							acct.VAT_Region__c = relStateUnitMap.containsKey('VAT') && acct.VAT_Region__c == unknown.Region__c ? relStateUnitMap.get('VAT').District__r.Region__c : acct.VAT_Region__c;
							acct.VIN_Region__c = relStateUnitMap.containsKey('VIN') && acct.VIN_Region__c == unknown.Region__c ? relStateUnitMap.get('VIN').District__r.Region__c : acct.VIN_Region__c;
							acct.HAY_Region__c = relStateUnitMap.containsKey('HAY') && acct.HAY_Region__c == unknown.Region__c ? relStateUnitMap.get('HAY').District__r.Region__c : acct.HAY_Region__c;
						}
					}
				}
			}
		}
	}
}