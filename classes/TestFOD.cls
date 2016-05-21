@isTest
public class TestFOD {
    
    static testmethod void testSalesPipelineCtrl() {
        Test.startTest();
        Account acc = new Account(Name = 'Account Setup', Dealer_Type__c = 'Independent');
        insert acc;
        Opportunity opp = new Opportunity(Name = 'Account Setup', CloseDate = System.today().addMonths(1), StageName = 'Prospecting', AccountId = acc.id);
        insert opp;
        opp.CloseDate = System.today();
        update opp;
        System.debug('opp==' + [select Name from Opportunity where id = :opp.id].Name);
        Account acc1 = new Account(Name = 'Conquest', Dealer_Type__c = 'Independent');
        insert acc1;
        Opportunity opp1 = new Opportunity(Name = 'Conquest', CloseDate = System.today().addMonths(1), StageName = 'Prospecting', AccountId = acc1.id);
        insert opp1;
        opp1.CloseDate = System.today();
        update opp1;
        System.debug('opp1==' + [select Name from Opportunity where id = :opp1.id].Name);
        FOD_SalesPipelineCtrl ctrl = new FOD_SalesPipelineCtrl();
        FOD_SalesPipelineCtrl.getChartInput('Conquest:Open', 'project', 'Next Month');
        FOD_SalesPipelineCtrl.getChartInput('Conquest:Open', 'acc', 'This Month');
        FOD_SalesPipelineCtrl.getChartInput('Provision:Open', 'project', 'Next Month');
        FOD_SalesPipelineCtrl.getChartInput('Provision:Open', 'acc', 'This Month');
        
        ApexPages.currentPage().getParameters().put('sp', 'Provision:Open');
        FOD_AccountListCtrl ctrl2 = new FOD_AccountListCtrl();
        ctrl2.backToDashboard();
        Test.stopTest();
        
    }
    
    static testmethod void testProvisionCtrl() {
        Test.startTest();
        customSettingData();
        SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Account Setup 1', Approval_Stage__c = 'Integration');
        insert proj;
        proj.Name = 'Account Setup 1';
        update proj;
        List<Task> tskList = new List<Task>();
        Task tsk1 = new Task(Subject = 'Integration A', Status = 'Not Started', WhatId = proj.id);
        tskList.add(tsk1);
        Task tsk2 = new Task(Subject = 'Training 1', Status = 'Not Started', WhatId = proj.id);
        tskList.add(tsk2);
        Task tsk3 = new Task(Subject = 'Integration A', Status = 'Back to Sales', WhatId = proj.id);
        tskList.add(tsk3);
        Task tsk4 = new Task(Subject = 'Training 1', Status = 'Back to Sales', WhatId = proj.id);
        tskList.add(tsk4);
        Task tsk5 = new Task(Subject = 'Integration A', Status = 'Deferred', WhatId = proj.id);
        tskList.add(tsk5);
        Task tsk6 = new Task(Subject = 'Training 1', Status = 'Deferred', WhatId = proj.id);
        tskList.add(tsk6);
        Task tsk7 = new Task(Subject = 'Integration A', Status = 'Escalated', WhatId = proj.id);
        tskList.add(tsk7);
        Task tsk8 = new Task(Subject = 'Training 1', Status = 'Escalated', WhatId = proj.id);
        tskList.add(tsk8);
        Task tsk9 = new Task(Subject = 'Training 1', Status = 'Completed', WhatId = proj.id);
        tskList.add(tsk9);
        insert tskList;
        FOD_ProvisionCtrl ctrl = new FOD_ProvisionCtrl();
        FOD_ProvisionCtrl.getChartData('0-15', 'acc', 'month');
        
        ApexPages.currentPage().getParameters().put('pname', 'Account Setup');
        ApexPages.currentPage().getParameters().put('stage', 'Integration');
        ApexPages.currentPage().getParameters().put('onholdtype', 'Active');
        FOD_ProjectListCtrl ctrl2 = new FOD_ProjectListCtrl();
        
        ApexPages.currentPage().getParameters().put('completedtype', 'month');
        ctrl2 = new FOD_ProjectListCtrl();
        Test.stopTest();
    }
    
