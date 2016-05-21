public with sharing class admin_ctrl_home { 
	
	public Map<String, Schema.SObjectType> gd {get;set;}
	
	public List<String> list1 {get;set;}
	
	
	public admin_ctrl_home() {
		
		//grabObjects();
		//sendNotification();
		
		
		runQuery();
	}
	
	
	public class accountSearchWrapper {
		
		public integer searchNumber {get;set;}
		public string accountSearchName {get;set;}
		public boolean match {get;set;}
		public integer qtyMatch {get;set;}
		public string accountId {get;set;}
		public string accountName {get;set;}
		public string accountType {get;set;}
		public decimal dealerGroupMrr {get;set;}
		
		public accountSearchWrapper(integer tSearchNumber, string tAccountSearchName, boolean tMatch, integer tQtyMatch, string tAccountId, string tAccountName, string tAccountType, decimal tDealerGroupMrr) {
			
			searchNumber = tSearchNumber;
			accountSearchName = tAccountSearchName;
			match = tMatch;
			qtyMatch = tQtyMatch;
			accountId = tAccountId;
			accountName = tAccountName;
			accountType = tAccountType;
			dealerGroupMrr = tDealerGroupMrr;
		}
	}
	
	
	public list<accountSearchWrapper> accountList {get;set;}
	
	public list<Account> theAccounts {get;set;}
	public string accountSize {get;set;}
	
	public void runQuery() {
		
		accountList = new list<accountSearchWrapper>();
		
		list<String> accountNames = new list<String>();
		
		/*
		accountNames.add('Jack Wilson Chevrolet Buick GMC');
		accountNames.add('James wood motors');
		accountNames.add('Jenkins Auto Group');
		accountNames.add('Jenkins Automotive Group');
		accountNames.add('Jerry Seiner Dealerships');
		accountNames.add('Jim Falk Lexus of Beverly Hills');
		accountNames.add('Kaizen Automotive Group');
		accountNames.add('Kaizen Automotive Group');
		accountNames.add('Kearny Pearson Ford- Sunroad Automotive');
		accountNames.add('Ken Nelson Auto Group');
		accountNames.add('Kenwood Auto Group');
		accountNames.add('Kinsel Ford Lincoln Mazda');
		accountNames.add('Kuni Automotive');
		accountNames.add('lakeview');
		accountNames.add('Larry H Miller Automotive');
		accountNames.add('Larry H Miller TUCSON');
		accountNames.add('Lebanon Ford');
		accountNames.add('Lexus San Diego / Penskeautomotive.com');
		accountNames.add('Lithia Motors');
		accountNames.add('Lone star Chevrolet');
		accountNames.add('Mankato Motors');
		accountNames.add('Mark Christopher Auto Center');
		accountNames.add('Mark Christopher Auto Center');
		accountNames.add('Market Leader');
		accountNames.add('MatchCraft, Inc');
		accountNames.add('MCMC Auto LTD');
		accountNames.add('Mercedes Benz of Oakland');
		accountNames.add('Mercedes-Benz of Naples');
		accountNames.add('Metro Automotive');
		accountNames.add('Montgomery Motors');
		accountNames.add('Moritz Cadillac  BMW mini');
		accountNames.add('Morlan Chrysler');
		accountNames.add('Moss Motors');
		accountNames.add('New Country Motor Car Group, Inc.');
		accountNames.add('Northpointemotors.com');
		accountNames.add('Nue City');
		accountNames.add('Oliver C Joseph');
		accountNames.add('Orlando Infiniti');
		accountNames.add('Pacifico Auto Group');
		accountNames.add('Pat O\'Brien Chevrolet');
		accountNames.add('Paul Clark Ford');
		accountNames.add('payne auto group');
		accountNames.add('Performance Auto Mall');
		accountNames.add('Performance Automotive Group');
		accountNames.add('Premier Chevrolet');
		accountNames.add('Rancho Motor Company');
		accountNames.add('RAY CHEVROLET');
		accountNames.add('RBM of Atlanta-North');
		accountNames.add('Romano Auto Dealerships');
		accountNames.add('Route 23 Honda');
		accountNames.add('Route 23 Honda');
		accountNames.add('Roy O\'Brien Ford, Inc');
		accountNames.add('Sage Automotive Group');
		accountNames.add('Savage Auto Group');
		accountNames.add('Scott Robinson Automotive Group');
		accountNames.add('SF MBZ');
		accountNames.add('Sheehy Auto Stores');
		accountNames.add('Silver Star Mercedes Benz');
		accountNames.add('Smith Ford');
		accountNames.add('Southeast Toyota Distributors');
		accountNames.add('Southwest/Capitol Dealer Groups');
		accountNames.add('Suburban Auto Group');
		accountNames.add('Sunnyvale Ford Lincoln');
		accountNames.add('The Autobarn LTD');
		accountNames.add('The Dave Arbogast Group');
		accountNames.add('The Toland Group');
		accountNames.add('The Toland Group');
		accountNames.add('Toyota of Des Moines');
		accountNames.add('Treasure Coast Toyota');
		accountNames.add('Tuttle-Click Automotive Group');
		accountNames.add('Universal City Nissan');
		accountNames.add('Universal Nissan');
		accountNames.add('Victory Ford');
		accountNames.add('World Auto Group');
		*/
		
		
		accountNames.add('1769');
		accountNames.add('3232');
		accountNames.add('4242');
		accountNames.add('4360');
		accountNames.add('4546');
		accountNames.add('4623');
		accountNames.add('5301');
		accountNames.add('5336');
		accountNames.add('5377');
		accountNames.add('5401');
		accountNames.add('4659');
		accountNames.add('4673');
		accountNames.add('4726');
		accountNames.add('4858');
		accountNames.add('5409');
		accountNames.add('5592');
		accountNames.add('5713');
		accountNames.add('5724');
		accountNames.add('3720');
		accountNames.add('3808');
		accountNames.add('3816');
		accountNames.add('4898');
		accountNames.add('5112');
		accountNames.add('5125');
		accountNames.add('5848');
		accountNames.add('6049');
		accountNames.add('6081');
		accountNames.add('6287');
		accountNames.add('3798');
		accountNames.add('3878');
		accountNames.add('3611');
		accountNames.add('5148');
		accountNames.add('5272');
		accountNames.add('5149');
		accountNames.add('5069');
		accountNames.add('3243');
		accountNames.add('3987');
		accountNames.add('6404');
		accountNames.add('5928');
		accountNames.add('5719');
		accountNames.add('6392');
		accountNames.add('5120');
		accountNames.add('5128');
		accountNames.add('4229');
		accountNames.add('4714');
		accountNames.add('5363');
		accountNames.add('5303');
		accountNames.add('5814');
		accountNames.add('3837');
		accountNames.add('4788');
		accountNames.add('4329');
		accountNames.add('4978');
		accountNames.add('3355');
		accountNames.add('5408');
		accountNames.add('6242');
		accountNames.add('6075');
		accountNames.add('5859');
		accountNames.add('5145');
		accountNames.add('4652');
		accountNames.add('4367');
		accountNames.add('3960');
		accountNames.add('2825');
		accountNames.add('5704');
		accountNames.add('5591');
		accountNames.add('5425');
		accountNames.add('6439');
		accountNames.add('4366');
		accountNames.add('5170');
		accountNames.add('5113');
		accountNames.add('5299');
		accountNames.add('6048');
		accountNames.add('3861');
		accountNames.add('2845');
		accountNames.add('3912');
		accountNames.add('4455');
		accountNames.add('4599');
		accountNames.add('4888');
		accountNames.add('5467');
		accountNames.add('5750');
		accountNames.add('5626');
		accountNames.add('3788');
		accountNames.add('5139');
		accountNames.add('4241');
		accountNames.add('4757');
		accountNames.add('4627');
		accountNames.add('6052');
		accountNames.add('5878');
		accountNames.add('2501');
		accountNames.add('4143');
		accountNames.add('5379');
		accountNames.add('5992');
		accountNames.add('5718');
		accountNames.add('5302');
		accountNames.add('5049');
		accountNames.add('4820');
		accountNames.add('4884');
		accountNames.add('5358');
		accountNames.add('5300');
		accountNames.add('5295');
		accountNames.add('4564');
		accountNames.add('5146');
		accountNames.add('4977');
		accountNames.add('4486');
		accountNames.add('5169');
		
		
	

		theAccounts = [SELECT Id, Name, AccountNumber, Type, Dealer_Group_MRR__c
					   FROM Account
					   WHERE AccountNumber IN :accountNames];
		
		accountSize = string.ValueOf(theAccounts.size());
		
		integer sNum = 1;
		boolean foundMatch;
		integer qty;
		string aType;
		decimal dGMrr;
		string aId;
		
		for(String s : accountNames) {
			
			foundMatch = false;
			qty = 0;
			aType = '';
			dGMrr = 0;
			aId = '';
			
			for(Account a : theAccounts) {
				
				if(s == a.AccountNumber) {
					
					foundMatch = true;
					qty++;
					aType = a.Type;
					dGMrr = a.Dealer_Group_MRR__c;
					aId = a.Id;
				}
			}
			
			/*
			
			public string accountSearchName {get;set;}
			public boolean match {get;set;}
			public integer qtyMatch {get;set;}
			public string accountId {get;set;}
			public string accountName {get;set;}
			public string accountType {get;set;}
			public decimal dealerGroupMrr {get;set;}
			
			*/
			
			if(foundMatch) {
				
				if(qty == 1) {
					
					accountList.add(new accountSearchWrapper(sNum, s, true, 1, aId, s, aType, dGMrr));
				}
				else if(qty > 1) {
					 
					accountList.add(new accountSearchWrapper(sNum, s, true, qty, '-', '-', '-', 0));
				}
				
				
			}
			else {
				
				accountList.add(new accountSearchWrapper(sNum, s, false, qty, '-', '-', '-', 0));
			}
			
			sNum++;
		}
	}
	
	
	
	
	public list<objectSummaryData> summaryData {get;set;}
	
	public list<objectSummaryData> fieldData {get;set;}
	
	public class objectSummaryData {
		
		public string objName {get;set;}
		public decimal totalAmount {get;set;}
		
		public objectSummaryData(string tObjName, decimal tTotalAmount) {
			
			objName = tObjName;
			totalAmount = tTotalAmount;
		}
	}
	
	/*
	public void grabObjects() {
		
		gd = Schema.getGlobalDescribe();
		list1 = new List<String>();
		
		for(String s : gd.keyset()) {
			
			list1.add(s);
		}	
	}
	*/
	
	public void grabObjects() {
		
		gd = Schema.getGlobalDescribe();
		//list1 = new List<String>();
		//list2 = new List<String>();
		
		integer cObj = 0;
		integer sObj = 0;
		
		integer cFields = 0;
		integer sFields = 0;
		
		for(String s : gd.keyset()) {
			
			if(s.contains('__c')) {
				
				cFields += countFields(s, gd, true);
				
				cObj++;
			}
			else {
				
				//sFields += countFields(s, gd, false);
				
				sObj++;
			}
			
			//list1.add(s);
			
			//customObjects = string.valueOf(cObj);
			//standardObjects = string.valueOf(sObj);
			//customFields = string.valueOf(cFields);
		}	
		
		summaryData = new List<objectSummaryData>();
		//fieldData = new List<objectSummaryData>();
		
		
		summaryData.add(new objectSummaryData('Custom Fields', cFields));
		summaryData.add(new objectSummaryData('Custom Objects', cObj));
		summaryData.add(new objectSummaryData('Standard Objects', sObj));
		
		//fieldData.add(new objectSummaryData('Standard Fields', sFields));
	}
	
	public integer countFields(string selectedObject, Map<String, Schema.SObjectType> gdMap, boolean isCustom) {
		
		integer i = 0;
		
		//Map<String, Schema.SObjectField> M = Schema.SObjectType.Account.fields.getMap();
		//Map<String, Schema.SObjectField> M = Schema.SObjectType.objectType.fields.getMap();
		
		
		//Map<String, Schema.SObjectType> gdMap = Schema.getGlobalDescribe();
		Schema.Describesobjectresult dsr = gdMap.get(selectedObject).getDescribe();
		Map<String, Schema.SObjectField> fieldMap = dsr.fields.getMap();
		
		     
		//limit of 100 describe calls per transaction 
		    
		
	
		for(String key : fieldMap.keySet()) {
			
			//list2.add(key);
			
			if(isCustom) {
			
				if(key.contains('__c')) {
					
					i++;
				}
			}
			else {
				
				if(key.contains('__c')) {
					
					
				}
				else {
					
					i++;
				}
			}
		}
		
		return i;
	}
	
	public void sendNotification() {
		
		system.debug('Bazinga');
		
		try {
		
		  	string message = 'User Id: ' + UserInfo.getUserId() + ' ... User Name: ' + UserInfo.getUserName();
	
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Admin Home Page View');
	        mail.setPlainTextBody(message);
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
		catch(Exception e) {
			
			string message = 'Error: ' + e;
	
	        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
	        String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com'};
	        mail.setToAddresses(toAddresses);
	        mail.setSubject('Admin Home Page View Error');
	        mail.setPlainTextBody(message);
	        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		}
	}
	
}