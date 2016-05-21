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
private class Haystak_TaskTriggerTest {
    // Set the test data size
    static final Integer DATA_SET_SIZE = 2;
    
    // Account 
    static Account acc;
    
    // Contact
    static Contact con;
    
    // The list of POA as setup data
    static List<POA__c> poaList;
    
    // The list of Tasks related to POA
    static List<Task> taskList;
  
  	static void setupData() {
        // Setup Account
        acc = new Account(Name = 'Haystak Test Account');
        insert acc;
        
        // Setup Contact
        con = new Contact(LastName = 'Haystak Contact', AccountId = acc.Id);
        insert con;
        
        // Setup User
        User testUser = TestData.setupUser();
        testUser.CompanyName = 'Haystak';
        update testUser;
            
        // Setup POA data
        poaList = new List<POA__c>();
        for(Integer i = 0; i < DATA_SET_SIZE; i++) {
        	poaList.add(new POA__c(
            	Name = 'Haystak SEO-Integrity Motors-' + i
            ));
        }
        insert poaList;
            
        
        // Setup Task Data
        taskList = new List<Task>();
        for(Integer i = 0; i < DATA_SET_SIZE; i++) {
            taskList.add(new Task(
                OwnerId = testUser.Id,
                WhoId = con.Id,
                Subject = 'Subject ' + i,
                ActivityDate = System.today(),
                Status = 'Not Started',
                Priority = 'Normal',
                WhatId = poaList[i].Id
            ));
        }   
            
  	}
  
    static testMethod void testUpdateTaskCountOnPOA() {
        setupData();
        
        Map<Id, Decimal> poaTaskMap = new Map<Id, Decimal>();
        
        for(POA__c poa : poaList) {
            poaTaskMap.put(poa.Id, null);
        }
        
        List<POA__c> qPoaList = [SELECT Id, (SELECT WhatId FROM Tasks) FROM POA__c WHERE Id IN :poaTaskMap.keyset()];
        
        //This for loop will get the count of the Tasks created by the workFlows for POA 
        for(POA__c poa : qPoaList) {
            Integer taskSize = poa.Tasks.size();
            poaTaskMap.put(poa.Id, taskSize);
        }
        
        insert taskList; 
        
        Test.startTest();
        
        //The total number of tasks created for each POA record should be the sum of
        //default number of tasks created by workflows on POA plus the task created in setup data(1).
        for(POA__c poa : [SELECT Id, Activity_Count__c FROM POA__c]) {
            System.assertEquals(poa.Activity_Count__c, (poaTaskMap.get(poa.Id) + 1));
        }
          
		delete taskList;
        
        //After deletion the total count of tasks on POA record should be less than one.
        for(POA__c poa : [SELECT Id, Activity_Count__c FROM POA__c]) {
            System.assertEquals(poa.Activity_Count__c, poaTaskMap.get(poa.Id));
        }
          
        Test.stopTest();
    }
}