    static testmethod void testConquestCtrl() {
        Test.startTest();
        customSettingData();
        SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Conquest 1', Approval_Stage__c = 'Integration');
        insert proj;
        proj.Name = 'Conquest 1';
        update proj;
        List<Task> tskList = new List<Task>();
        Task tsk1 = new Task(Subject = 'Integration C', Status = 'Not Started', WhatId = proj.id);
        tskList.add(tsk1);
        Task tsk2 = new Task(Subject = 'Training 1', Status = 'Not Started', WhatId = proj.id);
        tskList.add(tsk2);
        Task tsk3 = new Task(Subject = 'Integration C', Status = 'Back to Sales', WhatId = proj.id);
        tskList.add(tsk3);
        Task tsk4 = new Task(Subject = 'Training 1', Status = 'Back to Sales', WhatId = proj.id);
        tskList.add(tsk4);
        Task tsk5 = new Task(Subject = 'Integration C', Status = 'Deferred', WhatId = proj.id);
        tskList.add(tsk5);
        Task tsk6 = new Task(Subject = 'Training 1', Status = 'Deferred', WhatId = proj.id);
        tskList.add(tsk6);
        Task tsk7 = new Task(Subject = 'Integration C', Status = 'Escalated', WhatId = proj.id);
        tskList.add(tsk7);
        Task tsk8 = new Task(Subject = 'Training 1', Status = 'Escalated', WhatId = proj.id);
        tskList.add(tsk8);
        Task tsk9 = new Task(Subject = 'Training 1', Status = 'Completed', WhatId = proj.id);
        tskList.add(tsk9);
        Task tsk10 = new Task(Subject = 'Setup', Status = 'Not Started', WhatId = proj.id);
        tskList.add(tsk10);
        Task tsk11 = new Task(Subject = 'Setup', Status = 'Back to Sales', WhatId = proj.id);
        tskList.add(tsk11);
        Task tsk12 = new Task(Subject = 'Setup', Status = 'Deferred', WhatId = proj.id);
        tskList.add(tsk12);
        Task tsk13 = new Task(Subject = 'Setup', Status = 'Escalated', WhatId = proj.id);
        tskList.add(tsk13);
        insert tskList;
        FOD_ConquestCtrl ctrl = new FOD_ConquestCtrl();
        FOD_ConquestCtrl.getChartData('0-21', 'acc', 'month');
        ApexPages.currentPage().getParameters().put('pname', 'Conquest');
        ApexPages.currentPage().getParameters().put('stage', 'Integration');
        ApexPages.currentPage().getParameters().put('onholdtype', 'Active');
        FOD_ProjectListCtrl ctrl2 = new FOD_ProjectListCtrl();
        ctrl2.sortByMttrSt();
        ctrl2.sortByAccountName();
        ctrl2.sortByProjStg();
        ctrl2.sortByStartDate();
        ctrl2.sortByIntStatus();
        ctrl2.sortByIntAge();
        ctrl2.sortByTrnStatus();
        ctrl2.sortByTrnAge();
        ctrl2.sortBySetStatus();
        ctrl2.sortBySetAge();
        ctrl2.sortByAssigned();
        ctrl2.sortByCompletionDate();
        ctrl2.sortByIntCompletionDate();
        ctrl2.sortBySetCompletionDate();
        ctrl2.reverse();
        ctrl2.backToDashboard();
        
        FOD_ProjectListCtrl.ProjectWrap pw = new FOD_ProjectListCtrl.ProjectWrap();
        pw.compareTo(ctrl2.projWrapList[0]);
        pw.sortString('Test', 'Testing');
        pw.sortInteger(10, 20);
        Test.stopTest();
    }
    
