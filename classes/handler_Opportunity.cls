public with sharing class handler_Opportunity {
    
    // AFTER UPDATE
    public static void afterUpdate(List<Opportunity> opps, Map<Id, Opportunity> oldMap) {
        
        checkToUpdateInstallments(opps, oldMap);
        checkToDeleteInstallments(opps, oldMap);
    }
    
    // AFTER INSERT
    public static void afterInsert(List<Opportunity> opps) {
        
        cloneDemos(opps);
        deleteRelatedInstallments(opps);
        checkToGenerateInstallments(opps);
    }
    
    // BEFORE DELETE
    public static void beforeDelete(List<Opportunity> oldOpps) {
        
        checkIfProjectsExistBeforeDelete(oldOpps);
    }
    
    // BEFORE UPDATE
    public static void beforeUpdate(List<Opportunity> opps, Set<Id> oppIds, Map<Id, Opportunity> oldMap) {
        
        Map<Id, List<OpportunityLineItem>> oppMap = new Map<Id, List<OpportunityLineItem>>();
        
        for(OpportunityLineItem oli : [SELECT Id, OpportunityId, Quantity, Freight_Cost__c, Related_ProductId__c, ProductId__c,
                                            Override_Related_Product__c, Solution_Product__c
                                       FROM OpportunityLineItem
                                       WHERE OpportunityId IN :oppIds]) {
                                        
            if(oppMap.containsKey(oli.OpportunityId)) {
                
                oppMap.get(oli.OpportunityId).add(oli);
            } 
            else {
                
                oppMap.put(oli.OpportunityId, new List<OpportunityLineItem>{oli});
            }                               
        }
        
        UpdateInvoiceTotal(oppMap, opps);
        //UpdateInitialWebexCompleteDate(opps);
        updatePhasedProject(oppMap, opps, oldMap);
        updateOwnerRoleSalespersonRole(opps, oldMap);
        checkIfUpdateAccountTypeAndCheckRelatedProducts(opps, oppMap, oldMap);
        checkInstallmentsGenerated(opps, oldMap);
        checkToCreateContractBillingItems(opps);
    }
    
    
    // BEFORE INSERT
    public static void beforeInsert(List<Opportunity> opps) {
        
        Set<Id> oppIds = new Set<Id>();
        
        for(Opportunity opp : opps) {
            
            oppIds.add(opp.Id);
        }
        
        system.debug('Bazinga.... Bazinga2');
        
        Map<Id, List<OpportunityLineItem>> oppMap = new Map<Id, List<OpportunityLineItem>>();
        
        for(OpportunityLineItem oli : [SELECT Id, OpportunityId, Quantity, Freight_Cost__c, Related_ProductId__c, ProductId__c,
                                            Override_Related_Product__c, Solution_Product__c
                                       FROM OpportunityLineItem
                                       WHERE OpportunityId IN :oppIds]) {
                                        
            if(oppMap.containsKey(oli.OpportunityId)) {
                
                oppMap.get(oli.OpportunityId).add(oli);
            }
            else {
                
                oppMap.put(oli.OpportunityId, new List<OpportunityLineItem>{oli});
            }                               
        }
        
        UpdateInvoiceTotal(oppMap, opps); //
        UpdateClonedWithProducts(oppMap, opps); //
        OneOpportunityPerAccount(opps);
        setRegionalOwner(opps);
        updateAccountType(opps);
        checkToCreateContractBillingItems(opps);
    }
    
    //Contract Management Method
    public static void checkToCreateContractBillingItems(List<Opportunity> opps) {
        
        //Datetime hardCodedPaidDate = datetime.newInstance(2013, 05, 31);
        
        for(Opportunity opp : opps) {
            
            //if(opp.StageName == 'Closed or Won' && opp.PAID__c == 'Yes' && opp.Contract_Generated__c == false && opp.Paid_Date__c > hardCodedPaidDate) {
            //if(opp.StageName == 'Closed or Won' && opp.Confirmed__c == 'Yes' && opp.Contract_Generated__c == false && opp.Paid_Date__c > hardCodedPaidDate) {
            if(opp.StageName == 'Closed or Won' && opp.Confirmed__c == 'Yes' && opp.Contract_Generated__c == false) {
                
                contractBillingItems.createContractAndBillingItems(opp);
            }
        }
    } 
    
    public static void checkToDeleteInstallments(List<Opportunity> opps, Map<Id, Opportunity> oldMap) {
        
        Set<Id> oppIds = new Set<Id>();
        
        for(Opportunity opp : opps) {
            
            if(oldMap.get(opp.Id).InstallmentsGenerated__c != false && oldMap.get(opp.Id).StageName != 'Closed or Lost' && opp.StageName == 'Closed or Lost') {
                
                oppIds.add(opp.Id);
            }
            
            //if(oldMap.get(opp.Id).InstallmentsGenerated__c != false && oldMap.get(opp.Id).StageName == 'Closed or Won' && opp.StageName != 'Closed or Won' && (opp.PAID__c == null || opp.PAID__c == 'No')) {
            if(oldMap.get(opp.Id).InstallmentsGenerated__c != false && oldMap.get(opp.Id).StageName == 'Closed or Won' && opp.StageName != 'Closed or Won' && (opp.Confirmed__c == null || opp.Confirmed__c == 'No')) {
            
                oppIds.add(opp.Id);     
            }
        }
        
        if(oppIds.size() > 0) {
            
            List<Installment__c> deleteInstallments = [SELECT Id 
                                                       FROM Installment__c 
                                                       WHERE Opportunity__c IN :oppIds];
                                                       
            if(deleteInstallments.size() > 0) {
                
                delete deleteInstallments;
            }
        }
    }
    
    public static void checkToUpdateInstallments(List<Opportunity> opps, Map<Id, Opportunity> oldMap) {
        
        for(Opportunity opp : opps) {
            
            if(oldMap.get(opp.Id).InstallmentsGenerated__c == false && ((opp.Number_of_Installments__c != null && 
                opp.StageName=='Closed or Won' && oldMap.get(opp.Id).StageName != 'Closed or Won') || 
                (opp.Number_of_Installments__c != null && oldMap.get(opp.Id).Number_of_Installments__c == null && opp.StageName == 'Closed or Won'))) {
                                            
                OpportunityClass.UpdateInstallments(opp);               
            }                                                           
            
            /*
            if((oldMap.get(opp.Id).PAID__c == null || oldMap.get(opp.Id).PAID__c == 'No') && oldMap.get(opp.Id).InstallmentsGenerated__c == true &&
                ((opp.Number_of_Installments__c != null && opp.StageName == 'Closed or Won' && oldMap.get(opp.Id).StageName != 'Closed or Won') || 
                (opp.Number_of_Installments__c != null && oldMap.get(opp.Id).Number_of_Installments__c == null && opp.StageName == 'Closed or Won'))) {
            */
            if((oldMap.get(opp.Id).Confirmed__c == null || oldMap.get(opp.Id).Confirmed__c == 'No') && oldMap.get(opp.Id).InstallmentsGenerated__c == true &&
                ((opp.Number_of_Installments__c != null && opp.StageName == 'Closed or Won' && oldMap.get(opp.Id).StageName != 'Closed or Won') || 
                (opp.Number_of_Installments__c != null && oldMap.get(opp.Id).Number_of_Installments__c == null && opp.StageName == 'Closed or Won'))) {
                
                OpportunityClass.UpdateInstallments(opp);               
            }
        }
    }
    
    
    // Will need to rewrite the GenerateInstallments method in "OpportunityClass.cls" eventually. This will work for now. (NCJ 5/29/13)
    public static void checkToGenerateInstallments(List<Opportunity> opps) {
        
        for(Opportunity opp : opps) {
            
            if(opp.Number_of_Installments__c != null && opp.Amount != null) {
                
                //Bad practice.. fix later
                OpportunityClass.GenerateInstallments(opp);
            }
        }
    }
    
    public static void cloneDemos(List<Opportunity> opps) {
        
        // Will need to rewrite the CloneDemos method in "OpportunityClass.cls" eventually. This will work for now. (NCJ 5/29/13)
        for(Opportunity opp : opps) {
            
            if(opp.Parent_Clone_ID__c != null && opp.Parent_Clone_ID__c != opp.Id) {
                
                //Bad practice.. fix later
                OpportunityClass.CloneDemos(opp);
            }
        }
    }
    
    public static void deleteRelatedInstallments(List<Opportunity> opps) {
        
        Set<Id> oppIds = new Set<Id>();
        
        for(Opportunity opp : opps) {
            
            if(opp.Parent_Clone_ID__c != null && opp.Parent_Clone_ID__c != opp.Id) {
                
                oppIds.add(opp.Id);
            }
        }
        
        if(oppIds.size() > 0) {
        
            List<Installment__c> deleteInstallments = [SELECT Id, Opportunity__c 
                                                       FROM Installment__c 
                                                       WHERE Opportunity__c IN :oppIds];
                                                       
            if(deleteInstallments.size() > 0) {
                
                delete deleteInstallments;
            }
        }
    }
    
    public static void checkIfProjectsExistBeforeDelete(List<Opportunity> oldOpps) {
        
        for(Opportunity opp : oldOpps) {
            
            List<SFDC_520_Quote__c> projects = [SELECT Id
                                                FROM SFDC_520_Quote__c
                                                WHERE Opportunity__c = :opp.Id];
                                                
            if(projects.size() > 0) {
                
                opp.addError('An Opportunity cannot be deleted without first deleting the related Projects.');
            }
        }
    }
    
    public static void UpdateInvoiceTotal(Map<Id, List<OpportunityLineItem>> oppMap, List<Opportunity> opps) {
        
        for(Opportunity opp : opps) {
            
            double totalFreight = 0;
            
            if(oppMap.get(opp.Id) != null) { 
            
                for(OpportunityLineItem oli : oppMap.get(opp.Id)) {
                    
                    totalFreight += oli.Freight_Cost__c;
                }
            }
            
            opp.Freight_Cost__c = totalFreight;
        }
    }
    
    public static void UpdateClonedWithProducts(Map<Id, List<OpportunityLineItem>> oppMap, List<Opportunity> opps) {
        
        for(Opportunity opp : opps) {
            
            if(oppMap.get(opp.Id) != null) {
                for(OpportunityLineItem oli : oppMap.get(opp.Id)) {
                    
                    if(opp.Id == oli.OpportunityId) {
                        
                        opp.Cloned_with_Products__c = true;
                    }
                }
            }
            
            opp.Phased_Project__c = false;
            opp.Project_Generated__c = false;
            opp.Project_Exception__c = false;
            opp.InstallmentsGenerated__c = false;
            opp.Invoice_Total__c = 0;
            opp.Multi_Installments_Approved__c = false;
            opp.Stage_Type__c = null;
            opp.Salesperson__c = userinfo.getUserId();
        }
    }
    
    public static void OneOpportunityPerAccount(List<Opportunity> opps) {
        /* -
        Set<Id> accountIds = new Set<Id>();
        
        for(Opportunity opp : opps) {
            
            accountIds.add(opp.AccountId);
        //}
        
        for(Opportunity opp1 : [SELECT Id, Opportunity_Names__c, StageName, AccountId, Multiple_Opportunity_Override__c,
                                IsClosed
                               FROM Opportunity
                               WHERE AccountId IN :accountIds]) {
        
            if(opp.Opportunity_Names__c != 'Fulfillment' && opp.Opportunity_Names__c != 'Hardware' && opp.Opportunity_Names__c != 'Printed Materials' &&
               opp.IsClosed == false && opp.Multiple_Opportunity_Override__c != true) {
                
                opp.addError('There is already an Opportunity open for this account. Please see a manager if you need this error to be overriden.');
            }                   
        }
      }
      */
    }
    
    /*public static void setRegionalOwner(List<Opportunity> opps) {
        
        for(Opportunity opp : opps) {
            
            if(opp.Account.Territory_State__r.Regional__c != null && userinfo.getUserRoleId() == '00E70000000xk01') {
                
                opp.OwnerId = opp.Account.Territory_State__r.Regional__c;
            }
            
            opp.Owner_Role__c = userinfo.getUserRoleId();
            opp.Salesperson_Role__c = userinfo.getUserRoleId();
        }
    }*/
    
    public static void setRegionalOwner(List<Opportunity> opps) {
        
        string roleId = userinfo.getUserRoleId();
        string roleName;
        User ui = [Select UserRole.Name FROM User WHERE UserRoleId =: roleId Limit 1];
        roleName = ui.UserRole.Name;
        
        string ownerRoleName = ui.UserRole.Name;
        
        //string roleName = [SELECT Name FROM UserRole WHERE Id =:userinfo.getUserRoleId()].Name;
        
        
        for(Opportunity opp : opps) {
            
            if(opp.Account.Territory_State__r.Regional__c != null && userinfo.getUserRoleId() == '00E70000000xk01') {
                
                opp.OwnerId = opp.Account.Territory_State__r.Regional__c;
            }
            
            opp.Owner_Role__c = ownerRoleName;
            //opp.Salesperson_Role__c = userinfo.getUserRoleId();
            opp.Salesperson_Role__c = roleName;
        }
    }
    
    public static void checkIfUpdateAccountTypeAndCheckRelatedProducts(List<Opportunity> opps, Map<Id, List<OpportunityLineItem>> oppMap, Map<Id, Opportunity> oldMap) {
        
        List<Opportunity> updateAccountOpps = new List<Opportunity>();
        List<Opportunity> checkRelatedProductsOpps = new List<Opportunity>();
        
        for(Opportunity opp : opps) {
            
            if(oldMap.get(opp.Id).StageName != 'Closed or Won' && opp.StageName == 'Closed or Won') {
                
                updateAccountOpps.add(opp);
                
                if(opp.Override_Related_Product__c != true) {
                    
                    checkRelatedProductsOpps.add(opp);
                }
            }
        }
        
        if(updateAccountOpps.size() > 0) {
            
            updateAccountType(updateAccountOpps);
        }
        
        if(checkRelatedProductsOpps.size() > 0) {
            
            checkRelatedProducts(checkRelatedProductsOpps, oppMap);
        }
    }
    
    public static void checkInstallmentsGenerated(List<Opportunity> opps, Map<Id, Opportunity> oldMap) {
        
        for(Opportunity opp : opps) {
            
            if(oldMap.get(opp.Id).InstallmentsGenerated__c == false && ((opp.Number_of_Installments__c != null &&
                opp.StageName == 'Closed or Won' && oldMap.get(opp.Id).StageName != 'Closed or Won') ||
                (opp.Number_of_Installments__c != null && oldMap.get(opp.Id).Number_of_Installments__c == null && opp.StageName == 'Closed or Won'))) {
                    
                opp.InstallmentsGenerated__c = true;        
            }
        }
    }
    
    public static void checkRelatedProducts(List<Opportunity> opps, Map<Id, List<OpportunityLineItem>> oppMap) {
        
        List<Id> listOfRelatedProductIds = new List<Id>();
        Map<Id, OpportunityLineItem> mapOfAllProductIds = new Map<Id, OpportunityLineItem>();
        
        for(Opportunity opp : opps) {
            
            if(oppMap.get(opp.Id) != null) {
            
                for(OpportunityLineItem oli : oppMap.get(opp.Id)) {
                    
                    if(oli.Related_ProductId__c != null && oli.Override_Related_Product__c != true) {
                        
                        listOfRelatedProductIds.add(oli.Related_ProductId__c);
                    }
                    
                    mapOfAllProductIds.put(oli.ProductId__c, oli);
                }
                
                for(Id thisRelatedId : listOfRelatedProductIds) {
                    
                    if(mapOfAllProductIds.get(thisRelatedId) == null) {
                        
                        Product2 errorProduct = [SELECT Id, Name
                                                 FROM Product2
                                                 WHERE Id =:thisRelatedId
                                                 limit 1];
                                                 
                        opp.addError('Opportunity has a product on it that has a REQUIRED RELATED PRODUCT. Product Name Required: ' + errorProduct.Name);
                    }
                }
            }
        }
    }
    
    public static void updateAccountType(List<Opportunity> opps) {
        
        Set<Id> accountIds = new Set<Id>();
        
        for(Opportunity opp : opps) {
            
            if(opp.StageName == 'Closed or Won' && opp.Account.Type != 'Customer') {
                
                accountIds.add(opp.AccountId);
            }
        }
        
        List<Account> updateAccounts = new List<Account>();
        
        if(accountIds.size() > 0) {
            
            for(Account a : [SELECT Id, Type
                             FROM Account
                             WHERE Id IN :accountIds]) {
                                
                a.Type = 'Customer';
                
                updateAccounts.add(a);                  
            }
            
            update updateAccounts;
        }
    }
    
    public static void UpdateInitialWebexCompleteDate(List<Opportunity> opps) {
        
        for(Opportunity opp : opps) {
            
            if(opp.StageName == 'Webex Complete') {
                
                opp.Initial_Webex_Completed__c = system.today();
            }
        }
    }
    
    public static void updatePhasedProject(Map<Id, List<OpportunityLineItem>> oppMap, List<Opportunity> opps, Map<Id, Opportunity> oldMap) {
        
        for(Opportunity opp : opps) {
            
            if(opp.StageName == 'Closed or Won' && oldMap.get(opp.Id).StageName != 'Closed or Won') {
                
                if(oppMap.get(opp.Id) != null) {
                
                    for(OpportunityLineItem oli : oppMap.get(opp.Id)) {
                        
                        if(oli.Solution_Product__c == true) {
                            
                            opp.Phased_Project__c = true;
                        }
                    }
                }
            }
        }
    }
    
    /*public static void updateOwnerRoleSalespersonRole(List<Opportunity> opps, Map<Id, Opportunity> oldMap) {
        
        for(Opportunity opp : opps) {
            
            if(((oldMap.get(opp.Id).OwnerId != null) && (oldMap.get(opp.Id).OwnerId != opp.OwnerId)) || (opp.OwnerId != null && opp.Owner_Role__c == null)) {
                
                opp.Owner_Role__c = userinfo.getUserRoleId();
            }
            
            if((oldMap.get(opp.Id).Salesperson__c != opp.Salesperson__c) || (opp.Salesperson__c != null && opp.Salesperson_Role__c == null)) {
                
                opp.Salesperson_Role__c = userinfo.getUserRoleId();
            }
        }
    }*/
    
    public static void updateOwnerRoleSalespersonRole(List<Opportunity> opps, Map<Id, Opportunity> oldMap) {
        
        string spID;
        string owID;
        Set<Id> userIDs = new Set<Id>();
        
        for(Opportunity opp : opps){
            if(oldMap.get(opp.Id).OwnerId != opp.OwnerId || oldMap.get(opp.Id).Salesperson__c != opp.Salesperson__c){
                userIDs.add(opp.Salesperson__c);
                userIDs.add(opp.OwnerId);
            }
        }
        if(userIDs.size() > 0){
            MAP<Id, String> roleMap = new MAP<Id, String>();
            
                for(User u : [SELECT Id, UserRole.Name FROM User WHERE Id IN : userIds]){
                    roleMap.put(u.Id, u.UserRole.Name);
                }
            
            
            for(Opportunity opp : opps) {
                
                
                if(((oldMap.get(opp.Id).OwnerId != null) && (oldMap.get(opp.Id).OwnerId != opp.OwnerId)) || (opp.OwnerId != null && opp.Owner_Role__c == null)) {
                    
                    //opp.Owner_Role__c = userinfo.getUserRoleId();
                    //opp.Owner_Role__c = owInfo.UserRole.Name;
                    //opp.Owner_Role__c = opp.OwnerId.UserRole.Name;
                    opp.Owner_Role__c = roleMap.get(opp.OwnerId);
                }
                if(opp.Salesperson_Exception__c == true){
                    //opp.Salesperson_Role__c = opp.Salesperson__c;
                    //opp.Salesperson_Role__c = spInfo.UserRole.Name;
                    opp.Salesperson_Role__c = roleMap.get(opp.Salesperson__c);
                }
                //if((oldMap.get(opp.Id).Salesperson__c != opp.Salesperson__c) || (opp.Salesperson__c != null && opp.Salesperson_Role__c == null)) {
                    
                //      opp.Salesperson_Role__c = userinfo.getUserRoleId();
                    //opp.Salesperson_Role__c = opp.Salesperson__r.UserRole.Name;
                    //opp.Salesperson_Role__c = opp.Salesperson__c.UserRoleId();
                //}
            }
        }
    }
    
    
}