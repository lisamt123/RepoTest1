trigger ProjectBeforeInsertBeforeUpdate on SFDC_520_Quote__c (before insert, before update) {

/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('ProjectBeforeInsertBeforeUpdate')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}
    Map<Id, List<SFDC_520_Quote__c>> projMap = new Map<Id, List<SFDC_520_Quote__c>>();

    for(SFDC_520_Quote__c proj : trigger.new) {
        SFDC_520_Quote__c old = trigger.isUpdate ? trigger.oldMap.get(proj.Id) : new SFDC_520_Quote__c();

        if(proj.Status__c == 'Open' && (trigger.isInsert || proj.Vin_Performance_Manager__c != old.Vin_Performance_Manager__c || proj.WAM_Digital_Marketing_Advisor__c != old.WAM_Digital_Marketing_Advisor__c || proj.Status__c != old.Status__c || proj.Vin_Performance_Manager__c == null || proj.WAM_Digital_Marketing_Advisor__c == null)) {
            List<SFDC_520_Quote__c> projs = projMap.containsKey(proj.Account__c) ? projMap.get(proj.Account__c) : new List<SFDC_520_Quote__c>();
            projs.add(proj);
            projMap.put(proj.Account__c, projs);
        }
    }

    projMap.remove(null);

    if(!projMap.isEmpty()) {
        List<AccountTeamMember> atms = [SELECT Id, AccountId, UserId, TeamMemberRole FROM AccountTeamMember WHERE AccountId IN :projMap.keySet()];
        
        for(AccountTeamMember atm : atms) {
            for(SFDC_520_Quote__c proj : projMap.get(atm.AccountId)) {
                if(atm.TeamMemberRole.equalsIgnoreCase('Vin Performance Manager')) {
                    proj.Vin_Performance_Manager__c = atm.UserId;
                } else if(atm.TeamMemberRole.equalsIgnoreCase('Website Account Manager')) {
                    proj.WAM_Digital_Marketing_Advisor__c = atm.UserID;
                }
            }
        }
    }
}