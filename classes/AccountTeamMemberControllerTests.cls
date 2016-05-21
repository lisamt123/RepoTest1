@isTest
private class AccountTeamMemberControllerTests {
	private static User u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, runningUser;
	private static District__c dist1, dist2, dist3, dist4, dist5, dist6, unknownDist;
	private static Region__c reg1, reg2, reg3, reg4, reg5, reg6, unknownReg;
	private static Business_Unit__c vat, vin, hay, unknownBU;
	private static Role_Definition__c rd1, rd2;
	private static Country__c country;
	private static Zip_Postal_Code__c zip1, zip2;
	private static State_Province__c state1, state2;
	private static Related_Zip_Postal_Code__c rZip1, rZip2, rZip3, rZip4, rZip5, rZip6;
	private static Account acct, mergeAcct;
	private static SFDC_520_Quote__c proj;

	static testMethod void testAccountTMViewController() {
		setup();

		ApexPages.StandardController stdController = new ApexPages.StandardController(acct);
		ViewAccountTeamController viewController = new ViewAccountTeamController(stdController);
		viewController.init();

		Set<Id> regUserIds = new Set<Id> { u4.Id, u5.Id };
		Set<Id> distUserIds = new Set<Id> { u7.Id, u8.Id, u9.Id, u10.Id };

		if(viewController.tmHelperMap.isEmpty()) {
			System.assert(false, 'This map should contain team members at this point.');
		}

		for(AccountTMHelper atmh : viewController.tmHelperMap.values()) {
			if(atmh.source.equalsIgnoreCase('District')) {
				System.assert(distUserIds.contains(atmh.userId));
			} else if(atmh.source.equalsIgnoreCase('Region')) {
				System.assert(regUserIds.contains(atmh.userId));
			} else {
				System.assert(false, 'All account team member helpers should have a source of either region or district.');
			}
		}

		viewController.memberId = u4.Id;
		viewController.deleteMember();

		stdController = new ApexPages.StandardController(acct);
		viewController = new ViewAccountTeamController(stdController);
		viewController.init();

		System.assertEquals(5, viewController.tmHelperMap.size());
	}

	static testMethod void testAccountTMAddController() {

		setup();
		ApexPages.StandardController stdController = new ApexPages.StandardController(acct);
		AddTeamMemberController addController = new AddTeamMemberController(stdController);
		addController.init();
		addController.save();

		addController.atmh.setUserId(u1.Id);
		addController.atmh.acctShare = new AccountShare(
			AccountAccessLevel = 'Edit',
			CaseAccessLevel = 'Edit',
			ContactAccessLevel = 'Edit',
			OpportunityAccessLevel = 'Edit',
			AccountId = acct.Id
		);
		addController.save();
		addController.atmh.tm.TeamMemberRole = 'Vin Performance Manager';
		addController.save();
		addController.cancel();
		addController.addError('This is a test error.');

		List<AccountTeamMember> atms = loadATMS(acct.Id);
		System.assertEquals(7, atms.size());
	}

	static testMethod void testAccountTMEditController() {
		setup();

		PageReference testPr = Page.EditTeamMember;
		Map<String, String> paramMap = testPr.getParameters();
		paramMap.put('UserId', u4.Id);
		Test.setCurrentPage(testPr);

		proj = loadProject(proj.Id);
		System.assertEquals(null, proj.Vin_Performance_Manager__c);
		System.assertEquals(null, proj.WAM_Digital_Marketing_Advisor__c);

		ApexPages.StandardController stdController = new ApexPages.StandardController(acct);
		EditTeamMemberController editController = new EditTeamMemberController(stdController);
		editController.init();

		editController.atmh.tm.userId = u1.Id;
		editController.atmh.acctShare.AccountAccessLevel = 'Edit';
		editController.atmh.acctShare.CaseAccessLevel = 'Edit';
		editController.atmh.acctShare.ContactAccessLevel = 'Edit';
		editController.atmh.acctShare.OpportunityAccessLevel = 'Edit';
		editController.atmh.tm.TeamMemberRole = 'Vin Performance Manager';
		editController.save();
		editController.addError('This is a Test error');

		List<AccountTeamMember> atms = loadATMS(acct.Id);
		System.assertEquals(6, atms.size());

		Set<Id> userIds = new Set<Id> { u1.Id, u5.Id, u7.Id, u8.Id, u9.Id, u10.Id };
		for(AccountTeamMember tm : atms) {
			System.assert(userIds.contains(tm.UserId));
		}

		proj = loadProject(proj.Id);
		System.assertEquals(u1.Id, proj.Vin_Performance_Manager__c);
		System.assertEquals(null, proj.WAM_Digital_Marketing_Advisor__c);
	}

