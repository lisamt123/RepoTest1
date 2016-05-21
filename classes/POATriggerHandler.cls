public class POATriggerHandler extends TriggerHandler {
	public POATriggerHandler(){
		
	}
	
		  /****************************************
   * context method overrides
   ****************************************/
   
    protected override void afterInsert(){
    	system.debug('POA AFter Insert Trigger');
    	 for(Id poaId : Trigger.newMap.keySet()){
    	 if(((POA__c)Trigger.newMap.get(poaId)).RecordTypeId == StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id){
    	 		 new vAutoPOAHandler().afterInsert((POA__c)Trigger.newMap.get(poaId));	
    	 }    	 	
    	 }
    }
    
     protected override void afterUpdate(){
     	system.debug('POA AFter Update Trigger');
    	 for(Id poaId : Trigger.newMap.keySet()){
    	 if(((POA__c)Trigger.newMap.get(poaId)).RecordTypeId == StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id){
    	 		 new vAutoPOAHandler().afterUpdate((POA__c)Trigger.newMap.get(poaId),(POA__c)Trigger.oldMap.get(poaId));	
    	 }    	 	
    	 }
    }        
    
}