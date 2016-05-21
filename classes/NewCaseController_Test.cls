/*--------------------------------------------------------------------------
Author:         Moon Cui (Perficient)
Description:    Testing NewCaseController.
History
2/2/2016    Moon Cui    Initial version
----------------------------------------------------------------------------*/
@isTest
private class NewCaseController_Test {
    static final String UNIQ_NAME = 'NewCaseController_Test';
    static String accountName = 'NewCaseController_Test';
    static String userFirstName = 'NCC_Test_User_F';
    static String userLastName = 'NCC_Test_User_L';
    static String userEmail = 'NCC_Test_User@test.com';
    static String userPhone = '(123)455-6789';
    
    @isTest
    static void test_saveCase(){
        Case c = new Case();
        c.Subject = UNIQ_NAME;
        c.Description=UNIQ_NAME;
        Test.startTest();
            NewCaseController.saveCase(c);
        Test.stopTest();
        List<Case> caseList = [SELECT Subject, Description, ContactId, OwnerId FROM Case];
        System.assertEquals(1,caseList.size());
        Case cUpdated = caseList.get(0);
        String ownerId = cUpdated.OwnerId;
        System.assert(ownerId.startsWith('00G'));
        System.assertEquals(UNIQ_NAME, cUpdated.Subject);
        System.assertEquals(UNIQ_NAME, cUpdated.Description);
    }
    
    @isTest
    static void test_getProductAreaList(){
        List<String> paList = NewCaseController.getProductAreaList();
        System.assert(paList.size()>0,'Product Area list size should greater than 0');
    }
    
    @isTest
    static void test_getCurrentUserInfo(){
        String userInfo = NewCaseController.getCurrentUserInfo();
        System.assert(String.isNotEmpty(userInfo));
        NewCaseController.UserInfoWrapper userInfoWrapper = 
            (NewCaseController.UserInfoWrapper)JSON.deserialize(userInfo, NewCaseController.UserInfoWrapper.class);
        System.assertNotEquals(null,userInfoWrapper);
        System.assertNotEquals(null,userInfoWrapper.userName);
    }
}