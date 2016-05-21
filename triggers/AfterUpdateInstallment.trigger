trigger AfterUpdateInstallment on Installment__c (after update, after insert) 
{
	
	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
    if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('AfterUpdateInstallment')){
      system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
      system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
      system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
      return;
    }

	
	
	if(trigger.isUpdate) {
	
		MAP<Id, Installment__c> theseInstallmentOpptys = new MAP<Id, Installment__c>();	
		for(Installment__c I: trigger.new)
		{
			if(I.Opportunity__c!=null)
			{
				theseInstallmentOpptys.put(I.Opportunity__c, I);
			}		
		}
		LIST<Opportunity> theseOpportunities = 
		[select id, name, Account.name, Total_Installments_Paid__c, Territory_State_Id__c, Phased_Project__c, 
		Implementation_Contact__c, Project_Generated__c, Project_Exception__c, Type, Opportunity_Names__c,
		Campaign_Start_Date__c, Campaign_End_Date__c, Fulfillment_Timeline__c, Campaign_Type__c, OwnerId, Mailer_Notes__c,
		Initial_Load__c, RecordTypeId, RecordType.Name, Confirmed__c
		from Opportunity 
		where id IN: theseInstallmentOpptys.keySet()];	
		
		LIST<Installment__c> paidInstallments = 
		[select id, Installment_Amount__c, Opportunity__c 
		from Installment__c 
		where Opportunity__c IN: theseInstallmentOpptys.keySet()];
		//where Installment__c.Paid__c!=null 
		//and Opportunity__c IN: theseInstallmentOpptys.keySet()];
		
		
		//Get a list of all Product Processes
		/*LIST<Product_Process__c> prodProc = new LIST<Product_Process__c>();
	    for(Product_Process__c PrP:
	    [select id, Number_of_Milestones__c, Product__c 
	    from Product_Process__c])
	    {
	        prodProc.add(Prp);
	    }*/
	    
	    MAP<Id, Opportunity> OpptyState = new MAP<Id, Opportunity>(); 
	    for(Opportunity thisState:theseOpportunities)
	    {
	    	OpptyState.put(thisState.Territory_State_Id__c, thisState);
	    }   
	    
	    List<Territory_State__c> allStates = 
	    [select Territory_Manager__c, DDM__c, Account_Manager__c, Regional__c, Implementation_Manager__c,
	    Implementation_Specialist__c, Website_Manager__c from Territory_State__c where Id IN: OpptyState.keySet()];
		
		//Get a list of the Opportunity Line Items/Products added to the Opportunity        
		LIST<OpportunityLineItem> allOLIs = [SELECT Description, IsTraining__c, ProductId__c, PricebookEntry.Name, ProdProj_Default_Owner__c, Product_Issue__c, 
	    										Product_Issue2__c, Product_Issue3__c, ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, 
    											Production_Department__c, Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
	    										PricebookEntryId, requiresWelcomePacket__c, TotalPrice, OpportunityId, Id, Total_List_Price__c, VS_Sale_Price__c,
	    										OLI_Cost_Factor__c, PricebookEntry.Product2.Subject_to_Load__c, PricebookEntry.Product2.Project_Separation__c,
												Project__c, PricebookEntry.Product2.Family, PricebookEntry.Product2.ProdProj_Default_Owner__c, Product_MRR__c
	    									 FROM OpportunityLineItem 
	    									 WHERE OpportunityId IN: theseInstallmentOpptys.keySet()];
	    
	    MAP<Id, OpportunityLineItem> OLIMap = new MAP<Id, OpportunityLineItem>();
	    
	    for (OpportunityLineItem thisOLI: allOLIs)
	    {
	    	OLIMap.put(thisOLI.ProductId__c, thisOLI);
	    }
	    
	    LIST<Product_Process__c> prodProc = [select id, Number_of_Milestones__c, Product__c from Product_Process__c where Product__c IN: OLIMap.keyset()];
	    
	        
		 
		for(Installment__c I:Trigger.new)
		{		
			Installment__c oI = trigger.oldMap.get(I.Id);
			boolean firstPayment;
			 // this will be removed
			 if(oI.Paid__c==null&&I.Paid__c!=null)
			 { 
			 	firstPayment = true;
			 }
			 else
			 {
			 	firstPayment = false;
			 }
			
			 Opportunity parentOppty = new Opportunity();
			 Territory_State__c territoryState = new Territory_State__c();
			 for(Opportunity thisOppty:theseOpportunities)
			 {
			 	if(thisOppty.Id==I.Opportunity__c)
			 	{
			 		parentOppty = thisOppty;
			 		for(Territory_State__c thisState:allStates)
					{
					 	if(thisState.Id==thisOppty.Territory_State_Id__c)
					 	{
					 		territoryState = thisState;
					 	}
					}
			 	}
			 }
			 LIST<Installment__c> relatedInstallments = new LIST<Installment__c>();
			 for(Installment__c thisPaidInstallment: paidInstallments)
			 {
			 	
			 	if(thispaidInstallment.Opportunity__c==I.Opportunity__c)
			 	{
			 		relatedInstallments.add(thisPaidInstallment);
			 	}
			 }
			 LIST<OpportunityLineItem> OLIs = new LIST<OpportunityLineItem>();
			 for(OpportunityLineItem thisOli:allOLIs)
			 {
			 	if(thisOli.OpportunityId==I.Opportunity__c)
			 	{
			 		OLIs.add(thisOli);
			 	}
			 }
			 
			 
			 Installment.UpdateOpportunityPaidInstallments(I, firstPayment, parentOppty, relatedInstallments, OLIs, prodProc, territoryState);
		}
	}	
	/**/
	if(trigger.isInsert) {
		
		
	
		MAP<Id, Installment__c> theseInstallmentOpptys = new MAP<Id, Installment__c>();	
		for(Installment__c I: trigger.new)
		{
			if(I.Opportunity__c!=null)
			{
				theseInstallmentOpptys.put(I.Opportunity__c, I);
			}		
		}
		LIST<Opportunity> theseOpportunities = 
		[select id, name, Account.name, Total_Installments_Paid__c, Territory_State_Id__c, Phased_Project__c, 
		Implementation_Contact__c, Project_Generated__c, Project_Exception__c, Type, Opportunity_Names__c,
		Campaign_Start_Date__c, Campaign_End_Date__c, Fulfillment_Timeline__c, Campaign_Type__c, OwnerId, Mailer_Notes__c,
		Initial_Load__c, RecordTypeId, RecordType.Name, Load_Counter__c, Confirmed__c
		from Opportunity 
		where id IN: theseInstallmentOpptys.keySet()];	
		
		LIST<Installment__c> paidInstallments = 
		[select id, Installment_Amount__c, Opportunity__c 
		from Installment__c 
		where Opportunity__c IN: theseInstallmentOpptys.keySet()];
		//where Installment__c.Paid__c!=null 
		//and Opportunity__c IN: theseInstallmentOpptys.keySet()];
		
		//Get a list of all Product Processes
		//LIST<Product_Process__c> prodProc = new LIST<Product_Process__c>();
	    //for(Product_Process__c PrP:
	    //[select id, Number_of_Milestones__c, Product__c 
	    //from Product_Process__c])
	    //{
	       // prodProc.add(Prp);
	    //}
	    
	    MAP<Id, Opportunity> OpptyState = new MAP<Id, Opportunity>(); 
	    for(Opportunity thisState:theseOpportunities)
	    {
	    	OpptyState.put(thisState.Territory_State_Id__c, thisState);
	    }   
	    
	    List<Territory_State__c> allStates = 
	    [select Territory_Manager__c, DDM__c, Account_Manager__c, Regional__c, Implementation_Manager__c,
	    Implementation_Specialist__c, Website_Manager__c from Territory_State__c where Id IN: OpptyState.keySet()];
		
		//Get a list of the Opportunity Line Items/Products added to the Opportunity
		
		LIST<OpportunityLineItem> allOLIs = 
		[Select Description, IsTraining__c, ProductId__c, PricebookEntry.Name, ProdProj_Default_Owner__c, Product_Issue__c, 
	    Product_Issue2__c, Product_Issue3__c, ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, 
	    Production_Department__c, Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
	    PricebookEntryId, requiresWelcomePacket__c, TotalPrice, OpportunityId, Id, Total_List_Price__c, VS_Sale_Price__c,
	    OLI_Cost_Factor__c, PricebookEntry.Product2.Subject_to_Load__c, PricebookEntry.Product2.Project_Separation__c,
	    Project__c, PricebookEntry.Product2.Family, PricebookEntry.Product2.ProdProj_Default_Owner__c, Product_MRR__c
	    From OpportunityLineItem 
	    where OpportunityId IN: theseInstallmentOpptys.keySet()];
	    
	    
	    MAP<Id, OpportunityLineItem> OLIMap = new MAP<Id, OpportunityLineItem>();
	    
	    for (OpportunityLineItem thisOLI: allOLIs)
	    {
	    	OLIMap.put(thisOLI.ProductId__c, thisOLI);
	    }
	    
	    LIST<Product_Process__c> prodProc = [select id, Number_of_Milestones__c, Product__c from Product_Process__c where Product__c IN: OLIMap.keyset()];
	    
	        
		 
		for(Installment__c I:Trigger.new)
		{		
			//Installment__c oI = trigger.oldMap.get(I.Id);
			boolean firstPayment;
			 //if(oI.Paid__c==null&&I.Paid__c!=null)
			 if(I.Paid__c != null)
			 { 
			 	firstPayment = true;
			 }
			 else
			 {
			 	firstPayment = false;
			 }
			
			 Opportunity parentOppty = new Opportunity();
			 Territory_State__c territoryState = new Territory_State__c();
			 for(Opportunity thisOppty:theseOpportunities)
			 {
			 	if(thisOppty.Id==I.Opportunity__c)
			 	{
			 		parentOppty = thisOppty;
			 		for(Territory_State__c thisState:allStates)
					{
					 	if(thisState.Id==thisOppty.Territory_State_Id__c)
					 	{
					 		territoryState = thisState;
					 	}
					}
			 	}
			 }
			 LIST<Installment__c> relatedInstallments = new LIST<Installment__c>();
			 for(Installment__c thisPaidInstallment: paidInstallments)
			 {
			 	if(thispaidInstallment.Opportunity__c==I.Opportunity__c)
			 	{
			 		relatedInstallments.add(thisPaidInstallment);
			 	}
			 }
			 LIST<OpportunityLineItem> OLIs = new LIST<OpportunityLineItem>();
			 for(OpportunityLineItem thisOli:allOLIs)
			 {
			 	if(thisOli.OpportunityId==I.Opportunity__c)
			 	{
			 		OLIs.add(thisOli);
			 	}
			 }
			 
			 if(parentOppty.RecordTypeId == '01270000000Q9Me') {
				
				Installment.UpdateOpportunityPaidInstallments(I, firstPayment, parentOppty, relatedInstallments, OLIs, prodProc, territoryState);
			 }
		}
	}/**/
}