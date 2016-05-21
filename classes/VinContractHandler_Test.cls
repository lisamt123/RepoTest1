@isTest(SeeAllData=true) 
public class  VinContractHandler_Test {
static testMethod void  ReadyToBill() {
		User testUser = TestData.setupUser();
		testUser.Business_Unit__c = 'VIN';
		update testUser;

		System.runAs(testUser){

			Account a =TestData.setupAccount();
			insert a;
			Contract  c = TestData.setupContract(a, StaticData.getInstance().ContractRecTypesMapByDevName.get('ADD'));
			c.LOB__c = 'VINSOLUTIONS';
			c.Status = 'Draft';
			insert c;
			Billing_Item__c bl1 = TestData.setUpBillingItem(c, TestData.getProduct('700 Credit Inc','VinSolutions'));
			bl1.RecordTypeId =StaticData.getInstance().BillingItemRecTypesMapByDevName.get('ADD').Id;
			bl1.Start_Date__c = Date.today();
			insert bl1;		
			Billing_Item__c bl2 = TestData.setUpBillingItem(c, TestData.getProduct('Advanced Inventory with Website and MPT Package','VinSolutions'));
			bl2.RecordTypeId =StaticData.getInstance().BillingItemRecTypesMapByDevName.get('MODIFY').Id;
			bl2.Start_Date__c = Date.today();
			insert bl2;
	 

		   Test.startTest();
	        
	        //update the contract and set Ready_To_Bill__c to true
	        c.Ready_To_Bill__c = TRUE;
	        c.StartDate = Date.today();
	        update c;
	        List<Billing_Item__c> bLines = [Select Id, Ready_To_Bill__c from Billing_Item__c where Contract__c=: c.Id];

	        System.assert(bLines.size() ==2, 'Incorrect Billing Lines');
	        for(Billing_Item__c item : bLines){
	        	//only lines with recordType ADD should be updated
	        	if(item.Id == bl1.Id){
	        	System.assert(item.Ready_To_Bill__c, 'Ready_To_Bill__c is not set to true; after the contractis set for ready to bill');
	        }
	        else{
	        System.assert(item.Ready_To_Bill__c == bl2.Ready_to_Bill__c, 'Ready_To_Bill__c is changed after the contract is set for ready to bill');	
	        }
	        }
		   Test.stopTest();		
		}   

	}

 /*
	static testMethod void  Cancel() {
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
        c.RecordTypeId = StaticData.getInstance().ContractRecTypesMapByDevName.get('Cancel_Contract').Id;
        c.Action__c = 'Modify';
        c.Status = 'Draft';
        c.StartDate = Date.today().addDays(-2);
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