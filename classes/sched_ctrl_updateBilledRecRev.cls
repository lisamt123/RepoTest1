global class sched_ctrl_updateBilledRecRev implements Schedulable {
	
	global void execute(SchedulableContext sc) {
		
		job_updateBilledRecRev j = new job_updateBilledRecRev();
		//Id jId = Database.executeBatch(j, 1);
		Id jId = Database.executeBatch(j);
	}

}