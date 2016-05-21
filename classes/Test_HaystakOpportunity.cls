@isTest(SeeAllData=true)  
public with sharing class Test_HaystakOpportunity { 
    

      static testMethod void closedOwn_ProjectName_LongAccountName() {
  
      Contact cont =  setupContact();
      Account acct = setupAccount();
      //update the acct Name to be more than 100;
      acct.Name  = TestData.generateRandomString(80);
      update acct;      
      Opportunity opp= setupOpportunity(acct, cont, 'Digital_Marketing');
      
      Product2 prod1 = getProduct('Kore360 Pro Package');
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);    
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
      ValidateOpportunity(opp);
      ValidateProject(opp);
      ValidatePOA(opp);
      ValidateContract(opp);  
      
  }


  static testMethod void closedOwn() {
  
      Contact cont =  setupContact();
      Account acct = setupAccount();
      Opportunity opp= setupOpportunity(acct, cont, 'Digital_Marketing');
      
      Product2 prod1 = getProduct('Kore360 Pro Package');
      OpportunityLineItem  oppLine1 = createOppProduct(opp,prod1);    
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
      ValidateOpportunity(opp);
      ValidateProject(opp);
      ValidatePOA(opp);
      ValidateContract(opp);  
      
  }
  static void ValidateOpportunity(Opportunity Opp){
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
            
  }
  static void ValidateProject(Opportunity opp){
      //Validate Project Exists
      
         List<OpportunityLineItem> oppLines = [Select PricebookEntry.Product2.Project_Definition__c,
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
	    
 Map<String, Project_Definition__c> uniqueProjectCategories = new  Map<String, Project_Definition__c>(); 
  	//Iterate over opplines and find all the Projects that need to be created as per the Project Definition
  for(OpportunityLineItem oppLine : oppLines) {
  	//Get the project Definition
  	  Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(oppLine.PricebookEntry.Product2.Project_Definition__c);
  	      if(projectDefinition == null){
	         throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oppLine.PricebookEntry.Product2.Name);	      
	    }
  	 
  	  	 //collect kinds of project we need to create  	 
  	 if(!uniqueProjectCategories.containsKey(projectDefinition.Project_Category__c)){
  	 	uniqueProjectCategories.put(projectDefinition.Project_Category__c,projectDefinition);
  	 }
  }
        boolean webProjectGenerated = false;
    boolean impProjectGenerated = false;
    
    for(String projectCategory : uniqueProjectCategories.keySet()){
      if( projectCategory == 'Implementation'
    || projectCategory == 'IMP'){ impProjectGenerated = true;}
    if( projectCategory == 'Websites'
    || projectCategory == 'WEB'){ webProjectGenerated = true;}  
    } 
      List<SFDC_520_Quote__c> projects = [Select Id
      ,Approval_Stage__c 
      ,RecordTypeId
      ,Related_POA__c
      ,Project_Name__c
      ,Name
      ,Web_Project_Generated__c
      , Implementation_Included__c 
      ,Has_Recurring_Products__c
      ,Project_Type2__c
      ,Projects_Generated_by_Opp__c
      ,Website_Custom__c
      from SFDC_520_Quote__c where Opportunity__c  =: opp.Id];
      
      System.AssertNotEquals(projects,NULL,'No Projects got created');
      System.Assert(projects.size()> 0,'No Projects got created');
      //check if all configured projects are created      
      System.Assert(projects.size()== uniqueProjectCategories.size(),'Configured projects count and Created projects count do not match');
      

for(SFDC_520_Quote__c project : projects) {
  
  system.assert(project.Approval_Stage__c == 'Introduction','Projects are not set with Integration stage');
    system.assert(project.Web_Project_Generated__c == webProjectGenerated,'Web Project generated flag is not correct');
    system.assert(project.Implementation_Included__c ==impProjectGenerated,'Implementation Project generated flag is not correct');

    system.assert(project.Projects_Generated_by_Opp__c !='','Projects_Generated_by_Opp__c is empty');

    system.assert(project.Project_Type2__c !=null,'Project_Type2__c is empty');
    system.assert(project.Project_Type2__c !='','Project_Type2__c is empty');
    /* Removed as per Maggie, no longer adding these at the end of the name with code
      if(opp.Type == 'New Business'){
        system.assert(project.Name.contains('-New'),'Project Name format not correct');
    }
    else if(opp.Type == 'Upsell'){
system.assert(project.Name.contains('-Upsell'),'Project Name format not correct');
    }
    else{
      system.assert(project.Name.contains('-Existing Business'),'Project Name format not correct');

    }
*/
    ValidateProjectPieces(project);
   }
   }
   static void ValidateProjectPieces(SFDC_520_Quote__c project){
      //Validate Project Pieces      
      List<Project_Piece__c> projectPieces = [Select Id,  Project_Piece_Stage__c ,RecordTypeId 
        ,Product_Family__c
       , Product_Name__c
      from Project_Piece__c      
       where Project__c =: project.Id];
       System.AssertNotEquals(projectPieces ,NULL,'No Project Pieces got created');
      Map<String,RecordType> projectPieceRecordTypes = new   Map<String,RecordType>();
  for(RecordType recType : [SELECT Description, Name, NamespacePrefix, Id, DeveloperName FROM RecordType
where IsActive = true
and SobjectType = 'Project_Piece__c']){
    projectPieceRecordTypes.put(recType.Name,recType);       
}     

    for(Project_Piece__c piece : projectPieces ){
          if(piece.Product_Family__c != null && piece.Product_Family__c.contains('Reoccuring')){
            System.assert(project.Has_Recurring_Products__c,'Reocurring flag is not set on the project');
          }
           if(piece.Product_Name__c != null && piece.Product_Name__c.contains('Website')){
            System.assert(project.Website_Custom__c,'Website_Custom__c flag is not set on the project');
           }
         System.AssertEquals(piece.Project_Piece_Stage__c ,'Pending','Project Piece is not set to Pending Stage');
         System.Assert(piece.RecordTypeId != StaticData.getInstance().ProjectPiecesRecTypesMapByDevName.get('vAuto').Id,'Recoredtype is not corerct');
    }
      
  }
  
    static void ValidatePOA(Opportunity opp){
  
    
      //Validate POA Exists
        List<OpportunityLineItem> oppLines = [Select PricebookEntry.Product2.Project_Definition__c,
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
	    
	    List<Id> poaList = new List<Id>();
	    for(OpportunityLineItem oli: oppLines){
	    	
	    	try{
	    	      	//Get the project Definition
  	  Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(oli.PricebookEntry.Product2.Project_Definition__c);
  	      if(projectDefinition == null){
	         throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oli.PricebookEntry.Product2.Name);	      
	    }
	    
	    if(projectDefinition.POA_Type__c != null && projectDefinition.POA_Type__c.trim() !=''){
	    	RecordType poaRecType = StaticData.getInstance().POARecTypesMapByName.get(projectDefinition.POA_Type__c);
	    	
    if(poaRecType != null){
	    poaList.add(poaRecType.Id);
    	}
	    
	    }
	    	}
	    	catch(Exception ex){
	    		UtilityClass.DebugException(ex);
	    		
	    	}     	
	    }
	    
	    if(poaList.size() > 0){
	   List<POA__c> p = [Select Id from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId IN: poaList and status__c !=: 'Churned'];
	   System.Assert(p!=null,'NO POA records created');
	   System.Assert(p.size()>0 ,'NO POA records created');
	    }
	 
  }
    static void ValidateContract(Opportunity opp){
      //Validate Contract Exists
      List<Contract> contracts = [Select Id,Related_Opportunity__c  from Contract where Related_Opportunity__c  =: opp.Id];
            System.AssertNotEquals(contracts,NULL,'No Contracs got created');
      System.Assert(contracts.size()> 0,'No Contracts got created');
      
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
          List<Billing_Item__c> contractLines = [Select Id, LOB__c,Related_POA__c,isBaseAsset__c from Billing_Item__c where Contract__c =: contracts[0].Id];
                   System.AssertNotEquals(contractLines ,NULL,'No Contracs Lines got created');
      System.Assert(contractLines .size()> 0,'No Contract Lines got created');    
      
            
  }
  
  static Contact setupContact(){
        Contact c = new Contact();
        c.FirstName = 'TestFirstName';
        c.LastName = 'TestLastName';
        c.Phone = '234-234-2345';
        insert c;
        return c;
  }
  
      static Account setupAccount(){ 
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
    
    static Product2 getProduct(String productName){
    
       List<Product2> products = [Select Id, Name from Product2 where Name =: productName];
       if(products== null || products.size() ==0){
           new CoxAutomotiveException('Could not find vAuto Product: '+productName);
       }
       Product2 pr = products[0];
       return pr;
    }
    
    static OpportunityLineItem  createOppProduct(Opportunity opp, Product2 p){
    
    List<PricebookEntry> priceBookEntry = [SELECT Id, Pricebook2Id, UnitPrice, ProductCode, Product2Id, Name FROM PricebookEntry where Pricebook2.Name = '2014 Standard Price Book' and Product2Id =: p.Id];
    if(priceBookEntry == null || priceBookEntry.size() ==0){
         throw  new CoxAutomotiveException('Could not find entry in Pricebook 2014 Standard Price Book for product '+p.Name);
       }
       
     PricebookEntry pe = priceBookEntry[0];
        
        OpportunityLineItem ol = new OpportunityLineItem();
        ol.UnitPrice = pe.UnitPrice;
        ol.Quantity = 1;
        ol.PricebookEntryId = pe.Id;
        ol.OpportunityId = opp.Id;
        //insert ol;   
        return ol;     
    }
    
    static Opportunity setupOpportunity(Account a, Contact c,String recordTypeName){
        
         
      RecordType recordType = StaticData.getInstance().OpportunityRecTypesMapByDevName.get(recordTypeName);
        if(recordType == null){
         throw  new CoxAutomotiveException('Could not find opporunity recordType: '+recordTypeName);
         }
        Opportunity o = new Opportunity ();
        o.Name = 'test'; 
        o.Type = 'Sale';
        o.Opportunity_Names__c = 'Account Setup';
        o.CloseDate = System.today();
        o.StageName = 'Prospecting';
        o.AccountId = a.Id;
        o.RecordTypeId = recordType.Id;
        o.Deal_Contact__c = c.Id;
        o.Implementation_Contact__c = c.Id;
        o.TNOPPST__Tax_Now_Status__c = 'Sales Tax Current';
        o.ValidationRules__c = true;
        o.Website__c = 'www.test.com';
        o.Type = 'Type';
        o.Products_of_Interest__c = 'Haystak Custom';
        
        insert o;
        
        //Competition__c
        Competition__c competition = new Competition__c();
        competition.Name = 'Compe'+ Datetime.now().format('MMMMdyyyyhhss');
        competition.Who__c = 'AAX';
        competition.Product_Line__c = 'CRM';
        competition.Why_Won_Lost__c = 'No Interest in Change';
        competition.Opportunity__c = o.Id;
        insert competition;
        
        return o;
    }
    
  
}