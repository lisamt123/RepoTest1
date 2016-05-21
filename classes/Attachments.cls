//This is called from AfterInsertAttachment Trigger

public with sharing class Attachments 
{
	public static void HasAttachments(Attachment attch)
	{		
		Case cse = [select id, has_Attachments__c from Case where id =: attch.ParentId];
		cse.has_Attachments__c = true;
		update cse;
				
	}
}