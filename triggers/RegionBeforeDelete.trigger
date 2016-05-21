trigger RegionBeforeDelete on Region__c (before delete) {
			            /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('RegionBeforeDelete')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  

	for(Region__c reg : trigger.old) {
		if(!reg.Allow_Deletion__c) {
			reg.addError('You cannot delete a Region without first checking the allow delete checkbox.');
		}
	}
}