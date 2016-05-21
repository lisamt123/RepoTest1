public with sharing class StartAccountTeamSyncController {
	public StartAccountTeamSyncController() {}

	public PageReference init() {
		Database.executeBatch(new AccountTeamUpdater(), 50);

		String retId = Apexpages.currentPage().getParameters().get('retId');

		return new PageReference('/' + retId);
	}
}