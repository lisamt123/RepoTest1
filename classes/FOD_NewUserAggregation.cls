global class FOD_NewUserAggregation implements Database.Batchable<SObject>{
    
    
    global List<DashboardTaskStatus__c> dbSettingList = FOD_Helper.queryDashboardSettings('New User');
    global Map<String, String> tStatus_pStatus_Map = FOD_Helper.returnTaskStatus(dbSettingList);
        
    global Database.QueryLocator start(Database.BatchableContext bi){
        List<New_User_Task_Summary__c> nuList = [select id from New_User_Task_Summary__c where Name = 'NewUserAggregatedResult' limit 1];
        
        if(nuList != null && nuList.size() > 0) {
            delete nuList;
        }
        Set<String> statusSet = new Set<String>();
        statusSet.addAll(tStatus_pStatus_Map.keySet());
        String subjectCondition = FOD_Helper.returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        String query = 'select WhatId, subject, Status from Task where ' + subjectCondition + ' and Status in :statusSet';
        return Database.getQueryLocator(query);
                                      
    }
   
   /*
    *  execute the bach process 
    */
    global void execute(Database.BatchableContext bi, List<sObject> scope){
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        Set<String> tStatusSet = new Set<String>();
        List<Task> taskListFromBatch = (List<sObject>)scope;
        for(Task tsk : taskListFromBatch) {
            if(tStatus_pStatus_Map != null && tStatus_pStatus_Map.containsKey(tsk.Status)) {
                String pStatus = tStatus_pStatus_Map.get(tsk.Status);
                Integer count = 0;
                if(map_pStatusCount != null && map_pStatusCount.containsKey(pStatus)) {
                    count = map_pStatusCount.get(pStatus);
                }
                count++;
                map_pStatusCount.put(pStatus, count);
                tStatusSet.add(tsk.Status);
            }
        }
        System.debug('map_pStatusCount===' + map_pStatusCount);
        List<New_User_Task_Summary__c> nuList = [select id, Active_Count__c, Deferred_Count__c, Escalated_Count__c from New_User_Task_Summary__c where Name = 'NewUserAggregatedResult' limit 1];
        New_User_Task_Summary__c summaryRec;
        if(nuList != null && nuList.size() > 0) {
            summaryRec = nuList[0];
        } else {
            summaryRec = new New_User_Task_Summary__c(Name = 'NewUserAggregatedResult');
        }
        Integer actCnt = 0;
        Integer defCnt = 0;
        Integer escCnt = 0;
        if(map_pStatusCount.containsKey('Active'))                 actCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Deferred'))               defCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))        escCnt = map_pStatusCount.get('Escalated to PM');
        
        summaryRec.Active_Count__c = summaryRec.Active_Count__c == null ? actCnt : (summaryRec.Active_Count__c + actCnt);
        summaryRec.Deferred_Count__c = summaryRec.Deferred_Count__c == null ? defCnt : (summaryRec.Deferred_Count__c + defCnt);
        summaryRec.Escalated_Count__c = summaryRec.Escalated_Count__c == null ? escCnt : (summaryRec.Escalated_Count__c + escCnt);
        upsert summaryRec;
    }//end of method
    
   /*
    *  Send information After execute the bach process 
    */
    global void finish(Database.BatchableContext bi){   
        List<New_User_Task_Summary__c> nuList = [select id, Name, Active_Count__c, Deferred_Count__c, Escalated_Count__c from New_User_Task_Summary__c where (Name = 'NewUserAggregatedResult' or Name = 'NewUserLive')];
        
        New_User_Task_Summary__c recToUpsert = new New_User_Task_Summary__c(Name = 'NewUserLive');
        New_User_Task_Summary__c recToClone;
        
        for(New_User_Task_Summary__c nu : nuList) {
            if(nu.Name == 'NewUserLive') {
                recToUpsert.id = nu.id;
                
            } else if(nu.Name == 'NewUserAggregatedResult') {
                recToClone = nu;
            }
        }
        
        if(recToClone != null) {
            recToUpsert.Active_Count__c = recToClone.Active_Count__c;
            recToUpsert.Deferred_Count__c = recToClone.Deferred_Count__c;
            recToUpsert.Escalated_Count__c = recToClone.Escalated_Count__c;
        }   
        upsert recToUpsert;
        
        FOD_NewUserCompletedAggregation  tb = new FOD_NewUserCompletedAggregation () ;
        Database.executeBatch(tb);
    }
}