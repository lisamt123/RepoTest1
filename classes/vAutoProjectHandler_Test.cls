@isTest(SeeAllData=true) 
public  class vAutoProjectHandler_Test {


  static testMethod void CheckingProjectNames() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
    
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
      opp.Opportunity_Names__c = 'Trial';                       
      opp.Add_Deposit__c = 'No';
      opp.Type = 'Site Module Upsell';  
                      
      update opp;
      Product2 prod1 = Test_vAutoOpportunity.getProduct('ProVisioning');

        
      OpportunityLineItem  oppLine1 = Test_vAutoOpportunity.createOppProduct(opp,prod1);
      
      List<OpportunityLineItem> oppLines = new List<OpportunityLineItem>();
      oppLines.add(oppLine1);
            insert oppLines;
             
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
      
      List<SFDC_520_Quote__c> projects = [Select Id,Name,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];

      //check that project names are valid
      for(SFDC_520_Quote__c proj : projects){
        system.debug('Proj.Name: '+proj.Name);
        //System.assert(proj.Name == '', '')
      }
  }



  static testMethod void AutionGenius_ApprovalStage_IntegrationComplete() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
    
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
    Test_vAutoOpportunity.setupAuctionGeniusOpportunity(opp);
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
        

                  
      //update the project Approval statge 
      system.assert( project.Approval_Stage__c != 'Integration Complete','Project is already in Integration Complete Stage');
      project.Approval_Stage__c = 'Integration Complete';
      update project;
      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c from Billing_Item__c where Related_Project_Piece__c IN :projPieces
                  AND LOB__c !=null];
                  
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
                  
      //check if the related LOB Billed Items status updated.
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
      system.assert(item.LOB_Status__c=='Pending Needs Training','Project Approval Stage set to Intergation Complete but LOB Billed Items Status not chaanged to Pending Needs Training');        
   }
           

      
      
  }

    static testMethod void AutionGenius_ApprovalStage_Completed() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
    
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
    Test_vAutoOpportunity.setupAuctionGeniusOpportunity(opp);
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
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Status__c,Project_Type__c,RecordTypeId,Related_POA__c,Related_POA__r.OwnerId  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        

                  
      //update the project Approval statge 
      system.assert( project.Status__c != 'Completed','Project status is already completed; Approval_Stage__c changes will not be triggered');
      system.assert( project.Approval_Stage__c != 'Completed','Project is already in Completed Stage');
      project.Approval_Stage__c = 'Completed';
      update project;
      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c from Billing_Item__c where Related_Project_Piece__c IN :projPieces
                  AND LOB__c !=null];

  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
    System.Assert(billingItemsMarkedWithLOB.size() ==1,'Expecting only one Billing Item Marked as product suites found:'+billingItemsMarkedWithLOB.size()); 
                      
      //check if the related LOB Billed Items status updated.
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
      system.assert(item.LOB_Status__c=='Good','Project Approval Stage set to Completed but LOB Billed Items Status not chaanged to Good');        
   }

  }

