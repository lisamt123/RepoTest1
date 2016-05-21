public class OpportunityTriggerHandler extends TriggerHandler {
  public OpportunityTriggerHandler() { 
    //this.setMaxLoopCount(10); 
  }
 
  /****************************************
   * context method overrides
   ****************************************/
  protected override void beforeInsert() {
  	
  
    for(Opportunity o : (List<Opportunity>) Trigger.new) {        
      if(o.RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('vAuto').Id
      ||o.RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('vAuto_Conquest').Id) {
		new vAutoOpportunityHandler().beforeInsert(o);
      }
      //else if( o.RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('Directors').Id
      	//|| o.RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('General_Sales').Id)
      	else if( o.RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('General_Sales').Id)
      	{
              	//VIN 
              	new VinOpportunityHandler().beforeInsert(o); 
      	}
      else if(o.RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('Digital_Marketing').Id)      	
      	{
        		//Haystak
        		new HaystakOpportunityHandler().beforeInsert(o); 
      	}
      }
    }
    
        protected override void beforeUpdate() {
    	System.debug('Opportunity Handler beforeUpdate');
    	
      for(Id oppId : Trigger.newMap.keySet()) {
      	System.debug('Opportunity RecordsTypeId: '+((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId);
      	
	      if(((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('vAuto').Id
	         ||((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('vAuto_Conquest').Id) {	      
			//vAuto
			System.debug('vAuto Opportunity');    
	      new vAutoOpportunityHandler().beforeUpdate((Opportunity)Trigger.newMap.get(oppId),(Opportunity)Trigger.oldMap.get(oppId));
	      }
      }
      }
    protected override void afterUpdate() {
    	System.debug('Opportunity Handler afterUpdate');
    	
      for(Id oppId : Trigger.newMap.keySet()) {
      	System.debug('Opportunity RecordsTypeId: '+((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId);
      	
	      if(((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('vAuto').Id
	         ||((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('vAuto_Conquest').Id) {	      
			//vAuto
			System.debug('vAuto Opportunity');    
	      new vAutoOpportunityHandler().afterUpdate((Opportunity)Trigger.newMap.get(oppId),(Opportunity)Trigger.oldMap.get(oppId));
	      }
	      //else if(((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('Directors').Id
	      //|| ((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('General_Sales').Id){
	      //Ramana: 09282014: As per Mark, we nologer use Directors RecordType 
	      else if(((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('General_Sales').Id){	      	
	      	//VIN
	      	System.debug('VIN Opportunity');
	      	new VinOpportunityHandler().afterUpdate((Opportunity)Trigger.newMap.get(oppId),(Opportunity)Trigger.oldMap.get(oppId));
	      }
	      else if(((Opportunity)Trigger.newMap.get(oppId)).RecordTypeId == StaticData.getInstance().OpportunityRecTypesMapByDevName.get('Digital_Marketing').Id){
	        //Haystak
	        System.debug('Haystack Opportunity');
	        new HaystakOpportunityHandler().afterUpdate((Opportunity)Trigger.newMap.get(oppId),(Opportunity)Trigger.oldMap.get(oppId));
	      }
      }     
    }
}