public class ContractTriggerHandler extends TriggerHandler {
	public ContractTriggerHandler() {
		
	}

	/****************************************
   * context method overrides
   ****************************************/
  protected override void afterUpdate() {

  //Use LOB__c field to diffrentiate between BU
  for(Id contractId : Trigger.newMap.keySet()) {
  	
	System.debug('Contract LOB__c: '+((Contract)Trigger.newMap.get(contractId)).LOB__c);
	
  //VIN
  if(((Contract)Trigger.newMap.get(contractId)).LOB__c == 'VINSOLUTIONS') {	      	
	System.debug('VIN Contract');
  new VinContractHandler().afterUpdate((Contract)Trigger.newMap.get(contractId),(Contract)Trigger.oldMap.get(contractId));
  }

  //VAUTO
  if(((Contract)Trigger.newMap.get(contractId)).LOB__c == 'VAUTO') {	      	
	System.debug('VAUTO Contract');
  new vAutoContractHandler().afterUpdate((Contract)Trigger.newMap.get(contractId),(Contract)Trigger.oldMap.get(contractId));
  }
  }
}
}