global class scheduledAccountCaseUpdateInterface implements Schedulable{
	global void execute(SchedulableContext ctx)
	{
		//scheduledAccountCaseUpdateJob.updateAccountCase();
		String query = 'select Id, Status__c, Total_Cases__c, VS_Dealer_ID__c from Account where Status__c = \'Active\' AND AccountNumber != null';
		scheduledAccountCaseUpdateJob batchApex = new scheduledAccountCaseUpdateJob(query);
		ID batchprocessid = Database.executeBatch(batchApex, 1);
		
	}

	public static void start()
	{
		System.schedule('Update Account Case Total', '0 0 0 * * ?', new scheduledAccountCaseUpdateInterface());
	}		
}