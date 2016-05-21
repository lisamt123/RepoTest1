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
private class PTO_Calendar_Controller_Test {

    static testMethod void calTest() {
    	
        PageReference ptoCal = Page.PTO_Calendar;
        Test.setCurrentPage(ptoCal);
        
        PTO_Calendar_Controller tstPTO = new PTO_Calendar_Controller();
        
        List<selectOption> departmentString = tstPTO.getrequestOptions();
        List<selectOption> managerString = tstPTO.getrequestOptionsB();
        
        tstPTO.departmentString = 'Sales';
        tstPTO.setptoRequests();
        tstPTO.departmentString = 'All Departments';
		tstPTO.managerString = 'Tom Walls';
        tstPTO.setptoRequests();
        tstPTO.returnHome();
        tstPTO.PTOobjrctPage();
    }
}