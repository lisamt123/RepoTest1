public class BillingItemTriggerHandler  extends TriggerHandler{
 public BillingItemTriggerHandler() { 
    //this.setMaxLoopCount(10);
  }
  
  
      protected override void afterInsert() {
    	System.debug('BillingItem Handler afterInsert');    	
    	
    	  for(Id itemId : Trigger.newMap.keySet()) {
      	System.debug('BillingItem Business Unit: '+((Billing_Item__c)Trigger.newMap.get(itemId)).Business_Unit__c);
      	
	      if(((Billing_Item__c)Trigger.newMap.get(itemId)).Business_Unit__c == 'vAuto') {	      
			//vAuto
			System.debug('vAuto Billing Item');    
	      new vAutoBillingItemHandler().afterInsert((Billing_Item__c)Trigger.newMap.get(itemId));
	      }
    	  }
    }
  
    protected override void afterUpdate() {
    	System.debug('BillingItem Handler afterUpdate');    	
    	
    	  for(Id itemId : Trigger.newMap.keySet()) {
      	System.debug('BillingItem Business Unit: '+((Billing_Item__c)Trigger.newMap.get(itemId)).Business_Unit__c);
      	
	      if(((Billing_Item__c)Trigger.newMap.get(itemId)).Business_Unit__c == 'vAuto') {	      
			//vAuto
			System.debug('vAuto Billing Item');    
	      new vAutoBillingItemHandler().afterUpdate((Billing_Item__c)Trigger.newMap.get(itemId),(Billing_Item__c)Trigger.oldMap.get(itemId));
	      }
    	  }
    }

     protected override void beforeDelete() {
      System.debug('BillingItem Handler beforeDelete');
        for(Id itemId : Trigger.oldMap.keySet()) {
        System.debug('BillingItem Business Unit: '+((Billing_Item__c)Trigger.oldMap.get(itemId)).Business_Unit__c);
        
        if(((Billing_Item__c)Trigger.oldMap.get(itemId)).Business_Unit__c == 'vAuto') {       
      //vAuto
      System.debug('vAuto Billing Item');    
        new vAutoBillingItemHandler().beforeDelete((Billing_Item__c)Trigger.oldMap.get(itemId));
        }
        }

     }
}