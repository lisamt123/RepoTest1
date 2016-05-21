public Interface IProjectHandler {
  //context-specific methods
  void beforeInsert(SFDC_520_Quote__c proj);
  void beforeUpdate(SFDC_520_Quote__c newProj, SFDC_520_Quote__c oldProj);
  void beforeDelete(SFDC_520_Quote__c proj);
  void afterInsert(SFDC_520_Quote__c proj);
  void afterUpdate(SFDC_520_Quote__c newProj, SFDC_520_Quote__c oldProj);
  void afterDelete(SFDC_520_Quote__c proj);
  void afterUndelete(SFDC_520_Quote__c proj);
}