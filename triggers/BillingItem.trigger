trigger BillingItem on Billing_Item__c (before update, before insert, after update, after delete, after insert) {
        

        /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
        if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('BillingItem')){
          system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
          system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
          system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
          return;
        }

        //after insert
        //if(trigger.isBefore && trigger.isInsert) {
            
            //system.debug('Bazinga... ')
            
            //handler_BillingItem.beforeInsert(trigger.new);
        //}
        
        //before update
        if(trigger.isBefore && trigger.isUpdate) {
            
            // do stuff
            
            handler_BillingItem.beforeUpdate(trigger.oldMap, trigger.new);
        }
        if(trigger.isAfter && (trigger.isUpdate||trigger.isInsert)) {
            
            // update Billing TYpe on account when billing item changes
            
            //handler_BillingItemUpdateBillingType.afterTriggers(trigger.new);
        }
        if(trigger.isAfter && (trigger.isDelete)) {
            
            // update Billing TYpe on account when billing item changes
            
            handler_BillingItemUpdateBillingType.afterTriggers(trigger.old);
            //handler_BillingItemUpdateBillingType.deleteTriggers(trigger.old);

        } 
        if(trigger.isBefore && trigger.isDelete){
            handler_BillingItemUpdateBillingType.deleteTriggers(trigger.new);
        }          
}