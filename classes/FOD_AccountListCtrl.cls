public class FOD_AccountListCtrl {
    
    transient public List<Opportunity> oppList {get; set;}
    Set<Id> oppIds = new Set<Id>();
    public String SORT_ORDER;
    public String pageTitle {get; set;}
    String selectedDealerType = ApexPages.currentPage().getParameters().get('sv');
    String selectedMonth = ApexPages.currentPage().getParameters().get('dt');
    
    public fod_AccountListCtrl() {
        pageTitle = '';
        String selectedProject = ApexPages.currentPage().getParameters().get('sp');
        SORT_ORDER = 'ASC';
        if(selectedProject != null && selectedProject != '') 
            querySeletedAccounts(selectedProject);
    }
    
    public void querySeletedAccounts(String selectedProject) {
        System.debug('selectedProject ===' + selectedProject);
        String selType = selectedProject.split(':')[0];
        String selStatus = selectedProject.split(':')[1];
        
        pageTitle = 'Sales Pipeline - ' + selType;
        
        if(selType == 'Provision') selType = 'Account Setup';
        String operator = '=';
        if(selStatus == 'Open') operator = '!=';
        
        System.debug('selectedDealerType==' + selectedDealerType);
        
        pageTitle += ' - ' + selStatus + ' - ' + selectedDealerType;
        
        String delTypeCond = ' Account.Dealer_Type__c = :selectedDealerType ';
        
        if(selectedDealerType == 'Other') {
            delTypeCond = ' Account.Dealer_Type__c = null ';
        }
        String dateCondition = '';
        if(selectedMonth == 'This Month') {
            dateCondition = ' and CloseDate = THIS_MONTH';
        } else if(selectedMonth == 'Next Month') {
            dateCondition = ' and CloseDate = NEXT_MONTH';
        }
        String query = 'SELECT id FROM Opportunity where StageName ' + operator + ' \'Closed or Won\' and StageName != \'Closed or Lost\' and Name like \'%' + selType + '%\' and ' + delTypeCond + dateCondition + FOD_Helper.excludeOppCondition();
        //String query = 'SELECT Opportunity__c FROM SFDC_520_Quote__c where Opportunity__r.StageName != \'Closed or Lost\' and Name like \'%' + selType + '%\' and Opportunity__r.Account.Dealer_Type__c = :selectedDealerType' ;
        System.debug('query==' + query);
        for(Opportunity p :Database.query(query)) {
            oppIds.add(p.id);
        }
        ApexPages.currentPage().getParameters().put('orderby', 'Name');
        queryOpp();
        //oppList = [select Name, Owner.Name, Probability, CloseDate, Dealmaker_Close_Date__c, Account.Name, Auto_Group__c, Account.Dealer_Type__c from Opportunity where id in :oppIds];
    }
    
    public void queryOpp() {
        String orderByCol = ApexPages.currentPage().getParameters().get('orderby');
        String ORDER_STRING = ' Order By ' + orderByCol + ' ' + SORT_ORDER;
        
        String q = 'select Name, Owner.Name, Probability, CloseDate, Dealmaker_Close_Date__c, Account.Name, Auto_Group__c, Account.Dealer_Type__c from Opportunity where id in :oppIds ' + ORDER_STRING;
        
        oppList = Database.query(q);
        
        if(selectedDealerType == 'Other') {
            for(Opportunity opp : oppList) {
                opp.Account.Dealer_Type__c = 'Other';
            }
        }
        
        if(SORT_ORDER == 'ASC') SORT_ORDER = 'DESC';
        else if(SORT_ORDER == 'DESC') SORT_ORDER = 'ASC';
    }
    
    public PageReference backToDashboard() {
        return new Pagereference('/apex/FODashboard').setRedirect(true);
    }
}