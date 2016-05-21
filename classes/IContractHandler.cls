public Interface IContractHandler {
  //context-specific methods
  void beforeInsert(Contract contract);
  void beforeUpdate(Contract newContract, Contract oldContract);
  void beforeDelete(Contract contract);
  void afterInsert(Contract contract);
  void afterUpdate(Contract newContract, Contract oldContract);
  void afterDelete(Contract contract);
  void afterUndelete(Contract contract);
}