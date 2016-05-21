@isTest//(SeeAllData = true)
private class test_dynamicEmail {

    static testMethod void myUnitTest() {
    	Map <String,Schema.RecordTypeInfo> accountRecordTypes = Account.sObjectType.getDescribe().getRecordTypeInfosByName();
    	ID dealerRecID = accountRecordTypes.get('Dealer').getRecordTypeId();
       	Account a = new Account(Name = 'Test', RecordTypeID = dealerRecID, BillingPostalCode = '66210', BillingStreet = 'Number 1 Happy Street', BillingCity='Overland Park', BillingState = 'KS', BillingCountry='US'
        , ShippingPostalCode = '66210', ShippingStreet = 'Number 1 Happy Street', ShippingCity='Overland Park', ShippingState = 'KS', ShippingCountry='US'
          );
       	insert a;
       	
       	Map <String,Schema.RecordTypeInfo> oppRecordTypes = Opportunity.sObjectType.getDescribe().getRecordTypeInfosByName();
    	ID genSalesRecID = oppRecordTypes.get('Vin').getRecordTypeId();
       	Opportunity opp = new Opportunity(Name='Test', StageName='Prospect', CloseDate = date.today(), AccountID = a.ID, RecordTypeID = genSalesRecID);
       	insert opp;
       	
       	Template__c temp = new Template__c();
       	temp.API_Name__c = 'Account';
       	temp.Name__c = 'Test Template';
       	temp.Standard_Text__c = 'Lorem Ipsum';
       	insert temp;
       	
       	Template_Merge_Field__c tmf = new Template_Merge_Field__c();
       	tmf.API_Name__c = 'ATC_Account_ID__c';
       	tmf.Name__c = 'ATC Account ID';
       	tmf.Template__c = temp.ID;
       	insert tmf;
       	
       	Template_Merge_Field__c tmfTable = new Template_Merge_Field__c();
       	tmfTable.API_Name__c = 'StageName';
       	tmfTable.Name__c = 'oppStage';
       	tmfTable.Plural_Name__c = 'Opportunities';
       	tmfTable.Column_Header__c  = 'Stage Name';
       	tmfTable.template__c = temp.iD;
       	insert tmfTable;
       	
       	Dynamic_Email__c de = new Dynamic_Email__c();
       	de.Template__c = temp.ID;
       	de.Urgency__c = 'Critical';
       	insert de;
       	
       	EmailTemplate et = [SELECT ID, Name FROM EmailTemplate WHERE Name = 'Dynamic Email Template'];
       	Test.startTest();
       	test.setCurrentPage(new pageReference('/apex/emailSetup?relatedToID='+a.ID));
    	ctrl_EmailSetup controller = new ctrl_EmailSetup();
    	list<SelectOption> tempOps = controller.getTemplateOptions();
    	//controller.mainTemplate = temp;
    	controller.mainTemplate = temp;
    	controller.tempNum = 0;
    	controller.findTemplate();
    	controller.UrgencyImage = 'Critical';
    	controller.findUrgencyImage();
    	controller.UrgencyImage = 'Normal';
    	controller.findUrgencyImage();
    	controller.UrgencyImage = 'Low';
    	controller.findUrgencyImage();
		string s = controller.getStandardText();
    	controller.findUserInfo();

    	PageReference pr = controller.runHandler();
    	
    	test.setCurrentPage(new pageReference('/_ui/core/email/author/EmailAuthor?p3_lkid='+de.ID+'&template_id='+eT.ID+'&sobj_id='+a.ID));
    	ctrl_DynamicEmail controller2 = new ctrl_DynamicEmail();
    	//controller2.getDynamicEmail();
    	controller2.getThisID();
    	controller2.getEmail();
    	controller2.getFirstName();
    	controller2.getLastName();
    	controller2.getObjID();
    	controller2.getPhone();
    	controller2.getStandardText();
    	controller2.getTitle();
    	controller2.getDynamicEmail();
    	controller2.getExt();
    	controller2.getObjID();
    	list<dynamicEmailHandler.tableDisplay> emailTables = controller2.getTables();
    	
    	test.setCurrentPage(new pageReference('/apex/addTemplateMergeField'));
   		ApexPages.StandardController sc = new ApexPages.StandardController(temp);
    	ctrl_addTemplateMergeField controller3 = new ctrl_addTemplateMergeField(sc);
    	controller3.findFieldListStandard();
    	controller3.getTemplateTypes();
    	controller3.runRefresh();
    	controller3.findMergeFieldType();
    	pageReference pr2 = controller3.saveTMF();
    	
    	ctrl_EmailTables controller4 = new ctrl_EmailTables();
    	controller4.RID = a.ID;
    	controller4.tempID = temp.ID;
    	list<dynamicEmailHandler.tableDisplay> emailTables2 = controller4.getTables();
    	
    	ctrl_BannerComponent controller5 = new ctrl_BannerComponent();
    	controller5.getBanner();
    	
    	dynamicEmailHandler handler = new dynamicEmailHandler();
    	list<string> colHeaders = dynamicEmailHandler.findColumnHeaders(temp);
    	list<string> headerValues = dynamicEmailHandler.findHeaderValues(temp);
    	
    	Test.stopTest();
    }
}