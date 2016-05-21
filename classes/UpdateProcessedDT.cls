global class UpdateProcessedDT implements Database.Batchable<sObject> {
	global Database.QueryLocator start(Database.BatchableContext BC) {
		return Database.getQueryLocator([SELECT Id, Processed_D_T__c FROM Zip_Postal_Code__c WHERE Processed_D_T__c = null]);
	}

   	global void execute(Database.BatchableContext BC, List<Zip_Postal_Code__c> zips) {
   		Datetime now = System.now();

		for(Zip_Postal_Code__c zip : zips) {
			zip.Processed_D_T__c = now;
		}

		Database.update(zips, false);
	}
	
	global void finish(Database.BatchableContext BC) {}
}