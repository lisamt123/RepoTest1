public with sharing class ProjectClass2 
{
	public static void UpdateOwnerName(SFDC_520_Quote__c Proj)
	{
		for(User pOwner: [select id, LastName, FirstName, email, Team_Name__c, Squad_Name__c from User where Id =: Proj.OwnerId limit 1])
	
		{
			Proj.Project_Owner_Name__c = pOwner.FirstName+' '+pOwner.LastName;
			Proj.Project_Owner_Email__c = pOwner.Email;
			Proj.Team_Name__c = pOwner.Team_Name__c;
			Proj.Squad_Name__c = pOwner.Squad_Name__c;
			
		}
		
	}	
}