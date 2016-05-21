trigger OpportunityTrigger on Opportunity (
  before insert, before update, before delete, 
  after insert, after update, after delete, after undelete) {
  
            /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('OpportunityTrigger')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  
  new OpportunityTriggerHandler().run(); 

}