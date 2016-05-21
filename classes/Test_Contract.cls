/*
Ramana Mosali: 10/28/2014
Adding this test class to improve the test coverage for contract trigger and its classes
handler_updateContractReadyToBill.cls
handler_updateContractCancel.cls
*/

@isTest(SeeAllData=true)
public with sharing class Test_Contract {
	static testMethod void  VINContractReadyToBill() {
		User testUser = TestData.setupUser();
		testUser.Business_Unit__c = 'VIN';
		update testUser;

	   System.runAs(testUser){
		Account a =TestData.setupAccount();
		insert a;
		Contract  c = TestData.setupContract(a, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
		c.LOB__c = 'VINSOLUTIONS';
		insert c;
		Billing_Item__c bl1 = TestData.setUpBillingItem(c, TestData.getProduct('700 Credit Inc','VinSolutions'));
		bl1.Ready_to_Bill__c = true;
		bl1.Start_Date__c = system.today();
		Database.SaveResult SR1 = Database.insert(bl1);	
		Billing_Item__c bl2 = TestData.setUpBillingItem(c, TestData.getProduct('Advanced Inventory with Website and MPT Package','VinSolutions'));
		bl2.Ready_to_Bill__c = true;
		bl2.Start_Date__c = system.today();
		Database.SaveResult SR2 = Database.insert(bl2);
 

	   Test.startTest();
		    //update the contract and set Ready_To_Bill__c to true
		    c.Ready_To_Bill__c = TRUE;
		    c.StartDate = Date.today();
		    update c;
		    List<Billing_Item__c> bLines = [Select Id, Ready_To_Bill__c from Billing_Item__c where Contract__c=: c.Id];
		    System.assert(bLines.size() ==2 , 'Incorrect Billing Lines');
		    for(Billing_Item__c item : bLines){
		    	System.assert(item.Ready_To_Bill__c, 'Ready_To_Bill__c is not set to true; after the contractis set for ready to bill');
		    }
		
	   Test.stopTest();		
	}
	}

/*
	static testMethod void  VINContractCancel() {
		Account a =TestData.setupAccount();
		insert a;
		Contract  c = TestData.setupContract(a, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
		c.LOB__c = 'VINSOLUTIONS';
		insert c;
		Billing_Item__c bl1 = TestData.setUpBillingItem(c, TestData.getProduct('700 Credit Inc','VinSolutions'));
		insert bl1;		
		Billing_Item__c bl2 = TestData.setUpBillingItem(c, TestData.getProduct('Advanced Inventory with Website and MPT Package','VinSolutions'));
		insert bl2;
 

	   Test.startTest();
        
        //update the contract and set end date
        c.RecordTypeId = StaticData.getInstance().ContractRecTypesMapByDevName.get('Cancel').Id;
        c.EndDate = Date.today();
        update c;
        List<Billing_Item__c> bLines = [Select Id, Action__c,End_Date__c,RecordTypeId from Billing_Item__c where Contract__c=: c.Id];
        System.assert(bLines.size() ==2 , 'Incorrect Billing Lines');
        for(Billing_Item__c item : bLines){
        	System.assert(item.Action__c == 'Cancelled', 'Action__c is not set to Cancelled after the contract was Cancelled');
        	System.assert(item.End_Date__c == c.EndDate, 'End_Date__c is not same as contract EndDate');
        	System.assert(item.RecordTypeId == StaticData.getInstance().BillingItemRecTypesMapByDevName.get('CANCEL').Id, 'RecordTypeId is not set to Cancel after the contract was Cancelled');        	
        }
	   Test.stopTest();		

	}
*/
}