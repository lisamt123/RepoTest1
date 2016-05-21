global class emailService_changeRequestHandler implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
		
		system.debug('Bazinga... email thing start');
		
		system.debug('Bazinga... fromAddress ' + envelope.fromAddress);
		
		system.debug('Bazinga... CCs-' + email.ccAddresses);
		
		string privacyText = 'This message contains information that may be privileged, confidential or copyrighted and is the property of the author. It is only intended for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain, copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message.';
		string privacyText2 = 'This message contains information that may be privileged, confidential or copyrighted and is the property of  the author. It is only intended for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain, copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message.';
							  
		//////////////////////This message contains information that may be privileged, confidential or copyrighted and is the property of the author. It is only intended for the person to whom it is addressed. If you are not the intended recipient, you are not authorized to read, print, retain, copy, disseminate, distribute, or use this message or any part thereof. If you receive this message in error, please notify the sender immediately and delete all copies of this message.
		//string senderName = email.fromName.substring(email.fromName.indexOf(' ') + 1, email.fromName.indexOf('(')) + email.fromName.substring(0,email.fromName.indexOf(','));
		
		//string firstName = email.fromName.ind
		string senderName = email.fromName;
		
		system.debug('Bazinga... sendername..-' + senderName);
		
		User sender = new User();
		
		try {
			
			/*sender = [SELECT Id, Email, Name, IsActive, Outlook_Email__c, Outlook_Name__c
				      FROM User 
				      WHERE (Email = :envelope.fromAddress
				      OR Outlook_Email__c = :envelope.fromAddress)
				      AND (Name = :senderName
				      OR Outlook_Name__c = :senderName)
				      AND IsActive = true];*/
				      
			sender = [SELECT Id, Email, Name, IsActive, Outlook_Email__c
					  FROM User
					  WHERE (Email =: envelope.fromAddress
					  OR Outlook_Email__c =:envelope.fromAddress)
					  AND IsActive = true];
		}
		catch(Exception e) {
			
			sender = [SELECT Id, Email, Name, IsActive
					  FROM User
					  WHERE Name = 'API User'];
					  
		  	// send email saying it failed
		  	string message = 'Change Request Email Submit Error: Could not find a match for ' + envelope.fromAddress + ' and ' + senderName + ' in Salesforce. The Change Request has been created under the API User';

	        // Send an email to the Apex job's submitter notifying of job completion.
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'paul.duryee@vinsolutions.com'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Change Request Error');
	        mail.setPlainTextBody(message);
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
		
		system.debug('Bazinga... senderId ' + sender.Id);
		
		system.debug('Bazinga... htmlBody-' + email.htmlBody);
		system.debug('Bazinga... plainTextBody-' + email.plainTextBody);
		
		/////////pattern myPattern = pattern.compile('(a(b)?)+');
		
		string emailDetails;
		string emailDebug;
		
		if(email.htmlBody != null) {
			 
			emailDetails = email.htmlBody;
			emailDebug = email.htmlBody;
			//////NOT WORKING.......just removes first '<img'/////////////////////////////////////////////
			//emailDetails = handler_ChangeRequest.parseEmailSignature(email.htmlBody);
			/*
			try {
			
				if(emailDetails.contains('<p class="MsoNormal" style="text-autospace:none"><b><span style="font-size:14.0pt;color:#1F497D">')) {
					
					string remove = emailDetails.substring(emailDetails.indexOf('<p class="MsoNormal" style="text-autospace:none"><b><span style="font-size:14.0pt;color:#1F497D">'), emailDetails.length() - 1);
					emailDetails = emailDetails.remove(remove);
					emailDetails = emailDetails + '</body> </html>';
				}
			}
			catch(Exception e) {
				
				string message = 'Image Removal Failed: Error: ' + e;

		        // Send an email to the Apex job's submitter notifying of job completion.
		        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
		        mail.setToAddresses(toAddresses);
		        mail.setSubject('Image Removal Failed: Error: ' + e);
		        mail.setPlainTextBody(message);
		        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
			}
			*/
		}
		else {
			//html does not exist.. use plainttext if availl
			emailDetails = email.plainTextBody;
			emailDebug = email.plainTextBody;
		}
		
		
		//emailDetails = email.plainTextBody; 
		
		if(emailDetails.contains(privacyText)) {
			
			system.debug('Bazinga... privacyText exists');
			
			emailDetails = emailDetails.remove(privacyText);
			
			if(system.today().day() == 1) {
			
				string message = '+10 Achievement Points! Privacy Text 1 was Removed!';
	
		        // Send an email to the Apex job's submitter notifying of job completion.
		        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
		        mail.setToAddresses(toAddresses);
		        mail.setSubject('CR Accomplishment: Privacy Text 1 was Removed!');
		        mail.setPlainTextBody(message);
		        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
			}
		}
		
		if(emailDetails.contains(privacyText2)) {
			
			emailDetails = emailDetails.remove(privacyText2);
			
			if(system.today().day() == 1) {
			
				string message = ' +20 Achievement Points! Privacy Text 2 was Removed!';
	
		        // Send an email to the Apex job's submitter notifying of job completion.
		        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
		        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
		        mail.setToAddresses(toAddresses);
		        mail.setSubject('CR Accomplishment: Privacy Text 2 was Removed!');
		        mail.setPlainTextBody(message);
		        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
			}
		}
		
		
		
		
		Change_Request__c cr = new Change_Request__c();
		cr.OwnerId = sender.Id;
		cr.Subject__c = email.subject;
		cr.Origin__c = 'Email';
		cr.Change_Request_Status__c = 'New';
		
		if(emailDetails.length() > 32768) {
			
			cr.Request_Details__c = emailDetails.substring(0, 32760);
			cr.debug__c = emailDebug.substring(0, 32760);	
			
			string message = ' +30 Achievement Points! Email Details length substring!';
	
	        // Send an email to the Apex job's submitter notifying of job completion.
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('CR Accomplishment: Email Deatils length substring method!');
	        mail.setPlainTextBody(message);
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
		else {
			
			cr.Request_Details__c = emailDetails;	
			cr.debug__c = emailDebug;
		}
		
		 
		
		system.debug('Bazinga.... emailDetails-' + emailDetails);
		system.debug('Bazinga.... requestDetails-' + cr.Request_Details__c);
		
		
		
		//ON FIRE, Hot, Warm, Cool, Cold
		
		string emailBody = email.plainTextBody.toLowerCase();
		
		if(emailBody.contains('on fire')) {
			
			cr.Priority__c = '1-ON FIRE';
		}
		else if(emailBody.contains('hot')) {
			
			cr.Priority__c = '2-Hot';
		}
		else if(emailBody.contains('warm')) {
			
			cr.Priority__c = '3-Warm';
		}
		else if(emailBody.contains('cool')) {
			
			cr.Priority__c = '4-Cool';
		}
		else if(emailBody.contains('cold')) {
			
			cr.Priority__c = '5-Cold';
		}
		
		try {
			
			insert cr;
		}
		catch(Exception e) {
			
			string message = 'There has been an error and your change request has not been submitted. Please contact your salesforce adminstrator. Error: ' + e;

	        // Send an email to the Apex job's submitter notifying of job completion.
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Change Request Error');
	        mail.setPlainTextBody(message);
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
		}
		
		
		system.debug('Bazinga... email thing end');
		
		//check for cc's.. if they exist have them follow the new CR in chatter
		if(email.ccAddresses != null) {
			
			//handler_ChangeRequest.ccAutoFollow(cr.Id, email.ccAddresses, envelope.fromAddress);
		}
		
		
		try {
			
			if(email.binaryAttachments != null && email.binaryAttachments.size() > 0) {
	      		
	      		for(integer i = 0 ; i < email.binaryAttachments.size() ; i++) {
	        		
	        		Attachment attachment = new Attachment();
	        		
	       	 		attachment.ParentId = cr.Id;
	        		attachment.Name = email.binaryAttachments[i].filename;
	        		attachment.Body = email.binaryAttachments[i].body;
	        		
	        		insert attachment;
	      		}
	    	}
		}
		catch(Exception e) {
			
			string message = 'There has been an error and your change request has not been submitted. Please contact your salesforce adminstrator. Error: ' + e;

	        // Send an email to the Apex job's submitter notifying of job completion.
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
	        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Change Request Error: Attachment Error: ' + e);
	        mail.setPlainTextBody(message);
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
		}
		
		
		
		
		
		
        return result;
    }
}