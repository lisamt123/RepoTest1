@isTest
private class Utility_test {

     static testMethod void test_substring() {
            String testStr;
            system.assert(Utility.substring(testStr, 0, 2) == '','Null String did not produde a empty string');
            testStr = '';
            system.assert(Utility.substring(testStr, 0, 2) == '','Empty String did not produde a empty string');

            testStr = '       ';
            system.assert(Utility.substring(testStr, 0, 2) == '','Whitestace String did not produde a empty string');

            testStr = 'Test This String';
            system.assert(Utility.substring(testStr, 0, 2) == 'Te','Output is not valid');

            testStr = 'Test This String';
            system.assert(Utility.substring(testStr, 3, 4) == 't','Output is not valid');

            testStr = 'Test This String';
            System.assertEquals('t Th',Utility.substring(testStr, 3, 7));
            

            testStr = 'Test This String';
            system.assert(Utility.substring(testStr, 3, 50) == 't This String','Output is not valid');            

     }
    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	//Set your controller
        	//Utility controller = new Utility();
        	
        	test.startTest();
        	
        	Utility.throwExceptionError ();
        	
        	test.stopTest();
        }
    }
}