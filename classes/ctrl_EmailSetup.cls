public with sharing class ctrl_EmailSetup {

	public list<String> bannerOptions {get;set;}
	public String roleID {get;set;}
	public String urgency {get;set;}
	public String sidebarRadio {get;set;}
	public String bodyRadio {get;set;}
	public boolean mainBodyFlag {get;set;}
	public boolean sideBodyFlag {get;set;}
	public boolean tempSelectedFlag {get;set;}
	public integer tempNum {get;set;}
	public List<Template__c> tempList {get;set;}
	public Template__c temp {get;set;}
	public string relatedToID {get;set;}
	public string UrgencyImage {get;set;}
	public sObject sobj {get;set;}

	public Template__c mainTemplate {get;set;}
	public Dynamic_Email__c dynamicEmail {get;set;}
	
	public ctrl_EmailSetup(){
		relatedToID = ApexPages.currentPage().getParameters().get('relatedToID');
		dynamicEmail = new Dynamic_Email__c();
		mainTemplate = new Template__c();
		tempSelectedFlag = false;
		
	}

	public List<SelectOption> getTemplateOptions(){
		List<SelectOption> selOps = new List<SelectOption>();
		tempList = new List<Template__c>();
		string api = ' ';
		
		/*At some point in this conroller you have to know what object you are dealing with. 
		For all future objects please just add another else if below. 
		*/
		map<string, schema.Sobjecttype> gd = schema.getGlobalDescribe();
		map<string, string> keyPrefixMap = new map<string, string>();
		set<string> keyPrefixSet = gd.keySet();
		
		for(String str : gd.keySet()){
			Schema.DescribeSObjectResult r = gd.get(str).getDescribe();
			string tempName = r.getName();
			string tempPrefix = r.getKeyPrefix();
			system.debug('Processing Object[' + tempName+ '] with Prefix ['+tempPrefix+']');
			keyPrefixMap.put(tempPrefix,tempName);
		}
		
		api = keyPrefixMap.get(relatedToID.substring(0,3));
		/*
		if(relatedToID.startsWith(Schema.SObjectType.POA__c.getKeyPrefix())){
			api = 'POA__c';
		}else if(relatedToID.startsWith(Schema.SObjectType.Account.getKeyPrefix())){
			api = 'Account';
		}else if(relatedToID.startswith(Schema.SObjectType.Opportunity.getKeyPrefix())){
			api = 'Opportunity';
		}else if(relatedToID.startswith(Schema.SObjectType.SFDC_520_Quote__c.getKeyPrefix())){
			api = 'SFDC_520_Quote__c';
		}
		*/
		
		

		tempList = [Select ID, Activity_Subject__c, Urgency__c, Name__c, Body__c, Default_Email_Subject__c, Standard_Text__c, API_Name__c, (SELECT ID, Name, Name__c, API_Name__c, Plural_Name__c FROM Template_Merge_Fiels__r) FROM Template__c Where API_Name__c = : api];
		integer counter = 0;
		if(tempList.size() > 0){
			for(Template__c t : tempList){
				selOps.add(new selectOption(string.valueOf(counter), t.Name__c));
				counter +=1;
			}
		}
		return selOps;
	}

	public void findTemplate(){
		mainTemplate = tempList[integer.valueOf(tempNum)];
		tempSelectedFlag = true;
	}

	public void findUserInfo(){
		roleID = userInfo.getUserRoleId();
	}
	
	public string getStandardText(){
		string standardText = '';
		if(mainTemplate != null){
			sobj = dynamicEmailHandler.runQuery(mainTemplate.ID, relatedToID);
			standardText = dynamicEmailHandler.findStandardText(mainTemplate.Standard_Text__c, mainTemplate.Template_Merge_Fiels__r, sobj);
		}
		system.debug('Entire Standard: ' + standardText);
		return standardText;
	}
	
	
	public void findUrgencyImage(){
		UrgencyImage = '';
		if(dynamicEmail.Urgency__c == 'Critical'){
			UrgencyImage = 'https://c.cs12.content.force.com/servlet/servlet.FileDownload?file=015V0000000574J';
		}else if(dynamicEmail.Urgency__c == 'Normal'){
			UrgencyImage = 'https://c.cs12.content.force.com/servlet/servlet.ImageServer?id=015V0000000574O&oid=00DV0000006NEHJ&lastMod=1358267610000';
		}else if(dynamicEmail.Urgency__c == 'Low'){
			UrgencyImage = 'https://c.cs12.content.force.com/servlet/servlet.ImageServer?id=015V0000000574T&oid=00DV0000006NEHJ&lastMod=1358267675000';
		}
	}
	
	public PageReference runHandler(){
		dynamicEmail.Template__c = mainTemplate.Id;
		ID sobjID = relatedToID;
		Schema.Sobjecttype token = sobjID.getSObjectType();
		system.debug('Token ' + token.getDescribe().getName());
		
		if(token.getDescribe().getName() == 'POA__c'){
			dynamicEmail.Related_POA__c = sobjID;
		}else if(token.getDescribe().getName()== 'SFDC_520_Quote__c'){
			dynamicEmail.Related_Project__c = sobjID;
		}
		
		dynamicEmail.Standard_Body__c = dynamicEmailHandler.findStandardText(mainTemplate.Standard_Text__c, mainTemplate.Template_Merge_Fiels__r, sobj);
		insert dynamicEmail;
		
		Task t = new task();
		t.WhatId = relatedToId;
		t.Status = 'Completed';
		t.Type = 'Email';
		t.ActivityDate = date.today();
		t.Subject = 'Email – WFU – [' + mainTemplate.Activity_Subject__c + ']';
		//t.Description =  mainTemplate.Standard_Text__c + '\r\n' +  dynamicEmail.Main_Body__c+ '\r\n' + dynamicEmail.Sidebar_Body__c;
		insert t;
		
		EmailTemplate et = [Select ID FROM EmailTemplate where Name = 'Dynamic Email Template'];
		PageReference pr = new PageReference('/_ui/core/email/author/EmailAuthor?p3_lkid='+dynamicEmail.ID+'&template_id='+eT.ID+'&sobj_id='+relatedToID+'&p6='+mainTemplate.Default_Email_Subject__c+'&retUrl=/'+relatedToID);
		return pr;
	}

}