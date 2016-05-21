public class FOD_CompletedProjectsCtrl {
    
    public Boolean showIntegration {get; set;}
    public Boolean showTraining {get; set;}
    public Boolean showSetup {get; set;}
    public Boolean showColorCode {get; set;}
    public Boolean isCompleted {get; set;}
    public List<ProjectWrap> projWrapList {get; set;}
    public String pageTitle {get; set;}
    
    public fod_completedProjectsCtrl() {
        pageTitle = '';
        projWrapList = new List<ProjectWrap>();
        String pName = ApexPages.currentPage().getParameters().get('pname');
        if(pName != null && pName != '') {
            renderColumns(pName);
            doSearch(pName);
        }
        SORT_Order = 'Asc';
    }
    
    public void renderColumns(String pName) {
        if(pName == 'Conquest') {
            showIntegration = true;
            showTraining = true;
            showSetup = true;
            showColorCode = true;
        }
        if(pName == 'Account Setup') {
            showIntegration = true;
            showTraining = true;
            showSetup = false;
            showColorCode = true;
        }
        if(pName == 'Module-Upsell') {
            showIntegration = false;
            showTraining = true;
            showSetup = false;
            showColorCode = false;
        }
        if(pName == 'Listings/Photos/Syndication-Upsell') {
            showIntegration = true;
            showTraining = false;
            showSetup = false;
            showColorCode = false;
        }
        if(pName == 'Window Stickers-Upsell') {
            showIntegration = true;
            showTraining = false;
            showSetup = false;
            showColorCode = false;
        }
        isCompleted = false;
    }
    
    public PageReference doSearch(String pName) {
        String pStatus = 'Completed';
        String pCompletedType = ApexPages.currentPage().getParameters().get('sd');
        String dealerType = ApexPages.currentPage().getParameters().get('sv');
        String mttrCond = ApexPages.currentPage().getParameters().get('sm');
        
        if(pCompletedType != null && pCompletedType != '')
            pageTitle += (pName == 'Account Setup' ? 'Provision' : pName) + ' - Completed - Detail';
        
        
        Map<Id, List<Task>> projTaskMap = new Map<Id, List<Task>>();
        List<SFDC_520_Quote__c> projList = new List<SFDC_520_Quote__c>();
        if(pCompletedType != null && pCompletedType != '') {
            projList = FOD_Helper.returnProjectTaskCompletedDT(pName, pCompletedType, dealerType);
            projTaskMap = FOD_Helper.returnProjectTaskSecondaryDT(pName, pCompletedType, dealerType);
            isCompleted = true;
        } else {
            projList = FOD_Helper.returnProjectTask(pName, '', pStatus);
        }
        
        Map<Id, ProjectWrap> mapProjectDetail = new Map<Id, ProjectWrap>();
        
        for(SFDC_520_Quote__c proj : projList) {
            
            if(proj.Tasks != null && proj.Tasks.size() > 0) {
                ProjectWrap pWrap = new ProjectWrap();
                pWrap.accName = proj.Account__r.Name;
                pWrap.projStage = proj.Approval_Stage__c;
                pWrap.stDate = proj.Start_Date__c;
                pWrap.intTskAge = 0;
                pWrap.trnTskAge = 0;
                pWrap.setTskAge = 0;
                pWrap.projId = proj.id;
                mapProjectDetail.put(proj.id, pWrap);
                
                List<Task> taskList = new List<Task>();
                taskList.addAll(proj.Tasks);
                if(projTaskMap != null && projTaskMap.containsKey(proj.id)) {
                    taskList.addAll(projTaskMap.get(proj.id));
                }
                
                for(Task t : taskList) {
                    pWrap.assignedTo = t.Owner.Name;
                    //pWrap.stDate = t.CreatedDate.month() + '/' + t.CreatedDate.day() + '/' + t.CreatedDate.year();
                    if(t.Subject.contains('Integration')) {
                        if(mapProjectDetail != null && mapProjectDetail.containsKey(t.WhatId)) {
                            pWrap.stDate = Date.valueOf(t.CreatedDate);
                            pWrap = mapProjectDetail.get(t.WhatId);
                            pWrap.intTskId = t.id;
                            pWrap.intTskStatus = t.Status;
                            pWrap.intTskAge = (t.Activity_Age__c == null) ? 0 : Integer.valueOf(t.Activity_Age__c);
                            pWrap.mttrStatus = pWrap.intTskAge + pWrap.trnTskAge + pWrap.setTskAge;
                            pWrap.mttrColor = ageColor(pName, 'MTTR', pWrap.mttrStatus);
                            pWrap.intAgeColor = ageColor(pName, 'Integration', pWrap.intTskAge);
                            mapProjectDetail.put(t.WhatId, pWrap);
                        }
                        if(t.Date_Time_Completed__c != null) {
                            pWrap.intCmplDate = t.Date_Time_Completed__c.date();
                        }
                    }
                    if(t.Subject.contains('Training 1')) {
                        if(mapProjectDetail != null && mapProjectDetail.containsKey(t.WhatId)) {
                            if(pName == 'Module-Upsell')
                                pWrap.stDate = Date.valueOf(t.CreatedDate);
                            pWrap = mapProjectDetail.get(t.WhatId);
                            pWrap.trnTskId = t.id;
                            pWrap.trnTskStatus = t.Status;
                            pWrap.trnTskAge = (t.Activity_Age__c == null) ? 0 : Integer.valueOf(t.Activity_Age__c);
                            pWrap.mttrStatus = pWrap.intTskAge + pWrap.trnTskAge + pWrap.setTskAge;
                            pWrap.mttrColor = ageColor(pName, 'MTTR', pWrap.mttrStatus);
                            pWrap.trnAgeColor = ageColor(pName, 'Training', pWrap.trnTskAge);
                            if(isCompleted && t.Date_Time_Completed__c != null) {
                                pWrap.cmplDate = t.Date_Time_Completed__c.date();
                            }
                            mapProjectDetail.put(t.WhatId, pWrap);
                        }
                    }
                    if(t.Subject.contains('Conquest Franchise Setup')) {
                        if(mapProjectDetail != null && mapProjectDetail.containsKey(t.WhatId)) {
                            pWrap = mapProjectDetail.get(t.WhatId);
                            pWrap.setTskId = t.id;
                            pWrap.setTskStatus = t.Status;
                            pWrap.setTskAge = (t.Activity_Age__c == null) ? 0 : Integer.valueOf(t.Activity_Age__c);
                            pWrap.mttrStatus = pWrap.intTskAge + pWrap.trnTskAge + pWrap.setTskAge;
                            pWrap.mttrColor = ageColor(pName, 'MTTR', pWrap.mttrStatus);
                            pWrap.setAgeColor = ageColor(pName, 'Setup', pWrap.setTskAge);
                            if(t.Date_Time_Completed__c != null) {
                                pWrap.setCmplDate = t.Date_Time_Completed__c.date();
                            }
                            mapProjectDetail.put(t.WhatId, pWrap);
                        }
                    }
                }
            }
        }
        //projWrapList = mapProjectDetail.values();
        Map<String, List<ProjectWrap>> mapMttrPwrap = new Map<String, List<ProjectWrap>>();
        
        List<ProjectWrap> pWrapList = new List<ProjectWrap>();
        for(ProjectWrap pw : mapProjectDetail.values()) {
            pWrapList = new List<ProjectWrap>();
            if(pName == 'Account Setup') {
                if(pw.mttrStatus >= 0 && pw.mttrStatus <= 14) {
                    if(mapMttrPwrap.containsKey('0-15')) {
                        pWrapList = mapMttrPwrap.get('0-15');
                    }
                    pWrapList.add(pw);
                    mapMttrPwrap.put('0-15', pWrapList);
                } else if(pw.mttrStatus >= 15 && pw.mttrStatus <= 20) {
                    if(mapMttrPwrap.containsKey('16-20')) {
                        pWrapList = mapMttrPwrap.get('16-20');
                    }
                    pWrapList.add(pw);
                    mapMttrPwrap.put('16-20', pWrapList);
                } else if(pw.mttrStatus >= 21) {
                    if(mapMttrPwrap.containsKey('greater than 20')) {
                        pWrapList = mapMttrPwrap.get('greater than 20');
                    }
                    pWrapList.add(pw);
                    mapMttrPwrap.put('greater than 20', pWrapList);
                }
            } else if(pName == 'Conquest') {
                if(pw.mttrStatus >= 0 && pw.mttrStatus <= 21) {
                    if(mapMttrPwrap.containsKey('0-21')) {
                        pWrapList = mapMttrPwrap.get('0-21');
                    }
                    pWrapList.add(pw);
                    mapMttrPwrap.put('0-21', pWrapList);
                } else if(pw.mttrStatus >= 22 && pw.mttrStatus <= 35) {
                    if(mapMttrPwrap.containsKey('22-35')) {
                        pWrapList = mapMttrPwrap.get('22-35');
                    }
                    pWrapList.add(pw);
                    mapMttrPwrap.put('22-35', pWrapList);
                } else if(pw.mttrStatus >= 36) {
                    if(mapMttrPwrap.containsKey('greater than 36')) {
                        pWrapList = mapMttrPwrap.get('greater than 36');
                    }
                    pWrapList.add(pw);
                    mapMttrPwrap.put('greater than 36', pWrapList);
                }
            }
        }
        if(mapMttrPwrap.containsKey(mttrCond))
            projWrapList = mapMttrPwrap.get(mttrCond);
        return null;
    }
    
    public String ageColor(String pName, String ageType, Integer ageValue) {
        Map<String, FODColorCode__c> colorCodeMap = FODColorCode__c.getAll();
        for(FODColorCode__c cc :colorCodeMap.values()) {
            if(cc.Type__c == ageType && cc.Project__c == pName) {
                if(ageValue >= cc.Start_Limit__c && (ageValue <= cc.End_Limit__c || cc.End_Limit__c == null)) {
                    return cc.Color_Code__c;
                }
            }
        }
        return '';
    }
    
    public PageReference backToDashboard() {
        return new Pagereference('/apex/FODashboard').setRedirect(true);
    }
    
    public PageReference sortByMttrSt() {
        SORT_BY = 'MttrStatus';
        sortList();
        return null;
    }
    
    public PageReference sortByAccountName() {
        SORT_BY = 'AccountName';
        sortList();
        return null;
    }
    
    public PageReference sortByProjStg() {
        SORT_BY = 'ProjStage';
        sortList();
        return null;
    }
    
    public PageReference sortByStartDate() {
        SORT_BY = 'StDate';
        sortList();
        return null;
    }
    
    public PageReference sortByIntStatus() {
        SORT_BY = 'IntTskStatus';
        sortList();
        return null;
    }
    
    public PageReference sortByIntAge() {
        SORT_BY = 'IntTskAge';
        sortList();
        return null;
    }
    
    public PageReference sortByTrnStatus() {
        SORT_BY = 'TrnTskStatus';
        sortList();
        return null;
    }
    
    public PageReference sortByTrnAge() {
        SORT_BY = 'TrnTskAge';
        sortList();
        return null;
    }
    
    public PageReference sortBySetStatus() {
        SORT_BY = 'SetTskStatus';
        sortList();
        return null;
    }
    
    public PageReference sortBySetAge() {
        SORT_BY = 'SetTskAge';
        sortList();
        return null;
    }
    
    public PageReference sortByAssigned() {
        SORT_BY = 'AssignedTo';
        sortList();
        return null;
    }
    
    public PageReference sortByCompletionDate() {
        SORT_BY = 'CmplDate';
        sortList();
        return null;
    }
    
    public PageReference sortByIntCompletionDate() {
        SORT_BY = 'IntCmplDate';
        sortList();
        return null;
    }
    
    public PageReference sortBySetCompletionDate() {
        SORT_BY = 'SetCmplDate';
        sortList();
        return null;
    }
    
    public PageReference sortList() {
        if(SORT_Order == 'Asc') {
            SORT_Order = 'Desc';
            projWrapList.sort();
            
        } else if(SORT_Order == 'Desc') {
            SORT_Order = 'Asc';
            reverse();
            
        }
        return null;
    }
    
    public PageReference reverse() {
        List<ProjectWrap> tmpList = new List<ProjectWrap>();
        Integer size = projWrapList.size();

        for (Integer i = 0; i < size; i++) {
            tmpList.add(projWrapList.remove(projWrapList.size() - 1));
        }

        projWrapList = tmpList;

        return null;
    }
    
    public static String SORT_BY;
    public String SORT_Order;
    public class ProjectWrap implements comparable {
        public Integer mttrStatus {get; set;}
        public String accName {get; set;}
        public String projStage {get; set;}
        public Date stDate {get; set;}
        public String intTskStatus {get; set;}
        public Integer intTskAge {get; set;}
        public String trnTskStatus {get; set;}
        public Integer trnTskAge {get; set;}
        public String setTskStatus {get; set;}
        public Integer setTskAge {get; set;}
        public String mttrColor {get; set;}
        public String intAgeColor {get; set;}
        public String trnAgeColor {get; set;}
        public String setAgeColor {get; set;}
        public String assignedTo {get; set;}
        public Id projId {get; set;}
        public Id intTskId {get; set;}
        public Id trnTskId {get; set;}
        public Id setTskId {get; set;}
        public Date cmplDate {get; set;}
        public Date intCmplDate {get; set;}
        public Date setCmplDate {get; set;}
        
        public Integer compareTo(Object obj){
            ProjectWrap pw = (ProjectWrap)(obj);
            if (SORT_BY == 'MttrStatus') {
                return sortByMttrStatus(pw);
            }
            if (SORT_BY == 'AccountName') {
                return sortByAccName(pw);
            }
            if (SORT_BY == 'ProjStage') {
                return sortByProjStage(pw);
            }
            if (SORT_BY == 'StDate') {
                return sortByStDate(pw);
            }
            if (SORT_BY == 'IntTskStatus') {
                return sortByIntTskStatus(pw);
            }
            if (SORT_BY == 'IntTskAge') {
                return sortByIntTskAge(pw);
            }
            if (SORT_BY == 'TrnTskStatus') {
                return sortByTrnTskStatus(pw);
            }
            if (SORT_BY == 'TrnTskAge') {
                return sortByTrnTskAge(pw);
            }
            if (SORT_BY == 'SetTskStatus') {
                return sortBySetTskStatus(pw);
            }
            if (SORT_BY == 'SetTskAge') {
                return sortBySetTskAge(pw);
            }
            if (SORT_BY == 'AssignedTo') {
                return sortByAssignedTo(pw);
            }
            if (SORT_BY == 'CmplDate') {
                return sortByCmplDate(pw);
            }
            if (SORT_BY == 'IntCmplDate') {
                return sortByCmplDate(pw);
            }
            if (SORT_BY == 'SetCmplDate') {
                return sortBySetCmplDate(pw);
            }
            return 0;
        }
        
        @TestVisible private Integer sortString(String currVal, String compareToVal) {
            if (currVal > compareToVal) {
                return 1;
            }
            if (currVal == compareToVal) {
                return 0;
            }
            return -1;
        }
        @TestVisible private Integer sortInteger(Integer currVal, Integer compareToVal) {
            if (currVal > compareToVal) {
                return 1;
            }
            if (currVal == compareToVal) {
                return 0;
            }
            return -1;
        }
        @TestVisible private Integer sortDate(Date currVal, Date compareToVal) {
            if(currVal != null && compareToVal != null) {
                if (currVal > compareToVal) {
                    return 1;
                }
                if (currVal == compareToVal) {
                    return 0;
                }
            }
            return -1;
        }
        
        private Integer sortByMttrStatus(ProjectWrap pw) {
            return sortInteger(this.mttrStatus, pw.mttrStatus);
        }
        private Integer sortByAccName(ProjectWrap pw) {
            return sortString(this.accName, pw.accName);
        }
        private Integer sortByProjStage(ProjectWrap pw) {
            return sortString(this.projStage, pw.projStage);
        }
        private Integer sortByStDate(ProjectWrap pw) {
            return sortDate(this.stDate, pw.stDate);
        }
        private Integer sortByIntTskStatus(ProjectWrap pw) {
            return sortString(this.intTskStatus, pw.intTskStatus);
        }
        private Integer sortByIntTskAge(ProjectWrap pw) {
            return sortInteger(this.intTskAge, pw.intTskAge);
        }
        private Integer sortByTrnTskStatus(ProjectWrap pw) {
            return sortString(this.trnTskStatus, pw.trnTskStatus);
        }
        private Integer sortByTrnTskAge(ProjectWrap pw) {
            return sortInteger(this.trnTskAge, pw.trnTskAge);
        }
        private Integer sortBySetTskStatus(ProjectWrap pw) {
            return sortString(this.setTskStatus, pw.setTskStatus);
        }
        private Integer sortBySetTskAge(ProjectWrap pw) {
            return sortInteger(this.setTskAge, pw.setTskAge);
        }
        private Integer sortByAssignedTo(ProjectWrap pw) {
            return sortString(this.assignedTo, pw.assignedTo);
        }
        private Integer sortByCmplDate(ProjectWrap pw) {
            return sortDate(this.cmplDate, pw.cmplDate);
        }
        private Integer sortByIntCmplDate(ProjectWrap pw) {
            return sortDate(this.intCmplDate, pw.intCmplDate);
        }
        private Integer sortBySetCmplDate(ProjectWrap pw) {
            return sortDate(this.setCmplDate, pw.setCmplDate);
        }
        
        public projectWrap() {
            this.mttrStatus = mttrStatus;
            this.accName = accName;
            this.projStage = projStage;
            this.stDate = stDate;
            this.intTskStatus = intTskStatus;
            this.intTskAge = intTskAge;
            this.trnTskStatus = trnTskStatus;
            this.trnTskAge = trnTskAge;
            this.mttrColor = mttrColor;
            this.intAgeColor = intAgeColor;
            this.trnAgeColor = trnAgeColor;
            this.setTskStatus = setTskStatus;
            this.setTskAge = setTskAge;
            this.setAgeColor = setAgeColor;
            this.assignedTo = assignedTo;
            this.projId = projId;
            this.intTskId = intTskId;
            this.trnTskId = trnTskId;
            this.setTskId = setTskId;
            this.cmplDate = cmplDate;
            this.intCmplDate = intCmplDate;
            this.setCmplDate = setCmplDate;
        }
    }
}