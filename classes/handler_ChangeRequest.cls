public without sharing class handler_ChangeRequest {
	
	public static void autofollow(List<Change_Request__c> changeControls) {
		// create boolean fields on User object: Autofollow_User__c, Autofollow_Follower__c
		EntitySubscription insertAssignedTo = new EntitySubscription();
		EntitySubscription insertOwner = new EntitySubscription();
		//EntitySubscription insertMark = new EntitySubscription();
		
		Set<Id> closedChangeControlIds = new Set<Id>();
		
		for(Change_Request__c c : changeControls) {
			//set the record creator to autofollow
			insertOwner.ParentId = c.Id;
			insertOwner.SubscriberId = c.OwnerId;
			//set the assigned admin to autofollow
			insertAssignedTo.ParentId = c.Id;
			insertAssignedTo.SubscriberId = c.Assigned_To__c;
			
			if(c.isClosed__c == 'True') {
				closedChangeControlIds.add(c.Id);
			}
		}
		
		try {
			insert insertAssignedTo;
		}
		catch(Exception e) {
			//do nothing
		}
		
		try {
			insert insertOwner;
		}
		catch(Exception e) {
			//do nothing
		}
		
		//auto-UNfollow
		List<EntitySubscription> deleteEntitySubscriptions = new List<EntitySubscription>();
		if(closedChangeControlIds.size() > 0) {
			deleteEntitySubscriptions = [SELECT Id, ParentId FROM EntitySubscription WHERE ParentId IN :closedChangeControlIds];
			delete deleteEntitySubscriptions;
		}
	}

	/* Removed this section of commented code, because the new change request process will not create a change request by emails, as of 1/27/2016
	public static void ccAutoFollow(string changeRequestId, List<string> ccAddresses, string fromAddress) {
		
		Map<string, User> emailUserMap = new Map<string, User>();
		
		system.debug('Bazinga... ccAddresses size ' + ccAddresses.size());
		
		for(User u : [SELECT Id, Email, Outlook_Email__c
					  FROM User
					  WHERE (Email IN :ccAddresses
					  OR Outlook_Email__c IN :ccAddresses)
					  AND IsActive = true]) {
			
			system.debug('Bazinga...loop ' + u.Email);	  	
			emailUserMap.put(u.Email, u);		  	
		}
		
		List<EntitySubscription> chatterFollows = new List<EntitySubscription>();
		
		for(string email : ccAddresses) {
			
			if(email != fromAddress) {
			
				//make lowercase to match
				system.debug('Bazinga... email-' + email);
				
				EntitySubscription newEntity = new EntitySubscription();
				
				User follower = emailUserMap.get(email.toLowerCase());
				
				newEntity.ParentId = changeRequestId;
				
				try {
					
					newEntity.SubscriberId = follower.Id;
				
					chatterFollows.add(newEntity);
				}
				catch(Exception e) {
					
					string message = 'There has been an error in the ccAutoFollow method. Some or all of the CCd users did not match up in Salesforce. Error: ' + e;
	
			        // Send an email to the Apex job's submitter notifying of job completion.
			        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
			        String[] toAddresses = new String[] {'paul.duryee@vinsolutions.com'};
			        mail.setToAddresses(toAddresses);
			        mail.setSubject('Change Request Error');
			        mail.setPlainTextBody(message);
			        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
				}
			}
		}
		
		try {
			
			if(chatterFollows.size() > 0) {
			
				insert chatterFollows;
			}
		}
		catch(Exception e) {
			
			string message = 'There has been an error in the ccAutoFollow method. Error: ' + e;

	        // Send an email to the Apex job's submitter notifying of job completion.
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        String[] toAddresses = new String[] {'william.shrewsbury@vinsolutions.com', 'mark.ross@vinsolutions.com'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Change Request Error');
	        mail.setPlainTextBody(message);
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
		}
	}
	
	public static string parseEmailSignature(string htmlBody) {
		
		boolean imgTag = true;
		
		string parsedHtmlBody = htmlBody;
		
		do {
			
			string removeImg = '';
			
			if(parsedHtmlBody.contains('<img')) {
				
				//removeImg = parsedHtmlBody.substring(parsedHtmlBody.indexOf('<img') - 4, parsedHtmlBody.indexOf('>'));
				
				//system.debug('Bazinga... removeImg:' + removeImg);
				
				//parsedHtmlBody = parsedHtmlBody.remove(removeImg);
				parsedHtmlBody = parsedHtmlBody.remove('<img');
				
				system.debug('Bazinga... parsedHtmlBody:' + parsedHtmlBody);
			}
			else {
				
				//all img tags have been romoved..
				//.. flip the boolean back to exit parsing loop
				imgTag = false;
			}
		}
		while(imgTag == true);
		
		return parsedHtmlBody;
	}
	*/

	//Adding BU for autopopulate in new CR process and page
	public static void autoPopulateDepartment(List<Change_Request__c> CRs) {
		
		Set<Id> ownerIds = new Set<Id>();
		
		for(Change_Request__c cr : CRs) {
			
			ownerIds.add(cr.OwnerId);
		}
		
		Map<Id, String> ownerDepartment = new Map<Id, String>();
		Map<Id, String> ownerBU = new Map<Id, String>();
		
		for(User u : [SELECT Id, Department, CompanyName
					  FROM User
					  WHERE Id IN :ownerIds]) {
			
			ownerDepartment.put(u.Id, u.Department);
			ownerBU.put(u.Id, u.CompanyName);		  	
		}
		
		for(Change_Request__c cr : CRs) {
			cr.BU__c = ownerBU.get(cr.OwnerId); 
			cr.Department__c = ownerDepartment.get(cr.OwnerId); 
		}
	}
	
	public static void checkIfOwnerChanged(List<Change_Request__c> newCRs, List<Change_Request__c> oldCRs) {
		
		List<Change_Request__c> changedCRs = new List<Change_Request__c>();
		
		for(Change_Request__c cr : newCRs) {
			
			for(Change_Request__c oldCR : oldCRs) {
				
				if(cr.Id == oldCR.Id && cr.OwnerId != oldCR.OwnerId) {
					
					changedCRs.add(cr);
				}
			}
		}
		
		if(changedCRs.size() > 0) {
			
			autoPopulateDepartment(changedCRs);	
		}
	}
	/*
	public static void autoPopulateOwner(List<Change_Request__c> changeRequests) {
		
		for(Change_Request__c cr : changeRequests) {
			
			if(cr.Request_Details__c != null) {
				
				if(cr.Request_Details__c.contains('Owner(')) {
					
					string remove = cr.Request_Details__c.substring(0, cr.Request_Details__c.indexOf('Owner(') + 6);
					remove = cr.Request_Details__c.remove(remove);
					system.debug('Bazinga... ' + remove);
					
					string ownerName = remove.substring(0, remove.indexOf(')'));
					
					system.debug('Bazinga... ownerName: ' + ownerName);
					
					for(User u : [SELECT Id, Email
								  FROM User 
								  WHERE Name = :ownerName]) {
					
						if(u.Email.contains('@vinsolutions.com')) {
							
							cr.OwnerId = u.Id;		
						}					  	
					}			 
				}
			}
		}
	}
	*/
	public static void autoPopulateAssignTo(List<Change_Request__c> changeRequests) {
    	for(Change_Request__c cr : changeRequests){
    		String ownerId = cr.OwnerId;
    		String company;
    		for(User u : [SELECT CompanyName, Team_Lead__c, ManagerId FROM User WHERE Id =: ownerId AND IsActive = True]){
    			company = u.CompanyName;
				cr.Owner_s_Team_Lead__c = u.Team_Lead__c;
    			cr.Owner_s_Manager__c = u.ManagerId;
			// Assigned_BAs__c is a custom setting
				Assigned_BAs__c instance = Assigned_BAs__c.getInstance(company);
				if(instance != null){
					for(User u2 : [SELECT Id FROM User WHERE Name =: instance.Name__c AND IsActive = True]){
		    			cr.Assigned_To__c = u2.Id;
					}
					for(User u3 : [SELECT Id FROM User WHERE Name =: instance.Curator__c AND IsActive = True]){
						cr.BU_Curator__c = u3.Id;
					}
				}
			}
    	}
	}

}