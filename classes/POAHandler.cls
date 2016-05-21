public abstract class POAHandler implements IPOAHandler {
    //context-specific methods
  public virtual void beforeInsert(POA__c poa){}
  public virtual void beforeUpdate(POA__c newpoa, POA__c oldpoa){}
  public virtual void beforeDelete(POA__c poa){}
  public virtual void afterInsert(POA__c poa){}
  public virtual void afterUpdate(POA__c newpoa, POA__c oldpoa){}
  public virtual void afterDelete(POA__c poa){}
  public virtual void afterUndelete(POA__c poa){}
  
  
  public static POA__c CreatePOA(Id accountId, String poaName, RecordType poaRecordType){
  		POA__c poa = new POA__c();
		//Ramana:: Catch to make sure not to cross max 80 char limit.
	    //if the name still exceeds 80 max length
	    if(poaName.length() >= 80){
	      //get only the first 80 char.
	      poaName = poaName.substring(0,79);
	      
	    } 


	    poa.Dealer__c =  accountId;
	    poa.RecordTypeId = poaRecordType.Id;
	    poa.Name =  poaName;
	    insert poa;
	    return poa;
  }  
  //methods to override
  // methods to override 
  // 
 
  public virtual  Map<String, POA__c>  UpsertPOA(OpportunityLineItem oppLine, Map<String, POA__c> existingPOAs){

  	/*
	POA__c poa;         	
	String poaName =  StaticData.getInstance().getBUIdentifierByOppRecType(oppLine.Opportunity.RecordTypeId)+'-';
	
	if(oppLine.Opportunity.Account.Name.length() > 61){        
	    poaName  += oppLine.Opportunity.Account.Name.substring(0,58) + '...';
	}
	else {        
	     poaName  += oppLine.Opportunity.Account.Name; 
	}
	    //Product2 product = [Select Id, Project_Definition__c,Name from Product2 where Id =: oppLine.ProductId__c];
	    //if(product.Project_Definition__c == null){
	    if(oppLine.PricebookEntry.Product2.Project_Definition__c == null){
	         //throw new CoxAutomotiveException('No Project Definition Specified for Product: '+product.Name);
	         System.debug('No POA Required for product: No Project Definition Specified for Product: '+oppLine.PricebookEntry.Product2.Name);
	         
	    	return existingPOAs;	      
	    }
	    
	    Project_Definition__c productDefinition = StaticData.getInstance().ProjectDefinitions().get(oppLine.PricebookEntry.Product2.Project_Definition__c);
	    if(productDefinition == null){
	         throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oppLine.PricebookEntry.Product2.Name);	      
	    }
	    
	    //check if there is a POA existing
	    
	    String posRecordTypeName = productDefinition.POA_Type__c;
	    if(posRecordTypeName == null || posRecordTypeName.trim()==''){
	    	
	    	System.debug('No POA Required for product: '+oppLine.PricebookEntry.Product2.Name);
	    	return existingPOAs;
	    }
	    RecordType poaRecordType = StaticData.getInstance().POARecTypesMapByName.get(posRecordTypeName);
	    if(poaRecordType == null){
	    throw new CoxAutomotiveException('Could not find POA recordType :'+posRecordTypeName +' for product: '+oppLine.PricebookEntry.Product2.Name);
	    }
	    
	    System.debug('poaRecordType.Name:' + poaRecordType.Name);
	   
	    //Check if the POA is already retrived	
	    //If not find/create one and add to it
	    if(!existingPOAs.containsKey(poaRecordType.Name)){	    	
	    
	    List<POA__c> existingPOA = [Select Id from POA__c where Dealer__c =: oppLine.Opportunity.AccountId and  RecordTypeId =: poaRecordType.Id and status__c !=: 'Churned'];
	    
	    if(existingPOA != null && existingPOA.size() > 0){
	    poa = existingPOA[0];
	   
	    System.debug('Assigning Existing POA: '+poa.Id);
	    }
	    else {
	    poa = CreatePOA(oppLine.Opportunity.AccountId,poaName,poaRecordType);
	    //poa = new POA__c();
	    //poa.Dealer__c =  oppLine.Opportunity.AccountId;
	    //poa.RecordTypeId = poaRecordType.Id;
	    //poa.Name =  poaName;
	    //insert poa;
	    System.debug('Created New POA of RecordType: '+poaRecordType.Name);
	    System.debug('Created New POA: '+poa.Id);
	    }
	    
	    existingPOAs.put(poaRecordType.Name,poa);
	    }
	    
	    */
	    return existingPOAs;
	    
	}
}