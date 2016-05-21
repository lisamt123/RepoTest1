@isTest(SeeAllData=true)
public class Test_vAutoOpportunity{
  /*
  
   //Commeneted 2
    static testMethod void validate_ConquestFranchise() {

    	
      Contact cont =  setupContact();
      Account acct = setupAccount();
      Opportunity opp= setupOpportunity(acct, cont, 'vAuto');
	          	             opp.Opportunity_Names__c = 'Conquest';
        	              opp.Type = 'Sale';
        	             opp.Conquest_Contact_1__c =     opp.Deal_Contact__c;
        	             opp.Conquest_Contact_1_Makes__c = 'Acura';
        	             opp.Make__c = 'Acura';
        	             
             update opp;
    	      Product2 prod1 = getProduct('Conquest (with Provision Suite)');
      Product2 prod2 = getProduct('Conquest Set Up Fee');
        Product2 prod3 = getProduct('Deposit Conquest');
        Product2 prod4 = getProduct('Conquest Franchise');
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);
      OpportunityLineItem  oppLine2 = createOppProduct(opp,prod2);
      OpportunityLineItem  oppLine3 = createOppProduct(opp,prod3);
      
      OpportunityLineItem  oppLine4 = createOppProduct(opp,prod4);      
      oppLine4.Make__c = 'Acura';
      Contact conquestContact1 = setupContact('TestFirst1','TestLast1');
      oppLine4.Product_Contact__c = conquestContact1.Id;
      
      OpportunityLineItem  oppLine5 = createOppProduct(opp,prod4);
      oppLine5.Make__c = 'Honda';
      oppLine5.Product_Contact__c = conquestContact1.Id;
      
      OpportunityLineItem  oppLine6 = createOppProduct(opp,prod4);
      //oppLine6.Make__c = 'GMC';
      //oppLine6.Product_Contact__c = setupContact('TestFirst2','TestLast2').Id;
      
      List<OpportunityLineItem> oppLines = new List<OpportunityLineItem>();
      oppLines.add(oppLine1);
            oppLines.add(oppLine2);
            oppLines.add(oppLine3);
            oppLines.add(oppLine4);
            oppLines.add(oppLine5);
            oppLines.add(oppLine6);
            insert oppLines;
      Test.startTest();
      //set the opp to Closed Own
      opp.StageName= 'Pending Won';
       
	    assertErrorOnUpdate(
	    opp,
	    'requires Make and Contact fields'
	    );
    Test.stopTest();
    }
    private static void assertErrorOnUpdate(SObject sob, String expected) {
    try {
        update sob;
        System.assert(false, 'exception expected for SObject ' + sob);
    } catch (Exception e) {
        System.assert(e.getMessage().contains(expected), 'message=' + e.getMessage());
    }
}*/

  static testMethod void fieldAssignments() {
      Contact cont =  setupContact();
      Account acct = setupAccount();      
      //update the acct Name to be more than 100;
      acct.Name  = TestData.generateRandomString(80);
      update acct;  
      Opportunity opp= setupOpportunity(acct, cont, 'vAuto');
      //check on create
      opp = [SELECT AccountId, Business_Unit__c, CloseDate, Haystak_Opportunity_Account__c, VIN_Opportunity_Account__c, vAuto_Opportunity_Account__c FROM Opportunity where Id=: opp.Id];
      System.Assert(opp.vAuto_Opportunity_Account__c== opp.AccountId);  
      System.Assert(opp.vAuto_Opportunity_Account__c== acct.Id);        

      Test.startTest();
      UtilityClass.debugSystemLimits();
      update opp;           
      //check on update
      opp = [SELECT AccountId, Business_Unit__c, CloseDate, Haystak_Opportunity_Account__c, VIN_Opportunity_Account__c, vAuto_Opportunity_Account__c FROM Opportunity where Id=: opp.Id];
      System.Assert(opp.vAuto_Opportunity_Account__c== opp.AccountId);  
      System.Assert(opp.vAuto_Opportunity_Account__c== acct.Id);  
      //check on update on a change
      Account acct1 = setupAccount(); 
      opp.AccountId = acct1.Id;      
      update opp;
      opp = [SELECT AccountId, Business_Unit__c, CloseDate, Haystak_Opportunity_Account__c, VIN_Opportunity_Account__c, vAuto_Opportunity_Account__c FROM Opportunity where Id=: opp.Id];
      System.Assert(opp.vAuto_Opportunity_Account__c== opp.AccountId);  
      System.Assert(opp.vAuto_Opportunity_Account__c== acct1.Id);  
      Test.stopTest();
  }


