public Interface IOpportunityHandler {
  //context-specific methods
  void beforeInsert(Opportunity opp);
  void beforeUpdate(Opportunity newOpp, Opportunity oldOpp);
  void beforeDelete(Opportunity Opp);
  void afterInsert(Opportunity Opp);
  void afterUpdate(Opportunity newOpp, Opportunity oldOpp);
  void afterDelete(Opportunity Opp);
  void afterUndelete(Opportunity opp);
}