trigger User on User (after update, before insert, before update) {
	
			/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('User')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  
	
	if(trigger.isAfter && trigger.isUpdate) {
		
		//add edit restrictions based on profile
		//..
		handler_userTrigger.lockDownUserFields(trigger.old, trigger.new);
		handler_updateUsersRelatedProjects.updateRelatedProjects(trigger.new, trigger.old);
		//
	}
	
	if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
		
		UserUpdate.addOffices(Trigger.new, Trigger.old);
	}
	
}