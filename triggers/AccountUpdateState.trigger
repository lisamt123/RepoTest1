trigger AccountUpdateState on Account (before update, before insert) {

    system.debug('Bazinga... Optimize.. AccountUpdateState.trigger');
    
    
     //09/05/2014: Ramana/Mark this code can be ignored; since territory state is not something we are moving away from.  
     //Confirmed by Mark; so we don't need this
        // method to populate territory state    
    //handler_Account.setTerritoryState(trigger.new);
    
  //09/05/2014: Ramana/Mark this code can be ignored; since territory state is not something we are moving away from.  
 //Confirmed by Mark; so we don't need this
    //handler_Account.setWAMsetDDMsetVinPro(trigger.new); 


	//09/05/2014: Ramana/Mark: these can be done in validation rules; will take out this once the validation is in place.
	//Built using Validation rule; we don't need this
	/*     
    for(Account A : trigger.new) {
        
        if(trigger.isInsert) {
            
            if(A.BillingStreet == null || A.BillingState == null || A.BillingPostalCode == null || A.BillingCity == null) {
                
                A.adderror('Billing Address must be filled out to save record');    
            }
        }
    }
    */
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    
    MAP<Id, Territory_State__c> TSmap = new MAP<Id, Territory_State__c>([SELECT Id, Name, Website_AM__c, DDM__c, Account_Manager__c, Regional__c FROM Territory_State__c]); //1
    
    
    for(Account A : trigger.new) {
            
        if(A.BillingState != null && A.Territory_State__r.Name != A.BillingState) {            
                
            for(Id TS : TSmap.keySet()) {
                
                if(A.BillingState == TSmap.get(TS).name) {
                    
                    A.Territory_State__c = TS;
                            
                    if(TSmap.get(TS).Regional__c != null) {
                        
                        A.OwnerId = TSmap.get(TS).Regional__c;
                    }
                }
            }
        }
          //
        if(trigger.isInsert) {
            
            if(A.BillingStreet == null || A.BillingState == null || A.BillingPostalCode == null || A.BillingCity == null) {
                
                A.adderror('Billing Address must be filled out to save record');    
            }
        }
    }
    
    
    Accounts.setWAM(trigger.new, TSmap.values());
    
    Accounts.setDDM(trigger.new, TSmap.values()); 
    
    Accounts.setVinPro(trigger.new, TSmap.values()); 
    */
}