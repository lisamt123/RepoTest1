@isTest
private class ParentAccount_test {

    static testMethod void myUnitTest() {
        
        User u_testMethodUser = TestData.setupUser();
        
        System.runas(u_testMethodUser) {
            
            Account testAcct = TestData.setupAccount();
            insert testAcct;
            
            //Set your controller
            ParentAccount controller = new ParentAccount();
            
            test.startTest();
            
            controller.setcurrentId(testAcct.Id);
            controller.getObjectStructure();
            
            
            
            test.stopTest();
        }
    }
}