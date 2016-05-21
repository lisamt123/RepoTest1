trigger UpdatePiecefromRunner on Project_Runner__c (after insert, after update) 
{
				/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('UpdatePiecefromRunner')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  


	//need code to check time and not create a new runner if there is one there with the same date/time value
	for(Project_Runner__c PR: Trigger.new)UpdatePieceStage.updatePieceStage(PR);
}