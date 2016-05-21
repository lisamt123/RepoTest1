public with sharing class ctrl_addTemplateMergeField {

	public Template__c thisTemp 								{get;set;}
	public boolean standardFlag									{get;set;}
	public boolean tableFlag									{get;set;}
	public string mergeFieldType								{get;set;}
	public ID thisTempID										{get;set;}
	public list<string> tempList								{get;set;}
	public list<selectOption> childRelationshipList				{get;set;}
	public list<selectOption> fieldList							{get;set;}
	public list<selectOption> fieldListStandard					{get;set;}
	public boolean childRelationshipExists						{get;set;}
	public string childRelationshipSelected						{get;set;}
	public string fieldSelected 								{get;set;}
	public string fieldSelectedStandard							{get;set;}
	map<string,Schema.Sobjecttype> sobjMap						{get;set;}
	public boolean displayFlag									{get;set;}
	public Template_Merge_Field__c tmf 							{get;set;}
	public map<string, string> pluralMap						{get;set;}
	public map<string, string> pluralReverseMap					{get;set;}
	set<string> existingApiNames								{get;set;}
	set<string> existingApiNamesStandard						{get;set;}
	public sObject thisSObj										{get;set;}
	
	public ctrl_addTemplateMergeField(ApexPages.StandardController sc){
		standardFlag = false;
		tableFlag = false;
		sobjMap = new map<string,Schema.Sobjecttype>();
		pluralMap = new map<string,string>();
		pluralReverseMap = new map<string,string>();
		existingApiNames = new set<string>();
		existingApiNamesStandard = new set<string>();
		tmf = new Template_Merge_Field__c();
		displayFlag = false;
		thisTempID = sc.getId();
		childRelationshipExists = false;
		thisTemp = [Select ID, Api_Name__c FROM Template__c where ID =:thisTempID];
		/*
		Getting the sobject type associated with this template's api name 
		*/
		string qString = 'SELECT ID FROM ' + thisTemp.API_Name__c + ' Limit 1';
		sObject sobj = Database.query(qString);
		thisSObj = sobj;
		Schema.SObjectType sobjTyp = sobj.getSObjectType();
		Schema.DescribeSObjectResult describeResult = sobjTyp.getDescribe();
		List<Schema.ChildRelationShip> lstChildRelationships = describeResult.getChildRelationships();
		tempList = new list<string>();
		childRelationshipList = new list<selectOption>();
		
		/*
		Looping through the list of Schema.Childrelationships in order to populate a map of a string to the object 
		and a map of the object's name and it's lookup field to the template api name. 
		*/
		
		string pName = '';
		for(Schema.Childrelationship s : lstChildRelationships){
			if(s.getRelationshipName() != null){
				childRelationshipList.add(new selectOption(string.valueOf(s.getChildSobject()),string.valueOf(s.getChildSobject())));
				sobjmap.put(string.valueOf(s.getChildSobject()), s.getChildSObject());
				pluralMap.put(string.valueOf(s.getChildSobject()), s.getRelationshipName());
				pluralReverseMap.put(s.getRelationshipName(), string.valueOf(s.getChildSobject()));
			}
		}
		
		/*
		Running through existing template merge fields and checking to see if there is already a related table, 
		if so will disable choosing the child object. Also adding existing API Names for both the standard text and 
		Plural Name to ensure that the same fields cannot be added to another merge field
		*/
		
		list<Template_Merge_Field__c> tempMergeFields = new list<Template_Merge_Field__c>();
		tempMergeFields = [Select ID, Plural_Name__c, API_Name__c, Template__c FROM Template_Merge_Field__c where Template__c =:thisTemp.ID];
		
		if(tempMergeFields.size()>0){
			for(Template_Merge_Field__c t : tempMergeFields){
				if(t.Plural_Name__c != null){
					system.debug('Hitting Child RelationshipSelected ' + t.Plural_Name__c);
					pName = t.Plural_Name__c;
					childRelationshipExists = true;
					existingApiNames.add(t.API_Name__c.toUpperCase());
				}else{
					existingApiNamesStandard.add(t.API_Name__c.toUpperCase());
				}
				
			}
		}
		
		if(childRelationshipExists){
			childRelationshipSelected = pluralReversemap.get(pName);
			displayFlag = true;
			findFieldList();
		}
		
	}
	
	/*
	Template Options
	*/
	
	public list<selectOption> getTemplateTypes(){
		list<selectOption> selOps = new list<selectOption>();
		selOps.add(new selectOption('Replacement Text','Replacement Text'));
		selOps.add(new selectOption('Table Field','Table Field'));
		return selOps;
	}
	
	public void runRefresh(){
		displayFlag = true;
		system.debug(childRelationshipSelected);
		findFieldList();
	}
	
	/*
	Determine which of the select lists below to show the user, based on what kind 
	of merge field they would like to display
	*/
	
	public void findMergeFieldType(){
		if(mergeFieldType=='Table Field'){
			tableFlag = true;
		}else{
			standardFlag = true;
			findFieldListStandard();	
		}
	}
	/*
	Filling Select List with Fields from the API Name associated with the Template
	*/
	
	public void findFieldListStandard(){
		fieldListStandard = new list<selectOption>();
		
		Schema.SObjectType sobjTyp = thisSobj.getSObjectType();
		
		Schema.DescribeSObjectResult describeResult = sobjTyp.getDescribe();
		
		map<string,schema.Describefieldresult> finalMap = new map<String,schema.DescribeFieldResult>();
		
		map<String, Schema.SobjectField> objFields = sobjTyp.getDescribe().fields.getMap();
		
		for(string s : objFields.keySet()){
			if(s!=null && !existingApiNamesStandard.contains(s.toUpperCase())){
				fieldListStandard.add(new selectOption(string.valueOf(s), string.valueOf(s)));
			}
		}
		
		if(fieldListStandard.size() > 0){
			fieldListStandard.sort();
		}
	}
	
	/*
	Filling the Select Lists if the user chooses the Table Option
	*/
	
	public void findFieldList(){
		fieldList = new List<selectOption>();
		string str = childRelationshipSelected;
		system.debug('Find Me ' + childRelationShipSelected);
		Schema.SObjectType sobjTyp = sobjMap.get(childRelationshipSelected);
		
		Schema.DescribeSObjectResult describeResult = sobjTyp.getDescribe();
		
		map<string,schema.Describefieldresult> finalMap = new map<String,schema.DescribeFieldResult>();
		
		map<String, Schema.SobjectField> objFields = sobjTyp.getDescribe().fields.getMap();
		
		try{
			for(string s : objFields.keySet()){
				if(string.valueOf(s) != null && !existingApiNames.contains(string.valueOf(s).toUpperCase())){
					fieldList.add(new selectOption(string.valueOf(s), string.valueOf(s)));
				}
			}
		}catch(exception e){
			system.debug(string.valueOf(e));
		}
		
		if(fieldList.size() > 0){
			fieldList.sort();
		}
	}
	
	/*
	Save Method
	*/
	
	public PageReference saveTMF(){
		tmf.Plural_Name__c = string.valueOf(pluralMap.get(childRelationShipSelected));
		tmf.Template__c = thisTemp.ID;
		if(fieldSelected != null){
			tmf.API_Name__c = fieldSelected;
		}else{
			tmf.API_Name__c = fieldSelectedStandard;
		}
		insert tmf;		
		PageReference pr = new PageReference('/'+thisTemp.ID);
		return pr;
	}

}