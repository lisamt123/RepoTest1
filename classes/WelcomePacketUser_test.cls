@isTest(SeeAllData=True)
private class WelcomePacketUser_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
  		Account a = [select Id from Account where VIN_District__c != null limit 1];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	
        	Welcome_Packet__c W = new Welcome_Packet__c();
	        W.name = 'test';
	        W.Packet_Includes__c = 'CRM';        
	        W.OwnerId = userinfo.getuserid();
	        insert W;
	        
	        PageReference testStart = Page.Welcome_Packet_User;
			Test.setCurrentPage(testStart);
			
			ApexPages.currentPage().getParameters().put('ParentId', W.Id);
	        
	        
	        WelcomePacketUser WPW = new WelcomePacketUser();
	        
	        WPW.getUser();
	        WPW.saveUserListComplete();
	        
	        
	        Welcome_Packet_User__c newUser = new Welcome_Packet_User__c();
	        newUser.Name = 'test';
	        newUser.First_Name__c = 'testing';
	        
	        WPW.user.add(newUser);        
	        
	        WPW.addrow();        
	        WPW.addrow();
	        WPW.save();
	        WPW.goBack();
	        WPW.Skip();
	        
	        
	        W.Packet_Includes__c = 'ILM';
	        update W;
	        WPW.goBack();
	        
	        W.Packet_Includes__c = 'DIY';
	        update W;
	        WPW.goBack();
	        
	       	W.Packet_Includes__c=null;
	       	W.Pick_Your_Packet__c = 'CUSTOM FORMS';
	       	update W;
	       	WPW.goBack();
			
			W.Pick_Your_Packet__c = 'ILM CRM Inventory User Access';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'STANDARD FORMS REQUEST SHEET';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'UNSOLD (CRM) PROSPECT DATA';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'SOLD DATA';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'MINIMUM SYSTEM REQUIRMENTS';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'ROUTE ONE / DEALERTRACK';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'DMS PUSHING';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'PREDEFINED EXPORTS';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'THIRD PARTY EXPORTS';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'INVENTORY';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'ACCOUNT SET UP FORM (Page 2)';
			update W;
	       	WPW.goBack();
	       	
			W.Pick_Your_Packet__c = 'ACCOUNT SET UP FORM (Page 1)';
	        update W;
	       	WPW.goBack();
	       	
	       	W.Pick_Your_Packet__c = 'test';
	       	update W;
	       	WPW.goBack();  
	       	
	       	Opportunity O = new Opportunity();
	       	O.AccountId=a.id;
	       	O.Name = 'test';
	       	O.StageName = 'test';
	       	O.CloseDate = system.today();
	       	insert O;
	       
	       	SFDC_520_Quote__c project = new SFDC_520_Quote__c();
	       	project.Opportunity__c = O.Id;
			project.Name = 'test';
			insert project;
			
			W.Project__c = project.Id;
			update W;
			WPW.Skip();      
	        
	        W.Packet_Includes__c = null;
	        W.Pick_Your_Packet__c = null;
	        update W;
	        WPW.goBack();
	        
	        
	        
        	
        	
        	
        	test.startTest();
        	
        	
        	
        	test.stopTest();
        }
    }
}