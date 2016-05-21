global class scheduledTimeLogCreationInterface implements Schedulable{
    global void execute(SchedulableContext ctx) 
    {
    //Date lDate = system.today();
    //Datetime dt = datetime.newInstance(lDate.year(), lDate.month(),lDate.day());
    LIST<Time_Log__c> newTimeLogs = new LIST<Time_Log__c>();
        
    MAP<Id, UserLicense> userLicenses = new MAP<Id, UserLicense>([
    select Id, Name from UserLicense where Name = 'Salesforce' OR Name = 'Force.com - Free' OR Name = 'Salesforce Platform']);
            
    MAP<Id, Profile> userProfiles = new MAP<Id, Profile>([select Id, UserLicenseId from Profile where UserLicenseId IN: userLicenses.keyset()]);
 
    MAP<Id,SFDC_Paid_Time_Off__c> onPTO = new MAP<ID,SFDC_Paid_Time_Off__c>([Select Type__c, Total_Days_Requested__c, To_Date__c,SystemModstamp, Request_Type__c, Name, 
    IsDeleted, Id, Hours_to_be_Used__c,From_Date__c,Employee_s_Name__c, Employee_Role__c, Approving_Manager__c, Approval_Status__c, Employee_s_Name__r.Name, Employee_s_Name__r.Department From SFDC_Paid_Time_Off__c where (From_Date__c <= TODAY and To_Date__c >= TODAY) and Approval_Status__c = 'Approved']);
        
    List<Id> excludeIds = new List<Id>();

    for(id pto : onPTO.keyset()) excludeIds.add(onPTO.get(pto).Employee_s_Name__c);

    LIST<User> UsersExPTO = [select Id, isActive, isPortalEnabled from User where isActive = true AND isPortalEnabled = false AND ProfileId IN: userProfiles.keyset() AND Auto_Time_Log_Ignore__c = false And Id NOT IN: excludeIds];

    system.debug('Users not on PTO: ' + UsersExPTO.size());

    for(user b : UsersExPTO) system.debug(b.id);
        // old user query
        // LIST<User> allUsers = [select Id, isActive, isPortalEnabled from User where isActive = true AND isPortalEnabled = false AND ProfileId IN: userProfiles.keyset() AND Auto_Time_Log_Ignore__c = false];
        
        for (User user: UsersExPTO)
        {
            
            Time_Log__c newTimeLog = new Time_Log__c();
            newTimeLog.VS_Employee__c = user.Id;
            newTimeLog.OwnerId = user.Id;
            newTimeLog.Time_Log_Date__c = system.today();           
            newTimeLogs.add(newTimeLog);

        }
        insert newTimeLogs;
    }   
    
    //******Test methods******
    
    
    static testmethod void test()
    {
        Test.startTest();
        String jobId = System.schedule('scheduledTimeLogCreationInterface',
            '0 0 0 3 9 ? 2022', 
            new scheduledTimeLogCreationInterface());
         
        CronTrigger ct = [SELECT id, CronExpression, TimesTriggered, 
            NextFireTime
            FROM CronTrigger WHERE id = :jobId];
        System.assertEquals('0 0 0 3 9 ? 2022',
            ct.CronExpression);         
        
         
        System.assertEquals('2022-09-03 00:00:00', 
            String.valueOf(ct.NextFireTime));
        
        Test.stopTest();
    }
}