	static testMethod void testProjectControllerSync() {
		setup();

		ApexPages.StandardController stdController = new ApexPages.StandardController(acct);
		AddTeamMemberController addController = new AddTeamMemberController(stdController);
		addController.init();

		addController.atmh.setUserId(u1.Id);
		addController.atmh.acctShare = new AccountShare(
			AccountAccessLevel = 'Edit',
			CaseAccessLevel = 'Edit',
			ContactAccessLevel = 'Edit',
			OpportunityAccessLevel = 'Edit',
			AccountId = acct.Id
		);
		addController.atmh.tm.TeamMemberRole = 'Vin Performance Manager';
		addController.save();

		addController.init();
		addController.atmh.setUserId(u2.Id);
		addController.atmh.acctShare = new AccountShare(
			AccountAccessLevel = 'Edit',
			CaseAccessLevel = 'Edit',
			ContactAccessLevel = 'Edit',
			OpportunityAccessLevel = 'Edit',
			AccountId = acct.Id
		);
		addController.atmh.tm.TeamMemberRole = 'Website Account Manager';
		addController.save();

		proj = loadProject(proj.Id);
		System.assertEquals(u1.Id, proj.Vin_Performance_Manager__c);
		System.assertEquals(u2.Id, proj.WAM_Digital_Marketing_Advisor__c);

		ViewAccountTeamController viewController = new ViewAccountTeamController(stdController);
		viewController.init();
		viewController.memberId = u1.Id;
		viewController.deleteMember();

		viewController.init();
		viewController.memberId = u2.Id;
		viewController.deleteMember();

		proj = loadProject(proj.Id);
		System.assertEquals(null, proj.Vin_Performance_Manager__c);
		System.assertEquals(null, proj.WAM_Digital_Marketing_Advisor__c);
	}

	static testMethod void testProjectSyncTriggers() {
		setup();

		AccountTeamMember atm1, atm2;
		atm1 = new AccountTeamMember(
			UserId = u1.Id,
			AccountId = acct.Id,
			TeamMemberRole = 'Vin Performance Manager'
		);
		atm2 = new AccountTeamMember(
			UserId = u2.Id,
			AccountId = acct.Id,
			TeamMemberRole = 'Website Account Manager'
		);
		insert new List<AccountTeamMember> { atm1, atm2 };

		proj.Approval_Stage__c = 'GO LIVE';
		update proj;

		proj = loadProject(proj.Id);
		System.assertEquals(null, proj.Vin_Performance_Manager__c);
		System.assertEquals(null, proj.WAM_Digital_Marketing_Advisor__c);

		proj.Approval_Stage__c = null;
		update proj;

		proj = loadProject(proj.Id);
		System.assertEquals(u1.Id, proj.Vin_Performance_Manager__c);
		System.assertEquals(u2.Id, proj.WAM_Digital_Marketing_Advisor__c);

		delete proj;
		delete atm2;
		undelete proj;

		proj = loadProject(proj.Id);
		System.assertEquals(u1.Id, proj.Vin_Performance_Manager__c);
		System.assertEquals(null, proj.WAM_Digital_Marketing_Advisor__c);
	}

	static List<AccountTeamMember> loadATMS(Id acctId) {
		return [SELECT Id, AccountId, UserId FROM AccountTeamMember WHERE AccountId = :acctId];
	}

	static SFDC_520_Quote__c loadProject(Id projId) {
		return [SELECT Id, Vin_Performance_Manager__c, WAM_Digital_Marketing_Advisor__c FROM SFDC_520_Quote__c WHERE Id = :projId];
	}

	static Region__c newRegion(String name, Id buId) {
		return new Region__c(
			Name = name,
			Business_Unit__c = buId,
			Allow_Deletion__c = true
		);
	}

