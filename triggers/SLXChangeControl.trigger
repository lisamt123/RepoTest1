trigger SLXChangeControl on SLX__Change_Control__c (after insert, after update) {
	
		/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('SLXChangeControl')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  


	//Call the "autofollow" method in the SLXChangeControl class and pass over the records being processed by this trigger
	SLXChangeControl.autofollow(trigger.new);
	
}