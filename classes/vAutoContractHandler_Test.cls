@isTest(SeeAllData=true) 
public class vAutoContractHandler_Test {
	static testMethod void  Cancel() {
		Account a =TestData.setupAccount();
		insert a;
		Contract  c = TestData.setupContract(a, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
		c.LOB__c = 'VAUTO';
		c.Action__c = 'Modify';
        c.Status = 'Draft';
		insert c;
		Billing_Item__c bl1 = TestData.setUpBillingItem(c, TestData.getProduct('Appraisal Tool','vAuto'));
		insert bl1;		
				Billing_Item__c bl2 = TestData.setUpBillingItem(c, TestData.getProduct('Pricing Tool','vAuto'));
		insert bl2;		
				Billing_Item__c bl3 = TestData.setUpBillingItem(c, TestData.getProduct('30 Day Deposit','vAuto'));
		insert bl3;		
				Billing_Item__c bl4 = TestData.setUpBillingItem(c, TestData.getProduct('PriceGuide.KelleyBlueBook (KarPower)','vAuto'));
		insert bl4;		
				Billing_Item__c bl5 = TestData.setUpBillingItem(c, TestData.getProduct('PriceGuide.KBBOnline','vAuto'));
		insert bl5;		
				Billing_Item__c bl6 = TestData.setUpBillingItem(c, TestData.getProduct('AutoWriter','vAuto'));
		insert bl6;		
				Billing_Item__c bl7 = TestData.setUpBillingItem(c, TestData.getProduct('Listings/Photos/Syndication','vAuto'));
		insert bl7;						
	   Test.startTest();
        
        /*
        //update the contract and set end date
        c.RecordTypeId = StaticData.getInstance().ContractRecTypesMapByDevName.get('Cancel_Contract').Id;
        c.Action__c = 'Modify';
        c.Status = 'Draft';
        c.Cancellation_Reason__c = 'Cutting Expenses';
        c.Integration_Status__c = 'Pending';
        c.StartDate = Date.today().addDays(-2);
        c.EndDate = Date.today();
        update c;
        List<Billing_Item__c> bLines = [Select Id, Action__c,End_Date__c,RecordTypeId from Billing_Item__c where Contract__c=: c.Id];
        System.assert(bLines.size() ==7 , 'Incorrect Billing Lines');
        for(Billing_Item__c item : bLines){
        	System.assert(item.Action__c == 'Cancelled', 'Action__c is not set to Cancelled after the contract was Cancelled');
        	System.assert(item.End_Date__c == c.EndDate, 'End_Date__c is not same as contract EndDate');
        	System.assert(item.RecordTypeId == StaticData.getInstance().BillingItemRecTypesMapByDevName.get('CANCEL').Id, 'RecordTypeId is not set to Cancel after the contract was Cancelled');        	
        }
        */
	   Test.stopTest();		

	}
}