  static testMethod void closedOwn_AUXAccountSetup() {
  
      Contact cont =  setupContact();
      Account acct = setupAccount();
      Opportunity opp= setupAUXAccountSetupOpportunity(acct, cont, 'vAuto');    
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      //Validate POA
      RecordType poaRecordType = StaticData.getInstance().POARecTypesMapByName.get('vAuto');
      List<POA__c> p = [Select Id , RecordTypeId from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId =: poaRecordType.Id AND status__c !=: 'Churned'];
    System.Assert(p!=null,'NO POA records created');
    System.Assert(p.size()>0 ,'NO POA records created');
    
      //Validate Project Exists  
      List<SFDC_520_Quote__c> projects = [Select Id, OwnerId, Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];      
      System.AssertNotEquals(projects,NULL,'No Projects got created');
      System.Assert(projects.size()> 0,'No Projects got created');
      System.Assert(projects.size()== 1,'More than one Project got created');
      SFDC_520_Quote__c proj = projects[0];
      System.AssertEquals(proj.Approval_Stage__c ,'Integration','Project is not set to Integration Status');
      System.Assert(proj.Related_POA__c != null ,'Project Related POA is not set');
      System.Assert(proj.Project_Type__c == opp.Opportunity_Names__c,'Project type does not match Opportunity Names');    
      
      String auxProjownerEmail = vAuto__c.getOrgDefaults().Default_Project_Owner__c;
        if(auxProjownerEmail ==null || auxProjownerEmail =='' ){
       throw new CoxAutomotiveException('Could not find the project owner; NO value for Default_Project_Owner__c in vAuto__c custom setting');  
        }
      List<User> auxProjOwnerusers = [Select Id from User where email =:auxProjownerEmail];  
        
      if(auxProjOwnerusers== null || auxProjOwnerusers.size() == 0){  
      throw new CoxAutomotiveException('Could not find the project owner; No users with email: '+auxProjownerEmail); 
      }
      System.Assert(proj.OwnerId == auxProjOwnerusers[0].Id,'Project Owner is incorrect');    
      
      //Validate that NO contract was created
      List<Contract> contracts = [Select Contract_Type__c,Description,Id,Related_Opportunity__c  from Contract where Related_Opportunity__c =: opp.Id];      
      System.Assert(contracts.size() == 0,'No Contracts should be created');
      
  }
  