	static District__c newDistrict(String name, Id regId, Id buId) {
		return new District__c(
			Name = name,
			Region__c = regId,
			Business_Unit__c = buId,
			Allow_Deletion__c = true
		);
	}

	static Business_Unit__c newBU(String name) {
		return new Business_Unit__c(
			Name = name
		);
	}

	static Role_Definition__c newRD(String name, Id buId, String acctAcc, String caseAcc, String contAcc, String oppAcc, Boolean isManager) {
		return new Role_Definition__c(
			Name = name,
			Business_Unit__c = buId,
			Account_Access__c = acctAcc,
			Case_Access__c = caseAcc,
			Contact_Access__c = contAcc,
			Opportunity_Access__c = oppAcc,
			Opp_Regional_Manager__c = isManager
		);
	}

	static State_Province__c newState(String name, Id countryId) {
		return new State_Province__c(
			Name = name,
			Country__c = countryId
		);
	}

	static Zip_Postal_Code__c newZip(String name, Id stateId) {
		return new Zip_Postal_Code__c(
			Name = name,
			State_Province__c = stateId
		);
	}

	static Related_State_Province__c newRelState(Id distId, Id stateId) {
		return new Related_State_Province__c(
			District__c = distId,
			State_Province__c = stateId
		);
	}

	static Related_Zip_Postal_Code__c newRelZip(Id distId, Id zipId) {
		return new Related_Zip_Postal_Code__c(
			District__c = distId,
			Zip_Postal_Code__c = zipId,
			Processed_D_T__c = System.now()
		);
	}

	static POA__c newPOA(Id userId, Id acctId) {
		return new POA__c(
			Account_Director__c = userId,
			Dealer__c = acctId
		);
	}

	static User newUser(String userNum, Id profId) {
    	return new User(
			FirstName = 'User',
			LastName = userNum,
			Alias = 'U' + userNum,
			CommunityNickname = 'U' + userNum,
			Email = 'userEmail@' + userNum + '.com',
			Username = 'userEmail@' + userNum + '.com',
			TimeZoneSidKey = 'America/Los_Angeles',
			LocaleSidKey = 'en_US',
			LanguageLocaleKey = 'en_US',
			EmailEncodingKey = 'ISO-8859-1',
			ProfileId = profId
		);
    }

    private static void setup() {
    	Advanced_Team_Management__c atmCs = new Advanced_Team_Management__c(Enable_Account_Team_Triggers__c = true);
    	insert atmCs;

		Profile prof = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];

		u1 = newUser('One', prof.Id);
		u2 = newUser('Two', prof.Id);
		u3 = newUser('Three', prof.Id);
		u4 = newUser('Four', prof.Id);
		u5 = newUser('Five', prof.Id);
		u6 = newUser('Six', prof.Id);
		u7 = newUser('Seven', prof.Id);
		u8 = newUser('Eight', prof.Id);
		u9 = newUser('Nine', prof.Id);
    	u10 = newUser('Ten', prof.Id);
		insert new List<User> { u1, u2, u3, u4, u5, u6, u7, u8, u9, u10 };

		vat = newBU('VAT');
		vin = newBU('VIN');
		hay = newBU('HAY');
		unknownBU = newBU('Unknown');
		insert new List<Business_Unit__c> { vat, vin, hay, unknownBU };

		rd1 = newRD('RD1', hay.Id, 'Read/Write', 'Read Only', 'Read/Write', 'Read Only', false);
		rd2 = newRD('RD2', vin.Id, 'Read Only', 'Read/Write', 'Read Only', 'Read/Write', true);
		insert new List<Role_Definition__c> { rd1, rd2 };

		reg1 = newRegion('New York (VAT)', vat.Id);
		reg1.User_1__c = u1.Id;
		reg1.Role_1__c = rd1.Id;
		
		reg2 = newRegion('New York (VIN)', vin.Id);
		reg2.User_2__c = u2.Id;
		reg2.Role_2__c = rd1.Id;

		reg3 = newRegion('New York (HAY)', hay.Id);
		reg3.User_3__c = u3.Id;
		reg3.Role_3__c = rd1.Id;

		reg4 = newRegion('California (VAT)', vat.Id);
		reg4.User_4__c = u4.Id;
		reg4.Role_4__c = rd1.Id;

