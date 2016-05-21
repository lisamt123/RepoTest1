global with sharing class AccountTeamUpdater implements Database.Batchable<sObject> {
	Map<Id, District__c> distMap;
	Map<Id, Region__c> regMap;
	Map<Id, Zip_Postal_Code__c> zipMap;
	Map<Id, Related_State_Province__c> stateMap;
	List<Opportunity> opps;
	Set<String> stateSet;
	Set<String> zipSet;

	global AccountTeamUpdater() {}
	
	global Database.QueryLocator start(Database.BatchableContext bc) {
		String distQuery = DistrictRegionSchemaUtility.generateQueryNull('District__c', 'Processed_D_T__c');
		String regQuery = DistrictRegionSchemaUtility.generateQueryNull('Region__c', 'Processed_D_T__c');
		String zipQuery = DistrictRegionSchemaUtility.generateQueryNull('Zip_Postal_Code__c', 'Processed_D_T__c');
		String stateQuery = DistrictRegionSchemaUtility.generateQueryNull('Related_State_Province__c', 'Processed_D_T__c');

		distMap = new Map<Id, District__c>((List<District__c>) Database.query(distQuery));
		regMap = new Map<Id, Region__c>((List<Region__c>) Database.query(regQuery));
		zipMap = new Map<Id, Zip_Postal_Code__c>((List<Zip_Postal_Code__c>) Database.query(zipQuery));
		stateSet = new Set<String>();
		zipSet = new Set<String>();
		
		for(Related_State_Province__c rsp : (List<Related_State_Province__c>) Database.query(stateQuery)) {
			stateSet.add(rsp.Name);
		}

		for(Zip_Postal_Code__c zpc : zipMap.values()) {
			zipSet.add(zpc.Name);
		}
		
		return Database.getQueryLocator([SELECT Id, Update_Team_Members__c FROM Account WHERE VIN_District__c IN :distMap.keySet() OR VAT_District__c IN :distMap.keySet() OR HAY_District__c IN :distMap.keySet() OR VIN_Region__c IN :regMap.keySet() OR VAT_Region__c IN:regMap.keySet() OR Hay_Region__c IN:regMap.keySet() OR Zip_Postal_Code__c IN :zipMap.keySet() OR ShippingState IN :stateSet OR ShippingPostalCode IN :zipSet]);
	}

   	global void execute(Database.BatchableContext bc, List<Account> accts) {
   		Set<Id> acctIds = new Set<Id>();

		for(Account acct : accts) {
			acct.Update_Team_Members__c = true;
			acctIds.add(acct.Id);
		}

		Database.update(accts, false);

		opps = [SELECT Id, Update_Regional_Manager__c FROM Opportunity WHERE IsClosed = false AND AccountId IN :acctIds AND Business_Unit__c = 'VinSolutions'];

		if(!opps.isEmpty()) {
			for(Opportunity opp : opps) {
				opp.Update_Regional_Manager__c = true;
			}

			Database.update(opps, false);
		}
	}
	
	global void finish(Database.BatchableContext bc) {
		Datetime now = System.now();

		String distQuery = DistrictRegionSchemaUtility.generateQueryNull('District__c', 'Processed_D_T__c');
		String regQuery = DistrictRegionSchemaUtility.generateQueryNull('Region__c', 'Processed_D_T__c');
		String zipQuery = DistrictRegionSchemaUtility.generateQueryNull('Zip_Postal_Code__c', 'Processed_D_T__c');
		String stateQuery = DistrictRegionSchemaUtility.generateQueryNull('Related_State_Province__c', 'Processed_D_T__c');
		String oppQuery = DistrictRegionSchemaUtility.generateQueryCompare('Opportunity', 'Update_Regional_Manager__c', 'true');

		distMap = new Map<Id, District__c>((List<District__c>) Database.query(distQuery));
		regMap = new Map<Id, Region__c>((List<Region__c>) Database.query(regQuery));
		zipMap = new Map<Id, Zip_Postal_Code__c>((List<Zip_Postal_Code__c>) Database.query(zipQuery));
		stateMap = new Map<Id, Related_State_Province__c>((List<Related_State_Province__c>) Database.query(stateQuery));
		opps = new List<Opportunity>((List<Opportunity>) Database.query(oppQuery));

		if(!distMap.isEmpty()) {
			for(District__c dist : distMap.values()) {
				for(Integer i = 1; i <= 10; i++) {
					String userProcessedDT = 'User_' + i + '_Processed_D_T__c';
					String roleProcessedDT = 'Role_' + i + '_Processed_D_T__c';
					String userPriorValue = 'User_' + i + '_Prior_Value__c';
					String rolePriorValue = 'Role_' + i + '_Prior_Value__c';

					if(dist.get(userProcessedDT) == null) {
						dist.put(userProcessedDT, now);
					}

					if(dist.get(roleProcessedDT) == null) {
						dist.put(roleProcessedDT, now);
					}

					if(dist.get(userPriorValue) != null) {
						dist.put(userPriorValue, null);
					}

					if(dist.get(rolePriorValue) != null) {
						dist.put(rolePriorValue, null);
					}

					dist.Processed_D_T__c = now;
				}
			}

			Database.update(distMap.values(), false);
		}

		if(!regMap.isEmpty()) {
			for(Region__c reg : regMap.values()) {
				for(Integer i = 1; i <= 5; i++) {
					String userProcessedDT = 'User_' + i + '_Processed_D_T__c';
					String roleProcessedDT = 'Role_' + i + '_Processed_D_T__c';
					String userPriorValue = 'User_' + i + '_Prior_Value__c';
					String rolePriorValue = 'Role_' + i + '_Prior_Value__c';

					if(reg.get(userProcessedDT) == null) {
						reg.put(userProcessedDT, now);
					}

					if(reg.get(roleProcessedDT) == null) {
						reg.put(roleProcessedDT, now);
					}

					if(reg.get(userPriorValue) != null) {
						reg.put(userPriorValue, null);
					}

					if(reg.get(rolePriorValue) != null) {
						reg.put(rolePriorValue, null);
					}

					reg.Processed_D_T__c = now;
				}
			}

			Database.update(regMap.values(), false);
		}

		if(!zipMap.isEmpty()) {
			Database.executeBatch(new UpdateProcessedDT(), 200);
		}

		if(!stateMap.isEmpty()) {
			for(Related_State_Province__c rsp : stateMap.values()) {
				rsp.Processed_D_T__c = now;
			}

			Database.update(stateMap.values(), false);
		}
	}
}