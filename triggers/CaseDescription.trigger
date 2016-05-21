trigger CaseDescription on Case_Runner__c (before insert, before update) 
{
	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
    if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('CaseDescription')){
      system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
      system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
      system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
      return;
    }


	for(Case_Runner__c CR: Trigger.new)UpdateCaseStage.updateCaseDescriptionOnRunner(CR);
}