public class vAutoContractHandler extends ContractHandler{       
    // methods to override 
    public override void createContractAndBillingItems(Opportunity opp,List<OpportunityLineItem> oppLines,Map<String,POA__c> poaList) {
        //For cases where we can have Opportunites with out products
        //and need special handling ignore; do not create contracts
        //check if opp has products
        if(oppLines == null || oppLines.size() ==0){
       	  return;
        }
        System.debug('Creating a contract');
        opp.Contract_Generated__c = true;
        Contract contract;

        //Trader Canada Accounts
        if(opp.Account.vAuto_Account_Number__c != null 
            && opp.Account.vAuto_Account_Number__c.startsWith('TC')){
            //handle Trader Canada Contracts
            List<Contract> existingContracts = [Select Id from Contract
                                                where AccountId =: opp.AccountId
                                                and Contract_Type__c = 'vAuto' 
                                                and RecordTypeId  =: StaticData.getInstance().ContractRecTypesMapByDevName.get('vAuto_NOT_RMB').Id
                                                and Status != 'Cancelled'];  
            if(existingContracts != null && existingContracts.size() > 1){
                throw new CoxAutomotiveException('There are more than one vAuto Contracts of recordtype vAuto_NOT_RMB for Account');       
            }

            if(existingContracts == null || existingContracts.size() == 0){
                //create contract
                Contract newContract = new Contract();
                string contractName = 'ORDER-' + opp.Opportunity_Names__c + '-'
                                               + opp.Formula_Account_Name__c + '-'
                                               + string.valueOf(system.today().format());
        
                if(contractName.length() > 80) {
                    newContract.Name = contractName.substring(0, 80);
                }
                else {
                    newContract.Name = contractName;
                }
        
                newContract.PO__c = opp.Opportunity_ID__c;
                newContract.StartDate = system.today().toStartOfMonth();
                newContract.Contract_Type__c = 'vAuto';
                newContract.AccountId = opp.AccountId;
                newContract.Bill_To_Account__c = opp.AccountId;
                newContract.Salesperson__c = opp.Owner.Name;
                newContract.Related_Opportunity__c = opp.Id;
                newContract.Training_Included__c = getTrainingIncluded(opp);
                newContract.OwnerId = Label.API_UserId;
                newContract.Description = opp.Description;
                newContract.LOB__c = 'VAUTO';
                newContract.RecordTypeId = StaticData.getInstance().ContractRecTypesMapByDevName.get('vAuto_NOT_RMB').Id;
                insert newContract;
                contract = newContract;    
            }
            else{
                contract = existingContracts[0]; 
            }
        }
        else{
            // Contract are not Trader Canada
            //check if there is a contract for a account if so use existing
            //filter vAuto_NOT_RMB
            //and (NOT name Like 'VATC%')
            List<Contract> existingContracts = [Select Id from Contract where AccountId =: opp.AccountId and Contract_Type__c = 'vAuto' 
                                    and RecordTypeId  !=: StaticData.getInstance().ContractRecTypesMapByDevName.get('vAuto_NOT_RMB').Id 
                                    and RecordTypeId  !=: StaticData.getInstance().ContractRecTypesMapByDevName.get('Cancel_Contract').Id 
                                    and Status != 'Cancelled'];  
            if(existingContracts != null && existingContracts.size() > 1){
                throw new CoxAutomotiveException('There are more than one vAuto Contracts for Account');       
            }
        
            if(existingContracts == null || existingContracts.size() == 0){
                //create contract
                Contract newContract = new Contract();
                string contractName = 'ORDER-' + opp.Opportunity_Names__c + '-'
                                               + opp.Formula_Account_Name__c + '-'
                                               + string.valueOf(system.today().format());
                if(contractName.length() > 80) {
                    newContract.Name = contractName.substring(0, 80);
                }
                else {
                    newContract.Name = contractName;
                }
        
                newContract.PO__c = opp.Opportunity_ID__c;
                newContract.StartDate = system.today().toStartOfMonth();
                newContract.Contract_Type__c = 'vAuto';
                newContract.AccountId = opp.AccountId;
                newContract.Bill_To_Account__c = opp.AccountId;
                newContract.Salesperson__c = opp.Owner.Name;
                newContract.Related_Opportunity__c = opp.Id;
                newContract.Training_Included__c = getTrainingIncluded(opp);
                newContract.OwnerId = Label.API_UserId;
                newContract.Description = opp.Description;
                newContract.LOB__c = 'VAUTO';
                insert newContract;
                contract = newContract;    
            }
            else{
                contract = existingContracts[0]; 
            }
        }
        
        Set<Id> projIds = new Set<Id>();
        for(SFDC_520_Quote__c proj : [SELECT Id, Opportunity__c
                        FROM SFDC_520_Quote__c
                        WHERE Opportunity__c = :opp.Id]) {
            projIds.add(proj.Id);    
        }
        
        Map<Id, Id> oliToProjectPieceId = new Map<Id, Id>();
        for(Project_Piece__c pp : [SELECT Id, Opportunity_Line_Item_ID__c
                       FROM Project_Piece__c
                       WHERE Project__c IN :projIds]) {
            oliToProjectPieceId.put(pp.Opportunity_Line_Item_ID__c, pp.Id);                 
        }
        
        List<Billing_Item__c> newBillingItems = new List<Billing_Item__c>();
        //setup fee aggregate
        decimal setupFee = 0;
                             
        for(OpportunityLineItem oli : oppLines) {
           	//Get the project Definition
            Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(oli.PricebookEntry.Product2.Project_Definition__c);
            if(projectDefinition == null){
    	       throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oli.PricebookEntry.Product2.Name);	      
    	    }
            if(oli.PricebookEntry.Product2.Show_on_Bill__c == 'YES') {
                integer i = 1;
                integer limiter;
                if(oli.Quantity_Exception__c == 'True') {
                    limiter = 1;
                }
                else {
                    limiter = Math.round(oli.Quantity.intValue());
                }
                do {
                    Billing_Item__c newBillingItem = new Billing_Item__c();
                    newBillingItem.Subscriber_Account__c = opp.AccountId;
                    newBillingItem.Related_Opportunity__c = opp.Id;
                    //newBillingItem.CreatedById = '00570000001fBU9';
                    newBillingItem.Product_Sold__c = oli.ProductId__c;
                    newBillingItem.Start_Date__c = system.today();
                
                    if(oli.Quantity_Exception__c == 'True') {
                        //newBillingItem.Sale_Price__c = oli.UnitPrice * oli.Quantity;
                        newBillingItem.Sale_Price__c = oli.UnitPrice;
                        newBillingItem.Qty__c = oli.Quantity;
                    }
                    else {
                        newBillingItem.Sale_Price__c = oli.UnitPrice;
                        newBillingItem.Qty__c = 1;
                    }
                
                    newBillingItem.Contract__c = contract.Id;
                    newBillingItem.Related_Project_Piece__c = oliToProjectPieceId.get(oli.Id);
                	if(poaList.get(projectDefinition.POA_Type__c) == null){
      					System.Debug('NO POA is assigned to the project having ProjectDefinition Name: '+projectDefinition.Name);
      				}
      				else{
                		newBillingItem.Related_POA__c = poaList.get(projectDefinition.POA_Type__c).Id;
                		//System.debug('Is the asset line Base Asset:'+oli.PricebookEntry.Product2.Base_Product__c);
                        if(oli.PricebookEntry.Product2.Base_Product__c){
                            //System.debug('Assigning LOB Value to POA');
                            newBillingItem.LOB__c = poaList.get(projectDefinition.POA_Type__c).Id;
                        }
      				}

                    newBillingItems.add(newBillingItem);
                    i++;
                }
                while(i <= limiter);
            }
            /*
            else if(oli.Setup_Fee__c == true) {
                setupFee += oli.UnitPrice * oli.Quantity;
            }*/
        }
        //Adding check for the 'Add Promotional Credit?' field on the Opportunity
        //If set to yes then add the Promotional Credit product to the Contract
        system.debug('=================>>>> opp.Add_Promotional_Credit__c = ' + opp.Add_Promotional_Credit__c);
        system.debug('=================>>>> Before IF Statement Promo Credit');
        /*if (opp.Add_Promotional_Credit__c == 'Yes'){
            system.debug('=================>>>> In IF Statement Promo Credit');
            PricebookEntry PromoCreditPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','PV Promo');
            system.debug('=================>>>> PromoCreditPriceBookEntry = ' + PromoCreditPriceBookEntry);
            Project_Definition__c promoDefinition = StaticData.getInstance().ProjectDefinitions().get(PromoCreditPriceBookEntry.Product2.Project_Definition__c);
            //then add billed asset with product code 
            Billing_Item__c promoCreditBillingItem = new Billing_Item__c();
            promoCreditBillingItem.Subscriber_Account__c = opp.AccountId;
            promoCreditBillingItem.Related_Opportunity__c = opp.Id;
            promoCreditBillingItem.Accounting_Notes__c = opp.Promotional_Credit_Term__c;
            //promoCreditBillingItem.Start_Date__c = system.today();
            promoCreditBillingItem.Qty__c = 1;
            promoCreditBillingItem.Sale_Price__c = -1 * opp.Promotional_Credit_Amount__c;
            promoCreditBillingItem.Contract__c = contract.Id;
            promoCreditBillingItem.Product_Sold__c = PromoCreditPriceBookEntry.Product2Id;
            if(promoDefinition != null){
                if(poaList.get(promoDefinition.POA_Type__c) == null){
                    System.Debug('NO POA is assigned to the project having ProjectDefinition Name: '+promoDefinition.Name);
                }
                else{
                    promoCreditBillingItem.Related_POA__c = poaList.get(promoDefinition.POA_Type__c).Id;
                    //System.debug('Is the asset line Base Asset:'+oli.PricebookEntry.Product2.Base_Product__c);
                    if(PromoCreditPriceBookEntry.Product2.Base_Product__c){
                        //System.debug('Assigning LOB Value to POA');
                        promoCreditBillingItem.LOB__c = poaList.get(promoDefinition.POA_Type__c).Id;
                    }
                }
            }
            newBillingItems.add(promoCreditBillingItem);
        }*/

