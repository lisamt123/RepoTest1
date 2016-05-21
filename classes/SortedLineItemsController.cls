public class SortedLineItemsController 
{
    public Opportunity opportunity { get; set; }
    
    public OpportunityLineItem[] getSorted1() 
    {
        if (opportunity == null || opportunity.opportunityLineItems== null) 
        {
            return null;
        }
        
        // TODO: Add your sorting logic here (demo just reverses the list)
        LIST<OpportunityLineItem> result = new LIST<OpportunityLineItem>();
        for (OpportunityLineItem item : [select Discount_Amount__c, ListPrice, List_Price_Formula__c, PricebookEntry.Product2.Description, PricebookEntry.Product2.Name, Quantity, TotalPrice, ActualDescription__c, TNOPPST__LineTax__c  from OpportunityLineItem where OpportunityLineItem.OpportunityId=:opportunity.Id and Product_Sort_Order__c = 1 order by TotalPrice desc])//opportunity.opportunityLineItems) 
        {          
           result.add(item);
        }
        
        return result;
   }
   public OpportunityLineItem[] getSorted2() 
    {
        if (opportunity == null || opportunity.opportunityLineItems== null) 
        {
            return null;
        }
        
        // TODO: Add your sorting logic here (demo just reverses the list)
        LIST<OpportunityLineItem> result = new LIST<OpportunityLineItem>();
        for (OpportunityLineItem item : [select Discount_Amount__c, ListPrice, List_Price_Formula__c, PricebookEntry.Product2.Description, PricebookEntry.Product2.Name, Quantity, TotalPrice, ActualDescription__c, TNOPPST__LineTax__c from OpportunityLineItem where OpportunityLineItem.OpportunityId=:opportunity.Id  and Product_Sort_Order__c = 2 order by TotalPrice desc])//opportunity.opportunityLineItems) 
        {   
        	       
           result.add(item);
        }
        
        return result;
   }
   public OpportunityLineItem[] getSorted3() 
    {
        if (opportunity == null || opportunity.opportunityLineItems== null) 
        {
            return null;
        }
        
        // TODO: Add your sorting logic here (demo just reverses the list)
        LIST<OpportunityLineItem> result = new LIST<OpportunityLineItem>();
        for (OpportunityLineItem item : [select Discount_Amount__c, ListPrice, List_Price_Formula__c, PricebookEntry.Product2.Description, PricebookEntry.Product2.Name, Quantity, TotalPrice, ActualDescription__c, TNOPPST__LineTax__c from OpportunityLineItem where OpportunityLineItem.OpportunityId=:opportunity.Id  and Product_Sort_Order__c = 3 order by TotalPrice desc])//opportunity.opportunityLineItems) 
        {          
           result.add(item);
        }
        
        return result;
   }
   public OpportunityLineItem[] getSorted4() 
    {
        if (opportunity == null || opportunity.opportunityLineItems== null) 
        {
            return null;
        }
        
        // TODO: Add your sorting logic here (demo just reverses the list)
        LIST<OpportunityLineItem> result = new LIST<OpportunityLineItem>();
        for (OpportunityLineItem item : [select Discount_Amount__c, ListPrice, List_Price_Formula__c, PricebookEntry.Product2.Description, PricebookEntry.Product2.Name, Quantity, TotalPrice, ActualDescription__c, TNOPPST__LineTax__c from OpportunityLineItem where OpportunityLineItem.OpportunityId=:opportunity.Id  and Product_Sort_Order__c = 4 order by TotalPrice desc])//opportunity.opportunityLineItems) 
        {   
        	
        	result.add(item);
        }
        
        return result;
   }
   
   public OpportunityLineItem[] getSorted5(){
   	
   		if(opportunity == null || opportunity.opportunityLineItems == null){
   			
   			return null;
   		}
   		
   		//TODO:  Add your sorting logic here (demo just reverse the list)
   		LIST<OpportunityLineItem> result = new LIST<OpportunityLineItem>();
   		for (OpportunityLineItem item : [SELECT Discount_Amount__c, ListPrice, List_Price_Formula__c, 
   												 PricebookEntry.Product2.Description, PricebookEntry.Product2.Name,
   												 Quantity, TotalPrice, ActualDescription__c, TNOPPST__LineTax__c
   										  FROM OpportunityLineItem
   										  WHERE OpportunityLineItem.OpportunityId =: opportunity.Id and Product_Sort_Order__c = 5 order by TotalPrice desc]){
   		
   			result.add(item);								  	
   										  	
   		}
   										  	
   			return result;							  	
   }
  public static testmethod void testSortedLine()
  {
  	Opportunity Opp = new Opportunity();
  	OpportunityLineItem oli = new OpportunityLineItem(One_Time_Fee__c = true, Setup_Fee__c = true, Solution_Product__c = true, OpportunityId = Opp.id);
  	  		
  	Apexpages.Standardcontroller sc = new Apexpages.Standardcontroller(oli);
  	
  	SortedLineItemsController SLIC = new SortedLineItemsController();
  	
  	SLIC.opportunity = Opp;
  	SLIC.getSorted1();
  	SLIC.getSorted2();
  	SLIC.getSorted3();
  	SLIC.getSorted4();
  	SLIC.getSorted5();
  }
}