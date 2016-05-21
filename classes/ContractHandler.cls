public abstract class  ContractHandler implements IContractHandler{
  //context-specific methods
  public virtual void beforeInsert(Contract contract){}
  public virtual void beforeUpdate(Contract newContract, Contract oldContract){}
  public virtual void beforeDelete(Contract contract){}
  public virtual void afterInsert(Contract contract){}
  
  public virtual void afterDelete(Contract contract){}
  public virtual void afterUndelete(Contract contract){}
  


    // methods to override 

public virtual void afterUpdate(Contract newContract, Contract oldContract){
  //only apply the ReadyTOBill logic to VinSolutions
if( newContract.RecordTypeId ==  StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD').Id 
   && newContract.Ready_To_Bill__c == true
   && newContract.LOB__c == 'VINSOLUTIONS' 
   && newContract.Status == 'Draft') {

      //only get lines which are ADD record type
      List<Billing_Item__c> updateBillingItems = [SELECT Id, Ready_To_Bill__c
                  FROM Billing_Item__c
                  WHERE Contract__c =:newContract.Id
                  AND RecordTypeId =:StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id];                  
      for(Billing_Item__c bi : updateBillingItems) {        
        bi.Ready_To_Bill__c = true;
      }                        
      update updateBillingItems;
}
//Cancel
/*Ramana: 12/29/2014 Maggie confirmed that we should not cancel anything; and SOA server will take care of cancellation*/
/*
else if(newContract.RecordTypeId ==  StaticData.getInstance().ContractRecTypesMapByDevName.get('Cancel_Contract').Id ){

  List<Billing_Item__c> updateBillingItems  = [SELECT Id, RecordTypeId, End_Date__c, Contract__c, Action__c
                  FROM Billing_Item__c
                  WHERE Contract__c =:newContract.Id
                  AND Action__c !=: 'Cancelled'];

                    for(Billing_Item__c bi : updateBillingItems) {
          
                bi.Action__c = 'Cancelled';
              bi.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('CANCEL').Id; 
              bi.End_Date__c = newContract.EndDate;             
          }

          update updateBillingItems;
}*/

  
}


    public virtual void createContractAndBillingItems(Opportunity opp,List<OpportunityLineItem> oppLines,Map<String,POA__c> poaList) {

System.debug('Creating a contract');
  opp.Contract_Generated__c = true;
    
    //create contract
    Contract newContract = new Contract();
    
    string contractName = 'ORDER-' + opp.Opportunity_Names__c + '-' + opp.Formula_Account_Name__c + '-' + string.valueOf(system.today().format());
    
    if(contractName.length() > 80) {
      
      newContract.Name = contractName.substring(0, 80);
    }
    else {
      
      newContract.Name = contractName;
    }
    
    newContract.PO__c = opp.Opportunity_ID__c;
    newContract.StartDate = system.today();
    newContract.Contract_Type__c = opp.Type;
    newContract.AccountId = opp.AccountId;
    newContract.Bill_To_Account__c = opp.AccountId;
    newContract.Salesperson__c = opp.Owner.Name;
    newContract.Related_Opportunity__c = opp.Id;
    newContract.Training_Included__c = getTrainingIncluded(opp);
    newContract.OwnerId = Label.API_UserId;
    newContract.Description = opp.Description;
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
    
     insert newContract;
     

      
      List<Billing_Item__c> newBillingItems = new List<Billing_Item__c>();
      
       //setup fee aggregate
      decimal setupFee = 0;
                         
      for(OpportunityLineItem oli : oppLines) {
       	//Get the project Definition
  	  Project_Definition__c projectDefinition = StaticData.getInstance().ProjectDefinitions().get(oli.PricebookEntry.Product2.Project_Definition__c);
  	      if(projectDefinition == null){
	         throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oli.PricebookEntry.Product2.Name);	      
	    }
         if((projectDefinition.Default_Project_Owner__c != null || oli.TNOPPST__LineTax__c != null) && oli.Setup_Fee__c == false && oli.PricebookEntry.Product2.Show_on_Bill__c == 'YES') {
         
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
            
            newBillingItem.Contract__c = newContract.Id;
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
          else if(oli.Setup_Fee__c == true) {
          
          setupFee += oli.UnitPrice * oli.Quantity;
        }
          
      }
      
        if(setupFee > 0) {
            //create setup fee billing item
            Billing_Item__c setupFeeBillingItem = new Billing_Item__c();
            
            //setupFeeBillingItem.CreatedById = '00570000001fBU9';
            
            setupFeeBillingItem.Start_Date__c = system.today();
            setupFeeBillingItem.Qty__c = 1;
            setupFeeBillingItem.Sale_Price__c = setupFee;
            setupFeeBillingItem.Contract__c = newContract.Id;
            setupFeeBillingItem.Product_Sold__c = [SELECT Id FROM Product2 WHERE Name = 'Account Setup' LIMIT 1].Id;
            newBillingItems.add(setupFeeBillingItem);
        }
      
       insert newBillingItems;
     
     
 }
 
     public static string getTrainingIncluded(Opportunity opp) {
        
        boolean training = false;
        
        for(SFDC_520_Quote__c proj : [SELECT Id, Training_Included__c
                                      FROM SFDC_520_Quote__c
                                      WHERE Opportunity_Id__c = :opp.Id]) {
            
            if(proj.Training_Included__c == true) {
                
                training = true;
            }                       
        }
        
        string trainingIncluded;
        
        if(training == true) {
            
            trainingIncluded = 'Yes';
        }
        else if(training == false) {
            
            trainingIncluded = 'No';
        }
        
        return trainingIncluded;
    }
}