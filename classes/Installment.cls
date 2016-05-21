public with sharing class Installment {
    
  /*public static void updateProjectWorth(Opportunity oppty, OpportunityLineItem[] OLIs){
    
    boolean updateImpPW = false;
    boolean updateWebPW = false;
    
    for(OpportunityLineItem oli : OLIs){
      
      if(oli.PricebookEntry.Product2.Project_Separation__c == 'Implementation' && oli.PricebookEntry.Product2.ProdProj_Default_Owner__c != null){
        updateImpPW = true;
        system.debug('BAM IMP' + updateImpPW);
      }
      else if(oli.PricebookEntry.Product2.Project_Separation__c == 'Websites' && oli.PricebookEntry.Product2.ProdProj_Default_Owner__c != null){
        updateWebPW = true;
        system.debug('BAM WEB' + updateWebPW);
      }
    }
    
    if(updateImpPW == true){
      
      SFDC_520_Quote__c projImpProjectWorth = [SELECT Project_Worth__c FROM SFDC_520_Quote__c WHERE Type_Of_Project__c = 'IMP' AND OppId18__c =: oppty.Id];
      
        List<AggregateResult> groupedResults = [SELECT SUM(TotalPrice) sumTP FROM OpportunityLineItem WHERE OpportunityId =: oppty.Id AND Product_Separation__c = 'Implementation' AND One_Time_Fee__c = false AND Setup_Fee__c = false];
           decimal impSUM = 0;
           if(groupedResults.size() > 0 ){
             String str = '' + groupedResults[0].get('sumTP');
             impSum = Decimal.valueOf(str);
             system.Debug('Shrewsbury   ' + impSum);
             system.Debug('Shrewsbury   ' + oppty.Id);
             
             projImpProjectWorth.Project_Worth__c = impSum;
             
           }
           
           update projImpProjectWorth;
    }
    
    if(updateWebPW == true){
      
      //Grab the Websites Project that needs to be updated
      SFDC_520_Quote__c projWebProjectWorth = [SELECT Project_Worth__c FROM SFDC_520_Quote__c WHERE Type_Of_Project__c = 'WEB' AND OppId18__c =: oppty.Id];
      //Get the aggregate result of the new OLIs in order to update the Project Worth
      List<AggregateResult> groupedResultsWeb = [SELECT SUM(TotalPrice) sumTPP FROM OpportunityLineItem WHERE OpportunityId =: oppty.Id AND Product_Separation__c = 'Websites' AND One_Time_Fee__c = false AND Setup_Fee__c = false];
      decimal webSum = 0;
      if(groupedResultsWeb.size() > 0){
        String str1 = '' + groupedResultsWeb[0].get('sumTPP');
        webSum = Decimal.valueOf(str1);
        
        projWebProjectWorth.Project_Worth__c = webSum;
      }
      
      update projWebProjectWorth;
      
    }
    
  }*/

    public static void UpdateOpportunityPaidInstallments(Installment__c Ins, boolean firstPayment, Opportunity oppty, 
                             Installment__c[] relatedInstallments, OpportunityLineItem[] OLIs, 
                             Product_Process__c[] prodProc, Territory_State__c territoryState) {
  
    Integer paidInstallments = 0;
    double amountPaid = 0;
    string acctName = oppty.Account.Name;
    system.debug('Bazinga related installments.size()' + relatedInstallments.size());
    
    for(Installment__c instmts : relatedInstallments){
      paidInstallments += 1;
      if(instmts.Installment_Amount__c != null){
        amountPaid += instmts.Installment_Amount__c;
      }
    }
    oppty.Total_Installment_Amounts_Paid__c = amountPaid;
    oppty.Total_Installments_Paid__c = paidInstallments;
    //If no related installments exist then mark the Opportunity's Installments Generated false
    if(relatedInstallments.size() == 0){
      oppty.InstallmentsGenerated__c = false;
    }                             
    
    system.debug('Bazinga.... Update 1.. paidInstallments: ' + paidInstallments);
    system.debug('Bazinga.... Update 2.. firstPayment: ' + firstPayment);
    system.debug('Bazinga.... Update 3.. oppty.Project_Generated__c: ' + oppty.Project_Generated__c);
    system.debug('Bazinga.... Update 4.. oppty.Project_Exception__c: ' + oppty.Project_Exception__c);
        system.debug('Bazinga.... Update 5.. Ins.Confirmed__c: ' + Ins.Confirmed__c);
        system.debug('Bazinga.... Update 6.. Ins.Paid__c: ' + Ins.Paid__c);
        if(Ins.Paid__c != null){
          oppty.Paid__c = 'Yes';
        }
        /////redo from here
        /*if(paidInstallments == 1 && oppty.Project_Exception__c == false && Ins.Confirmed__c == true && oppty.Project_Generated__c == false){
          if(oppty.RecordTypeId != '01270000000Q9Me' && Ins.Confirmed__c == true && oppty.Project_Generated__c == false){
            GenerateProjectAndPieces(Ins, oppty, acctName, OLIs, prodProc, territoryState);  
            
            if(Ins.Confirmed__c == true){
              oppty.Project_Generated__c = true;
              oppty.Paid_Date__c = Ins.Paid__c;
              oppty.Confirmed__c = 'Yes';
            }
            if(oppty.Type == 'New Business'){
              updateAccountForNewCustomer(oppty.Id);
            }
            
          }
          else if(oppty.RecordTypeId == '01270000000Q9Me'){
            GenerateProjectAndPiecesTier1Tier2(Ins, oppty, acctName, OLIs, prodProc, territoryState);
            
            if(Ins.Confirmed__c != null){
              oppty.Paid_Date__c = Ins.Paid__c;
              oppty.PAID__c = 'Yes';
            }
            if(oppty.Type == 'New Business'){
              updateAccountForNewCustomerT1T2(oppty.Id);
            }
            if(Ins.Paid__c != null){
              oppty.Paid__c = 'Yes';
            }
          }
        }*/
      if(paidInstallments == 1 && oppty.Project_Exception__c == false && oppty.Project_Generated__c == false){
      if(oppty.RecordTypeId != '01270000000Q9Me'){
        if(Ins.Confirmed__c == true){
          GenerateProjectAndPieces(Ins, oppty, acctName, OLIs, prodProc, territoryState);
          oppty.Project_Generated__c = true;
          oppty.Confirmed__c = 'Yes';
        }
        if(oppty.Type == 'New Business'){
          updateAccountForNewCustomer(oppty.Id);
        }
        if(Ins.Paid__c != null){
          oppty.Paid__c = 'Yes';
        }
        if(Ins.Confirmed__c != null){
          //oppty.Project_Generated__c = true;
          oppty.Paid_Date__c = Ins.Paid__c;
          
        }
      
      }
      else if(oppty.RecordTypeId == '01270000000Q9Me'){
        if(Ins.Confirmed__c ==true){
        GenerateProjectAndPiecesTier1Tier2(Ins, oppty, acctName, OLIs, prodProc, territoryState);  
        oppty.Project_Generated__c = true;
        oppty.Confirmed__c = 'Yes';
        }
        
        
        if(oppty.Type == 'New Business'){
              updateAccountForNewCustomerT1T2(oppty.Id);
            }
        if(Ins.Paid__c != null){
              oppty.Paid__c = 'Yes';
            }
            if(Ins.Confirmed__c != null){
              oppty.Paid_Date__c = Ins.Paid__c;
              //oppty.PAID__c = 'Yes';
            }
      }
    }
        else if(paidInstallments == 1 && firstPayment == true  && oppty.Project_Exception__c == true){
          if(Ins.Confirmed__c == true){
            oppty.Project_Generated__c = true;
            oppty.Confirmed__c = 'Yes';
          }
          if(Ins.Paid__c != null){
            oppty.Paid_Date__c = Ins.Paid__c;
            oppty.Paid__c = 'Yes';
          }
          if(oppty.Type == 'New Business'){
            updateAccountForNewCustomer(oppty.Id);
          }
        }
        update oppty;
    }
    
    public static void GenerateProjectAndPieces(Installment__c Ins, Opportunity oppty, string acctName, 
                          OpportunityLineItem[] OLIs, Product_Process__c[] prodProc, 
                          Territory_State__c territoryState) {
        
        
        
        
        boolean requiresImplementationProject = false;
        boolean requiresWebsitesProject = false;
        decimal mrr = 0;
         //Opportunity opp = [SELECT We_Owe__c FROM Opportunity WHERE Id =: oppty.Id];  //WAS 07/23/2013  Grabbing this to populate field on Project
        
        for(OpportunityLineItem oli : OLIs) {
          
          if(oli.PricebookEntry.Product2.Project_Separation__c == 'Implementation' && oli.PricebookEntry.Product2.ProdProj_Default_Owner__c != null) {
            
            requiresImplementationProject = true;
            //oppty.Imp_Project__c = true;
          }
          else if(oli.PricebookEntry.Product2.Project_Separation__c == 'Websites' && oli.PricebookEntry.Product2.ProdProj_Default_Owner__c != null) {
            
            requiresWebsitesProject = true;
            //oppty.Web_Project__c = true;
          }
          
        }
        List<OpportunityLineItem> mrrOLI = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
                         FROM OpportunityLineItem
                         WHERE OpportunityId = :oppty.Id AND One_Time_Fee__c = false AND Setup_Fee__c = false AND PricebookEntry.Product2.Disable_Price_Change__c = false];
                         
    for(OpportunityLineItem oli : mrrOLI){
      mrr += oli.List_Price_Formula__c;
    }
        
        SFDC_520_Quote__c newImplementationPrj;
        string packetSenderImplementation;
        boolean sendPacketImplementation;
        
        SFDC_520_Quote__c newWebsitePrj;
        string packetSenderWebsite;
        boolean sendPacketWebsite;
        
        
        if(requiresImplementationProject == true) {
          
          system.debug('TEST requiresImplementationProject == true');
          boolean includesTraining = false;
          boolean trainingExpensesPaidByDealer = false;
          Date endDate;
          String projectType = 'Log SFDC Issue to Update';
          
          if(oppty.Name.contains('CRM')) {
            
              endDate = system.today()+30;
          }
          else if(oppty.Name.contains('ILM')) {
            
              endDate = system.today()+20;
          }
          else if(oppty.Name.contains('Inventory')) {
              
              endDate = system.today()+10;
          }
          else {
              
              endDate = system.today()+30;
          }
          
          if(oppty.Opportunity_Names__c != null){
            
            if(oppty.Opportunity_Names__c == 'Hardware'){
              projectType = 'Hardware';
            }
            else if(oppty.Opportunity_Names__c == 'Add On'){
              projectType = 'Add On';
            }
            else if(oppty.Opportunity_Names__c == 'Advanced Inventory with MPT' || oppty.Opportunity_Names__c == 'Advanced Inventory'){
              projectType = 'Inventory Module';
            }
            else if(oppty.Opportunity_Names__c == 'CRM' ||
                oppty.Opportunity_Names__c == 'CRM Plus Desking' ||
                oppty.Opportunity_Names__c == 'CRM Plus MPT' ||
                oppty.Opportunity_Names__c == 'CRM Premier' ||
                oppty.Opportunity_Names__c == 'CRM Pro'){
              projectType = 'CRM';      
            }
            else if(oppty.Opportunity_Names__c == 'ILM' ||
                oppty.Opportunity_Names__c == 'ILM with MPT'){
              projectType = 'ILM';    
            }
            else if(oppty.Opportunity_Names__c == 'Digital Marketing Package'){
              projectType = 'Digital Marketing';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment'){
              projectType = 'Fulfillment';
            }
            else if(oppty.Opportunity_Names__c.contains('Training')){
              projectType = 'Training';
            }
            else if(oppty.Opportunity_Names__c == 'Website - Kore 360' ||
                  oppty.Opportunity_Names__c == 'Website' ||
                  oppty.Opportunity_Names__c == 'Website - Vin Advanced'){
              projectType = 'Website';
            }
            else if(oppty.Opportunity_Names__c == 'Printed Materials'){
              projectType = 'Printed Materials';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment Coop'){
              projectType = 'Fulfillment Coop';
            }
            else if(oppty.Opportunity_Names__c == 'OEM Website'){
              projectType = 'OEM Website';
            }
            else if(oppty.Opportunity_Names__c == 'Product Swap'){
              projectType = 'Product Swap';
            }
            else if(oppty.Opportunity_Names__c == 'Haystak DM'){
              projectType = 'Haystak DM';
            }
            else{
              projectType = 'Log SFDC Issue to Update';
            }
          }
          
          /*if(oppty.Opportunity_Names__c != null) {
              
            if(oppty.Opportunity_Names__c == 'Hardware') {
              //
              projectType = 'Hardware';
            }
            else if(oppty.Opportunity_Names__c == 'Add On') {
              //
              projectType = 'Add On';
            }        
            else if(oppty.Opportunity_Names__c == 'Bronze Solution' || 
                oppty.Opportunity_Names__c == 'DIY / Inventory' || 
                oppty.Opportunity_Names__c.contains('Nickel')) {
              //
              projectType = 'Inventory Module';
            }
            else if(oppty.Opportunity_Names__c == 'CRM' || 
                oppty.Opportunity_Names__c == 'CRM Plus' ||
                oppty.Opportunity_Names__c == 'Diamond Package' || 
                oppty.Opportunity_Names__c == 'Gold Solution' || 
                oppty.Opportunity_Names__c == 'Platinum Solution') {
              //
              projectType = 'CRM';
            }
            else if(oppty.Opportunity_Names__c == 'ILM' || 
                oppty.Opportunity_Names__c == 'Silver Solution') {
              //
              projectType = 'ILM';
        }
            else if(oppty.Opportunity_Names__c == 'Data Acquisition') {
              //
              projectType = 'Data Acquisition';
            }
            else if(oppty.Opportunity_Names__c == 'Digital Marketing Package') {
              //
              projectType = 'Digital Marketing';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment') {
              //
              projectType = 'Fulfillment';
            }
            else if(oppty.Opportunity_Names__c.contains('Training')) {
              //
              projectType = 'Training';
            }
            else if(oppty.Opportunity_Names__c == 'Up Grade') {
              //
              projectType = 'Upgrade';
            }
            else if(oppty.Opportunity_Names__c == 'Website') {
              //
              projectType = 'Website';
            }
            else if(oppty.Opportunity_Names__c == 'Printed Materials') {
              //
              projectType = 'Printed Materials';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment Coop') {
              //
              projectType = 'Fulfillment Coop';
            }
            else {
              //
              projectType = 'Log SFDC Issue to Update';
            }
          }*/
          
          /////...
                          
          string projectOwner = territoryState.Implementation_Manager__c;
          string emailBannerRep = territoryState.Implementation_Specialist__c;
          packetSenderImplementation = territoryState.Implementation_Specialist__c;
          //string notes = oppty.We_Owe__c;
          
          //Create a Project
          newImplementationPrj = new SFDC_520_Quote__c();
          
          if(acctName.length() > 66) {
            
            newImplementationPrj.Name = 'IMP-' + acctName.substring(0,63) + '...' + '-' + system.today().format();
          }
          else {
            
            newImplementationPrj.Name = 'IMP-' + acctName + '-' + system.today().format();  
          }
          decimal impSUM = 0;
          system.debug('BAM1' + mrr);
          if(requiresImplementationProject == true && mrr > 0){
            if(Oppty.Project_Exception__c == false){
               List<AggregateResult> groupedResults = [SELECT SUM(TotalPrice) sumTP FROM OpportunityLineItem WHERE OpportunityId =: oppty.Id AND Product_Separation__c = 'Implementation' AND One_Time_Fee__c = false AND Setup_Fee__c = false];
               
               if(groupedResults.size() > 0){
                 String str = '' + groupedResults[0].get('sumTP');
                 
                 impSum = Decimal.valueOf(str);
                 system.Debug('Shrewsbury   ' + impSum);
               }
            }
          }
                           
          newImplementationPrj.Account__c = Oppty.AccountId;
          newImplementationPrj.Opportunity__c = oppty.Id;
          newImplementationPrj.Project_Worth__c = impSum;
          
          
          
          
          if(oppty.Name.length() > 100) {
            
            newImplementationPrj.Project_Name__c = oppty.Name.substring(0,97) + '...';
          }
          else {
            
            newImplementationPrj.Project_Name__c = oppty.Name;  
          }
          
          
          newImplementationPrj.Approval_Stage__c = 'Introduction';
          newImplementationPrj.Contact__c = oppty.Deal_Contact__c;      
          newImplementationPrj.Training_Included__c = includesTraining;
          newImplementationPrj.Training_Expenses_Paid_by_Dealer__c = trainingExpensesPaidByDealer;
          //newImplementationPrj.Implementation_Notes__c = oppty.We_Owe__c;  // WAS 07/23/2013 
          
          
          if(oppty.Type == 'OEM Website') {
            newImplementationPrj.Project_Type__c = 'OEM Website';
          }
          else {
            newImplementationPrj.Project_Type__c = projectType;
          }
          
          if(oppty.Implementation_Contact__c != null) {
            
            newImplementationPrj.Contact__c = oppty.Implementation_Contact__c;
          }
          
          if(territoryState.Implementation_Manager__c != null) {
            
            projectOwner = territoryState.Implementation_Manager__c;       
          }
          else {
            
            projectOwner = userinfo.getuserId();
          }
          
          newImplementationPrj.OwnerId = projectOwner;
          newImplementationPrj.Go_Live_Date__c = endDate;
          
          //if (oppty.Phased_Project__c == true) newPrj.RecordTypeId = '012Q00000000Fep';//Sandbox
          if(oppty.Phased_Project__c == true) {
            
            newImplementationPrj.RecordTypeId = '01270000000QATH';//production
          }
          else { 
            
            newImplementationPrj.RecordTypeId = '012700000005dgP';
          }
          
          if(oppty.Opportunity_Names__c == 'Fulfillment') {
            
            newImplementationPrj.RecordTypeId = '01270000000Q5u8';
          }
          
          /*if(oppty.Opportunity_Names__c == 'Fulfillment'){
            
            newPrj.RecordTypeId = ' 01270000000Q5Yq';
            newPrj.OwnerId = '00G70000001Kg6p';
          }*/
          system.debug('TEST newImplementationPrj'+ newImplementationPrj);
          insert newImplementationPrj;  
          
          //check if opportunity type of fullfillment
          if(oppty.RecordTypeId == '01270000000Q87d') {
            
              
            List<Attachment> notesAndAttachments = new List<Attachment>();
            
            try {
              notesAndAttachments = [SELECT Id, ParentId, Name, Body
                       FROM Attachment
                          WHERE ParentId = :oppty.Id];
            }
            catch(Exception e) {
              //do nothing
            }
            
            List<Attachment> insertNotesAndAttachments = new List<Attachment>();
            
            if(notesAndAttachments.size() > 0) {
              
              for(Attachment naa : notesAndAttachments) {
                
                Attachment att = new Attachment(name = naa.Name, body = naa.body, parentId = newImplementationPrj.Id);
                insertNotesAndAttachments.add(att);
              }
              
              try {
              
                //update notesAndAttachments;
                insert insertNotesAndAttachments;
                
              }
              catch(Exception e) {
                //do nothing
              }  
            }
          }     
          
          
          //Initialize Project Task List
          LIST<Task> projectTasks = new LIST<Task>();
          
          //Run through the Opportunity Line Items/Products on the Oppty to see if the following special tasks/pieces need be generated
          sendPacketImplementation = false;
          boolean CRM = false;
          boolean ILM = false;
          boolean BOTH = false;
          boolean emailBanner = false;  
          boolean inventoryLight = false;       
          
          for(OpportunityLineItem setPP : OLIs) {
            
              if(setPP.requiresWelcomePacket__c == 'True') {
                
                sendPacketImplementation = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('CRM')) {
                
                CRM = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('ILM')) {
                
                ILM = true;
              }
              
              if(CRM == true || ILM == true) {
                
                emailBanner = true;
              }
                
              if(setPP.PricebookEntry.Name.contains('Inventory Light')) {
                
                inventoryLight = true;
              }
              
              if(setPP.IsTraining__c.tolowercase() == 'true') {
                
                newImplementationPrj.Training_Included__c = true;
              }
              
              if(setPP.ExpPaidByDealer__c.tolowercase() == 'true') {
                
                newImplementationPrj.Training_Expenses_Paid_by_Dealer__c = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('Website')) {
                
                newImplementationPrj.Website_Custom__c = true;        
              }
              
              if(setPP.PricebookEntry.Product2.Project_Separation__c == 'Implementation') {
                
                newImplementationPrj.Implementation_Included__c = true;
              }
              
              if(setPP.PricebookEntry.Product2.Project_Separation__c == 'Websites') {
                
                newImplementationPrj.Web_Project_Generated__c = true;
              }
              
              if(setPP.PricebookEntry.Product2.Family.contains('Reoccuring')) {
                
                newImplementationPrj.Has_Recurring_Products__c = true;
              }
          }
          
          if(CRM == true && ILM == true) {
            
            BOTH = true;
          }
          
          update newImplementationPrj;
        
        }
        
        if(requiresWebsitesProject == true) {
          
          
          boolean includesTraining = false;
          boolean trainingExpensesPaidByDealer = false;
          Date endDate;
          //String projectType = 'Log SFDC Issue to Update';
          String projectType = 'Website';
          
          if(oppty.Opportunity_Names__c != null){
          
            if(oppty.Opportunity_Names__c == 'Haystak DM'){
              projectType = 'Haystak DM';
             }
          }
          
          if(oppty.Name.contains('CRM')) {
            
              endDate = system.today()+30;
          }
          else if(oppty.Name.contains('ILM')) {
            
              endDate = system.today()+20;
          }
          else if(oppty.Name.contains('Inventory')) {
              
              endDate = system.today()+10;
          }
          else {
              
              endDate = system.today()+30;
          }
          /*
          if(oppty.Opportunity_Names__c != null) {
              
            if(oppty.Opportunity_Names__c == 'Hardware') {
              //
              projectType = 'Hardware';
            }
            else if(oppty.Opportunity_Names__c == 'Add On') {
              //
              projectType = 'Add On';
            }        
            else if(oppty.Opportunity_Names__c == 'Bronze Solution' || 
                oppty.Opportunity_Names__c == 'DIY / Inventory' || 
                oppty.Opportunity_Names__c.contains('Nickel')) {
              //
              projectType = 'Inventory Module';
            }
            else if(oppty.Opportunity_Names__c == 'CRM' || 
                oppty.Opportunity_Names__c == 'Diamond Package' || 
                oppty.Opportunity_Names__c == 'Gold Solution' || 
                oppty.Opportunity_Names__c == 'Platinum Solution') {
              //
              projectType = 'CRM';
            }
            else if(oppty.Opportunity_Names__c == 'ILM' || 
                oppty.Opportunity_Names__c == 'Silver Solution') {
              //
              projectType = 'ILM';
        }
            else if(oppty.Opportunity_Names__c == 'Data Acquisition') {
              //
              projectType = 'Data Acquisition';
            }
            else if(oppty.Opportunity_Names__c == 'Digital Marketing Package') {
              //
              projectType = 'Digital Marketing';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment') {
              //
              projectType = 'Fulfillment';
            }
            else if(oppty.Opportunity_Names__c.contains('Training')) {
              //
              projectType = 'Training';
            }
            else if(oppty.Opportunity_Names__c == 'Up Grade') {
              //
              projectType = 'Upgrade';
            }
            else if(oppty.Opportunity_Names__c == 'Website') {
              //
              projectType = 'Website';
            }
            else if(oppty.Opportunity_Names__c == 'Printed Materials') {
              //
              projectType = 'Printed Materials';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment Coop') {
              //
              projectType = 'Fulfillment Coop';
            }
            else {
              //
              projectType = 'Log SFDC Issue to Update';
            }
          }
          */
          
          /////...
                          
          string projectOwner = territoryState.Implementation_Manager__c;
          string emailBannerRep = territoryState.Implementation_Specialist__c;
          packetSenderWebsite = territoryState.Implementation_Specialist__c;
          
          //Create a Project
          newWebsitePrj = new SFDC_520_Quote__c();
          
          if(acctName.length() > 66) {
            
            newWebsitePrj.Name = 'WEB-' + acctName.substring(0,63) + '...' + '-' + system.today().format();
          }
          else {
            
            newWebsitePrj.Name = 'WEB-' + acctName + '-' + system.today().format();  
          }
          decimal webSum = 0;
          system.debug('BAM2' + mrr);
          if(requiresWebsitesProject == true && mrr > 0) {
            if(Oppty.Project_Exception__c == false){
              List<AggregateResult> groupedResultsWeb = [SELECT SUM(TotalPrice) sumWebTP FROM OpportunityLineItem WHERE OpportunityId =: oppty.ID AND Product_Separation__c = 'Websites' AND One_Time_Fee__c = false AND Setup_Fee__c = false];
              if(groupedResultsWeb.size() > 0){
                String strWeb = '' + groupedResultsWeb[0].get('sumWebTp');
                //if(Decimal.valueOf(strWeb) > 0){
                //  webSum = Decimal.valueOf(strWeb);
                //}
                System.Debug('Shrewsbury' + webSum);
              }   
            }
          }
          newWebsitePrj.Account__c = Oppty.AccountId;
          newWebsitePrj.Opportunity__c = oppty.Id;
          newWebsitePrj.Project_Worth__c = webSum;
          
          
          
          if(oppty.Name.length() > 100) {
            
            newWebsitePrj.Project_Name__c = oppty.Name.substring(0,97) + '...';
          }
          else {
            
            newWebsitePrj.Project_Name__c = oppty.Name;  
          }
          
          newWebsitePrj.Approval_Stage__c = 'Introduction';
          newWebsitePrj.Contact__c = oppty.Deal_Contact__c;      
          //newWebsitePrj.Training_Included__c = includesTraining;
          newWebsitePrj.Training_Included__c = false;
          newWebsitePrj.Training_Expenses_Paid_by_Dealer__c = trainingExpensesPaidByDealer;
          //newWebsitePrj.Implementation_Notes__c = oppty.We_Owe__c;  // WAS 07/23/2013 
          Assigned_Users__c wOwner = Assigned_Users__c.getValues('DefaultWebsiteProjectOwner');
          String wOwnerId = wOwner.Who_ID__c;
          Assigned_Users__c hOwner = Assigned_Users__c.getValues('DefaultHaystakProjectOwner');
          String hOwnerId = hOwner.Who_ID__c;
          
          
          if(oppty.Type == 'OEM Website') {
            newWebsitePrj.Project_Type__c = 'OEM Website';
          }
          else if(oppty.Opportunity_Names__c == 'Printed Materials') {
            newWebsitePrj.Project_Type__c = 'Printed Materials';
          }
          else {
            newWebsitePrj.Project_Type__c = projectType;
          }
          
          if(oppty.Implementation_Contact__c != null) {
            
            newWebsitePrj.Contact__c = oppty.Implementation_Contact__c;
          }
          
          if(projectType == 'Website') {
            
            projectOwner = wOwnerId;       
          }
          
          else if (projectType == 'Haystak DM'){
            
            projectOwner = hOwnerId;
          }
          else {
            
            projectOwner = userinfo.getuserId();
          }
          
          newWebsitePrj.OwnerId = projectOwner;
          newWebsitePrj.Go_Live_Date__c = endDate;
          
          //if (oppty.Phased_Project__c == true) newPrj.RecordTypeId = '012Q00000000Fep';//Sandbox
          if(oppty.Phased_Project__c == true) {
            
            newWebsitePrj.RecordTypeId = '01270000000QATH';//production
          }
          else { 
            
            newWebsitePrj.RecordTypeId = '012700000005dgP';
          }
          
          if(oppty.Opportunity_Names__c == 'Fulfillment') {
            
            newWebsitePrj.RecordTypeId = '01270000000Q5u8';
          }
          
          /*if(oppty.Opportunity_Names__c == 'Fulfillment'){
            
            newPrj.RecordTypeId = ' 01270000000Q5Yq';
            newPrj.OwnerId = '00G70000001Kg6p';
          }*/
          
          insert newWebsitePrj;       
          
          
          //Initialize Project Task List
          LIST<Task> projectTasks = new LIST<Task>();
          
          //Run through the Opportunity Line Items/Products on the Oppty to see if the following special tasks/pieces need be generated
          sendPacketWebsite = false;
          boolean CRM = false;
          boolean ILM = false;
          boolean BOTH = false;
          boolean emailBanner = false;  
          boolean inventoryLight = false;       
          
          for(OpportunityLineItem setPP : OLIs) {
            
              if(setPP.requiresWelcomePacket__c == 'True') {
                
                sendPacketWebsite = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('CRM')) {
                
                CRM = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('ILM')) {
                
                ILM = true;
              }
              
              if(CRM == true || ILM == true) {
                
                emailBanner = true;
              }
                
              if(setPP.PricebookEntry.Name.contains('Inventory Light')) {
                
                inventoryLight = true;
              }
              
              if(setPP.IsTraining__c.tolowercase() == 'true') {
                
                //newWebsitePrj.Training_Included__c = true;
              }
              
              if(setPP.ExpPaidByDealer__c.tolowercase() == 'true') {
                
                newWebsitePrj.Training_Expenses_Paid_by_Dealer__c = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('Website')) {
                
                newWebsitePrj.Website_Custom__c = true;        
              }
              
              if(setPP.PricebookEntry.Product2.Project_Separation__c == 'Implementation') {
                
                newWebsitePrj.Implementation_Included__c = true;
              }
              
              if(setPP.PricebookEntry.Product2.Project_Separation__c == 'Websites') {
                
                newWebsitePrj.Web_Project_Generated__c = true;
              }
              
              if(setPP.PricebookEntry.Product2.Family.contains('Reoccuring')) {
                
                newWebsitePrj.Has_Recurring_Products__c = true;
              }
          }
          
          if(CRM == true && ILM == true) {
            
            BOTH = true;
          }
          
          update newWebsitePrj;
        
          
        }
        
        
        
        ////////////////////////
        
        
        //Create a list of Project Pieces to be generated       
        LIST<Project_Piece__c> piecesToCreate = new LIST<Project_Piece__c>();
        
        
        for(OpportunityLineItem thisOli : OLIs) {    
                      
          
            if(thisOli.ProdProj_Default_Owner__c != null) {
                             
                integer i = 1;
                
                if(thisOli.Quantity_Exception__c == 'True') {
              
              i = Math.round(thisOli.Quantity.intValue());
                }
                
                do {   
                    //Find the proper Product Process ID from the list
                    string productProcessId;
                    integer numberMilestones;
                    
                    for(Product_Process__c PrdP : prodProc) {
                      
                        if(PrdP.Product__c == thisOli.ProductId__c) {
                            
                            productProcessId = PrdP.Id;
                            numberMilestones = PrdP.Number_of_Milestones__c.intValue();
                        }
                    }
                                
                    string pieceName = 'PP-' + thisOli.Product_Issue__c + '-' + acctName + '-' + system.today().format();
                    
                    if(pieceName.length() >= 78) {
                      
                      pieceName = piecename.substring(0,73);
                    }
                    
                    
                    if(thisOli.Quantity > 1 && thisOli.Quantity_Exception__c != 'True') {
                      
                      pieceName += '-' + i;
                    }
                    
                    
                    
                    Project_Piece__c newPiece = new Project_Piece__c();
                    newPiece.Product_Process__c = productProcessId;
                                            
                    if(territoryState.Implementation_Manager__c != null) {
                      
                      newPiece.OwnerId = territoryState.Implementation_Manager__c;
                    }
                    
                    if(newPiece.OwnerId != null) {
                      
                      newPiece.OwnerId = thisOli.ProdProj_Default_Owner__c;
                    }
                    
                    newPiece.Project_Piece_Stage__c = 'Introduction';
                    newPiece.Account__c = oppty.AccountId;
                    newPiece.Project_Piece_Special_Instructions__c = thisOli.Description;
                    if(thisOli.Quantity_Exception__c == 'false' && thisOli.Quantity > 1){
                      newPiece.Product_Value__c = thisOli.UnitPrice;
                    }
                    else{
                      newPiece.Product_Value__c = thisOli.TotalPrice;
                    }
                    newPiece.Product_Name__c = thisOli.PricebookEntry.name;
                    newPiece.Name = pieceName;
                    
                    if(oppty.Implementation_Contact__c != null) {
                      
                      newPiece.Contact__c = oppty.Implementation_Contact__c;
                    }
                    
                    if(numberMilestones == 1) {
                      
                      newPiece.RecordTypeId = '01270000000Q4Ux';
                    }
                    else if(numberMilestones == 2) { 
                      
                      newPiece.RecordTypeId = '01270000000Q4V2';
                    }
                    else if(numberMilestones == 3) {
                      
                      newPiece.RecordTypeId = '01270000000Q4V7';
                    }
                    else if(numberMilestones == 4) { 
                      
                      newPiece.RecordTypeId = '01270000000Q4VC';
                    }
                    else if(numberMilestones == 5) { 
                      
                      newPiece.RecordTypeId = '01270000000Q4VH';
                    }
                    else if(numberMilestones == 6) { 
                      
                      newPiece.RecordTypeId = '01270000000Q4Uy';
                    }
                    else if(numberMilestones == 7) { 
                      
                      newPiece.RecordTypeId = '01270000000Q4Uz';
                    }
                    else if(numberMilestones == 8) { 
                      
                      newPiece.RecordTypeId = '01270000000Q4VM';
                    }
                    else if(numberMilestones == 9) { 
                      
                      newPiece.RecordTypeId = '01270000000Q4VR';
                    }
                    else if(numberMilestones == 10) { 
                      
                      newPiece.RecordTypeId = '01270000000Q4V0';
                    }
                    else { 
                      
                      newPiece.RecordTypeId = '012700000005e2u';
                    }
                    
                    string pieceIssue = thisOli.Product_Issue__c + '-' + acctName;
                    
                    if(pieceIssue.length() > 100) {
                      
                      newPiece.Piece_Issue__c = pieceIssue.substring(0, 97) + '...';
                    }
                    else {
                      
                      newPiece.Piece_Issue__c = pieceIssue;  
                    }
                                          
                    
                    
                    ///
                    
                    if(thisOli.PricebookEntry.Product2.Project_Separation__c == 'Implementation') {
                      
                      newPiece.Project__c = newImplementationPrj.Id;
                      
                      //thisOli.Project__c = newImplementationPrj.Id;
                      //update thisOli;
                    }
                    else if(thisOli.PricebookEntry.Product2.Project_Separation__c == 'Websites') {
                      
                      newPiece.Project__c = newWebsitePrj.Id;
                      
                      //thisOli.Project__c = newWebsitePrj.Id;
                      //update thisOli;
                    }
                    
                    
                    ///
                    
                    
                    newPiece.Opportunity_Line_Item_ID__c = thisOli.Id;
                    newPiece.Product_Revenue__c = thisOli.OLI_Cost_Factor__c;
                    
                    //PP Mailer funtionality
                    if(pieceName.contains('Mailer')){
                      
                      newPiece.In_Home_Date__c = oppty.Campaign_Start_Date__c;
                      newPiece.Expiration_Date__c = oppty.Campaign_End_Date__c;
                      newPiece.Timeline__c = oppty.Fulfillment_Timeline__c;
                      newPiece.Campaign_Type__c = oppty.Campaign_Type__c;
                      newPiece.Mailer_Notes__c = oppty.Mailer_Notes__c;
                      newPiece.Opportunity_Owner__c = oppty.OwnerId;
                    }
                    
                    
                    piecesToCreate.add(newPiece);

                    i++;
                }
                while(i<=thisOli.Quantity);             
            }                       
        }   
                
        
        //Generate all the project pieces in the list
        try {
        
        
        insert piecesToCreate;
        
        system.debug('Bazinga... piecesToCreate.size(): ' + piecesToCreate.size());
          
          //Exception Testing and handling
          if(utility.throwExceptionError() == true){
            string Ex = null;
            Ex.tolowercase();
          }
        }
        catch(Exception Ex) {
            String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
            Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
            String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'mark.ross@vinsolutions.com'};
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('dean.lukowski@vinsolutions.com');
            mail.setSubject('Error creating project pieces for ' + oppty.Id);
            mail.setPlainTextBody('Error creating project pieces for opportunity ' + oppty.Id + '<br /> Error: ' + Ex);
            mail.setHtmlBody('Error creating project pieces for opportunity <a href=h' + fullURL + oppty.Id + '>' +
            oppty.Id + '</a><br /> Error:' + Ex);
            system.debug('===================================>>>>> error = ' + Ex);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            system.debug(Ex);
        }
        
        if(newImplementationPrj != null) {
          
          List<SFDC_520_Quote__c> projsToUpdate = new List<SFDC_520_Quote__c>();
          
          projsToUpdate.add(newImplementationPrj);
          
          system.debug('Bazinga... handler_ProjectTrigger.updateProjectMilestoneNA');
          
          handler_ProjectTrigger.updateProjectMilestoneNA(projsToUpdate);
        }
        
        
        
        //Add special Tasks to the list
        if(sendPacketImplementation == True) {
          
            /*Task wPacket = new Task();
            wPacket.WhatId = newPrj.Id;
            wPacket.OwnerId = packetSender;
            wPacket.Subject = 'WFT-Intro Call/Intro Email/Send Packet';
            wPacket.ActivityDate = system.today();
            wPacket.Description ='WFT-Intro Call/Intro Email/Send Packet';
            projectTasks.add(wPacket);*/
            
            Welcome_Packet__c newPacket = new Welcome_Packet__c();
            newPacket.OwnerId = packetSenderImplementation;
            
            if(territoryState.Implementation_Manager__c != null) {
              
              newPacket.OwnerId = territoryState.Implementation_Manager__c;
            } 
            
            newPacket.Account__c = oppty.AccountId;
          newPacket.Project__c = newImplementationPrj.Id;            
          newPacket.Name = newImplementationPrj.Name + ' - Welcome Packet';
            
            if(newPacket.Name.Length() > 80) {
              
              newPacket.Name = newPacket.Name.substring(0,80);  
            } 
            
            newPacket.Packet_Includes__c = 'DIY';
            
            //insert newPacket;
        }
        
        if(sendPacketWebsite == True) {
          
            /*Task wPacket = new Task();
            wPacket.WhatId = newPrj.Id;
            wPacket.OwnerId = packetSender;
            wPacket.Subject = 'WFT-Intro Call/Intro Email/Send Packet';
            wPacket.ActivityDate = system.today();
            wPacket.Description ='WFT-Intro Call/Intro Email/Send Packet';
            projectTasks.add(wPacket);*/
            
            Welcome_Packet__c newPacket = new Welcome_Packet__c();
            newPacket.OwnerId = packetSenderWebsite;
            
            if(territoryState.Implementation_Manager__c != null) {
              
              newPacket.OwnerId = territoryState.Implementation_Manager__c;
            } 
            
            newPacket.Account__c = oppty.AccountId;
          newPacket.Project__c = newWebsitePrj.Id;            
          newPacket.Name = newWebsitePrj.Name + ' - Welcome Packet';
            
            if(newPacket.Name.Length() > 80) {
              
              newPacket.Name = newPacket.Name.substring(0,80);  
            } 
            
            newPacket.Packet_Includes__c = 'DIY';
            
            //insert newPacket;
        }
        
        //Generate all special tasks on the List
        //insert projectTasks;
    }
    
    
    
    public static void GenerateProjectAndPiecesTier1Tier2(Installment__c Ins, Opportunity oppty, string acctName, 
                                OpportunityLineItem[] OLIs, Product_Process__c[] prodProc, 
                                Territory_State__c territoryState) {
        
        
        
        
        boolean requiresImplementationProject = false;
        boolean requiresWebsitesProject = false;
        //Opportunity opp = [SELECT We_Owe__c FROM Opportunity WHERE Id =: oppty.Id];  //WAS 07/23/2013  Grabbing this to populate field on Project
        
        for(OpportunityLineItem oli : OLIs) {
          
          if(oli.PricebookEntry.Product2.Project_Separation__c == 'Implementation' && oli.PricebookEntry.Product2.ProdProj_Default_Owner__c != null) {
            
            requiresImplementationProject = true;
          }
          else if(oli.PricebookEntry.Product2.Project_Separation__c == 'Websites' && oli.PricebookEntry.Product2.ProdProj_Default_Owner__c != null) {
            
            requiresWebsitesProject = true;
          }
        }
        
        SFDC_520_Quote__c newImplementationPrj;
        string packetSenderImplementation;
        boolean sendPacketImplementation;
        
        SFDC_520_Quote__c newWebsitePrj;
        string packetSenderWebsite;
        boolean sendPacketWebsite;
        
        if(requiresImplementationProject == true) {
          
          
          boolean includesTraining = false;
          boolean trainingExpensesPaidByDealer = false;
          Date endDate;
          String projectType = 'Log SFDC Issue to Update';
          
          if(oppty.Name.contains('CRM')) {
            
              endDate = system.today()+30;
          }
          else if(oppty.Name.contains('ILM')) {
            
              endDate = system.today()+20;
          }
          else if(oppty.Name.contains('DIY')) {
              
              endDate = system.today()+10;
          }
          else {
              
              endDate = system.today()+30;
          }
          
          /*if(oppty.Opportunity_Names__c != null) {
              
            if(oppty.Opportunity_Names__c == 'Hardware') {
              //
              projectType = 'Hardware';
            }
            else if(oppty.Opportunity_Names__c == 'Add On') {
              //
              projectType = 'Add On';
            }        
            else if(oppty.Opportunity_Names__c == 'Bronze Solution' || 
                oppty.Opportunity_Names__c == 'DIY / Inventory' || 
                oppty.Opportunity_Names__c.contains('Nickel')) {
              //
              projectType = 'Inventory Module';
            }
            else if(oppty.Opportunity_Names__c == 'CRM' || 
                oppty.Opportunity_Names__c == 'CRM Plus' ||
                oppty.Opportunity_Names__c == 'Diamond Package' || 
                oppty.Opportunity_Names__c == 'Gold Solution' || 
                oppty.Opportunity_Names__c == 'Platinum Solution') {
              //
              projectType = 'CRM';
            }
            else if(oppty.Opportunity_Names__c == 'ILM' || 
                oppty.Opportunity_Names__c == 'Silver Solution') {
              //
              projectType = 'ILM';
        }
            else if(oppty.Opportunity_Names__c == 'Data Acquisition') {
              //
              projectType = 'Data Acquisition';
            }
            else if(oppty.Opportunity_Names__c == 'Digital Marketing Package') {
              //
              projectType = 'Digital Marketing';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment') {
              //
              projectType = 'Fulfillment';
            }
            else if(oppty.Opportunity_Names__c.contains('Training')) {
              //
              projectType = 'Training';
            }
            else if(oppty.Opportunity_Names__c == 'Up Grade') {
              //
              projectType = 'Upgrade';
            }
            else if(oppty.Opportunity_Names__c == 'Website') {
              //
              projectType = 'Website';
            }
            else if(oppty.Opportunity_Names__c == 'Printed Materials') {
              //
              projectType = 'Printed Materials';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment Coop') {
              //
              projectType = 'Fulfillment Coop';
            }
            else {
              //
              projectType = 'Log SFDC Issue to Update';
            }
          }*/
          
          /////...
                          
          string projectOwner = territoryState.Implementation_Manager__c;
          string emailBannerRep = territoryState.Implementation_Specialist__c;
          packetSenderImplementation = territoryState.Implementation_Specialist__c;
          
          //Create a Project
          newImplementationPrj = new SFDC_520_Quote__c();
          newImplementationPrj.Name = 'IMP-' + acctName + '-' + system.today().format();
          newImplementationPrj.Account__c = Oppty.AccountId;
          newImplementationPrj.Opportunity__c = oppty.Id;
          newImplementationPrj.Project_Name__c = oppty.Name;
          newImplementationPrj.Approval_Stage__c = 'Introduction';
          newImplementationPrj.Contact__c = oppty.Deal_Contact__c;      
          newImplementationPrj.Training_Included__c = includesTraining;
          newImplementationPrj.Training_Expenses_Paid_by_Dealer__c = trainingExpensesPaidByDealer;
          //newImplementationPrj.Implementation_Notes__c = oppty.We_Owe__c;  // WAS 07/23/2013 
          
          if(oppty.Opportunity_Names__c == 'OEM Website') {
            newImplementationPrj.Project_Type__c = 'OEM Website';
          }
          else {
            newImplementationPrj.Project_Type__c = projectType;
          }
          
          if(oppty.Implementation_Contact__c != null) {
            
            newImplementationPrj.Contact__c = oppty.Implementation_Contact__c;
          }
          
          if(territoryState.Implementation_Manager__c != null) {
            
            projectOwner = territoryState.Implementation_Manager__c;       
          }
          else {
            
            projectOwner = userinfo.getuserId();
          }
          
          newImplementationPrj.OwnerId = projectOwner;
          newImplementationPrj.Go_Live_Date__c = endDate;
          
          //if (oppty.Phased_Project__c == true) newPrj.RecordTypeId = '012Q00000000Fep';//Sandbox
          if(oppty.Phased_Project__c == true) {
            
            newImplementationPrj.RecordTypeId = '01270000000QATH';//production
          }
          else { 
            
            newImplementationPrj.RecordTypeId = '012700000005dgP';
          }
          
          if(oppty.Opportunity_Names__c == 'Fulfillment') {
            
            newImplementationPrj.RecordTypeId = '01270000000Q5u8';
          }
          
          /*if(oppty.Opportunity_Names__c == 'Fulfillment'){
            
            newPrj.RecordTypeId = ' 01270000000Q5Yq';
            newPrj.OwnerId = '00G70000001Kg6p';
          }*/
          
          insert newImplementationPrj;       
          
          
          //Initialize Project Task List
          LIST<Task> projectTasks = new LIST<Task>();
          
          //Run through the Opportunity Line Items/Products on the Oppty to see if the following special tasks/pieces need be generated
          sendPacketImplementation = false;
          boolean CRM = false;
          boolean ILM = false;
          boolean BOTH = false;
          boolean emailBanner = false;  
          boolean inventoryLight = false;       
          
          for(OpportunityLineItem setPP : OLIs) {
            
              if(setPP.requiresWelcomePacket__c == 'True') {
                
                sendPacketImplementation = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('CRM')) {
                
                CRM = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('ILM')) {
                
                ILM = true;
              }
              
              if(CRM == true || ILM == true) {
                
                emailBanner = true;
              }
                
              if(setPP.PricebookEntry.Name.contains('Inventory Light')) {
                
                inventoryLight = true;
              }
              
              if(setPP.IsTraining__c.tolowercase() == 'true') {
                
                newImplementationPrj.Training_Included__c = true;
              }
              
              if(setPP.ExpPaidByDealer__c.tolowercase() == 'true') {
                
                newImplementationPrj.Training_Expenses_Paid_by_Dealer__c = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('Website')) {
                
                newImplementationPrj.Website_Custom__c = true;        
              }
              
              if(setPP.PricebookEntry.Product2.Project_Separation__c == 'Implementation') {
                
                newImplementationPrj.Implementation_Included__c = true;
              }
              
              if(setPP.PricebookEntry.Product2.Project_Separation__c == 'Websites') {
                
                newImplementationPrj.Web_Project_Generated__c = true;
              }
              
             if(setPP.PricebookEntry.Product2.Family.contains('Reoccuring')) {
                
                newImplementationPrj.Has_Recurring_Products__c = true;
              }
          }
          
          if(CRM == true && ILM == true) {
            
            BOTH = true;
          }
          
          update newImplementationPrj;
        
        }
        
        if(requiresWebsitesProject == true) {
          
          
          boolean includesTraining = false;
          boolean trainingExpensesPaidByDealer = false;
          Date endDate;
          //String projectType = 'Log SFDC Issue to Update';
          String projectType = 'Website';
          
          if(oppty.Name.contains('CRM')) {
            
              endDate = system.today()+30;
          }
          else if(oppty.Name.contains('ILM')) {
            
              endDate = system.today()+20;
          }
          else if(oppty.Name.contains('DIY')) {
              
              endDate = system.today()+10;
          }
          else {
              
              endDate = system.today()+30;
          }
          if(oppty.Opportunity_Names__c != null){
            
            if(oppty.Opportunity_Names__c == 'Hardware'){
              projectType = 'Hardware';
            }
            else if(oppty.Opportunity_Names__c == 'Add On'){
              projectType = 'Add On';
            }
            else if(oppty.Opportunity_Names__c == 'Advanced Inventory with MPT' || oppty.Opportunity_Names__c == 'Advanced Inventory'){
              projectType = 'Inventory Module';
            }
            else if(oppty.Opportunity_Names__c == 'CRM' ||
                oppty.Opportunity_Names__c == 'CRM Plus Desking' ||
                oppty.Opportunity_Names__c == 'CRM Plus MPT' ||
                oppty.Opportunity_Names__c == 'CRM Premier' ||
                oppty.Opportunity_Names__c == 'CRM Pro'){
              projectType = 'CRM';      
            }
            else if(oppty.Opportunity_Names__c == 'ILM' ||
                oppty.Opportunity_Names__c == 'ILM with MPT'){
              projectType = 'ILM';
            }
            else if(oppty.Opportunity_Names__c == 'Digital Marketing Package'){
              projectType = 'Digital Marketing';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment'){
              projectType = 'Fulfillment';
            }
            else if(oppty.Opportunity_Names__c.contains('Training')){
              projectType = 'Training';
            }
            else if(oppty.Opportunity_Names__c == 'Website - Kore 360' ||
                  oppty.Opportunity_Names__c == 'Website' ||
                  oppty.Opportunity_Names__c == 'Website - Vin Advanced'){
              projectType = 'Website';
            }
            else if(oppty.Opportunity_Names__c == 'Printed Materials'){
              projectType = 'Printed Materials';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment Coop'){
              projectType = 'Fulfillment Coop';
            }
            else if(oppty.Opportunity_Names__c == 'OEM Website'){
              projectType = 'OEM Website';
            }
            else if(oppty.Opportunity_Names__c == 'Product Swap'){
              projectType = 'Product Swap';
            }
            else if(oppty.Opportunity_Names__c == 'Haystak DM'){
              projectType = 'Haystak DM';
            }
            else{
              projectType = 'Log SFDC Issue to Update';
            }
          }
          /*
          if(oppty.Opportunity_Names__c != null) {
              
            if(oppty.Opportunity_Names__c == 'Hardware') {
              //
              projectType = 'Hardware';
            }
            else if(oppty.Opportunity_Names__c == 'Add On') {
              //
              projectType = 'Add On';
            }        
            else if(oppty.Opportunity_Names__c == 'Bronze Solution' || 
                oppty.Opportunity_Names__c == 'DIY / Inventory' || 
                oppty.Opportunity_Names__c.contains('Nickel')) {
              //
              projectType = 'Inventory Module';
            }
            else if(oppty.Opportunity_Names__c == 'CRM' || 
                oppty.Opportunity_Names__c == 'Diamond Package' || 
                oppty.Opportunity_Names__c == 'Gold Solution' || 
                oppty.Opportunity_Names__c == 'Platinum Solution') {
              //
              projectType = 'CRM';
            }
            else if(oppty.Opportunity_Names__c == 'ILM' || 
                oppty.Opportunity_Names__c == 'Silver Solution') {
              //
              projectType = 'ILM';
        }
            else if(oppty.Opportunity_Names__c == 'Data Acquisition') {
              //
              projectType = 'Data Acquisition';
            }
            else if(oppty.Opportunity_Names__c == 'Digital Marketing Package') {
              //
              projectType = 'Digital Marketing';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment') {
              //
              projectType = 'Fulfillment';
            }
            else if(oppty.Opportunity_Names__c.contains('Training')) {
              //
              projectType = 'Training';
            }
            else if(oppty.Opportunity_Names__c == 'Up Grade') {
              //
              projectType = 'Upgrade';
            }
            else if(oppty.Opportunity_Names__c == 'Website') {
              //
              projectType = 'Website';
            }
            else if(oppty.Opportunity_Names__c == 'Printed Materials') {
              //
              projectType = 'Printed Materials';
            }
            else if(oppty.Opportunity_Names__c == 'Fulfillment Coop') {
              //
              projectType = 'Fulfillment Coop';
            }
            else {
              //
              projectType = 'Log SFDC Issue to Update';
            }
          }
          */
          
          /////...
                          
          string projectOwner = territoryState.Implementation_Manager__c;
          string emailBannerRep = territoryState.Implementation_Specialist__c;
          packetSenderWebsite = territoryState.Implementation_Specialist__c;
          
          //Create a Project
          newWebsitePrj = new SFDC_520_Quote__c();
          newWebsitePrj.Name = 'WEB-' + acctName + '-' + system.today().format();
          newWebsitePrj.Account__c = Oppty.AccountId;
          newWebsitePrj.Opportunity__c = oppty.Id;
          newWebsitePrj.Project_Name__c = oppty.Name;
          newWebsitePrj.Approval_Stage__c = 'Introduction';
          newWebsitePrj.Contact__c = oppty.Deal_Contact__c;      
          //newWebsitePrj.Training_Included__c = includesTraining;
          newWebsitePrj.Training_Included__c = false;
          newWebsitePrj.Training_Expenses_Paid_by_Dealer__c = trainingExpensesPaidByDealer;
          //newWebsitePrj.Implementation_Notes__c = oppty.We_Owe__c;  // WAS 07/23/2013 
          Assigned_Users__c wOwner = Assigned_Users__c.getValues('DefaultWebsiteProjectOwner');
          String wOwnerId = wOwner.Who_ID__c;
          Assigned_Users__c hOwner = Assigned_Users__c.getValues('DefaultHaystakProjectOwner');
          String hOwnerId = hOwner.Who_ID__c;
          
          if(oppty.Opportunity_Names__c == 'OEM Website') {
            newWebsitePrj.Project_Type__c = 'OEM Website';
          }
          else if(oppty.Opportunity_Names__c == 'Printed Materials') {
            newWebsitePrj.Project_Type__c = 'Printed Materials';
          }
          else {
            newWebsitePrj.Project_Type__c = projectType;
          }
          
          if(oppty.Implementation_Contact__c != null) {
            
            newWebsitePrj.Contact__c = oppty.Implementation_Contact__c;
          }
          
      if(projectType == 'Website') {
            
            projectOwner = wOwnerId;       
          }
          
          else if (projectType == 'Haystak DM'){
            
            projectOwner = hOwnerId;
          }
          else {
            
            projectOwner = userinfo.getuserId();
          }
          
          newWebsitePrj.OwnerId = projectOwner;
          newWebsitePrj.Go_Live_Date__c = endDate;
          
          //if (oppty.Phased_Project__c == true) newPrj.RecordTypeId = '012Q00000000Fep';//Sandbox
          if(oppty.Phased_Project__c == true) {
            
            newWebsitePrj.RecordTypeId = '01270000000QATH';//production 01270000000Q5Z0
          }
          else { 
            
            newWebsitePrj.RecordTypeId = '012700000005dgP';
          }
          
          if(oppty.Opportunity_Names__c == 'Fulfillment') {
            
            newWebsitePrj.RecordTypeId = '01270000000Q5u8';
          }
          
          /*if(oppty.Opportunity_Names__c == 'Fulfillment'){
            
            newPrj.RecordTypeId = ' 01270000000Q5Yq';
            newPrj.OwnerId = '00G70000001Kg6p';
          }*/
          
          insert newWebsitePrj;       
          
          
          //Initialize Project Task List
          LIST<Task> projectTasks = new LIST<Task>();
          
          //Run through the Opportunity Line Items/Products on the Oppty to see if the following special tasks/pieces need be generated
          sendPacketWebsite = false;
          boolean CRM = false;
          boolean ILM = false;
          boolean BOTH = false;
          boolean emailBanner = false;  
          boolean inventoryLight = false;       
          
          for(OpportunityLineItem setPP : OLIs) {
            
              if(setPP.requiresWelcomePacket__c == 'True') {
                
                sendPacketWebsite = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('CRM')) {
                
                CRM = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('ILM')) {
                
                ILM = true;
              }
              
              if(CRM == true || ILM == true) {
                
                emailBanner = true;
              }
                
              if(setPP.PricebookEntry.Name.contains('Inventory Light')) {
                
                inventoryLight = true;
              }
              
              if(setPP.IsTraining__c.tolowercase() == 'true') {
                
                newWebsitePrj.Training_Included__c = true;
              }
              
              if(setPP.ExpPaidByDealer__c.tolowercase() == 'true') {
                
                newWebsitePrj.Training_Expenses_Paid_by_Dealer__c = true;
              }
              
              if(setPP.PricebookEntry.Name.contains('Website')) {
                
                newWebsitePrj.Website_Custom__c = true;        
              }
              
              if(setPP.PricebookEntry.Product2.Project_Separation__c == 'Implementation') {
                
                newWebsitePrj.Implementation_Included__c = true;
              }
              
              if(setPP.PricebookEntry.Product2.Project_Separation__c == 'Websites') {
                
                newWebsitePrj.Web_Project_Generated__c = true;
              }
              
              if(setPP.PricebookEntry.Product2.Family.contains('Reoccuring')) {
                
                newWebsitePrj.Has_Recurring_Products__c = true;
              }
          }
          
          if(CRM == true && ILM == true) {
            
            BOTH = true;
          }
          
          update newWebsitePrj;
        
          
        }
        
        
        
        
        //Create a list of Project Pieces to be generated       
        LIST<Project_Piece__c> piecesToCreate = new LIST<Project_Piece__c>();
        
        
        for(OpportunityLineItem thisOli : OLIs) {  
          
          system.debug('Bazinga...1');                     
          
            if(thisOli.ProdProj_Default_Owner__c != null) {
                
              system.debug('Bazinga...2');
              
              if(thisOli.PricebookEntry.Product2.Subject_to_Load__c == true) {
                
                integer i = 1;
                  
                  integer limiter = 1;
                  
                  if(thisOli.Quantity < oppty.Initial_Load__c) {
                    
                    limiter = Math.round(thisOli.Quantity.intValue());
                  }
                  else {
                    
                    limiter = Math.round(oppty.Initial_Load__c.intValue());
                  }
                  
                  //set the load counter equal to the initial load
                  oppty.Load_Counter__c = limiter;
                  
                  system.debug('Bazinga...3..limiter: ' + limiter);
                  
                  
                  do {   
                      //Find the proper Product Process ID from the list
                      string productProcessId;
                      integer numberMilestones;
                      
                      for(Product_Process__c PrdP : prodProc) {
                        
                          if(PrdP.Product__c == thisOli.ProductId__c) {
                              
                              productProcessId = PrdP.Id;
                              numberMilestones = PrdP.Number_of_Milestones__c.intValue();
                          }
                      }
                                  
                      string pieceName = 'PP-' + thisOli.Product_Issue__c + '-' + acctName + '-' + system.today().format();
                      //
                      if(pieceName.length() >= 78) {
                         
                        pieceName = piecename.substring(0,73);
                      }
                      
                      if(thisOli.Quantity > 1 && thisOli.Quantity_Exception__c != 'True') {
                        
                        pieceName += + '-' + i;
                      }
                      
                      Project_Piece__c newPiece = new Project_Piece__c();
                      newPiece.Product_Process__c = productProcessId;
                                              
                      if(territoryState.Implementation_Manager__c != null) {
                        
                        newPiece.OwnerId = territoryState.Implementation_Manager__c;
                      }
                      
                      if(newPiece.OwnerId != null) {
                        
                        newPiece.OwnerId = thisOli.ProdProj_Default_Owner__c;
                      }
                      
                      newPiece.Project_Piece_Stage__c = 'Introduction';
                      newPiece.Account__c = oppty.AccountId;
                      newPiece.Project_Piece_Special_Instructions__c = thisOli.Description;
                      if(thisOli.Quantity_Exception__c == 'false' && thisOli.Quantity > 1){
                        newPiece.Product_Value__c = thisOli.UnitPrice;
                      }
                      else{
                        newPiece.Product_Value__c = thisOli.TotalPrice;
                      }
                      newPiece.Product_Name__c = thisOli.PricebookEntry.name;
                      newPiece.Name = pieceName;
                      
                      if(oppty.Implementation_Contact__c != null) {
                        
                        newPiece.Contact__c = oppty.Implementation_Contact__c;
                      }
                      
                      if(numberMilestones == 1) {
                        
                        newPiece.RecordTypeId = '01270000000Q4Ux';
                      }
                      else if(numberMilestones == 2) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4V2';
                      }
                      else if(numberMilestones == 3) {
                        
                        newPiece.RecordTypeId = '01270000000Q4V7';
                      }
                      else if(numberMilestones == 4) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4VC';
                      }
                      else if(numberMilestones == 5) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4VH';
                      }
                      else if(numberMilestones == 6) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4Uy';
                      }
                      else if(numberMilestones == 7) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4Uz';
                      }
                      else if(numberMilestones == 8) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4VM';
                      }
                      else if(numberMilestones == 9) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4VR';
                      }
                      else if(numberMilestones == 10) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4V0';
                      }
                      else { 
                        
                        newPiece.RecordTypeId = '012700000005e2u';
                      }
                                             
                      newPiece.Piece_Issue__c = thisOli.Product_Issue__c + '-' + acctName;
                      ///
                      
                      if(thisOli.PricebookEntry.Product2.Project_Separation__c == 'Implementation') {
                        
                        newPiece.Project__c = newImplementationPrj.Id;
                        
                        //thisOli.Project__c = newImplementationPrj.Id;
                        //update thisOli; 
                      }
                      else if(thisOli.PricebookEntry.Product2.Project_Separation__c == 'Websites') {
                        
                        newPiece.Project__c = newWebsitePrj.Id;
                        
                        //thisOli.Project__c = newWebsitePrj.Id;
                        //update thisOli; 
                      }
                      
                      
                      ///
                      newPiece.Opportunity_Line_Item_ID__c = thisOli.Id;
                      newPiece.Product_Revenue__c = thisOli.OLI_Cost_Factor__c;
                      
                      //PP Mailer funtionality
                      if(pieceName.contains('Mailer')){
                        
                        newPiece.In_Home_Date__c = oppty.Campaign_Start_Date__c;
                        newPiece.Expiration_Date__c = oppty.Campaign_End_Date__c;
                        newPiece.Timeline__c = oppty.Fulfillment_Timeline__c;
                        newPiece.Campaign_Type__c = oppty.Campaign_Type__c;
                        newPiece.Mailer_Notes__c = oppty.Mailer_Notes__c;
                        newPiece.Opportunity_Owner__c = oppty.OwnerId;
                      }
                      
                      piecesToCreate.add(newPiece);
                      
                      
  
                      i++;
                      
                      
                      system.debug('Bazinga...4..i: ' + i); 
                  }
                  while(i <= limiter);
              }
              else {
                
                system.debug('Bazinga...5');
                
                integer i = 1;
                
                  if(thisOli.Quantity_Exception__c == 'True') {
                
                i = Math.round(thisOli.Quantity.intValue());
                  }
                  
                  
                  
                  do {   
                    
                    system.debug('Bazinga...6');
                    
                      //Find the proper Product Process ID from the list
                      string productProcessId;
                      integer numberMilestones;
                      
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
                                              
                      if(territoryState.Implementation_Manager__c != null) {
                        
                        newPiece.OwnerId = territoryState.Implementation_Manager__c;
                      }
                      
                      if(newPiece.OwnerId != null) {
                        
                        newPiece.OwnerId = thisOli.ProdProj_Default_Owner__c;
                      }
                      
                      newPiece.Project_Piece_Stage__c = 'Introduction';
                      newPiece.Account__c = oppty.AccountId;
                      newPiece.Project_Piece_Special_Instructions__c = thisOli.Description;
                      if(thisOli.Quantity_Exception__c == 'false' && thisOli.Quantity > 1){
                        newPiece.Product_Value__c = thisOli.UnitPrice;
                      }
                      else{
                        newPiece.Product_Value__c = thisOli.TotalPrice;
                      }
                      newPiece.Product_Name__c = thisOli.PricebookEntry.name;
                      newPiece.Name = pieceName;
                      
                      if(oppty.Implementation_Contact__c != null) {
                        
                        newPiece.Contact__c = oppty.Implementation_Contact__c;
                      }
                      
                      if(numberMilestones == 1) {
                        
                        newPiece.RecordTypeId = '01270000000Q4Ux';
                      }
                      else if(numberMilestones == 2) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4V2';
                      }
                      else if(numberMilestones == 3) {
                        
                        newPiece.RecordTypeId = '01270000000Q4V7';
                      }
                      else if(numberMilestones == 4) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4VC';
                      }
                      else if(numberMilestones == 5) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4VH';
                      }
                      else if(numberMilestones == 6) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4Uy';
                      }
                      else if(numberMilestones == 7) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4Uz';
                      }
                      else if(numberMilestones == 8) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4VM';
                      }
                      else if(numberMilestones == 9) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4VR';
                      }
                      else if(numberMilestones == 10) { 
                        
                        newPiece.RecordTypeId = '01270000000Q4V0';
                      }
                      else { 
                        
                        newPiece.RecordTypeId = '012700000005e2u';
                      }
                                             
                      newPiece.Piece_Issue__c = thisOli.Product_Issue__c + '-' + acctName;
                      ///
                    
                      if(thisOli.PricebookEntry.Product2.Project_Separation__c == 'Implementation') {
                        
                        newPiece.Project__c = newImplementationPrj.Id;
                      }
                      else if(thisOli.PricebookEntry.Product2.Project_Separation__c == 'Websites') {
                        
                        newPiece.Project__c = newWebsitePrj.Id;
                      }
                      
                      
                      ///
                      newPiece.Opportunity_Line_Item_ID__c = thisOli.Id;
                      newPiece.Product_Revenue__c = thisOli.OLI_Cost_Factor__c;
                      
                      //PP Mailer funtionality
                      if(pieceName.contains('Mailer')){
                        
                        newPiece.In_Home_Date__c = oppty.Campaign_Start_Date__c;
                        newPiece.Expiration_Date__c = oppty.Campaign_End_Date__c;
                        newPiece.Timeline__c = oppty.Fulfillment_Timeline__c;
                        newPiece.Campaign_Type__c = oppty.Campaign_Type__c;
                        newPiece.Mailer_Notes__c = oppty.Mailer_Notes__c;
                        newPiece.Opportunity_Owner__c = oppty.OwnerId;
                      }
                      
                      piecesToCreate.add(newPiece);
  
                      i++;
                  }
                  while(i<=thisOli.Quantity);
              }           
            }                       
        }
        
        system.debug('Bazinga... before insert pieces...');   
                
        
        //Generate all the project pieces in the list
        try {
          
          system.debug('Bazinga... insert pieces.. size: ' + piecesToCreate.size());
          
          insert piecesToCreate;
          
          system.debug('Bazinga... insert complete');

      //Exception Testing and handling
          if(utility.throwExceptionError() == true){
            
            
            string Ex = null;
            Ex.tolowercase();
          } 
        }
        catch(Exception Ex) {
            
            system.debug('Bazinga... exception..2');
            String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
            Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();
            String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'mark.ross@vinsolutions.com'};
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('dean.lukowski@vinsolutions.com');
            mail.setSubject('Error creating project pieces for ' + oppty.Id);
            mail.setPlainTextBody('Error creating project pieces for opportunity ' + oppty.Id + '<br /> Error: ' + Ex);
            mail.setHtmlBody('Error creating project pieces for opportunity <a href=' + fullURL + oppty.Id + '>' +
            oppty.Id + '</a><br /> Error:' + Ex);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            system.debug(Ex);
        }
        
        
        //Add special Tasks to the list
        if(sendPacketImplementation == True) {
          
            /*Task wPacket = new Task();
            wPacket.WhatId = newPrj.Id;
            wPacket.OwnerId = packetSender;
            wPacket.Subject = 'WFT-Intro Call/Intro Email/Send Packet';
            wPacket.ActivityDate = system.today();
            wPacket.Description ='WFT-Intro Call/Intro Email/Send Packet';
            projectTasks.add(wPacket);*/
            
            Welcome_Packet__c newPacket = new Welcome_Packet__c();
            newPacket.OwnerId = packetSenderImplementation;
            
            if(territoryState.Implementation_Manager__c != null) {
              
              newPacket.OwnerId = territoryState.Implementation_Manager__c;
            } 
            
            newPacket.Account__c = oppty.AccountId;
          newPacket.Project__c = newImplementationPrj.Id;            
          newPacket.Name = newImplementationPrj.Name + ' - Welcome Packet';
            
            if(newPacket.Name.Length() > 80) {
              
              newPacket.Name = newPacket.Name.substring(0,80);  
            } 
            
            newPacket.Packet_Includes__c = 'DIY';
            
            //insert newPacket;
        }
        
        if(sendPacketWebsite == True) {
          
            /*Task wPacket = new Task();
            wPacket.WhatId = newPrj.Id;
            wPacket.OwnerId = packetSender;
            wPacket.Subject = 'WFT-Intro Call/Intro Email/Send Packet';
            wPacket.ActivityDate = system.today();
            wPacket.Description ='WFT-Intro Call/Intro Email/Send Packet';
            projectTasks.add(wPacket);*/
            
            Welcome_Packet__c newPacket = new Welcome_Packet__c();
            newPacket.OwnerId = packetSenderWebsite;
            
            if(territoryState.Implementation_Manager__c != null) {
              
              newPacket.OwnerId = territoryState.Implementation_Manager__c;
            } 
            
            newPacket.Account__c = oppty.AccountId;
          newPacket.Project__c = newWebsitePrj.Id;            
          newPacket.Name = newWebsitePrj.Name + ' - Welcome Packet';
            
            if(newPacket.Name.Length() > 80) {
              
              newPacket.Name = newPacket.Name.substring(0,80);  
            } 
            
            newPacket.Packet_Includes__c = 'DIY';
            
            //insert newPacket;
        }
        
        //Generate all special tasks on the List
        //insert projectTasks;
    }
    
    
    
    
    //Mark Account Status as 'Active' for new customers
    @future
    public static void updateAccountForNewCustomer(string oppId) {
      
        Opportunity thisOpp = [select Id, AccountId, Paid_Date__c from Opportunity where Id =: oppId limit 1];
        Account thisAccount = [select Id, Status__c, Created_Date__c from Account where Id =: thisOpp.AccountId limit 1];
        if(test.isRunningTest()==false){
          if(thisAccount.Created_Date__c == null) {
            
            thisAccount.Status__c = 'Active';
            thisAccount.Created_Date__c = thisOpp.Paid_Date__c.date();
            
            update thisAccount;     
          }
        }
    }
    
    public static void updateAccountForNewCustomerT1T2(string oppId){
      
      Opportunity thisOpp = [select Id, AccountId, Paid_Date__c from Opportunity where Id =: oppId limit 1];
        Account thisAccount = [select Id, Status__c, Created_Date__c from Account where Id =: thisOpp.AccountId limit 1];
        if(test.isRunningTest()==false){
          if(thisAccount.Created_Date__c == null) {
            
            thisAccount.Status__c = 'Active';
            thisAccount.Created_Date__c = system.today();
            
            update thisAccount;     
          }
        }
      
    } 

    
    
}