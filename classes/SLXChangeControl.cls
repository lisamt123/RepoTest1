public with sharing class SLXChangeControl {
	
	public static void autofollow(List<SLX__Change_Control__c> changeControls) {
		
		//...
		//...
		
		//User mark = [SELECT Id FROM User WHERE Name = 'Mark Ross'];
		
		
		//List<EntitySubscription> insertEntitySubscriptions = new List<EntitySubscription>();
		
		EntitySubscription insertRequestor = new EntitySubscription();
		EntitySubscription insertOwner = new EntitySubscription();
		//EntitySubscription insertMark = new EntitySubscription();
		
		
		Set<Id> closedChangeControlIds = new Set<Id>();
		
		List<User> usersToFollow = [SELECT Id FROM User WHERE Name = 'Dean Lukowski' OR Name = 'Angel Bourret'];
		
		Map<Id, User> userIdsToFollow = new Map<Id, User>(usersToFollow);
		
		//Set<Id> userIdsToFollow = new Set<Id>();
			
		//for(User u : usersToFollow) {
				
			//userIdsToFollow.add(u.Id);
		//}
		
		for(SLX__Change_Control__c c : changeControls) {
			
			//set the record creator to autofollow
			
			
			//insertEntitySubscriptions.add(new EntitySubscription(ParentId = c.Id, SubscriberId = c.SLX__Requestor__c));
			insertRequestor.ParentId = c.Id;
			insertRequestor.SubscriberId = c.SLX__Requestor__c;
			
			//insertEntitySubscriptions.add(new EntitySubscription(ParentId = c.Id, SubscriberId = c.OwnerId));
			insertOwner.ParentId = c.Id;
			insertOwner.SubscriberId = c.OwnerId;
			
			
			//if(userIdsToFollow.keyset().contains(c.OwnerId)) {
				
				//insertMark.ParentId = c.Id;
				//insertMark.SubscriberId = mark.Id;
			//}
			
			//if(userIdsToFollow.contains(c.OwnerId)) {
				
				//if(c.isClosed__c == 'False') {
			
					//insertEntitySubscriptions.add(new EntitySubscription(ParentId = c.Id, SubscriberId = mark.Id));
				//}
				//else if(c.isClosed__c == 'True') {
					
					//closedChangeControlIds.add(c.Id);
				//}
			
			//}
			
			if(c.isClosed__c == 'True') {
				
				closedChangeControlIds.add(c.Id);
			}
			
		}
		
		try {
			
			//insert insertEntitySubscriptions;
			insert insertRequestor;
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
		
		//try {
			
			//insert insertMark;
		//}
		//catch(Exception e) {
			
			//do nothing
		//}
		
		
		//auto-UNfollow
		
		List<EntitySubscription> deleteEntitySubscriptions = new List<EntitySubscription>();
		
		if(closedChangeControlIds.size() > 0) {
			
			//try {
			
				deleteEntitySubscriptions = [SELECT Id, ParentId FROM EntitySubscription WHERE ParentId IN :closedChangeControlIds];
			//}
			//catch(Exception e) {
				
				//none exist
			//}
			
			//try {
				
				delete deleteEntitySubscriptions;
			//}
			//catch(Exception e) {
				
				//..
			//}
		}
		
	}
	
}