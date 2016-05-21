/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class Haystak_CaseTriggerTest {
	// Set the test data size
	static final Integer DATA_SET_SIZE = 10;
	
	// Account 
	static Account acc;
	
	// Contact
	static Contact con;
	
	// The list of POA as setup data
	static List<POA__c> poaList;
	
	// The list of Cases related to POA
	static List<Case> caseList;
	
	static void setupData() {
		// Setup Account
		acc = new Account(Name = 'Haystak Test Account');
		insert acc;
		
		// Setup Contact
		con = new Contact(LastName = 'Haystak Contact', AccountId = acc.Id);
		insert con;
		
		// Setup POA data
		poaList = new List<POA__c>();
		for(Integer i = 0; i < DATA_SET_SIZE; i++) {
			poaList.add(new POA__C(
				Name = 'Haystak SEO-Integrity Motors-' + i
			));
		}
		insert poaList;
		
		// Setup Case Data
		caseList = new List<Case>();
		for(Integer i = 0; i < DATA_SET_SIZE * 5; i++) {
			caseList.add(new Case(
				AccountId = acc.Id,
				ContactId = con.Id,
				Origin = 'Phone',
				Product_Line__c = 'Service',
				Type = 'Problem',
				Status = 'New',
				POA__c = poaList[i / 5].Id
			));
		}
	}
	
    static testMethod void testUpdateCaseCountOnPOA() {
    	setupData();
    	
    	Test.startTest();
    	
    	poaList = [SELECT Id, Name, Case_Count__c FROM POA__c];
    	
    	Set<Id> poaIdSet = new Set<Id>();
        for(POA__c poa : poaList) {
        	System.assert(poa.Id <> null);
        	System.assert(poa.Case_Count__c == null);
        	poaIdSet.add(poa.Id);
        }
        
        insert caseList;       
        
        for(POA__c poa : [SELECT Case_Count__c FROM POA__c WHERE Id IN :poaIdSet]) {
        	System.assert(poa.Case_Count__c == 5);
        }
        
        delete caseList;
        
        for(POA__c poa : [SELECT Case_Count__c FROM POA__c WHERE Id IN :poaIdSet]) {
        	System.assert(poa.Case_Count__c == 0);
        }
        
        Test.stopTest();
    }
}