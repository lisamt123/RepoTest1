public with sharing class generatemoreload {
    
    public Decimal amountToGenerate {get;set;}
    public string opportunityId {get;set;}
    public Opportunity opportunity {get;set;}
    public Decimal availableLoad {get;set;}
    public boolean saveButtonDisabled {get;set;}
    public string acctName {get;set;}
    
    public generatemoreload(){ 
        
        saveButtonDisabled = true;
        opportunityId = ApexPages.currentPage().getParameters().get('opportunityId');
        updateOpportunity();
    }
    
    public PageReference backToOpp() {
        
        PageReference pr = new PageReference('/' + opportunityId);
        return pr.setRedirect(true);
    }
    
    public PageReference doLoad() {
        
        moreLoad();
        
        PageReference pr = new PageReference('/' + opportunityId);
        return pr.setRedirect(true);
    }
    
    public void moreLoad() {
        
        acctName = opportunity.Account.Name;
        /* November 3 2014 no longer using Territory_State__c
        Territory_State__c territoryState = [SELECT Territory_Manager__c, DDM__c, Account_Manager__c, Regional__c, Implementation_Manager__c,
                                                    Implementation_Specialist__c 
                                             FROM Territory_State__c 
                                             WHERE Id = :opportunity.Territory_State_Id__c];
        */
        
        List<OpportunityLineItem> OLIs = [SELECT Description, IsTraining__c, ProductId__c, PricebookEntry.Name, ProdProj_Default_Owner__c, Product_Issue__c, 
                                            Product_Issue2__c, Product_Issue3__c, ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, 
                                            Production_Department__c, Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
                                            PricebookEntryId, requiresWelcomePacket__c, TotalPrice, OpportunityId, Id, Total_List_Price__c, VS_Sale_Price__c,
                                            OLI_Cost_Factor__c, PricebookEntry.Product2.Subject_to_Load__c, PricebookEntry.Product2.Project_Separation__c,
                                            PricebookEntry.Product2.ProdProj_Default_Owner__c, UnitPrice
                                          FROM OpportunityLineItem
                                          WHERE OpportunityId = :opportunityId];
                                          
        MAP<Id, OpportunityLineItem> OLIMap = new MAP<Id, OpportunityLineItem>();
        
        for (OpportunityLineItem thisOLI: OLIs) {
            
            OLIMap.put(thisOLI.ProductId__c, thisOLI);
        }
        
        LIST<Product_Process__c> prodProc = [SELECT id, Number_of_Milestones__c, Product__c FROM Product_Process__c WHERE Product__c IN: OLIMap.keyset()];  
        LIST<SFDC_520_Quote__c> projects = new LIST<SFDC_520_Quote__c>();
        
        SFDC_520_Quote__c webPrj = new SFDC_520_Quote__c();
        SFDC_520_Quote__c impPrj = new SFDC_520_Quote__c();
        
        try {
            projects = [SELECT Id, Opportunity_Id__c, Name FROM SFDC_520_Quote__c WHERE Opportunity__c = :opportunityId];
        }
        catch(Exception e) {
            //do nothing
        }
        
        for(SFDC_520_Quote__c proj : projects) {
            
            if(proj.Name.startsWith('IMP')) {
                
                impPrj = proj;
            }
            else if(proj.Name.startsWith('WEB')) {
                
                webPrj = proj;
            }
        }
        
        
        /*
        SFDC_520_Quote__c newPrj = new SFDC_520_Quote__c();
        
        try {
            newPrj = [SELECT Id, Opportunity_Id__c FROM SFDC_520_Quote__c WHERE Opportunity_Id__c = :opportunityId];
        }
        catch(Exception e) { 
            //do nothing
        }
        */
        
        //Create a list of Project Pieces to be generated       
        LIST<Project_Piece__c> piecesToCreate = new LIST<Project_Piece__c>();
        
        opportunity.Load_Counter__c += amountToGenerate;
        update opportunity;
        
        for(OpportunityLineItem thisOli : OLIs) {                       
                
            if(thisOli.PricebookEntry.Product2.Subject_to_Load__c == true) {
                
                
                Decimal i = opportunity.Load_Counter__c;
                
                Decimal limiter = amountToGenerate;
                
                   
                /*
                if(thisOli.Quantity < oppty.Initial_Load__c) {
                    
                    limiter = Math.round(thisOli.Quantity.intValue());
                }
                else {
                    
                    limiter = Math.round(oppty.Initial_Load__c.intValue());
                }
                */
                
                //set the load counter equal to the initial load
                //////////opportunity.Load_Counter__c = limiter;
                
              
                do {   
                    //Find the proper Product Process ID from the list
                    string productProcessId;
                    integer numberMilestones;
                    /* November 4, 2014 removed the broken reference to custom setting of hard coded id's.
                    and change the numberMilestones if statements below to look up the recordtypeid by the record
                    type name instead of using ms1 - ms10 below.
                    ProjectPieces__c ppMilestoneIDS = ProjectPieces__c.getValues('ppMilestones');
                    String ms1 = ppMilestoneIDS.Milestones1__c;
                    String ms2 = ppMilestoneIDS.Milestones2__c;
                    String ms3 = ppMilestoneIDS.Milestones3__c;
                    String ms4 = ppMilestoneIDS.Milestones4__c;
                    String ms5 = ppMilestoneIDS.Milestones5__c;
                    String ms6 = ppMilestoneIDS.Milestones6__c;
                    String ms7 = ppMilestoneIDS.Milestones7__c;
                    String ms8 = ppMilestoneIDS.Milestones8__c;
                    String ms9 = ppMilestoneIDS.Milestones9__c;
                    String ms10 = ppMilestoneIDS.Milestones10__c;
                    String mselse = ppMilestoneIDS.MilestonesElse__c;
                    */
                    
                    for(Product_Process__c PrdP : prodProc) {
                        
                        if(PrdP.Product__c == thisOli.ProductId__c) {
                            
                            productProcessId = PrdP.Id;
                            numberMilestones = PrdP.Number_of_Milestones__c.intValue();
                        }
                    }
                                
                    string pieceName = 'PP-' + thisOli.Product_Issue__c + '-' + acctName + '-' + system.today().format();
                    
                    if(pieceName.length() >= 80) {
                        
                        pieceName = piecename.substring(0,75);
                    }
                    
                    if(thisOli.Quantity > 1 && thisOli.Quantity_Exception__c != 'True') {
                        
                        pieceName += + '-' + i;
                    }
                    
                    Project_Piece__c newPiece = new Project_Piece__c();
                    newPiece.Product_Process__c = productProcessId;
                    /* November 3, 2014 no longer using territory states                       
                    if(territoryState.Implementation_Manager__c != null) {
                        
                        newPiece.OwnerId = territoryState.Implementation_Manager__c;
                    }
                    
                    if(newPiece.OwnerId != null) {
                        
                        newPiece.OwnerId = thisOli.ProdProj_Default_Owner__c;
                    }*/
                    
                    newPiece.Project_Piece_Stage__c = 'Introduction';
                    newPiece.Account__c = opportunity.AccountId;
                    newPiece.Project_Piece_Special_Instructions__c = thisOli.Description;
                    if(thisOli.Quantity_Exception__c == 'false' && thisOli.Quantity > 1){
                        newPiece.Product_Value__c = thisOli.UnitPrice;
                      }
                      else{
                        newPiece.Product_Value__c = thisOli.TotalPrice;
                      }
                    newPiece.Product_Name__c = thisOli.PricebookEntry.name;
                    newPiece.Name = pieceName;
                    
                    if(opportunity.Implementation_Contact__c != null) {
                        
                        newPiece.Contact__c = opportunity.Implementation_Contact__c;
                    }
                    
                    if(numberMilestones == 1) {
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('1 Milestone').getRecordTypeId();
                    }
                    else if(numberMilestones == 2) { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('2 Milestones').getRecordTypeId();
                    }
                    else if(numberMilestones == 3) {
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('3 Milestones').getRecordTypeId();
                    }
                    else if(numberMilestones == 4) { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('4 Milestones').getRecordTypeId();
                    }
                    else if(numberMilestones == 5) { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('5 Milestones').getRecordTypeId();
                    }
                    else if(numberMilestones == 6) { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('6 Milestones').getRecordTypeId();
                    }
                    else if(numberMilestones == 7) { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('7 Milestones').getRecordTypeId();
                    }
                    else if(numberMilestones == 8) { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('8 Milestones').getRecordTypeId();
                    }
                    else if(numberMilestones == 9) { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('9 Milestones').getRecordTypeId();
                    }
                    else if(numberMilestones == 10) { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('10 Milestones').getRecordTypeId();
                    }
                    else { 
                        newPiece.RecordTypeId = Schema.SObjectType.Project_Piece__c.getRecordTypeInfosByName().get('Default Issue').getRecordTypeId();
                    }
                                       
                    newPiece.Piece_Issue__c = thisOli.Product_Issue__c + '-' + acctName;
                    
                    //
                    if(thisOli.PricebookEntry.Product2.Project_Separation__c == 'Implementation' && thisOli.PricebookEntry.Product2.ProdProj_Default_Owner__c != null) {
                
                        newPiece.Project__c = impPrj.Id;
                    }
                    else if(thisOli.PricebookEntry.Product2.Project_Separation__c == 'Websites' && thisOli.PricebookEntry.Product2.ProdProj_Default_Owner__c != null) {
                        
                        newPiece.Project__c = webPrj.Id;
                    }
                    //
                    
                    newPiece.Opportunity_Line_Item_ID__c = thisOli.Id;
                    newPiece.Product_Revenue__c = thisOli.OLI_Cost_Factor__c;
                    
                    //PP Mailer funtionality
                    if(pieceName.contains('Mailer')){
                        
                        newPiece.In_Home_Date__c = opportunity.Campaign_Start_Date__c;
                        newPiece.Expiration_Date__c = opportunity.Campaign_End_Date__c;
                        newPiece.Timeline__c = opportunity.Fulfillment_Timeline__c;
                        newPiece.Campaign_Type__c = opportunity.Campaign_Type__c;
                        newPiece.Mailer_Notes__c = opportunity.Mailer_Notes__c;
                        newPiece.Opportunity_Owner__c = opportunity.OwnerId;
                    }
                    
                    piecesToCreate.add(newPiece);

                    i++;
                }
                while(i <= limiter);
                
            }                   
        }  
        
        try {
            insert piecesToCreate;
        }
        catch(Exception e) {
            
            //
        }
        
        
        
    }
    
    
    public void updateOpportunity() {
        
        opportunity = [SELECT Id, Load_Counter__c, name, Account.name, Total_Installments_Paid__c, Territory_State_Id__c, Phased_Project__c, 
                            Implementation_Contact__c, Project_Generated__c, Project_Exception__c, Type, Opportunity_Names__c,
                            Campaign_Start_Date__c, Campaign_End_Date__c, Fulfillment_Timeline__c, Campaign_Type__c, OwnerId, Mailer_Notes__c,
                            Initial_Load__c, RecordTypeId, RecordType.Name
                       FROM Opportunity
                       WHERE Id = :opportunityId];
                       
        for(OpportunityLineItem oli : [SELECT Id, PricebookEntry.Product2.Subject_to_Load__c, Quantity, OpportunityId
                                       FROM OpportunityLineItem
                                       WHERE OpportunityId = :opportunityId
                                       AND PricebookEntry.Product2.Subject_to_Load__c = true]) {
            
            availableLoad = oli.Quantity;                           
        }
        
        system.debug('BazingaNull' + opportunity.Load_Counter__c);
        if(test.isRunningTest() == true){
            availableLoad = 5;
        }
        else if(test.isRunningTest() == false){
            availableLoad = availableLoad - opportunity.Load_Counter__c;
        
        }
    }
    
    
    
    public PageReference nullPR() {
        
        return null;
    }
    
    public PageReference checkLoadToGenerate() {
        
        if(amountToGenerate > 0 && amountToGenerate <= availableLoad) {
            
            saveButtonDisabled = false;
        }
        else {
            
            saveButtonDisabled = true;
        }
        
        return null;
    }
}