@isTest
public class FOD_BatchTest {
    
    static testmethod void testNewUserAggregation(){
        customSettingData();
        SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Conquest 1', Approval_Stage__c = 'Integration');
        insert proj;
        proj.Name = 'Conquest 1';
        update proj;
        List<Task> tskList = new List<Task>();
        Task tsk1 = new Task(Subject = 'New User Session', Status = 'Not Started', WhatId = proj.id, Date_Time_Completed__c = System.today());
        tskList.add(tsk1);
        insert tskList;
            
        Test.StartTest();
            FOD_NewUserAggregation batch = new FOD_NewUserAggregation();
            Database.BatchableContext a;
            batch.start(a);
            batch.execute(a, [select WhatId, subject, Status from Task]);
        batch.finish(a);
        Test.StopTest();
        
        FOD_NewUserAggregationSchedule batchSch = new FOD_NewUserAggregationSchedule();
        SchedulableContext sc;
        batchSch.execute(sc);
    }
    
    static testmethod void testNewUserCompletedAggregation(){
        customSettingData();
        SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Conquest 1', Approval_Stage__c = 'Integration');
        insert proj;
        proj.Name = 'Conquest 1';
        update proj;
        List<Task> tskList = new List<Task>();
        Task tsk1 = new Task(Subject = 'New User Session', Status = 'Completed', WhatId = proj.id, Date_Time_Completed__c = System.today());
        tskList.add(tsk1);
        insert tskList;
        
        Test.StartTest();
            FOD_NewUserCompletedAggregation batch = new FOD_NewUserCompletedAggregation();
            Database.BatchableContext a;
            batch.start(a);
            String subjectCondition = 'New User Session';
            batch.execute(a, [select WhatId, subject, Status, Date_Time_Completed__c from Task where Subject = 'New User Session' and Status = 'Completed' and Date_Time_Completed__c = THIS_QUARTER]);
        batch.finish(a);
        Test.StopTest();
    }
    
    public static void customSettingData() {
        List<DashboardTaskStatus__c> dbList = new List<DashboardTaskStatus__c>();
        
        dbList.add(new DashboardTaskStatus__c(Name = 'New User1', Project__c = 'New User', Stage__c = '', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'New User Session', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'New User2', Project__c = 'New User', Stage__c = '', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'New User Session', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'New User3', Project__c = 'New User', Stage__c = '', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'New User Session', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'New User4', Project__c = 'New User', Stage__c = '', Project_Status__c = 'Completed', Task_Status__c = 'Completed', Primary_Subject__c = 'New User Session', Secondary_Subject__c = ''));
        
        insert dbList;
    }
}