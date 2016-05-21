global class dynamicEmailHandler {

	public static sObject runQuery(ID tempID, ID sobjID){
		
		List<Template__c> tempList = [SELECT ID, Name, API_Name__c, (SELECT ID, API_Name__c, Plural_Name__c FROM Template_Merge_Fiels__r) Plural_Name__c, Body__c FROM Template__c WHERE ID = :tempID];
		
		List<sObject> sobjs = new List<sObject>();
		sObject sobj;
		
		for(Template__c t : tempList){
			String relatedTo = t.API_Name__c;
			List<String> apiNames = new List<String>();
			List<String> subQueryList = new List<String>();
			map<string,List<string>> subQueryMap = new map<string,List<string>>();			
			map<string, string> queryMap = new map<string, string>();
			for(Template_Merge_Field__c tmf : t.Template_Merge_Fiels__r){
				
				if(tmf.Plural_Name__c != null || string.isBlank(tmf.Plural_Name__c) == false){

					if(subQueryMap.containsKey(tmf.plural_name__c)){
						system.debug('Contains key');
						subQueryMap.get(tmf.plural_name__c).add(tmf.api_name__c);
					}
					else{
						subQueryMap.put(tmf.plural_name__c, new List<string>{tmf.api_name__c});
						system.debug('No key ' + tmf.plural_name__c);
					}
					string iterQuery = '';
					if(queryMap.containsKey(tmf.plural_name__c)){
						iterQuery = queryMap.get(tmf.plural_name__c);
					}
					iterQuery += tmf.api_name__c + ',';
					queryMap.put(tmf.plural_name__c, iterQuery);
				}else{
					apiNames.add(tmf.API_Name__c);
				}
			}
			
			system.debug('Q Map ' + queryMap);
			String queryString = 'Select ';
			
			for(integer i = 0; i<apiNames.size(); i++){
				
				queryString += (apiNames[i] + ', ');
			}
				queryString = queryString.trim();
				if(queryMap.size()>0){
					
				}
				else{
					queryString = queryString.removeEnd(',');
				}
				
				if(queryMap.size() > 0){
					for(String s : queryMap.keySet()){
						String fieldSet = queryMap.get(s);
						fieldSet = fieldSet.trim();
						fieldSet = fieldSet.removeEnd(',');
						queryString+='(Select ' + fieldSet + ' FROM ' + s +')';
					}
				}
				
				queryString = queryString + ' FROM ' + relatedTo.toUpperCase() + ' WHERE ID = \'' + sObjID +'\'';
				system.debug('Q String...' + queryString);
				sobj = Database.query(queryString);	
				
		}
		
		return sobj;
	}
	
	public static list<string> findColumnHeaders(Template__c template){
		List<string> colHeaders = new list<string>();
		if(template.Template_Merge_Fiels__r.size() > 0){
			for(Template_Merge_Field__c tmf : template.Template_Merge_Fiels__r){
				if(tmf.Plural_Name__c != null){
					colHeaders.add(tmf.API_Name__c);
				}
			}
		}
		return colHeaders;
	}
	
	public static list<string> findHeaderValues(Template__c template){
		list<string> colHeaders = new list<string>();
		if(template.Template_Merge_Fiels__r.size() > 0){
			for(Template_Merge_Field__c tmf : template.Template_Merge_Fiels__r){
				if(tmf.Name__c != null){
					colHeaders.add(tmf.Name__c);
				}
			}
		}
		return colHeaders;
	}
	
	public static map<string, string> findHeaderMap(Template__c template){
		map<string, string> headerMap = new map<string, string>();
		
		if(template.Template_Merge_Fiels__r.size() > 0){
			for(Template_Merge_Field__c tmf : template.Template_Merge_Fiels__r){
				if(tmf.Plural_Name__c != null && tmf.Column_Header__c != null){
					headerMap.put(tmf.API_Name__c, tmf.Column_Header__c);
				}
			}
		}
		return headerMap;
	}
	
	
	public static map<string, list<string>> findTableFields(Template__c template){
		map<string, list<string>> sets = new map<string, list<string>>();
		if(template.Template_Merge_Fiels__r.size() > 0){
			for(Template_Merge_Field__c tmf : template.Template_Merge_Fiels__r){
				if(tmf.Plural_Name__c != null){
					List<string> fieldList = new List<string>();
					if(sets.containsKey(tmf.Plural_Name__c)){
						fieldList = sets.get(tmf.Plural_Name__c);
						fieldList.add(tmf.Api_Name__c);
					}else{
						fieldList.add(tmf.API_Name__c);
						
					}
					sets.put(tmf.Plural_Name__c, fieldList);	
				}
			}
		}
		return sets;
	}
	
	public static String findStandardText(string stdText, List<Template_Merge_Field__c> mergeFields, sObject sobj){
		map<string,string> apiMap = new map<string,string>();
		List<String> completeString = new List<String>();
		for(Template_Merge_Field__c t : mergeFields){
			if(t.Plural_Name__c == null){
				apiMap.put(t.Name__c,string.valueOf(sobj.get(t.Api_Name__c)));
			}
		}
		system.debug('API Map' + apiMap);
		String str = stdText;
		//str = str.replace('<br>', '');
		for(Template_Merge_Field__c t : mergeFields){
			if(t.Plural_Name__c == null){
				system.debug(t);
				
				if(sobj.get(t.Api_Name__c) != null){
					str = str.replace(t.Name__c, string.valueOf(sobj.get(t.Api_Name__c)));
				}else{
					str = str.replace(t.Name__c, '');
				}
			}
		}
		
		return str;
	}
	
	public class tableDisplay{
		public List<sObject> objRecs 			{get;set;}
		public List<String> colHeads 			{get;set;}
		public List<String> headerValues		{get;set;}
		public map<string, string> headerMap	{get;set;}
	}
}