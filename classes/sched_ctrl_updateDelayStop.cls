global class sched_ctrl_updateDelayStop implements Schedulable {
	
	global void execute(SchedulableContext sc) {
		
		job_updateDelayStop j = new job_updateDelayStop();
		//Id jId = Database.executeBatch(j, 1);
		Id jId = Database.executeBatch(j, 1);
	}
}