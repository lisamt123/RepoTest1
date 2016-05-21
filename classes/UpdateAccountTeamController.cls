public with sharing class UpdateAccountTeamController {
	private ApexPages.StandardController stdController;
	
	public UpdateAccountTeamController(ApexPages.StandardController stdController) {
		this.stdController = stdController;
	}

	public PageReference initPage() {
		Account acct;

		if(stdController.getId() == null || !(stdController.getRecord() instanceOf Account)) {
			return null;
		} else {
			acct = (Account) stdController.getRecord();
		}

		acct.Update_Team_Members__c = true;
		update acct;

		return new PageReference('/' + acct.Id);
	}
}