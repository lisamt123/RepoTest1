public with sharing class OpportunityPopupController {
        
    //setup public getters/setters
    public Id Id {get;set;}
    public Opportunity thisOpp {get;set;}
    public Account thisAccount {get;set;}
    public String oppStatus {get;set;}
    public boolean showPopupDataIntegration {get;set;}
    public boolean showPopupInactiveProducts {get;set;}
    public boolean showAgain {get;set;}
    public LIST<OpportunityLineItem> theseOLIs {get;set;}
	        
        
    public OpportunityPopupController(ApexPages.Standardcontroller controller) {
                
    	Opportunity tempOpp = (Opportunity)controller.getRecord();
        
        if(tempOpp != null) { 
    		
    		Id = tempOpp.Id;
        }
        
        init();
    }

    public void init() {  
    	           
    	if(Id == null) { 
			setId();
    	}
    	
        setThisOpp();
        setThisAccount();
        setTheseOLIs();         
        setOppStatus();
        setShowPopupDataIntegration();
        setShowPopupInactiveProducts();
    }
    
    public pageReference updateOppToNoShow() {
            
    	thisOpp.Phased_Project__c = true;
        update thisOpp;
        
        PageReference thisPage = new PageReference('/' + id);           
        return thisPage;
    }
        
    public void setTheseOLIs() {
        
        theseOLIs = [SELECT Id, PricebookEntry.Name, OpportunityId, Active_Product__c 
                     FROM OpportunityLineItem 
                     WHERE OpportunityId = :Id];
    }
    
    public void setId() {
        
        Id = Apexpages.currentPage().getParameters().get('id');
    }
    
    public Id getId() {
        
        return Id;
    }       
    
    public void setThisOpp() {
            
        thisOpp = [SELECT Id, StageName, AccountId, Inactive_Product_Override__c, PAID__c, Paid_Date__c, IsWon
        		   FROM Opportunity 
        		   WHERE Id = :Id 
        		   limit 1]; 
    }
    
    public Opportunity getThisOpp() {                
        
        return thisOpp;
    }   
        
    public void setThisAccount() {
        
        thisAccount = [SELECT Id, DMS_System__c 
    				   FROM Account 
    				   WHERE Id = :thisOpp.AccountId limit 1];
    }
    
    public Account getThisAccount() {
        
        return thisAccount;
    }
    
    public void setOppStatus() {
        
        oppStatus = thisOpp.StageName;
    }
    
    public String getOppStatus() {
        return oppStatus;
    }
    
    public void setShowPopupDataIntegration() {
    	
    	boolean overrideShow = false;
    	            
        if(thisOpp.StageName != 'Closed or Won') {
        	
        	for(OpportunityLineItem thisOLI : theseOLIs) {
                    
            	system.debug('OLI ' + thisOLI.PricebookEntry.Name);
            	
                if(thisOLI.PricebookEntry.Name.contains('ILM') || thisOLI.PricebookEntry.Name.contains('CRM') || 
                   thisOLI.PricebookEntry.Name.contains('Inventory Module') || thisOLI.PricebookEntry.Name.contains('Inventory Light')) {
                   	                               
                	showPopupDataIntegration = true;                               
                }
                        
            	if(thisOLI.PricebookEntry.Name.contains('Data Integration')) {
            		
                	overrideShow = true;
                }                               
             }                       
        }
    	
    	if(overrideShow == true) { 
			
			showPopupDataIntegration = false;
    	}
    }
        
    public boolean getShowPopupDateIntegration() {
    	
    	return showPopupDataIntegration;
    }
        
    public void setShowPopupInactiveProducts() {
    	        	
		if((thisOpp.IsWon == false && thisOpp.Inactive_Product_Override__c != true) || 
		   (thisOpp.PAID__c != 'Yes' && thisOpp.IsWon == true && thisOpp.Inactive_Product_Override__c != true) ||
		   (thisOpp.PAID__c == 'Yes' && thisOpp.IsWon == true && (system.today().addDays(-7) < thisOpp.Paid_Date__c) && thisOpp.Inactive_Product_Override__c != true)) {
			
			for(OpportunityLineItem thisOLI: theseOLIs) {
				
				system.debug('OLI ' + thisOLI.Active_Product__c);
				
    			if(thisOLI.Active_Product__c == 'FALSE') {
    				
					showPopupInactiveProducts = true;
    			}
    		}
    	}
    }
        
    public boolean getShowPopupInactiveProducts() {
    	
    	return showPopupInactiveProducts;
    }
        

        
}