trigger BusinessUnitBeforeDelete on Business_Unit__c (before delete) {

	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
    if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('BusinessUnitBeforeDelete')){
      system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
      system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
      system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
      return;
    }

	for(Business_Unit__c bu : trigger.old) {
		if(!bu.Allow_Deletion__c) {
			bu.addError('You cannot delete a Business Unit without first checking the allow delete checkbox.');
		}
	}
}