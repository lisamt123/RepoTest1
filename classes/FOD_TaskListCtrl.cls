public class FOD_TaskListCtrl {
    
    public List<TaskWrap> taskList {get; set;}
    public String pageTitle {get; set;}
    String durationCondition = '';
    
    public fod_TaskListCtrl() {
        taskList = new List<TaskWrap>();
        String pStatus = ApexPages.currentPage().getParameters().get('status');
        pageTitle = 'New User Session - ' + pStatus;
        
        String pCompletedType = ApexPages.currentPage().getParameters().get('completedtype');
        if(pCompletedType == 'month') {
             durationCondition = ' Date_Time_Completed__c = THIS_MONTH and ';
        }
        if(pCompletedType == 'year') {
             durationCondition = ' Date_Time_Completed__c = THIS_QUARTER and ';
        }
        
        if(pStatus != null && pStatus != '') {
            if(pStatus != 'Completed')
                queryTasks(pStatus);
            else if(pStatus == 'Completed')
                queryCompletedTasks();
        }
        SORT_Order = 'Asc';
    }
    
    public void queryTasks(String pStatus) {
        
        List<DashboardTaskStatus__c> dbSettingList = [select Project__c, Stage__c, Project_Status__c, Task_Status__c,
                Primary_Subject__c from DashboardTaskStatus__c where Project__c = 'New User' 
                and Project_Status__c = :pStatus];
                
        Map<String, String> tStatus_pStatus_Map = FOD_Helper.returnTaskStatus(dbSettingList);
        Set<String> statusSet = new Set<String>();
        statusSet.addAll(tStatus_pStatus_Map.keySet());
        System.debug('Status Set = '+statusSet);
        String subjectCondition = FOD_Helper.returnSubjectCondition(dbSettingList[0].Primary_Subject__c);
        
        String query = 'select WhatId, subject, Status, ActivityDate, Owner.Name, What.Name from Task where ' + durationCondition + subjectCondition + ' and Status in :statusSet';
        System.debug('query===' + query);
            
        assignToWrapper(Database.query(query));
    }
    
    public void queryCompletedTasks() {
        
        String subjectCondition = FOD_Helper.returnSubjectCondition('New User Session');
        
        String query = 'select WhatId, subject, Status, ActivityDate, Owner.Name, What.Name from Task where ' + durationCondition + subjectCondition + ' and Status = \'Completed\'';
        System.debug('query===' + query);
            
        assignToWrapper(Database.query(query));
    }
    
    public void assignToWrapper(List<Task> tskList) {
        for(Task tsk :tskList) {
            TaskWrap tw = new TaskWrap();
            //tw.accName = tw.What.Name;
            tw.Subject = tsk.Subject;
            tw.assigned = tsk.Owner.Name;
            tw.Status = tsk.Status;
            tw.tDate = tsk.ActivityDate;
            taskList.add(tw);
        }
    }
    
    public PageReference sortByAccName() {
        SORT_BY = 'AccName';
        sortList();
        return null;
    }
    
    public PageReference sortBySubject() {
        SORT_BY = 'Subject';
        sortList();
        return null;
    }
    
    public PageReference sortByActDate() {
        SORT_BY = 'ActDate';
        sortList();
        return null;
    }
    
    public PageReference sortByAssigned() {
        SORT_BY = 'AssignedTo';
        sortList();
        return null;
    }
    
    public PageReference sortByStatus() {
        SORT_BY = 'Status';
        sortList();
        return null;
    }
    
    public PageReference sortList() {
        if(SORT_Order == 'Asc') {
            SORT_Order = 'Desc';
            taskList.sort();
            
        } else if(SORT_Order == 'Desc') {
            SORT_Order = 'Asc';
            reverse();
            
        }
        return null;
    }
    
    public PageReference reverse() {
        List<TaskWrap> tmpList = new List<TaskWrap>();
        Integer size = taskList.size();

        for (Integer i = 0; i < size; i++) {
            tmpList.add(taskList.remove(taskList.size() - 1));
        }

        taskList = tmpList;

        return null;
    }
    
    public static String SORT_BY;
    public String SORT_Order;
    public class TaskWrap implements Comparable {
        public String accName {get; set;}
        public String subject {get; set;}
        public Date tdate {get; set;}
        public String assigned {get; set;}
        public String status {get; set;}
        
        public Integer compareTo(Object obj){
            TaskWrap tw = (TaskWrap)(obj);
            if (SORT_BY == 'AccName') {
                return sortByAccName(tw);
            }
            if (SORT_BY == 'Subject') {
                return sortBySubject(tw);
            }
            if (SORT_BY == 'ActDate') {
                return sortByActivityDate(tw);
            }
            if (SORT_BY == 'AssignedTo') {
                return sortByAssignedTo(tw);
            }
            if (SORT_BY == 'Status') {
                return sortByStatus(tw);
            }
            return 0;
        }
        
        @TestVisible private Integer sortString(String currVal, String compareTo) {
            if (currVal > compareTo) {
                return 1;
            }
            if (currVal == compareTo) {
                return 0;
            }
            return -1;
        }
        
        @TestVisible private Integer sortDate(Date currVal, Date compareTo) {
            if (currVal > compareTo) {
                return 1;
            }
            if (currVal == compareTo) {
                return 0;
            }
            return -1;
        }
        
        private Integer sortByAccName(TaskWrap tw) {
            return sortString(this.accName, tw.accName);
        }
        private Integer sortBySubject(TaskWrap tw) {
            return sortString(this.subject, tw.subject);
        }
        private Integer sortByActivityDate(TaskWrap tw) {
            return sortDate(this.tdate, tw.tdate);
        }
        private Integer sortByAssignedTo(TaskWrap tw) {
            return sortString(this.assigned, tw.assigned);
        }
        private Integer sortByStatus(TaskWrap tw) {
            return sortString(this.status, tw.status);
        }
        
        public taskWrap() {
            this.accName = accName;
            this.subject = subject;
            this.tdate = tdate;
            this.assigned = assigned;
            this.status = status;
        }
    }
}