        if (opp.Opportunity_Names__c == 'Account Setup' && opp.Add_Deposit__c == 'Yes'){
            PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','DEPOSIT');
            system.debug('=================>>>> Deposit depositPriceBookEntry = ' + depositPriceBookEntry);
            Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(depositPriceBookEntry.Product2.Project_Definition__c);
            //then add billed asset with product code = DEPOSIT and Sale Price = Opportunity.Deposit Amount
            Billing_Item__c depositBillingItem = new Billing_Item__c();
            depositBillingItem.Subscriber_Account__c = opp.AccountId;
            depositBillingItem.Related_Opportunity__c = opp.Id;
            depositBillingItem.Start_Date__c = system.today();
            depositBillingItem.Qty__c = 1;
            depositBillingItem.Sale_Price__c = opp.Deposit_Amount__c;
            depositBillingItem.Contract__c = contract.Id;
            depositBillingItem.Product_Sold__c = depositPriceBookEntry.Product2Id;
            if(projectDefinition != null){
                if(poaList.get(projectDefinition.POA_Type__c) == null){
                    System.Debug('NO POA is assigned to the project having ProjectDefinition Name: '+projectDefinition.Name);
                }
                else{
                    depositBillingItem.Related_POA__c = poaList.get(projectDefinition.POA_Type__c).Id;
                    //System.debug('Is the asset line Base Asset:'+oli.PricebookEntry.Product2.Base_Product__c);
                    if(depositPriceBookEntry.Product2.Base_Product__c){
                        //System.debug('Assigning LOB Value to POA');
                        depositBillingItem.LOB__c = poaList.get(projectDefinition.POA_Type__c).Id;
                    }
                }
            }
            newBillingItems.add(depositBillingItem);
        }

