@isTest (SeeAllData=true)  
public class TaskHandler_Test {
static testMethod void IntegrationC_Complete () {
	User owner = setupUser();
	
	Contact contact = setupContact('firstName1','lastName1');
	SFDC_520_Quote__c vAutoProj = setupvAutoProject();
	
	//Create AdvsetupCall
	String advTaskSubject = '* Advance Setup Call  – Acura';
	Task advCallTask = CreateTask(advTaskSubject, 0, owner.Id, vAutoProj.Id,contact.Id,'Not Started');
	system.debug('Advance Call task created with subject:'+advTaskSubject);
			
	List<Task> advSetupTasks = [Select Id,ownerId from Task where subject =:advTaskSubject and whatId =: advCallTask.whatId];
	
    System.Assert(advSetupTasks!=null,'Advance Setup call is not created');
    System.Assert(advSetupTasks.size()> 0,'Advance Setup call is not created');
	
	Task integrationTask = CreateTask('* Integration C - '+'Acura', 0, owner.Id, vAutoProj.Id,contact.Id,'Not Started'); 
	//complete the integation task
	integrationTask.Status = 'Completed';
	update integrationTask;
	
	//check if Conquest Franchise Setup task got generated
	//get assignee user from custom setttings			
	/*String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Franchise_Setup_Task_Assignee__c;
	SYstem.Assert(assigneeEmail != null,'NO value for Conquest_Franchise_Setup_Task_Assignee__c in vAuto__c custom setting');
	SYstem.Assert(assigneeEmail != '','Empty value for Conquest_Franchise_Setup_Task_Assignee__c in vAuto__c custom setting');
	List<User> users = [Select Id from User where email =:assigneeEmail];	
	Id assigneeUserId = integrationTask.OwnerId;
		system.assert(users!= null,'No users with email: '+assigneeEmail);
	system.assert(users.size() > 0,'No users with email: '+assigneeEmail);
	
	if(users!= null && users.size() > 0){
		assigneeUserId = users[0].Id;
	}*/			 
	Id assigneeUserId = advCallTask.OwnerId;
	String subject = integrationTask.subject.replace('* Integration C -','* Conquest Franchise Setup -');

	 // check for task
      List<Task> tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:integrationTask.WhatId
      and Subject =:subject
      and Status = 'Not Started'
      and WhoId =: integrationTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 	
}


static testMethod void ConquestFranchiseSetup_Complete () {
	User owner = setupUser();
	Contact assignee = setupContact('firstName1','lastName1');
	SFDC_520_Quote__c vAutoProj = setupvAutoProject();
	Task conquestFranchiseSetup = CreateTask('* Conquest Franchise Setup - '+'Acura', 0, owner.Id, vAutoProj.Id,assignee.Id,'Not Started'); 
	//complete the conquestFranchiseSetup task
	conquestFranchiseSetup.Status = 'Completed';
	update conquestFranchiseSetup;
	
	//check if Conquest Franchise Setup task got generated
	//get assignee user from custom setttings			
	String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Verification_C_Task_Assignee__c;
	SYstem.Assert(assigneeEmail != null,'NO value for Conquest_Verification_C_Task_Assignee__c in vAuto__c custom setting');
	SYstem.Assert(assigneeEmail != '','Empty value for Conquest_Verification_C_Task_Assignee__c in vAuto__c custom setting');
	List<User> users = [Select Id from User where email =:assigneeEmail];	
	Id assigneeUserId = conquestFranchiseSetup.OwnerId;
	
	system.assert(users!= null,'No users with email: '+assigneeEmail);
	system.assert(users.size() != 0,'No users with email: '+assigneeEmail);
	
	if(users!= null && users.size() > 0){
		assigneeUserId = users[0].Id;
	}			
	 // check for task
      List<Task> tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:conquestFranchiseSetup.WhatId
      and Subject like '* Verification C -%'
      and Status = 'Not Started'
      and WhoId =: conquestFranchiseSetup.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 	
	  
	//check if Training 1 Conquest task got generated
	//get assignee user from custom setttings			
	/*assigneeEmail = vAuto__c.getOrgDefaults().Training_1_Conquest_Task_Assignee__c;
	SYstem.Assert(assigneeEmail != null,'NO value for Training_1_Conquest_Task_Assignee__c in vAuto__c custom setting');
	SYstem.Assert(assigneeEmail != '','Empty value for Training_1_Conquest_Task_Assignee__c in vAuto__c custom setting');
	
	users = [Select Id from User where email =:assigneeEmail];	
	assigneeUserId = conquestFranchiseSetup.OwnerId;
	
	system.assert(users!= null,'No users with email: '+assigneeEmail);
	system.assert(users.size() > 0,'No users with email: '+assigneeEmail);
	
	if(users!= null && users.size() > 0){
		assigneeUserId = users[0].Id;
	}
	*/
	
	assigneeUserId = conquestFranchiseSetup.OwnerId;			
	 // check for task
      tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:conquestFranchiseSetup.WhatId
      and Subject like '* Training 1 Conquest –%'
      and Status = 'Not Started'
      and WhoId =: conquestFranchiseSetup.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 	
	  
	  
	  
}

static testMethod void Training1Conquest_Complete () {
	User owner = setupUser();
	Contact assignee = setupContact('firstName1','lastName1');
	Account a = setupAccount();
	POA__c poa = setupvAutoPOA(a);	
	SFDC_520_Quote__c vAutoProj = setupvAutoProject();
	vAutoProj.Related_POA__c = poa.Id;
	update vAutoProj;
	Task training1ConquestTask = CreateTask('* Training 1 Conquest –'+'Acura', 0, owner.Id, vAutoProj.Id,assignee.Id,'Not Started'); 
	//complete the training1ConquestTask task
	training1ConquestTask.Status = 'Completed';
	update training1ConquestTask;
	
	//check if * Conquest Monthly Billing Task (MM) task got generated
	//get assignee user from custom setttings			
	String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_MM_Assignee__c;
	
	SYstem.Assert(assigneeEmail != null,'NO value for Conquest_Monthly_Billing_MM_Assignee__c in vAuto__c custom setting');
	SYstem.Assert(assigneeEmail != '','Empty value for Conquest_Monthly_Billing_MM_Assignee__c in vAuto__c custom setting');
	
	List<User> users = [Select Id,User_Full_Name__c from User where email =:assigneeEmail  and IsActive = true];	
	Id assigneeUserId = training1ConquestTask.OwnerId;
	
	system.assert(users!= null,'No users with email: '+assigneeEmail);
	system.assert(users.size() > 0,'No users with email: '+assigneeEmail);
	if(users!= null && users.size() > 0){
		system.assert(users[0].User_Full_Name__c == 'Maureen Morrissey','* Conquest Monthly Billing Task (MM) task  is not assigned to Maureen Morrissey');
		assigneeUserId = users[0].Id;
	}
			
	 // check for task
      List<Task> tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:training1ConquestTask.WhatId
      and Subject like '* Conquest Monthly Billing Task (MM)%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 	
	  
	  
	//check if * Conquest Monthly Billing Task (JT) task got generated
	//get assignee user from custom setttings			
	assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_JT_Assingee__c;
		SYstem.Assert(assigneeEmail != null,'NO value for Conquest_Monthly_Billing_JT_Assingee__c in vAuto__c custom setting');
	SYstem.Assert(assigneeEmail != '','Empty value for Conquest_Monthly_Billing_JT_Assingee__c in vAuto__c custom setting');
	users = [Select Id from User where email =:assigneeEmail];	
	assigneeUserId = training1ConquestTask.OwnerId;
	
		system.assert(users!= null,'No users with email: '+assigneeEmail);
	system.assert(users.size() != 0,'No users with email: '+assigneeEmail);
	
	
	if(users!= null && users.size() > 0){
		assigneeUserId = users[0].Id;
	}			
	 // check for task
      tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:training1ConquestTask.WhatId
      and Subject like '* Conquest Monthly Billing Task (JT)%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 

	//check if * Conquest Monthly Billing Task (EL) task got generated
	//get assignee user from custom setttings			
	assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_EL_Assignee__c;
	users = [Select Id from User where email =:assigneeEmail];	
	assigneeUserId = training1ConquestTask.OwnerId;
	if(users!= null && users.size() > 0){
		assigneeUserId = users[0].Id;
	}			
	  // check for task
      tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:training1ConquestTask.WhatId
      and Subject like '* Conquest Monthly Billing Task (EL)%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 
	  
	 
	 //check if 1st Conquest PM Review Call - task got generated	
	 //get assignee user from project POA
	 SFDC_520_Quote__c project = [Select Id, Related_POA__c,Related_POA__r.OwnerId from SFDC_520_Quote__c where Id =:training1ConquestTask.WhatId];	
	 // check for task
      tasks = [Select Id from Task where 
      ownerId=:project.Related_POA__r.OwnerId 
      and whatId=:project.Related_POA__c
      and Subject like '* 1st Conquest PM Review Call -%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 
	  	  
}

static testMethod void Training1Conquest_StandAlone_Complete() {
	User owner = setupUser();
	Contact assignee = setupContact('firstName1','lastName1');
	Account a = setupAccount();
	POA__c poa = setupvAutoPOA(a);	
	SFDC_520_Quote__c vAutoProj = setupvAutoProject();
	vAutoProj.Related_POA__c = poa.Id;
	vAutoProj.Project_Type__c = 'Conquest Stand-Alone';
	update vAutoProj;
	Task training1ConquestTask = CreateTask('* Training 1 Conquest –'+'Acura', 0, owner.Id, vAutoProj.Id,assignee.Id,'Not Started'); 
	//complete the training1ConquestTask task
	training1ConquestTask.Status = 'Completed';
	update training1ConquestTask;
	

		 // check for task * Training 2 Conquest 2
      List<Task> training2Tasks = [Select Id from Task where 
      ownerId=:owner.Id
      and whatId=:training1ConquestTask.WhatId
      and Subject like '* Training 2 Conquest%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(training2Tasks != null,'No Tasks got created as expected');
	  System.Assert(training2Tasks.size() > 0,'No Tasks got created as expected');
	  
	  
	//check if * Conquest Monthly Billing Task (MM) task got generated
	//get assignee user from custom setttings			
	String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_MM_Assignee__c;
	
	SYstem.Assert(assigneeEmail != null,'NO value for Conquest_Monthly_Billing_MM_Assignee__c in vAuto__c custom setting');
	SYstem.Assert(assigneeEmail != '','Empty value for Conquest_Monthly_Billing_MM_Assignee__c in vAuto__c custom setting');
	
	List<User> users = [Select Id,User_Full_Name__c from User where email =:assigneeEmail  and IsActive = true];	
	Id assigneeUserId = training1ConquestTask.OwnerId;
	
	system.assert(users!= null,'No users with email: '+assigneeEmail);
	system.assert(users.size() > 0,'No users with email: '+assigneeEmail);
	if(users!= null && users.size() > 0){
		system.assert(users[0].User_Full_Name__c == 'Maureen Morrissey','* Conquest Monthly Billing Task (MM) task  is not assigned to Maureen Morrissey');
		assigneeUserId = users[0].Id;
	}
			
	 // check for task
      List<Task> tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:training1ConquestTask.WhatId
      and Subject like '* Conquest Monthly Billing Task (MM)%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 	
	  
	  
	//check if * Conquest Monthly Billing Task (JT) task got generated
	//get assignee user from custom setttings			
	assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_JT_Assingee__c;
		SYstem.Assert(assigneeEmail != null,'NO value for Conquest_Monthly_Billing_JT_Assingee__c in vAuto__c custom setting');
	SYstem.Assert(assigneeEmail != '','Empty value for Conquest_Monthly_Billing_JT_Assingee__c in vAuto__c custom setting');
	users = [Select Id from User where email =:assigneeEmail];	
	assigneeUserId = training1ConquestTask.OwnerId;
	
		system.assert(users!= null,'No users with email: '+assigneeEmail);
	system.assert(users.size() != 0,'No users with email: '+assigneeEmail);
	
	
	if(users!= null && users.size() > 0){
		assigneeUserId = users[0].Id;
	}			
	 // check for task
      tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:training1ConquestTask.WhatId
      and Subject like '* Conquest Monthly Billing Task (JT)%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 

	//check if * Conquest Monthly Billing Task (EL) task got generated
	//get assignee user from custom setttings			
	assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Monthly_Billing_EL_Assignee__c;
	users = [Select Id from User where email =:assigneeEmail];	
	assigneeUserId = training1ConquestTask.OwnerId;
	if(users!= null && users.size() > 0){
		assigneeUserId = users[0].Id;
	}			
	  // check for task
      tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:training1ConquestTask.WhatId
      and Subject like '* Conquest Monthly Billing Task (EL)%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 
	  
	 
	 //check if 1st Conquest PM Review Call - task got generated	
	 //get assignee user from project POA
	 SFDC_520_Quote__c project = [Select Id, Related_POA__c,Related_POA__r.OwnerId from SFDC_520_Quote__c where Id =:training1ConquestTask.WhatId];	
	 // check for task
      tasks = [Select Id from Task where 
      ownerId=:project.Related_POA__r.OwnerId 
      and whatId=:project.Related_POA__c
      and Subject like '* 1st Conquest PM Review Call -%'
      and Status = 'Not Started'
      and WhoId =: training1ConquestTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 
	  	  
}


static testMethod void ConquestPMReviewCall_1st_Complete () {
	User owner = setupUser();
	Contact assignee = setupContact('firstName1','lastName1');
	Account a = setupAccount();
	POA__c poa = setupvAutoPOA(a);	
	Task ConquestPMReviewCall_1stTask = CreateTask('* 1st Conquest PM Review Call - '+'Acura', 0, owner.Id, poa.Id,assignee.Id,'Not Started'); 
	//complete the ConquestPMReviewCall_1st task
	ConquestPMReviewCall_1stTask.Status = 'Completed';
	update ConquestPMReviewCall_1stTask;
	
	  //check if Conquest Franchise Setup task got generated
      List<Task> tasks = [Select Id from Task where 
      ownerId=:ConquestPMReviewCall_1stTask.OwnerId
      and whatId=:ConquestPMReviewCall_1stTask.WhatId
      and Subject like '* 2nd Conquest PM Review Call -%'
      and Status = 'Not Started'
      and WhoId =: ConquestPMReviewCall_1stTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 	
}
static testMethod void ConquestPMReviewCall_2nd_Complete () {
	User owner = setupUser();
	Contact assignee = setupContact('firstName1','lastName1');
	Account a = setupAccount();
	POA__c poa = setupvAutoPOA(a);	
	Task ConquestPMReviewCall_2ndTask = CreateTask('* 2nd Conquest PM Review Call - '+'Acura', 0, owner.Id, poa.Id,assignee.Id,'Not Started'); 
	//complete the ConquestPMReviewCall_2nd task
	ConquestPMReviewCall_2ndTask.Status = 'Completed';
	update ConquestPMReviewCall_2ndTask;
	
	  //check if Conquest Franchise Setup task got generated
      List<Task> tasks = [Select Id from Task where 
      ownerId=:ConquestPMReviewCall_2ndTask.OwnerId
      and whatId=:ConquestPMReviewCall_2ndTask.WhatId
      and Subject like '* 3rd Conquest PM Review Call -%'
      and Status = 'Not Started'
      and WhoId =: ConquestPMReviewCall_2ndTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 	
}
static testMethod void ConquestPMReviewCall_3rd_Complete () {
	User owner = setupUser();
	Contact assignee = setupContact('firstName1','lastName1');
	Account a = setupAccount();
	POA__c poa = setupvAutoPOA(a);	
	Task ConquestPMReviewCall_3dTask = CreateTask('* 3rd Conquest PM Review Call - '+'Acura', 0, owner.Id, poa.Id,assignee.Id,'Not Started'); 
	//complete the ConquestPMReviewCall_3rd task
	ConquestPMReviewCall_3dTask.Status = 'Completed';
	update ConquestPMReviewCall_3dTask;
	
	  //check if Conquest Franchise Setup task got generated
      List<Task> tasks = [Select Id from Task where 
      ownerId=:ConquestPMReviewCall_3dTask.OwnerId
      and whatId=:ConquestPMReviewCall_3dTask.WhatId
      and Subject like '* 4th Conquest PM Review Call -%'
      and Status = 'Not Started'
      and WhoId =: ConquestPMReviewCall_3dTask.WhoId];
      
  	  System.Assert(tasks != null,'No Tasks got created as expected');
	  System.Assert(tasks.size() > 0,'No Tasks got created as expected');
	  //System.Assert(tasks.size() ==1 ,'No Tasks got created as expected');	 	
}



 public  static Contact setupContact(String firstName, String lastName){
         Contact c = new Contact();
        c.FirstName = firstName;
        c.LastName = lastName;
        c.Phone = '234-234-2345';
        insert c;
        return c;
 }   
   
   
 public  static User setupUser(){
 	Profile pfl = [select id from profile where name='Standard User'];
 	DateTime dt = DateTime.now();
    String formattedDt = dt.format('yyyyMMddhhmmss');
 	
 User usrAux = new User();                
        usrAux.Username = formattedDt+'@test.com';
                usrAux.FirstName= 'f'+formattedDt ;
        usrAux.LastName=  'l'+formattedDt;
        usrAux.IsActive= true;
        usrAux.Email = formattedDt+'@test.com';
        usrAux.Alias = usrAux.FirstName.SubString(0,1)+usrAux.LastName.SubString(0,1);
        usrAux.TimeZoneSidKey= 'America/Los_Angeles';
        usrAux.LocaleSidKey= 'en_US';
        usrAux.EmailEncodingKey ='UTF-8';
        
        usrAux.ProfileId = pfl.id;
        usrAux.LanguageLocaleKey ='en_US';
        insert usrAux;
        return usrAux;
 }   
   
  
     public  static Account setupAccount(){ 
        Account a = new Account();
        a.Name = 'test';
        a.BillingCity = 'Oakbrook Terrace';
        a.BillingCountry = 'USA';
        a.BillingState = 'IL';
        a.BillingStreet = '1901 S. Meyers Suite 700';
        a.BillingPostalCode = '60181';
        a.ShippingCity = 'Oakbrook Terrace';
        a.ShippingCountry = 'USA';
        a.ShippingState = 'IL';
        a.ShippingStreet = '1901 S. Meyers Suite 700';
        a.ShippingPostalCode = '60181';
        insert a;
        return a;
    }
    

 public  static SFDC_520_Quote__c setupvAutoProject(){
         SFDC_520_Quote__c proj= new SFDC_520_Quote__c();
        proj.Name = 'TestProject';
        proj.RecordTypeId = StaticData.getInstance().ProjectRecTypesMapByDevName.get('vAuto').Id;
        insert proj;
        return proj;
 }   
 
  public  static POA__c setupvAutoPOA(Account a){
         POA__c poa= new POA__c();
        poa.Name = 'TestPOA';
        
        poa.Dealer__c = a.Id;
        poa.RecordTypeId = StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id;
        insert poa;
        return poa;
 }   
 
     public Static Task CreateTask(String subject, Integer dueInDays, Id ownerId, Id whatId, Id whoId, String status){
   	
		Task task = new Task();
		task.Subject =  subject;
		task.ActivityDate = System.today().addDays(dueInDays);
		task.OwnerId = ownerId;
		task.WhatId = whatId;
		task.WhoId = whoId;
		insert task;
		return task;

     }
     
}