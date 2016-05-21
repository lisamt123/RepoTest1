trigger ProjectAfterUndelete on SFDC_520_Quote__c (after undelete) {

/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('ProjectAfterUndelete')){
	system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
	system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
	system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
	return;
}

    List<SFDC_520_Quote__c> projs = new List<SFDC_520_Quote__c>();

    for(SFDC_520_Quote__c proj : [SELECT Id, Vin_Performance_Manager__c, WAM_Digital_Marketing_Advisor__c FROM SFDC_520_Quote__c WHERE Id IN :trigger.newMap.keySet() AND Status__c = 'Open']) {
        proj.Vin_Performance_Manager__c = null;
        proj.WAM_Digital_Marketing_Advisor__c = null;
        projs.add(proj);
    }

    update projs;
}