        else if (opp.Opportunity_Names__c == 'Conquest' && opp.Add_Deposit__c == 'Yes'){
            system.debug('Adding conquest deposit contract line');
            PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','CQ DEPOSIT');
            //then add billed asset with product code = DEPOSIT and Sale Price = Opportunity.Deposit Amount
            Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(depositPriceBookEntry.Product2.Project_Definition__c);
            Billing_Item__c depositBillingItem = new Billing_Item__c();
            depositBillingItem.Subscriber_Account__c = opp.AccountId;
            depositBillingItem.Related_Opportunity__c = opp.Id;
            depositBillingItem.Start_Date__c = system.today();
            depositBillingItem.Qty__c = 1;
            depositBillingItem.Sale_Price__c = opp.Deposit_Amount__c;
            depositBillingItem.Contract__c = contract.Id;
            depositBillingItem.Product_Sold__c = depositPriceBookEntry.Product2Id;
            if(projectDefinition != null){
                if(poaList.get(projectDefinition.POA_Type__c) == null){
                    System.Debug('NO POA is assigned to the project having ProjectDefinition Name: '+projectDefinition.Name);
                }
                else{
                    depositBillingItem.Related_POA__c = poaList.get(projectDefinition.POA_Type__c).Id;
                    //System.debug('Is the asset line Base Asset:'+oli.PricebookEntry.Product2.Base_Product__c);
                    if(depositPriceBookEntry.Product2.Base_Product__c){
                        //System.debug('Assigning LOB Value to POA');
                        depositBillingItem.LOB__c = poaList.get(projectDefinition.POA_Type__c).Id;
                    }
                }
            }
            newBillingItems.add(depositBillingItem);
        }

