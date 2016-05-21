public with sharing class handler_billingItemUpdateBillingType {
	
    public static void afterTriggers(List<Billing_Item__c> billingItems) {
        //This trigger updates the Billing Type on the Account based on changes to Billing Items that exist on contracts related to account
        // Get record types
        List<RecordType> rtypes = [Select Name, Id From RecordType where sObjectType='Billing_Item__c' and isActive=true];
        Map<String,String> biRecordTypes = new Map<String,String>{};
        for(RecordType rt: rtypes)
        {            
            biRecordTypes.put(rt.Name,rt.Id);
        }            
        boolean atcVar = FALSE;         
        boolean crmVar = FALSE;
        boolean webvar = FALSE;
        boolean ilmVar = FALSE;
        boolean invVar = FALSE;        
        boolean inventory = FALSE;
        boolean ATC = FALSE;
        string tempName;
        system.debug('billingitems'); system.debug(billingItems);
        system.debug('Contract__c'); system.debug(billingItems[0].Contract__c);                          
        List <Billing_Item__c> temp = [select Id,Contract__c from Billing_Item__c where Id =: billingItems[0].Id ];     
        system.debug('temp'); system.debug(temp); 
        // Get product names of all billing items that are not CANCELLED record type
        // If any of the product names in the billing items starts with CRM, then set to CRM
        List <Billing_Item__c> bi = [Select Id, RecordTypeId, Product_Sold__r.Name,Product_Sold__r.Family,Contract__r.AccountId from Billing_Item__c where Contract__c =: billingItems[0].Contract__c ];
        // Are there any other billing items?
        Contract contractInfo = [SELECT Id, AccountId, Delete_Trigger__c FROM Contract WHERE Id =: billingItems[0].Contract__c];
        system.debug('bi'); system.debug(bi); 
        if (bi != null)
        {
            for(Billing_Item__c biAll: bi)
            {   
                system.debug('LYNNTEST biAll Id'); system.debug(biAll.Id);                       
                system.debug('LYNNTEST product name'); system.debug(biAll.Product_Sold__r.Name);   
                system.debug('LYNNTEST product family'); system.debug(biAll.Product_Sold__r.Family);                       
                system.debug('LYNNTEST recordtype'); system.debug(biAll.RecordTypeId);                       
                if(biAll.RecordTypeId<>biRecordTypes.get('CANCELLED')&& (biAll.Product_Sold__r.Family =='Monthly Reoccuring'))
                {  
                    tempName = biAll.Product_Sold__r.Name;
                	system.debug('tempname'+tempName);
                    if (tempName.startsWith('CRM')) 
                        crmVar = TRUE;
                    if (tempName.startsWith('ILM'))
                        ilmVar = TRUE;
                    if (tempName.startsWith('Website'))
                        webVar = TRUE;
                    if (tempName.startsWith('Inventory Module')) 
                        invVar = TRUE;                    
                    if (tempName.contains('ATC'))
                        atcVar = TRUE;                 
                }
            }   
        }            
        // If any of the product names in the billing items starts with  Website and CRM, then set to CRM with website
        // ELSE If any of the product names in the billing items starts with  ILM, then set to ILM
        // If any of the product names in the billing items starts with  Website and ILM, then set to ILM with website
        // ELSE If any of the product names in the billing items have Inventory, then set to Inventory
        // If any of the product names in the billing items have Website and Inventory, then set to Inventory with website
        // ELSE If any of the product names in the billing items contains ATC, then set to ATC Website
        // ELSE If any of the product names in the billing items starts with Website, then set to Website
        // IF Nothing above applies, then set to Other
        system.debug('LYNNTEST crmVar'); system.debug(crmVar);                       
        system.debug('LYNNTEST webVar'); system.debug(webVar);                       
        system.debug('LYNNTEST ilmVar'); system.debug(ilmVar);                       
        system.debug('LYNNTEST invVar'); system.debug(invVar);                       
        
        
        Account relatedAccount = [Select Id, Billing_Type__c from Account where Id = : contractInfo.AccountId];
        //system.debug('Bazinga' + relatedAccount.Deleted_Billing_Item_Trigger__c);
        //system.debug('Bazinga' + relatedAccount.Id);
        //system.debug('Bazinga' + contractInfo.Dealer_SVOC_ID__c);
        //relatedAccount.Deleted_Billing_Item_Trigger__c = true;
        /*if ((crmVar == TRUE)&&(webVar==TRUE))
            relatedAccount.Billing_Type__c = 'CRM w/Website';
        else if (crmVar == TRUE)
            relatedAccount.Billing_Type__c = 'CRM';
        else if ((ilmVar == TRUE)&&(webVar==TRUE))
            relatedAccount.Billing_Type__c = 'ILM w/Website';
        else if (ilmVar == TRUE)
            relatedAccount.Billing_Type__c = 'ILM';
        else if ((invVar == TRUE)&&(webVar==TRUE))
            relatedAccount.Billing_Type__c = 'Inventory w/Website';
        else if (invVar == TRUE)
            relatedAccount.Billing_Type__c = 'Inventory';            
        else if ((atcVar == TRUE)&&(webVar==TRUE))
            relatedAccount.Billing_Type__c = 'ATC Website';            
        else
            relatedAccount.Billing_Type__c = 'Other';*/
         contractInfo.Delete_Trigger__c = true;   
         update contractInfo;
        //update relatedAccount;
    
            /* billing type picklist
            CRM w/Website 
            CRM 
            ILM w/Website 
            ILM 
            Inventory w/Website 
            Inventory 
            Website 
            Other */        
    } 
    
    public static void deleteTriggers(List<Billing_Item__c> billingItems){
    	/*
    	List <Billing_Item__c> temp = [select Id,Contract__c from Billing_Item__c where Id =: billingItems[0].Id ];
    	List <Billing_Item__c> bi = [Select Id, RecordTypeId, Product_Sold__r.Name,Product_Sold__r.Family,Contract__r.AccountId from Billing_Item__c where Contract__c =: billingItems[0].Contract__c ];
    	Contract contractInfo = [SELECT Id, AccountId, Delete_Trigger__c FROM Contract WHERE Id =: billingItems[0].Contract__c];
    	Account relatedAccount = [Select Id, Deleted_Billing_Item_Trigger__c from Account where Id = : contractInfo.AccountId];
    	
    	
    	system.debug('Bazinga' + relatedAccount.Deleted_Billing_Item_Trigger__c);
        system.debug('Bazinga' + relatedAccount.Id);
        //system.debug('Bazinga' + contractInfo.Dealer_SVOC_ID__c);
        
    	relatedAccount.Deleted_Billing_Item_Trigger__c = true;
    	system.debug('Bazinga' + relatedAccount.Deleted_Billing_Item_Trigger__c);
    	
    	update relatedAccount;
    	*/
    }
}