/*
This trigger works on the Installment custom object after a delete is performed.  


*/

trigger AfterDeleteInstallment on Installment__c (after delete) 
{

    /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
    if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('AfterDeleteInstallment')){
      system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
      system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
      system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
      return;
    }

	//Build a map of the installments being deleted
	MAP<Id, Installment__c> theseInstallmentOpptys = new MAP<Id, Installment__c>();
	
	//loop through the old values and place them in the map if the Opportunity is not null
	for(Installment__c I: trigger.old)
	{
		if(I.Opportunity__c!=null)
		{
			theseInstallmentOpptys.put(I.Opportunity__c, I);
		}		
	}
	
	//Create a list of Opportunitues where the id is in the Map, theseInstallmentOpptys
	LIST<Opportunity> theseOpportunities = 
	[select id, name, Account.name, Total_Installments_Paid__c, Phased_Project__c, Project_Generated__c, Project_Exception__c, Type, Opportunity_Names__c 
	from Opportunity 
	where id IN: theseInstallmentOpptys.keySet()];
	
	//Create a list of Installments where the Intallment__c.paid value is not null and the Opportunity id is in the Map, theseInstallmentOpptys
	LIST<Installment__c> paidInstallments = 
	[select id, isdeleted, Installment_Amount__c, Opportunity__c 
	from Installment__c 
	where Installment__c.Paid__c!=null 
	and Opportunity__c IN: theseInstallmentOpptys.keySet()];
	
	//Create a list of Product Processes, but I dont think this gets populated
	LIST<Product_Process__c> prodProc = new LIST<Product_Process__c>();
	
	//Create a list of Opportunity line items again I dont see where this gets populated
	LIST<OpportunityLineItem> OLIs = new LIST<OpportunityLineItem>();
	
	
	//loop through the old values of the trigger
	for(Installment__c I: Trigger.old)
	{
		
		 Opportunity parentOppty = new Opportunity();
		 
		 //loop through the list "theseOpportunities"
		 for(Opportunity thisOppty: theseOpportunities)
		 {
		 	//if the the id's match set the parent equal to it 
		 	if(thisOppty.Id==I.Opportunity__c)
		 	{
		 		parentOppty = thisOppty;
		 	}
		 }
		 
		 // create a new list for relatedINsatallments			
		 LIST<Installment__c> relatedInstallments = new LIST<Installment__c>();
		 
		 //loop through the paid installments
		 for(Installment__c thisPaidInstallment: paidInstallments)
		 {
		 	//if the paid installments Opportunity is the same as current Installment Opportunity then add it to the related list
		 	if(thispaidInstallment.Opportunity__c==I.Opportunity__c)
		 	{
		 		relatedInstallments.add(thisPaidInstallment);
		 	}
		 }
		
		boolean firstPayment=false;
		
		Territory_State__c territoryState = new Territory_State__c();
		//Send all of the data collected to the Installment the updatedate method in the installment class..
		Installment.UpdateOpportunityPaidInstallments(I, firstPayment, parentOppty, relatedInstallments, OLIs, prodProc, territoryState);
	}
	
}