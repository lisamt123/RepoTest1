trigger Cancelled_Trainings on Cancelled_Trainings__c (before insert, before update) {

    /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
    if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('Cancelled_Trainings')){
      system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
      system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
      system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
      return;
    }

    for(Cancelled_Trainings__c newct : trigger.new) {
    RecordType poaRecordType = StaticData.getInstance().POARecTypesMapByName.get('vAuto');
    if(trigger.isBefore && trigger.isInsert){                       
        system.debug('Finding  POA');
        List<POA__c> existingPOA = [Select Id from POA__c where Dealer__c =: newct.Account__c and  RecordTypeId =: poaRecordType.Id and status__c != 'Churned'];    
        if(existingPOA != null && existingPOA.size() > 0){
            system.debug('Setting POA');
            newct.POA__c = existingPOA[0].Id;
        }
    }
    else if(trigger.isBefore && trigger.isUpdate){
        system.debug('Finding  POA');
        Cancelled_Trainings__c  oldct = trigger.oldMap.get(newct.Id);
        if(oldct.Account__c != newct.Account__c){
            List<POA__c> existingPOA = [Select Id from POA__c where Dealer__c =: newct.Account__c and  RecordTypeId =: poaRecordType.Id and status__c != 'Churned'];    
            if(existingPOA != null && existingPOA.size() > 0){
                system.debug('Setting POA');
                newct.POA__c = existingPOA[0].Id;
            }
            else{
                system.debug('Removing POA');
                newct.POA__c = null;
            }
        }
        }   
    }
}