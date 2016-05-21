public abstract class BillingItemHandler implements IBillingItemHandler {
//context-specific methods
  public virtual void beforeInsert(Billing_Item__c billingItem){}
  public virtual void beforeUpdate(Billing_Item__c newbillingItem, Billing_Item__c oldbillingItem){}
  public virtual void beforeDelete(Billing_Item__c billingItem){}
  public virtual void afterInsert(Billing_Item__c billingItem){}
  public virtual void afterUpdate(Billing_Item__c newbillingItem, Billing_Item__c oldbillingItem){}
  public virtual void afterDelete(Billing_Item__c billingItem){}
  public virtual void afterUndelete(Billing_Item__c billingItem){}
  
}