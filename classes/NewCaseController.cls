/*--------------------------------------------------------------------------
Author:         Moon Cui (Perficient)
Description:    Create a Case in Community.
History
1/28/2016   Moon Cui    Initial version
----------------------------------------------------------------------------*/
public with sharing class NewCaseController {
    @AuraEnabled
    public static String getCurrentUserInfo(){    
        User u = [SELECT Contact.Account.Name, Name,Phone,Email FROM User WHERE Id = :userInfo.getUserId()];
        UserInfoWrapper result = new UserInfoWrapper();
        if(u.Contact.Account.Name != null){
            result.accountName = u.Contact.Account.Name;
        }
        result.userName = u.Name;
        result.userEmail = u.Email;
        result.userPhone = u.Phone;
        return JSON.serialize(result);
    }
    public class UserInfoWrapper{
        public String accountName {get;set;}
        public String userName {get;set;}
        public String userEmail {get;set;}
        public String userPhone {get;set;}
    }
    @AuraEnabled
    public static List<String> getProductAreaList(){
        List<String> productAreaList = new List<String>();
        Schema.DescribeFieldResult fieldResult = Case.Product_Area__c.getDescribe();    
        List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry f : ple){
            productAreaList.add(f.getValue());
        }
        return productAreaList;
    }
    
    @AuraEnabled
    public static Case saveCase(Case newCase){
        Id caseRecordTypeId = Case.SObjectType.getDescribe().getRecordTypeInfosByName().get(CommunityConstants.CASE_CUSTOMER_RECORDTYPE_NAME).getRecordTypeId();
        newCase.RecordTypeId = caseRecordTypeId;
        newCase.Origin = CommunityConstants.CASE_ORIGIN_WEB;
        User currentUser = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId() limit 1];
        if(currentUser != null && currentUser.ContactId != null){
            newCase.ContactId = currentUser.ContactId;
        }
        List<Group> groups = [SELECT Id, DeveloperName FROM Group WHERE Type='Queue' AND DeveloperName = :CommunityConstants.CASE_QUEUE_DEV_NAME];
        if(groups.size() > 0){
            newCase.OwnerId = groups.get(0).Id;
        }
        upsert newCase;
        return newCase;
    }
}