  static testMethod void closedOwn_Removal() {
  
      Contact cont =  setupContact();
      Account acct = setupAccount();
      Opportunity opp= setupRemovalOpportunity(acct, cont, 'vAuto');	  
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      //Validate POA
      RecordType poaRecordType = StaticData.getInstance().POARecTypesMapByName.get('vAuto');
      List<POA__c> p = [Select Id , RecordTypeId from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId =: poaRecordType.Id AND status__c !=: 'Churned'];
	  System.Assert(p!=null,'NO POA records created');
	  System.Assert(p.size()>0 ,'NO POA records created');
	  
      //Validate Project Exists  
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];      
      System.AssertNotEquals(projects,NULL,'No Projects got created');
      System.Assert(projects.size()> 0,'No Projects got created');
      System.Assert(projects.size()== 1,'More than one Project got created');
      SFDC_520_Quote__c proj = projects[0];
      System.AssertEquals(proj.Approval_Stage__c ,'Integration','Project is not set to Integration Status');
   	  System.Assert(proj.Related_POA__c != null ,'Project Related POA is not set');
   	  System.Assert(proj.Project_Type__c == opp.Opportunity_Names__c,'Project type does not match Opportunity Names');    
   	  
   	  
   	  //Validate that NO contract was created
   	  List<Contract> contracts = [Select Contract_Type__c,Description,Id,Related_Opportunity__c  from Contract where Related_Opportunity__c =: opp.Id];      
      System.Assert(contracts.size() == 0,'No Contracts should be created');
   	  
  }
  
  static testMethod void closedOwn_Pricechange() {
  
      Contact cont =  setupContact();
      Account acct = setupAccount();
      Opportunity opp= setupPriceChangesOpportunity(acct, cont, 'vAuto');	  
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      //Validate POA
      RecordType poaRecordType = StaticData.getInstance().POARecTypesMapByName.get('vAuto');
      List<POA__c> p = [Select Id , RecordTypeId from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId =: poaRecordType.Id AND status__c !=: 'Churned'];
	  System.Assert(p!=null,'NO POA records created');
	  System.Assert(p.size()>0 ,'NO POA records created');
      
    //Validate Project Exists  
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];      
      System.AssertNotEquals(projects,NULL,'No Projects got created');
      System.Assert(projects.size()> 0,'No Projects got created');
      System.Assert(projects.size()== 1,'More than one Project got created');
      SFDC_520_Quote__c proj = projects[0];
      System.AssertEquals(proj.Approval_Stage__c ,'Completed','Project is not set to Completed Status');
      System.Assert(proj.Related_POA__c != null ,'Project Related POA is not set');
      System.Assert(proj.Project_Type__c == opp.Opportunity_Names__c,'Project type does not match Opportunity Names');    
        
   	  
   	  //Validate that NO contract was created
   	  List<Contract> contracts = [Select Contract_Type__c,Description,Id,Related_Opportunity__c  from Contract where Related_Opportunity__c =: opp.Id];      
      System.Assert(contracts.size() == 0,'No Contracts should be created');
  }
  

  static testMethod void closedOwn_Provision_WithExistingNonRMBContract() {
    
      Contact cont =  setupContact();
      Account acct = setupAccount();
      acct.vAuto_Account_Number__c = 'TC2342Test23423';
      update acct;
      //Create a NON-RMB Contract
      Contract nonRMBContract = TestData.setupContract(acct, StaticData.getInstance().ContractRecTypesMapByDevName.get('vAuto_NOT_RMB'));
      nonRMBContract.Contract_Type__c = 'vAuto';
      insert nonRMBContract;

      Opportunity opp= setupOpportunity(acct, cont, 'vAuto');
      setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      ValidatePOA(opp);
      ValidateProject(opp);
      ValidateNonRMBContract(opp);
      //Make sure NonRMB Contract was used; no other contracts were created
    List<Contract> existingContracts = [Select Id from Contract where AccountId =: opp.AccountId];  
    system.assert(existingContracts.size() == 1 ,'Expected only one contract found: '+existingContracts.size());
  }

    static testMethod void closedOwn_Provision_WithNoNonRMBContract() {
    
      Contact cont =  setupContact();
      Account acct = setupAccount();
      acct.vAuto_Account_Number__c = 'TC2342Test23423';
      update acct;

      Opportunity opp= setupOpportunity(acct, cont, 'vAuto');
      setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      ValidatePOA(opp);
      ValidateProject(opp);
      ValidateNonRMBContract(opp);
   }



  static testMethod void closedOwn_Provision() {
  
      Contact cont =  setupContact();
      Account acct = setupAccount();
      Opportunity opp= setupOpportunity(acct, cont, 'vAuto');
	  setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      ValidatePOA(opp);
      ValidateProject(opp);
      
      ValidateContract(opp); 
      
  }


  
    static testMethod void closedOwn_Conquest() {
  
      Contact cont =  setupContact();
      Account acct = setupAccount();
      Opportunity opp= setupOpportunity(acct, cont, 'vAuto');
	  setupConquestOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      ValidatePOA(opp);
      ValidateProject(opp);
      
      ValidateContract(opp); 
      
  }



    static testMethod void closedOwn_ConquestStandAlone() {
  
      Contact cont =  setupContact();
      Account acct = setupAccount();
      Opportunity opp= setupOpportunity(acct, cont, 'vAuto');
      setupConquestStandAloneOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      ValidatePOA(opp);
      ValidateProject(opp);
      
      ValidateContract(opp); 
      
  }



    static testMethod void closedOwn_ProjectName_LongAccountName() {
  
  Contact cont =  setupContact();
      Account acct = setupAccount();
      //update the acct Name to be more than 100;
      acct.Name  = TestData.generateRandomString(80);
      update acct;  
      Opportunity opp= setupOpportunity(acct, cont, 'vAuto');
    setupConquestOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
      Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      ValidateOpportunity(opp);
      ValidatePOA(opp);
      ValidateProject(opp);
      
      ValidateContract(opp);  
      
  }


  
 public  static void ValidateOpportunity(Opportunity Opp){
    opp = [SELECT AccountId, Business_Unit__c, CloseDate, Haystak_Opportunity_Account__c, VIN_Opportunity_Account__c, vAuto_Opportunity_Account__c FROM Opportunity where Id=: opp.Id];
    List<OpportunityLineItem> oppLines =   [Select PricebookEntry.Product2.Project_Definition__c,
	  PricebookEntry.Product2.Name,Opportunity.RecordTypeId,Opportunity.RecordType.Name, Opportunity.AccountId,Opportunity.Account.Name,
	  Description, IsTraining__c, ProductId__c, PricebookEntry.Name, ProdProj_Default_Owner__c, Product_Issue__c, 
	  Product_Issue2__c, Product_Issue3__c, ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, 
	  Production_Department__c, Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
	  PricebookEntryId, requiresWelcomePacket__c, TotalPrice, OpportunityId, Id, Total_List_Price__c, VS_Sale_Price__c,
	  OLI_Cost_Factor__c, PricebookEntry.Product2.Subject_to_Load__c, PricebookEntry.Product2.Project_Separation__c,
	  Project__c, PricebookEntry.Product2.Family, PricebookEntry.Product2.ProdProj_Default_Owner__c,
	  PricebookEntry.Product2.Base_Product__c,
                          UnitPrice,   
                          Setup_Fee__c, TNOPPST__LineTax__c, PricebookEntry.Product2.Show_on_Bill__c                          
	  from OpportunityLineItem where OpportunityId =: opp.Id];   

    System.Assert(opp.vAuto_Opportunity_Account__c== opp.AccountId);   	
    
    /*for(OpportunityLineItem oli: oppLines){
      system.debug('oli.PricebookEntry.Product2.Name:'+oli.PricebookEntry.Product2.Name);      
      system.debug('oli.PricebookEntry.Product2.Project_Definition__c:'+oli.PricebookEntry.Product2.Project_Definition__c);

    } */        
  }
  public static void ValidateProject(Opportunity opp){
      //Validate Project Exists
      
      List<SFDC_520_Quote__c> projects = [Select Id,Approval_Stage__c ,Project_Type__c,RecordTypeId,Related_POA__c  from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      
      System.AssertNotEquals(projects,NULL,'No Projects got created');
      System.Assert(projects.size()> 0,'No Projects got created');
      
       Map<String,RecordType> projectRecordTypes = new   Map<String,RecordType>();
  for(RecordType recType : [SELECT Description, Name, NamespacePrefix, Id, DeveloperName FROM RecordType
where IsActive = true
and SobjectType = 'SFDC_520_Quote__c']){
    projectRecordTypes.put(recType.Name,recType);
}
     
     for(SFDC_520_Quote__c project :projects){
     System.AssertEquals(project.RecordTypeId,projectRecordTypes.get('vAuto').Id,'Project is not vAuto Record Type');
      
         if(opp.Type == 'Price Changes')
      {
        System.AssertEquals(project.Approval_Stage__c ,'Completed','Project is not set to Completed Status');
      }
      else{
   System.AssertEquals(project.Approval_Stage__c ,'Integration','Project is not set to Integration Status');
  }
   System.Assert(project.Related_POA__c != null ,'Project Related POA is not set');
   System.Assert(project.Project_Type__c == opp.Opportunity_Names__c,'Project type does not match Opportunity Names');
   
    ValidateProjectPieces(project,opp);
     }
   }
   public static void ValidateProjectPieces(SFDC_520_Quote__c project, Opportunity opp){
      //Validate Project Pieces      
      List<Project_Piece__c> projectPieces = [Select Id,  Project_Piece_Stage__c ,RecordTypeId from Project_Piece__c where Project__c =: project.Id];
       System.AssertNotEquals(projectPieces ,NULL,'No Project Pieces got created');
      Map<String,RecordType> projectPieceRecordTypes = new   Map<String,RecordType>();
  for(RecordType recType : [SELECT Description, Name, NamespacePrefix, Id, DeveloperName FROM RecordType
where IsActive = true
and SobjectType = 'Project_Piece__c']){
    projectPieceRecordTypes.put(recType.Name,recType);       
}     

  System.Assert(projectPieces!= null,'No Project peices are created');
  System.Assert(projectPieces.size()>0,'No Project peices are created');
    for(Project_Piece__c piece : projectPieces ){
        System.AssertEquals(piece.RecordTypeId,projectPieceRecordTypes.get('vAuto').Id,'Project Piece is not vAuto Record Type');
         System.AssertEquals(piece.Project_Piece_Stage__c ,'Pending','Project Piece is not set to Pending Stage');
        // if(opp.Opportunity_Names__c == 'Conquest' && opp.Type == 'Sale'){
         	 //System.Assert(piece.
         //}
    }
    
    
      
  }
  
  public static void ValidateConquestSaleProjectPiece(List<Project_Piece__c> pieces){
  	
  }
  
   public  static void ValidatePOA(Opportunity opp){
  
      //Validate POA Exists
        List<OpportunityLineItem> oppLines = [Select PricebookEntry.Product2.Project_Definition__c,
	    PricebookEntry.Product2.Name,Opportunity.RecordTypeId,Opportunity.RecordType.Name, Opportunity.AccountId,Opportunity.Account.Name,
	    Description, IsTraining__c, ProductId__c, PricebookEntry.Name, ProdProj_Default_Owner__c, Product_Issue__c, 
	    Product_Issue2__c, Product_Issue3__c, ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, 
	    Production_Department__c, Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
	    PricebookEntryId, requiresWelcomePacket__c, TotalPrice, OpportunityId, Id, Total_List_Price__c, VS_Sale_Price__c,
	    OLI_Cost_Factor__c, PricebookEntry.Product2.Subject_to_Load__c,
	    Project__c, PricebookEntry.Product2.Family, PricebookEntry.Product2.ProdProj_Default_Owner__c,
	    PricebookEntry.Product2.Base_Product__c,
                          UnitPrice,   
                          Setup_Fee__c, TNOPPST__LineTax__c, PricebookEntry.Product2.Show_on_Bill__c                          
	    from OpportunityLineItem where OpportunityId =: opp.Id];
	    
	    List<Id> poaList = new List<Id>();
	    for(OpportunityLineItem oli: oppLines){
	    
      system.debug('oli.PricebookEntry.Product2.Name:'+oli.PricebookEntry.Product2.Name);      
      system.debug('oli.PricebookEntry.Product2.Project_Definition__c:'+oli.PricebookEntry.Product2.Project_Definition__c);

	    	      	//Get the project Definition
  	  Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(oli.PricebookEntry.Product2.Project_Definition__c);
  	      if(projectDefinition == null){
	         throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oli.PricebookEntry.Product2.Name);	      
	    }
       system.debug('(projectDefinition.POA_Type__c:'+projectDefinition.POA_Type__c);      
	    if(projectDefinition.POA_Type__c != null && projectDefinition.POA_Type__c.trim() !=''){
	    	RecordType poaRecType = StaticData.getInstance().POARecTypesMapByName.get(projectDefinition.POA_Type__c);
	    	
    if(poaRecType != null){
	    poaList.add(poaRecType.Id);
    	}
	    }
	          	
	    }
	    
	    if(poaList.size() > 0){
	   List<POA__c> p = [Select Id , RecordTypeId from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId IN: poaList and status__c !=: 'Churned'];
	   System.Assert(p!=null,'NO POA records created');
	   System.Assert(p.size()>0 ,'NO POA records created');
	   for(POA__c poa : p){
	   	System.Assert(poa.RecordTypeId==StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id,'POA Created is not a vAuto Type');
	   }
	    }
	 
	    
  }

     public  static void ValidateNonRMBContract(Opportunity opp){
      //Validate Contract Exists
      List<Contract> contracts =  [Select Contract_Type__c,LOB__c,Description,Id,Related_Opportunity__c from Contract where AccountId =: opp.AccountId and Contract_Type__c = 'vAuto' 
    and RecordTypeId  =: StaticData.getInstance().ContractRecTypesMapByDevName.get('vAuto_NOT_RMB').Id and Status != 'Cancelled'];  
            System.AssertNotEquals(contracts,NULL,'No Contracs got created');
      System.Assert(contracts.size()> 0,'No Contracts got created');
      
          List<OpportunityLineItem> oppLines = [Select Product2.Name,Opportunity.RecordType.Name, Opportunity.AccountId,Opportunity.Account.Name,
            Description, IsTraining__c, ProductId__c, PricebookEntry.Name, ProdProj_Default_Owner__c, Product_Issue__c, 
            Product_Issue2__c, Product_Issue3__c, ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, 
            Production_Department__c, Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
            PricebookEntryId, requiresWelcomePacket__c, TotalPrice, OpportunityId, Id, Total_List_Price__c, VS_Sale_Price__c,
            OLI_Cost_Factor__c, PricebookEntry.Product2.Subject_to_Load__c, PricebookEntry.Product2.Project_Separation__c,
            Project__c, PricebookEntry.Product2.Family, PricebookEntry.Product2.ProdProj_Default_Owner__c,POA__c
            from OpportunityLineItem where OpportunityId =: Opp.Id];
            
      for(Contract contract: contracts){
         System.Assert(contract.Contract_Type__c =='vAuto','Contract type is not vAuto');
         System.Assert(contract.LOB__c =='VAUTO','LOB__c is not VAUTO');
      System.Assert(contract.Description ==opp.Description,'Opportunity Description is not copied to contract');
      
      
          List<Billing_Item__c> contractLines = [Select Id, LOB__c,Related_POA__c,isBaseAsset__c,Product_Sold__c,Product_Sold__r.Name from Billing_Item__c where Contract__c =: contract.Id];
                   System.AssertNotEquals(contractLines ,NULL,'No Contracs Lines got created');
      System.Assert(contractLines .size()> 0,'No Contract Lines got created');
      Set<Id> productsOfContract = new Set<Id>();
      
      for(Billing_Item__c contractLine : contractLines ){
      System.debug('Contract Line for product:'+ contractLine.Product_Sold__r.Name);
        
      //System.Assert(!productsOfContract.contains(contractLine.Product_Sold__c), contractLine.Product_Sold__r.Name + ' Product line created diplicate Billing Items in the contract');
      
   //add to the list for next check             
      productsOfContract.add(contractLine.Product_Sold__c);

      List<Product2> product = [select Id,Project_Definition__c, Name, Project_Definition__r.POA_Type__c from Product2 where Id =: contractLine.Product_Sold__c];
      if(product[0].Project_Definition__c != null && product[0].Project_Definition__r.POA_Type__c != null){
      System.Assert(contractLine.Related_POA__c != null,'NO Related_POA__c for contract line Product: '+product[0].Name);
      if(contractLine.isBaseAsset__c){
      System.Assert(contractLine.LOB__c != null,'NO LOB__c for contract line Product: '+product[0].Name);
      }
      }
      }

      if(opp.Opportunity_Names__c == 'Account Setup' && opp.Add_Deposit__c == 'Yes'){
          PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','DEPOSIT');
            List<Billing_Item__c> depositcontractLines = [Select Id, LOB__c,Related_POA__c,isBaseAsset__c,Product_Sold__c,Product_Sold__r.Name from Billing_Item__c where Contract__c =: contract.Id
            AND Product_Sold__c =:depositPriceBookEntry.Product2Id];
          System.Assert(depositcontractLines.size() > 0 ,'Deposit product: '+depositPriceBookEntry.Name +' expected alteast 1 but found: '+depositcontractLines.size());
      }
      else if (opp.Opportunity_Names__c == 'Conquest' && opp.Add_Deposit__c == 'Yes'){
          PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','CQ DEPOSIT');
            List<Billing_Item__c> depositcontractLines = [Select Id, LOB__c,Related_POA__c,isBaseAsset__c,Product_Sold__c,Product_Sold__r.Name from Billing_Item__c where Contract__c =: contract.Id
            AND Product_Sold__c =:depositPriceBookEntry.Product2Id];
          System.Assert(depositcontractLines.size() > 0 ,'Deposit product: '+depositPriceBookEntry.Name +' expected atleast 1 but found: '+depositcontractLines.size());
      }
      else if (opp.Opportunity_Names__c == 'Conquest Stand-Alone' && opp.Add_Deposit__c == 'Yes'){
          PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','CQ DEPOSIT');
            List<Billing_Item__c> depositcontractLines = [Select Id, LOB__c,Related_POA__c,isBaseAsset__c,Product_Sold__c,Product_Sold__r.Name from Billing_Item__c where Contract__c =: contract.Id
            AND Product_Sold__c =:depositPriceBookEntry.Product2Id];
          System.Assert(depositcontractLines.size() > 0 ,'Deposit product: '+depositPriceBookEntry.Name +' expected atleast 1 but found: '+depositcontractLines.size());
      }


      
      }
            
  }

   public  static void ValidateContract(Opportunity opp){
      //Validate Contract Exists
      List<Contract> contracts = [Select Contract_Type__c,LOB__c,Description,Id,Related_Opportunity__c  from Contract where Related_Opportunity__c =: opp.Id];
            System.AssertNotEquals(contracts,NULL,'No Contracs got created');
      System.Assert(contracts.size()> 0,'No Contracts got created');
      
          List<OpportunityLineItem> oppLines = [Select Product2.Name,Opportunity.RecordType.Name, Opportunity.AccountId,Opportunity.Account.Name,
            Description, IsTraining__c, ProductId__c, PricebookEntry.Name, ProdProj_Default_Owner__c, Product_Issue__c, 
            Product_Issue2__c, Product_Issue3__c, ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, 
            Production_Department__c, Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
            PricebookEntryId, requiresWelcomePacket__c, TotalPrice, OpportunityId, Id, Total_List_Price__c, VS_Sale_Price__c,
            OLI_Cost_Factor__c, PricebookEntry.Product2.Subject_to_Load__c, PricebookEntry.Product2.Project_Separation__c,
            Project__c, PricebookEntry.Product2.Family, PricebookEntry.Product2.ProdProj_Default_Owner__c,POA__c
            from OpportunityLineItem where OpportunityId =: Opp.Id];
            
      for(Contract contract: contracts){
         System.Assert(contract.Contract_Type__c =='vAuto','Contract type is not vAuto');
         System.Assert(contract.LOB__c =='VAUTO','LOB__c is not VAUTO');
      System.Assert(contract.Description ==opp.Description,'Opportunity Description is not copied to contract');
      
      
          List<Billing_Item__c> contractLines = [Select Id,Subscriber_Account__c,Related_Opportunity__c, LOB__c,Related_POA__c,isBaseAsset__c,Product_Sold__c,Product_Sold__r.Name from Billing_Item__c where Contract__c =: contract.Id];
                   System.AssertNotEquals(contractLines ,NULL,'No Contracs Lines got created');
      System.Assert(contractLines .size()> 0,'No Contract Lines got created');
      Set<Id> productsOfContract = new Set<Id>();
      
      for(Billing_Item__c contractLine : contractLines ){
      System.debug('Contract Line for product:'+ contractLine.Product_Sold__r.Name);
      	System.assert(contractLine.Subscriber_Account__c == opp.AccountId,'Subscriber Account field on Billing Line Item is not the same as Opp AccountId');
        System.assert(contractLine.Related_Opportunity__c == opp.Id,'Related_Opportunity__c field on Billing Line Item is not the same as Opp');
      //System.Assert(!productsOfContract.contains(contractLine.Product_Sold__c), contractLine.Product_Sold__r.Name + ' Product line created diplicate Billing Items in the contract');
      
	 //add to the list for next check		      		
      productsOfContract.add(contractLine.Product_Sold__c);

      List<Product2> product = [select Id,Project_Definition__c, Name, Project_Definition__r.POA_Type__c from Product2 where Id =: contractLine.Product_Sold__c];
      if(product[0].Project_Definition__c != null && product[0].Project_Definition__r.POA_Type__c != null){
      System.Assert(contractLine.Related_POA__c != null,'NO Related_POA__c for contract line Product: '+product[0].Name);
      if(contractLine.isBaseAsset__c){
      System.Assert(contractLine.LOB__c != null,'NO LOB__c for contract line Product: '+product[0].Name);
      }
      }
      }

      if(opp.Opportunity_Names__c == 'Account Setup' && opp.Add_Deposit__c == 'Yes'){
          PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','DEPOSIT');
            List<Billing_Item__c> depositcontractLines = [Select Id, LOB__c,Related_POA__c,isBaseAsset__c,Product_Sold__c,Product_Sold__r.Name from Billing_Item__c where Contract__c =: contract.Id
            AND Product_Sold__c =:depositPriceBookEntry.Product2Id];
          System.Assert(depositcontractLines.size() > 0 ,'Deposit product: '+depositPriceBookEntry.Name +' expected alteast 1 but found: '+depositcontractLines.size());
      }
      else if (opp.Opportunity_Names__c == 'Conquest' && opp.Add_Deposit__c == 'Yes'){
          PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','CQ DEPOSIT');
            List<Billing_Item__c> depositcontractLines = [Select Id, LOB__c,Related_POA__c,isBaseAsset__c,Product_Sold__c,Product_Sold__r.Name from Billing_Item__c where Contract__c =: contract.Id
            AND Product_Sold__c =:depositPriceBookEntry.Product2Id];
          System.Assert(depositcontractLines.size() > 0 ,'Deposit product: '+depositPriceBookEntry.Name +' expected atleast 1 but found: '+depositcontractLines.size());
      }
   else if (opp.Opportunity_Names__c == 'Conquest Stand-Alone' && opp.Add_Deposit__c == 'Yes'){
          PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','CQ DEPOSIT');
            List<Billing_Item__c> depositcontractLines = [Select Id, LOB__c,Related_POA__c,isBaseAsset__c,Product_Sold__c,Product_Sold__r.Name from Billing_Item__c where Contract__c =: contract.Id
            AND Product_Sold__c =:depositPriceBookEntry.Product2Id];
          System.Assert(depositcontractLines.size() > 0 ,'Deposit product: '+depositPriceBookEntry.Name +' expected atleast 1 but found: '+depositcontractLines.size());
      }

      
      }
            
  }
  

 public  static Contact setupContact(String firstName, String lastName){
         Contact c = new Contact();
        c.FirstName = firstName;
        c.LastName = lastName;
         c.Phone = '234-234-2345';
        insert c;
        return c;
 }   
   
  
 public  static Contact setupContact(){
        Contact c = new Contact();
        c.FirstName = 'TestFirstName';
        c.LastName = 'TestLastName';
        c.Phone = '234-234-2345';
        insert c;
        return c;
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
                Territory_State__c territotyState=
            [select Territory_Manager__c, DDM__c, Account_Manager__c, Regional__c, Implementation_Manager__c,
              Implementation_Specialist__c, Website_Manager__c from Territory_State__c where Name =:  a.ShippingState LIMIT 1];
        
        /*a.Territory_State__c =  territotyState.Id;*/
        
        insert a;
        return a;
    }
    
  public   static Product2 getProduct(String productName){
    
       List<Product2> products = [Select Id, Name from Product2 where Name =: productName and product_BU__c = 'vAuto'];
       if(products== null || products.size() ==0){
           new CoxAutomotiveException('Could not find vAuto Product: '+productName);
       }
       Product2 pr = products[0];
       return pr;
    }
    
    public static  PricebookEntry getPricebookEntry(Product2 p){
        List<PricebookEntry> priceBookEntry = [SELECT Id, Pricebook2Id, UnitPrice, ProductCode, Product2Id, Name FROM PricebookEntry where Pricebook2.Name = 'vAuto 2014' and Product2Id =: p.Id];
    if(priceBookEntry == null || priceBookEntry.size() ==0){
           new CoxAutomotiveException('Could not find entry in Pricebook vAuto 2014 for product '+p.Name);
       }
       
     PricebookEntry pe = priceBookEntry[0];
     return pe;
        
}
    
  public   static OpportunityLineItem  createOppProduct(Opportunity opp, Product2 p){
    
  /*  List<PricebookEntry> priceBookEntry = [SELECT Id, Pricebook2Id, UnitPrice, ProductCode, Product2Id, Name FROM PricebookEntry where Pricebook2.Name = 'vAuto 2014' and Product2Id =: p.Id];
    if(priceBookEntry == null || priceBookEntry.size() ==0){
           new CoxAutomotiveException('Could not find entry in Pricebook vAuto 2014 for product '+p.Name);
       }
       
     PricebookEntry pe = priceBookEntry[0];
     */
         PricebookEntry pe =  getPricebookEntry(p);
        OpportunityLineItem ol = new OpportunityLineItem();
        ol.UnitPrice = pe.UnitPrice;
        ol.Quantity = 1;
        ol.PricebookEntryId = pe.Id;
        ol.OpportunityId = opp.Id;
        //insert ol;   
        return ol;     
    }
    
    public static void setupProvisionOpportunity(Opportunity opp){
    	            opp.Opportunity_Names__c = 'Account Setup';
                  opp.Add_Deposit__c = 'Yes';
                  opp.Deposit_Amount__c = 100.00;
            update opp;
    	      Product2 prod1 = getProduct('Installation Fee');
      Product2 prod2 = getProduct('PriceGuide.BlackBook');
      Product2 prod3 = getProduct('Pricing Tool');
      Product2 prod4 = getProduct('Appraisal Tool');
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);
      OpportunityLineItem  oppLine2 = createOppProduct(opp,prod2);
       OpportunityLineItem  oppLine3 = createOppProduct(opp,prod3);
       OpportunityLineItem  oppLine4 = createOppProduct(opp,prod4);
      List<OpportunityLineItem> oppLines = new List<OpportunityLineItem>();
      oppLines.add(oppLine1);
            oppLines.add(oppLine2);
            oppLines.add(oppLine3);
            oppLines.add(oppLine4);
            insert oppLines;

    }
    
            public static void setupConquestFranchiseSaleOpportunity(Opportunity opp){
        	             opp.Opportunity_Names__c = 'Conquest';
        	              opp.Type = 'Sale';
        	             opp.Conquest_Contact_1__c =     opp.Deal_Contact__c;
        	             opp.Conquest_Contact_1_Makes__c = 'Acura';
        	             opp.Make__c = 'Acura';
        	             
             update opp;
    	      Product2 prod1 = getProduct('Conquest (with Provision Suite)');
      Product2 prod2 = getProduct('Conquest Set Up Fee');
        Product2 prod3 = getProduct('Deposit Conquest');
        Product2 prod4 = getProduct('Conquest Franchise');
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);
      OpportunityLineItem  oppLine2 = createOppProduct(opp,prod2);
      OpportunityLineItem  oppLine3 = createOppProduct(opp,prod3);
      
      OpportunityLineItem  oppLine4 = createOppProduct(opp,prod4);      
      oppLine4.Make__c = 'Acura';
      Contact conquestContact1 = setupContact('TestFirst1','TestLast1');
      oppLine4.Product_Contact__c = conquestContact1.Id;
      
      OpportunityLineItem  oppLine5 = createOppProduct(opp,prod4);
      oppLine5.Make__c = 'Honda';
       oppLine5.Product_Contact__c = setupContact('TestFirst2','TestLast2').Id;
      oppLine5.Product_Contact__c = conquestContact1.Id;
      
      OpportunityLineItem  oppLine6 = createOppProduct(opp,prod4);
      oppLine6.Make__c = 'GMC';
      oppLine6.Product_Contact__c = setupContact('TestFirst3','TestLast3').Id;
      
      List<OpportunityLineItem> oppLines = new List<OpportunityLineItem>();
      oppLines.add(oppLine1);
            oppLines.add(oppLine2);
            //oppLines.add(oppLine3);
            oppLines.add(oppLine4);
            oppLines.add(oppLine5);
            oppLines.add(oppLine6);
            insert oppLines;

             
    }
    
         public static void setupAuctionGeniuswithvAutoandProvisioningClientOpportunity(Opportunity opp){
                       opp.Opportunity_Names__c = 'Auction Genius - With Provision Client';
                        opp.Type = 'Upsell';
                      
                       
             update opp;
            Product2 prod1 = getProduct('AuctionGenius (Base - 1 Auction Platform included)');
    
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);

      
    
      
      List<OpportunityLineItem> oppLines = new List<OpportunityLineItem>();
      oppLines.add(oppLine1);
           
            insert oppLines;

             
    }

            public static void setupConquestStandAloneOpportunity(Opportunity opp){
                       opp.Opportunity_Names__c = 'Conquest Stand-Alone';
                       opp.Add_Deposit__c = 'Yes';
                       opp.Deposit_Amount__c = 100.00;
                       opp.Type = 'Upsell';  
                       opp.Conquest_Contact_1__c =     opp.Deal_Contact__c;
                       opp.Conquest_Contact_1_Makes__c = 'Acura';
                       opp.Make__c = 'Acura';
                       
             update opp;
            Product2 prod1 = getProduct('Conquest (Stand Alone)');
      Product2 prod2 = getProduct('Conquest Set Up Fee');
        //Product2 prod3 = getProduct('AutoWriter');
          Product2 prod4 = getProduct('Conquest Franchise');
          //  Product2 prod5 = getProduct('Merchandising Tool');
        
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);
      OpportunityLineItem  oppLine2 = createOppProduct(opp,prod2);
      //OpportunityLineItem  oppLine3 = createOppProduct(opp,prod3);
      
      
       OpportunityLineItem  oppLine4 = createOppProduct(opp,prod4);      
      oppLine4.Make__c = 'Acura';
      Contact conquestContact1 = setupContact('TestFirst1','TestLast1');
      oppLine4.Product_Contact__c = conquestContact1.Id;

      //OpportunityLineItem  oppLine5 = createOppProduct(opp,prod5);

      List<OpportunityLineItem> oppLines = new List<OpportunityLineItem>();
      oppLines.add(oppLine1);
            oppLines.add(oppLine2);
            //oppLines.add(oppLine3);
            oppLines.add(oppLine4);
            //oppLines.add(oppLine5);
            insert oppLines;

             
    }
    


        public static void setupConquestOpportunity(Opportunity opp){
        	             opp.Opportunity_Names__c = 'Conquest';
                       opp.Add_Deposit__c = 'Yes';
                       opp.Deposit_Amount__c = 100.00;
        	             opp.Type = 'Upsell';  
        	             opp.Conquest_Contact_1__c =     opp.Deal_Contact__c;
        	             opp.Conquest_Contact_1_Makes__c = 'Acura';
        	             opp.Make__c = 'Acura';
        	             
             update opp;
    	      Product2 prod1 = getProduct('Conquest (with Provision Suite)');
      Product2 prod2 = getProduct('Conquest Set Up Fee');
        Product2 prod3 = getProduct('Deposit Conquest');
        
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);
      OpportunityLineItem  oppLine2 = createOppProduct(opp,prod2);
      OpportunityLineItem  oppLine3 = createOppProduct(opp,prod3);
      
      
      List<OpportunityLineItem> oppLines = new List<OpportunityLineItem>();
      oppLines.add(oppLine1);
            oppLines.add(oppLine2);
            //oppLines.add(oppLine3);
            insert oppLines;

             
    }



    

    public static void setupAuctionGeniusOpportunity(Opportunity opp){
                       opp.Opportunity_Names__c = 'Auction Genius - With Provision Client';                       
                       opp.Deposit_Amount__c = 100.00;
                       opp.Type = 'Upsell';  
                       
             update opp;
            Product2 prod1 = getProduct('AuctionGenius (Base - 1 Auction Platform included)');

        
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);
      
      List<OpportunityLineItem> oppLines = new List<OpportunityLineItem>();
      oppLines.add(oppLine1);
            insert oppLines;
             
    }

   public  static Opportunity setupOpportunity(Account a, Contact c,String recordTypeName){
        
        List<RecordType> recordType = [Select Id, Name from RecordType where sObjectType= 'Opportunity' and DeveloperName =: recordTypeName];
         if(recordType == null || recordType .size() ==0){
           new CoxAutomotiveException('Could not find opporunity recordType: '+recordTypeName);
       }
        Opportunity o = new Opportunity ();
        o.Name = 'test'; 
        o.Type = 'Sale';       
        o.CloseDate = System.today();
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;
        o.RecordTypeId = recordType[0].Id;
        o.Deal_Contact__c = c.Id;
        o.Implementation_Contact__c = c.Id;
        o.TNOPPST__Tax_Now_Status__c = 'Sales Tax Current';
        o.ValidationRules__c = true;

           
        insert o;
        return o;
    }
    
       public  static Opportunity setupRemovalOpportunity(Account a, Contact c,String recordTypeName){
        
        List<RecordType> recordType = [Select Id, Name from RecordType where sObjectType= 'Opportunity' and DeveloperName =: recordTypeName];
         if(recordType == null || recordType .size() ==0){
           new CoxAutomotiveException('Could not find opporunity recordType: '+recordTypeName);
       }
        Opportunity o = new Opportunity ();
        o.Name = 'test'; 
        o.Type = 'Remove';       
        o.CloseDate = System.today();
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;
        o.RecordTypeId = recordType[0].Id;
        o.Deal_Contact__c = c.Id;
        o.Implementation_Contact__c = c.Id;
        o.TNOPPST__Tax_Now_Status__c = 'Sales Tax Current';
        o.ValidationRules__c = true;

           
        insert o;
        return o;
    }

        public  static Opportunity setupAUXAccountSetupOpportunity(Account a, Contact c,String recordTypeName){
        
        List<RecordType> recordType = [Select Id, Name from RecordType where sObjectType= 'Opportunity' and DeveloperName =: recordTypeName];
         if(recordType == null || recordType .size() ==0){
           new CoxAutomotiveException('Could not find opporunity recordType: '+recordTypeName);
       }
        Opportunity o = new Opportunity ();
        o.Name = 'test'; 
        o.Type = 'Sale';       
        o.Opportunity_Names__c = 'AUX Account Setup';
        o.CloseDate = System.today();
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;
        o.RecordTypeId = recordType[0].Id;
        o.Deal_Contact__c = c.Id;
        o.Implementation_Contact__c = c.Id;
        o.TNOPPST__Tax_Now_Status__c = 'Sales Tax Current';
        o.ValidationRules__c = true;

           
        insert o;
        return o;
    }
    
   
           public  static Opportunity setupPriceChangesOpportunity(Account a, Contact c,String recordTypeName){
        
        List<RecordType> recordType = [Select Id, Name from RecordType where sObjectType= 'Opportunity' and DeveloperName =: recordTypeName];
         if(recordType == null || recordType .size() ==0){
           new CoxAutomotiveException('Could not find opporunity recordType: '+recordTypeName);
       }
        Opportunity o = new Opportunity ();
        o.Name = 'test'; 
        o.Type = ' Price Changes';       
        o.CloseDate = System.today();
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;
        o.RecordTypeId = recordType[0].Id;
        o.Deal_Contact__c = c.Id;
        o.Implementation_Contact__c = c.Id;
        o.TNOPPST__Tax_Now_Status__c = 'Sales Tax Current';
        o.ValidationRules__c = true;

           
        insert o;
        return o;
    }
    
    
    
  
}