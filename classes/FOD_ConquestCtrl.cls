public class FOD_ConquestCtrl {
    
    public Integer activeIntConQCnt  {get;set;}
    public Integer activeSetConQCnt  {get;set;}
    public Integer activeTrnConQCnt  {get;set;}
    public Integer intDefConQCnt  {get;set;}
    public Integer setDefConQCnt  {get;set;}
    public Integer intDelConQCnt  {get;set;}
    public Integer setDelConQCnt  {get;set;}
    public Integer trnDefConQCnt  {get;set;}
    public Integer trnDelConQCnt  {get;set;}
    public Integer intEscConQCnt  {get;set;}
    public Integer setEscConQCnt  {get;set;}
    public Integer trnEscConQCnt  {get;set;}
    public Decimal budgetMTD {get;set;}
    public Decimal budgetQTD {get;set;}
    public Integer completedByMonthConQCnt  {get;set;}
    public Integer completedByYearConQCnt  {get;set;}
    public static String chStr {get; set;}
    static Map<String, Set<Id>> mapMttrAccIds = new Map<String, Set<Id>>();
    
    public fod_ConquestCtrl() {
        activeIntConQCnt = 0;
        activeSetConQCnt = 0;
        activeTrnConQCnt = 0;
        intDefConQCnt = 0;
        intDelConQCnt = 0;
        setDefConQCnt = 0;
        setDelConQCnt = 0;
        trnDefConQCnt = 0;
        trnDelConQCnt = 0;
        intEscConQCnt = 0;
        setEscConQCnt = 0;
        trnEscConQCnt = 0;
        completedByMonthConQCnt = 0;
        completedByYearConQCnt = 0;
        budgetMTD = 0;
        budgetQTD = 0;
        //queryProjects();
        queryProjectCount();
    }
    
    public void queryProjectCount() {
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        map_pStatusCount = FOD_Helper.projectCount('Conquest', 'Integration');
        
        if(map_pStatusCount.containsKey('Active'))                activeIntConQCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Back to Sales'))         intDelConqCnt = map_pStatusCount.get('Back to Sales');
        if(map_pStatusCount.containsKey('Deferred'))              intDefConqCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       intEscConqCnt = map_pStatusCount.get('Escalated to PM');
        
        map_pStatusCount = FOD_Helper.projectCount('Conquest', 'Setup Pricing');
        
        if(map_pStatusCount.containsKey('Active'))                activeSetConQCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Back to Sales'))         setDelConqCnt = map_pStatusCount.get('Back to Sales');
        if(map_pStatusCount.containsKey('Deferred'))              setDefConqCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       setEscConqCnt = map_pStatusCount.get('Escalated to PM');
        
        map_pStatusCount = FOD_Helper.projectCount('Conquest', 'Training 1');
        
        if(map_pStatusCount.containsKey('Active'))                activeTrnConQCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Back to Sales'))         trnDelConqCnt = map_pStatusCount.get('Back to Sales');
        if(map_pStatusCount.containsKey('Deferred'))              trnDefConqCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       trnEscConqCnt = map_pStatusCount.get('Escalated to PM');
    
        map_pStatusCount = FOD_Helper.projectCountForCompleted('Conquest');
        if(map_pStatusCount.containsKey('Month'))                 completedByMonthConQCnt = map_pStatusCount.get('Month');
        if(map_pStatusCount.containsKey('Year'))                  completedByYearConQCnt = map_pStatusCount.get('Year');
    
        
        List<FO_Project_Budget__c> budgetList = [select Conquest_Budget__c, Budget_Date__c from FO_Project_Budget__c 
                    where Budget_Date__c = THIS_QUARTER];
        Integer thisMonth = System.today().month();
        for(FO_Project_Budget__c bgt : budgetList) {
            if(bgt.Conquest_Budget__c != null) {
                Decimal budgetAmt = bgt.Conquest_Budget__c;
                if(bgt.Budget_Date__c.month() == thisMonth)
                    budgetMTD = budgetAmt.setScale(0);
                budgetQTD += budgetAmt.setScale(0);
            }
        }
    }
    
    
    public static String doSearch(String selDuration) {
        String pName = 'Conquest';
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
                pWrap.setTskAge = 0;
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
                            pWrap.mttrStatus = pWrap.intTskAge + pWrap.trnTskAge + pWrap.setTskAge;
                            
                        }
                    }
                    if(t.Subject.contains('Training 1')) {
                        if(mapProjectDetail != null && mapProjectDetail.containsKey(t.WhatId)) {
                            pWrap = mapProjectDetail.get(t.WhatId);
                            
                            pWrap.trnTskAge = (t.Activity_Age__c == null) ? 0 : Integer.valueOf(t.Activity_Age__c);
                            pWrap.mttrStatus = pWrap.intTskAge + pWrap.trnTskAge + pWrap.setTskAge;
                        }
                    }
                    if(t.Subject.contains('Conquest Franchise Setup')) {
                        if(mapProjectDetail != null && mapProjectDetail.containsKey(t.WhatId)) {
                            pWrap = mapProjectDetail.get(t.WhatId);
                            
                            pWrap.setTskAge = (t.Activity_Age__c == null) ? 0 : Integer.valueOf(t.Activity_Age__c);
                            pWrap.mttrStatus = pWrap.intTskAge + pWrap.trnTskAge + pWrap.setTskAge;
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
            if(pw.mttrStatus >= 0 && pw.mttrStatus <= 21) {
                lowerLimit++;
                if(mapMttrAccIds.containsKey('0-21')) {
                    accIds = mapMttrAccIds.get('0-21');
                }
                accIds.add(pw.accId);
                mapMttrAccIds.put('0-21', accIds);
            } else if(pw.mttrStatus >= 22 && pw.mttrStatus <= 35) {
                mediumLimit++;
                if(mapMttrAccIds.containsKey('22-35')) {
                    accIds = mapMttrAccIds.get('22-35');
                }
                accIds.add(pw.accId);
                mapMttrAccIds.put('22-35', accIds);
            } else if(pw.mttrStatus >= 36) {
                upperLimit++;
                if(mapMttrAccIds.containsKey('greater than 36')) {
                    accIds = mapMttrAccIds.get('greater than 36');
                }
                accIds.add(pw.accId);
                mapMttrAccIds.put('greater than 36', accIds);
            }
        }
        chStr = '';
        System.debug('mapMttrAccIds==' + mapMttrAccIds);
        chStr += '[\'0-21\',' + lowerLimit + '],';
        chStr += '[\'22-35\',' + mediumLimit + '],';
        chStr += '[\'greater than 36\',' + upperLimit + '],';
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
        public Integer setTskAge {get; set;}
        public String accId {get; set;}
        public projectWrap() {
            this.mttrStatus = mttrStatus;
            this.intTskAge = intTskAge;
            this.trnTskAge = trnTskAge;
            this.setTskAge = setTskAge;
            this.accId = accId;
            
        }
    }
}