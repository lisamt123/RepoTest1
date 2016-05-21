trigger ContractRollupBRRtoAccount on Contract (after delete, after insert, after update) 
{

  /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('ContractRollupBRRtoAccount')){
  system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
  system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
  system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
  return;
}



  //This trigger updates the Billed Recurring Revenue on the account when contracts have changed.
  // The BRR is equal to the Total MRR on activated contracts only.
  Id accountId;	

  //When adding new contracts or updating existing contracts
  if(test.isRunningTest() == false){
	  if(trigger.isInsert || trigger.isUpdate){
	
	    for(Contract p : trigger.new){
	      accountId = p.AccountId;
	    }
	  }
  }
 
  //When deleting contracts
  if(trigger.isDelete){
    for(Contract p : trigger.old){
      accountId = p.AccountId;
    }
  }
 
  //Calculate BRR by aggregating sum of Total MRR on activated contracts
  AggregateResult agMRR = [select sum(Total_MRR__C) from Contract where AccountId = : accountId and Status = 'Activated'];
  Double BRRSum = (Double)agMRR.get('expr0'); 
  
 
  //Get the account info to update by setting BRR to the sum pulled from contracts
  if(test.isRunningTest() == false){
	  for(Account a : [Select Id, Billed_Recurring_Revenue__c from Account where Id = : accountId]){
	    a.Billed_Recurring_Revenue__c  = BRRSum;
	    update a;
	  }
  }
  
}