    static testmethod void testUpsellCtrl() {
        Test.startTest();
        customSettingData();
        SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Module-Upsell 1', Approval_Stage__c = 'Integration');
        insert proj;
        proj.Name = 'Module-Upsell 1';
        update proj;
        List<Task> tskList = new List<Task>();
        Task tsk1 = new Task(Subject = 'Training 1', Status = 'Not Started', WhatId = proj.id);
        tskList.add(tsk1);
        Task tsk2 = new Task(Subject = 'Training 1', Status = 'Back to Sales', WhatId = proj.id);
        tskList.add(tsk2);
        Task tsk3 = new Task(Subject = 'Training 1', Status = 'Deferred', WhatId = proj.id);
        tskList.add(tsk3);
        Task tsk4 = new Task(Subject = 'Training 1', Status = 'Escalated', WhatId = proj.id);
        tskList.add(tsk4);
        Task tsk5 = new Task(Subject = 'Training 1', Status = 'Completed', WhatId = proj.id);
        tskList.add(tsk5);
        insert tskList;
        FOD_UpsellCtrl ctrl = new FOD_UpsellCtrl();
        ctrl.queryUpsellProjects();
        
        ApexPages.currentPage().getParameters().put('pname', 'Module-Upsell');
        ApexPages.currentPage().getParameters().put('stage', 'Training 1');
        ApexPages.currentPage().getParameters().put('onholdtype', 'Active');
        FOD_ProjectListCtrl ctrl2 = new FOD_ProjectListCtrl();
        Test.stopTest();
    }
    
    static testmethod void testListingCtrl() {
        Test.startTest();
        customSettingData();
        SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Listings/Photos/Syndication-Upsell 1', Approval_Stage__c = 'Integration');
        insert proj;
        proj.Name = 'Listings/Photos/Syndication-Upsell 1';
        update proj;
        List<Task> tskList = new List<Task>();
        Task tsk1 = new Task(Subject = 'Integration L', Status = 'Not Started', WhatId = proj.id);
        tskList.add(tsk1);
        Task tsk2 = new Task(Subject = 'Integration L', Status = 'Back to Sales', WhatId = proj.id);
        tskList.add(tsk2);
        Task tsk3 = new Task(Subject = 'Integration L', Status = 'Deferred', WhatId = proj.id);
        tskList.add(tsk3);
        Task tsk4 = new Task(Subject = 'Integration L', Status = 'Escalated', WhatId = proj.id);
        tskList.add(tsk4);
        Task tsk5 = new Task(Subject = 'Integration L', Status = 'Completed', WhatId = proj.id);
        tskList.add(tsk5);
        insert tskList;
        FOD_UpsellCtrl ctrl = new FOD_UpsellCtrl();
        ctrl.queryListingProjects();
        
        ApexPages.currentPage().getParameters().put('pname', 'Listings/Photos/Syndication-Upsell');
        ApexPages.currentPage().getParameters().put('stage', 'Integration');
        ApexPages.currentPage().getParameters().put('onholdtype', 'Active');
        FOD_ProjectListCtrl ctrl2 = new FOD_ProjectListCtrl();
        Test.stopTest();
    }
    
    static testmethod void testWindowCtrl() {
        Test.startTest();
        customSettingData();
        SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Window Stickers-Upsell 1', Approval_Stage__c = 'Integration');
        insert proj;
        proj.Name = 'Window Stickers-Upsell 1';
        update proj;
        List<Task> tskList = new List<Task>();
        Task tsk1 = new Task(Subject = 'Integration W', Status = 'Not Started', WhatId = proj.id);
        tskList.add(tsk1);
        Task tsk2 = new Task(Subject = 'Integration W', Status = 'Back to Sales', WhatId = proj.id);
        tskList.add(tsk2);
        Task tsk3 = new Task(Subject = 'Integration W', Status = 'Deferred', WhatId = proj.id);
        tskList.add(tsk3);
        Task tsk4 = new Task(Subject = 'Integration W', Status = 'Escalated', WhatId = proj.id);
        tskList.add(tsk4);
        Task tsk5 = new Task(Subject = 'Integration W', Status = 'Completed', WhatId = proj.id);
        tskList.add(tsk5);
        insert tskList;
        FOD_UpsellCtrl ctrl = new FOD_UpsellCtrl();
        ctrl.queryListingProjects();
        
        ApexPages.currentPage().getParameters().put('pname', 'Window Stickers-Upsell');
        ApexPages.currentPage().getParameters().put('stage', 'Integration');
        ApexPages.currentPage().getParameters().put('onholdtype', 'Active');
        FOD_ProjectListCtrl ctrl2 = new FOD_ProjectListCtrl();
        Test.stopTest();
    }
    
