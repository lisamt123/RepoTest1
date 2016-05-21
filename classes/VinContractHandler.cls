public class VinContractHandler extends ContractHandler{  
    // methods to override    



public override void createContractAndBillingItems(Opportunity opp,List<OpportunityLineItem> oppLines,Map<String,POA__c> poaList) {

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
    newContract.Status = 'Draft';
    newContract.Action__c = 'Add';
    newContract.RecordTypeId = StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD').Id;
    newContract.Integration_Status__c = 'Pending';
    newContract.StartDate = system.today();
    newContract.Contract_Type__c = opp.Type;
    newContract.AccountId = opp.AccountId;
    newContract.Bill_To_Account__c = opp.AccountId;
    newContract.Salesperson__c = opp.Owner.Name;
    newContract.Related_Opportunity__c = opp.Id;
    newContract.Training_Included__c = getTrainingIncluded(opp);
    newContract.OwnerId = Label.API_UserId;
    newContract.Description = opp.Description;
    newContract.LOB__c = 'VINSOLUTIONS';
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
            newBillingItem.Subscriber_Account__c = opp.AccountId;
            newBillingItem.Product_Sold__c = oli.ProductId__c;
              newBillingItem.Action__c = 'Add';
              newBillingItem.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id;
              newBillingItem.Integration_Status__c = 'Pending';
             //For Monthly Reoccurring 
             //Create a deferred lines; start 6 mnonths out 
             //since there is an advance payment line created below       
             
            /*Ramana: 11/07/2014 Mark asked to comment since these values are updated by workflow.     
             if(oli.UnitPrice > 0 && oli.PricebookEntry.Product2.Family == 'Monthly Reoccuring') {
              newBillingItem.Bill_Now__c = false;
              newBillingItem.Start_Date__c = system.today().addMonths(6);
              newBillingItem.Bill_Period_Code__c = 'FUTUREM';
              newBillingItem.Recurring_Flag__c = 'BP';
             }
             else{
             newBillingItem.Bill_Now__c = true;
              newBillingItem.Start_Date__c = system.today();
            }
            */
            
            
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
            
          //create Prepaid Product BillingItem
          if(oli.UnitPrice > 0 && oli.PricebookEntry.Product2.Family == 'Monthly Reoccuring') {


              
              Billing_Item__c prepaidBillingItem = new Billing_Item__c();
            prepaidBillingItem.Subscriber_Account__c = opp.AccountId;
              prepaidBillingItem.Bill_Now__c = true;
              prepaidBillingItem.Action__c = 'Add';
              prepaidBillingItem.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id;
              prepaidBillingItem.Integration_Status__c = 'Pending';
              prepaidBillingItem.Prepaid_Product__c = true;
              prepaidBillingItem.Use_Alternate_Description__c = true;
              prepaidBillingItem.Alternate_Product_Description__c = oli.PricebookEntry.Product2.Name + ' Advance Payment';
              
              prepaidBillingItem.Product_Sold__c = oli.ProductId__c;
              prepaidBillingItem.Start_Date__c = system.today();
              prepaidBillingItem.Qty__c = 1;
              prepaidBillingItem.Sale_Price__c = oli.UnitPrice;
              prepaidBillingItem.Contract__c = newContract.Id;
              prepaidBillingItem.Related_Project_Piece__c = oliToProjectPieceId.get(oli.Id);
                  if(poaList.get(projectDefinition.POA_Type__c) == null){
            System.Debug('NO POA is assigned to the project having ProjectDefinition Name: '+projectDefinition.Name);
          }
          else{
                newBillingItem.Related_POA__c = poaList.get(projectDefinition.POA_Type__c).Id;
              }
              
              newBillingItems.add(prepaidBillingItem);
            } 
  

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
            setupFeeBillingItem.Subscriber_Account__c = opp.AccountId;                    
           setupFeeBillingItem.Bill_Now__c = true;
           setupFeeBillingItem.Action__c = 'Add';
           setupFeeBillingItem.RecordTypeId = StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id;
           setupFeeBillingItem.Integration_Status__c = 'Pending';
            setupFeeBillingItem.Start_Date__c = system.today();
            setupFeeBillingItem.End_Date__c = setupFeeBillingItem.Start_Date__c.addMonths(14);
            setupFeeBillingItem.Qty__c = 1;
            setupFeeBillingItem.Sale_Price__c = setupFee;
            setupFeeBillingItem.Contract__c = newContract.Id;
            setupFeeBillingItem.Product_Sold__c = [SELECT Id FROM Product2 WHERE Name = 'Account Setup' LIMIT 1].Id;
            newBillingItems.add(setupFeeBillingItem);
        }
      
       insert newBillingItems;
     
     
 }
}