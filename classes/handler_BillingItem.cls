public with sharing class handler_BillingItem {
	
	// AFTER UPDATE
	public static void beforeUpdate(Map<Id, Billing_Item__c> oldMap, List<Billing_Item__c> billingItems) {
		
		// do stuff
		
		
		
		// .. compare old values
		checkToActivateDeactivateFeatures(checkOldValuesBeforeUpdate(oldMap, billingItems));
		
		// ..
		flipAdminDebugBoolean(billingItems);
	}
	
	public static void flipAdminDebugBoolean(List<Billing_Item__c> billingItems) {
		
		for(Billing_Item__c bi : billingItems) {
			
			if(bi.End_Date__c <= system.today() && bi.MSDelayRemovedDONOTCHANGE__c == true && bi.debug__c == true) {
			
				bi.MSDelayRemovedDONOTCHANGE__c = false;	
			}
			
			if(bi.debug__c == true) {
				
				bi.debug__c = false;
			}
		}
	}
	
	// AFTER INSERT
	//public static void beforeInsert(List<Billing_Item__c> billingItems) {
		
		// do stuff
		
		//checkToActivateDeactivateFeatures(billingItems);
	//}
	
	// old comparison method
	public static List<Billing_Item__c> checkOldValuesBeforeUpdate(Map<Id, Billing_Item__c> oldMap, List<Billing_Item__c> billingItems) {
		
		//Prod RecordTypeIds
		// Process Stop - 01270000000Q9wW
		// CANCELLED - 01270000000Q9wT
		// ADD - 01270000000Q9wS
		// MODIFY - 01270000000Q9wV
		
		List<Billing_Item__c> addStopBillingItems = new List<Billing_Item__c>();
		
		for(Billing_Item__c bi : billingItems) {
			
			system.debug('Bazinga... bi.Contract_Status__c: ' + bi.Contract_Status__c);
			system.debug('Bazinga... OLD bi.Contract_Status__c: ' + oldMap.get(bi.Id).Contract_Status__c);
			system.debug('Bazinga... bi.RecordTypeId: ' + bi.RecordTypeId);
			system.debug('Bazinga... OLD bi.RecordTypeId: ' + oldMap.get(bi.Id).RecordTypeId);
			
			//
			if(bi.Prepaid_Product__c == false) {
										
				if((bi.RecordTypeId == '01270000000Q9wV' && oldMap.get(bi.Id).RecordTypeId == '01270000000Q9wS') ||
				   (bi.RecordTypeId == '01270000000Q9wT' && oldMap.get(bi.Id).RecordTypeId == '01270000000Q9wW') ||
				   (bi.debug__c == true)) {
					
					system.debug('Bazinga... addStopAdd');
					
					addStopBillingItems.add(bi);
				}
			}
		}
		
		return addStopBillingItems;
	}
	
	//
	public static void checkToActivateDeactivateFeatures(List<Billing_Item__c> billingItems) {
		
		// ..
		// .
		
		Set<Id> activatePPIds = new Set<Id>();
		Set<Id> stopPPIds = new Set<Id>();
		//
		
		List<Billing_Item__c> activateBillingItems = new List<Billing_Item__c>();
		List<Billing_Item__c> deActivateBillingItems = new List<Billing_Item__c>();
		
		List<Billing_Item__c> delayStopBillingItems = new List<Billing_Item__c>();
		
		Boolean isDebug = false;
		
		if(Utility.isFutureUpdate != true) {
			
			//..
			for(Billing_Item__c bi : billingItems) {
				
				if(bi.debug__c == true) {
					
					isDebug = true;
				}
				
				system.debug('Bazinga... Billing Item Record Type Id: ' + bi.RecordTypeId);
				system.debug('Bazinga... Contract Status: ' + bi.Contract_Status__c);
				system.debug('Bazinga... End Date: ' + bi.End_Date__c);
								
				if(bi.RecordTypeId == '01270000000Q9wV') { 
					
					activateBillingItems.add(bi);
					
					//PP Update
					activatePPIds.add(bi.Related_Project_Piece__c);
				}
				else if(bi.RecordTypeId == '01270000000Q9wT') {
					
					if(bi.End_Date__c <= system.today()) {
						
						deActivateBillingItems.add(bi);
						
						//PP Update
						stopPPIds.add(bi.Related_Project_Piece__c);
					}
					else if(bi.End_Date__c >= system.today() && bi.MSDelayRemovedDONOTCHANGE__c == false) {
						
						delayStopBillingItems.add(bi);
					}
				}
			}  
			
			if(activateBillingItems.size() > 0) {
				
				prepareDataForActivateDeactivateFeaturesCallout(isDebug, true, activateBillingItems);
			}
			
			if(deActivateBillingItems.size() > 0) {
				
				system.debug('Bazinga... prepare Data Deactivate');
				
				prepareDataForActivateDeactivateFeaturesCallout(isDebug, false, deActivateBillingItems);
			}
			
			if(delayStopBillingItems.size() > 0) {
				
				delayStop(delayStopBillingItems);
			}
			
			if(activatePPIds.size() > 0) {
				
				prepareDataForFieldUpdate(true, activatePPIds);
			}
			
			if(stopPPIds.size() > 0) {
				
				prepareDataForFieldUpdate(false, stopPPIds);
			}
		}
	}
	
	
	//
	public static void prepareDataForFieldUpdate(Boolean isActivate, Set<Id> ppIds) {
		
		List<Project_Piece__c> updateProjectPieces = new List<Project_Piece__c>();
		List<Project_Piece__c> relatedProjectPieces = new List<Project_Piece__c>();
		
		relatedProjectPieces = [SELECT Id, Contract_Push_Picklist__c
							    FROM Project_Piece__c
							    WHERE Id IN :ppIds];
							    
		for(Project_Piece__c pp : relatedProjectPieces) {
			
			if(isActivate) {
				
				pp.Contract_Push_Picklist__c = 'Activated';
			}
			else {
				
				pp.Contract_Push_Picklist__c = 'Stopped';
			}
			
			updateProjectPieces.add(pp);
		}
		
		update updateProjectPieces;
	}
	
	
	//in scheduled job..
	// .. loop thru all billingitems with MSdelay check true
	// .. if date criteria is met then unchech MSdelay and update the billingitem
	// .. the update should trigger a callout from the billing item trigger
	
	// mark billing items as delay stop
	public static void delayStop(List<Billing_Item__c> billingItems) {
		
		// record is read only error************ afterUpdate?
		
		//flip future recursive flag before calling dml
		Utility.isFutureUpdate = true;
		
		//List<Billing_Item__c> updateBillingItems = new List<Billing_Item__c>();
		
		for(Billing_Item__c bi : billingItems) {
			
			bi.MSDelayRemovedDONOTCHANGE__c = true;
			//updateBillingItems.add(bi);
		}
		
		// TODO
		//send email with the update
		//update updateBillingItems;
		
	}
	
	
	
	// Needs to be re-written/adjusted to group data by Contract
	public static void prepareDataForActivateDeactivateFeaturesCallout(Boolean isDebug, Boolean isActivate, List<Billing_Item__c> billingItems) {
		

		//commented since Maggie mentioned we
		//have the BU Unit for vAuto not from Opp
		//since it has more than one Opp and only one contract
		/*
		Ramana:10/23/2014:
		After debuggng an issue with vAuto data load with brian (future calls limit reached)
		we rialized that this call is specific to VIN- MotoSnap
		So; not running this for vAuto		
		possibily better to stop before this; Need to refactor later
		
		
		
		//remove all vAuto Items
		Set<Id> setvAutoItems = new Set<Id>(); 
		for(Billing_Item__c item: billingItems){
			if(item.Business_Unit__c == 'vAuto'){
				setvAutoItems.add(item.Id);
			}
		}
		
		//remove vAuto if found
		if(setvAutoItems.size() > 0){
			Map<Id,Billing_Item__c> mapbillingItems = new Map<Id,Billing_Item__c>(billingItems);
			//renmove if any vAuto from provided
			for(Id vAutoitemId: setvAutoItems){
				mapbillingItems.Remove(vAutoitemId);
			}
			
			//after remove set existing to process
			billingItems = mapbillingItems.values();
		}
		
		*/
		
		/*
		Map<Id, Set<Id>> accountIdProductIdsMap = new Map<Id, Set<Id>>();
		
		for(Billing_Item__c bi : billingItems) {
			
			if(accountIdProductIdsMap.containsKey(bi.Contract__r.AccountId)) {
				
				accountIdProductIdsMap.get(bi.Contract__r.AccountId).add(bi.Product_Code__c);
			}
			else {
				
				accountIdProductIdsMap.put(bi.Contract__r.AccountId, new Set<Id>{bi.Product_Code__c});
			}
		}
		
		for(Id acctId : accountIdProductIdsMap.keyset()) { 
			 
			futureActivateDeactivateFeatures(isActivate, acctId, accountIdProductIdsMap.get(acctId));
		}
		*/
		
		/*
		
		Map<Id, LIST<Case>> caseMap = new Map<Id, LIST<Case>>();

		for(Case cc : childCases) {
		
			if(caseMap.containsKey(cc.parentId)) {
			
				caseMap.get(cc.parentId).add(cc);
			}
			else {
			
				caseMap.put(cc.parentId, new List<Case>{cc});
			}
		}
		
		*/
		
		Map<Id, List<Billing_Item__c>> conBMap = new Map<Id, List<Billing_Item__c>>();
		
		
		
		
		//String acctNumber;
		//Id contractId;
		
		for(Billing_Item__c bi : billingItems) {
			
			//acctId = bi.Vin_Dealer_Id__c;
			//acctId = bi.Contract__r.Account.Id;
			
			
			
			//acctNumber = bi.Vin_Dealer_Id__c;
			//contractId = bi.Contract__c;
			
			if(conBMap.containsKey(bi.Contract__c)) {
				
				conBMap.get(bi.Contract__c).add(bi);
			}
			else {
				
				conBMap.put(bi.Contract__c, new List<Billing_Item__c>{bi});
			}
			
			
			
			//system.debug('Bazinga.. ^ accountId: ' + acctId);
			//system.debug('Bazinga.. ^ bi.Contract__r.AccountId: ' + bi.Contract__r.AccountId);
			//system.debug('Bazinga.. ^ bi.Contract__r.Account.Id: ' + bi.Contract__r.Account.Id);
		}
		
		
		
		String acctNumber;
		Map<Id, String> billingItemIdProductCodeIdMap;
		
		for(Id cId : conBMap.keyset()) {
			
			billingItemIdProductCodeIdMap = new Map<Id, String>();
		
			//system.debug('Bazinga... contractId:' + contractId + ' .. acctNumber: ' + acctNumber);
			
			for(Billing_Item__c bi : conBMap.get(cId)) {
				
				acctNumber = bi.Vin_Dealer_Id__c;
				billingItemIdProductCodeIdMap.put(bi.Id, bi.Product_Code__c);
			}
			
			
			if(!System.isBatch()) {
				
				futureActivateDeactivateFeatures(isDebug, isActivate, acctNumber, cId, billingItemIdProductCodeIdMap);
			}
			else {
				
				activateDeactivateFeatures(isDebug, isActivate, acctNumber, cId, billingItemIdProductCodeIdMap);
			}		
		}
	}
	
	// !System.isBatch
	public static void activateDeactivateFeatures(Boolean isDebug, Boolean isActivate, String accountNumber, Id contractId, Map<Id, String> billingItemIdProductCodeIdMap) {
		
		system.debug('Bazinga.. accountNumber: ' + accountNumber);
		
		/*
		
		Enable two features and remove 3 for DealerId 314 
		{
			"DealerId":314,
			"InvoiceItemsToEnable":[
				{
					"Amount":11.38,
					"SalesforceId":"CRM114",
					"InvoiceItemId":"SVC-INVMAEBA",
					"OrderNumber":"Miranda"
				},
				{"
					Amount":5.77,
					"SalesforceId":"THX1138",
					"InvoiceItemId":"SVC-DATINT",
					"OrderNumber":"3CPO"
				}
			],
			"InvoiceItemIdsToDisable":[
				"SVC-BLABOOIN",
				"SVC-DATINTBI",
				"SVC-SURVEYS1"
			]
		}
		
		*/
		
		
		
		//instantiate the generator
		JSONGenerator gen = JSON.createGenerator(true);
		gen.writeStartObject();
		gen.writeNumberField('DealerId', integer.valueOf(accountNumber));
		gen.writeFieldName('InvoiceItemsToEnable');
		gen.writeStartArray();
		
		if(isActivate) {
			
			for(Id billingItemId : billingItemIdProductCodeIdMap.keyset()) {
				
				gen.writeStartObject();
				//
				//gen.writeNumberField('Amount', 1);
				gen.writeStringField('SalesforceId', billingItemId);
				gen.writeStringField('InvoiceItemId', billingItemIdProductCodeIdMap.get(billingItemId));
				//
				//gen.writeNumberField('Type', 3);
				gen.writeStringField('OrderNumber', contractId);
				//
				//gen.writeNumberField('VinInvoiceItemId', -1);
				//
				//gen.writeStringField('AccpacInvoiceItemId', 'SVC-ADPCERIN');
				//
				//gen.writeNumberField('AccpacAmount', 1);
				//
				//gen.writeStringField('AccpacRecordID', 'cf7b0ef3-1e54-4f63-93ce-');
				//
				//gen.writeNumberField('AccpacType', 3);
				//
				//gen.writeStringField('AccpacOrderNumber', 'b8f3970a-4e23-4841-9659-e17217e2012d');
				gen.writeEndObject();
			}
		}
		
		gen.writeEndArray();
		gen.writeFieldName('InvoiceItemIdsToDisable');
		gen.writeStartArray();
		
		if(!isActivate) {
			
			for(Id billingItemId : billingItemIdProductCodeIdMap.keyset()) {
				
				gen.writeString(billingItemIdProductCodeIdMap.get(billingItemId));
			}
		}
		
		gen.writeEndArray();
		gen.writeEndObject();
		
		string jsonString = gen.getAsString();
		system.debug('Bazinga... JSON Generator string output: ' + jsonString);
		
		// set up uri
		//string callOutURL = 'https://wsvc.vinsolutions.com/MotosnapAdminServices/services/DealerFeature/SET';
		string callOutURL = 'https://vip-prod.apigee.net/v1/SalesforceMotosnap/services/DealerFeature/SET';
		//string callOutURL = 'https://officedev.vinsolutions.com/SalesforceMotosnap/services/DealerFeature/SET';
		
		// create an HTTPrequest object    
        HttpRequest req = new HttpRequest();
        
        // set up the HTTP request with a method, endpoint, header, body and API Key
        req.setMethod('POST');
        req.setEndpoint(callOutURL);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonString);    
        req.setHeader('apikey', 'EvCiqlDoCtjTOrBJC91HEHcFeda0LdVz');
        
        
        // create a new HTTP object
        Http http = new Http();
        
        // create a new HTTP response for receiving the remote response
        // then use it to send the configured HTTPrequest
        HTTPResponse res = http.send(req);
        
        
        // debugging call, which you can check in console logs
       	system.debug('Bazinga... DealerFeatureWebservice Response: '+ res.getBody());
		system.debug('Bazinga... Response Status Code: ' + res.getStatusCode());
		
		/*
		 Return Codes
         202 – The update has been accepted and saved to the database.
         304 – An error occurred on our end and has been logged. Returns an error message in JSON format also.
         503 – Something really bad happened on our end and has been logged. Returns an error message in JSON format also.
		*/
		
		
		/////
		// .. Process Results and update data as needed
		// .. set static boolean flag before dml starts to prevent recursive
		// .
		
		//system.debug('Bazinga... isFutureUpdate: ' + Utility.isFutureUpdate);
		
		
		///Utility.isFutureUpdate = true;
		
		
		Billing_Log__c newLog = new Billing_Log__c();
		
		string debugResponse = 'Status Code: ' + res.getStatusCode() + '.. Status: ' + res.getStatus() + '.. JSON string sent: ' + jsonString + ' .. Response Body: ' + res.getBody();
		
		if(debugResponse.length() > 32000) {
			
			newLog.debugResponse__c = debugResponse.substring(0,32000);
		}
		else {
			
			newLog.debugResponse__c = debugResponse;
		}
		
		
		
		for(Id billingItemId : billingItemIdProductCodeIdMap.keyset()) {
			
			newLog.Billing_Item__c = billingItemId;
			break;
		}
		
		insert newLog;
		
		
		//if (res.getStatusCode() != 200) {
		
		/*
		
		DealerId - Account Number ( may not be unique, allow for graceful fails )
		SalesforceId - (24 characters max) Yeah, the Salesforce Billing ID will work in this field.
		OrderNumber (24 characters max) The Salesforce Contract ID will work in this field.
		
		*/
		
		// rewrite this method after Account Number has been locked down to prevent duplicates
		// .. rewrite to reduce queries by 1
		// .accountId
		string action = '';
		
		if(isActivate) {
			
			action = 'Activate';
		}
		else {
			
			action = 'Deactivate';
		}
		
		// send email saying it failed
	  	string message = 'Motosnap ' + action + ' Callout. New Billing Log: ' + newLog.Id + '. Debug: ' + newLog.debugResponse__c;
	  	
	  	if(isDebug) {
	  		
	  		message += '. Debug override was used.';
	  	}

        // Send an email to the Apex job's submitter notifying of job completion.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'status404@outlook.com'};
        mail.setToAddresses(toAddresses);
        
        if(isDebug) {
        	
        	mail.setSubject('Motosnap *Debug* ' + action + ' Callout: Status: ' + res.getStatusCode());
        }
        else {
        	
        	mail.setSubject('Motosnap ' + action + ' Callout: Status: ' + res.getStatusCode());
        }
        
        mail.setPlainTextBody(message);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	}
	
	

	
	
	@future (callout=true) 
	public static void futureActivateDeactivateFeatures(Boolean isDebug, Boolean isActivate, String accountNumber, Id contractId, Map<Id, String> billingItemIdProductCodeIdMap) {
		
		
		//Ramana: 09/26/2014
		//after seeing some exceptions as below:
		/*>Apex script unhandled exception by user/organization:
>005Q000000O4PRv/00DQ000000GJxlb
>Source organization: 00D700000008zHZ (null) Failed to invoke future 
>method 'public static void futureActivateDeactivateFeatures(Boolean, 
>Boolean, String, Id, MAP<Id,String>)' on class 'handler_BillingItem' 
>for job id '707Q000000GGKo7'
>
>caused by: System.NullPointerException: Argument cannot be null.
>
>Class.handler_BillingItem.futureActivateDeactivateFeatures: line 573, 
>column 1*/
		 
		 
		 //Return if there is no accountNumber;
		 if(accountNumber == null || accountNumber.trim()==''){return;}
		 
		
		system.debug('Bazinga.. accountNumber: ' + accountNumber);
		
		/*
		
		Enable two features and remove 3 for DealerId 314 
		{
			"DealerId":314,
			"InvoiceItemsToEnable":[
				{
					"Amount":11.38,
					"SalesforceId":"CRM114",
					"InvoiceItemId":"SVC-INVMAEBA",
					"OrderNumber":"Miranda"
				},
				{"
					Amount":5.77,
					"SalesforceId":"THX1138",
					"InvoiceItemId":"SVC-DATINT",
					"OrderNumber":"3CPO"
				}
			],
			"InvoiceItemIdsToDisable":[
				"SVC-BLABOOIN",
				"SVC-DATINTBI",
				"SVC-SURVEYS1"
			]
		}
		
		*/
		
		
		
		//instantiate the generator
		JSONGenerator gen = JSON.createGenerator(true);
		gen.writeStartObject();
		gen.writeNumberField('DealerId', integer.valueOf(accountNumber));
		gen.writeFieldName('InvoiceItemsToEnable');
		gen.writeStartArray();
		
		if(isActivate) {
			
			for(Id billingItemId : billingItemIdProductCodeIdMap.keyset()) {
				
				gen.writeStartObject();
				//
				//gen.writeNumberField('Amount', 1);
				gen.writeStringField('SalesforceId', billingItemId);
				gen.writeStringField('InvoiceItemId', billingItemIdProductCodeIdMap.get(billingItemId));
				//
				//gen.writeNumberField('Type', 3);
				gen.writeStringField('OrderNumber', contractId);
				//
				//gen.writeNumberField('VinInvoiceItemId', -1);
				//
				//gen.writeStringField('AccpacInvoiceItemId', 'SVC-ADPCERIN');
				//
				//gen.writeNumberField('AccpacAmount', 1);
				//
				//gen.writeStringField('AccpacRecordID', 'cf7b0ef3-1e54-4f63-93ce-');
				//
				//gen.writeNumberField('AccpacType', 3);
				//
				//gen.writeStringField('AccpacOrderNumber', 'b8f3970a-4e23-4841-9659-e17217e2012d');
				gen.writeEndObject();
			}
		}
		
		gen.writeEndArray();
		gen.writeFieldName('InvoiceItemIdsToDisable');
		gen.writeStartArray();
		
		if(!isActivate) {
			
			for(Id billingItemId : billingItemIdProductCodeIdMap.keyset()) {
				
				gen.writeString(billingItemIdProductCodeIdMap.get(billingItemId));
			}
		}
		
		gen.writeEndArray();
		gen.writeEndObject();
		
		string jsonString = gen.getAsString();
		system.debug('Bazinga... JSON Generator string output: ' + jsonString);
		
		// set up url
		// Grabbing callout data from a custom setting
		Motosnap_Callout__c callOutCustSet = Motosnap_Callout__c.getValues('MotosnapCustSet'); 
		
		// create an HTTPrequest object    
        HttpRequest req = new HttpRequest();
        
        // set up the HTTP request with a method, endpoint, header, body and API Key
        req.setMethod('POST');
        req.setEndpoint(callOutCustSet.callOutURL__c);
        req.setHeader('Content-Type', 'application/json');
        req.setBody(jsonString);    
        req.setHeader('apikey', callOutCustSet.apikey__c);
        
        
        // create a new HTTP object
        Http http = new Http();
        
        // create a new HTTP response for receiving the remote response
        // then use it to send the configured HTTPrequest
        HTTPResponse res = new HTTPResponse();
        try{
        	res = http.send(req);
        }
        catch(Exception e){
        	//logging exceptions
        	 handler_BillingItem.LogMotosnapServiceResult(req, res, e, billingItemIdProductCodeIdMap);
        	 system.debug('==================>>>>>>> Exception: ' + e.getMessage());
        	// Send an email to developers to notify them of an error, if the boolean in the custom setting is set to true
        	// set the boolean in the custom setting to false if you want to stop sending emails.
        	if(callOutCustSet.Send_Error_Email__c){
        		String subject = 'Motosnap Callout Exception';
          		String message = 'An exception occurred when trying to send an HttpRequest in handler_BillingItem: '
          							+ UtilityClass.DebugException(e);
				UtilityClass.DevelopersEmail(subject, message);
        	}

        	//RETURN 
        	return;
        }

    	// debugging call, which you can check in console logs
       	system.debug('Bazinga... DealerFeatureWebservice Response: '+ res.getBody());
		system.debug('Bazinga... Response Status Code: ' + res.getStatusCode());
		
		/*
		 Return Codes
         202 – The update has been accepted and saved to the database.
         304 – An error occurred on our end and has been logged. Returns an error message in JSON format also.
         503 – Something really bad happened on our end and has been logged. Returns an error message in JSON format also.
		*/
		
		
		/////
		// .. Process Results and update data as needed
		// .. set static boolean flag before dml starts to prevent recursive
		// .
		
		system.debug('Bazinga... isFutureUpdate: ' + Utility.isFutureUpdate);
		
		
		Utility.isFutureUpdate = true;
	     handler_BillingItem.LogMotosnapServiceResult( req
		 ,  res
		 ,  null
		 , billingItemIdProductCodeIdMap);
		//Log 
		
		/*
		Billing_Log__c newLog = new Billing_Log__c();
		
		string debugResponse = 'Status Code: ' + res.getStatusCode() + '.. Status: ' + res.getStatus() + '.. JSON string sent: ' + jsonString + ' .. Response Body: ' + res.getBody();
		
		if(debugResponse.length() > 32000) {
			
			newLog.debugResponse__c = debugResponse.substring(0,32000);
		}
		else {
			
			newLog.debugResponse__c = debugResponse;
		}
		
		
		
		for(Id billingItemId : billingItemIdProductCodeIdMap.keyset()) {
			
			newLog.Billing_Item__c = billingItemId;
			break;
		}
		
		insert newLog;
		*/
		
		
		//if (res.getStatusCode() != 200) {
		
		/*
		
		DealerId - Account Number ( may not be unique, allow for graceful fails )
		SalesforceId - (24 characters max) Yeah, the Salesforce Billing ID will work in this field.
		OrderNumber (24 characters max) The Salesforce Contract ID will work in this field.
		
		*/
		
		// rewrite this method after Account Number has been locked down to prevent duplicates
		// .. rewrite to reduce queries by 1
		// .accountId
		// 
		/*
		string action = '';
		
		if(isActivate) {
			
			action = 'Activate';
		}
		else {
			
			action = 'Deactivate';
		}
		
		// send email saying it failed
	  	string message = 'Motosnap ' + action + ' Callout. New Billing Log: ' + newLog.Id + '. Debug: ' + newLog.debugResponse__c;
	  	
	  	if(isDebug) {
	  		
	  		message += '. Debug override was used.';
	  	}

        // Send an email to the Apex job's submitter notifying of job completion.
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[] {'status404@outlook.com'};
        mail.setToAddresses(toAddresses);
        
        if(isDebug) {
        	
        	mail.setSubject('Motosnap *Debug* ' + action + ' Callout: Status: ' + res.getStatusCode());
        }
        else {
        	
        	mail.setSubject('Motosnap ' + action + ' Callout: Status: ' + res.getStatusCode());
        }
        
        mail.setPlainTextBody(message);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        */
	}

	public static  void LogMotosnapServiceResult(HttpRequest req
	 , HTTPResponse res
	 , Exception ex
	 ,Map<Id, String> billingItemIdProductCodeIdMap){
	 	system.assert(req != null,'Must have a valid HttpRequest Details');
		string debugResponse = 'Request:: '+req.toString()+'; Body: '+req.getBody();
		if(req.getHeader('apikey') != null){
			debugResponse = debugResponse+ '; Header:apikey '+req.getHeader('apikey');
		}

		List<Billing_Log__c> logsToCreate = new List<Billing_Log__c>();
	 	//create log for each item;
	 	for(Id billingItemId : billingItemIdProductCodeIdMap.keyset()) {
		Billing_Log__c newLog = new Billing_Log__c();
		
		newLog.Billing_Item__c = billingItemId;
		newLog.Log_Date__c = System.now();

		if(debugResponse.length() > 32000) {
			
			newLog.debugResponse__c = debugResponse.substring(0,32000);
		}
		else {
			
			newLog.debugResponse__c = debugResponse;
		}

		
		if(ex != null){
			//collect exception details and create a log			
			newLog.Log_Status__c = 'Error';
			newLog.Log_Message__c = UtilityClass.DebugException(ex);
		}
		else if(res != null){
			//collect Response details and create a log.
			newLog.Log_Status__c = 'Processed';
			newLog.Log_Message__c = 'Status Code: ' + res.getStatusCode() + '.. Status: ' + res.getStatus() + ' .. Response Body: ' + res.getBody();
		}
		else{
			//Should not happen
			//nothing to log.
			system.assert(false,'Either Response or Exception details must exist');
		}

		//create log;
		logsToCreate.add(newLog);
		
		}

		if(logsToCreate.size() > 0){
			insert logsToCreate;
		}
		
	}
	

	
	
}