    static testmethod void testNewUserCtrl() {
        Test.startTest();
        customSettingData();
        SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Window Stickers-Upsell 1', Approval_Stage__c = 'Integration');
        insert proj;
        proj.Name = 'Window Stickers-Upsell 1';
        update proj;
        List<Task> tskList = new List<Task>();
        Task tsk1 = new Task(Subject = 'New User Session', Status = 'Not Started', WhatId = proj.id, ActivityDate = System.today());
        tskList.add(tsk1);
        Task tsk2 = new Task(Subject = 'New User Session', Status = 'Back to Sales', WhatId = proj.id, ActivityDate = System.today());
        tskList.add(tsk2);
        Task tsk3 = new Task(Subject = 'New User Session', Status = 'Deferred', WhatId = proj.id, ActivityDate = System.today());
        tskList.add(tsk3);
        Task tsk4 = new Task(Subject = 'New User Session', Status = 'Escalated', WhatId = proj.id, ActivityDate = System.today());
        tskList.add(tsk4);
        Task tsk5 = new Task(Subject = 'New User Session', Status = 'Completed', WhatId = proj.id, ActivityDate = System.today());
        tskList.add(tsk5);
        insert tskList;
        FOD_UpsellCtrl ctrl = new FOD_UpsellCtrl();
        ctrl.queryNewUserProjects();
        ctrl.back();
        
        ApexPages.currentPage().getParameters().put('status', 'Deferred');
        FOD_TaskListCtrl ctrl2 = new FOD_TaskListCtrl();
        ApexPages.currentPage().getParameters().put('status', 'Completed');
        ctrl2 = new FOD_TaskListCtrl();
        ctrl2.sortByAccName();
        ctrl2.sortBySubject();
        ctrl2.sortByActDate();
        ctrl2.sortByAssigned();
        ctrl2.sortByStatus();
        ctrl2.reverse();
        
        FOD_TaskListCtrl.TaskWrap pw = new FOD_TaskListCtrl.TaskWrap();
        pw.compareTo(ctrl2.taskList[0]);
        pw.sortString('Test', 'Testing');
        pw.sortDate(System.today(), System.today());
        Test.stopTest();
    }
    
    static testmethod void testCompletedProjCtrl() {
        Test.startTest();
            customSettingData();
            ApexPages.currentPage().getParameters().put('pname', 'Window Stickers-Upsell');
            FOD_CompletedProjectsCtrl ctrl = new FOD_CompletedProjectsCtrl();
            
            
            ApexPages.currentPage().getParameters().put('pname', 'Module-Upsell');
            ctrl = new FOD_CompletedProjectsCtrl();
            
            
            Account acc = new Account(Name = 'Test');
            insert acc;
            SFDC_520_Quote__c proj = new SFDC_520_Quote__c(Name = 'Conquest 1', Approval_Stage__c = 'Integration', Account__c = acc.id);
            insert proj;
            proj.Name = 'Conquest 1';
            update proj;
            List<Task> tskList = new List<Task>();
            Task tsk1 = new Task(Subject = 'Training 1', Status = 'Completed', WhatId = proj.id, Date_Time_Completed__c = System.today());
            tskList.add(tsk1);
            Task tsk2 = new Task(Subject = 'Integration L', Status = 'Completed', WhatId = proj.id, Date_Time_Completed__c = System.today());
            tskList.add(tsk2);
            Task tsk3 = new Task(Subject = 'Conquest Franchise Setup', Status = 'Completed', WhatId = proj.id, Date_Time_Completed__c = System.today());
            tskList.add(tsk3);
            insert tskList;
            
            ApexPages.currentPage().getParameters().put('pname', 'Account Setup');
            ApexPages.currentPage().getParameters().put('sd', 'month');
            ApexPages.currentPage().getParameters().put('sv', 'Other');
            ApexPages.currentPage().getParameters().put('sm', '0-15');
            ctrl = new FOD_CompletedProjectsCtrl();
            ctrl.doSearch('Account Setup');
            ApexPages.currentPage().getParameters().put('pname', 'Conquest');
            ApexPages.currentPage().getParameters().put('sd', 'month');
            ApexPages.currentPage().getParameters().put('sv', 'Other');
            ApexPages.currentPage().getParameters().put('sm', '0-21');
            ctrl = new FOD_CompletedProjectsCtrl();
            
            
            ctrl.sortByMttrSt();
            ctrl.sortByAccountName();
            ctrl.sortByProjStg();
            ctrl.sortByStartDate();
            ctrl.sortByIntStatus();
            ctrl.sortByIntAge();
            ctrl.sortByTrnStatus();
            ctrl.sortByTrnAge();
            ctrl.sortBySetStatus();
            ctrl.sortBySetAge();
            ctrl.sortByAssigned();
            ctrl.sortByCompletionDate();
            ctrl.sortByIntCompletionDate();
            ctrl.sortBySetCompletionDate();
            ctrl.reverse();
            ctrl.backToDashboard();
            
            FOD_CompletedProjectsCtrl.ProjectWrap pw = new FOD_CompletedProjectsCtrl.ProjectWrap();
            pw.compareTo(ctrl.projWrapList[0]);
            pw.sortString('Test', 'Testing');
            pw.sortInteger(10, 20);
            
            proj.Name = 'Listings/Photos/Syndication-Upsell';
            update proj;
            ApexPages.currentPage().getParameters().put('pname', 'Listings/Photos/Syndication-Upsell');
            ctrl = new FOD_CompletedProjectsCtrl();
            
        Test.stopTest();
    }
    
