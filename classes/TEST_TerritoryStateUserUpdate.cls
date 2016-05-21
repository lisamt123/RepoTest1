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
@isTest(SeeAllData=true)
private class TEST_TerritoryStateUserUpdate {
/*
    static testMethod void myUnitTest() {
    
    
    Territory_State__c TS = new Territory_State__c(); 
	TS.Name = 'BS';
	TS.DDM__c = [SELECT Id FROM User WHERE Name = 'Mark Ross'].Id;
	TS.Account_Manager__c = [SELECT Id FROM User WHERE Name = 'Mark Ross'].Id;
	TS.Website_AM__c = [SELECT Id FROM User WHERE Name = 'Mark Ross'].Id;
	
	insert TS;
    
    Account a = new Account();
    a.Name = 'TEST Trigger';
    a.BillingStreet = '123 ELM St';
    a.BillingCity = 'Warrensburg'; 
    a.BillingState = 'KS';
    a.BillingPostalCode = '64093';
    a.ShippingStreet = '123 ELM St';
    a.ShippingCity = 'Warrensburg'; 
    a.ShippingState = 'KS';
    a.ShippingPostalCode = '64093';
    a.Territory_State__c = TS.Id;
    
    insert a;
    
	
	
	TS.Website_AM__c = [SELECT Id FROM User WHERE Name = 'Dean Lukowski'].Id;	
	update TS;
	
	a.WAM2__c = TS.Website_AM__c;
	update a;
	
	TS.DDM__c = [SELECT Id FROM User WHERE Name = 'Dean Lukowski'].Id;
	update TS;
	
	TS.Account_Manager__c = [SELECT Id FROM User WHERE Name = 'Dean Lukowski'].Id;
	update TS;
    }
    */
}