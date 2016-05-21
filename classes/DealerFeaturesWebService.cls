public with sharing class DealerFeaturesWebService {
	
	public string callOutURL {get;set;}
	
	public string accountNum {get;set;}
	
	public string urlCalled {get;set;}
	
	public string jsonOutput {get;set;}
	
	public double random {get;set;}
	
	public string debugString {get;set;}
	
	public string accountId {get;set;}
	
	public string listSize {get;set;}
	
	public string dealerId {get;set;}
	
	//public Opportunity theOpp {get;set;}
	
	public class JSONWrapper {
		
		public integer rowCount {get;set;}
		public string salesforceId {get;set;}
		public string invoiceItemId {get;set;}
		public string orderNumber {get;set;}
		public decimal price {get;set;}
		public string productSold {get;set;}
		
		public JSONWrapper(integer rc, string sfId, string invoiceId, string orderNumberId) {
			
			rowCount = rc;
			salesforceId = sfId;
			invoiceItemId = invoiceId;
			orderNumber = orderNumberId;
			//price = 0.00;
			productSold = ' -- ';
		}
	}
	
	
	
	public DealerFeaturesWebService() {
		
		//callOutURL = 'https://wsvc.vinsolutions.com/MotosnapAdminServices/services/DealerFeature/Get/'; 
		callOutURL = 'https://vip-prod.apigee.net/v1/SalesforceMotosnap/services/DealerFeature/Get/';
		//callOutURL = 'https://vip-test.apigee.net/v1/SalesforceMotosnap/services/DealerFeature/Get/';
		//callOutURL = 'https://officedev.vinsolutions.com/SalesforceMotosnap/services/DealerFeature/Get/';
		//callOutURL = 'http://SUPVINS-VSELSHY.DEV.VINSTICKERS.com/SalesforceService/services/DealerFeatureTest/Get';
		//callOutURL = 'http://50.59.42.7/SalesforceService/services/DealerFeatureTest/Get';
		
		
		accountId = ApexPages.currentPage().getParameters().get('accountId');
		
		if(accountId != null) {
			
			// do stuff
			// get account number
			updateAccount();
			
			callOutURL += accountNum;
			
			makeCallout();
		}
		
	}
	
	public void updateAccountId() {
		
		try {
			
			accountId = [SELECT Id, AccountNumber FROM Account WHERE AccountNumber = :accountNum LIMIT 1].Id;
		}
		catch(Exception e) {
			
		}
	}
	
	public void updateAccount() {
		
		accountNum = [SELECT Id, AccountNumber FROM Account WHERE Id = :accountId].AccountNumber;
		
		
		//theOpp = new Opportunity();
		
		//theAccount = [SELECT Id FROM Account WHERE]	
	}
	
	public void makeCallout() {
		
		/*
		..
		200 – Processed without error
		503 – An exception occurred on our end and has been logged. Returns an error message in JSON format also.
		.
		*/
		
		
		
		///Boolean calloutSuccess;
		
		Http h = new Http();
		
		HttpRequest req = new HttpRequest();
		req.setEndpoint(callOutURL);
		
		urlCalled = callOutURL;
		
		req.setMethod('GET');
		//req.setTimeout(30000);
		
		req.setHeader('apikey', 'EvCiqlDoCtjTOrBJC91HEHcFeda0LdVz');
		
		system.debug('Bazinga... getBody: ' + req.getBody());
		system.debug('Bazinga... getEndpoint: ' + req.getEndpoint());
		system.debug('Bazinga... getHeader: ' + req.getHeader('apikey'));
		system.debug('Bazinga... getMethod: ' + req.getMethod());
		
		
		
		HttpResponse res;
		///calloutSuccess = true;
		
		res = h.send(req);
		
		/*
		string[] headerKeys = res.getHeaderKeys();
		
		for(string s : headerKeys) {
			
			system.debug('Bazinga.... header: ' + s + ' value: ' + res.getHeader(s));
		}
		*/
		
		jsonOutput = res.getBody();
		
		debugString = 'Status: ' + res.getStatus() + ' .. Status Code: ' + res.getStatusCode();
		
		JSONParser parser = JSON.createParser(jsonOutput);
		
		createWrapper(parser);
		
		
		queryLineItems();
		assignPrice();
		updateAccountId();
		/*
		try {
			
			res = h.send(req);
		}
		catch(Exception e) {
			
			calloutSuccess = false;
			// add later error handling
		}
		
		
		if(calloutSuccess) {
			
			jsonOutput = res.getBody();
		}
		*/
		
		
	}
	
	public List<JSONWrapper> theWrapper {get;set;}
	
	public Set<Id> billingItemIds = new Set<Id>();
	
	public void createWrapper(JSONParser parser) {
		
		theWrapper = new List<JSONWrapper>();
		
		integer i = 1;
		
		while(parser.nextToken() != null) {
			
			if(parser.getCurrentToken() == JSONToken.FIELD_NAME) {
			
				system.debug('Bazinga...Current token: ' + parser.getCurrentToken());
				system.debug('Bazinga...getText: ' + parser.getText());
				
				if(parser.getText() == 'DealerId') {
					
					system.debug('Bazinga.. DealerId');
					
					parser.nextToken();
					dealerId = parser.getText();
				}
				
				if(parser.getText() == 'SalesforceId') {
					
					string sfId = '';
					string invoiceId = '';
					string orderNumberId = '';
					
					parser.nextToken();
					//SalesforceId
					
					sfId = parser.getText();
					
					if(parser.getText().length() >= 15) {
					
						billingItemIds.add(parser.getText());
					}
					
					parser.nextToken();
					
					
					parser.nextToken();
					//InvoiceItemId
					
					invoiceId = parser.getText();
					
					parser.nextToken();
					parser.nextToken();
					parser.nextToken();
					
					
					parser.nextToken();
					//Order Number Id
					
					orderNumberId = parser.getText();
					
					theWrapper.add(new JSONWrapper(i, sfId, invoiceId, orderNumberId));
					
					i++;
				}
				else {
					
					parser.nextToken();
				}
				
				
				system.debug('Bazinga9...Current token: ' + parser.getCurrentToken());
				system.debug('Bazinga9...getText: ' + parser.getText());
			}
		}
		
		listSize = string.valueOf(theWrapper.size());
		
		
	}
	
	public Map<Id, Billing_Item__c> billingItemMap = new Map<Id, Billing_Item__c>();
	
	//rewrite this NJ
	public void queryLineItems() {
		
		for(Billing_Item__c bi : [SELECT Id, Total_Price__c, Product_Sold_Debug__c
								  FROM Billing_Item__c
								  WHERE Id IN :billingItemIds]) {
			
			billingItemMap.put(bi.Id, bi);					  	
		}
	}
	
	///
	public void assignPrice() {
		try {
			for(JSONWrapper jw : theWrapper) {
				
				if(jw.salesforceId.length() >= 15){
					if(billingItemMap.get(jw.salesforceId) != null) {
						
						jw.price = billingItemMap.get(jw.salesforceId).Total_Price__c;
						jw.productSold = billingItemMap.get(jw.salesforceId).Product_Sold_Debug__c;
					}
				}
			}
		}
		catch(Exception e) {
			
			
		}
	}
	
	public PageReference call() {
		
		callOutURL = 'https://vip-prod.apigee.net/v1/SalesforceMotosnap/services/DealerFeature/Get/' + accountNum;
		
		makeCallout();
		
		return null;
	}
	
	
	public void performRandom() {
		
		random = math.random();
	}
	
	public PageReference rando() {
		
		performRandom();
		
		return null;
	}
	

}