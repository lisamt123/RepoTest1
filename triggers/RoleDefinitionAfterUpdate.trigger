trigger RoleDefinitionAfterUpdate on Role_Definition__c (after update) {

/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('RoleDefinitionAfterUpdate')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  

	Set<Id> rdIds = new Set<Id>();

	for(Role_Definition__c rd : trigger.new) {
		Role_Definition__c old = trigger.oldMap.get(rd.Id);

		if(rd.Account_Access__c != old.Account_Access__c || rd.Contact_Access__c != old.Contact_Access__c || rd.Case_Access__c != old.Case_Access__c || rd.Opportunity_Access__c != old.Opportunity_Access__c) {
			rdIds.add(rd.Id);
		}
	}

	rdIds.remove(null);

	if(!rdIds.isEmpty()) {
		List<Region__c> regs = [SELECT Id, Processed_D_T__c, Role_1__c, Role_2__c, Role_3__c, Role_4__c, Role_5__c FROM Region__c WHERE Role_1__c IN :rdIds OR Role_2__c IN :rdIds OR Role_3__c IN :rdIds OR Role_4__c IN :rdIds OR Role_5__c IN :rdIds];
		List<District__c> dists = [SELECT Id, Processed_D_T__c, Role_1__c, Role_2__c, Role_3__c, Role_4__c, Role_5__c, Role_6__c, Role_7__c, Role_8__c, Role_9__c, Role_10__c FROM District__c WHERE Role_1__c IN :rdIds OR Role_2__c IN :rdIds OR Role_3__c IN :rdIds OR Role_4__c IN :rdIds OR Role_5__c IN :rdIds OR Role_6__c IN :rdIds OR Role_7__c IN :rdIds OR Role_8__c IN :rdIds OR Role_9__c IN :rdIds OR Role_10__c IN :rdIds];

		if(!regs.isEmpty()) {
			for(Region__c reg : regs) {
				reg.Processed_D_T__c = null;

				for(Integer i = 1; i <= 5; i++) {
					String roleFieldName = '' + 'Role_' + i + '__c';

					if(rdIds.contains((Id) reg.get(roleFieldName))) {
						reg.put('Role_' + i + '_Processed_D_T__c', null);
					}
				}
			}

			update regs;
		}

		if(!dists.isEmpty()) {
			for(District__c dist : dists) {
				dist.Processed_D_T__c = null;

				for(Integer i = 1; i <= 10; i++) {
					String roleFieldName = '' + 'Role_' + i + '__c';

					if(rdIds.contains((Id) dist.get(roleFieldName))) {
						dist.put('Role_' + i + '_Processed_D_T__c', null);
					}
				}
			}

			update dists;
		}
	}
}