trigger SFDC_Timecard_Trigger on SFDC_Service_Timecard__c (after insert, after update) {

	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('SFDC_Timecard_Trigger')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  


	Set<Id> conIds = new Set<Id>();
	
	for(SFDC_Service_Timecard__c t : trigger.new) {
		
		conIds.add(t.Contact__c);
	}
	
	Map<Id, Contact> cons2update = new Map<Id, Contact>([Select Timecard_Completed__c, c.Id From Contact c where c.Id IN :conIds]);
	
	
	for(SFDC_Service_Timecard__c t : trigger.new) {
		
		if(t.Class_Status__c == 'Completed') {
			
			system.debug('Completed!');
			
			if(cons2update.get(t.Contact__c) != null) {
				
				cons2update.get(t.Contact__c).Timecard_Completed__c = true;
			}
		}
	}
	
	List<Contact> conList = cons2update.values();
	
	update(conList);

}