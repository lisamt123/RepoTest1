trigger RecapTrigger on Recap__c (before insert, before update) {
	
		            /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('RecapTrigger')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  
	for(Recap__c thisR : Trigger.new)
	{
		
		if (thisR.Ready_To_Score__c == true)
		{
			
				thisR.Total_Score_1__c = (thisR.Score_Count__c / thisR.Answered__c) * 100;
			
		}
		
	}

}