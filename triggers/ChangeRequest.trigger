trigger ChangeRequest on Change_Request__c (after insert, after update, before insert, before update) {
	
	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
    if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('ChangeRequest')){
      system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
      system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
      system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
      return;
    }


	if(trigger.isAfter) {
		
		//..
		handler_ChangeRequest.autofollow(trigger.new);
	}
	
	if(trigger.isBefore) {
		
		if(trigger.isInsert) {
			
			
			//..
			//handler_ChangeRequest.autoPopulateOwner(trigger.new);
			
			//..
			handler_ChangeRequest.autoPopulateAssignTo(trigger.new);
			
			//..
			handler_ChangeRequest.autoPopulateDepartment(trigger.new);
			
			
		}
		
		if(trigger.isUpdate) {
			
			//..
			handler_ChangeRequest.checkIfOwnerChanged(trigger.new, trigger.old);
			
			//..
			//handler_ChangeRequest.autoPopulateOwner(trigger.new);
		}
	}
}