public with sharing class contractBillingItems {
	
	
	public static void createContractAndBillingItems(Opportunity opp) {
		
		// API USER ID - 00570000001fBU9
		
		//flip the contract generated boolean on opp
		opp.Contract_Generated__c = true;
		
		//create contract
		Contract newContract = new Contract();
		
		string contractName = 'ORDER-' + opp.Opportunity_Names__c + '-' + opp.Formula_Account_Name__c + '-' + string.valueOf(system.today().format());
		
		if(contractName.length() > 80) {
			
			newContract.Name = contractName.substring(0, 80);
		}
		else {
			
			newContract.Name = contractName;
		}
		
		//newContract.Name
		
		newContract.PO__c = opp.Opportunity_ID__c;
		newContract.StartDate = system.today();
		newContract.Contract_Type__c = opp.Type;
		newContract.AccountId = opp.AccountId;
		newContract.Bill_To_Account__c = opp.AccountId;
		newContract.Salesperson__c = opp.Owner.Name;
		newContract.Related_Opportunity__c = opp.Id;
		newContract.Training_Included__c = getTrainingIncluded(opp);
		newContract.OwnerId = '00570000001fBU9';
		
		Set<Id> projIds = new Set<Id>();
		
		for(SFDC_520_Quote__c proj : [SELECT Id, Opportunity__c
									  FROM SFDC_520_Quote__c
									  WHERE Opportunity__c = :opp.Id]) {
			
			projIds.add(proj.Id);  	
		}
		
		
		Map<Id, Id> oliToProjectPieceId = new Map<Id, Id>();
		
		for(Project_Piece__c pp : [SELECT Id, Opportunity_Line_Item_ID__c
								   FROM Project_Piece__c
								   WHERE Project__c IN :projIds]) {
			
			oliToProjectPieceId.put(pp.Opportunity_Line_Item_ID__c, pp.Id);						   	
		}
		
		
		//get related Installment
		Installment__c relatedInstallment = [SELECT Id, Payment_Type__c, Payment_Information__c, LastModifiedById, Installment_Number__c
											 FROM Installment__c
											 WHERE Opportunity__c = :opp.Id
											 AND Installment_Number__c = 1];
		
		
		newContract.Payment_Method__c = relatedInstallment.Payment_Type__c;
		//newContract.Payment_Details__c = relatedInstallment.Payment_Details__c;											 
		newContract.Payment_Details__c = relatedInstallment.Payment_Information__c;
		newContract.OwnerId = relatedInstallment.LastModifiedById;
		
		insert newContract;
		
		List<OpportunityLineItem> relatedOLIs = [SELECT Id, PricebookEntry.Product2.Family, PricebookEntry.Product2.Name, 
													ProductId__c, Quantity, UnitPrice, Project__c, ProdProj_Default_Owner__c, 
													Setup_Fee__c, TNOPPST__LineTax__c, PricebookEntry.Product2.Show_on_Bill__c,
													Quantity_Exception__c
    										     FROM OpportunityLineItem 
    											 WHERE OpportunityId = :opp.Id];
    	
    	List<Billing_Item__c> newBillingItems = new List<Billing_Item__c>();
    	
    	//setup fee aggregate
    	decimal setupFee = 0;
    										 
    	for(OpportunityLineItem oli : relatedOLIs) {
    		
    		system.debug('Bazinga... oli.ProdProj_Default_Owner__c: ' + oli.ProdProj_Default_Owner__c);
    		system.debug('Bazinga... oli.TNOPPST__LineTax__c: ' + oli.TNOPPST__LineTax__c);
    		system.debug('Bazinga... oli.ProductId__c: ' + oli.ProductId__c);
    		system.debug('Bazinga... oli.UnitPrice: ' + oli.UnitPrice);
    		
    		//if(((oli.ProdProj_Default_Owner__c != null || oli.TNOPPST__LineTax__c != null) && oli.Setup_Fee__c == false && oli.PricebookEntry.Product2.Show_on_Bill__c == 'YES') || (oli.IsTraining__c == 'True')) {
    		if((oli.ProdProj_Default_Owner__c != null || oli.TNOPPST__LineTax__c != null) && oli.Setup_Fee__c == false && oli.PricebookEntry.Product2.Show_on_Bill__c == 'YES') {
    		
    		
    			system.debug('Bazinga... cb 1');
    			
	    		integer i = 1;
	    		integer limiter;
	    		
	    		if(oli.Quantity_Exception__c == 'True') {
	    			
	    			limiter = 1;
	    		}
	    		else {
	    			
	    			limiter = Math.round(oli.Quantity.intValue());
	    		}
	    		
	    		
	    		do {
	    			
	    			system.debug('Bazinga... cb 2');
		    		
		    		Billing_Item__c newBillingItem = new Billing_Item__c();
		    		
		    		//newBillingItem.CreatedById = '00570000001fBU9';
		    		
		    		newBillingItem.Product_Sold__c = oli.ProductId__c;
		    		newBillingItem.Start_Date__c = system.today();
		    		
		    		
		    		if(oli.Quantity_Exception__c == 'True') {
		    			
		    			//newBillingItem.Sale_Price__c = oli.UnitPrice * oli.Quantity;
		    			newBillingItem.Sale_Price__c = oli.UnitPrice;
		    			newBillingItem.Qty__c = oli.Quantity;
		    		}
		    		else {
		    			
		    			newBillingItem.Sale_Price__c = oli.UnitPrice;
		    			newBillingItem.Qty__c = 1;
		    		}
		    		
		    		newBillingItem.Contract__c = newContract.Id;
		    		newBillingItem.Related_Project_Piece__c = oliToProjectPieceId.get(oli.Id);
		    		
		    		newBillingItems.add(newBillingItem);
		    		
		    		i++;
		    		
		    		//create Prepaid Product BillingItem
		    		if(oli.UnitPrice > 0 && oli.PricebookEntry.Product2.Family == 'Monthly Reoccuring') {
		    			
		    			system.debug('Bazinga... cb 3');
		    			
		    			Billing_Item__c prepaidBillingItem = new Billing_Item__c();
		    			
		    			//prepaidBillingItem.CreatedById = '00570000001fBU9';
		    			
		    			prepaidBillingItem.Prepaid_Product__c = true;
		    			prepaidBillingItem.Use_Alternate_Description__c = true;
		    			prepaidBillingItem.Alternate_Product_Description__c = oli.PricebookEntry.Product2.Name + ' Advance Payment';
		    			
		    			prepaidBillingItem.Product_Sold__c = oli.ProductId__c;
			    		prepaidBillingItem.Start_Date__c = system.today();
			    		prepaidBillingItem.Qty__c = 1;
			    		prepaidBillingItem.Sale_Price__c = oli.UnitPrice;
			    		prepaidBillingItem.Contract__c = newContract.Id;
			    		prepaidBillingItem.Related_Project_Piece__c = oliToProjectPieceId.get(oli.Id);
			    		
			    		newBillingItems.add(prepaidBillingItem);
		    		}
	    		}
	    		while(i <= limiter);
    		
    		}
    		else if(oli.Setup_Fee__c == true) {
    			
    			setupFee += oli.UnitPrice * oli.Quantity;
    		}
    	}
    	
    	if(setupFee > 0) {
	    	//create setup fee billing item
	    	Billing_Item__c setupFeeBillingItem = new Billing_Item__c();
	    	
	    	//setupFeeBillingItem.CreatedById = '00570000001fBU9';
	    	
	    	setupFeeBillingItem.Start_Date__c = system.today();
	    	setupFeeBillingItem.Qty__c = 1;
	    	setupFeeBillingItem.Sale_Price__c = setupFee;
	    	setupFeeBillingItem.Contract__c = newContract.Id;
	    	setupFeeBillingItem.Product_Sold__c = [SELECT Id FROM Product2 WHERE Name = 'Account Setup' LIMIT 1].Id;
	    	
	    	newBillingItems.add(setupFeeBillingItem);
    	}
    	
    	//create Sales Tax billing item
    	//..3.18.13..commented out for later use possibly 
    	//Billing_Item__c salesTaxBillingItem = new Billing_Item__c();
    	
    	//salesTaxBillingItem.Start_Date__c = system.today();
    	//salesTaxBillingItem.Qty__c = 1;
    	//salesTaxBillingItem.Sale_Price__c = opp.TNOPPST__Sales_Tax__c;
    	//salesTaxBillingItem.Contract__c = newContract.Id;
    	//salesTaxBillingItem.Product_Sold__c = [SELECT Id FROM Product2 WHERE Name = 'Sales Tax' LIMIT 1].Id;
    	
    	//newBillingItems.add(salesTaxBillingItem);
		
		insert newBillingItems;
		
		
	}
	
	/*
	public static List<Project_Piece__c> getRelatedProjectPieces(string projId) {
		
		List<Project_Piece__c> projectPieces = [SELECT Id, Project__c
												FROM Project_Piece__c
												WHERE Project__c = :projId];
												
		return projectPieces;
	}
	*/
	
	
	public static string getTrainingIncluded(Opportunity opp) {
		
		boolean training = false;
		
		for(SFDC_520_Quote__c proj : [SELECT Id, Training_Included__c
									  FROM SFDC_520_Quote__c
									  WHERE Opportunity_Id__c = :opp.Id]) {
			
			if(proj.Training_Included__c == true) {
				
				training = true;
			}					  	
	  	}
	  	
	  	string trainingIncluded;
	  	
	  	if(training == true) {
	  		
	  		trainingIncluded = 'Yes';
	  	}
	  	else if(training == false) {
	  		
	  		trainingIncluded = 'No';
	  	}
	  	
	  	return trainingIncluded;
	}

}