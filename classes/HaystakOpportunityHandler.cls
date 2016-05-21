public class HaystakOpportunityHandler extends OpportunityHandler{ 
  public override void beforeInsert(Opportunity opp){ 
      //update vAuto Account lookup if the opportunity is for vAuto      
      opp.Haystak_Opportunity_Account__c = opp.AccountId;         
  }
   
  public override void afterUpdate(Opportunity newOpp, Opportunity oldOpp){
  	  	
  	List<Opportunity> oppsToUpdate = new List<Opportunity>();
       //Check if the Opportunity is Closed Own 
       if(newOpp.StageName == 'Closed or Won' && oldOpp.StageName != 'Closed or Won'){
       newOpp=	[Select Id, Name,StageName,AccountId,Account.Name,Deal_Contact__c,
  Total_Installments_Paid__c, Territory_State_Id__c, Phased_Project__c, Description,
  Implementation_Contact__c, Project_Generated__c, Project_Exception__c, Type, Opportunity_Names__c,
  Campaign_Start_Date__c, Campaign_End_Date__c, Fulfillment_Timeline__c, Campaign_Type__c, OwnerId, Mailer_Notes__c,
  Initial_Load__c, RecordTypeId, RecordType.Name,RecordType.DeveloperName, Load_Counter__c, Confirmed__c,Contract_Generated__c
  from Opportunity where Id =: newOpp.Id];
	    oppsToUpdate.add(newOpp);
   List<OpportunityLineItem> oppLines = [Select PricebookEntry.Product2.Project_Definition__c,
	    PricebookEntry.Product2.Name,Opportunity.RecordTypeId,Opportunity.RecordType.Name, Opportunity.AccountId,Opportunity.Account.Name,
	    Description, IsTraining__c, ProductId__c, PricebookEntry.Name, ProdProj_Default_Owner__c, Product_Issue__c, 
	    Product_Issue2__c, Product_Issue3__c, ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, 
	    Production_Department__c, Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
	    PricebookEntryId, requiresWelcomePacket__c, TotalPrice, OpportunityId, Id, Total_List_Price__c, VS_Sale_Price__c,
	    OLI_Cost_Factor__c, PricebookEntry.Product2.Subject_to_Load__c, PricebookEntry.Product2.Project_Separation__c,
	    Project__c, PricebookEntry.Product2.Family, PricebookEntry.Product2.ProdProj_Default_Owner__c,
	    PricebookEntry.Product2.Base_Product__c,
                          UnitPrice,   
                          Setup_Fee__c, TNOPPST__LineTax__c, PricebookEntry.Product2.Show_on_Bill__c ,Make__c                         
	    from OpportunityLineItem where OpportunityId =: newOpp.Id];      	
	      
	     
	       //POA
	      
	      HaystakPOAHandler poaHandler = new HaystakPOAHandler(); 
	       
	      Map<String, POA__c> poaList = new Map<String, POA__c>();          
           for(OpportunityLineItem oppLine: oppLines){                                  
           poaList = poaHandler.UpsertPOA(oppLine,poaList);
           }  
         
           
            //Project
            
           if(newOpp.Project_Exception__c == false && newOpp.Project_Generated__c == false){ 
           	 Territory_State__c territotyState;
           	  /*Territory_State__c territotyState=
      			[select Territory_Manager__c, DDM__c, Account_Manager__c, Regional__c, Implementation_Manager__c,
      		    Implementation_Specialist__c, Website_Manager__c from Territory_State__c where Id =: newOpp.Territory_State_Id__c LIMIT 1];*/
       
           MAP<Id, OpportunityLineItem> productOppLineMap = new MAP<Id, OpportunityLineItem>();
      
           for (OpportunityLineItem thisOppLine: oppLines)
           { 
             productOppLineMap.put(thisOppLine.ProductId__c, thisOppLine);
           }
            LIST<Product_Process__c> prodProc = [select id, Number_of_Milestones__c, Product__c from Product_Process__c where Product__c IN: productOppLineMap.keyset()];
           new HaystakProjectHandler().GenerateProjectAndPieces(newOpp, oppLines, prodProc,territotyState,poaList);  
           newOpp.Project_Generated__c = true;
           newOpp.Confirmed__c = 'Yes';
           } 

			 //Contract
        System.debug('newOpp.Contract_Generated__c: '+newOpp.Contract_Generated__c);
			 if(newOpp.Contract_Generated__c == false){ 
           new HaystakContractHandler().createContractAndBillingItems(newOpp,oppLines,poaList); 
			 }
 update newOpp;
           }
           
          
           
       }
  }