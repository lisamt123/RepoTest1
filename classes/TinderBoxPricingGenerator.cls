/***************************************************************************************************
Name        : TinderBoxPricingGenerator 
Created By  : TinderBox 
Email       : developer@tinderbox.com
Created Date: July 24, 2013
Description : Builds a multi-part pricing table based on specific conditions 
              for opportunity product records.
******************************************************************************************************/
public with sharing class TinderBoxPricingGenerator {
/*
   class PricingTable
   {
       Opportunity oOpportunity;
       tinderbox__TinderBox__c oTinderBoxSettings;
       Decimal finalRetailPrice = 0;
       Decimal finalSalePrice = 0;
       Decimal currentTotalRetailPrice = 0;
       Decimal currentTotalSalePrice = 0;

       public PricingTable(Opportunity opp, tinderbox__TinderBox__c tbSettings)
       {
          oOpportunity = opp;
          oTinderBoxSettings = tbSettings;
       }

       public String buildTable(String headTitle, String footTitle, List<Map<String,Object>> lineItems)
       {
            String sHTML = '';

            if (lineItems.size() > 0) {
                sHTML += this.getTableHeader(headTitle);
                sHTML += this.buildTableLineItems(lineItems);
                sHTML += this.getTableFooter(footTitle);
            } else {
                System.debug('PricingTable.buildTable: No products given for ' + headTitle);
            }
            return sHTML;
       }

       public String getTableHeader(String title) {
    
           return '<table border="0" class="pricing">' +
              '  <thead>' +
              '    <tr>' +
              '      <th class="name">' + title + '</th>' +
              '      <th class="retail" nowap="nowrap">Retail price</th>' +
              '      <th class="sale">Sale price</th>' +
              '    </tr>' +
              '  </thead>' +
              '  <tbody>';
        }
        
        public String getTableFooter(String title) {
    
           return '</tbody>' +
              '  <tfoot>' +
              '    <tr>' +
              '      <th class="name">' + title + ':</th>' +
              '      <th class="retail">$' + currency(currentTotalRetailPrice) + '</th>' +
              '      <th class="sale">$' + currency(currentTotalSalePrice) + '</th>' +
              '    </tr>' +
              '  </tfoot>' +
            '</table>' +
            '<p>&nbsp;</p>';
        }

        public String getTableSummary() {
           return '<table border="0" class="pricing summary">' +
             '  <tfoot>' +
             '    <tr>' +
             '      <th class="name">Total due upfront to start:</th>' +
             '      <th class="retail">$' + currency(finalRetailPrice) + '</th>' +
             '      <th class="sale">$' + currency(finalSalePrice) + '</th>' +
             '    </tr>' +
             '  </tfoot>' +
             '</table>';
       }

        public String buildTableLineItems(List<Map<String, Object>> lineItems)
        {
            // Reset current table totals.
            currentTotalRetailPrice = 0;
            currentTotalSalePrice = 0;

           String sHTML = '';
           for(Map<String, Object> record: lineItems) {
              String name = (String)record.get('name');
              Object oRetailPrice = record.get('retail_price');
              Object oSalePrice = record.get('sale_price');
              Decimal retailPrice  = (oRetailPrice == null) ? 0 : (Decimal)oRetailPrice;
              Decimal salePrice  = (oSalePrice == null) ? 0 : (Decimal)oSalePrice;

               currentTotalRetailPrice += retailPrice;
               currentTotalSalePrice += salePrice;
               finalRetailPrice += retailPrice;
               finalSalePrice += salePrice;

               sHTML += '<tr>' +
              '<td class="name">' + name + '</td>' + 
              '<td class="retail">$' + currency(retailPrice) + '</td>' +
              '<td class="sale">$' + currency(salePrice) + '</td></tr>\n';
           }
           return sHTML;
       }
       

        public String currency(Decimal d) {
            return TinderBoxPricingGenerator.currency(String.valueOf(d));
        }

    }
   
    public static String currency(String i) {
        String s = ( Decimal.valueOf(i==null||i.trim()==''?'0':i).setScale(2) + 0.001 ).format();
        return s.substring(0,s.length()-1);
    }

    
    public static Map<String, Object> getOneTimeAggregateResult(String sOpportunityId)
    {
        AggregateResult[] results = [SELECT SUM(List_Price_Formula__c)RetailPrice, SUM(TotalPrice)SalePrice
                                     FROM OpportunityLineItem Where OpportunityId = :sOpportunityId 
                                     AND Source_Package_Product__c != '' AND (One_Time_Fee__c = true OR Setup_Fee__c = true)];

        Map<String, Object> record = new Map<String, Object>();
        
        Decimal retailPrice = (Decimal)results[0].get('RetailPrice');
        Decimal salePrice = (Decimal)results[0].get('SalePrice');

        record.put('name', 'Package setup and training cost');
        record.put('retail_price', retailPrice);
        record.put('sale_price', salePrice);
        
        return record;
    }
    
    /*public static Map<String, Object> getOneTimeAggregateResult(String sOpportunityId){
        
        Map<String, Object> record = new Map<String, Object>();
        if(test.IsRunningTest()==false){
            AggregateResult[] results = [SELECT SUM(List_Price_Formula__c)RetailPrice, SUM(UnitPrice)SalePrice
                                         FROM OpportunityLineItem Where OpportunityId = :sOpportunityId 
                                         AND IsPackageChild__c = FALSE AND (One_Time_Fee__c = true OR Setup_Fee__c = true)];
    
            
            
            Decimal retailPrice = (Decimal)results[0].get('RetailPrice');
            Decimal salePrice = (Decimal)results[0].get('SalePrice');
    
            record.put('name', 'Package setup and training cost');
            record.put('retail_price', retailPrice);
            record.put('sale_price', salePrice);
        }
        return record;
    }*/
	/*
    public static List<Map<String, Object>> getProductLineItems(Opportunity oOpportunity, String sWhereClause) {

        tinderbox__TinderBox__c oTinderBoxSettings = tinderbox__TinderBox__c.getInstance(userinfo.getProfileId());

        String sHTML = '';

        System.debug('TinderBoxPricingTable.buildOpportunityPricingHTML: HTML - ' + sHTML);

        String sSOQL = 'Select Id, PricebookEntry.Product2.Name, List_Price_Formula__c, TotalPrice, Package_Value__c';

        String sOrderBy = '';

        if(oTinderBoxSettings.tinderbox__Sort_Field_1__c != NULL) {

            if(oTinderBoxSettings.tinderbox__Sort_Field_2__c != NULL){

                sSOQL += ', ' + oTinderBoxSettings.tinderbox__Sort_Field_1__c + ', ' + oTinderBoxSettings.tinderbox__Sort_Field_2__c;

                sOrderBy += ' Order By ' + oTinderBoxSettings.tinderbox__Sort_Field_1__c + ', ' + oTinderBoxSettings.tinderbox__Sort_Field_2__c;

            }else{
                
                sSOQL += ', ' + oTinderBoxSettings.tinderbox__Sort_Field_1__c;
                
                sOrderBy += ' Order By ' + oTinderBoxSettings.tinderbox__Sort_Field_1__c;
            }
        }
        
        sSOQL += ' From OpportunityLineItem Where OpportunityId = \'' + oOpportunity.Id + '\' ' + sWhereClause + sOrderBy;

        System.debug('TinderBoxPricingTable.buildOpportunityPricingHTML: SOQL - ' + sSOQL);

        List<Map<String, Object>> queryResults = new List<Map<String, Object>>();
        for(OpportunityLineItem oOpportunityLineItem: Database.query(sSOQL)) {

            Decimal retailPrice = oOpportunityLineItem.List_Price_Formula__c;
            //Decimal salePrice = oOpportunityLineItem.UnitPrice;
            Decimal salePrice = oOpportunityLineItem.TotalPrice;
           
            // A line item can be a package parent or a package child.
            // A package parent will have a value for Package_Value__c
            // which should be used along with the Opportunity Total_Packaged_MRR__c
            if (oOpportunityLineItem.Package_Value__c > 0) {
                retailPrice = oOpportunityLineItem.Package_Value__c;
                salePrice = oOpportunity.Total_Packaged_MRR__c;
            }

            Map<String, Object> record = new Map<String, Object>();
            record.put('name', oOpportunityLineItem.PricebookEntry.Product2.Name);
            record.put('retail_price', retailPrice);
            record.put('sale_price', salePrice);
            queryResults.add(record);
        }
        
        return queryResults;
    }
    
   /**
        buildOpportunityPricingHTML
        
        Args: oOpportunity (Opportunity) - Opportunity to build Pricing HTML field for   
        
        Desc: This method builds the HTML Pricing Table used within the TinderBox proposal using
              the TinderBox__c Custom Settings and the Opportunity Line Items associated to
              the Opportunity          
    **/
    
    public static void buildOpportunityPricingHTML(Opportunity oOpportunity){
/*
        System.debug('TinderBoxPricingTable.buildOpportunityPricingHTML: Start Method');

        try{

            tinderbox__TinderBox__c oTinderBoxSettings = tinderbox__TinderBox__c.getInstance(userinfo.getProfileId());

            if (oTinderBoxSettings.tinderbox__Generate_Custom_Pricing__c) {

                PricingTable pricing = new PricingTable(oOpportunity, oTinderBoxSettings);
                //String sHTML = TinderBoxPricingGenerator.getStyles();
                String sHTML = '';
                // Find all Monthly/Package Items.
                List<Map<String,Object>> monthlyItems = getProductLineItems(oOpportunity, 'AND IsPackageChild__c = false AND One_Time_Fee__c = false AND Setup_Fee__c = false');
                sHTML += pricing.buildTable('Monthly Fees', 'Total Monthly price', monthlyItems);

                // Find all One Time / Setup Line Items. 1st is the aggregate of package children.
                Map<String, Object> aggregate = getOneTimeAggregateResult(oOpportunity.Id);
                // Next are all other one-time/setup items.
                //List<Map<String,Object>> oneTimeItems = getProductLineItems(oOpportunity, 'AND IsPackageChild__c = FALSE AND (One_Time_Fee__c = TRUE OR Setup_Fee__c = TRUE)');
                // One_Time_Fee__c = TRUE OR  AND Non_Monthly_Created_by_Pkg__c = FALSE
                List<Map<String,Object>> oneTimeItems = getProductLineItems(oOpportunity, 'AND Source_Package_Product__c = \'\' AND (One_Time_Fee__c = TRUE OR Setup_Fee__c = TRUE)');
                if (oneTimeItems.size() == 0) {
                    oneTimeItems.add(aggregate);
                } else {
                    oneTimeItems.add(0, aggregate);
                }

                sHTML += pricing.buildTable('One-Time Setup & Training', 'Total One-time cost', oneTimeItems);
                sHTML += pricing.getTableSummary();
                if (oOpportunity.Terms_and_Conditions__c != null) {
                    sHTML += '<p class="pricing-terms">' + oOpportunity.Terms_and_Conditions__c.replaceAll('\n','<br/>') + '</p>';
                }

                // Hard-coding assignment due to conflict with managed package trigger.
                oOpportunity.CustomPricing__c = sHTML;
                /*
                if (oTinderBoxSettings.tinderbox__Pricing_HTML_Field__c != '') {
                    oOpportunity.put(oTinderBoxSettings.tinderbox__Pricing_HTML_Field__c, sHTML);
                    System.debug('Setting Opportunity field ' + oTinderBoxSettings.tinderbox__Pricing_HTML_Field__c);
                } else {
                    System.debug('TinderBoxPricingTable.buildOpportunityPricingHTML: Custom Setting Pricing HTML field is not set');
                }*/
    /*
            }else{
                System.debug('TinderBoxPricingTable.buildOpportunityPricingHTML: Custom Setting Generate Pricing Setting is false or not configured for Profile Id ' + userinfo.getProfileId());
            }

        }catch(Exception oException){
          
            System.debug('TinderBoxPricingTable.buildOpportunityPricingHTML' + oException.getMessage());
        
        }finally{
        
            System.debug('TinderBoxPricingTable.buildOpportunityPricingHTML: End Method');
        }     
       */  
    }
    /*
    public static String getStyles() {
        return '<style type="text/css">'+
                'table.pricing th { text-align: left; }'+ 
                'table.pricing thead th { text-decoration: underline; }'+
                'table.pricing thead th.name, tfoot th.name { width: 400px; }'+
                'table.pricing thead th.retail, tfoot th.retail { width: 125px; }'+
                'table.pricing th, td { padding: 5px; }'+
                'table.pricing tfoot th.retail, tbody td.retail { color: red; }'+
                'table.pricing tfoot th.retail { text-decoration: line-through; }'+
                'table.pricing tfoot tr th { border-top: 1px solid black; }'+
                'p.pricing-terms { padding-top: 20px }' +
                '</style>';
    }
  */
}