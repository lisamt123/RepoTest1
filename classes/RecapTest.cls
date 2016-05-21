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
private class RecapTest {

    static testMethod void RecapTest1() {
    	
    	Recap__c tRecap = new Recap__c();
    	
    	tRecap.RecordTypeId = '01270000000Q96C' ;// sandbox value'012S00000008lfY'
    	tRecap.Name = 'Test Recap';
    	tRecap.q1__c = 'YES';
    	tRecap.q2__c = 'YES';
    	tRecap.q3__c = 'NO';
    	tRecap.q4__c = 'YES';
    	tRecap.q5__c = 'No';
    	
    	insert tRecap;
    	
    	tRecap.Ready_To_Score__c = True;
    	
    	update tRecap;
    	
    	
    }

}