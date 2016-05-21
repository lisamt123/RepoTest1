global class FOD_NewUserCompletedAggregation implements Database.Batchable<SObject>{
    
    
    global List<DashboardTaskStatus__c> dbSettingList = FOD_Helper.queryDashboardSettings('New User');
    global Map<String, String> tStatus_pStatus_Map = FOD_Helper.returnTaskStatus(dbSettingList);
        
    global Database.QueryLocator start(Database.BatchableContext bi){
        List<New_User_Task_Summary__c> nuList = [select id from New_User_Task_Summary__c where Name = 'NewUserCompletedAggregatedResult' limit 1];
        
        if(nuList != null && nuList.size() > 0) {
            delete nuList;
        }
        
        String subjectCondition = FOD_Helper.returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        String query = 'select WhatId, subject, Status, Date_Time_Completed__c from Task where ' + subjectCondition + ' and Status = \'Completed\' and Date_Time_Completed__c = THIS_QUARTER';
        return Database.getQueryLocator(query);
                                      
    }
   
   /*
    *  execute the bach process 
    */
    global void execute(Database.BatchableContext bi, List<sObject> scope){
        Date todayDate = System.today();
        Integer thisMonth = todayDate.month();
        
        Integer compByMonth = 0;
        Integer compByYear = 0;
        
        List<Task> taskListFromBatch = (List<sObject>)scope;
        for(Task tsk : taskListFromBatch) {
            if(tsk.Date_Time_Completed__c.month() == thisMonth) {
                compByMonth++;
            }
            compByYear++;
        }
        
        List<New_User_Task_Summary__c> nuList = [select id, Completed_By_Month_Count__c, Completed_By_Year_Count__c from New_User_Task_Summary__c where Name = 'NewUserCompletedAggregatedResult' limit 1];
        New_User_Task_Summary__c summaryRec;
        if(nuList != null && nuList.size() > 0) {
            summaryRec = nuList[0];
        } else {
            summaryRec = new New_User_Task_Summary__c(Name = 'NewUserCompletedAggregatedResult');
        }
        
        summaryRec.Completed_By_Month_Count__c = summaryRec.Completed_By_Month_Count__c == null ? compByMonth : (summaryRec.Completed_By_Month_Count__c + compByMonth);
        summaryRec.Completed_By_Year_Count__c = summaryRec.Completed_By_Year_Count__c == null ? compByYear : (summaryRec.Completed_By_Year_Count__c + compByYear);
        upsert summaryRec;
    }//end of method
    
   /*
    *  Send information After execute the bach process 
    */
    global void finish(Database.BatchableContext bi){   
        List<New_User_Task_Summary__c> nuList = [select id, Name, Completed_By_Month_Count__c, Completed_By_Year_Count__c from New_User_Task_Summary__c where (Name = 'NewUserCompletedAggregatedResult' or Name = 'NewUserLive')];
        
        New_User_Task_Summary__c recToUpsert = new New_User_Task_Summary__c(Name = 'NewUserLive');
        New_User_Task_Summary__c recToClone;
        
        for(New_User_Task_Summary__c nu : nuList) {
            if(nu.Name == 'NewUserLive') {
                recToUpsert.id = nu.id;
                
            } else if(nu.Name == 'NewUserCompletedAggregatedResult') {
                recToClone = nu;
            }
        }
        
        if(recToClone != null) {
            recToUpsert.Completed_By_Month_Count__c = recToClone.Completed_By_Month_Count__c;
            recToUpsert.Completed_By_Year_Count__c = recToClone.Completed_By_Year_Count__c;
        }   
        upsert recToUpsert;
        
        FOD_NewUserAggregationSchedule newUserSch = new FOD_NewUserAggregationSchedule();
        dateTime dt=System.now().addMinutes(30);
        String Csec,Cmin,Chr,Cday,Cmonth,CYear;
        Csec=String.valueof(dt.second());
        Cmin=String.valueof(dt.minute());
        Chr=String.valueof(dt.hour());
        Cday=String.valueof(dt.day());
        Cmonth=String.valueof(dt.month());
        CYear=String.valueof(dt.Year());
        String SchTimer = Csec+' '+Cmin+' '+Chr+' '+Cday+' '+Cmonth+' ? '+CYear;
        System.debug(LoggingLevel.INFO, 'timer = '+schTimer);
       
        String schTime = Cday+'/'+Cmonth+'/'+CYear+' '+Chr+':'+Cmin+':'+Csec;
       
        if(!Test.isRunningTest())
            system.schedule('New User Job Schedule ' + schTime, SchTimer, newUserSch);
    }
}