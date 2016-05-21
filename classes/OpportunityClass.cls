public class OpportunityClass {
	
    //This Method is used for Cloning Demos whenever an Oppty is created or updated
    //public Opportunity oppty = new Opportunity();
    public double salesTax2 {get; set;}
        
    public static void CloneDemos(Opportunity Oppty) {   
    	
        List<Demo__c> cloneEvents = new List<Demo__c>();
        
        for(Event webexEvents : [SELECT Id, StartDateTime, OwnerId, Subject, WhatId 
                                 FROM Event 
                                 WHERE WhatId=:Oppty.Parent_Clone_ID__c 
                                 AND (NOT subject like '%Meeting%') 
                                 AND (subject like '%WebEx%')]) {
                                 	
            Demo__c D = new Demo__c();
            D.Name = 'WebEx' + ' - ' + webexEvents.StartDateTime;
            D.Webex_Event_ID__c = webexEvents.Id;
            D.Webexer__c = webexEvents.OwnerId;
            D.Opportunity__c = Oppty.Id;   
                    
            cloneEvents.add(D); 
        }   
        
        try {
        	
            insert cloneEvents;
        }
        catch(Exception Ex) {
        	
            system.debug(Ex);
        }       
    }
    
    
    //This method is used for Generating installments when an Oppty is marked "Closed or Won"
    public static void GenerateInstallments(Opportunity oppty) {     
    	
    	Hard_Coded_Ids__c hcid = Hard_Coded_Ids__c.getValues('HCIDS');
    	String hsrtid = hcid.HayStakOppRecordTypeId__c;
    	  
        integer i = 0;
        double installmentAmount = oppty.Amount / decimal.valueOf(oppty.Number_of_Installments__c);
        double numberInstallments = decimal.valueOf(oppty.Number_of_Installments__c);
        double salesTax = oppty.TNOPPST__Sales_Tax__c / decimal.valueOf(oppty.Number_of_Installments__c);
        double totalSplit = 0;
        Date installmentDue = oppty.CloseDate;      
        
        List<Installment__c> Inst = new List<Installment__c>();
        
        if(oppty.RecordTypeId == hsrtid){
        	do {
            	
                Installment__c a = new Installment__c();
                a.Installment_Number__c = i + 1;              
                a.Contact_Email__c = oppty.Deal_Contact_Email__c;
                a.Installment_Due_Date__c = installmentDue + (30 * i);
                a.Opportunity__c = oppty.id;
                a.Name = oppty.Name + ' - Installment ' + (i + 1);
                
                if(a.Name.length() > 80) {
                	
                	a.Name = a.Name.substring(0,80);
                }
                
                if(i + 1 == numberInstallments) {
                	
                    //calculate final payment to trim off division excess
                    installmentAmount = oppty.Amount - totalSplit;
                }
                
                a.Installment_Amount__c = installmentAmount;
                a.installmentAmtPlusSalesTax__c = installmentAmount + salesTax;
                Inst.add(a);
                totalSplit += installmentAmount;  
                
                i++;            
            }   
            while(i < numberInstallments);
        }
        
        if(oppty.CloseDate == system.today()) {
        	
            do {
            	
                Installment__c a = new Installment__c();
                a.Installment_Number__c = i + 1;              
                a.Contact_Email__c = oppty.Deal_Contact_Email__c;
                a.Installment_Due_Date__c = installmentDue + (30 * i);
                a.Opportunity__c = oppty.id;
                a.Name = oppty.Name + ' - Installment ' + (i + 1);
                
                if(a.Name.length() > 80) {
                	
                	a.Name = a.Name.substring(0,80);
                }
                
                if(i + 1 == numberInstallments) {
                	
                    //calculate final payment to trim off division excess
                    installmentAmount = oppty.Amount - totalSplit;
                }
                
                a.Installment_Amount__c = installmentAmount;
                a.installmentAmtPlusSalesTax__c = installmentAmount + salesTax;
                Inst.add(a);
                totalSplit += installmentAmount;  
                
                i++;            
            }   
            while(i < numberInstallments);
        }
        
        
        try { 
        	  
            insert Inst;
        }
        catch(Exception Ex) {
        	
            system.debug(ex);
        }
        
    }
    
    public static void UpdateInstallments(Opportunity oppty) {
    	
    	system.debug('Bazinga... oppty.Amount: ' + oppty.Amount);
    	system.debug('Bazinga... oppty.Number_of_Installments__c: ' + oppty.Number_of_Installments__c);
    	double installmentAmount;
    	double numberInstallments;
    	double salesTax;
    	double totalSplit;
    	Date installmentDue;
    	
        integer i = 0;
        if(oppty.Amount != null){
	        //double installmentAmount = oppty.Amount / decimal.valueOf(oppty.Number_of_Installments__c);
	        //double numberInstallments = decimal.valueOf(oppty.Number_of_Installments__c);
	        //double salesTax = oppty.TNOPPST__Sales_Tax__c / decimal.valueOf(oppty.Number_of_Installments__c);
	        //double totalSplit = 0;
	        //Date installmentDue = oppty.CloseDate;
	        installmentAmount = oppty.Amount / decimal.valueOf(oppty.Number_of_Installments__c);
	        numberInstallments = decimal.valueOf(oppty.Number_of_Installments__c);
	        salesTax = oppty.TNOPPST__Sales_Tax__c / decimal.valueOf(oppty.Number_of_Installments__c);
	        totalSplit = 0;
	        installmentDue = oppty.CloseDate;
        }      
        
        List<Installment__c> Inst = new List<Installment__c>();
    
        List<Installment__c> oldInst = [SELECT Id, Opportunity_ID__c, Opportunity__c 
        								FROM Installment__c 
        								WHERE Opportunity__c = :oppty.Id];
    
        if(oldInst != null) {
        	
            try {
            	
                delete oldInst;
            }
            catch(Exception Ex) {
            	
                system.debug(ex);
            }
        }
        
        if(oppty.CloseDate == system.today()) {
        	
            do {
            	
                Installment__c a = new Installment__c();
                a.Installment_Number__c = i + 1;              
                a.Contact_Email__c = oppty.Deal_Contact_Email__c;
                a.Installment_Due_Date__c = installmentDue + (30 * i);
                a.Opportunity__c = oppty.id;
                a.Name = oppty.Name + ' - Installment ' + (i + 1);
                
                if(a.Name.length() > 80) {
                	
                	a.Name = a.Name.substring(0,80);
                }
                
                if(i + 1 == numberInstallments) {
                	
                    //calculate final payment to trim off division excess
                    installmentAmount = oppty.Amount - totalSplit;
                }
                
                a.Installment_Amount__c = installmentAmount;
               	a.installmentAmtPlusSalesTax__c = installmentAmount + salesTax;
                Inst.add(a);
                totalSplit += installmentAmount;  
                
                i++;            
            }   
            while(i < numberInstallments);
        }
        
        try {  
        	 
            insert Inst;
        }
        catch(Exception Ex) {
        	
            system.debug(ex);
        }
    }
    //method that updated freight charges in whenever the opportunity is updated 
    public static void UpdateInvoiceTotal(Opportunity opp) {
    	
    	double totalFreight = 0;
    	double totalAmount = 0; 
    	//double salesTax2 = opp.TNOPPST__Sales_Tax__c/decimal.valueOf(opp.Number_of_Installments__c); 
    	
    	List<OpportunityLineItem> theseOLIs = [SELECT Id, OpportunityId, Quantity, Freight_Cost__c 
											   FROM OpportunityLineItem 
											   WHERE OpportunityId = :opp.Id];
    	
    	for(OpportunityLineItem thisOLI : theseOLIs) {
    		
            totalFreight += thisOLI.Freight_Cost__c;
        }
        
        opp.Freight_Cost__c = totalFreight;
        
        //update opp;
    	
    }
    
   	public static void UpdateInitialWebexCompleteDate(Opportunity opp) {
    	
    	if(opp.StageName == 'Webex Complete') {
    		
    		opp.Initial_Webex_Completed__c = system.today();
    	}
    	/*if(opp.StageName == 'Second WX Complete'){
    		
    		opp.Last_Completed_Webex_Date__c = system.today();
    	}*/
    }
    
    public static void UpdateInvoiceInformation(Opportunity O) {
    	
        //class updates Freight Cost and invoice total for invoice generation.
        
        double totalFreight = 0;
        double totalInstallment = 0;
        
        List<OpportunityLineItem> theseOLIs = [SELECT Id, OpportunityId, Quantity, Freight_Cost__c 
    										   FROM OpportunityLineItem 
    										   WHERE OpportunityId = :O.Id];
        
        for(OpportunityLineItem thisOLI : theseOLIs) {
        	
            totalFreight += thisOLI.Freight_Cost__c;
        }
        
        O.Freight_Cost__c = totalFreight;
        
        List<Installment__c> theseInstallments = [SELECT ID, Opportunity__c, Installment_Amount__c, Installment_Number__c, Paid2__c, installmentAmtPlusSalesTax__c 
            									  FROM Installment__c 
            									  WHERE Opportunity__c = :O.Id 
            									  ORDER BY Installment_Number__c DESC];           
        
        if(Double.valueOf(O.Number_of_Installments__c) > 1) {
            
            double lowestUnpaidFound = Double.valueOf(O.Number_of_Installments__c) + 1;
                
            for(Installment__c thisInstallment : theseInstallments) {
                
                //this Installment loop finds the lowest unpaid installment and puts it as the AMOUNT DUE NOW
                if(thisInstallment.Paid2__c == null && thisInstallment.Installment_Number__c <= lowestUnpaidFound) {
                    
                    totalInstallment = thisInstallment.Installment_Amount__c;
                    lowestUnpaidFound = thisInstallment.Installment_Number__c;              
                }
                
                system.debug('Installment Number: ' + thisInstallment.Installment_Number__c);
                system.debug('Lowest Unpaid Found: ' + lowestUnpaidFound);
                system.debug('totalInstallmentPaid: '+ totalInstallment);                           
            }
        }
        else {
        	
            for(Installment__c thisInstallment : theseInstallments) {
            	
                if(thisInstallment.Installment_Number__c == 1) {
                	
                    totalInstallment = thisInstallment.Installment_Amount__c;               
                }               
            }           
        }   
        
        O.Invoice_Total__c = (totalFreight + totalInstallment);
        O.Invoice_Generated__c = true;
        
        update O;
    }  
    
    public static void checkRelatedProducts(Opportunity O) {
    		
        List<Id> ListOfRelatedProductIds = new List<Id>();
        
        MAP<Id, OpportunityLineItem> mapOfAllProductIds = new MAP<Id, OpportunityLineItem>();
    
        List<OpportunityLineItem> theseOLIs = [SELECT Id, Related_ProductId__c, ProductId__c, OpportunityId, Override_Related_Product__c 
    										   FROM OpportunityLineItem 
    										   WHERE OpportunityId = :O.Id];
        
        for(OpportunityLineItem thisOLI : theseOLIs) {
        	
            system.debug('OLI ID: ' + thisOLI.Id);
            
            if(thisOLI.Related_ProductId__c != null && thisOLI.Override_Related_Product__c != true) {
            	
            	listOfRelatedProductIds.add(thisOLI.Related_ProductId__c);
            }
                       
            mapOfAllProductIds.put(thisOLI.ProductId__c, thisOLI);          
        }
        
        for(Id thisRelatedId : ListOfRelatedProductIds) {
        	           
            if(mapOfAllProductIds.get(thisRelatedId) == null) {
            	               
                Product2 errorProduct = [SELECT Id, Name 
                						 FROM Product2 
                						 WHERE Id = :thisRelatedId 
                						 limit 1];              
                
                O.addError('Opportunity has a product on it that has a REQUIRED RELATED PRODUCT.  Product Name Required:  ' + errorProduct.Name);
            }
        }
    }
}