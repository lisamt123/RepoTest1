public class StaticData { 
private static StaticData instance = null;
public static final string vAutoIdenitifer = 'VAT';
public static final string vinIdenitifer = 'VIN';
public static final string hayStakIdenitifer = 'HAY';

// The constructor is private
private StaticData(){

}



public Boolean isVAutoOppRecType(Id recTypeId){
	 
	 return (recTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('vAuto').Id
	 
	 || recTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('vAuto_Conquest').Id);
}
public  Boolean isVINOppRecType(Id recTypeId){
		      return ( recTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('General_Sales').Id);
}

public  Boolean isHayStakOppRecType(Id recTypeId){
      return (recTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('Digital_Marketing').Id);      	      	
}


public  String getBUIdentifierByOppRecType(Id recTypeId){	
	if(isVAutoOppRecType(recTypeId)){
		return vAutoIdenitifer;
	}
	else if(isVINOppRecType(recTypeId)){
		return vinIdenitifer;
	}
	else if(isHayStakOppRecType(recTypeId)){
		return hayStakIdenitifer;
	}
	return '';
}

// a static method that returns the instance of the record type
public static StaticData getInstance(){
// lazy load the record type - only initialize if it doesn't already exist
if(instance == null) instance = new StaticData();
	return instance;
}

//Opportunity Record Types
//Usage: StaticData.getInstance().OpportunityRecTypesMap
private Map<Id,RecordType> oppRecTypesMap;
public Map<Id,RecordType> OpportunityRecTypesMap{
get{
		if(oppRecTypesMap == null){
			LoadOpportunityTypes();
		}		
		return oppRecTypesMap;
}
}

private Map<String,RecordType> oppRecTypesMapByDevName;
public Map<String,RecordType> OpportunityRecTypesMapByDevName{
get{
		if(oppRecTypesMapByDevName == null){
			LoadOpportunityTypes();
		}		
		return oppRecTypesMapByDevName;
}
}

	
private void LoadOpportunityTypes(){	
	oppRecTypesMap = new Map<Id,RecordType>();	
    oppRecTypesMapByDevName = new Map<String,RecordType>();
	for(RecordType recType: [Select Id,DeveloperName,Name,SObjectType from RecordType where SObjectType = 'Opportunity' and IsActive = true]){				
		oppRecTypesMap.put(recType.Id,recType);
		oppRecTypesMapByDevName.put(recType.DeveloperName,recType);
	}
}
	
//Project Record Types
private Map<Id,RecordType> projRecTypesMap;
public Map<Id,RecordType> ProjectRecTypesMap{
get{
		if(projRecTypesMap == null){
			LoadProjectTypes();
		}		
		return projRecTypesMap;
}
}

private Map<String,RecordType> projRecTypesMapByDevName;
public Map<String,RecordType> ProjectRecTypesMapByDevName{
get{
		if(projRecTypesMapByDevName == null){
			LoadProjectTypes();
		}		
		return projRecTypesMapByDevName;
}
}

private Map<String,RecordType> projRecTypesMapByName;
public Map<String,RecordType> ProjectRecTypesMapByName{
get{
		if(projRecTypesMapByName == null){
			LoadProjectTypes();
		}		
		return projRecTypesMapByName;
}
}	 
private void LoadProjectTypes(){	
	projRecTypesMap = new Map<Id,RecordType>();	
    projRecTypesMapByDevName = new Map<String,RecordType>();
    projRecTypesMapByName = new Map<String,RecordType>(); 
	for(RecordType recType: [Select Id,DeveloperName,Name,SObjectType from RecordType where SObjectType = 'SFDC_520_Quote__c' and IsActive = true]){				
		projRecTypesMap.put(recType.Id,recType);
		projRecTypesMapByDevName.put(recType.DeveloperName,recType);
		projRecTypesMapByName.put(recType.Name,recType);
	}
}

//ProjectPieces Record Types
private Map<Id,RecordType> projPiecesRecTypesMap;
public Map<Id,RecordType> ProjectPiecesRecTypesMap{
get{
		if(projPiecesRecTypesMap == null){
			LoadProjectPiecesTypes();
		}		
		return projPiecesRecTypesMap;
}
}

private Map<String,RecordType> projPiecesRecTypesMapByDevName;
public Map<String,RecordType> ProjectPiecesRecTypesMapByDevName{
get{
		if(projPiecesRecTypesMapByDevName == null){
			LoadProjectPiecesTypes();
		}		
		return projPiecesRecTypesMapByDevName;
}
}
	
private void LoadProjectPiecesTypes(){	
	projPiecesRecTypesMap = new Map<Id,RecordType>();	
    projPiecesRecTypesMapByDevName = new Map<String,RecordType>();
	for(RecordType recType: [Select Id,DeveloperName,Name,SObjectType from RecordType where SObjectType = 'Project_Piece__c' and IsActive = true]){				
		projPiecesRecTypesMap.put(recType.Id,recType);
		projPiecesRecTypesMapByDevName.put(recType.DeveloperName,recType);
	}
}

//POA Record Types
private Map<Id,RecordType> poa_RecTypesMap;
public Map<Id,RecordType> POARecTypesMap{
get{
		if(poa_RecTypesMap == null){
			LoadPOATypes();
		}		
		return poa_RecTypesMap;
}
}

private Map<String,RecordType> poa_RecTypesMapByDevName;
public Map<String,RecordType> POARecTypesMapByDevName{
get{
		if(poa_RecTypesMapByDevName == null){
			LoadPOATypes();
		}		
		return poa_RecTypesMapByDevName;
}
}

private Map<String,RecordType> poa_RecTypesMapByName;
public Map<String,RecordType> POARecTypesMapByName{
get{
		if(poa_RecTypesMapByName == null){
			LoadPOATypes();
		}		
		return poa_RecTypesMapByName;
}
}
	
private void LoadPOATypes(){	
	poa_RecTypesMap = new Map<Id,RecordType>();	
    poa_RecTypesMapByDevName = new Map<String,RecordType>();
    poa_RecTypesMapByName= new Map<String,RecordType>();
	for(RecordType recType: [Select Id,DeveloperName,Name,SObjectType from RecordType where SObjectType = 'POA__c' and IsActive = true]){				
		poa_RecTypesMap.put(recType.Id,recType);
		poa_RecTypesMapByDevName.put(recType.DeveloperName,recType);
		poa_RecTypesMapByName.put(recType.Name,recType);
	}
}


//Contract Record Types
private Map<Id,RecordType> contract_RecTypesMap;
public Map<Id,RecordType> ContractRecTypesMap{
get{
		if(contract_RecTypesMap == null){
			LoadContractTypes();
		}		
		return contract_RecTypesMap;
}
}

private Map<String,RecordType> contract_RecTypesMapByDevName;
public Map<String,RecordType> ContractRecTypesMapByDevName{
get{
		if(contract_RecTypesMapByDevName == null){
			LoadContractTypes();
		}		
		return contract_RecTypesMapByDevName;
}
}
	
private void LoadContractTypes(){	
	contract_RecTypesMap = new Map<Id,RecordType>();	
    contract_RecTypesMapByDevName = new Map<String,RecordType>();
	for(RecordType recType: [Select Id,DeveloperName,Name,SObjectType from RecordType where SObjectType = 'Contract' and IsActive = true]){				
		contract_RecTypesMap.put(recType.Id,recType);
		contract_RecTypesMapByDevName.put(recType.DeveloperName,recType);
	}
}

//BillingItem Record Types
private Map<Id,RecordType> billingItem_RecTypesMap;
public Map<Id,RecordType> BillingItemRecTypesMap{
get{
		if(billingItem_RecTypesMap == null){
			LoadBillingItemTypes();
		}		
		return billingItem_RecTypesMap;
}
}

private Map<String,RecordType> billingItem_RecTypesMapByDevName;
public Map<String,RecordType> BillingItemRecTypesMapByDevName{
get{
		if(billingItem_RecTypesMapByDevName == null){
			LoadBillingItemTypes();
		}		
		return billingItem_RecTypesMapByDevName;
}
}
	
private void LoadBillingItemTypes(){	
	billingItem_RecTypesMap = new Map<Id,RecordType>();	
    billingItem_RecTypesMapByDevName = new Map<String,RecordType>();
	for(RecordType recType: [Select Id,DeveloperName,Name,SObjectType from RecordType where SObjectType = 'Billing_Item__c' and IsActive = true]){				
		billingItem_RecTypesMap.put(recType.Id,recType);
		billingItem_RecTypesMapByDevName.put(recType.DeveloperName,recType);
	}
}

private Map<Id,Project_Definition__c> ProjDefinitions;
public Map<Id,Project_Definition__c> ProjectDefinitions(){
 	if(ProjDefinitions == null){ 	
 		ProjDefinitions = new Map<Id,Project_Definition__c> ();
 		for (Project_Definition__c projDef :[SELECT isActive__c
 			,POA_Type__c
 			, Project_Category__c
 			, Project_Record_Type__c
 			, Name
 			, Id
 			, Default_Project_Owner__c
 			, Default_POA_Owner__c
 			, NeedProjectPieces__c
 			, Project_Short_Code__c
 			, Project_Priority__c
 			, Project_Type__c
 			 FROM Project_Definition__c where isActive__c = true]){
 			ProjDefinitions.put(projDef.Id, projDef);
 		} 
 	}
	return ProjDefinitions;
}


private Map<String,RecordType> task_RecordTypesMapByDevName;
public Map<String,RecordType> TaskRecordTypeMapByDevName{
get{
		if(task_RecordTypesMapByDevName == null){
			LoadTaskRecordTypes();
		}		
		return task_RecordTypesMapByDevName;
}
}
	
private void LoadTaskRecordTypes(){	
    task_RecordTypesMapByDevName = new Map<String,RecordType>();
	for(RecordType recType: [Select Id,DeveloperName,Name,SObjectType from RecordType where SObjectType = 'Task' and IsActive = true]){				
		task_RecordTypesMapByDevName.put(recType.DeveloperName,recType);
	}
}

//Case Record Types
//Usage: StaticData.getInstance().CaseRecTypesMap
private Map<Id,RecordType> case_RecordTypesMap;
public Map<Id,RecordType> CaseRecTypesMap{
get{
		if(case_RecordTypesMap == null){
			LoadCaseTypes();
		}		
		return case_RecordTypesMap;
}
}

private Map<String,RecordType> case_RecordTypesMapByDevName;
public Map<String,RecordType> CaseRecTypesMapByDevName{
get{
		if(case_RecordTypesMapByDevName == null){
			LoadCaseTypes();
		}		
		return case_RecordTypesMapByDevName;
}
}

private Map<String,RecordType> case_RecordTypesMapByName;
public Map<String,RecordType> CaseRecTypesMapByName{
get{
		if(case_RecordTypesMapByName == null){
			LoadCaseTypes();
		}		
		return case_RecordTypesMapByName;
}
}
	
private void LoadCaseTypes(){
	case_RecordTypesMap = new Map<Id,RecordType>();	
    case_RecordTypesMapByDevName = new Map<String,RecordType>();
	case_RecordTypesMapByName = new Map<String,RecordType>();
	for(RecordType recType: [Select Id, DeveloperName, Name, SObjectType from RecordType where SObjectType = 'Case' and IsActive = true]){				
		case_RecordTypesMap.put(recType.Id, recType);
		case_RecordTypesMapByDevName.put(recType.DeveloperName, recType);
		case_RecordTypesMapByName.put(recType.Name,recType);
	}
}

//Account Record Types
private Map<Id,RecordType> acctRecTypesMap;
public Map<Id,RecordType> AccountRecTypesMap{
get{
		if(acctRecTypesMap == null){
			LoadAccountTypes();
		}		
		return acctRecTypesMap;
}
}

private Map<String,RecordType> acctRecTypesMapByDevName;
public Map<String,RecordType> AccountRecTypesMapByDevName{
get{
		if(acctRecTypesMapByDevName == null){
			LoadAccountTypes();
		}		
		return acctRecTypesMapByDevName;
}
}

private Map<String,RecordType> acctRecTypesMapByName;
public Map<String,RecordType> AccountRecTypesMapByName{
get{
		if(acctRecTypesMapByName == null){
			LoadProjectTypes();
		}		
		return acctRecTypesMapByName;
}
}	 
private void LoadAccountTypes(){	
	acctRecTypesMap = new Map<Id,RecordType>();	
    acctRecTypesMapByDevName = new Map<String,RecordType>();
    acctRecTypesMapByName = new Map<String,RecordType>(); 
	for(RecordType recType: [Select Id,DeveloperName,Name,SObjectType from RecordType where SObjectType = 'Account' and IsActive = true]){				
		acctRecTypesMap.put(recType.Id,recType);
		acctRecTypesMapByDevName.put(recType.DeveloperName,recType);
		acctRecTypesMapByName.put(recType.Name,recType);
	}
}

private Map<String, Pricebook2> priceBook_ByName;
public Map<String,Pricebook2> PriceBookByName{
get{
		if(priceBook_ByName == null){
			LoadPriceBooks();
		}		
		return priceBook_ByName;
}
}

private void LoadPriceBooks(){	
    priceBook_ByName = new Map<String,Pricebook2>();
	for(Pricebook2 priceBook: [SELECT IsActive, Description, IsStandard, Id, Name FROM Pricebook2
	where IsActive = true]){				
		priceBook_ByName.put(priceBook.Name,priceBook);
	}
}

private Map<String, PricebookEntry> productsByCodeAndPriceBook;
public  PricebookEntry GetPricebookEntry(string priceBookName,String productCode){
   Pricebook2 priceBook = PriceBookByName.get(priceBookName);
   if(priceBook == null){
   		throw new CoxAutomotiveException('Could not find Price Book: '+priceBookName);
   }
   string productKey = productCode+'_'+priceBook.Name;

   if(productsByCodeAndPriceBook == null || !productsByCodeAndPriceBook.containsKey(productKey)){
	List<PricebookEntry> priceBookEntry = [SELECT IsActive, UnitPrice, Id, Pricebook2Id, ProductCode, Product2Id, Name, UseStandardPrice, Product2.Project_Definition__c,Product2.Base_Product__c FROM PricebookEntry 
	where Pricebook2Id =: priceBook.Id and ProductCode =: productCode and IsActive = true];
   	if(priceBookEntry== null || priceBookEntry.size() ==0){
      throw new CoxAutomotiveException('Could not find Product: '+productCode+ ' in Price Book: '+priceBook.Name);
   	}
   	if(productsByCodeAndPriceBook == null){ productsByCodeAndPriceBook = new Map<String, PricebookEntry>();}
   	productsByCodeAndPriceBook.put(productKey,priceBookEntry[0]);   
	}
 	return productsByCodeAndPriceBook.get(productKey);   
}


public Static Set<String> DisabledTriggers {
	get{
	Set<string> setOfDisabledTriggers = new Set<string>();
	TriggerDisable__c CS = TriggerDisable__c.getValues(UserInfo.getUserId());
	if(CS != null && CS.ListOfTriggerToDisable__c != null && CS.ListOfTriggerToDisable__c !=''){
		String[]  results = CS.ListOfTriggerToDisable__c.split('\r\n', 0);
		for(string item : results){				
		    //system.debug('item: '+ item);
		    if(!setOfDisabledTriggers.contains(item)){
		    	setOfDisabledTriggers.add(item);
		    }
		}

		//list
		//for(string setitem : setOfDisabledTriggers){		
		// system.debug('setitem: '+ setitem);		
		//}
	}		
	return setOfDisabledTriggers;
}
}

}