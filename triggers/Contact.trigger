trigger Contact on Contact (before insert, before update) {

	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
    if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('Contact')){
      system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
      system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
      system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
      return;
    }


	User u = [Select Id, Alias, Business_Unit__c  from User where Id=: UserInfo.getUserId()];
	for (Contact c : Trigger.new) {
		//If it current user is from vAuto BU
		//update the Account
		if(u.Business_Unit__c == 'VAT' && u.Alias != 'msync'){
			c.vAuto_Account__c = c.AccountId;
		}
	}

}