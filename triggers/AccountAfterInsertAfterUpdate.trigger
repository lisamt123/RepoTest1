trigger AccountAfterInsertAfterUpdate on Account (after insert, after update) {
	Boolean forceUpdate = false;
	Set<Id> acctIdsUpdateTM = new Set<Id>();
	Set<Id> acctZipStateChange = new Set<Id>();
	Map<Id, Set<Id>> acctAddMap = new Map<Id, Set<Id>>();
	Map<Id, Set<Id>> acctDelMap = new Map<Id, Set<Id>>();
	Map<Id, List<AccountTMHelper>> distTMMap = new Map<Id, List<AccountTMHelper>>();
	Map<Id, List<AccountTMHelper>> regTMMap = new Map<Id, List<AccountTMHelper>>();

	if(Advanced_Team_Management__c.getOrgDefaults().Enable_Account_Team_Triggers__c) {
		for(Account acct : trigger.new) {
			Set<Id> addIds = new Set<Id>();
			Set<Id> delIds = new Set<Id>();
			Account old = trigger.isUpdate ? trigger.oldMap.get(acct.Id) : new Account();

			if(acct.ShippingPostalCode != old.ShippingPostalCode || acct.ShippingState != old.ShippingState || acct.VAT_District__c != old.VAT_District__c || acct.VIN_District__c != old.VIN_District__c || acct.HAY_District__c != old.HAY_District__c || acct.VAT_Region__c != old.VAT_Region__c || acct.VIN_Region__c != old.VIN_Region__c || acct.HAY_Region__c != old.HAY_Region__c || acct.Update_Team_Members__c) {
				distTMMap.put(acct.VAT_District__c, new List<AccountTMHelper>());
				distTMMap.put(old.VAT_District__c, new List<AccountTMHelper>());
				addIds.add(acct.VAT_District__c);
				delIds.add(old.VAT_District__c);

				distTMMap.put(acct.VIN_District__c, new List<AccountTMHelper>());
				distTMMap.put(old.VIN_District__c, new List<AccountTMHelper>());
				addIds.add(acct.VIN_District__c);
				delIds.add(old.VIN_District__c);

				distTMMap.put(acct.HAY_District__c, new List<AccountTMHelper>());
				distTMMap.put(old.HAY_District__c, new List<AccountTMHelper>());
				addIds.add(acct.HAY_District__c);
				delIds.add(old.HAY_District__c);

				regTMMap.put(acct.VAT_Region__c, new List<AccountTMHelper>());
				regTMMap.put(old.VAT_Region__c, new List<AccountTMHelper>());
				addIds.add(acct.VAT_Region__c);
				delIds.add(old.VAT_Region__c);

				regTMMap.put(acct.VIN_Region__c, new List<AccountTMHelper>());
				regTMMap.put(old.VIN_Region__c, new List<AccountTMHelper>());
				addIds.add(acct.VIN_Region__c);
				delIds.add(old.VIN_Region__c);

				regTMMap.put(acct.HAY_Region__c, new List<AccountTMHelper>());
				regTMMap.put(old.HAY_Region__c, new List<AccountTMHelper>());
				addIds.add(acct.HAY_Region__c);
				delIds.add(old.HAY_Region__c);

				addIds.remove(null);
				delIds.remove(null);
				acctAddMap.put(acct.Id, addIds);
				acctDelMap.put(acct.Id, delIds);

				if(acct.ShippingPostalCode != old.ShippingPostalCode || acct.ShippingState != old.ShippingState || acct.VAT_District__c != old.VAT_District__c || acct.VIN_District__c != old.VIN_District__c || acct.HAY_District__c != old.HAY_District__c || acct.VAT_Region__c != old.VAT_Region__c || acct.VIN_Region__c != old.VIN_Region__c || acct.HAY_Region__c != old.HAY_Region__c) {
					acctZipStateChange.add(acct.Id);
				}
				if(acct.Update_Team_Members__c) {
					acctIdsUpdateTM.add(acct.Id);
				}
			}
		}

		distTMMap.remove(null);
		regTMMap.remove(null);

		AccountTeamService.syncAccountTeams(acctIdsUpdateTM, acctAddMap, acctDelMap, distTMMap, regTMMap, trigger.newMap, acctZipStateChange, trigger.isInsert);
	}
}