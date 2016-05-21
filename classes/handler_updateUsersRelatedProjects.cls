public with sharing class handler_updateUsersRelatedProjects {
	
	public static void updateRelatedProjects(List<User> oldList, List<User> newList) {
		
		Set<Id> userIds = new Set<Id>();
		
		for(User oldUser : oldList) {
			for(User newUser : newList) {
				if(oldUser.Id == newUser.Id) {
					if(oldUser.Team_Name__c != newUser.Team_Name__c || oldUser.Squad_Name__c != newUser.Squad_Name__c) {
						userIds.add(newUser.Id);
					}
				}
			}
		}
		
		List<SFDC_520_Quote__c> relatedProjects = new List<SFDC_520_Quote__c>();
		
		try {
		
			relatedProjects = [SELECT Id
							   FROM SFDC_520_Quote__c
							   WHERE OwnerId IN :userIds
							   AND Approval_Stage__c != 'Work Complete'
							   AND Approval_Stage__c != 'Cancelled'
                               AND Approval_Stage__c != 'GO LIVE'
							   AND RecordType.Name != 'FROZEN'];
		}
		catch(Exception e) {
			//do nothing
		}
		
		try {
			//update relatedProjects;
		}
		catch(Exception e) {
			//do nothing
		}
		
	}

}