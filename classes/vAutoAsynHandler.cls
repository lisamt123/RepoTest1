global class vAutoAsynHandler{
@future
public static void handleProjectCreation(Id projectId){
	

	
	try{

List<SFDC_520_Quote__c> projectList = [Select Id from SFDC_520_Quote__c where Id =: projectId];
  if(projectList != null && projectList.size() > 0){
  	     SFDC_520_Quote__c project = projectList[0];
  	     project.Approval_Stage__c = 'Integration';
  	     update project;
  		 handleTasksByProjectPieces(project.Id);               
  }
  else{
      System.debug('No Project found with Id: '+projectId);
  }
  
	}
	catch(Exception ex){
		 try{
		  string errorDetails = UtilityClass.DebugException(ex);
          string message = 'There has been an error in vAutoAsynHandler.handleProjectCreation '+ errorDetails;
		  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          String[] toAddresses = new String[] {'ramana.mosali@autotradergroup.com'};
          mail.setToAddresses(toAddresses);
          mail.setSubject('vAutoAsynHandler.handleProjectCreation Error');
          mail.setPlainTextBody(message);
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		  }catch(Exception e){
		  	//Ignore if anything else fail
		  }
	}
  
     
}



private static void handleTasksByProjectPieces(Id projectId){
List<SFDC_520_Quote__c> projectList = [Select Id
, Opportunity__r.Opportunity_Names__c
, Opportunity__r.Type 
, Related_POA__c
, Related_POA__r.OwnerId 
, OwnerId
from SFDC_520_Quote__c where Id =: projectId];

  if(projectList != null && projectList.size() > 0){
	     SFDC_520_Quote__c project = projectList[0];
	     
	     if( (project.Opportunity__r.Opportunity_Names__c == 'Conquest' || project.Opportunity__r.Opportunity_Names__c == 'Conquest Stand-Alone')
	     && (
	     project.Opportunity__r.Type == 'Sale'
	     || project.Opportunity__r.Type == 'Upsell'
       || project.Opportunity__r.Type == 'Reactivate'
	     )
	     ){ 
         List<Project_Piece__c> projectPieces = [Select Id,  Product_Make__c, Product_Name__c, Contact__c from Project_Piece__c 
         where Project__c =: project.Id
         and  Product_Name__c = 'Conquest Franchise'];
         		
				//* Conquest Intro Call – Make(s)
				//Make 1 task for each unique contact from the project assets (product name = Conquest Franchise)
  				handlePOATasks(project, projectPieces);
  				
  				//* Advance Setup Call – Make(s)
  				//Make 1 task for each unique contact from the project assets (product name = Conquest Franchise)
  				handleProjectAdvSetupCallTasks(project, projectPieces);
  				
  				//* Integration C - Make
  				//1 task for each make
                handleProjectIntegarionCTasks(project, projectPieces);
	     }
  }
  else {
      System.debug('No Project found with Id: '+projectId);
  }  
}


private Static void handleProjectIntegarionCTasks(SFDC_520_Quote__c project, List<Project_Piece__c> projectPieces){
	
	
	     if(projectPieces != null && projectPieces.size() > 0){
			//get assignee user from custom setttings			
			String assigneeEmail = vAuto__c.getOrgDefaults().Integration_C_Task_Assignee__c;
			List<User> users = [Select Id from User where email =:assigneeEmail];	
			Id assigneeUserId = project.OwnerId;
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}
	
         	//create intro calls for each contact
         	Map<Id, Set<String>> makesByContact = new Map<Id, Set<String>>();
         	List<Task> introCallTasks = new List<Task>();
         	for(Project_Piece__c piece : projectPieces){
				//Create a task task for make
	         			Task t =CreateTask('* Integration C - '+piece.Product_Make__c, 0, assigneeUserId, project.Id,piece.Contact__c);
	         			//only add if there is a task that needs to be created
	         			if(t != null){	    
	         			introCallTasks.add(t);
	         			}		
         	}
         	
         	if(introCallTasks.size() >0){
	         			insert introCallTasks;
	         		}
	         		
         
	         	 
	         }      
	
}
/*

An intro call needs to be created on the Project for each unique product contact related to a project asset
Example: 
Project Asset Make 1 – jane doe
Project Asset Make 2 – john doe
Project Make 3 – john doe
You would create 2 intro calls
If
Make 1 – jane doe
Make 2 – john doe
Make 3 – jim doe
You would create 3 intro calls
Make 1 – jane doe
Make 2 – jane doe
Make 3 – jane doe
You would create 1 intro call
The task subject line should be formatted “* Advance Setup Call – Make(s) and the assigned to on the task would be equal to the product contact from the project asset

*/
private Static void handleProjectAdvSetupCallTasks(SFDC_520_Quote__c project, List<Project_Piece__c> projectPieces){
	
	     if(projectPieces != null && projectPieces.size() > 0){
			//get assignee user from custom setttings			
			String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Advanced_Setup_Call_Assignee__c;
			List<User> users = [Select Id from User where email =:assigneeEmail];	
			Id assigneeUserId = project.OwnerId;
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}
	
         	//create intro calls for each contact
         	Map<Id, Set<String>> makesByContact = new Map<Id, Set<String>>();
         	
         	for(Project_Piece__c piece : projectPieces){
         		if(!makesByContact.containsKey(piece.Contact__c)){
         			Set<String> makes = new Set<String>(); 
         			if(piece.Product_Make__c != null){    			
         			makes.add(piece.Product_Make__c);
         			}else{
         			makes.add('');}
         			makesByContact.put(piece.Contact__c,makes);
         		}
         		else{
         			//If the contact already exists
         			//get the makes list
         			Set<String> makes  = makesByContact.get(piece.Contact__c);
         			String make = '';
         			if(piece.Product_Make__c != null){    			
         			make = piece.Product_Make__c;}
         			
         			
         			if(!makes.contains(make)){
         				makes.add(make);
         			}
         			makesByContact.put(piece.Contact__c,makes);
         		}		
         	}
         	
	         //if there are contacts and makes that we need to send a intro call for
	         if(!makesByContact.isEmpty()){
	         	
	         	List<Task> introCallTasks = new List<Task>();
	         		//for each contact
	         		for(Id contactId : makesByContact.keySet()){
	         			Set<String> makes = makesByContact.get(contactId);
	         			String csvMakes ='';
	         			//build a comma saperated makes list
	         			for(String make : makes){
	         				csvMakes += (csvMakes ==''? '':',')+make;
	         			}
	         			
	         			//Create a task for the contact
	         			Task t =CreateTask('* Advance Setup Call  – '+csvMakes, 0, assigneeUserId, project.Id,contactId);
	         			//only add if there is a task that needs to be created
	         			if(t != null){	         				
	         			introCallTasks.add(t);
	         			}
	         		}
	         		
	         		if(introCallTasks.size() >0){
	         			insert introCallTasks;
	         		}
	         }
	         	 
	         }      
	
}

