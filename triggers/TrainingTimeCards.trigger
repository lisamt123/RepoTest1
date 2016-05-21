trigger TrainingTimeCards on SFDC_Service_Timecard__c (after insert, after update, before insert, 
before update) {

		/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('TrainingTimeCards')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  
	
	if (trigger.isBefore && (trigger.isUpdate || trigger.isInsert))
	{
		for (SFDC_Service_Timecard__c thisTimeCard: trigger.new)
		{
			if (thisTimeCard.Contact__c != null)
			{ 
				Contact thisContact = [select Id, AccountId from Contact where Id =: thisTimeCard.Contact__c];			
				thisTimeCard.Account__c = thisContact.AccountId;
			}
		}		
	}
	else if(trigger.isAfter && (trigger.isUpdate))
	{
		
		List<Id> thisCont = new List<Id>();
		
		
		//collect all the contact id's in the trigger into a list
		for (SFDC_Service_Timecard__c thisTimeCard: trigger.new)
		{	
			if (thisTimeCard.Contact__c != null)
			{ 
				
				thisCont.add(thisTimeCard.Contact__c);
						
			}
		
		}
		system.Debug('This trigger contains these Contact IDs: ' + thisCont);
		CreateCertificationClass.CreateCertification(thisCont);
					
	} 
		
}