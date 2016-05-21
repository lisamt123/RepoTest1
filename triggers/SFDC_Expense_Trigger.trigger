trigger SFDC_Expense_Trigger on SFDC_Expense_Header__c (before insert, before update) {
	
	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('SFDC_Expense_Trigger')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  

	//create a list to store all of the OwnerId's in for each new or updated Expense Report
	set<id> exRoleId = new set<id>();
	
	//For every Expense report being created or modified add the Ownerid to the Set so that there are no duplicates
	for (SFDC_Expense_Header__c Expnse : Trigger.new){
		
		exRoleId.add(Expnse.OwnerId);
		
		
	}
	
	Map<id, User> usr = new map<id,User>([Select UserRoleId, ManagerId, DelegatedApproverId From User where id in  :exRoleId]);
	
	//Select u.Name, u.Manager.Username, u.ManagerId, u.Id, u.DelegatedApproverId From User u

	//create a list that holds the approver Id, this could either be the managerID or the DelegatedApproverId
	//list<id> apprverId = new list<id>();
	
	//loop through the exRoleId list and add the manager or Approver ID to the apprvrId list, determined by UserRoleId neing (trainer)
	for (SFDC_Expense_Header__c Expnse : Trigger.new){
		
		if(usr.get(Expnse.OwnerId).UserRoleId == '00E70000000wHfNEAU'){       //old (usr.get(Expnse.id).UserRoleId == '00E70000000wHfNEAU')
				
		Expnse.Approver__c = usr.get(Expnse.OwnerId).DelegatedApproverId;	
			
		} else {
			
		Expnse.Approver__c = usr.get(Expnse.OwnerId).ManagerId;
		
		}
		
	}
	/*
	//create a list to store the Approver/Manager in
	list<User> ApprList = [select name from User where id in :apprverId];
	//loop through user list and create a new ordered, list or map with the manager name in it tied to the OwnerId
	
	//map to hold the Manager name, Key is OwnerId
	Map<id, String> combMap = new Map<id, String>();
	
	integer lstLmt = exRoleId.size();
	
	for(integer i=0; i <=lstLmt; i++){

		combMap.put(exRoleId[i],ApprList[i].Name );  
		
	}
	
	for (SFDC_Expense_Header__c Expnse : Trigger.new){
	
	
	Expnse.Approver__c = combMap.get(Expnse.OwnerId);
	
	}
	*/
	
}