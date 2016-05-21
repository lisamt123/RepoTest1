trigger DistrictBeforeDelete on District__c (before delete) {

		/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('DistrictBeforeDelete')){
	system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
	system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
	system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
	return;
}


	for(District__c dist : trigger.old) {
		if(!dist.Allow_Deletion__c) {
			dist.addError('You cannot delete a District without first checking the allow delete checkbox.');
		}
	}
}