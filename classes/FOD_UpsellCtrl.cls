public class FOD_UpsellCtrl {
    
    public Integer activeUpslCnt  {get;set;}
    public Integer upslDefCnt  {get;set;}
    public Integer upslDelCnt  {get;set;}
    public Integer upslEscCnt  {get;set;}
    public Integer completedByMonthUpslCnt  {get;set;}
    public Integer completedByYearUpslCnt  {get;set;}
    
    public Integer activeListingCnt  {get;set;}
    public Integer listingDefCnt  {get;set;}
    public Integer listingEscCnt  {get;set;}
    public Integer completedByMonthListingCnt  {get;set;}
    public Integer completedByYearListingCnt  {get;set;}
    
    public Integer activeWinCnt  {get;set;}
    public Integer winDefCnt  {get;set;}
    public Integer winEscCnt  {get;set;}
    public Integer completedByMonthWinCnt  {get;set;}
    public Integer completedByYearWinCnt  {get;set;}
    
    public Integer activeNewUsrCnt  {get;set;}
    public Integer newUsrDefCnt  {get;set;}
    public Integer newUsrEscCnt  {get;set;}
    public Integer completedByMonthNewUsrCnt  {get;set;}
    public Integer completedByYearNewUsrCnt  {get;set;}
    
    public Boolean showFirstScreen {get; set;}
    public Boolean showUpsells {get; set;}
    public Boolean showListings {get; set;}
    public Boolean showNewUserSession {get; set;}
    public Boolean showStockWave {get; set;}
    
    public Integer activeIntSWCnt  {get;set;}
    public Integer activeTrnSWCnt  {get;set;}
    public Integer intDefSWCnt  {get;set;}
    public Integer intDelSWCnt  {get;set;}
    public Integer trnDefSWCnt  {get;set;}
    public Integer trnDelSWCnt  {get;set;}
    public Integer trnEscSWCnt  {get;set;}
    public Integer completedByMonthSWCnt  {get;set;}
    public Integer completedByYearSWCnt  {get;set;}
    public Decimal budgetMTDSW {get;set;}
    public Decimal budgetQTDSW {get;set;}
    
    public fod_UpsellCtrl() {
        activeUpslCnt = 0;
        upslDefCnt = 0;
        upslDelCnt = 0;
        upslEscCnt = 0;
        completedByMonthUpslCnt = 0;
        completedByYearUpslCnt = 0;
        
        activeListingCnt = 0;
        listingEscCnt = 0;
        completedByMonthListingCnt = 0;
        completedByYearListingCnt = 0;
        
        activeWinCnt = 0;
        winEscCnt = 0;
        completedByMonthWinCnt = 0;
        completedByYearWinCnt = 0;
        
        activeNewUsrCnt = 0;
        newUsrDefCnt = 0;
        newUsrEscCnt = 0;
        
        activeIntSWCnt = 0;
        activeTrnSWCnt = 0;
        intDefSWCnt = 0;
        intDelSWCnt = 0;
        trnDefSWCnt = 0;
        trnDelSWCnt = 0;
        trnEscSWCnt = 0;
        completedByMonthSWCnt = 0;
        completedByYearSWCnt = 0;
        budgetMTDSW = 0;
        budgetQTDSW = 0;
        
        showFirstScreen = true;
        showListings = false;
        showUpsells = false;
        showNewUserSession = false;
        showStockWave = false;
    }
    
    public void back() {
        showFirstScreen = true;
        showListings = false;
        showUpsells = false;
        showNewUserSession = false;
        showStockWave = false;
    }
    
    public void queryUpsellProjects() {
        showFirstScreen = false;
        showUpsells = true;
        
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        map_pStatusCount = FOD_Helper.projectCount('Module-Upsell', 'Training 1');
        
        if(map_pStatusCount.containsKey('Active'))                activeUpslCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Back to Sales'))         upslDelCnt = map_pStatusCount.get('Back to Sales');
        if(map_pStatusCount.containsKey('Deferred'))              upslDefCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       upslEscCnt = map_pStatusCount.get('Escalated to PM');
        
        
        map_pStatusCount = FOD_Helper.projectCountForCompleted('Module-Upsell');
        if(map_pStatusCount.containsKey('Month'))                 completedByMonthUpslCnt = map_pStatusCount.get('Month');
        if(map_pStatusCount.containsKey('Year'))                  completedByYearUpslCnt = map_pStatusCount.get('Year');
    }
    
    public void queryListingProjects() {
        showFirstScreen = false;
        showListings = true;
        
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        map_pStatusCount = FOD_Helper.projectCount('Listings/Photos/Syndication-Upsell', 'Integration');
        
        if(map_pStatusCount.containsKey('Active'))                activeListingCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Deferred'))              listingDefCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       listingEscCnt = map_pStatusCount.get('Escalated to PM');
        
        map_pStatusCount = FOD_Helper.projectCountForCompleted('Listings/Photos/Syndication-Upsell');
        if(map_pStatusCount.containsKey('Month'))                 completedByMonthListingCnt = map_pStatusCount.get('Month');
        if(map_pStatusCount.containsKey('Year'))                  completedByYearListingCnt = map_pStatusCount.get('Year');
        
        map_pStatusCount = FOD_Helper.projectCount('Window Stickers-Upsell', 'Integration');
        
        if(map_pStatusCount.containsKey('Active'))                activeWinCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Deferred'))              winDefCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       winEscCnt = map_pStatusCount.get('Escalated to PM');
        
        map_pStatusCount = FOD_Helper.projectCountForCompleted('Window Stickers-Upsell');
        if(map_pStatusCount.containsKey('Month'))                 completedByMonthWinCnt = map_pStatusCount.get('Month');
        if(map_pStatusCount.containsKey('Year'))                  completedByYearWinCnt = map_pStatusCount.get('Year');
    }
    
    public void queryNewUserProjects() {
        showFirstScreen = false;
        showNewUserSession = true;
        
        List<New_User_Task_Summary__c> newUser = [select Active_Count__c, Deferred_Count__c, Escalated_Count__c,
                Completed_By_Month_Count__c, Completed_By_Year_Count__c from New_User_Task_Summary__c
                where Name = 'NewUserLive' limit 1];
        if(newUser != null && newUser.size() > 0) {
            New_User_Task_Summary__c nu = newUser[0];
            activeNewUsrCnt = nu.Active_Count__c == null ? 0 : Integer.valueOf(nu.Active_Count__c);
            newUsrDefCnt = nu.Deferred_Count__c == null ? 0 : Integer.valueOf(nu.Deferred_Count__c);
            newUsrEscCnt = nu.Escalated_Count__c == null ? 0 : Integer.valueOf(nu.Escalated_Count__c);
            completedByMonthNewUsrCnt = nu.Completed_By_Month_Count__c == null ? 0 : Integer.valueOf(nu.Completed_By_Month_Count__c);
            completedByYearNewUsrCnt = nu.Completed_By_Year_Count__c == null ? 0 : Integer.valueOf(nu.Completed_By_Year_Count__c);
        }
    }
    
    public void queryStockWaveProjects() {
        showFirstScreen = false;
        showStockWave = true;
        
        Map<String, Integer> map_pStatusCount = new Map<String, Integer>();
        map_pStatusCount = FOD_Helper.projectCount('Stockwave', 'Integration');
        
        if(map_pStatusCount.containsKey('Active'))                activeIntSWCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Back to Sales'))         intDelSWCnt = map_pStatusCount.get('Back to Sales');
        if(map_pStatusCount.containsKey('Deferred'))              intDefSWCnt = map_pStatusCount.get('Deferred');
        
        map_pStatusCount = FOD_Helper.projectCount('Stockwave', 'Training 1');
        
        if(map_pStatusCount.containsKey('Active'))                activeTrnSWCnt = map_pStatusCount.get('Active');
        if(map_pStatusCount.containsKey('Back to Sales'))         trnDelSWCnt = map_pStatusCount.get('Back to Sales');
        if(map_pStatusCount.containsKey('Deferred'))              trnDefSWCnt = map_pStatusCount.get('Deferred');
        if(map_pStatusCount.containsKey('Escalated to PM'))       trnEscSWCnt = map_pStatusCount.get('Escalated to PM');
        
        map_pStatusCount = FOD_Helper.projectCountForCompleted('Stockwave');
        if(map_pStatusCount.containsKey('Month'))                 completedByMonthSWCnt = map_pStatusCount.get('Month');
        if(map_pStatusCount.containsKey('Year'))                  completedByYearSWCnt = map_pStatusCount.get('Year');
        
        List<FO_Project_Budget__c> budgetList = [select Stockwave_Budget__c, Budget_Date__c from FO_Project_Budget__c 
                    where Budget_Date__c = THIS_QUARTER];
        Integer thisMonth = System.today().month();
        for(FO_Project_Budget__c bgt : budgetList) {
            if(bgt.Stockwave_Budget__c != null) {
                Decimal budgetAmt = bgt.Stockwave_Budget__c;
                if(bgt.Budget_Date__c.month() == thisMonth)
                    budgetMTDSW = budgetAmt.setScale(0);
                budgetQTDSW += budgetAmt.setScale(0);
            }
        }
    }
}