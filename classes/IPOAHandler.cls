public interface IPOAHandler {
    //context-specific methods
  void beforeInsert(POA__c poa);
  void beforeUpdate(POA__c newpoa, POA__c oldpoa);
  void beforeDelete(POA__c poa);
  void afterInsert(POA__c poa);
  void afterUpdate(POA__c newpoa, POA__c oldpoa);
  void afterDelete(POA__c poa);
  void afterUndelete(POA__c poa);
}