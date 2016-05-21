@isTest
private class AccountDistrictRegionTests {
	private static User u1, u2, u3, u4, u5, u6, u7, u8, u9, u10, runningUser;
	private static District__c dist1, dist2, dist3, dist4, dist5, dist6, unknownDist;
	private static Region__c reg1, reg2, reg3, reg4, reg5, reg6, unknownReg;
	private static Business_Unit__c vat, vin, hay, unknownBU;
	private static Role_Definition__c rd1, rd2;
	private static Country__c country;
	private static Zip_Postal_Code__c zip1, zip2;
	private static State_Province__c state1, state2;
	private static Related_Zip_Postal_Code__c rZip1, rZip2, rZip3, rZip4, rZip5, rZip6;
	private static Related_State_Province__c rState1, rState2, rState3, rState4, rState5, rState6;
	private static Account acct, mergeAcct;

	static testMethod void testInsertUnknown() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();	

			insert acct;

			acct = loadAccount(acct.Id);
			System.assertEquals(unknownDist.Id, acct.VAT_District__c);
			System.assertEquals(unknownDist.Id, acct.VIN_District__c);
			System.assertEquals(unknownDist.Id, acct.HAY_District__c);
			System.assertEquals(unknownReg.Id, acct.VAT_Region__c);
			System.assertEquals(unknownReg.Id, acct.VIN_Region__c);
			System.assertEquals(unknownReg.Id, acct.HAY_Region__c);
			System.assertEquals(null, acct.Zip_Postal_Code__c);
		}
	}

	static testMethod void testManualMerge() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			insert acct;

			AccountTeamMember atm = new AccountTeamMember(
				AccountId = acct.Id,
				UserId = u10.Id
			);
			AccountShare acctShare = new AccountShare(
				AccountId = acct.Id,
				UserOrGroupId = u10.Id,
				AccountAccessLevel = 'Edit',
				OpportunityAccessLevel = 'Edit',
				CaseAccessLevel = 'Edit',
				ContactAccessLevel = 'Edit'
			);
			insert atm;
			insert acctShare;

			acct.ShippingPostalCode = '92675';
			update acct;

			Map<Id, AccountShare> acctShares = loadAcctShares(acct.Id);
			AccountShare share = acctShares.get(u10.Id);

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(6, atms.size());
			System.assertEquals('Edit', share.AccountAccessLevel);
			//System.assertEquals('Edit', share.CaseAccessLevel);
			System.assertEquals('Edit', share.ContactAccessLevel);
			//System.assertEquals('Edit', share.OpportunityAccessLevel);
		}
	}

	static testMethod void testInsertKnown() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '10011';
			insert acct;

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(dist1.Id, acct.VAT_District__c);
			System.assertEquals(dist2.Id, acct.VIN_District__c);
			System.assertEquals(dist3.Id, acct.HAY_District__c);
			System.assertEquals(reg1.Id, acct.VAT_Region__c);
			System.assertEquals(reg2.Id, acct.VIN_Region__c);
			System.assertEquals(reg3.Id, acct.HAY_Region__c);
			System.assertEquals(zip1.Id, acct.Zip_Postal_Code__c);
			System.assertEquals(6, atms.size());
		}
	}

	static testMethod void testUpdateFromUnknown() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			insert acct;

			acct.ShippingPostalCode = '10011';
			update acct;

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(dist1.Id, acct.VAT_District__c);
			System.assertEquals(dist2.Id, acct.VIN_District__c);
			System.assertEquals(dist3.Id, acct.HAY_District__c);
			System.assertEquals(reg1.Id, acct.VAT_Region__c);
			System.assertEquals(reg2.Id, acct.VIN_Region__c);
			System.assertEquals(reg3.Id, acct.HAY_Region__c);
			System.assertEquals(zip1.Id, acct.Zip_Postal_Code__c);
			System.assertEquals(6, atms.size());

			Set<Id> userIds = new Set<Id> { u1.Id, u2.Id, u3.Id, u4.Id, u5.Id, u6.Id };
			for(AccountTeamMember atm : atms) {
				System.assert(userIds.contains(atm.UserId));
			}
		}
	}

	static testMethod void testUpdateToUnknownWithManualAdd() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '10011';
			insert acct;

			AccountTeamMember atm = new AccountTeamMember(
				AccountId = acct.Id,
				TeamMemberRole = 'Vin Account Manager',
				UserId = u10.Id
			);
			insert atm;

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(7, atms.size());

			acct.ShippingState = 'ZY';
			acct.ShippingPostalCode = '99999';
			update acct;

			acct = loadAccount(acct.Id);
			atms = loadATMS(acct.Id);
			System.assertEquals(unknownDist.Id, acct.VAT_District__c);
			System.assertEquals(unknownDist.Id, acct.VIN_District__c);
			System.assertEquals(unknownDist.Id, acct.HAY_District__c);
			System.assertEquals(unknownReg.Id, acct.VAT_Region__c);
			System.assertEquals(unknownReg.Id, acct.VIN_Region__c);
			System.assertEquals(unknownReg.Id, acct.HAY_Region__c);
			System.assertEquals(null, acct.Zip_Postal_Code__c);
			System.assertEquals(1, atms.size());
		}
	}

	static testMethod void testUpdateWithDeleteDistrict() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(6, atms.size());

			dist5.User_10__c = null;
			dist5.Role_10__c = null;
			update dist5;

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			atms = loadATMS(acct.Id);
			System.assertEquals(5, atms.size());
		}
	}

	static testMethod void testUpdateWithDeleteRegion() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			acct = loadAccount(acct.Id);
			System.assertEquals(acct.HAY_Region__c, reg6.Id);

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(6, atms.size());

			Set<Id> userIds = new Set<Id> { u4.Id, u5.Id, u7.Id, u8.Id, u9.Id, u10.Id };
			for(AccountTeamMember atm : atms) {
				System.assert(userIds.contains(atm.UserId));
			}

			reg6.User_1__c = null;
			reg6.Role_1__c = null;
			update reg6;

			reg6 = loadRegion(reg6.Id);
			System.assertEquals(null, reg6.Processed_D_T__c);
			System.assertEquals(u5.Id, reg6.User_1_Prior_Value__c);

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			reg6 = loadRegion(reg6.Id);
			System.assertNotEquals(null, reg6.Processed_D_T__c);
			System.assertEquals(null, reg6.User_1_Prior_Value__c);
		}
	}

	static testMethod void testUpdateToNewZipCode() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '10011';
			insert acct;

			acct.ShippingPostalCode = '92675';
			update acct;

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(dist4.Id, acct.VAT_District__c);
			System.assertEquals(dist5.Id, acct.VIN_District__c);
			System.assertEquals(dist6.Id, acct.HAY_District__c);
			System.assertEquals(reg4.Id, acct.VAT_Region__c);
			System.assertEquals(reg5.Id, acct.VIN_Region__c);
			System.assertEquals(reg6.Id, acct.HAY_Region__c);
			System.assertEquals(zip2.Id, acct.Zip_Postal_Code__c);
			System.assertEquals(6, atms.size());

			Set<Id> userIds = new Set<Id> { u4.Id, u5.Id, u7.Id, u8.Id, u9.Id, u10.Id };
			for(AccountTeamMember atm : atms) {
				System.assert(userIds.contains(atm.UserId));
			}
		}
	}

	static testMethod void testAccountTeamMemberMerge() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();
			
			acct.ShippingPostalCode = '92675';
			insert acct;

			Map<Id, AccountTeamMember> acctTMS = loadATMMap(acct.Id);
			Map<Id, AccountShare> acctShares = loadAcctShares(acct.Id);
			AccountShare share = acctShares.get(u7.Id);
			System.assertEquals('Edit', share.AccountAccessLevel);
			System.assertEquals('Edit', share.CaseAccessLevel);
			System.assertEquals('Edit', share.ContactAccessLevel);
			System.assertEquals('Edit', share.OpportunityAccessLevel);
			
			/*
			AccountTeamMember atm = acctTMS.get(u7.Id);
			System.assertEquals('Vin Performance Manager', atm.TeamMemberRole);

			acct = loadAccount(acct.Id);
			System.assertNotEquals(null, acct.VinPro2__c);
			System.assertNotEquals(null, acct.Regional_Manager_Lookup__c);
			*/
		}
	}

	static testMethod void testAccountTeamUpdatePage() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			delete atms;

			PageReference pr = Page.UpdateAccountTeam;
			pr.getParameters().put('id', acct.Id);
			Test.setCurrentPage(pr);
			ApexPages.StandardController stdController = new ApexPages.StandardController(acct);
			UpdateAccountTeamController controller = new UpdateAccountTeamController(stdController);
			controller.initPage();

			atms = loadATMS(acct.Id);
			System.assertEquals(6, atms.size());
		}
	}

	static testMethod void testAccountTeamNoZipCode() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelStates();

			acct.ShippingState = 'CA';
			insert acct;

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(dist4.Id, acct.VAT_District__c);
			System.assertEquals(dist5.Id, acct.VIN_District__c);
			System.assertEquals(dist6.Id, acct.HAY_District__c);
			System.assertEquals(reg4.Id, acct.VAT_Region__c);
			System.assertEquals(reg5.Id, acct.VIN_Region__c);
			System.assertEquals(reg6.Id, acct.HAY_Region__c);
			System.assertEquals(null, acct.Zip_Postal_Code__c);
			System.assertEquals(6, atms.size());

			Set<Id> userIds = new Set<Id> { u4.Id, u5.Id, u7.Id, u8.Id, u9.Id, u10.Id };
			for(AccountTeamMember atm : atms) {
				System.assert(userIds.contains(atm.UserId));
			}
		}
	}

	static testMethod void testAccountTeamNoZipCodeUpdate() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelStates();

			acct.ShippingState = 'CA';
			insert acct;

			acct.ShippingState = 'NY';
			update acct;

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(dist1.Id, acct.VAT_District__c);
			System.assertEquals(dist2.Id, acct.VIN_District__c);
			System.assertEquals(dist3.Id, acct.HAY_District__c);
			System.assertEquals(reg1.Id, acct.VAT_Region__c);
			System.assertEquals(reg2.Id, acct.VIN_Region__c);
			System.assertEquals(reg3.Id, acct.HAY_Region__c);
			System.assertEquals(null, acct.Zip_Postal_Code__c);
			System.assertEquals(6, atms.size());

			Set<Id> userIds = new Set<Id> { u1.Id, u2.Id, u3.Id, u4.Id, u5.Id, u6.Id };
			for(AccountTeamMember atm : atms) {
				System.assert(userIds.contains(atm.UserId));
			}
		}
	}

	static testMethod void testAccountTeamNoRegions() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			delete new List<Region__c> { reg1, reg2, reg3, reg4, reg5, reg6 };
			acct.ShippingState = 'NY';
			acct.ShippingPostalCode = '10011';
			insert acct;

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(unknownDist.Id, acct.VAT_District__c);
			System.assertEquals(unknownDist.Id, acct.VIN_District__c);
			System.assertEquals(unknownDist.Id, acct.HAY_District__c);
			System.assertEquals(unknownReg.Id, acct.VAT_Region__c);
			System.assertEquals(unknownReg.Id, acct.VIN_Region__c);
			System.assertEquals(unknownReg.Id, acct.HAY_Region__c);
			System.assertEquals(zip1.Id, acct.Zip_Postal_Code__c);
			System.assertEquals(0, atms.size());
		}
	}

	static testMethod void testAccountTeamNoUndefined() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			delete unknownReg;
			insert acct;

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(null, acct.VAT_District__c);
			System.assertEquals(null, acct.VIN_District__c);
			System.assertEquals(null, acct.HAY_District__c);
			System.assertEquals(null, acct.VAT_Region__c);
			System.assertEquals(null, acct.VIN_Region__c);
			System.assertEquals(null, acct.HAY_Region__c);
			System.assertEquals(null, acct.Zip_Postal_Code__c);
			System.assertEquals(0, atms.size());

			acct.ShippingPostalCode = '10011';
			update acct;

			acct = loadAccount(acct.Id);
			atms = loadATMS(acct.Id);
			System.assertEquals(dist1.Id, acct.VAT_District__c);
			System.assertEquals(dist2.Id, acct.VIN_District__c);
			System.assertEquals(dist3.Id, acct.HAY_District__c);
			System.assertEquals(reg1.Id, acct.VAT_Region__c);
			System.assertEquals(reg2.Id, acct.VIN_Region__c);
			System.assertEquals(reg3.Id, acct.HAY_Region__c);
			System.assertEquals(zip1.Id, acct.Zip_Postal_Code__c);
			System.assertEquals(6, atms.size());
		}
	}

	static testMethod void testAccountBatchUpdaterZipCodes() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			delete atms;

			atms = loadATMS(acct.Id);
			System.assertEquals(0, atms.size());

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			atms = loadATMS(acct.Id);
			System.assertEquals(6, atms.size());

			for(District__c dist : loadDistricts()) {
				for(Integer i = 1; i <= 10; i++) {
					String userPriorValue = '' + 'User_' + i + '_Prior_Value__c';
					String rolePriorValue = '' + 'Role_' + i + '_Prior_Value__c';
					String userProcessedDT = '' + 'User_' + i + '_Processed_D_T__c';
					String roleProcessedDT = '' + 'Role_' + i + '_Processed_D_T__c';
					String distProcessedDT = 'Processed_D_T__c';

					System.assertEquals(null, dist.get(userPriorValue));
					System.assertEquals(null, dist.get(rolePriorValue));
					System.assertNotEquals(null, dist.get(userProcessedDT));
					System.assertNotEquals(null, dist.get(roleProcessedDT));
					System.assertNotEquals(null, dist.get(distProcessedDT));
				}
			}

			List<Zip_Postal_Code__c> zips = loadZipCodes();
			for(Zip_Postal_Code__c zip : zips) {
				System.assertNotEquals(null, zip.Processed_D_T__c);
			}

			List<Related_State_Province__c> relStates = loadRelStates();
			for(Related_State_Province__c relState : relStates) {
				System.assertNotEquals(null, relState.Processed_D_T__c);
			}
		}
	}

	static testMethod void testAccountBatchUpdaterStates() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelStates();

			acct.ShippingState = 'CA';
			insert acct;

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			delete atms;

			atms = loadATMS(acct.Id);
			System.assertEquals(0, atms.size());

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			atms = loadATMS(acct.Id);
			System.assertEquals(6, atms.size());

			for(District__c dist : loadDistricts()) {
				for(Integer i = 1; i <= 10; i++) {
					String userPriorValue = '' + 'User_' + i + '_Prior_Value__c';
					String rolePriorValue = '' + 'Role_' + i + '_Prior_Value__c';
					String userProcessedDT = '' + 'User_' + i + '_Processed_D_T__c';
					String roleProcessedDT = '' + 'Role_' + i + '_Processed_D_T__c';
					String distProcessedDT = 'Processed_D_T__c';

					System.assertEquals(null, dist.get(userPriorValue));
					System.assertEquals(null, dist.get(rolePriorValue));
					System.assertNotEquals(null, dist.get(userProcessedDT));
					System.assertNotEquals(null, dist.get(roleProcessedDT));
					System.assertNotEquals(null, dist.get(distProcessedDT));
				}
			}

			List<Related_State_Province__c> relStates = loadRelStates();
			for(Related_State_Province__c relState : relStates) {
				System.assertNotEquals(null, relState.Processed_D_T__c);
			}
		}
	}

	static testMethod void testAccountBatchUpdaterDelete() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			acct = loadAccount(acct.Id);
			/*
			System.assertNotEquals(null, acct.VinPro2__c);
			System.assertNotEquals(null, acct.Regional_Manager_Lookup__c);
			*/

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			delete atms;

			acct.Update_Team_Members__c = true;
			update acct;

			atms = loadATMS(acct.Id);
			//System.assertEquals(0, atms.size());

			/*
			acct = loadAccount(acct.Id);
			System.assertEquals(null, acct.VinPro2__c);
			System.assertEquals(null, acct.Regional_Manager_Lookup__c);
			*/
		}
	}

	static testMethod void testAccountUpdateTeamMember() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			delete atms;

			atms = loadATMS(acct.Id);
			System.assertEquals(0, atms.size());

			acct.Update_Team_Members__c = true;
			update acct;

			atms = loadATMS(acct.Id);
			System.assertEquals(6, atms.size());
		}
	}

	static testMethod void testRoleDefinitionUpdate() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			rd1.Contact_Access__c = 'Read Only';
			update rd1;

			for(District__c dist : loadDistricts()) {
				for(Integer i = 1; i <= 10; i++) {
					String role = '' + 'Role_' + i + '__c';
					String roleProcessedDT = '' + 'Role_' + i + '_Processed_D_T__c';

					if((Id) dist.get(role) == rd1.Id) {
						System.assertEquals(null, dist.get(roleProcessedDT));
					}
				}
			}
		}
	}

	static testMethod void testDistrictUserUpdate() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			dist4.User_7__c = u1.Id;
			update dist4;

			acct.Update_Team_Members__c = true;
			update acct;

			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(7, atms.size());

			Map<Id, AccountShare> acctShares = loadAcctShares(acct.Id);
			AccountShare share = acctShares.get(u7.Id);
			System.assertEquals('Read', share.AccountAccessLevel);
			System.assertEquals('Edit', share.CaseAccessLevel);
			System.assertEquals('Read', share.ContactAccessLevel);
			System.assertEquals('Edit', share.OpportunityAccessLevel);
		}
	}

	static testMethod void testDistrictRegionDeleteProtection() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();

			dist1.Allow_Deletion__c = false;
			update dist1;

			try {
				delete dist1;
				System.assert(false, 'This should have failed');
			} catch(Exception ex) {}

			reg1.Allow_Deletion__c = false;
			update reg1;

			try {
				delete reg1;
				System.assert(false, 'This should have failed');
			} catch (Exception ex) {}
		}
	}

	static testMethod void testZipCodeSwitch() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			rZip1.District__c = dist4.Id;
			rZip2.District__c = dist5.Id;
			rZip3.District__c = dist6.Id;
			rZip4.District__c = dist1.Id;
			rZip5.District__c = dist2.Id;
			rZip6.District__c = dist3.Id;
			update new List<Related_Zip_Postal_Code__c> { rZip1, rZip2, rZip3, rZip4, rZip5, rZip6 };

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(dist1.Id, acct.VAT_District__c);
			System.assertEquals(dist2.Id, acct.VIN_District__c);
			System.assertEquals(dist3.Id, acct.HAY_District__c);
			System.assertEquals(reg1.Id, acct.VAT_Region__c);
			System.assertEquals(reg2.Id, acct.VIN_Region__c);
			System.assertEquals(reg3.Id, acct.HAY_Region__c);
			System.assertEquals(zip2.Id, acct.Zip_Postal_Code__c);
			System.assertEquals(6, atms.size());

			Set<Id> userIds = new Set<Id> { u1.Id, u2.Id, u3.Id, u4.Id, u5.Id, u6.Id };
			for(AccountTeamMember atm : atms) {
				System.assert(userIds.contains(atm.UserId));
			}
		}
	}

	static testMethod void testStateSwitch() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelStates();

			acct.ShippingState = 'CA';
			insert acct;

			rState1.District__c = dist4.Id;
			rState2.District__c = dist5.Id;
			rState3.District__c = dist6.Id;
			rState4.District__c = dist1.Id;
			rState5.District__c = dist2.Id;
			rState6.District__c = dist3.Id;
			update new List<Related_State_Province__c> { rState1, rState2, rState3, rState4, rState5, rState6 };

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			acct = loadAccount(acct.Id);
			List<AccountTeamMember> atms = loadATMS(acct.Id);
			System.assertEquals(dist1.Id, acct.VAT_District__c);
			System.assertEquals(dist2.Id, acct.VIN_District__c);
			System.assertEquals(dist3.Id, acct.HAY_District__c);
			System.assertEquals(reg1.Id, acct.VAT_Region__c);
			System.assertEquals(reg2.Id, acct.VIN_Region__c);
			System.assertEquals(reg3.Id, acct.HAY_Region__c);
			System.assertEquals(null, acct.Zip_Postal_Code__c);
			System.assertEquals(6, atms.size());

			Set<Id> userIds = new Set<Id> { u1.Id, u2.Id, u3.Id, u4.Id, u5.Id, u6.Id };
			for(AccountTeamMember atm : atms) {
				System.assert(userIds.contains(atm.UserId));
			}
		}
	}

	static testMethod void testOpportunityRegionalManagerSync() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			acct.ShippingPostalCode = '92675';
			insert acct;

			RecordType rt = [SELECT Id, sObjectType, Name, DeveloperName, NamespacePrefix FROM RecordType WHERE DeveloperName = 'General_Sales'];

			Opportunity opp = new Opportunity(
				Name = 'New Opp',
				StageName = 'Prospect',
				CloseDate = System.today(),
				Add_Deposit__c = 'No',
				AccountId = acct.Id,
				RecordTypeId = rt.Id,
				ValidationRules__c = true
			);
			insert opp;

			opp = [SELECT Id, Regional_Manager_2__c FROM Opportunity WHERE Id = :opp.Id];

			//System.assertEquals(u9.Id, opp.Regional_Manager_2__c);
		}
	}

	static testMethod void testOpportunityRegionalManagerBatchSync() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();
			insertRelZips();

			insert acct;

			RecordType rt = [SELECT Id, sObjectType, Name, DeveloperName, NamespacePrefix FROM RecordType WHERE DeveloperName = 'General_Sales'];

			Opportunity opp = new Opportunity(
				Name = 'New Opp',
				StageName = 'Prospect',
				CloseDate = System.today(),
				Add_Deposit__c = 'No',
				AccountId = acct.Id,
				RecordTypeId = rt.Id,
				ValidationRules__c = true
			);
			insert opp;

			acct.ShippingPostalCode = '92675';
			update acct;

			Test.startTest();
			AccountTeamUpdater updated = new AccountTeamUpdater();
			Database.executeBatch(updated);
			Test.stopTest();

			opp = [SELECT Id, Regional_Manager_2__c FROM Opportunity WHERE Id = :opp.Id];

			//System.assertEquals(u9.Id, opp.Regional_Manager_2__c);
		}
	}

	static testMethod void testDeleteDistrictRegionBusinessUnit() {
		setupRunningUser();

		System.runAs(runningUser) {
			setup();

			dist1.Allow_Deletion__c = false;
			update dist1;

			reg1.Allow_Deletion__c = false;
			update reg1;

			vat.Allow_Deletion__c = false;
			update vat;

			try {
				delete dist1;
				System.assert(false, 'This should have failed.  Check the DistrictBeforeDeleteTrigger behavior.');
			} catch(Exception ex) {}

			try {
				delete reg1;
				System.assert(false, 'This should have failed.  Check the RegionBeforeDeleteTrigger behavior.');
			} catch(Exception ex) {}

			try {
				delete vat;
				System.assert(false, 'This should have failed.  Check the BusinessUnitBeforeDeleteTrigger behavior.');
			} catch(Exception ex) {}
		}
	}

	@isTest
	static void testOpportunities() {
		List<Opportunity> opps = [SELECT Id, Update_Regional_Manager__c
									FROM Opportunity 
									WHERE (IsClosed = false AND Business_Unit__c = 'VinSolutions') LIMIT 50];

		for(Opportunity opp : opps) {
			opp.Update_Regional_Manager__c = true;
			opp.ValidationRules__c = true;
		}

		update opps;
	}

	static testMethod void testAccountTMHelper() {
		setup();

		acct.ShippingPostalCode = '92675';
		insert acct;

		AccountTMHelper athAcct = new AccountTMHelper(acct.Id);
		System.assertEquals(athAcct.acctShare.AccountId, acct.Id);
		System.assertEquals(athAcct.tm.AccountId, acct.Id);

		AccountTeamMember atm = new AccountTeamMember();
		AccountTMHelper athTeamMember = new AccountTMHelper(atm);
		System.assertEquals(athTeamMember.tm, atm);

		AccountShare acctShare = new AccountShare();
		AccountTMHelper athShareTeamMember = new AccountTMHelper(atm, acctShare);
		System.assertEquals(athShareTeamMember.tm, atm);
		System.assertEquals(athShareTeamMember.acctShare, acctShare);

		athAcct.setUserId(u1.Id);
		System.assertEquals(athAcct.userId, u1.Id);

		athAcct.setAccountShare(acctShare);
		System.assertEquals(athAcct.acctShare, acctShare);
	}

	static testMethod void testAccountTMViewController() {
		setup();
		insertRelZips();

		acct.ShippingPostalCode = '92675';
		insert acct;

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
	}

	static Account loadAccount(Id acctId) {
		return [SELECT Id, HAY_District__c, HAY_Region__c, VIN_District__C, VIN_Region__c, VAT_District__c, VAT_Region__c, Zip_Postal_Code__c, WAM2__c, Regional_Manager_Lookup__c FROM Account WHERE Id = :acctId];
	}

	static District__c loadDistrict(Id distId) {
		Set<Id> distIds = new Set<Id>{ distId };
		String query = DistrictRegionSchemaUtility.generateQuery('District__c', 'Id', 'distIds');
		return (District__c) Database.query(query);
	}

	static List<District__c> loadDistricts() {
		Set<Id> distIds = new Set<Id>{ dist1.Id, dist2.Id, dist3.Id, dist4.Id, dist5.Id, dist6.Id };
		String query = DistrictRegionSchemaUtility.generateQuery('District__c', 'Id', 'distIds');
		return (List<District__c>) Database.query(query);
	}

	static Region__c loadRegion(Id regId) {
		Set<Id> regIds = new Set<Id>{ regId };
		String query = DistrictRegionSchemaUtility.generateQuery('Region__c', 'Id', 'regIds');
		return (Region__c) Database.query(query);
	}

	static List<Region__c> loadRegions() {
		Set<Id> RegIds = new Set<Id>{ Reg1.Id, Reg2.Id, Reg3.Id, Reg4.Id, Reg5.Id, Reg6.Id };
		String query = DistrictRegionSchemaUtility.generateQuery('Region__c', 'Id', 'RegIds');
		return (List<Region__c>) Database.query(query);
	}

	static List<AccountTeamMember> loadATMS(Id acctId) {
		return [SELECT Id, AccountId, TeamMemberRole, UserId FROM AccountTeamMember WHERE AccountId = :acctId];
	}

	static Map<Id, AccountTeamMember> loadATMMap(Id acctId) {
		Map<Id, AccountTeamMember> atmMap = new Map<Id, AccountTeamMember>();

		for(AccountTeamMember atm : loadATMS(acctId)) {
			atmMap.put(atm.UserId, atm);
		}

		return atmMap;
	}

	static Map<Id, AccountShare> loadAcctShares(Id acctId) {
		Map<Id, AccountShare> shareMap = new Map<Id, AccountShare>();

		for(AccountShare share : [SELECT Id, AccountId, AccountAccessLevel, ContactAccessLevel, CaseAccessLevel, OpportunityAccessLevel, UserOrGroupId FROM AccountShare WHERE AccountID = :acctId]) {
			shareMap.put(share.UserOrGroupId, share);
		}

		return shareMap;
	}

	static List<Zip_Postal_Code__c> loadZipCodes() {
		return [SELECT Id, Processed_D_T__c FROM Zip_Postal_Code__c];
	}

	static List<Related_State_Province__c> loadRelStates() {
		return [SELECT Id, Processed_D_T__c FROM Related_State_Province__c];
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

    	Master_Switches__c mSwitch = new Master_Switches__c(Workflow__c = true);
    	insert mSwitch;

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

		rd1 = newRD('Vin Regional Manager', hay.Id, 'Read/Write', 'Read Only', 'Read/Write', 'Read Only', false);
		rd2 = newRD('Vin Performance Manager', vin.Id, 'Read Only', 'Read/Write', 'Read Only', 'Read/Write', true);
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
		dist5.Role_9__c = rd2.Id;
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

		rState1 = newRelState(dist1.Id, state1.Id);
		rState2 = newRelState(dist2.Id, state1.Id);
		rState3 = newRelState(dist3.Id, state1.Id);
		rState4 = newRelState(dist4.Id, state2.Id);
		rState5 = newRelState(dist5.Id, state2.Id);
		rState6 = newRelState(dist6.Id, state2.Id);

		rZip1 = newRelZip(dist1.Id, zip1.Id);
		rZip2 = newRelZip(dist2.Id, zip1.Id);
		rZip3 = newRelZip(dist3.Id, zip1.Id);
		rZip4 = newRelZip(dist4.Id, zip2.Id);
		rZip5 = newRelZip(dist5.Id, zip2.Id);
		rZip6 = newRelZip(dist6.Id, zip2.Id);

		acct = new Account(
			Name = 'Acct 1',
			ShippingStreet = 'Shipping Street',
			ShippingCity = 'Shipping City',
			ShippingState = 'KY',
			ShippingPostalCode = '01234',
			BillingStreet = '123 Electric Ave',
			BillingCity = 'Power City',
			BillingState = 'KY',
			BillingPostalCode = '29149',
			/*DDM_Override__c = true,*/
			WAM_Override__c = true
			/*VinPro_Override__c = true*/
		);

		mergeAcct = new Account(
			Name = 'Merge Acct',
			/*DDM_Override__c = true,*/
			WAM_Override__c = true,
			/*VinPro_Override__c = true,*/
			ShippingStreet = 'Street 123',
			ShippingState = 'State 123',
			ShippingCity = 'City 123',
			ShippingPostalCode = '00000',
			ShippingCountry = 'USA'
		);
		insert mergeAcct;
	}

	private static void setupRunningUser() {
		Profile prof = [SELECT Id FROM Profile WHERE Name = 'System Administrator'];
		runningUser = newUser('Running', prof.Id);
		insert runningUser;
	}

	private static void insertRelStates() {
		insert new List<Related_State_Province__c> { rState1, rState2, rState3, rState4, rState5, rState6 };
	}

	private static void insertRelZips() {
		insert new List<Related_Zip_Postal_Code__c> { rZip1, rZip2, rZip3, rZip4, rZip5, rZip6 };
	}
}