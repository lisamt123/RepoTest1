@isTest(SeeAllData=true) 
public class vAutoBillingItemHandler_Test {

static testMethod void Provision_LOB_Status_Good() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
    
    
   	
   	      //check if the related LOB Billed Items sproject types are set correctly
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.Project_Type__c == 'Account Setup','Project_Type__c is not valid');	   	  
   }
         
         
              //check if the intro call task is created
    List<Task>  introCalltasks = [Select Id from Task where 
      ownerId=:billingItemsMarkedWithLOB[0].Related_POA__r.OwnerId 
      and whatId=:billingItemsMarkedWithLOB[0].Related_POA__c
      and Subject = '* Intro Call'];
      
    System.Assert(introCalltasks != null,'No Intro Call Tasks got created as expected');
    System.Assert(introCalltasks.size() > 0,'No Intro Call Tasks got created as expected');
     System.Assert(introCalltasks.size() == billingItemsMarkedWithLOB.size() ,'Number of intro calls created does not match  Billing Items Marked as product suites');
       
           							
   	Billing_Item__c billingItem = 	billingItemsMarkedWithLOB[0];						
      //update the LOB_Status__c 
      system.assert(billingItem.LOB_Status__c != 'Good','Billing Item LOB_Status__c is already set to Good');
      billingItem.LOB_Status__c = 'Good';
      update billingItem;
           

         //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:billingItem.Related_POA__r.OwnerId 
      and whatId=:billingItem.Related_POA__c
      and Subject = '# PM Review Call Good Status'];
      
    System.Assert(tasks != null,'No Tasks got created as expected');
    System.Assert(tasks.size() > 0,'No Tasks got created as expected');
     System.Assert(tasks.size() ==1 ,'More than one Task got created');
     
     

     
      
	}
	
	static testMethod void Provision_LOB_Status_AtRisk() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
   	
   	      //check if the related LOB Billed Items sproject types are set correctly
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.Project_Type__c == 'Account Setup','Project_Type__c is not valid');	   	  
   }
           
                         //check if the intro call task is created
    List<Task>  introCalltasks = [Select Id from Task where 
      ownerId=:billingItemsMarkedWithLOB[0].Related_POA__r.OwnerId 
      and whatId=:billingItemsMarkedWithLOB[0].Related_POA__c
      and Subject = '* Intro Call'];
      
    System.Assert(introCalltasks != null,'No Intro Call Tasks got created as expected');
    System.Assert(introCalltasks.size() > 0,'No Intro Call Tasks got created as expected');
     System.Assert(introCalltasks.size() == billingItemsMarkedWithLOB.size() ,'Number of intro calls created does not match  Billing Items Marked as product suites');
       
           							
   	Billing_Item__c billingItem = 	billingItemsMarkedWithLOB[0];						
      //update the LOB_Status__c 
      system.assert(billingItem.LOB_Status__c != 'At Risk','Billing Item LOB_Status__c is already set to At Risk');
      billingItem.LOB_Status__c = 'At Risk';
      update billingItem;
           

         //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:billingItem.Related_POA__r.OwnerId 
      and whatId=:billingItem.Related_POA__c
      and Subject = '# PM Review Call At Risk Status'];
      
    System.Assert(tasks != null,'No Tasks got created as expected');
    System.Assert(tasks.size() > 0,'No Tasks got created as expected');
      System.Assert(tasks.size() ==1 ,'More than one Task got created');
      
	}
		static testMethod void Provision_LOB_Status_SaveAccount() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
   	
   	      //check if the related LOB Billed Items sproject types are set correctly
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.Project_Type__c == 'Account Setup','Project_Type__c is not valid');	   	  
   }

     /*Commented since we are not creating tasks for this status
                 //check if the intro call task is created
    List<Task>  introCalltasks = [Select Id from Task where 
      ownerId=:billingItemsMarkedWithLOB[0].Related_POA__r.OwnerId 
      and whatId=:billingItemsMarkedWithLOB[0].Related_POA__c
      and Subject = '* Intro Call'];
      
    System.Assert(introCalltasks != null,'No Intro Call Tasks got created as expected');
    System.Assert(introCalltasks.size() > 0,'No Intro Call Tasks got created as expected');
     System.Assert(introCalltasks.size() == billingItemsMarkedWithLOB.size() ,'Number of intro calls created does not match  Billing Items Marked as product suites');
               
           							
   	Billing_Item__c billingItem = 	billingItemsMarkedWithLOB[0];						
      //update the LOB_Status__c 
      system.assert(billingItem.LOB_Status__c != 'Save - Account','Billing Item LOB_Status__c is already set to Save - Account');
      billingItem.LOB_Status__c = 'Save - Account';
      update billingItem;
           

         //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:billingItem.Related_POA__r.OwnerId 
      and whatId=:billingItem.Related_POA__c
      and Subject = '# PM Review Call Save Status'];
      
    System.Assert(tasks != null,'No Tasks got created as expected');
    System.Assert(tasks.size() > 0,'No Tasks got created as expected');
      System.Assert(tasks.size() ==1 ,'More than one Task got created');
      */
      
	}
	static testMethod void Conquest_LOB_Status_Good() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupConquestOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
   	
   	      //check if the related LOB Billed Items sproject types are set correctly
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.Project_Type__c == 'Conquest','Project_Type__c is not valid');	   	  
   }
                  //check if the intro call task is created
    List<Task>  introCalltasks = [Select Id from Task where 
      ownerId=:billingItemsMarkedWithLOB[0].Related_POA__r.OwnerId 
      and whatId=:billingItemsMarkedWithLOB[0].Related_POA__c
      and Subject = '* Intro Call'];
      
 	System.Assert(introCalltasks.size() == 0,'Intro Call Tasks got created which is not expected');
              
           							
   	Billing_Item__c billingItem = 	billingItemsMarkedWithLOB[0];						
      //update the LOB_Status__c 
      system.assert(billingItem.LOB_Status__c != 'Good','Billing Item LOB_Status__c is already set to Good');
      billingItem.LOB_Status__c = 'Good';
      update billingItem;
           

         //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:billingItem.Related_POA__r.OwnerId 
      and whatId=:billingItem.Related_POA__c
      and Subject = '# Conquest Review Call Good Status'];
      
    System.Assert(tasks != null,'No Tasks got created as expected');
    System.Assert(tasks.size() > 0,'No Tasks got created as expected');
      System.Assert(tasks.size() ==1 ,'More than one Task got created');
      
	}
	
		static testMethod void Conquest_LOB_Status_AtRisk() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupConquestOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
   	
   	      //check if the related LOB Billed Items sproject types are set correctly
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.Project_Type__c == 'Conquest','Project_Type__c is not valid');	   	  
   }
           
               //check if the intro call task is created
    List<Task>  introCalltasks = [Select Id from Task where 
      ownerId=:billingItemsMarkedWithLOB[0].Related_POA__r.OwnerId 
      and whatId=:billingItemsMarkedWithLOB[0].Related_POA__c
      and Subject = '* Intro Call'];
      
 	System.Assert(introCalltasks.size() == 0,'Intro Call Tasks got created which is not expected');
                 							
   	Billing_Item__c billingItem = 	billingItemsMarkedWithLOB[0];						
      //update the LOB_Status__c 
      system.assert(billingItem.LOB_Status__c != 'At Risk','Billing Item LOB_Status__c is already set to At Risk');
      billingItem.LOB_Status__c = 'At Risk';
      update billingItem;
           

         //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:billingItem.Related_POA__r.OwnerId 
      and whatId=:billingItem.Related_POA__c
      and Subject = '# Conquest Review Call At Risk Status'];
      
    System.Assert(tasks != null,'No Tasks got created as expected');
    System.Assert(tasks.size() > 0,'No Tasks got created as expected');
      System.Assert(tasks.size() ==1 ,'More than one Task got created');
      
	}
	
		static testMethod void Conquest_LOB_Status_SaveAccount() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupConquestOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
   	
   	      //check if the related LOB Billed Items sproject types are set correctly
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.Project_Type__c == 'Conquest','Project_Type__c is not valid');	   	  
   }
           

           /*Commented since we are not creating tasks for this status
                 //check if the intro call task is created
    List<Task>  introCalltasks = [Select Id from Task where 
      ownerId=:billingItemsMarkedWithLOB[0].Related_POA__r.OwnerId 
      and whatId=:billingItemsMarkedWithLOB[0].Related_POA__c
      and Subject = '* Intro Call'];
      
 	System.Assert(introCalltasks.size() == 0,'Intro Call Tasks got created which is not expected');
               							
   	Billing_Item__c billingItem = 	billingItemsMarkedWithLOB[0];						
      //update the LOB_Status__c 
      system.assert(billingItem.LOB_Status__c != 'Save - Account','Billing Item LOB_Status__c is already set to Save - Account');
      billingItem.LOB_Status__c = 'Save - Account';
      update billingItem;
           

         //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:billingItem.Related_POA__r.OwnerId 
      and whatId=:billingItem.Related_POA__c
      and Subject = '# Conquest Review Call Save Status'];
      
    System.Assert(tasks != null,'No Tasks got created as expected');
    System.Assert(tasks.size() > 0,'No Tasks got created as expected');
      System.Assert(tasks.size() ==1 ,'More than one Task got created');
      */
      
	}


      static testMethod void AuctionGeniuswithvAutoandProvisioningClient_NoIntroCalls() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
    
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
    Test_vAutoOpportunity.setupAuctionGeniuswithvAutoandProvisioningClientOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
                  AND LOB__c !=null];
                  
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
    
          //check if the related LOB Billed Items sproject types are set correctly
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
      system.assert(item.Project_Type__c == 'Auction Genius - With Provision Client','Project_Type__c is not valid');       
   }
           
                 //check if the intro call task is created
    List<Task>  introCalltasks = [Select Id from Task where 
      ownerId=:billingItemsMarkedWithLOB[0].Related_POA__r.OwnerId 
      and whatId=:billingItemsMarkedWithLOB[0].Related_POA__c
      and Subject = '* Intro Call'];
      
    
    System.Assert(introCalltasks.size() == 0,'Intro Call Tasks got created which is not expected');
     
                            
      
  }

	
		static testMethod void ConquestFranchise_NoIntroCalls() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupConquestFranchiseSaleOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
   	
   	      //check if the related LOB Billed Items sproject types are set correctly
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.Project_Type__c == 'Conquest','Project_Type__c is not valid');	   	  
   }
           
                 //check if the intro call task is created
    List<Task>  introCalltasks = [Select Id from Task where 
      ownerId=:billingItemsMarkedWithLOB[0].Related_POA__r.OwnerId 
      and whatId=:billingItemsMarkedWithLOB[0].Related_POA__c
      and Subject = '* Intro Call'];
      
    
    System.Assert(introCalltasks.size() == 0,'Intro Call Tasks got created which is not expected');
     
               							
      
	}

      static testMethod void DoNotDeleteNonAddRecordTypes() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
    
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
    Test_vAutoOpportunity.setupConquestFranchiseSaleOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      
      
      //Now update the project Approval stage and confirm that the LOB Billed Items are also updated.
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        


      
                 //find all the related billing Items for above project pieces with record type ADD
  List<Billing_Item__c> billingItemsWithRecordTypeADD = [Select Id,LOB_Status__c,Project_Type__c,Related_POA__c,Related_POA__r.OwnerId from Billing_Item__c where Related_Project_Piece__c IN :projPieces
  and RecordTypeId =:  StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id ];
                  
  System.Assert(billingItemsWithRecordTypeADD != null,'No Billing Items with record type ADD');
  System.Assert(billingItemsWithRecordTypeADD.size() > 0,'No Billing Items with record type ADD');


//change the status to Locked
          billingItemsWithRecordTypeADD[0].RecordTypeId =  StaticData.getInstance().BillingItemRecTypesMapByDevName.get('Locked').Id ;
          update billingItemsWithRecordTypeADD[0];

  //try deleting it
      try {
         delete billingItemsWithRecordTypeADD[0];
        System.assert(false, 'exception expected for Deleting BillingItem with RecordType ADD');
    } catch (Exception e) {
      string expectedError = 'Can not delete Items';
        System.assert(e.getMessage().contains(expectedError), 'Expected Error Message containing message='+expectedError+', but found message is :' + e.getMessage());
    }
 

           
                            
      
  }
  
	
}