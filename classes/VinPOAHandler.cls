public class VinPOAHandler  extends POAHandler{ 
  
   /*  public override void beforeInsert(POA__c poa){
    	system.debug('setting Vin Performance Manager POA on inserted');
        setVinPerformanceManager(poa);
    }
    
    public override void beforeUpdate(POA__c newpoa,POA__c oldpoa){
    	system.debug('setting Vin Performance Manager POA on update');
    	if(newpoa.Dealer__c !=null && newpoa.Dealer__c != oldpoa.Dealer__c){
        setVinPerformanceManager(newpoa);
    	}
    }

    private void setVinPerformanceManager(POA__c poa){
	 	if(poa.Dealer__c == null) {return;}

	   	List<AccountTeamMember> teamMembers = [Select Id from AccountTeamMember
	   	where AccountId =: poa.Dealer__c
	   	and TeamMemberRole =: 'Vin Performance Manager'];
	   	if(teamMembers.size()> 0){ 
	   		System.debug('Setting the Vin Performance Manager on POA');
	   		poa.VinPro_Manager__c = teamMembers[0].userId;
	   	}
	 }*/ 
  public override  Map<String, POA__c>  UpsertPOA(OpportunityLineItem oppLine, Map<String, POA__c> existingPOAs){
	POA__c poa;         	

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
	    poa = new POA__c();
 
	    String poaName =  productDefinition.POA_Type__c+'-';
	
			if(oppLine.Opportunity.Account.Name.length() >= 61){        
	    	poaName  += oppLine.Opportunity.Account.Name.substring(0,60) + '...'+'-';
		}
		else {        
	     poaName  += oppLine.Opportunity.Account.Name+'-'; 
		}

	poaName  += system.today().format();


	// check name length
	//If length exceeds 80; try to take the excceded char count from account Name
    if(poaName.length() >= 80){
      try{
      Integer exceededCharCount =  poaName.length() - 80;
      if(oppLine.Opportunity.Account.Name.length() > 41){
          poaName = productDefinition.POA_Type__c+'-'+oppLine.Opportunity.Account.Name.substring(0,41-exceededCharCount);
        }
        else{
           poaName = productDefinition.POA_Type__c+'-'+oppLine.Opportunity.Account.Name.substring(0,oppLine.Opportunity.Account.Name.length() - exceededCharCount);
        }
        poaName  += system.today().format();
      } 
      Catch(Exception ex){
        //Being cautious
        //For some reason there is a error while trying to get the right split;
        //it is not end of the world; let's continue by truncating from the end;
        //Users can still have an option to change the name; instead of erroring out on 
        //creation all together;
      }
    }

    //Ramana:: Catch to make sure not to cross max 80 char limit.
    //if the name still exceeds 80 max length
    if(poaName.length() >= 80){
      //get only the first 80 char.
      poaName = poaName.substring(0,79);
      
    } 

	    if(productDefinition.Default_POA_Owner__c != null){	    
	    poa.OwnerId = productDefinition.Default_POA_Owner__c;
		}
	    poa.Dealer__c =  oppLine.Opportunity.AccountId;
	    poa.RecordTypeId = poaRecordType.Id;
	    poa.Name =  poaName;
	    insert poa;	   
	    System.debug('Created New POA of RecordType: '+poaRecordType.Name);
	    System.debug('Created New POA: '+poa.Id);
	    }
	    
	    existingPOAs.put(poaRecordType.Name,poa);
	    }
	    
	    
	    return existingPOAs;
	}
    
}