/*

An intro call needs to be created on the POA for each unique product contact related to a project asset
Example: 
Project Asset Make 1 – jane doe
Project Asset Make 2 – john doe
Project Make 3 – john doe
You would create 2 intro calls
If
Make 1 – jane doe
Make 2 – john doe
Make 3 – jim doe
You would create 3 intro calls
Make 1 – jane doe
Make 2 – jane doe
Make 3 – jane doe
You would create 1 intro call
The task subject line should be formatted “*Conquest Intro Call – Make and the assigned to on the task would be equal to the product contact from the project asset

*/
private Static void handlePOATasks(SFDC_520_Quote__c project, List<Project_Piece__c> projectPieces){
	         if(projectPieces != null && projectPieces.size() > 0){
         	//create intro calls for each contact
         	Map<Id, Set<String>> makesByContact = new Map<Id, Set<String>>();
         	
         	for(Project_Piece__c piece : projectPieces){
         		if(!makesByContact.containsKey(piece.Contact__c)){
         			Set<String> makes = new Set<String>(); 
         			if(piece.Product_Make__c != null){    			
         			makes.add(piece.Product_Make__c);
         			}else{
         			makes.add('');}
         			makesByContact.put(piece.Contact__c,makes);
         		}
         		else{
         			//If the contact already exists
         			//get the makes list
         			Set<String> makes  = makesByContact.get(piece.Contact__c);
         			String make = '';
         			if(piece.Product_Make__c != null){    			
         			make = piece.Product_Make__c;}
         			
         			
         			if(!makes.contains(make)){
         				makes.add(make);
         			}
         			makesByContact.put(piece.Contact__c,makes);
         		}		
         	}
         	
         //if there are contacts and makes that we need to send a intro call for
         if(!makesByContact.isEmpty()){
         	
         	List<Task> introCallTasks = new List<Task>();
         		//for each contact
         		for(Id contactId : makesByContact.keySet()){
         			Set<String> makes = makesByContact.get(contactId);
         			String csvMakes ='';
         			//build a comma saperated makes list
         			for(String make : makes){
         				csvMakes += (csvMakes ==''? '':',')+make;
         			}
         			
         			//Create a task an intro call for the contact
         			Task t =CreateTask('*Conquest Intro Call – '+csvMakes, 0, project.Related_POA__r.OwnerId, project.Related_POA__c,contactId);
         			//only add if there is a task that needs to be created
         			if(t != null){
         			introCallTasks.add(t);
         			}
         		}
         		
         		if(introCallTasks.size() >0){
         			insert introCallTasks;
         		}
         }
         	 
         }      
}

   private Static Task CreateTask(String subject, Integer dueInDays, Id ownerId, Id whatId, Id whoId){
   	
   	      //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:ownerId
      and whatId=:whatId
      and Subject =: subject
      and Status =: 'Not Started'
      and WhoId =: whoId];
      
      if(tasks == null || tasks.size() == 0){
		Task task = new Task();
		task.Subject =  subject;
		task.ActivityDate = System.today().addDays(dueInDays);
		task.OwnerId = ownerId;
		task.WhatId = whatId;
		task.WhoId = whoId;
		return task;
      }
      else{
      	System.debug('Task with subject:'+subject+ 'already exists;');
      	return null;
      }
}

}