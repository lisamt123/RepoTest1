trigger OpportunityBeforeInsertBeforeUpdate on Opportunity (before insert, before update) {
	Map<Id, Opportunity> oppMap = new Map<Id, Opportunity>();

            /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('OpportunityBeforeInsertBeforeUpdate')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}

	for(Opportunity opp : trigger.new) {
		Opportunity old = trigger.isUpdate ? trigger.oldMap.get(opp.Id) : new Opportunity();

		if(!opp.IsClosed && opp.Business_Unit__c.equalsIgnoreCase('VinSolutions') && (opp.RecordTypeId != old.RecordTypeId || opp.Regional_Manager_2__c != old.Regional_Manager_2__c || opp.AccountId != old.AccountId || opp.Business_Unit__c != old.Business_Unit__c || opp.Update_Regional_Manager__c)) {
			//opp.Regional_Manager_2__c = null;
			oppMap.put(opp.AccountId, opp);
		}

		opp.Update_Regional_Manager__c = false;
	}

	oppMap.remove(null);

	if(!oppMap.isEmpty()) {
		Map<Id, Id> acctVinDistMap = new Map<Id, Id>();
		Set<Id> vinDistIds = new Set<Id>();

		for(Account acct : [SELECT Id, Vin_District__c, Vin_District__r.Unknown_District__c FROM Account WHERE Id IN :oppMap.keySet() AND Vin_District__r.Unknown_District__c = false]) {
			acctVinDistMap.put(acct.Id, acct.Vin_District__c);
			vinDistIds.add(acct.Vin_District__c);
		}

		acctVinDistMap.remove(null);
		vinDistIds.remove(null);

		String query = DistrictRegionSchemaUtility.generateQuery('District__c', 'Id', 'vinDistIds');

		if(!vinDistIds.isEmpty()) {
			Set<Id> regManagerRoleIds = new Set<Id>();
			Map<Id, Id> regManagerMap = new Map<Id, Id>();

			for(Role_Definition__c rd : [SELECT Id FROM Role_Definition__c WHERE Opp_Regional_Manager__c = true]) {
				regManagerRoleIds.add(rd.Id);
			}

			for(District__c dist : (List<District__c>) Database.query(query)) {
				for(Integer i = 1; i <= 10; i++) {
					String userFieldName = '' + 'User_' + i + '__c';
					String roleFieldName = '' + 'Role_' + i + '__c';
					
					if(dist.get(roleFieldName) != null && regManagerRoleIds.contains((Id) dist.get(roleFieldName))) {
						regManagerMap.put(dist.Id, (Id) dist.get(userFieldName));
					}
				}
			}

			for(Id acctId : oppMap.keySet()) {
				Opportunity opp = oppMap.get(acctId);

				if(regManagerMap.containsKey(acctVinDistMap.get(acctId))) {
					//opp.Regional_Manager_2__c = regManagerMap.get(acctVinDistMap.get(acctId));
				}
			}
		}
	}
}