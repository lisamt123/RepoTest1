trigger OpportunityTriggers on Opportunity (after delete, after insert, after undelete, after update, before delete, before insert, before update) {
    
    //Ramana: Commented out for refactoring.
return;
    //system.debug('Bazinga... Optimize.. OpportunityTriggers.trigger');
    /*  
    //Before Insert
    if(trigger.isBefore && trigger.isInsert) {
            
        for(Opportunity opp: Trigger.new){
            
            //Totals up freight cost from all related OLIs 
            OpportunityClass.UpdateInvoiceTotal(opp);
        }
        
        ///Mark the Opportunity as being cloned with Products if applicable
        MAP<Id, Id> theseOpptys = new MAP<Id, Id>();
        
        for(Opportunity O : trigger.new) {
            
            theseOpptys.put(O.Id, null);            
        }
        
        List<OpportunityLineItem> theseOLIs = [SELECT Id 
                                               FROM OpportunityLineItem 
                                               WHERE Id IN :theseOpptys.keySet()];
            
        for(Opportunity O : trigger.new) {
            
            for(OpportunityLineItem thisOLI : theseOLIs) {
                
                if(O.Id == thisOli.OpportunityId) {
                    
                    O.Cloned_with_Products__c = true;
                }
            }
            
            O.Phased_Project__c = false;
            system.debug('PHASED PROJECT ' + O.Phased_Project__c);
            O.Project_Generated__c = false;
            system.debug('PROJECT GENERATED ' + O.Project_Generated__c);
            O.Project_Exception__c = false;
            O.InstallmentsGenerated__c = false;
            system.debug('INSTALLMENTS GENERATED ' + O.InstallmentsGenerated__c);
            O.Invoice_Total__c = 0;
            system.debug('INVOICE TOTAL ' + O.Invoice_Total__c);
            O.Multi_Installments_Approved__c = false;
            O.Stage_Type__c = null;
        }                                           
            
        //Create Maps of the Opportunities, Owners, and the Salespeople
        MAP<ID, Opportunity> theseOpportunitiesAccountIds = new MAP<ID, Opportunity>();
        MAP<ID, Opportunity> theseOpptyOwners = new MAP<ID, Opportunity>();
        MAP<ID, Opportunity> theseOpptySalespeople = new MAP<ID, Opportunity>();
        
        for(Opportunity T:Trigger.new) {
            
            theseOpportunitiesAccountIds.put(T.AccountId, T);
            theseOpptyOwners.put(T.OwnerId, T);
            theseOpptySalespeople.put(T.Salesperson__c, T);
        }
        
        List<Account> theseAccounts = [SELECT Id, Territory_State__r.Regional__c 
                                       FROM Account 
                                       WHERE Id IN :theseOpportunitiesAccountIds.keySet()];
        
        List<User> ownerList = [SELECT Id, UserRole.Name, UserRoleId 
                                FROM User 
                                WHERE Id IN :theseOpptyOwners.keySet() 
                                OR Id = :userinfo.getUserId()];
        
        LIST<User> theseUsers = [SELECT Id, UserRoleId 
                                 FROM User 
                                 WHERE Id = :userinfo.getUserId()];
        
        LIST<Opportunity> theseOpenOpportunities = [SELECT Id, Opportunity_Names__c, StageName, AccountId, Multiple_Opportunity_Override__c 
                                                    FROM Opportunity
                                                    WHERE AccountId IN :theseOpportunitiesAccountIds.keyset() 
                                                    AND (Opportunity_Names__c != 'Fulfillment' 
                                                    AND Opportunity_Names__c != 'Hardware' 
                                                    AND Opportunity_Names__c != 'Printed Materials') 
                                                    AND IsClosed = False 
                                                    AND Multiple_Opportunity_Override__c != true];
            
        for(Opportunity O : trigger.new) {
                
            //Limits the user from creating multiple opportunities per account
            if(theseOpenOpportunities.size() != 0 && O.Opportunity_Names__c != 'Fulfillment' && 
                O.Opportunity_Names__c != 'Hardware' && O.Opportunity_Names__c != 'Printed Materials') {
                
                O.addError('There is already an opportunity open for this account.  Please see a manager if you need this error to be overriden');
            }
            
            for(User thisUser : theseUsers) {
                
                if(O.AccountId != null && thisUser.id == userinfo.getUserId()) {
                    
                    //Run through the list of accounts
                    for(Account Acct : theseAccounts) {
                        
                        //Set the Opportunity owner to match the Regional based on the Account Territory State if role = Keens Team
                        if(Acct.Territory_State__r.Regional__c != null && Acct.Id == O.AccountId && thisUser.UserRoleId == '00E70000000xk01') {
                            
                            O.OwnerId = Acct.Territory_State__r.Regional__c;
                        }                           
                    }
                }       
            }
                
            //Set the Salesperson to the user inserting the Opportunity
            O.Salesperson__c = userinfo.getUserId();
            
            if(O.OwnerId != null) {
                    
                //Run through the list of owners to find the matching Oppty Owner
                for(User Owner : ownerList) {       
                    
                    //populate the proper Owner Role
                    if(Owner.Id == O.OwnerId) {
                        
                        O.Owner_Role__c = Owner.UserRole.Name;
                    }   
                }               
            }
                
            if(O.Salesperson__c != null) {          
                    
                //Run through the list of owners to find the matching Salesperson
                for(User Owner : ownerList) {
                    
                    //populate the proper Salesperson Role
                    if(Owner.Id == O.Salesperson__c) {
                        
                        O.Salesperson_Role__c = Owner.UserRole.Name;
                    }                   
                }
            }   
                
            //Set the account type to customer check
            AccountisCustomer.updateAccountType(O);
        }
    }
    */
    /*  
    //Before Update
    if(trigger.isBefore && trigger.isUpdate) {
        
        system.debug('Bazinga... opp update: ' + Limits.getQueries());
        
        //trying this here
        for(Opportunity opp : trigger.new) {
            
            OpportunityClass.UpdateInvoiceTotal(opp); //1 
            OpportunityClass.UpdateInitialWebexCompleteDate(opp);
        }
        
        
        //Map out the Opportunity IDs, Owner IDs, and Salespeople IDs from all the contacts being updated
        boolean updateOwnerSalesperson = false;
            
        MAP<ID, Opportunity> theseOpptyOwners = new MAP<ID, Opportunity>();
        MAP<ID, Opportunity> theseOpptySalespeople = new MAP<ID, Opportunity>();
        
        for(Opportunity T : trigger.new) {
            
            theseOpptyOwners.put(T.OwnerId, T);
            theseOpptySalespeople.put(T.Salesperson__c, T);
            
            Opportunity OT = trigger.oldMap.get(T.Id);
            
            if(T.OwnerId != OT.OwnerId || T.Salesperson__c != OT.Salesperson__c) {
                
                updateOwnerSalesperson = true;
            }
        }
        
        
        LIST<User> ownerList = new LIST<User>();
            
        if(updateOwnerSalesperson) {
            
            ownerList = [SELECT Id, UserRole.Name, UserRoleId 
                         FROM User 
                         WHERE Id IN :theseOpptyOwners.keySet() 
                         OR Id IN :theseOpptySalespeople.keySet()];
        }
            
                
        MAP<Id, Opportunity> theseUpdateOpptys = new MAP<Id, Opportunity>();
            
        for(Opportunity oppty : trigger.new) {
            
            Opportunity oldOppty = trigger.oldMap.get(oppty.Id);
        
            theseUpdateOpptys.put(oldOppty.Id, oldOppty);
            
            List<OpportunityLineItem> theseOLIs = [SELECT Id, Solution_Product__c, Active_Product__c 
                                                   FROM OpportunityLineItem 
                                                   WHERE OpportunityId IN :theseUpdateOpptys.keySet()];
            
            for(OpportunityLineItem thisOLI : theseOLIs) {
                
                system.debug('SOLUTIONPRODUCT = ' + thisOLI.Solution_Product__c);
                
                //determine if the opportunity to be markd as Phased Project true
                if(thisOli.Solution_Product__c == true && (oppty.StageName == 'Closed or Won' && oldOppty.StageName != 'Closed or Won')) {
                        
                    oppty.Phased_Project__c = true;
                }
            }
        }
        
        //1

        for(Opportunity O : trigger.new) {
            
            Opportunity oldO = trigger.oldMap.get(O.Id);
        
            if(oldO.OwnerId != null && (oldO.OwnerId != O.OwnerId) || (O.OwnerId != null && O.Owner_Role__c == null)) {
                    
                for(User Owner : ownerList) {
                            
                    if(Owner.Id == O.OwnerId) {
                        
                        O.Owner_Role__c = Owner.UserRole.Name;
                    }   
                }               
            }
        
            if(oldO.Salesperson__c != O.Salesperson__c || (O.Salesperson__c != null && O.Salesperson_Role__c == null)) {
                                
                for(User Owner : ownerList) {
                    
                    if(Owner.Id == O.Salesperson__c) {
                        
                        O.Salesperson_Role__c = Owner.UserRole.Name;
                    }                   
                }
            }
            
            if(oldO.StageName != 'Closed or Won' && O.StageName == 'Closed or Won') {
                
                //1
                
                AccountisCustomer.updateAccountType(O);
                
                //1
                
                if(O.Override_Related_Product__c != true) {
                    
                    OpportunityClass.checkRelatedProducts(O);   
                }
            }
        
            if(oldO.InstallmentsGenerated__c == false && ((O.Number_of_Installments__c != null && 
                O.StageName == 'Closed or Won' && oldO.StageName != 'Closed or Won') || 
                (O.Number_of_Installments__c != null && oldO.Number_of_Installments__c == null && O.StageName == 'Closed or Won'))) {
                
                O.InstallmentsGenerated__c = true;
            }
        }
        
        //12 //4
        
        system.debug('Bazinga... opp update 2: ' + Limits.getQueries());
    }
    */
    /*
    if(trigger.isBefore && trigger.isDelete) {
        
        for(Opportunity Oppty : trigger.old) {
            
            //Prevent Opportunities from being deleted if there is a project associated to the Opportunity
            integer remainingProjects = [SELECT count() 
                                         FROM SFDC_520_Quote__c 
                                         WHERE Opportunity__c = :Oppty.Id];
            
            if(remainingProjects > 0) {
                
                Oppty.addError('An Opportunity cannot be deleted without first deleting the related Projects.');
            }
        }
    }
    */
//++++++++++++++++++++++++++++++++++++++++++++++AFTER++++++++++++++++++++++++++++++++++++++++++++++
    /*
    if(trigger.isAfter && trigger.isInsert) {
            
        for(Opportunity O: Trigger.new) {
            
            if(O.Parent_Clone_ID__c!=null&&O.Parent_Clone_ID__c!=O.id) {
                //Creates and Inserts a new Demo using information from
                //.. the Opportunities related Event.
                OpportunityClass.CloneDemos(O);
                LIST<Installment__c> theseInstallments = [select Id, Opportunity__c from Installment__c where Opportunity__c =: O.Id];
                delete theseInstallments;   
            }
            
                
            if(O.Number_of_Installments__c!=null&& O.Amount != null) {  
                //Generate Installments if opp is marked closed or won..
                OpportunityClass.GenerateInstallments(O);
            }
        }
    }
    */
    /*
    if(trigger.isAfter && trigger.isUpdate) {   
            
        //Check to see if installments should be generated and if so, check the "Installments Generated" box
        //after the update, generate the installments
        //Also updates the opportunity field Phased Project if one it's products is a
        //SOLUTION PRODUCT
        for(Opportunity oppty : trigger.new) {  
            
            Opportunity oldOppty = trigger.oldMap.get(oppty.Id);
            
            if(oldOppty.InstallmentsGenerated__c == false && ((oppty.Number_of_Installments__c != null && 
                oppty.StageName=='Closed or Won' && oldOppty.StageName != 'Closed or Won') || 
                (oppty.Number_of_Installments__c != null && oldOppty.Number_of_Installments__c == null && oppty.StageName == 'Closed or Won'))) {
                                            
                OpportunityClass.UpdateInstallments(oppty);             
            }                                                           
            
            if((oldOppty.PAID__c == null || oldOppty.PAID__c == 'No') && oldOppty.InstallmentsGenerated__c == true &&
                ((oppty.Number_of_Installments__c != null && oppty.StageName == 'Closed or Won' && oldOppty.StageName != 'Closed or Won') || 
                (oppty.Number_of_Installments__c != null && oldOppty.Number_of_Installments__c == null && oppty.StageName == 'Closed or Won'))) {
                
                OpportunityClass.UpdateInstallments(oppty);             
            }
            
            if(oldOppty.InstallmentsGenerated__c != false && oldOppty.StageName != 'Closed or Lost' && oppty.StageName == 'Closed or Lost') {
                
                LIST<Installment__c> theseInstallments = [select Id, Opportunity__c from Installment__c where Opportunity__c =: oppty.Id];
                delete theseInstallments;                       
            }
            
            if(oldOppty.InstallmentsGenerated__c != false && oldOppty.StageName == 'Closed or Won' && oppty.StageName != 'Closed or Won' && 
                (oppty.PAID__c == null || oppty.PAID__c == 'No')) {
                
                LIST<Installment__c> theseInstallments = [select Id, Opportunity__c from Installment__c where Opportunity__c =: oppty.Id];
                delete theseInstallments;                       
            }
        }
        
        //6                     
    }
    */
}