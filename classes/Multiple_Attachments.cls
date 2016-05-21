/*
 * Class/Method Name: Multiple_Attachments
 * Author/Date: Dean Lukowski September 23, 2014
 * Purpose: Create a dynamic page to allow users to add multiple attachments to a record.
 */

public with sharing class Multiple_Attachments {
	// the parent object id
	public Id sobjId{get;set;}
	// list of existing attachments - populated on demand
	public List<Attachment> attachments;
	// list of new attachments to add
	public List<Attachment> newAttachments{get;set;}
	// the number of new attachments to add to the list when the user clicks 'Add More'
	public static final Integer NUM_ATTACHMENTS_TO_ADD=5;
	public boolean existingAttachments{get;set;}

	// constructor
	public Multiple_Attachments() {
		// instantiate the list with a single attachment
		newAttachments = new List<Attachment>{new Attachment()};
		sobjId = ApexPages.currentPage().getParameters().get('sobjId');
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Click the Add More button first until you have more than enough file uploads than the number of Attachments you want to upload. This will prevent the Attachments from disappearing when you click the Add More button.'));
	}

	// retrieve the existing attachments
    public List<Attachment> getAttachments()
    {
    	// only execute the SOQL if the list hasn't been initialised
    	if (null==attachments)
    	{
    		attachments = [SELECT Id, ParentId, Name, Description
    						FROM Attachment
    						WHERE parentId = :sobjId];
    	}

    	existingAttachments = (attachments.size() > 0) ? true : false;
    	
    	return attachments;
    }

	// Add more attachments action method
	public void addMore()
	{
		// append NUM_ATTACHMENTS_TO_ADD to the new attachments list
		for (Integer idx=0; idx<NUM_ATTACHMENTS_TO_ADD; idx++)
		{
			newAttachments.add(new Attachment());
		}
	}    
	
	// Save action method
	public void save()
	{
		List<Attachment> toInsert=new List<Attachment>();
		for (Attachment newAtt : newAttachments)
		{
			if (newAtt.Body!=null)
			{
				newAtt.parentId=sobjId;
				toInsert.add(newAtt);
			}
		}
		insert toInsert;
		newAttachments.clear();
		newAttachments.add(new Attachment());
		
		// null the list of existing attachments - this will be rebuilt when the page is refreshed
		attachments=null;
		getAttachments();
	}
	
	// Action method when the user is done
	public PageReference done()
	{
		save();
		// send the user to the detail page for the sobject
		return new PageReference('/' + sobjId);
	}
}