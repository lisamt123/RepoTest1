public class FOD_ProvisionCtrl {
    
    public Integer activeIntCnt  {get;set;}
    public Integer activeTrnCnt  {get;set;}
    public Integer intDefCnt  {get;set;}
    public Integer intDelCnt  {get;set;}
    public Integer trnDefCnt  {get;set;}
    public Integer trnDelCnt  {get;set;}
    public Integer intEscCnt  {get;set;}
    public Integer trnEscCnt  {get;set;}
    public Integer completedByMonthCnt  {get;set;}
    public Integer completedByYearCnt  {get;set;}
    public Decimal budgetMTD {get;set;}
    public Decimal budgetQTD {get;set;}
    public static String chStr {get; set;}
    static Map<String, Set<Id>> mapMttrAccIds = new Map<String, Set<Id>>();
        
    public fod_ProvisionCtrl() {
        activeIntCnt = 0;
        activeTrnCnt = 0;
        intDefCnt = 0;
        intDelCnt = 0;
        trnDefCnt = 0;
        trnDelCnt = 0;
        intEscCnt = 0;
        trnEscCnt = 0;
        completedByMonthCnt = 0;
        completedByYearCnt = 0;
        budgetMTD = 0;
        budgetQTD = 0;
        queryProjects();
        chStr = '';
        //doSearch('Account Setup');
    }
    
    public void queryProjects() {
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        map_pStatusCount = FOD_Helper.projectCount('Account Setup', 'Integration');
        
        if(map_pStatusCount.containsKey('Active'))                activeIntCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Back to Sales'))         intDelCnt = map_pStatusCount.get('Back to Sales');
        if(map_pStatusCount.containsKey('Deferred'))              intDefCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       intEscCnt = map_pStatusCount.get('Escalated to PM');
        
        map_pStatusCount = FOD_Helper.projectCount('Account Setup', 'Training 1');
        
        if(map_pStatusCount.containsKey('Active'))                activeTrnCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Back to Sales'))         trnDelCnt = map_pStatusCount.get('Back to Sales');
        if(map_pStatusCount.containsKey('Deferred'))              trnDefCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       trnEscCnt = map_pStatusCount.get('Escalated to PM');
        
        map_pStatusCount = FOD_Helper.projectCountForCompleted('Account Setup');
        if(map_pStatusCount.containsKey('Month'))                 completedByMonthCnt = map_pStatusCount.get('Month');
        if(map_pStatusCount.containsKey('Year'))                  completedByYearCnt = map_pStatusCount.get('Year');
        
        List<FO_Project_Budget__c> budgetList = [select Provision_Budget__c, Budget_Date__c from FO_Project_Budget__c 
                    where Budget_Date__c = THIS_QUARTER];
        Integer thisMonth = System.today().month();
        for(FO_Project_Budget__c bgt : budgetList) {
            if(bgt.Provision_Budget__c != null) {
                Decimal budgetAmt = bgt.Provision_Budget__c;
                if(bgt.Budget_Date__c.month() == thisMonth)
                    budgetMTD = budgetAmt.setScale(0);
                budgetQTD += budgetAmt.setScale(0);
            }
        }
    }
    
    
    public static String doSearch(String selDuration) {
        String pName = 'Account Setup';
        String pStatus = 'Completed'; //ApexPages.currentPage().getParameters().get('onholdtype');
        String pCompletedType = selDuration; //ApexPages.currentPage().getParameters().get('completedtype');
        
        Map<Id, List<Task>> projTaskMap = new Map<Id, List<Task>>();
        List<SFDC_520_Quote__c> projList = new List<SFDC_520_Quote__c>();
        if(pCompletedType != null && pCompletedType != '') {
            projList = FOD_Helper.returnProjectTaskCompleted(pName, pCompletedType);
            projTaskMap = FOD_Helper.returnProjectTaskSecondary(pName, pCompletedType);
            
        }
        Map<Id, ProjectWrap> mapProjectDetail = new Map<Id, ProjectWrap>();
        
        for(SFDC_520_Quote__c proj : projList) {
            
            if(proj.Tasks != null && proj.Tasks.size() > 0) {
                ProjectWrap pWrap = new ProjectWrap();
                pWrap.intTskAge = 0;
                pWrap.trnTskAge = 0;
                pWrap.accId = proj.Account__c;
                mapProjectDetail.put(proj.id, pWrap);
                
                List<Task> taskList = new List<Task>();
                taskList.addAll(proj.Tasks);
                if(projTaskMap != null && projTaskMap.containsKey(proj.id)) {
                    taskList.addAll(projTaskMap.get(proj.id));
                }
                
                for(Task t : taskList) {
                    if(t.Subject.contains('Integration')) {
                        if(mapProjectDetail != null && mapProjectDetail.containsKey(t.WhatId)) {
                            pWrap = mapProjectDetail.get(t.WhatId);
                            pWrap.intTskAge = (t.Activity_Age__c == null) ? 0 : Integer.valueOf(t.Activity_Age__c);
                            pWrap.mttrStatus = pWrap.intTskAge + pWrap.trnTskAge;
                            
                        }
                    }
                    if(t.Subject.contains('Training 1')) {
                        if(mapProjectDetail != null && mapProjectDetail.containsKey(t.WhatId)) {
                            pWrap = mapProjectDetail.get(t.WhatId);
                            
                            pWrap.trnTskAge = (t.Activity_Age__c == null) ? 0 : Integer.valueOf(t.Activity_Age__c);
                            pWrap.mttrStatus = pWrap.intTskAge + pWrap.trnTskAge;
                        }
                    }
                }
            }
        }
        Integer lowerLimit = 0;
        Integer mediumLimit = 0;
        Integer upperLimit = 0;
        Set<Id> accIds = new Set<Id>();
        for(ProjectWrap pw : mapProjectDetail.values()) {
            accIds = new Set<Id>();
            if(pw.mttrStatus >= 0 && pw.mttrStatus <= 14) {
                lowerLimit++;
                if(mapMttrAccIds.containsKey('0-15')) {
                    accIds = mapMttrAccIds.get('0-15');
                }
                accIds.add(pw.accId);
                mapMttrAccIds.put('0-15', accIds);
            } else if(pw.mttrStatus >= 15 && pw.mttrStatus <= 20) {
                mediumLimit++;
                if(mapMttrAccIds.containsKey('16-20')) {
                    accIds = mapMttrAccIds.get('16-20');
                }
                accIds.add(pw.accId);
                mapMttrAccIds.put('16-20', accIds);
            } else if(pw.mttrStatus >= 21) {
                upperLimit++;
                if(mapMttrAccIds.containsKey('greater than 20')) {
                    accIds = mapMttrAccIds.get('greater than 20');
                }
                accIds.add(pw.accId);
                mapMttrAccIds.put('greater than 20', accIds);
            }
        }
        chStr = '';
        System.debug('mapMttrAccIds==' + mapMttrAccIds);
        chStr += '[\'0-15\',' + lowerLimit + '],';
        chStr += '[\'16-20\',' + mediumLimit + '],';
        chStr += '[\'greater than 20\',' + upperLimit + '],';
        if(chStr.length() > 1)
        chStr = chStr.substring(0, chStr.length() - 1);
        return chStr;
    }
    
    @RemoteAction
    public static String getChartData(String selVal, String selChart, String selDuration) {
        String cs = '';
        if(selChart == 'mttr')
            cs = doSearch(selDuration);
            
        if(selChart == 'acc')
            cs = accountData(selVal, selDuration);
        return cs;
    }
    
    public static String accountData(String selVal, String selDuration) {
        doSearch(selDuration);
        System.debug('selVal====' + selVal);
        Set<Id> accIds = new Set<Id>();
        accIds = mapMttrAccIds.get(selVal);
        String query = 'SELECT COUNT_DISTINCT(id) cnt, Dealer_Type__c rt FROM Account where id in :accIds Group by Account.Dealer_Type__c';
        AggregateResult[] groupedResults = Database.query(query);
        String chartString = '';
        for(AggregateResult agr : groupedResults) {
            String dlrType;
            if(agr.get('rt') == null) {
                dlrType = 'Other';
            } else {
                dlrType = String.valueOf(agr.get('rt'));
            }
            chartString += '[\'' + dlrType + '\',';
            chartString += Integer.valueOf(agr.get('cnt')) + '],';
            
        }  
        if(chartString != ''){
            chartString = chartString.substring(0, chartString.length() - 1);
        }  
        System.debug('accIds====' + accIds);
        return chartString;
    }
    
    public class ProjectWrap {
        public Integer mttrStatus {get; set;}
        public Integer intTskAge {get; set;}
        public Integer trnTskAge {get; set;}
        public String accId {get; set;}
        public projectWrap() {
            this.mttrStatus = mttrStatus;
            this.intTskAge = intTskAge;
            this.trnTskAge = trnTskAge;
            this.accId = accId;
            
        }
    }
}