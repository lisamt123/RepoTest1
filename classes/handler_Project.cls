public with sharing class handler_Project {
    
    
    //Pavan Hegde--- Start--> W-1157,W-1140,W-1158 ---> Converted The process Builders, Flows to below method
    public static void BuildAssetRecUpdate(List<SFDC_520_Quote__c> project){
        Set<Id> projectId = new Set<Id>();
        Set<Id> projectAssetId = new Set<Id>();
        Map<Id,List<Project_Piece__c>> projectAssetMap = new Map<Id,List<Project_Piece__c>>();
        Map<Id,List<Billing_Item__c>> BilledAssetMap = new Map<Id,List<Billing_Item__c>>();
        for(SFDC_520_Quote__c proj: project){
            projectId.add(proj.id); // add projectIds to a set
        }     
        //querying projectAsset records
        List<Project_Piece__c> projectAssets = [select id,name,Project__c,Product_Name__c from Project_Piece__c where Project__c in : projectId ];
        // processing all projectAsset records
        for(Project_Piece__c ps :projectAssets ){
        
        // Creating a temporary List for copying the Project Asset data, as duplicate keys cannot be inserted in the map,
        // One Project may have multiple Project Assets, hence Temporary list is needed.
            if( !projectAssetMap.containsKey(ps.Project__c))
            {   
                List<Project_Piece__c> tempList = new List<Project_Piece__c>();
                tempList.add(ps);
                projectAssetMap.put(ps.Project__c, tempList);   
            }
            else
            {
                List<Project_Piece__c> tempList = projectAssetMap.get(ps.Project__c);
                tempList.add(ps);
                projectAssetMap.put(ps.Project__c, tempList);
            }   
            
            projectAssetId.add(ps.id);
        }
        // get the Billed assets records, related to project asset.
        List<Billing_Item__c> billingItems = [select id,name,Related_Project_Piece__c from Billing_Item__c where Related_Project_Piece__c in : projectAssetId];
        for(Billing_Item__c bi : billingItems){
            if( !BilledAssetMap.containsKey(bi.Related_Project_Piece__c))
            {   
                List<Billing_Item__c> tempList = new List<Billing_Item__c>();
                tempList.add(bi);
                BilledAssetMap.put(bi.Related_Project_Piece__c, tempList);   
            }
            else
            {
                List<Billing_Item__c> tempList = BilledAssetMap.get(bi.Related_Project_Piece__c);
                tempList.add(bi);
                BilledAssetMap.put(bi.Related_Project_Piece__c, tempList);
            }       
        }   
        Map<ID,Billing_Item__c> BillingAssetUpdateMap = new Map<ID,Billing_Item__c>{};
            for(SFDC_520_Quote__c proj: project){ 
            
            // Setting the Status of Billed asset, based on Project's Stage and also if the Completed date on Project is not null
            // Setting of status of Billed asset is based on stories--> W-1157,W-1140,W-1158
               
                if(proj.Project_Complete_Date__c != null){
                    List<Project_Piece__C> pAssetsPendLaunchApp = projectAssetMap.get(proj.id);
                    if( pAssetsPendLaunchApp != null){
                        for(Project_Piece__c pAsset : pAssetsPendLaunchApp){
                            if(pAsset.Product_Name__c == 'Stockwave'){
                                List<Billing_Item__c> BillingAssets = BilledAssetMap.get(pAsset.id);
                                for(Billing_Item__c bi :BillingAssets){
                                    bi.LOB_Status__c = 'Pending Launch Approval';
                                    BillingAssetUpdateMap.put(bi.id, bi);
                                    system.debug('entered completed date');
                                }
                            }
                        }
                    }
                }
                    if(proj.Approval_Stage__c == 'Integration'){
                        List<Project_Piece__C> pAssets = projectAssetMap.get(proj.id);
                        if(pAssets != null){
                            for(Project_Piece__c pAsset : pAssets){
                                if(pAsset.Product_Name__c == 'Stockwave'){
                                    List<Billing_Item__c> BillingAssets = BilledAssetMap.get(pAsset.id);
                                    for(Billing_Item__c bi :BillingAssets){
                                        bi.LOB_Status__c = 'Pending Needs Data';
                                        BillingAssetUpdateMap.put(bi.id, bi);    
                                        system.debug('entered integration');
                                    }
                                }
                            }
                        }
                    }
                    if(proj.Approval_Stage__c == 'Training 1'){
                        List<Project_Piece__C> pAssets = projectAssetMap.get(proj.id);
                        if(pAssets.size()>0 && pAssets != null){
                            for(Project_Piece__c pAsset : pAssets){
                                if(pAsset.Product_Name__c == 'Stockwave'){
                                    List<Billing_Item__c> BillingAssets = BilledAssetMap.get(pAsset.id);
                                    for(Billing_Item__c bi :BillingAssets){
                                        bi.LOB_Status__c = 'Pending needs Training';
                                        BillingAssetUpdateMap.put(bi.id, bi);  
                                        system.debug('entered training 1');
                                    }
                                }
                            }
                        }
                    }
                
                if(BillingAssetUpdateMap.values().size()>0 ){
                    update BillingAssetUpdateMap.values();
                }
            }    
    }
}