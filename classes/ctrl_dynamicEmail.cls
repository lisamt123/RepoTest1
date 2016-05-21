public with sharing class ctrl_dynamicEmail {
	
	public ID RID {get;set;}
	public ID tempID {get;set;}
	public Template__c thisTemplate {get;set;}
	public String urgencyStr {get;set;}
	public User u = [Select ID, Extension, FirstName, LastName, Title, Phone, Email, SmallPhotoURL, FullPhotoUrl FROM USER WHERE ID = :Userinfo.getUserId()];
	
	public Dynamic_Email__c getDynamicEmail(){
		Dynamic_Email__c d = new Dynamic_Email__c();
		try{
			d = [SELECT Urgency_URL__c, ID, Name, Urgency__c, Template__c, Template__r.Standard_Text__c,  Main_Body__c, Sidebar_Body__c, Standard_Body__c FROM Dynamic_Email__c where ID = :RID];
			tempID = d.Template__c;
			urgencyStr = d.Urgency__c;
		}catch(exception e){
			
		}
		return d;
	}
	
	public string getExt(){
		string str = '';
		try{
			str = u.Extension;
		}catch(exception e){
			
		}
		return str;
	}

	public string getFirstname(){
		String str = '';
		try{
			str = u.FirstName;
		}catch(exception e){
			
		}
		return str;
	}
	
	public string getLastName(){
		string str = '';
		try{
			str = u.LastName;
		}catch(exception e){
			
		}
		return str;
	}
	
	public string getPhone(){
		string str = '';
		try{
			str = u.Phone;
		}catch(exception e){
			
		}
		return str;
	}
	
	public string getEmail(){
		string str = '';
		try{
			str = u.Email;
		}catch(exception e){
			
		}
		return str;
	}
	
	public String getTitle(){
		string str = '';
		try{
			str = u.Title;
		}catch(exception e){
			
		}
		return str;
	}
	
	public ID getObjID(){
		Id temp = ApexPages.currentPage().getParameters().get('sobj_ID');
		return temp;
	}

	public string getStandardText(){
		string s = '';
		
		if(RID != null){
			system.debug('RID' + rid);
			ID sobjID = ApexPages.currentPage().getParameters().get('sobj_ID');
			List<Template__c> testList = new List<Template__c>();
			testList = [Select ID, Standard_Text__c, Body__c, (SELECT ID, Name, Name__c, Plural_Name__c, API_Name__c FROM Template_Merge_Fiels__r) FROM Template__c WHERE ID = :tempId];
			thisTemplate = testList[0];
			sObject sobj = dynamicEmailHandler.runQuery(tempID, sobjID);
			s = dynamicEmailHandler.findStandardText(thisTemplate.Standard_Text__c, thisTemplate.Template_Merge_Fiels__r, sobj);
		}
		system.debug('Entire String: ' + s);
		return s;
	}
	
	public List<dynamicEmailHandler.tableDisplay> getTables(){
		List<dynamicEmailHandler.tableDisplay> temp = new List<dynamicEmailHandler.tableDisplay>();
		//Template__c mainTemplate = thisTemplate;
		Id sObjID = ApexPages.currentPage().getParameters().get('sobj_ID');
		if(tempID != null && sObjID != null){
			
			Template__c mainTemplate = [Select ID, Urgency__c, Name__c, Body__c, Standard_Text__c, API_Name__c, (SELECT ID, Column_Header__c, Name, Name__c, API_Name__c, Plural_Name__c FROM Template_Merge_Fiels__r) FROM Template__c WHERE ID = :tempID];
			if(mainTemplate != null ){
				map<string,List<string>> fieldSetMap = dynamicEmailHandler.findTableFields(mainTemplate);
				sObject sobj;
				if(fieldSetMap.size() > 0){
					for(String s : fieldSetmap.keySet()){
						sobj = dynamicEmailHandler.runQuery(tempID, sObjID);
						List<sObject> objects = sObj.getSobjects(s);
						dynamicEmailHandler.tableDisplay td = new dynamicEmailHandler.tableDisplay();
						td.objRecs = objects;
						td.colHeads = dynamicEmailHandler.findColumnHeaders(mainTemplate);
						td.headerValues = dynamicEmailHandler.findHeaderValues(mainTemplate);
						try{
						td.headerMap = dynamicEmailHandler.findHeaderMap(mainTemplate);
						}catch(exception e){
							system.debug('FML ' + e);
						}
						system.debug('FIND THIS' + td.headerValues);
						temp.add(td);
					}
				}
			}
		}
		
		return temp;
	}
	
	/*
	Had to switch to storing the images as documents, leaving this in here commented if
	there is a need to grab a static resource at some point
	*/
	/*
	public string findResourceURL(String resourceName){
		
		List<StaticResource> resourceList = [SELECT Name, NamespacePrefix, SystemModStamp
											 From StaticResource
											 Where Name = :resourceName];
											 
		if(resourceList.size() == 1){
			String namespace = resourceList[0].NamespacePrefix;
   			return 'https://cs12.salesforce.com/resource/' 
      		+ resourceList[0].SystemModStamp.getTime() + '/' 
      		+ (namespace != null && namespace != '' ? namespace + '__' : '') 
     	    + resourceName; 	
		}else return '';
		
		return resourceName;
	}
	*/
	public String getThisID(){
		return rID;
	}
	
	

}