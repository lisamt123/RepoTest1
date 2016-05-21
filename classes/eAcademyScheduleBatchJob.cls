global class eAcademyScheduleBatchJob implements Schedulable {
	global void execute(SchedulableContext sc) {
		eAcademyBatchJob e = new eAcademyBatchJob();
		database.executebatch(e);
	}
}