		reg5 = newRegion('California (VIN)', vin.Id);
		reg5.User_5__c = u4.Id;
		reg5.Role_5__c = rd2.Id;

		reg6 = newRegion('California (HAY)', hay.Id);
		reg6.User_1__c = u5.Id;
		reg6.Role_1__c = rd2.Id;

		unknownReg = newRegion('Unknown', unknownBU.Id);
		insert new List<Region__c> { reg1, reg2, reg3, reg4, reg5, reg6, unknownReg };

		dist1 = newDistrict('New York (VAT)', reg1.Id, vat.Id);
		dist1.User_1__c = u1.Id;
		dist1.User_2__c = u2.Id;
		dist1.Role_1__c = rd1.Id;
		dist1.Role_2__c = rd1.Id;

		dist2 = newDistrict('New York (VIN)', reg2.Id, vin.Id);
		dist2.User_3__c = u3.Id;
		dist2.User_4__c = u4.Id;
		dist2.Role_3__c = rd1.Id;
		dist2.Role_4__c = rd1.Id;

		dist3 = newDistrict('New York (HAY)', reg3.Id, hay.Id);
		dist3.User_5__c = u5.Id;
		dist3.User_6__c = u6.Id;
		dist3.Role_5__c = rd1.Id;
		dist3.Role_6__c = rd1.Id;

		dist4 = newDistrict('California (VAT)', reg4.Id, vat.Id);
		dist4.User_7__c = u7.Id;
		dist4.User_8__c = u8.Id;
		dist4.Role_7__c = rd1.Id;
		dist4.Role_8__c = rd1.Id;

		dist5 = newDistrict('California (VIN)', reg5.Id, vin.Id);
		dist5.User_9__c = u9.Id;
		dist5.User_10__c = u10.Id;
		dist5.Role_9__c = rd1.Id;
		dist5.Role_10__c = rd1.Id;

		dist6 = newDistrict('California (HAY)', reg6.Id, hay.Id);
		dist6.User_1__c = u7.Id;
		dist6.User_2__c = u8.Id;
		dist6.Role_1__c = rd2.Id;
		dist6.Role_2__c = rd1.Id;

		unknownDist = newDistrict('Unknown', unknownReg.Id, unknownBU.Id);
		unknownDist.Unknown_District__c = true;
		insert new List<District__c> { dist1, dist2, dist3, dist4, dist5, dist6, unknownDist };

		country = new Country__c(
			Name = 'United States'
		);
		insert country;

		state1 = newState('NY', country.Id);
		state2 = newState('CA', country.Id);
		insert new List<State_Province__c> { state1, state2 };

		zip1 = newZip('10011', state1.Id);
		zip2 = newZip('92675', state2.Id);
		insert new List<Zip_Postal_Code__c> { zip1, zip2 };

		rZip1 = newRelZip(dist1.Id, zip1.Id);
		rZip2 = newRelZip(dist2.Id, zip1.Id);
		rZip3 = newRelZip(dist3.Id, zip1.Id);
		rZip4 = newRelZip(dist4.Id, zip2.Id);
		rZip5 = newRelZip(dist5.Id, zip2.Id);
		rZip6 = newRelZip(dist6.Id, zip2.Id);
		insert new List<Related_Zip_Postal_Code__c> { rZip1, rZip2, rZip3, rZip4, rZip5, rZip6 };

		acct = new Account(
			Name = 'Acct 1',
			ShippingStreet = 'Shipping Street',
			ShippingCity = 'Shipping City',
			ShippingState = 'KY',
			ShippingPostalCode = '92675',
			BillingStreet = '123 Electric Ave',
			BillingCity = 'Power City',
			BillingState = 'KY',
			BillingPostalCode = '92675',
			/*DDM_Override__c = true,*/
			WAM_Override__c = true,
			VinPro_Override__c = true
		);
		insert acct;

		proj = new SFDC_520_Quote__c(
			Name = 'Test Proj',
			Account__c = acct.Id
		);
		insert proj;
	}

	private static void setupRunningUser() {
		Profile prof = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
		runningUser = newUser('Running', prof.Id);
		insert runningUser;
	}

	private static void insertRelZips() {
		insert new List<Related_Zip_Postal_Code__c> { rZip1, rZip2, rZip3, rZip4, rZip5, rZip6 };
	}
}