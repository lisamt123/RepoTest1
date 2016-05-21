public with sharing class ctrl_EmailTables {

	public ID tempID {get;set;}
	public ID RID {get;set;}

	public List<dynamicEmailHandler.tableDisplay> getTables(){
		List<dynamicEmailHandler.tableDisplay> temp = new List<dynamicEmailHandler.tableDisplay>();
		try{
		if(tempID != null && RID != null){
		Template__c mainTemplate = [Select ID, Urgency__c, Name__c, Body__c, Standard_Text__c, API_Name__c, (SELECT ID, Column_Header__c, Name, Name__c, API_Name__c, Plural_Name__c FROM Template_Merge_Fiels__r) FROM Template__c WHERE ID = :tempID];
		if(mainTemplate != null ){
			map<string,List<string>> fieldSetMap = dynamicEmailHandler.findTableFields(mainTemplate);
			sObject sobj;
			if(fieldSetMap.size() > 0){
				for(String s : fieldSetmap.keySet()){
					sobj = dynamicEmailHandler.runQuery(mainTemplate.ID, RID);
					List<sObject> objects = sObj.getSobjects(s);
					dynamicEmailHandler.tableDisplay td = new dynamicEmailHandler.tableDisplay();
					td.objRecs = objects;
					td.colHeads = dynamicEmailHandler.findColumnHeaders(mainTemplate);
					td.headerValues = dynamicEmailHandler.findHeaderValues(mainTemplate);
					try{
					td.headerMap = dynamicEmailHandler.findHeaderMap(mainTemplate);
					}catch(exception e){
					}
					system.debug('FIND THIS' + td.headerValues);
					temp.add(td);
				}
			}
		}
		}
		}catch(exception e){
			
		}
		return temp;
	}

}