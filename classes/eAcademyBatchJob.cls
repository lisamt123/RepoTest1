global class eAcademyBatchJob implements Database.Batchable<sObject> {
	
	global final String query;
	
	global eAcademyBatchJob() {
		//182.5 is half a year in days, so if it is older than 6 months, delete it
		query = 'SELECT Id, CreatedDate FROM eAcademy__c WHERE CreatedDate < LAST_N_DAYS:182';
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator(query);
	}

   	global void execute(Database.BatchableContext BC, List<sObject> scope) {
		delete scope;
		Database.EmptyRecycleBin(scope);
	}
	
	global void finish(Database.BatchableContext BC) {
		
	}
	
}