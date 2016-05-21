public class FOD_Helper {
    
    /***** NEW LOGIC START *******/
    
    public static String excludeOppCondition() {
        //String excludeOpp = ' and ((NOT Opportunity__r.Name like \'%HQ Tree%\') and (NOT Opportunity__r.Name like \'%Price Change%\')) ';
        String excludeOpp = ' and (NOT(Name like \'%HQ Tree%\' or Name like \'%Price Change%\' or Name like \'%AUX Account Setup%\' or Name like \'%Remove%\' or Name like \'%Auto Trader Canada%\')) ';
        return excludeOpp;
    }
    
    public static Map<String, Integer> projectCount(String pName, String pStage) {
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        
        List<DashboardTaskStatus__c> dbSettingList = queryDashboardSettings(pName, pStage);
        
        Map<String, String> tStatus_pStatus_Map = returnTaskStatus(dbSettingList);
        Set<String> statusSet = new Set<String>();
        statusSet.addAll(tStatus_pStatus_Map.keySet());
        
        String subjectCondition = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query = 'select id, name, (select WhatId, subject, Status from Tasks where ' + subjectCondition + ' and Status in :statusSet) from SFDC_520_Quote__c where Name like \'%' + pName + '%\' and Approval_Stage__c = :pStage';
        System.debug('-tStatus_pStatus_Map--' + tStatus_pStatus_Map);
        for(SFDC_520_Quote__c proj :Database.query(query)) {
            Set<String> tStatusSet = new Set<String>();
                
            for(Task tsk :proj.Tasks) {
                
                if(tStatus_pStatus_Map != null && tStatus_pStatus_Map.containsKey(tsk.Status)) {
                    String pStatus = tStatus_pStatus_Map.get(tsk.Status);
                    Integer count = 0;
                    if(map_pStatusCount != null && map_pStatusCount.containsKey(pStatus)) {
                        count = map_pStatusCount.get(pStatus);
                    }
                    if(!tStatusSet.contains(tsk.Status)) count++;
                    map_pStatusCount.put(pStatus, count);
                    tStatusSet.add(tsk.Status);
                }
            }
        }
        return map_pStatusCount;
    }
    
    public static List<SFDC_520_Quote__c> returnProjectTask(String pName, String pStage, String pStatus) {
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        
        List<DashboardTaskStatus__c> dbSettingList = queryDashboardSettings(pName, pStage, pStatus);
        
        Map<String, String> tStatus_pStatus_Map = returnTaskStatus(dbSettingList);
        Set<String> statusSet = new Set<String>();
        statusSet.addAll(tStatus_pStatus_Map.keySet());
        
        String subjectCondition1 = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query1 = 'select id, name, (select WhatId, subject, Status, Owner.Name, Date_Time_Completed__c from Tasks where ' + subjectCondition1 + ' and Status in :statusSet) from SFDC_520_Quote__c where Name like \'%' + pName + '%\' and Approval_Stage__c = :pStage';
        Set<Id> projIds = new Set<Id>();
        for(SFDC_520_Quote__c proj :Database.query(query1)) {
            if(proj.Tasks != null && proj.Tasks.size() > 0)
                projIds.add(proj.id);
        }
        
        String secSub = dbSettingList[0].Secondary_Subject__c == null ? '' : dbSettingList[0].Secondary_Subject__c;
        
        String subjectCondition = returnSubjectStatusCondition(dbSettingList[0].Primary_Subject__c, secSub, statusSet);
        
        String query = 'select id, name, Approval_Stage__c, Account__r.Name, Start_Date__c, (select WhatId, Subject, Status, Activity_Age__c, CreatedDate, Owner.Name, Date_Time_Completed__c from Tasks where ' + subjectCondition + ' ) from SFDC_520_Quote__c where id in :projIds';
        
        return Database.query(query);
    }
    
    public static Map<String, Integer> projectCountForNewUser(String pName) {
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        
        List<DashboardTaskStatus__c> dbSettingList = queryDashboardSettings(pName);
        
        Map<String, String> tStatus_pStatus_Map = returnTaskStatus(dbSettingList);
        Set<String> statusSet = new Set<String>();
        statusSet.addAll(tStatus_pStatus_Map.keySet());
        System.debug('statusSet==' + statusSet);
        String subjectCondition = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query = 'select WhatId, subject, Status from Task where ' + subjectCondition + ' and Status in :statusSet';
        System.debug('query==' + query);
        
        Set<String> tStatusSet = new Set<String>();
            
        for(Task tsk :Database.query(query)) {
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
        return map_pStatusCount;
    }
    
    public static Map<String, Integer> projectCountForNewUserCompleted(String pName) {
        Map<String, Integer> map_monthCount = new Map<String, Integer>();
        List<DashboardTaskStatus__c> dbSettingList = queryDashboardSettings(pName);
        
        String subjectCondition = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query = 'select WhatId, subject, Status, Date_Time_Completed__c from Task where ' + subjectCondition + ' and Status = \'Completed\'';
        System.debug('query==' + query);
        
        Date todayDate = System.today();
        Integer thisMonth = todayDate.month();
        
        Integer compByMonth = 0;
        Integer compByYear = 0;
           
        for(Task tsk :Database.query(query)) {
            if(tsk.Date_Time_Completed__c.month() == thisMonth) {
                compByMonth++;
            }
            compByYear++;
        }
        map_monthCount.put('Month', compByMonth);
        map_monthCount.put('Year', compByYear);
        return map_monthCount;
    }
    
    public static Map<String, Integer> projectCountForCompleted(String pName) {
        Map<String, Integer> map_monthCount = new Map<String, Integer>();
        
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c from DashboardTaskStatus__c where Project__c = :pName and Project_Status__c = 'Completed'];
        
        
        String subjectCondition = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query = 'select id, name, (select WhatId, subject, Status, Date_Time_Completed__c from Tasks where ' + subjectCondition + ' and Status = \'Completed\' and Date_Time_Completed__c = THIS_QUARTER) from SFDC_520_Quote__c where Name like \'%' + pName + '%\'';
        Date todayDate = System.today();
        Integer thisMonth = todayDate.month();
        
        Integer compByMonth = 0;
        Integer compByYear = 0;
        
        for(SFDC_520_Quote__c proj :Database.query(query)) {
            Set<String> tStatusSet = new Set<String>();
            
            for(Task tsk :proj.Tasks) {
                if(tsk.Date_Time_Completed__c.month() == thisMonth) {
                    compByMonth++;
                }
                compByYear++;
                break;
            }
        }
        map_monthCount.put('Month', compByMonth);
        map_monthCount.put('Year', compByYear);
        return map_monthCount;
    }
    
    public static List<SFDC_520_Quote__c> returnProjectTaskCompleted(String pName, String duration) {
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c, Secondary_Subject__c from DashboardTaskStatus__c where Project__c = :pName and Project_Status__c = 'Completed'];
        
        
        String subjectCondition1 = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query1 = 'select id, name, (select WhatId, subject, Status, Owner.Name, Date_Time_Completed__c from Tasks where ' + subjectCondition1 + ' and Status = \'Completed\') from SFDC_520_Quote__c where Name like \'%' + pName + '%\'';
        Set<Id> projIds = new Set<Id>();
        for(SFDC_520_Quote__c proj :Database.query(query1)) {
            if(proj.Tasks != null && proj.Tasks.size() > 0)
                projIds.add(proj.id);
        }
        System.debug('projIds==' + projIds);
        String secSub = dbSettingList[0].Secondary_Subject__c == null ? '' : dbSettingList[0].Secondary_Subject__c;
        
        Set<String> statusSet = new Set<String>();
        statusSet.add('Completed');
        String subjectCondition = returnSubjectStatusCondition(dbSettingList[0].Primary_Subject__c, secSub, statusSet);
        
        String durationCondition = '';
        if(duration == 'month') {
             durationCondition = ' Date_Time_Completed__c = THIS_MONTH and ';
        }
        if(duration == 'year') {
             durationCondition = ' Date_Time_Completed__c = THIS_QUARTER and ';
        }
        
        String query = 'select id, name, Approval_Stage__c, Account__c, Account__r.Name, Start_Date__c, (select WhatId, Subject, Status, Activity_Age__c, CreatedDate, Owner.Name, Date_Time_Completed__c from Tasks where ' +  durationCondition + subjectCondition  + ' ) from SFDC_520_Quote__c where id in :projIds';
        System.debug('query===' + query);
        return Database.query(query);
    }
    
    public static Map<Id, List<Task>> returnProjectTaskSecondary(String pName, String duration) {
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c, Secondary_Subject__c from DashboardTaskStatus__c where Project__c = :pName and Project_Status__c = 'Completed'];
        
        
        String subjectCondition1 = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query1 = 'select id, name, (select WhatId, subject, Status, Owner.Name, Date_Time_Completed__c from Tasks where ' + subjectCondition1 + ' and Status = \'Completed\') from SFDC_520_Quote__c where Name like \'%' + pName + '%\'';
        Set<Id> projIds = new Set<Id>();
        for(SFDC_520_Quote__c proj :Database.query(query1)) {
            if(proj.Tasks != null && proj.Tasks.size() > 0)
                projIds.add(proj.id);
        }
        
        String secSub = dbSettingList[0].Secondary_Subject__c == null ? '' : dbSettingList[0].Secondary_Subject__c;
        
        String subjectCondition = '';
        List<String> secSubList = secSub.split(',');
        Integer count = 0;
        for(String str :secSubList) {
            str = str.trim();
            if(str != '')
            count++;
            if(count == 1) subjectCondition = ' ( ';
            if(count == secSubList.size())
                subjectCondition += ' Subject like \'%' + str + '%\' ) and';
            else
                subjectCondition += ' Subject like \'%' + str + '%\' or ';
        }
        
        Map<Id, List<Task>> mapProjectTaskMap = new Map<Id, List<Task>>();
        
        
        String query2 = 'select id, name, Approval_Stage__c, Account__c, Account__r.Name, Start_Date__c, (select WhatId, Subject, Status, Activity_Age__c, CreatedDate, Owner.Name, Date_Time_Completed__c from Tasks where ' +  subjectCondition  + ' Status != \'Completed\') from SFDC_520_Quote__c where id in :projIds';
        
        for(SFDC_520_Quote__c proj :Database.query(query2)) {
            if(proj.Tasks != null && proj.Tasks.size() > 0) {
                System.debug('proj.id==== ' + proj.id);
                System.debug('proj.name==== ' + proj.name);
                mapProjectTaskMap.put(proj.id, proj.Tasks);
            }
        }
        
        String query3 = 'select id, name, Approval_Stage__c, Account__r.Name, Start_Date__c, (select WhatId, Subject, Status, Activity_Age__c, CreatedDate, Owner.Name, Date_Time_Completed__c from Tasks where ' +  subjectCondition  + ' Status = \'Completed\') from SFDC_520_Quote__c where id in :projIds';
        
        List<SFDC_520_Quote__c> projList2 = new List<SFDC_520_Quote__c>();
        
        projList2 = Database.query(query3);
        
        for(SFDC_520_Quote__c proj :projList2) {
            if(proj.Tasks != null && proj.Tasks.size() > 0) {
                List<Task> tskList = new List<Task>();
                if(mapProjectTaskMap.containsKey(proj.id)) {
                    tskList.addAll(mapProjectTaskMap.get(proj.id));
                }
                tskList.addAll(proj.Tasks);
                mapProjectTaskMap.put(proj.id, tskList);
            }
        }
        
        return mapProjectTaskMap;
    }
    
    public static List<SFDC_520_Quote__c> returnProjectTaskCompletedDT(String pName, String duration, String dealerType) {
        String dealerTypeCondition = ' and Account__r.Dealer_Type__c = :dealerType ';
        if(dealerType == 'Other')
            dealerTypeCondition = 'and Account__r.Dealer_Type__c = null';
        
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c, Secondary_Subject__c from DashboardTaskStatus__c where Project__c = :pName and Project_Status__c = 'Completed'];
        
        
        String subjectCondition1 = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query1 = 'select id, name, (select WhatId, subject, Status, Owner.Name, Date_Time_Completed__c from Tasks where ' + subjectCondition1 + ' and Status = \'Completed\') from SFDC_520_Quote__c where Name like \'%' + pName + '%\' ' + dealerTypeCondition;
        Set<Id> projIds = new Set<Id>();
        for(SFDC_520_Quote__c proj :Database.query(query1)) {
            if(proj.Tasks != null && proj.Tasks.size() > 0)
                projIds.add(proj.id);
        }
        System.debug('projIds==' + projIds);
        String secSub = dbSettingList[0].Secondary_Subject__c == null ? '' : dbSettingList[0].Secondary_Subject__c;
        
        Set<String> statusSet = new Set<String>();
        statusSet.add('Completed');
        String subjectCondition = returnSubjectStatusCondition(dbSettingList[0].Primary_Subject__c, secSub, statusSet);
        
        String durationCondition = '';
        if(duration == 'month') {
             durationCondition = ' Date_Time_Completed__c = THIS_MONTH and ';
        }
        if(duration == 'year') {
             durationCondition = ' Date_Time_Completed__c = THIS_QUARTER and ';
        }
        
        String query = 'select id, name, Approval_Stage__c, Account__c, Account__r.Name, Start_Date__c, (select WhatId, Subject, Status, Activity_Age__c, CreatedDate, Owner.Name, Date_Time_Completed__c from Tasks where ' +  durationCondition + subjectCondition  + ' ) from SFDC_520_Quote__c where id in :projIds';
        System.debug('query===' + query);
        return Database.query(query);
    }
    
    public static Map<Id, List<Task>> returnProjectTaskSecondaryDT(String pName, String duration, String dealerType) {
        String dealerTypeCondition = ' and Account__r.Dealer_Type__c = :dealerType ';
        if(dealerType == 'Other')
            dealerTypeCondition = 'and Account__r.Dealer_Type__c = null';
        
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c, Secondary_Subject__c from DashboardTaskStatus__c where Project__c = :pName and Project_Status__c = 'Completed'];
        
        
        String subjectCondition1 = returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String durationCondition = '';
        if(duration == 'month') {
             durationCondition = ' Date_Time_Completed__c = THIS_MONTH and ';
        }
        if(duration == 'year') {
             durationCondition = ' Date_Time_Completed__c = THIS_QUARTER and ';
        }
        
        String query1 = 'select id, name, (select WhatId, subject, Status, Owner.Name, Date_Time_Completed__c from Tasks where ' + subjectCondition1 + ' and Status = \'Completed\') from SFDC_520_Quote__c where Name like \'%' + pName + '%\' ' + dealerTypeCondition;
        Set<Id> projIds = new Set<Id>();
        for(SFDC_520_Quote__c proj :Database.query(query1)) {
            if(proj.Tasks != null && proj.Tasks.size() > 0)
                projIds.add(proj.id);
        }
        
        String secSub = dbSettingList[0].Secondary_Subject__c == null ? '' : dbSettingList[0].Secondary_Subject__c;
        
        String subjectCondition = '';
        List<String> secSubList = secSub.split(',');
        Integer count = 0;
        for(String str :secSubList) {
            str = str.trim();
            if(str != '')
            count++;
            if(count == 1) subjectCondition = ' ( ';
            if(count == secSubList.size())
                subjectCondition += ' Subject like \'%' + str + '%\' ) and';
            else
                subjectCondition += ' Subject like \'%' + str + '%\' or ';
        }
        
        Map<Id, List<Task>> mapProjectTaskMap = new Map<Id, List<Task>>();
        
        
        String query2 = 'select id, name, Approval_Stage__c, Account__c, Account__r.Name, Start_Date__c, (select WhatId, Subject, Status, Activity_Age__c, CreatedDate, Owner.Name, Date_Time_Completed__c from Tasks where ' + subjectCondition  + ' Status != \'Completed\') from SFDC_520_Quote__c where id in :projIds';
        
        for(SFDC_520_Quote__c proj :Database.query(query2)) {
            if(proj.Tasks != null && proj.Tasks.size() > 0) {
                System.debug('proj.id==== ' + proj.id);
                System.debug('proj.name==== ' + proj.name);
                mapProjectTaskMap.put(proj.id, proj.Tasks);
            }
        }
        
        String query3 = 'select id, name, Approval_Stage__c, Account__r.Name, Start_Date__c, (select WhatId, Subject, Status, Activity_Age__c, CreatedDate, Owner.Name, Date_Time_Completed__c from Tasks where ' + subjectCondition  + ' Status = \'Completed\') from SFDC_520_Quote__c where id in :projIds';
        
        List<SFDC_520_Quote__c> projList2 = new List<SFDC_520_Quote__c>();
        
        projList2 = Database.query(query3);
        
        for(SFDC_520_Quote__c proj :projList2) {
            if(proj.Tasks != null && proj.Tasks.size() > 0) {
                List<Task> tskList = new List<Task>();
                if(mapProjectTaskMap.containsKey(proj.id)) {
                    tskList.addAll(mapProjectTaskMap.get(proj.id));
                }
                tskList.addAll(proj.Tasks);
                mapProjectTaskMap.put(proj.id, tskList);
            }
        }
        
        return mapProjectTaskMap;
    }
    
    public static String returnSubjectStatusCondition(String priSubject, String secSubject, Set<String> statusSet) {
        String subCond = '';
        subCond += ' ((Subject like \'%' + priSubject + '%\' and Status in : statusSet) ';
        
        for(String str :secSubject.split(',')) {
            str = str.trim();
            if(str != '')
            subCond += ' or Subject like \'%' + str + '%\'';
        }
        subCond += ')';
        return subCond;
    }
    
    public static String returnSubjectCondition(String taskSubject) {
        String subQry = '';
        taskSubject = taskSubject.trim();
        subQry += 'Subject like \'%' + taskSubject + '%\'';
        return subQry;
    }
    
    public static Map<String, String> returnTaskStatus(List<DashboardTaskStatus__c> dbSettingList) {
        Map<String, String> tStatus_pStatus_Map = new Map<String, String>();
        
        for(DashboardTaskStatus__c ts : dbSettingList) {
            for(String st :ts.Task_Status__c.split(',')) {
                st = st.trim();
                if(st != 'Completed')
                    tStatus_pStatus_Map.put(st, ts.Project_Status__c);
            }
        }
        return tStatus_pStatus_Map;
    }
    
    public static List<DashboardTaskStatus__c> queryDashboardSettings(String pName) {
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c from DashboardTaskStatus__c where Project__c = :pName];
        return dbSettingList;
    }
    
    
    public static List<DashboardTaskStatus__c> queryDashboardSettings(String pName, String pStage) {
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c from DashboardTaskStatus__c where Project__c = :pName and Stage__c = :pStage
                and Project_Status__c != 'Completed'];
        return dbSettingList;
    }
    
    public static List<DashboardTaskStatus__c> queryDashboardSettings(String pName, String pStage, String pStatus) {
        System.debug('pName==' + pName);
        System.debug('pStage==' + pStage);
        System.debug('pStatus==' + pStatus);
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c, Secondary_Subject__c from DashboardTaskStatus__c 
                where Project__c = :pName and Stage__c = :pStage
                and Project_Status__c = :pStatus];
        return dbSettingList;
    }
    
    /***** NEW LOGIC END *******/
    
}