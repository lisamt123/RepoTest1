public class ProjectTriggerHandler extends TriggerHandler {
	public ProjectTriggerHandler(){
		
	}
	
	  /****************************************
   * context method overrides
   ****************************************/
   
    protected override void afterUpdate(){
    	 for(Id projId : Trigger.newMap.keySet()){
    	 if(((SFDC_520_Quote__c)Trigger.newMap.get(projId)).RecordTypeId == StaticData.getInstance().ProjectRecTypesMapByDevName.get('vAuto').Id){
    	 		 new vAutoProjectHandler().afterUpdate((SFDC_520_Quote__c)Trigger.newMap.get(projId),(SFDC_520_Quote__c)Trigger.oldMap.get(projId));	
    	 }    	 	
    	 }
    }    
}