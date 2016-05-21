trigger LastProjectComment on Project_Comment__c (before insert, before update) 
{
			/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('LastProjectComment')){
	system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
	system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
	system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
	return;
}
	/*for(Project_Comment__c P: Trigger.new)
	{
		commented out to bulkify
	}*/
	
	ProjComments.UpdateLastComment(Trigger.new);
}