    public static void customSettingData() {
        List<DashboardTaskStatus__c> dbList = new List<DashboardTaskStatus__c>();
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision1', Project__c = 'Account Setup', Stage__c = 'Integration', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'Integration A', Secondary_Subject__c = 'Training 1'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision2', Project__c = 'Account Setup', Stage__c = 'Integration', Project_Status__c = 'Back to Sales', Task_Status__c = 'Back to Sales', Primary_Subject__c = 'Integration A', Secondary_Subject__c = 'Training 1'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision3', Project__c = 'Account Setup', Stage__c = 'Integration', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'Integration A', Secondary_Subject__c = 'Training 1'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision4', Project__c = 'Account Setup', Stage__c = 'Integration', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'Integration A', Secondary_Subject__c = 'Training 1'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision5', Project__c = 'Account Setup', Stage__c = 'Training 1', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration A'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision6', Project__c = 'Account Setup', Stage__c = 'Training 1', Project_Status__c = 'Back to Sales', Task_Status__c = 'Back to Sales', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration A'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision7', Project__c = 'Account Setup', Stage__c = 'Training 1', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration A'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision8', Project__c = 'Account Setup', Stage__c = 'Training 1', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration A'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Provision9', Project__c = 'Account Setup', Stage__c = '', Project_Status__c = 'Completed', Task_Status__c = 'Completed', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration A'));
        
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest1', Project__c = 'Conquest', Stage__c = 'Integration', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'Integration C', Secondary_Subject__c = 'Training 1, Setup'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest2', Project__c = 'Conquest', Stage__c = 'Integration', Project_Status__c = 'Back to Sales', Task_Status__c = 'Back to Sales', Primary_Subject__c = 'Integration C', Secondary_Subject__c = 'Training 1, Setup'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest3', Project__c = 'Conquest', Stage__c = 'Integration', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'Integration C', Secondary_Subject__c = 'Training 1, Setup'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest4', Project__c = 'Conquest', Stage__c = 'Integration', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'Integration C', Secondary_Subject__c = 'Training 1, Setup'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest5', Project__c = 'Conquest', Stage__c = 'Training 1', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration C, Setup'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest6', Project__c = 'Conquest', Stage__c = 'Training 1', Project_Status__c = 'Back to Sales', Task_Status__c = 'Back to Sales', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration C, Setup'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest7', Project__c = 'Conquest', Stage__c = 'Training 1', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration C, Setup'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest8', Project__c = 'Conquest', Stage__c = 'Training 1', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration C, Setup'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest9', Project__c = 'Conquest', Stage__c = 'Setup Pricing', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'Setup', Secondary_Subject__c = 'Integration C, Training 1'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest10', Project__c = 'Conquest', Stage__c = 'Setup Pricing', Project_Status__c = 'Back to Sales', Task_Status__c = 'Back to Sales', Primary_Subject__c = 'Setup', Secondary_Subject__c = 'Integration C, Training 1'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest11', Project__c = 'Conquest', Stage__c = 'Setup Pricing', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'Setup', Secondary_Subject__c = 'Integration C, Training 1'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest12', Project__c = 'Conquest', Stage__c = 'Setup Pricing', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'Setup', Secondary_Subject__c = 'Integration C, Training 1'));
        dbList.add(new DashboardTaskStatus__c(Name = 'Conquest13', Project__c = 'Conquest', Stage__c = '', Project_Status__c = 'Completed', Task_Status__c = 'Completed', Primary_Subject__c = 'Training 1', Secondary_Subject__c = 'Integration C, Setup'));
        
        dbList.add(new DashboardTaskStatus__c(Name = 'Module-Upsell1', Project__c = 'Module-Upsell', Stage__c = 'Training 1', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'Training 1', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Module-Upsell2', Project__c = 'Module-Upsell', Stage__c = 'Training 1', Project_Status__c = 'Back to Sales', Task_Status__c = 'Back to Sales', Primary_Subject__c = 'Training 1', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Module-Upsell3', Project__c = 'Module-Upsell', Stage__c = 'Training 1', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'Training 1', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Module-Upsell4', Project__c = 'Module-Upsell', Stage__c = 'Training 1', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'Training 1', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Module-Upsell5', Project__c = 'Module-Upsell', Stage__c = '', Project_Status__c = 'Completed', Task_Status__c = 'Completed', Primary_Subject__c = 'Training 1', Secondary_Subject__c = ''));
        
        dbList.add(new DashboardTaskStatus__c(Name = 'Listings/Photos/Syndication-Upsell1', Project__c = 'Listings/Photos/Syndication-Upsell', Stage__c = 'Integration', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'Integration L', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Listings/Photos/Syndication-Upsell2', Project__c = 'Listings/Photos/Syndication-Upsell', Stage__c = 'Integration', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'Integration L', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Listings/Photos/Syndication-Upsell3', Project__c = 'Listings/Photos/Syndication-Upsell', Stage__c = 'Integration', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'Integration L', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Listings/Photos/Syndication-Upsell4', Project__c = 'Listings/Photos/Syndication-Upsell', Stage__c = '', Project_Status__c = 'Completed', Task_Status__c = 'Completed', Primary_Subject__c = 'Integration L'));
        
        dbList.add(new DashboardTaskStatus__c(Name = 'Window Stickers-Upsell1', Project__c = 'Window Stickers-Upsell', Stage__c = 'Integration', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'Integration W', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Window Stickers-Upsell2', Project__c = 'Window Stickers-Upsell', Stage__c = 'Integration', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'Integration W', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Window Stickers-Upsell3', Project__c = 'Window Stickers-Upsell', Stage__c = 'Integration', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'Integration W', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'Window Stickers-Upsell4', Project__c = 'Window Stickers-Upsell', Stage__c = '', Project_Status__c = 'Completed', Task_Status__c = 'Completed', Primary_Subject__c = 'Integration W', Secondary_Subject__c = ''));
        
        dbList.add(new DashboardTaskStatus__c(Name = 'New User1', Project__c = 'New User', Stage__c = '', Project_Status__c = 'Active', Task_Status__c = 'Not Started', Primary_Subject__c = 'New User Session', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'New User2', Project__c = 'New User', Stage__c = '', Project_Status__c = 'Deferred', Task_Status__c = 'Deferred', Primary_Subject__c = 'New User Session', Secondary_Subject__c = ''));
        dbList.add(new DashboardTaskStatus__c(Name = 'New User3', Project__c = 'New User', Stage__c = '', Project_Status__c = 'Escalated', Task_Status__c = 'Escalated', Primary_Subject__c = 'New User Session', Secondary_Subject__c = ''));
        
        insert dbList;
    }
}