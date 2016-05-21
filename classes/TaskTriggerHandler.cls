public class TaskTriggerHandler  extends TriggerHandler {
	public TaskTriggerHandler() { 
    //this.setMaxLoopCount(10); 
    }

  /****************************************
   * context method overrides
   ****************************************/
	protected override void afterUpdate() {
  	for(Id taskId : Trigger.newMap.keySet()) {
  	  new TaskHandler().afterUpdate((Task)Trigger.newMap.get(taskId),(Task)Trigger.oldMap.get(taskId));
  	}
  }
}