static testMethod void Provision_ApprovalStage_IntegrationComplete() {

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
        

   								
      //update the project Approval statge 
      system.assert( project.Approval_Stage__c != 'Integration Complete','Project is already in Integration Complete Stage');
      project.Approval_Stage__c = 'Integration Complete';
      update project;
      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
   								
      //check if the related LOB Billed Items status updated.
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.LOB_Status__c=='Pending Needs Training','Project Approval Stage set to Intergation Complete but LOB Billed Items Status not chaanged to Pending Needs Training');	   	  
   }
           

      
      
	}
      	static testMethod void Provision_ApprovalStage_Training2() {

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
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c,Related_POA__r.OwnerId  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        

   								
      //update the project Approval statge
      system.assert( project.Approval_Stage__c != 'Training 2','Project is already in Training 2 Stage');
      project.Approval_Stage__c = 'Training 2';
      update project;
      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];

  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites');
       								
      //check if the related LOB Billed Items status updated.
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.LOB_Status__c=='Pending Launch Approval','Project Approval Stage set to Training 2 but LOB Billed Items Status not chaanged to Pending Launch Apporoval');	   	  
   }
      
      //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:project.Related_POA__r.OwnerId 
      and whatId=:project.Related_POA__c
      and Subject = '* 1st PM Call'];
      
    System.Assert(tasks != null,'No Tasks got created as expected');
    System.Assert(tasks.size() > 0,'No Tasks got created as expected');
      System.Assert(tasks.size() ==1 ,'More than one Task got created');
	}
	
	static testMethod void Conquest_ApprovalStage_IntegrationComplete() {

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
        

   								
      //update the project Approval statge 
      system.assert( project.Approval_Stage__c != 'Integration Complete','Project is already in Integration Complete Stage');
      project.Approval_Stage__c = 'Integration Complete';
      update project;
      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];
   								
  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
    
   								
      //check if the related LOB Billed Items status updated.
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.LOB_Status__c=='Pending Needs Training','Project Approval Stage set to Intergation Complete but LOB Billed Items Status not chaanged to Pending Needs Training');	   	  
   }
           

      
      
	}
	
		static testMethod void Conquest_ApprovalStage_Completed() {

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
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Status__c,Project_Type__c,RecordTypeId,Related_POA__c,Related_POA__r.OwnerId  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      
            
          // first find all project pieces
   List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
        FROM Project_Piece__c
        WHERE Project__c =: project.Id];
        

   								
      //update the project Approval statge 
      system.assert( project.Status__c != 'Completed','Project status is already completed; Approval_Stage__c changes will not be triggered');
      system.assert( project.Approval_Stage__c != 'Completed','Project is already in Completed Stage');
      project.Approval_Stage__c = 'Completed';
      update project;
      
                 //find all the related billing Items for above project pieces
   //which are marked with LOB; to showup as product suites/status in POA
   List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id,LOB_Status__c from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								AND LOB__c !=null];

  System.Assert(billingItemsMarkedWithLOB != null,'No Billing Items Marked as product suites');
    System.Assert(billingItemsMarkedWithLOB.size() > 0,'No Billing Items Marked as product suites'); 
    System.Assert(billingItemsMarkedWithLOB.size() ==1,'Expecting only one Billing Item Marked as product suites found:'+billingItemsMarkedWithLOB.size()); 
       								
      //check if the related LOB Billed Items status updated.
   for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		system.assert(item.LOB_Status__c=='Pending Launch Approval','Project Approval Stage set to Completed but LOB Billed Items Status not chaanged to Pending Launch Apporoval');	   	  
   }
      
      //check if the task created
      List<Task> tasks = [Select Id from Task where 
      ownerId=:project.Related_POA__r.OwnerId 
      and whatId=:project.Related_POA__c
      and Subject = '* 1st PM Call'];
      
    System.Assert(tasks.size() == 0,'Unexcpected Tasks got created');
	}
	
	
			static testMethod void ConquestFranchise_IntroCallsByContactAndMake() {

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
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Status__c,Project_Type__c,RecordTypeId,Related_POA__c,Related_POA__r.OwnerId  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      //since the Opportunity as 3 makes and 2 contacts 
      // we expect the code to generate 2 Intro calls one for each contact and combine the makes for same contact
       Product2 prod2 = Test_vAutoOpportunity.getProduct('Conquest Franchise');
       PricebookEntry pe =  Test_vAutoOpportunity.getPricebookEntry(prod2);
      
      List<OpportunityLineItem> conquestFranchiseLines = [Select Product_Contact__c,Make__c from OpportunityLineItem where OpportunityId=: opp.Id
      and PricebookEntryId =: pe.Id];
      
      System.Assert(conquestFranchiseLines.size() ==3,'There are 3 lines expected but found:'+conquestFranchiseLines.size());
      
      Map<Id, Set<String>> makesByContact = new Map<Id, Set<String>>();
      
      	for(OpportunityLineItem line : conquestFranchiseLines){
      		
      		system.debug('Test Processing: '+line.Product_Contact__c + ' Make: '+line.Make__c);
         		if(!makesByContact.containsKey(line.Product_Contact__c)){
         			Set<String> makes = new Set<String>(); 
         			if(line.Make__c != null){    			
         			makes.add(line.Make__c);
         			}else{
         			makes.add('');}
         			makesByContact.put(line.Product_Contact__c,makes);
         		}
         		else{
         			//If the contact already exists
         			//get the makes list
         			Set<String> makes  = makesByContact.get(line.Product_Contact__c);
         			String make = '';
         			if(line.Make__c != null){    			
         			make = line.Make__c;}
         			
         			
         			if(!makes.contains(make)){
         				makes.add(make);
         			}
         			makesByContact.put(line.Product_Contact__c,makes);
         		}		
         	}
         	
         	System.Assert( makesByContact.size()==2, 'There are 2 contacts expected but found: '+makesByContact.size());
         	
         	//for each contact
         		for(Id contactId : makesByContact.keySet()){
         	Set<String> makes = makesByContact.get(contactId);
         			String csvMakes ='';
         			//build a comma saperated makes list
         			for(String make : makes){
         				csvMakes += (csvMakes ==''? '':',')+make;
         			}
      String subject = '*Conquest Intro Call – '+csvMakes;
            List<Task> tasks = [Select Id from Task where 
      ownerId=:project.Related_POA__r.OwnerId
      and whatId=:project.Related_POA__c
      and Subject =: subject 
      and Status =: 'Not Started'
      and WhoId =: contactId];
      
      	  System.Assert(tasks != null,'No Tasks got created as expected for contact:'+contactId + ' and makes: '+ csvMakes);
    System.Assert(tasks.size() > 0,'No Tasks got created as expected for contact:'+contactId + ' and makes: '+ csvMakes);
      System.Assert(tasks.size() ==1 ,'No Tasks got created as expected for contact:'+contactId + ' and makes: '+ csvMakes);
         		}
      
}

	static testMethod void ConquestFranchise_AdvanceSetupCallByContactAndMake() {

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
      List<SFDC_520_Quote__c> projects = [Select Id,OwnerId, Approval_Stage__c ,Status__c,Project_Type__c,RecordTypeId,Related_POA__c,Related_POA__r.OwnerId  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      //since the Opportunity as 3 makes and 2 contacts 
      // we expect the code to generate 2 Intro calls one for each contact and combine the makes for same contact
       Product2 prod2 = Test_vAutoOpportunity.getProduct('Conquest Franchise');
       PricebookEntry pe =  Test_vAutoOpportunity.getPricebookEntry(prod2);
      
      List<OpportunityLineItem> conquestFranchiseLines = [Select Product_Contact__c,Make__c from OpportunityLineItem where OpportunityId=: opp.Id
      and PricebookEntryId =: pe.Id];
      
      System.Assert(conquestFranchiseLines.size() ==3,'There are 3 lines expected but found:'+conquestFranchiseLines.size());
      
      Map<Id, Set<String>> makesByContact = new Map<Id, Set<String>>();
      
      	for(OpportunityLineItem line : conquestFranchiseLines){
      		
      		system.debug('Test Processing: '+line.Product_Contact__c + ' Make: '+line.Make__c);
         		if(!makesByContact.containsKey(line.Product_Contact__c)){
         			Set<String> makes = new Set<String>(); 
         			if(line.Make__c != null){    			
         			makes.add(line.Make__c);
         			}else{
         			makes.add('');}
         			makesByContact.put(line.Product_Contact__c,makes);
         		}
         		else{
         			//If the contact already exists
         			//get the makes list
         			Set<String> makes  = makesByContact.get(line.Product_Contact__c);
         			String make = '';
         			if(line.Make__c != null){    			
         			make = line.Make__c;}
         			
         			
         			if(!makes.contains(make)){
         				makes.add(make);
         			}
         			makesByContact.put(line.Product_Contact__c,makes);
         		}		
         	}
         	
         	System.Assert( makesByContact.size()==2, 'There are 2 contacts expected but found: '+makesByContact.size());
         	
         	//get assignee user from custom setttings			
			String assigneeEmail = vAuto__c.getOrgDefaults().Conquest_Advanced_Setup_Call_Assignee__c;
				SYstem.Assert(assigneeEmail != null,'NO value for Conquest_Advanced_Setup_Call_Assignee__c in vAuto__c custom setting');
	SYstem.Assert(assigneeEmail != '','Empty value for Conquest_Advanced_Setup_Call_Assignee__c in vAuto__c custom setting');
	
			List<User> users = [Select Id,User_Full_Name__c from User where email =:assigneeEmail];	
			Id assigneeUserId = project.OwnerId;
				system.assert(users!= null,'No users with email: '+assigneeEmail);
	system.assert(users.size() != 0,'No users with email: '+assigneeEmail);
			if(users!= null && users.size() > 0){
				system.assert(users[0].User_Full_Name__c == 'Joe Dougherty','* Conquest Monthly Billing Task (MM) task  is not assigned to Joe Dougherty');
				assigneeUserId = users[0].Id;
			}
			
         	//for each contact
         		for(Id contactId : makesByContact.keySet()){
         	Set<String> makes = makesByContact.get(contactId);
         			String csvMakes ='';
         			//build a comma saperated makes list
         			for(String make : makes){
         				csvMakes += (csvMakes ==''? '':',')+make;
         			}
      String subject = '* Advance Setup Call  – '+csvMakes;
            List<Task> tasks = [Select Id from Task where 
      ownerId=:assigneeUserId
      and whatId=:project.Id
      and Subject =: subject 
      and Status =: 'Not Started'
      and WhoId =: contactId];
      
      	  System.Assert(tasks != null,'No Tasks got created as expected for contact:'+contactId + ' and makes: '+ csvMakes);
    System.Assert(tasks.size() > 0,'No Tasks got created as expected for contact:'+contactId + ' and makes: '+ csvMakes);
      System.Assert(tasks.size() ==1 ,'No Tasks got created as expected for contact:'+contactId + ' and makes: '+ csvMakes);
         		}
      
}

	static testMethod void ConquestFranchise_IntegrationCallTask() {

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
      List<SFDC_520_Quote__c> projects = [Select Id,OwnerId, Approval_Stage__c ,Status__c,Project_Type__c,RecordTypeId,Related_POA__c,Related_POA__r.OwnerId  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      SFDC_520_Quote__c project = projects[0];
      //since the Opportunity as 3 makes and 2 contacts 
      // we expect the code to generate 2 Intro calls one for each contact and combine the makes for same contact
       Product2 prod2 = Test_vAutoOpportunity.getProduct('Conquest Franchise');
       PricebookEntry pe =  Test_vAutoOpportunity.getPricebookEntry(prod2);
      
      List<OpportunityLineItem> conquestFranchiseLines = [Select Product_Contact__c,Make__c from OpportunityLineItem where OpportunityId=: opp.Id
      and PricebookEntryId =: pe.Id];
      
      System.Assert(conquestFranchiseLines.size() ==3,'There are 3 lines expected but found:'+conquestFranchiseLines.size());
      
      Map<String,Id> mapMakes = new Map<String,Id>();
      
      	for(OpportunityLineItem line : conquestFranchiseLines){
      		
      		
      		system.debug('Test Processing: '+line.Product_Contact__c + ' Make: '+line.Make__c);
         		if(!mapMakes.containsKey(line.Make__c)){			
         			mapMakes.put(line.Make__c,line.Product_Contact__c);
         		}
         	}
         	
         	System.Assert( mapMakes.size()==3, 'There are 3 makes expected but found: '+mapMakes.size());
         	
         	//get assignee user from custom setttings			
			String assigneeEmail = vAuto__c.getOrgDefaults().Integration_C_Task_Assignee__c;
			List<User> users = [Select Id from User where email =:assigneeEmail];	
			Id assigneeUserId = project.OwnerId;
			if(users!= null && users.size() > 0){
				assigneeUserId = users[0].Id;
			}
			
         	//for each contact
         		for(String make : mapMakes.keySet()){      
         			  Id contactId =  mapMakes.get(make);  	
				      String subject = '* Integration C - '+make;
				      List<Task> tasks = [Select Id from Task where 
				      ownerId=:assigneeUserId
				      and whatId=:project.Id
				      and Subject =: subject 
				      and Status =: 'Not Started'
				      and WhoId =:contactId ];
				      
				      	  System.Assert(tasks != null,'No Tasks got created as expected for make: '+ make + ' contact:'+contactId);
				    System.Assert(tasks.size() > 0,'No Tasks got created as expected for make: '+ make + ' contact:'+contactId);
				      System.Assert(tasks.size() ==1 ,'No Tasks got created as expected for make: '+ make + ' contact:'+contactId);
         		}
      
}

}