        else if (opp.Opportunity_Names__c == 'Conquest Stand-Alone' && opp.Add_Deposit__c == 'Yes'){
            system.debug('Adding  Conquest Stand-Alone deposit contract line');
            PricebookEntry depositPriceBookEntry = StaticData.getInstance().GetPricebookEntry('vAuto 2014','CQ DEPOSIT');
            //then add billed asset with product code = DEPOSIT and Sale Price = Opportunity.Deposit Amount
            Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(depositPriceBookEntry.Product2.Project_Definition__c);
            Billing_Item__c depositBillingItem = new Billing_Item__c();
            depositBillingItem.Subscriber_Account__c = opp.AccountId;
            depositBillingItem.Related_Opportunity__c = opp.Id;
            depositBillingItem.Start_Date__c = system.today();
            depositBillingItem.Qty__c = 1;
            depositBillingItem.Sale_Price__c = opp.Deposit_Amount__c;
            depositBillingItem.Contract__c = contract.Id;
            depositBillingItem.Product_Sold__c = depositPriceBookEntry.Product2Id;
            if(projectDefinition != null){
                if(poaList.get(projectDefinition.POA_Type__c) == null){
                    System.Debug('NO POA is assigned to the project having ProjectDefinition Name: '+projectDefinition.Name);
                }
                else{
                    depositBillingItem.Related_POA__c = poaList.get(projectDefinition.POA_Type__c).Id;
                    //System.debug('Is the asset line Base Asset:'+oli.PricebookEntry.Product2.Base_Product__c);
                    if(depositPriceBookEntry.Product2.Base_Product__c){
                    //System.debug('Assigning LOB Value to POA');
                    depositBillingItem.LOB__c = poaList.get(projectDefinition.POA_Type__c).Id;
                    }
                }
            }
            newBillingItems.add(depositBillingItem);
        }
        /*
        if(setupFee > 0) {
            //create setup fee billing item
            Billing_Item__c setupFeeBillingItem = new Billing_Item__c();
            
            //setupFeeBillingItem.CreatedById = '00570000001fBU9';
            
            setupFeeBillingItem.Start_Date__c = system.today();
            setupFeeBillingItem.Qty__c = 1;
            setupFeeBillingItem.Sale_Price__c = setupFee;
            setupFeeBillingItem.Contract__c = contract.Id;
            setupFeeBillingItem.Product_Sold__c = [SELECT Id FROM Product2 WHERE Name = 'Account Setup' LIMIT 1].Id;
            newBillingItems.add(setupFeeBillingItem);
        }
        */
        insert newBillingItems;
    }
}