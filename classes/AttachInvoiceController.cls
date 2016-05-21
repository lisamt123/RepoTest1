public with sharing class AttachInvoiceController {
	ApexPages.Standardcontroller controller;
	Id id;
	public Opportunity thisOpp = new Opportunity();
	public AttachInvoiceController (ApexPages.Standardcontroller c)
	{
		id = Apexpages.currentPage().getParameters().get('id');
		controller = c;
		thisOpp = [select id, name, accountId, OwnerId, Opportunity_ID__c, Number_of_Installments__c, TNOPPST__Sales_Tax__c from Opportunity where id =: id];
	} 
	
	public Pagereference attachInvoice()
	{
		Account thisAccount = [select id, name from Account where id =: thisOpp.AccountId limit 1];
		User thisOppOwner = [select id, name, email from User where id =: thisOpp.OwnerId limit 1];
		Folder invoiceFolder = [select id, name from Folder where name =: 'Invoices' limit 1];
		
		OpportunityClass.UpdateInvoiceInformation(thisOpp);
		
		Pagereference pdfPage = null;
		integer numInstallments = integer.valueOf(thisOpp.Number_of_Installments__c); 
		
		system.debug(numInstallments);
		if (numInstallments == 1) 
		{
			pdfPage = Page.Opportunity_Invoice;
		}
		else
		{
			pdfPage = Page.Opportunity_Invoice_Multi_Installments;   
		}  
		
		
		
		pdfPage.setRedirect(true);
		
		pdfPage.getParameters().put('id',id);
	
		Blob thisBody = null;
		
		try
		{
			thisBody = pdfPage.getContent();	
		}
		catch (Exception ex)
		{
			system.debug(ex);
		}
		
		
		

		Document doc = new Document(FolderId = invoiceFolder.Id, name= thisOppOwner.name + ' - ' + thisOpp.Opportunity_ID__c + ' - '+ thisAccount.name + system.now() + '.pdf', body = thisBody);
		insert doc;
		
		Attachment A = new Attachment(ParentId = Id, name= 'Invoice'+ '-' + thisOppOwner.name + ' - ' + thisOpp.Opportunity_ID__c + ' - '+ thisAccount.name + system.now() + '.pdf', body = thisBody);
		
		try {
			insert A;
		}
		catch(Exception e) {
			
		} 
		
		String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
		Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
		String[] toAddresses = new String[]{thisOppOwner.Email};
		String orgURL = Apexpages.currentPage().getHeaders().get('Host');
		mail.setToAddresses(toAddresses);
		mail.setUseSignature(false);
		mail.setSubject('Invoice Ready to be sent for ' + thisAccount.Name);
		//mail.setHtmlBody('<p>The invoice for account' + thisAccount.Name + ' is ready to be sent</p><p>The invoice can be accessed at: <a href="https://cs3.salesforce.com/'  + doc.id + '">HERE</a>');
		mail.setHtmlBody('<p>The invoice for account' + thisAccount.Name + ' is ready to be sent</p><p>The invoice can be accessed at: <a href="' + fullURL  + doc.id + '">HERE</a>');
		Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });	 
		
		return pdfPage;
	}
	
	public Opportunity updateInvoiceStuff()
	{
		OpportunityClass.UpdateInvoiceInformation(thisOpp); 
		return null;
	} 
	
}