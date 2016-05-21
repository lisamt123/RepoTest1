trigger BillingItemTrigger on Billing_Item__c (
after delete, after insert, after undelete, 
after update, before delete, before insert, before update) {


/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('BillingItemTrigger')){
	system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
	system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
	system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
	return;
}

new BillingItemTriggerHandler().run(); 
}