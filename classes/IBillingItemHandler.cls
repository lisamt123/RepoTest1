public interface IBillingItemHandler {
    //context-specific methods
  void beforeInsert(Billing_Item__c billingItem);
  void beforeUpdate(Billing_Item__c newbillingItem, Billing_Item__c oldbillingItem);
  void beforeDelete(Billing_Item__c billingItem);
  void afterInsert(Billing_Item__c billingItem);
  void afterUpdate(Billing_Item__c newbillingItem, Billing_Item__c oldbillingItem);
  void afterDelete(Billing_Item__c billingItem);
  void afterUndelete(Billing_Item__c billingItem);
  
}