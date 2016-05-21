public abstract class ProjectHandler implements IProjectHandler{
  //context-specific methods
  public virtual void beforeInsert(SFDC_520_Quote__c proj){}
  public virtual void beforeUpdate(SFDC_520_Quote__c newProj, SFDC_520_Quote__c oldProj){}
  public virtual void beforeDelete(SFDC_520_Quote__c proj){}
  public virtual void afterInsert(SFDC_520_Quote__c proj){}
  public virtual void afterUpdate(SFDC_520_Quote__c newProj, SFDC_520_Quote__c oldProj){}
  public virtual void afterDelete(SFDC_520_Quote__c proj){}
  public virtual void afterUndelete(SFDC_520_Quote__c proj){}
  
  
  
  public Map<Id, SFDC_520_Quote__c> CreateProjectsByProjectDefinitions(Opportunity opp,
 OpportunityLineItem[] oppLines,
 Territory_State__c territoryState,
 Map<String,POA__c> poaList, decimal mrr,Map<String,SFDC_520_Quote__c> projectsMapByCategory){  	
  	Map<Id, SFDC_520_Quote__c>  projectsMapByProjectDefinitionId = new Map<Id, SFDC_520_Quote__c>();
  	Map<Id, Project_Definition__c> uniqueProjectDefinitions = new  Map<Id, Project_Definition__c>(); 	

 //list to capture the projectdefinition with higest priority with in each project category
 //so that we can use the project related values like Project_Priority__c and Project_Type__c
 //from project definition with higest priority
  Map<String, Project_Definition__c> projDefByProjCategorywithHighestPriority = new  Map<String, Project_Definition__c>();  


  	//Iterate over opplines and find all the Projects that need to be created as per the Project Definition
  for(OpportunityLineItem oppLine : oppLines) {
  	//Get the project Definition
  	  Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(oppLine.PricebookEntry.Product2.Project_Definition__c);
  	      if(projectDefinition == null){
	         //throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oppLine.PricebookEntry.Product2.Name);	  
 			System.debug('Project Definition is not defined for Product'+oppLine.PricebookEntry.Product2.Name+'; not creating a project');	      
	        continue;   
	    }
  	 
  	  if(projectDefinition.Default_Project_Owner__c == null){
 			System.debug('Project Default_Project_Owner__c  is not defined for Product'+oppLine.PricebookEntry.Product2.Name +'; not creating a project');	      
	        continue;   
	    }
	    
  	 //collect unique project definitions we need to create and also
     //collect Highest priority project defitions per project category
  	if(!uniqueProjectDefinitions.containsKey(projectDefinition.Id)){

  	 	uniqueProjectDefinitions.put(projectDefinition.Id,projectDefinition);

      //set Highest rated Projectdefinition by Project_Category
      //check if there is a Projectdefinition for category
      if(!projDefByProjCategorywithHighestPriority.containsKey(projectDefinition.Project_Category__c)){
        //add it
          projDefByProjCategorywithHighestPriority.put(projectDefinition.Project_Category__c,projectDefinition);
      }
      else{
        
        Project_Definition__c existingProjectDefinition  = projDefByProjCategorywithHighestPriority.get(projectDefinition.Project_Category__c);
        //check if the existing one is of low priority than the current one
        if(existingProjectDefinition.Project_Priority__c < projectDefinition.Project_Priority__c){
          //replace the existing one with current one for the current category
          projDefByProjCategorywithHighestPriority.put(projectDefinition.Project_Category__c,projectDefinition);
        }
        else{
          //ignore since we already have highest priority project definition
        }
      }
  	}
  }
  
  //Create Projects we need to create
  if(projectsMapByCategory == null){projectsMapByCategory= new Map<String,SFDC_520_Quote__c>();}
  for(Id projDefId: uniqueProjectDefinitions.keySet()){
  	
  	Project_Definition__c projDef = uniqueProjectDefinitions.get(projDefId);



  	
  	

  	SFDC_520_Quote__c proj = new SFDC_520_Quote__c();  	
  
    
    //check if the project of the current current category is already created
    //Create only if it does not exists
    if(!projectsMapByCategory.containsKey(projDef.Project_Category__c)){
  	if(projDef.Project_Category__c == 'Implementation'
  	|| projDef.Project_Category__c == 'IMP'){  	  		
  		proj =InitializeImplementationProject(opp,
			 oppLines,
			 territoryState,
			 mrr,
			 proj);
  		projectsMapByProjectDefinitionId.put(projDef.Id,proj);
  		projectsMapByCategory.put(projDef.Project_Category__c, proj);
  	}
  	else if(projDef.Project_Category__c == 'Websites'
  	|| projDef.Project_Category__c == 'WEB'){  
  		proj = InitializeWebSitesProject(opp,
			 oppLines,
			 territoryState,
			 mrr,
			 proj);		
  		projectsMapByProjectDefinitionId.put(projDef.Id,proj);
  		projectsMapByCategory.put(projDef.Project_Category__c, proj);
  	}
  	else {
     // for everything else create a Implmentation project  	  		
  		proj =InitializeImplementationProject(opp,
			 oppLines,
			 territoryState,
			 mrr,
			 proj);
  		projectsMapByProjectDefinitionId.put(projDef.Id,proj);
  		projectsMapByCategory.put(projDef.Project_Category__c, proj);
  	}
  	//else{
  	//	throw new CoxAutomotiveException('Project Definition ProjectCategory is not valid  for  Project Definition: '+projDef.Name);
  	//}

    //Set the project Name and Project_Name__c
    //• For Hay and Vin, Project Identifier and Project Name should be: 
    //[Project_Definition__c.Project_Short_Code__c]-[Account Name]-["New" if Opportunity.Type is "New Business", "Upsell" if Opportunity.Type is "Upsell" or "Existing Business"]-[Opportunity.Opportunity_Names__c]
    //(restrict Account Name to 41 characters)

    //Ramana: There might be better ways to help user identify project instead of this naming format
    //which could easily exceed max 80 char; like showing the account Name..ect where ever projects are displayed so that user
    //will know which account they belong to..etc
    
    String projectName = '';
    if(opp.Account.Name.length() > 41){
     projectName = projDef.Project_Short_Code__c+'-'+opp.Account.Name.substring(0,41);
    }
    else{
       projectName = projDef.Project_Short_Code__c+'-'+opp.Account.Name;
    }
    /* removed as per Maggie
    if(opp.Type == 'New Business'){
      projectName += '-New';
    }else if(opp.Type == 'Upsell'){ 
      projectName += '-Upsell';
    }else{
      projectName += '-Existing Business';
    }
    projectName += '-'+opp.Opportunity_Names__c;
*/


    //If length exceeds 80; try to take the excceded char count from account Name
    if(projectName.length() >= 80){
      try{
      Integer exceededCharCount =  projectName.length() - 80;
      if(opp.Account.Name.length() > 41){
          projectName = projDef.Project_Short_Code__c+'-'+opp.Account.Name.substring(0,41-exceededCharCount);
        }
        else{
           projectName = projDef.Project_Short_Code__c+'-'+opp.Account.Name.substring(0,opp.Account.Name.length() - exceededCharCount);
        }
      }
      Catch(Exception ex){
        //Being cautious
        //For some reason there is a error while trying to get the right split;
        //it is not end of the world; let's continue by truncating from the end;
        //Users can still have an option to change the name; instead of erroring out on 
        //project creation all together;
      }
    }

    //Ramana:: Catch to make sure not to cross max 80 char limit.
    //if the project name still exceeds 80 max length
    if(projectName.length() >= 80){
      //get only the first 80 char.
      projectName = projectName.substring(0,79);
      
    }


    proj.Name = projectName;
    proj.Project_Name__c = projectName;
    
    //Now update the Project recordtype and Project_Type2__c with values from 
    //project definition with Highest priority values
    Project_Definition__c highestPriorityProjDef = projDefByProjCategorywithHighestPriority.get(projDef.Project_Category__c);

    if(poaList.get(highestPriorityProjDef.POA_Type__c) == null){
    System.Debug('NO POA is assigned to the project having ProjectDefinition Name: '+highestPriorityProjDef.Name);
    }
    else{     
    proj.Related_POA__c = poaList.get(highestPriorityProjDef.POA_Type__c).Id;
    }
    proj.OwnerId = highestPriorityProjDef.Default_Project_Owner__c;

    //get the project record type from Highest priority project definition with in a category
    RecordType projRecType = StaticData.getInstance().ProjectRecTypesMapByName.get(highestPriorityProjDef.Project_Record_Type__c);
    if(projRecType == null){
      throw new CoxAutomotiveException('Project Definition ProjectRecordType is not valid  for Project Definition: '+highestPriorityProjDef.Name);
    }   
    proj.RecordTypeId = projRecType.Id;
    proj.Project_Type2__c = highestPriorityProjDef.Project_Type__c;
    proj.Project_Category__c = highestPriorityProjDef.Id;

    }else{
    	//If already created use the existing one
    	projectsMapByProjectDefinitionId.put(projDef.Id,projectsMapByCategory.get(projDef.Project_Category__c));
    }
  	
  }
  
  	

  	return projectsMapByProjectDefinitionId;
  	
  }
  
  public SFDC_520_Quote__c InitializeImplementationProject(Opportunity opp,
 OpportunityLineItem[] oppLines,
 Territory_State__c territoryState,
 decimal mrr,
 SFDC_520_Quote__c project){ 
  	 Date endDate;
    //String projectType = 'Log SFDC Issue to Update';
    
    if(opp.Name.contains('CRM')){                
    endDate = system.today()+30;
    }
    else if(opp.Name.contains('ILM')) {
    
    endDate = system.today()+20;
    }
    else if(opp.Name.contains('Inventory')) {
    
    endDate = system.today()+10;
    }
    else {                
    endDate = system.today()+30;
    }
      project.Go_Live_Date__c = endDate;  	
       decimal impSUM = 0;
    system.debug('BAM1' + mrr);
    if(mrr > 0){
    if(opp.Project_Exception__c == false){
    List<AggregateResult> groupedResults = [SELECT SUM(TotalPrice) sumTP FROM OpportunityLineItem WHERE OpportunityId =: opp.Id AND Product_Separation__c = 'Implementation' AND One_Time_Fee__c = false AND Setup_Fee__c = false];
    
    if(groupedResults.size() > 0){
    String str = '' + groupedResults[0].get('sumTP');
    if(str=='' || str == null || str == 'null'){
      impSum = 0.0;
      }else{
      try{
      impSum = Decimal.valueOf(str);
      }catch(Exception e){
         throw new CoxAutomotiveException('Could not convert value to decimal:'+str+';Error: '+ e.getMessage());
      }
      }
    }
    }
    }
    
    project.Account__c = opp.AccountId;
    project.Opportunity__c = opp.Id;
    project.Project_Worth__c = impSum;
    project.Implementation_Notes__c = opp.Description;
    if(opp.Name.length() > 100) {    
    project.Project_Name__c = opp.Name.substring(0,97) + '...';
    }
    else {    
    project.Project_Name__c = opp.Name;  
    }
    
    project.Approval_Stage__c = 'Introduction';
    project.Contact__c = opp.Deal_Contact__c;  
    project.Training_Included__c = false;
    project.Training_Expenses_Paid_by_Dealer__c = false;
    project.Project_Type__c = opp.Opportunity_Names__c; 
    if(opp.Implementation_Contact__c != null) {    
    project.Contact__c = opp.Implementation_Contact__c;
    } 
    
   
    return project;
  } 
  
  public SFDC_520_Quote__c InitializeWebSitesProject(Opportunity opp,
 OpportunityLineItem[] oppLines,
 Territory_State__c territoryState,
 decimal mrr
 ,SFDC_520_Quote__c project){
	        Date endDate;
	        String projectType = 'Website';
	        
	        if(opp.Name.contains('CRM')) {
	        	
	            endDate = system.today()+30;
	        }
	        else if(opp.Name.contains('ILM')) {
	        	
	            endDate = system.today()+20;
	        }
	        else if(opp.Name.contains('DIY')) {
	            
	            endDate = system.today()+10;
	        }
	        else {
	            
	            endDate = system.today()+30;
	        }
	        project.Go_Live_Date__c = endDate;
	        
	        if(opp.Opportunity_Names__c != null){
	        	
	        	if(opp.Opportunity_Names__c == 'Hardware'){
	        		projectType = 'Hardware';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Add On'){
	        		projectType = 'Add On';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Advanced Inventory with MPT' || opp.Opportunity_Names__c == 'Advanced Inventory'){
	        		projectType = 'Inventory Module';
	        	}
	        	else if(opp.Opportunity_Names__c == 'CRM' ||
	        			opp.Opportunity_Names__c == 'CRM Plus Desking' ||
	        			opp.Opportunity_Names__c == 'CRM Plus MPT' ||
	        			opp.Opportunity_Names__c == 'CRM Premier' ||
	        			opp.Opportunity_Names__c == 'CRM Pro'){
	        		projectType = 'CRM';			
	        	}
	        	else if(opp.Opportunity_Names__c == 'ILM' ||
	        			opp.Opportunity_Names__c == 'ILM with MPT'){
	        		projectType = 'ILM';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Digital Marketing Package'){
	        		projectType = 'Digital Marketing';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Fulfillment'){
	        		projectType = 'Fulfillment';
	        	}
	        	else if(opp.Opportunity_Names__c.contains('Training')){
	        		projectType = 'Training';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Website - Kore 360' ||
	        		    opp.Opportunity_Names__c == 'Website' ||
	        		    opp.Opportunity_Names__c == 'Website - Vin Advanced'){
	        		projectType = 'Website';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Printed Materials'){
	        		projectType = 'Printed Materials';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Fulfillment Coop'){
	        		projectType = 'Fulfillment Coop';
	        	}
	        	else if(opp.Opportunity_Names__c == 'OEM Website'){
	        		projectType = 'OEM Website';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Product Swap'){
	        		projectType = 'Product Swap';
	        	}
	        	else if(opp.Opportunity_Names__c == 'Haystak DM'){
	        		projectType = 'Haystak DM';
	        	}
	        	else{
	        		projectType = 'Log SFDC Issue to Update';
	        	}
	        }
	        	        
	        if(Opp.Account.Name.length() > 66) {
	        	
	        	project.Name = 'WEB-' + Opp.Account.Name.substring(0,63);
	        }
	        else {
	        	
	        	project.Name = 'WEB-' + Opp.Account.Name;	
	        }
	        
	        project.Account__c = opp.AccountId;
	        project.Opportunity__c = opp.Id;
	        project.Project_Name__c = opp.Name;
	        project.Approval_Stage__c = 'Introduction';
	        project.Contact__c = opp.Deal_Contact__c;      
	        project.Training_Included__c = false;
	        project.Training_Expenses_Paid_by_Dealer__c = false;	        
	        Assigned_Users__c wOwner = Assigned_Users__c.getValues('DefaultWebsiteProjectOwner');
	        String wOwnerId = wOwner.Who_ID__c;
	        Assigned_Users__c hOwner = Assigned_Users__c.getValues('DefaultHaystakProjectOwner');
	        String hOwnerId = hOwner.Who_ID__c;
	        
	        if(opp.Opportunity_Names__c == 'OEM Website') {
	        	project.Project_Type__c = 'OEM Website';
	        }
	        else if(opp.Opportunity_Names__c == 'Printed Materials') {
	        	project.Project_Type__c = 'Printed Materials';
	        }
	        else {
	        	project.Project_Type__c = projectType;
	        }
	        
	        if(opp.Implementation_Contact__c != null) {
	        	
	        	project.Contact__c = opp.Implementation_Contact__c;
	        }
       
	       
	        return project;      
	      
  }
  
  
public virtual LIST<Project_Piece__c> CreateProjectPieces(Opportunity opp,OpportunityLineItem[] oppLines,
Map<Id, SFDC_520_Quote__c> projectsMapByProjectDefinitionId,
Product_Process__c[] prodProc,
Territory_State__c territoryState){ 
	Map<String,RecordType> projectPieceRecordTypes = StaticData.getInstance().ProjectPiecesRecTypesMapByDevName;
    LIST<Project_Piece__c> piecesToCreate = new LIST<Project_Piece__c>();
    for(OpportunityLineItem oppLine: oppLines) {    
    	  System.debug('Processing Project Peices for Product'+oppLine.PricebookEntry.Product2.Name);
    	  Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(oppLine.PricebookEntry.Product2.Project_Definition__c);
  	      if(projectDefinition == null){
	         //throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oppLine.PricebookEntry.Product2.Name);
	         System.debug('Project Definition is not defined for Product'+oppLine.PricebookEntry.Product2.Name);	      
	         continue;
	    }
    if(projectDefinition.Default_Project_Owner__c != null) {    
    integer i = 1;    
    if(oppLine.Quantity_Exception__c == 'True') {    
    i = Math.round(oppLine.Quantity.intValue());
    }
    
    do {   
    //Find the proper Product Process ID from the list
    string productProcessId;
    integer numberMilestones;    
    for(Product_Process__c PrdP : prodProc) {    
    if(PrdP.Product__c == oppLine.ProductId__c) {    
    productProcessId = PrdP.Id;
    numberMilestones = PrdP.Number_of_Milestones__c.intValue();
    }
    }
    
    //name = 80 field length
    string pieceName = 'PA-' + oppLine.Product_Issue__c + '-' + opp.Account.Name;
    
    if(pieceName.length() >= 66) {    
    pieceName = piecename.substring(0,65);
    }
    //add created date at the end of the line
    //this will take additional 10 places in name
    pieceName +='-' + system.today().format();
    //remaoning 5 places for if there are any numbering.
    if(oppLine.Quantity > 1 && oppLine.Quantity_Exception__c != 'True') {    
    pieceName += '-' + i;
    }
    Project_Piece__c newPiece = new Project_Piece__c();
    newPiece.Product_Process__c = productProcessId;    
    /*if(territoryState.Implementation_Manager__c != null) {    
    newPiece.OwnerId = territoryState.Implementation_Manager__c;
    }    
    if(newPiece.OwnerId != null) {    
    newPiece.OwnerId = oppLine.ProdProj_Default_Owner__c;
    }*/
    newPiece.OwnerId = projectDefinition.Default_Project_Owner__c;
    newPiece.Project_Piece_Stage__c = 'Pending';
    newPiece.Account__c = opp.AccountId;
    newPiece.Project_Piece_Special_Instructions__c = oppLine.Description;
    if(oppLine.Quantity_Exception__c == 'false' && oppLine.Quantity > 1){
      newPiece.Product_Value__c = oppLine.UnitPrice;
    }
    else{
      newPiece.Product_Value__c = oppLine.TotalPrice;
    }
    newPiece.Product_Name__c = oppLine.PricebookEntry.name;
    newPiece.Product_Make__c = oppLine.Make__c;
    newPiece.Name = pieceName;    
    if(opp.Implementation_Contact__c != null) {    
    newPiece.Contact__c = opp.Implementation_Contact__c;
    }    
    if(numberMilestones == 1) {    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X1_Milestone').Id;
    }
    else if(numberMilestones == 2) { 
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X2_Milestones').Id;
    }
    else if(numberMilestones == 3) {
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X3_Milestones').Id;
    }
    else if(numberMilestones == 4) { 
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X4_Milestones').Id;
    }
    else if(numberMilestones == 5) { 
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X5_Milestones').Id;
    }
    else if(numberMilestones == 6) { 
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X6_Milestones').Id;
    }
    else if(numberMilestones == 7) { 
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X7_Milestones').Id;
    }
    else if(numberMilestones == 8) { 
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X8_Milestones').Id;
    }
    else if(numberMilestones == 9) { 
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X9_Milestones').Id;
    }
    else if(numberMilestones == 10) { 
    
    newPiece.RecordTypeId = projectPieceRecordTypes.get('X10_Milestones').Id;
    }
    else { 
    newPiece.RecordTypeId = projectPieceRecordTypes.get('Default_Issue').Id;
    
    }
    
    string pieceIssue = oppLine.Product_Issue__c + '-' + opp.Account.Name;
    
    if(pieceIssue.length() > 100) {
    
    newPiece.Piece_Issue__c = pieceIssue.substring(0, 97) + '...';
    }
    else {
    
    newPiece.Piece_Issue__c = pieceIssue;   
    }
    
    //find the project using the ProjectDefinition and Project Maps
    SFDC_520_Quote__c project = projectsMapByProjectDefinitionId.get(oppLine.PricebookEntry.Product2.Project_Definition__c);
    if(project == null){
    throw new CoxAutomotiveException('Could not find the project for Product: '+oppLine.PricebookEntry.Product2.Name+' to assign project pieces');
    }
    
    newPiece.Project__c = project.Id;
    newPiece.Opportunity_Line_Item_ID__c = oppLine.Id;    
    newPiece.Product_Revenue__c = oppLine.OLI_Cost_Factor__c;    
    //PP Mailer funtionality
    if(pieceName.contains('Mailer')){
    
    newPiece.In_Home_Date__c = opp.Campaign_Start_Date__c;
    newPiece.Expiration_Date__c = opp.Campaign_End_Date__c;
    newPiece.Timeline__c = opp.Fulfillment_Timeline__c;
    newPiece.Campaign_Type__c = opp.Campaign_Type__c;
    newPiece.Mailer_Notes__c = opp.Mailer_Notes__c;    
    newPiece.Opportunity_Owner__c = opp.OwnerId;
    }
    piecesToCreate.add(newPiece);
    i++;
    }
    while(i<=oppLine.Quantity);             
    }       
    }
    
    return piecesToCreate;
}

}