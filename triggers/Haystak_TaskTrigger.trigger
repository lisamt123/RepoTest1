/**
 * @author			Pranav Raulkar
 * @date            29/05/2015
 * @version			1.0
 * @description     Trigger for Task.
 */
trigger Haystak_TaskTrigger on Task (after insert, after delete, after update) {
	if(Trigger.isAfter) {
		if(Trigger.newMap != null){//added this if statement because I was getting an attempt to dereference a null object when deleting other BU tasks
			for(Id taskId : Trigger.newMap.keySet()) {
	      		if(((Task)Trigger.newMap.get(taskId)).Business_Unit__c == 'Haystak') {
					Haystak_TaskTriggerHandler.updateTaskCountOnPOA();
				}
			}
		}
		else if(Trigger.oldMap != null){
			for(Id taskId : Trigger.oldMap.keySet()) {
	      		if(((Task)Trigger.oldMap.get(taskId)).Business_Unit__c == 'Haystak') {
					Haystak_TaskTriggerHandler.updateTaskCountOnPOA();
				}
			}
		}
	}
}