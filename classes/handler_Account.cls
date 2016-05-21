public with sharing class handler_Account {
    
    /*
    public static void updateSpotLightNotes(List<Account> accounts) {
        
        for(Account a : accounts) {
            
            if(a.Spotlight_Notes__c != null && a.Spotlight_Notes__c != '') {
                
                a.Spotlight_Notes_Populated__c = true;
            }
            else {
                
                a.Spotlight_Notes_Populated__c = false; 
            }
        }
    }
    */
    
    //09/05/2014: Ramana/Mark this code can be ignored; since territory state is not something we are moving away from.    
    public static void setTerritoryState(list<Account> accts) {
        
        list<String> billingStates = new list<String>();
        
        list<Account> accountsToUpdate = new list<Account>();
        
        for(Account acct : accts) {
            system.debug('SFDCTEST:acct.BillingState:'+acct.BillingState);
            /*if(acct.Territory_State__c == null) {
                
                billingStates.add(acct.BillingState);
                accountsToUpdate.add(acct);
            }*/
        }

        system.debug('SFDCTEST:accountsToUpdate.size():'+accountsToUpdate.size());
        if(accountsToUpdate.size() > 0) {
            
           /* Map<String, Territory_State__c> TSmap = new Map<String, Territory_State__c>();
                                                                                 
            for(Territory_State__c ts : [SELECT Id, Name
                                         FROM Territory_State__c
                                         WHERE Name IN :billingStates]) {
                                            
                TSmap.put(ts.Name.toLowerCase(), ts);                       
                system.debug('SFDCTEST:ts.Name.toLowerCase():'+ts.Name.toLowerCase()+'ts:'+ ts);                       
            }
                                                                                 
            for(Account a : accountsToUpdate) {
                system.debug('SFDCTEST: a.BillingState'+ a.BillingState);
                system.debug('SFDCTEST: TSmap'+TSmap);
                system.debug('SFDCTEST: TSmap.get:'+ TSmap.get(a.BillingState.toLowerCase()));
                if (!TSmap.isEmpty())
                    a.Territory_State__c = TSmap.get(a.BillingState.toLowerCase()).Id;  
            }   */
        }
    }
    
    
    public static void setWAMsetDDMsetVinPro(list<Account> accts) {
        
        list<String> billingStates = new list<String>(); 
        
        list<Account> accountsToUpdate = new list<Account>();
        
        for(Account acct : accts) {
            
            //setOwnersetTerritoryState
            //if(acct.BillingState != null && (acct.Territory_State__r.Name != acct.BillingState)) {
                
            //    billingStates.add(acct.BillingState);
            //    accountsToUpdate.add(acct);
            //}
            
            /*setDDM
            if(!acct.DDM_Override__c) {
                
                billingStates.add(acct.BillingState);
                accountsToUpdate.add(acct);
            }*/
            
            //setWam
            if(!acct.WAM_Override__c) {
                
                billingStates.add(acct.BillingState);
                accountsToUpdate.add(acct);
            }
            
            //setVinPro
            /*if(!acct.VinPro_Override__c) {
                
                billingStates.add(acct.BillingState);
                accountsToUpdate.add(acct);
            }*/
        }
        
        if(accountsToUpdate.size() > 0) {
            
            Map<String, Territory_State__c> TSmap = new Map<String, Territory_State__c>();
                                                                                 
            for(Territory_State__c ts : [SELECT Id, Name, Website_AM__c, Account_Manager__c, Regional__c
                                         FROM Territory_State__c
                                         WHERE Name IN :billingStates]) {
                                            
                TSmap.put(ts.Name.toLowerCase(), ts);                       
            }
                                                                                 
            for(Account a : accountsToUpdate) {
                
                try {
                
                    if(a.BillingState != null && (a.Territory_State__r.Name != a.BillingState.toLowerCase())) {
                        
                        /*a.Territory_State__c = TSmap.get(a.BillingState.toLowerCase()).Id;*/
                        
                        if(TSmap.get(a.BillingState.toLowerCase()).Regional__c != null) {
                            
                            a.OwnerId = TSmap.get(a.BillingState.toLowerCase()).Regional__c;
                        }
                    }
                    
                    /*if(!a.DDM_Override__c) {
                        
                        a.DDM2__c = TSmap.get(a.BillingState.toLowerCase()).DDM__c;
                    }*/
                    
                    if(!a.WAM_Override__c) {
                        
                        a.WAM2__c = TSmap.get(a.BillingState.toLowerCase()).Website_AM__c;
                    }
                    
                    /*if(!a.VinPro_Override__c) {
                        
                        a.VinPro2__c = TSmap.get(a.BillingState.toLowerCase()).Account_Manager__c;
                    }*/
                
                }
                catch(Exception e) {
                    UtilityClass.DebugException(e);
                    string message = 'There has been an error in the setWAMsetDDMsetVinPro method related to Account: ' + a.Id + '. This account needs a Territory State in order to perform this method. Error: ' + e;

                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'paul.duryee@vinsolutions.com'};
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('Account Error');
                    mail.setPlainTextBody(message);
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail }); 
                }
            }
        }
    }
}