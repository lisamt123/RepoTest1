/*
This trigger runs after an insert of a new attachment

*/

trigger AfterInsertAttachment on Attachment (after insert) 
{

	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
    if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('AfterInsertAttachment')){
      system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
      system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
      system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
      return;
    }
	for(Attachment attch: Trigger.new)
	{
		string parent = attch.ParentId;
		
		//If the Parent to the Attachment has an did with 500 in it find the case for this attachment and set the "has_attachment__c to True
		if(parent.substring(0,3)=='500')
		{
			Attachments.HasAttachments(attch);
		}
	}
}