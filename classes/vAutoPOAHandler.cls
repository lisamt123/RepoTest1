public class vAutoPOAHandler extends POAHandler{   
 
     public override void afterInsert(POA__c poa){
    	system.debug('setting vAuto POA on account after POA is inserted');
        setvAutoPOA(poa);
    }
    
    public override void afterUpdate(POA__c newpoa,POA__c oldpoa){
       
        if(newpoa.Dealer__c !=null && newpoa.Dealer__r.vAuto_POA__c == null){
             setvAutoPOA(newpoa);
        }
        
        if(newpoa.OwnerId != oldpoa.OwnerId){
             ResetPerformanceManagerAccountTeam(newpoa,oldpoa);
        }
        if(newpoa.Account_Director__c != oldpoa.Account_Director__c){
             ResetAccountDirectorAccountTeam(newpoa,oldpoa);
             //CreateTask('* Reassigned Account Director Call',0,newpoa.ownerId, newpoa.Id,'You have been assigned to an existing customer. Please make an intro call and introduce yourself.');
        }
       
    }
   

    public override  Map<String, POA__c>  UpsertPOA(OpportunityLineItem oppLine, Map<String, POA__c> existingPOAs){
        POA__c poa;             
        //Product2 product = [Select Id, Project_Definition__c,Name from Product2 where Id =: oppLine.ProductId__c];
        //if(product.Project_Definition__c == null){
        if(oppLine.PricebookEntry.Product2.Project_Definition__c == null){
             //throw new CoxAutomotiveException('No Project Definition Specified for Product: '+product.Name);
             System.debug('No POA Required for product: No Project Definition Specified for Product: '+oppLine.PricebookEntry.Product2.Name);
             
            return existingPOAs;          
        }
        
        Project_Definition__c productDefinition = StaticData.getInstance().ProjectDefinitions().get(oppLine.PricebookEntry.Product2.Project_Definition__c);
        
        if(productDefinition == null){
             throw new CoxAutomotiveException('Project Definition is not valid for Product: '+oppLine.PricebookEntry.Product2.Name);          
        }
        
        //check if there is a POA existing 
        String posRecordTypeName = productDefinition.POA_Type__c;
        if(posRecordTypeName == null || posRecordTypeName.trim()==''){
            System.debug('No POA Required for product: '+oppLine.PricebookEntry.Product2.Name);
            return existingPOAs;
        }

        RecordType poaRecordType = StaticData.getInstance().POARecTypesMapByName.get(posRecordTypeName);

        if(poaRecordType == null){
            throw new CoxAutomotiveException('Could not find POA recordType :'+posRecordTypeName +' for product: '+oppLine.PricebookEntry.Product2.Name);
        }
        
        System.debug('poaRecordType.Name:' + poaRecordType.Name);
       
        //Check if the POA is already retrived  
        //If not find/create one and add to it
        if(!existingPOAs.containsKey(poaRecordType.Name)){          
            /*Ramana Mosali: Changes related to CR-00011898; Updated to look for non-churned POA and use it and incase if none found then look for Churned POA since it could be a returning customer and 
            reset the status on that POA to Open and use that instead of creating a new POA.
            */

            //get all non-churned vAUto POA for the account and use the most recently modified POA
            List<POA__c> existingPOA = [Select Id, Acquisition_Pro__c from POA__c where Dealer__c =: oppLine.Opportunity.AccountId and  RecordTypeId =: poaRecordType.Id and status__c !=: 'Churned' order by LastModifiedDate desc];
            
            if(existingPOA != null && existingPOA.size() > 0){
                // Updating Acquisition Pro field as per Story W-000915

                poa = existingPOA[0];
                System.debug('Assigning Existing POA: '+poa.Id);
            }
            else {
                //If there are no non-churned vAUto POA for the account
                //check if there are any churned POA since he could be a returning customer
                //get any churned vAuto POA's ordered by the most recently modified
                List<POA__c> existingChurnedPOA = [Select Id, Acquisition_Pro__c from POA__c where Dealer__c =: oppLine.Opportunity.AccountId and  RecordTypeId =: poaRecordType.Id and status__c =: 'Churned' order by LastModifiedDate desc];
                if(existingChurnedPOA != null && existingChurnedPOA.size() > 0){
                    poa = existingChurnedPOA[0];
                    System.debug('Found a Churned POA:'+poa.Id+' updating it to Open status');
                    poa.Status__c = 'Open';
                    update poa;
                    System.debug('Updated a Churned POA:'+poa.Id+' to Open status');
                    System.debug('Assigning Existing POA: '+poa.Id);
                }
                else{
                    //poa = CreatePOA(oppLine.Opportunity.AccountId,poaName,poaRecordType);
                    poa = new POA__c();    
                    String poaName =  StaticData.getInstance().getBUIdentifierByOppRecType(oppLine.Opportunity.RecordTypeId)+'-';
                
                    if(oppLine.Opportunity.Account.Name.length() > 61){        
                        poaName  += oppLine.Opportunity.Account.Name.substring(0,58) + '...';
                    }
                    else {        
                        poaName  += oppLine.Opportunity.Account.Name; 
                    }

                    //Ramana:: Catch to make sure not to cross max 80 char limit.
                    //if the name still exceeds 80 max length
                    if(poaName.length() >= 80){
                        //get only the first 80 char.
                        poaName = poaName.substring(0,79);  
                    } 

                    if(productDefinition.Default_POA_Owner__c != null){     
                        poa.OwnerId = productDefinition.Default_POA_Owner__c;
                    }
                    poa.Dealer__c =  oppLine.Opportunity.AccountId;
                    poa.RecordTypeId = poaRecordType.Id;
                    poa.Name =  poaName;
                    insert poa;    

                    System.debug('Created New POA of RecordType: '+poaRecordType.Name);
                    System.debug('Created New POA: '+poa.Id);            
                }
            } 
            // Updating Acquisition Pro field as per Story W-000915
            if(oppLine.Opp_Product_Suite__c.contains('Stockwave') && (oppLine.Opportunity.Type == 'Sale' || oppLine.Opportunity.Type == 'Reactivate')){
                // vAuto_Acquisition_Assignment__c is a custom setting
                vAuto_Acquisition_Assignment__c instance = vAuto_Acquisition_Assignment__c.getInstance('Acquisition Pro');
                poa.Acquisition_Pro__c = instance.UserID__c;
                update poa;
            }
            existingPOAs.put(poaRecordType.Name,poa);
        }
        
        return existingPOAs;
    }

    private void CreateTask(String subject, Integer dueInDays, Id ownerId, Id whatId
    ,String description){
	Task task = new Task();
	task.Subject =  subject;
	task.ActivityDate = System.today().addDays(dueInDays);
	task.OwnerId = ownerId;
	task.WhatId = whatId;
	task.Description =description;
	task.Priority ='Normal';
	task.Type='Task';
 	task.RecordTypeId = StaticData.getInstance().TaskRecordTypeMapByDevName.get('vAuto_Layout').Id;
	
	insert task;
}
     private void ResetAccountDirectorAccountTeam(POA__c newpoa,POA__c oldpoa){
     	System.debug('BEGIN Assigning VAT Account Director');
     	DeleteAccountTeam(oldpoa.Dealer__c,oldpoa.Account_Director__c,'VAT Account Director');
		InsertAccountTeam(newpoa.Dealer__c,newpoa.Account_Owner__c, newpoa.Account_Director__c,'VAT Account Director');
		System.debug('END Assigning VAT Account Director');
     } 
     private void ResetPerformanceManagerAccountTeam(POA__c newpoa,POA__c oldpoa){
     	System.debug('BEGIN Assigning VAT Performance Manager');
     	DeleteAccountTeam(oldpoa.Dealer__c,oldpoa.ownerId,'VAT Performance Manager');
		InsertAccountTeam(newpoa.Dealer__c,newpoa.Account_Owner__c,newpoa.ownerId,'VAT Performance Manager');
		System.debug('END Assigning VAT Performance Manager');
     }
	 private void DeleteAccountTeam(Id accountId, Id userId, String roleName){
	 	if(userId == null) {return;}
	   	List<AccountTeamMember> teamMembers = [Select Id from AccountTeamMember
	   	where UserId =: userId
	   	and AccountId =: accountId
	   	and TeamMemberRole =: roleName];
	   	if(teamMembers.size()> 0){ 
	   		System.debug('deleting existing VAT Performance Manager');
	   		delete teamMembers;
	   	}
	 }


     private void InsertAccountTeam(Id accountId,Id accountOwnerId, Id userId , String roleName){

        //check if the user being assigned is not Account owner already
        if(accountOwnerId == userId){
            //user is already a owner of the account no need to create AccountTeam member
            //If attemped to create; will error out with
            // INSUFFICIENT_ACCESS_ON_CROSS_REFERENCE_ENTITY, insufficient access rights on cross-reference id
            // Since as a owner user already has more access than and creating this AccountTeam member will create conflict
            System.debug('User is already a owner on the account; cannot create AccountTeam with role:'+roleName);
            return;
        }

        if(userId != null && accountId != null && roleName != null) {
            AccountTeamMember accTeam = new AccountTeamMember(
                UserId = userId,
                AccountId = accountId,
                TeamMemberRole = roleName
            );
 
            AccountShare accShare = new AccountShare(
                AccountId = accountId,
                UserOrGroupId = userId,
                AccountAccessLevel = 'Edit',
                OpportunityAccessLevel = 'Read',
                CaseAccessLevel = 'Read',
                ContactAccessLevel = 'Read'
            ); 

            AccountTMHelper atmh = new AccountTMHelper(accTeam, accShare);
            List<AccountShare> acctShare = [SELECT Id,AccountId,UserOrGroupId, AccountAccessLevel, ContactAccessLevel, OpportunityAccessLevel, CaseAccessLevel FROM AccountShare WHERE AccountId=: accountId and UserOrGroupId = :userId LIMIT 1];

            if(acctShare != null && acctShare.size() > 0) {
                atmh = atmh.mergeTM(new AccountTMHelper(acctShare[0]));
            }
			System.debug('Inserting existing VAT Performance Manager');
			System.debug('accTeam.UserId: '+accTeam.UserId);
			System.debug('accTeam.AccountId: '+accTeam.AccountId);
			System.debug('accTeam.TeamMemberRole: '+accTeam.TeamMemberRole);
            insert atmh.tm;
            insert atmh.acctShare;
        }   
     }

    private void setvAutoPOA(POA__c poa){
        system.debug('Checking vAuto POA on account: '+poa.Dealer__c);
        
            //set the vAuto POA lookup on account
            //

   /*Ramana Mosali: Changes related to CR-00011898; updating to assign not the passed POA but most recently modified non-churned POA*/
   /* List<POA__c> existingPOA = [Select Id from POA__c where Dealer__c =:poa.Dealer__c and  RecordTypeId =: poa.RecordTypeId and status__c !=: 'Churned' and Id !=: poa.Id];
    if(existingPOA == null || existingPOA.size() == 0){
            
            system.debug('Setting vAuto POA on account: '+poa.Dealer__c);
            //if this is the only one set the field
            Account acct = new Account(Id = poa.Dealer__c);
            acct.vAuto_POA__c = poa.Id;
            update acct;            
        }
        else{
            // throw an error since there can not be more than one vAuto POA on a account
             throw new CoxAutomotiveException('There are '+existingPOA.size()+' existing vAuto POA on account, cannot create more than one');
        }
    */
   
   //get all non churned vAuto POA's for this account
    List<POA__c> existingPOA = [Select Id from POA__c where Dealer__c =:poa.Dealer__c and  RecordTypeId =: poa.RecordTypeId and status__c !=: 'Churned' order by LastModifiedDate desc];
        
        if( existingPOA != null && existingPOA.size() >0){
        	
        	system.debug('Setting vAuto POA on account: '+poa.Dealer__c);
            //if this is the only one set the field
            Account acct = new Account(Id = poa.Dealer__c);
            acct.vAuto_POA__c = existingPOA[0].Id;
            update acct;            
        }
        else {

        //If there are no non-churned vAUto POA for the account
        //check if there are any churned POA since he could be a returning customer
        //get any churned vAuto POA's ordered by the most recently modified
        List<POA__c> existingChurnedPOA = [Select Id from POA__c where Dealer__c =:poa.Dealer__c and  RecordTypeId =: poa.RecordTypeId and status__c = 'Churned' order by LastModifiedDate desc];
        if(existingChurnedPOA != null && existingChurnedPOA.size() > 0){
        system.debug('Setting vAuto POA on account: '+poa.Dealer__c);
            //if this is the only one set the field
            Account acct = new Account(Id = poa.Dealer__c);
            acct.vAuto_POA__c = existingChurnedPOA[0].Id;
            update acct;     
        }       
        else{
            //There is nothing to assign; this should not happen 
            throw new CoxAutomotiveException('There is no '+poa.RecordType.Id+' type POA found to assign for Account: '+poa.Dealer__c);
        }        
        }
      }
    
}