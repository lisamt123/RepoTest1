public  class TaskHandler {
  // context-specific methods to implement  
  public void beforeInsert(Task t){}
  public  void beforeUpdate(Task newT, Task oldT){}
  public  void beforeDelete(Task t){}
  public  void afterInsert(Task t){}
  public  void afterUpdate(Task newT, Task oldT){
  	System.debug('New Task Subject:'+newT.Subject);
  	System.debug('New Task Status:'+newT.Status);
  	System.debug('Old Task Subject:'+oldT.Subject);
  	System.debug('Old Task Status:'+oldT.Status);
	if (newT.Subject != null)
	{
		//only if it is a project task
		
	
		
		if(newT.WhatId != null && Schema.SFDC_520_Quote__c.SObjectType == newT.WhatId.getSobjectType()){	
		if(newT.subject.StartsWith('* Integration C -')&&( newT.Status=='Completed' && oldT.Status !='Completed'))
		{			
			
			String subject = newT.subject.replace('* Integration C -','* Conquest Franchise Setup -');
		
			//get assignee user from custom setttings			
			String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Franchise_Setup_Task_Assignee__c;
			List<User> users = [Select Id from User where email =:assigneeEmail];	
			Id assigneeUserId = newT.OwnerId;
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}	
			
			//get the assigned user from the task '* Advance Setup Call  – ' 
			String serSubject = newT.subject.replace('* Integration C -','* Advance Setup Call  –');
			
			List<Task> advSetupTasks = [Select Id,ownerId from Task where subject =:serSubject and whatId =: newT.whatId];
			if(advSetupTasks == null || advSetupTasks.size() == 0){
				//If there is no Advance Setup Call created use what ever the setting is 
				//use what was got from settings
				system.debug('No Advance Call task found with subject:'+serSubject);
			}
			else{
				//use from Advance Setup Call ownerId
				assigneeUserId = advSetupTasks[0].ownerId;
			}
			
			
			
			CreateTask(subject, 0,assigneeUserId,newT.whatId,newT.WhoId,'Not Started');
		}
		else if(newT.subject.StartsWith('* Conquest Franchise Setup -')&&( newT.Status=='Completed' && oldT.Status !='Completed'))
		{	
			
			String subject = newT.subject.replace('* Conquest Franchise Setup -','* Verification C -');
			//get assignee user from custom setttings			
			String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Verification_C_Task_Assignee__c;
			List<User> users = [Select Id from User where email =:assigneeEmail];	
			Id assigneeUserId = newT.OwnerId;
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}			
			CreateTask(subject, 0,assigneeUserId,newT.whatId,newT.WhoId,'Not Started');
			
			
			subject = newT.subject.replace('* Conquest Franchise Setup -','* Training 1 Conquest –');
			assigneeUserId = newT.OwnerId;
			//get assignee user from custom setttings			
			/*assigneeEmail = vAuto__c.getOrgDefaults().Training_1_Conquest_Task_Assignee__c;
			users = [Select Id from User where email =:assigneeEmail];	
			
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}*/			
			CreateTask(subject, 0,assigneeUserId,newT.whatId,newT.WhoId,'Not Started');
		}
		
			//CR-00012029; Looks like migrated seems to have non-printable characters that is not matching 
			//so matching on '* Training 1 Conquest' instaed of : '* Training 1 Conquest –'
		else if (newT.subject.StartsWith('* Training 1 Conquest') && ( newT.Status=='Completed' && oldT.Status !='Completed'))
		{	

		   System.debug('Task subject starts with:* Training 1 Conquest; and it is Completed'); 
			
		   //Get the project
		   SFDC_520_Quote__c proj = [Select Id, Status__c,Project_Type__c,Approval_Stage__c
		   ,Related_POA__r.OwnerId, Related_POA__c
		   from SFDC_520_Quote__c where id =: newT.WhatId]; 

		   //create Training2 Task if proj.Project_Type__c == 'Conquest Stand-Alone'
		   if(proj.Project_Type__c == 'Conquest Stand-Alone'){
		   	  String trainingTask2Subject = newT.subject.replace('* Training 1 Conquest','* Training 2 Conquest');
		   		CreateTask(trainingTask2Subject, 0,newT.OwnerId,newT.whatId,newT.WhoId,'Not Started');
		   }

			String subject = newT.subject.replace('* Training 1 Conquest','* Conquest Monthly Billing Task (MM)');
			//get assignee user from custom setttings			
			String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_MM_Assignee__c;
			List<User> users = [Select Id from User where email =:assigneeEmail and IsActive = true];	
			Id assigneeUserId = newT.OwnerId;
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}			
			CreateTask(subject, 0,assigneeUserId,newT.whatId,newT.WhoId,'Not Started');
			
			
			subject = newT.subject.replace('* Training 1 Conquest','* Conquest Monthly Billing Task (JT)');
			//get assignee user from custom setttings			
			assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_JT_Assingee__c;
			users = [Select Id from User where email =:assigneeEmail];	
			assigneeUserId = newT.OwnerId;
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}			
			CreateTask(subject, 0,assigneeUserId,newT.whatId,newT.WhoId,'Not Started');
			
			
			subject = newT.subject.replace('* Training 1 Conquest','* Conquest Monthly Billing Task (EL)');
			//get assignee user from custom setttings			
			assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_EL_Assignee__c;
			users = [Select Id from User where email =:assigneeEmail];	
			assigneeUserId = newT.OwnerId;
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}			
			CreateTask(subject, 0,assigneeUserId,newT.whatId,newT.WhoId,'Not Started');
			
			
			subject = newT.subject.replace('* Training 1 Conquest –','* 1st Conquest PM Review Call -');
			//get assignee user from project POA
			SFDC_520_Quote__c project = [Select Id, Related_POA__c,Related_POA__r.OwnerId from SFDC_520_Quote__c where Id =:newT.WhatId];			
			CreateTask(subject, 0,project.Related_POA__r.OwnerId,project.Related_POA__c,newT.WhoId,'Not Started');
			
		}
		else{
			system.debug('Project Task did not match any criteria to handle');			
		}
		}
		
		//POA Task
		if(newT.WhatId != null &&  Schema.POA__c.SObjectType == newT.WhatId.getSobjectType()){	
		if(newT.subject.StartsWith('* 1st Conquest PM Review Call -')&&( newT.Status=='Completed' && oldT.Status !='Completed'))
		{	
			String subject = newT.subject.replace('* 1st Conquest PM Review Call -','* 2nd Conquest PM Review Call -');
			CreateTask(subject, 0,newT.OwnerId,newT.WhatId,newT.WhoId,'Not Started');
		}		
		else if(newT.subject.StartsWith('* 2nd Conquest PM Review Call -')&&( newT.Status=='Completed' && oldT.Status !='Completed'))
		{	
			String subject = newT.subject.replace('* 2nd Conquest PM Review Call -','* 3rd Conquest PM Review Call -');
			CreateTask(subject, 0,newT.OwnerId,newT.WhatId,newT.WhoId,'Not Started');
		}
		else if(newT.subject.StartsWith('* 3rd Conquest PM Review Call -')&&( newT.Status=='Completed' && oldT.Status !='Completed'))
		{	
			String subject = newT.subject.replace('* 3rd Conquest PM Review Call -','* 4th Conquest PM Review Call -');
			CreateTask(subject, 0,newT.OwnerId,newT.WhatId,newT.WhoId,'Not Started');
		}
		}		
	}				
  }
  public  void afterDelete(Task t){}
  public  void afterUndelete(Task t){}
  
  
     public Static void CreateTask(String subject, Integer dueInDays, Id ownerId, Id whatId, Id whoId, String status){
   	system.debug('Creating Task: subject: '+subject + ' ownerId: '+ownerId +'whatId: '+whatId +' whoId: '+whoId + 'status: '+status);
   	      //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:ownerId
      and whatId=:whatId
      and Subject =: subject
      and Status =: status
      and WhoId =: whoId];
      
      if(tasks == null || tasks.size() == 0){
		Task task = new Task();
		task.Subject =  subject;
		task.ActivityDate = System.today().addDays(dueInDays);
		task.OwnerId = ownerId;
		task.WhatId = whatId;
		task.WhoId = whoId;
		insert task;		
      }
     }
  
}