public class FOD_SalesPipelineCtrl {
    
    public static String projChartStr {get;set;}
    
    public fod_SalesPipelineCtrl() {
        String dateCondition = ' and CloseDate = THIS_MONTH ';
        pieChartData(dateCondition);
    }
    
    @RemoteAction
    public static String getChartInput(String selectedValue, String chartType, String monthType) {
        String chartData = '';
        
        String dateCondition = '';
        if(monthType == 'Next Month') {
            monthType = 'This Month';
            dateCondition = ' and CloseDate = NEXT_MONTH ';
        } else if(monthType == 'This Month') {
            monthType = 'Next Month';
            dateCondition = ' and CloseDate = THIS_MONTH ';
        }
        if(chartType == 'project') {
            chartData = pieChartData(dateCondition);
        } else if (chartType == 'acc') {
            chartData = queryAccounts(selectedValue,dateCondition);
        }
        return chartData;
    }
    
    public static String queryAccounts(String selectedValue, String dateCondition) {
        System.debug('selectedValue===' + selectedValue);
        String selType = selectedValue.split(':')[0];
        String selStatus = selectedValue.split(':')[1];
        if(selType == 'Provision') selType = 'Account Setup';
        String operator = '=';
        if(selStatus == 'Open') operator = '!=';
        
        //String query = 'SELECT COUNT_DISTINCT(Opportunity__r.AccountId) cnt, Opportunity__r.Account.Dealer_Type__c rt FROM SFDC_520_Quote__c where Opportunity__r.StageName ' + selStatus + ' \'Closed or Lost\' and Name like \'%' + selType + '%\' and Opportunity__r.Account.Dealer_Type__c != null ' ;
        String query = 'SELECT COUNT_DISTINCT(AccountId) cnt, Account.Dealer_Type__c rt FROM Opportunity where StageName ' + operator + ' \'Closed or Won\' and StageName != \'Closed or Lost\' and Name like \'%' + selType + '%\' ' + FOD_Helper.excludeOppCondition();//and Opportunity__r.Account.Dealer_Type__c != null
        query += dateCondition;
        query += '  Group by Account.Dealer_Type__c ';
        System.debug('query accounts = '+query);
        AggregateResult[] groupedResults = Database.query(query);
        System.debug('groupedResults===' + groupedResults);
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
        //String accChart = '[\''+ selectedValue +'\',10],[\'B\',15]';
        return chartString;
    }
    
    public static String pieChartData(String dateCondition) {

        Map<String, PieWedgeData> pieMap = new Map<String, PieWedgeData>();
        
        System.debug('dateCondition ====' + dateCondition);
        String query = 'SELECT COUNT(id) cnt, StageName stg, Name pname FROM Opportunity where StageName != \'Closed or Lost\' and (Name like \'%Conquest%\' or Name like \'%Account Setup%\') ' + FOD_Helper.excludeOppCondition();
        query += dateCondition;
        query += '  Group by Name, StageName ';
        AggregateResult[] groupedResults = Database.query(query);
        System.debug('groupedResults ====' + groupedResults);
        for (AggregateResult agr: groupedResults) {
            String pName = String.valueOf(agr.get('pname'));
            String pStage = String.valueOf(agr.get('stg'));
            System.debug('agr====' + agr);
            Decimal count = 0;
            if(pName != null && String.valueOf(pName).contains('Conquest')) {
                if(pStage != null && String.valueOf(pStage).equals('Closed or Won')) {
                    System.debug(' in Conquest Closed ++++++');
                    if(pieMap.containsKey('Conquest:Closed'))
                        count = pieMap.get('Conquest:Closed').data;
                    count += Integer.valueOf(agr.get('cnt'));
                    pieMap.put('Conquest:Closed', new PieWedgeData('Conquest:Closed', count));
                } else if(pStage != null && String.valueOf(pStage) != null){
                    System.debug(' in Conquest Open ++++++');
                    if(pieMap.containsKey('Conquest:Open'))
                        count = pieMap.get('Conquest:Open').data;
                    count += Integer.valueOf(agr.get('cnt'));
                    pieMap.put('Conquest:Open', new PieWedgeData('Conquest:Open', count));
                }
            }
            
            if(pName != null && String.valueOf(pName).contains('Account Setup')) {
                if(pStage != null && String.valueOf(pStage).equals('Closed or Won')) {
                    System.debug(' in Provision Closed ++++++');
                    if(pieMap.containsKey('Provision:Closed'))
                        count = pieMap.get('Provision:Closed').data;
                    count += Integer.valueOf(agr.get('cnt'));
                    pieMap.put('Provision:Closed', new PieWedgeData('Provision:Closed', count));
                } else if(pStage != null && String.valueOf(pStage) != null){
                    System.debug(' in Provision Open ++++++');
                    if(pieMap.containsKey('Provision:Open'))
                        count = pieMap.get('Provision:Open').data;
                    count += Integer.valueOf(agr.get('cnt'));
                    pieMap.put('Provision:Open', new PieWedgeData('Provision:Open', count));
                }
            }
                
        }
        
        String chartString = '';
        for(PieWedgeData pwd :pieMap.values()) {
            chartString += '[\'' + pwd.name + '\',';
            chartString += pwd.data + '],';
        }
        if(chartString.length() > 1)
        chartString = chartString.substring(0, chartString.length() - 1);
        System.debug('pieMap===' + pieMap);
        projChartStr = chartString;
        return chartString;
    }
    
    public class PieWedgeData {
    
        public String name { get; set; }  
        public decimal data { get; set; } 

        public PieWedgeData(String name, decimal data) {
            this.name = name;  
            this.data = data; 
        }
    }
}