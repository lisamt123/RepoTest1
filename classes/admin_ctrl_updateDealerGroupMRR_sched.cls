global class admin_ctrl_updateDealerGroupMRR_sched implements Schedulable {
	
	global void execute(SchedulableContext sc) {
		
		job_updateDealerGroupMRR j = new job_updateDealerGroupMRR();
		Id jId = Database.executeBatch(j, 5);
	}
}