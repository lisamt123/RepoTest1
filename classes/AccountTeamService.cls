public without sharing class AccountTeamService {
	public static Map<Id, Set<Id>> distPriorUserMap = new Map<Id, Set<Id>>();
	public static Map<Id, Set<Id>> regPriorUserMap = new Map<Id, Set<Id>>();
	public static Map<Id, Map<Id, AccountTMHelper>> distCurrentUserTMMap = new Map<Id, Map<Id, AccountTMHelper>>();
	public static Map<Id, Map<Id, AccountTMHelper>> regCurrentUserTMMap = new Map<Id, Map<Id, AccountTMHelper>>();

	public static void syncAccountTeams(Set<Id> acctIdsUpdateTM, Map<Id, Set<Id>> acctAddMap, Map<Id, Set<Id>> acctDelMap, Map<Id, List<AccountTMHelper>> distTMMap, Map<Id, List<AccountTMHelper>> regTMMap, Map<Id, Account> newMap, Set<Id> acctZipStateChange, Boolean isInsert) {
		
		if(!acctAddMap.isEmpty() || !acctDelMap.isEmpty()) {
			Map<Id, Role_Definition__c> roleDefMap = new Map<Id, Role_Definition__c>([SELECT Id, Name, Account_Access__c, Case_Access__c, Contact_Access__c, Opportunity_Access__c FROM Role_Definition__c LIMIT 100]); //If the # of roles exceeds 100, refactor
			List<AccountShare> acctShares = new List<AccountShare>();
			List<AccountTeamMember> acctTms = new List<AccountTeamMember>();
			Map<Id, Map<Id, AccountTMHelper>> currAcctTMMap = new Map<Id, Map<Id, AccountTMHelper>>();
			//for all sharing rules in for Accounts in acctAddMap
			//add the UserOrGroupId and a list of ov them to acctTMMap
			//and add Account Id and acctTMMap to currAcctTMMap
			for(AccountShare acctShare : [SELECT Id, AccountId, UserOrGroupId, AccountAccessLevel, ContactAccessLevel, CaseAccessLevel, OpportunityAccessLevel FROM AccountShare WHERE AccountId IN :acctAddMap.keySet()]) {
				Map<Id, AccountTMHelper> acctTMMap = currAcctTMMap.containsKey(acctShare.AccountId) ? currAcctTMMap.get(acctShare.AccountId) : new Map<Id, AccountTMHelper>();
				
				acctTMMap.put(acctShare.UserOrGroupId, new AccountTMHelper());
				currAcctTMMap.put(acctShare.AccountId, acctTMMap);
			}
			//
			if(!distTMMap.isEmpty()) {
				Set<Id> keySet = distTMMap.keySet();
				String query = DistrictRegionSchemaUtility.generateQuery('District__c', 'Id', 'keySet');
				//iterate through Districts 
				for(District__c dist : (List<District__c>) Database.query(query)) {
					List<AccountTMHelper> tms = distTMMap.get(dist.Id);
					Map<Id, AccountTMHelper> allTms = new Map<Id, AccountTMHelper>();

					for(Integer i = 1; i <= 10; i++) {
						String userFieldName = 'User_' + i + '__c';
						String roleFieldName = 'Role_' + i + '__c';
						String userPriorValue = 'User_' + i + '_Prior_Value__c';
						String rolePriorValue = 'Role_' + i + '_Prior_Value__c';
						String userProcessedDT = 'User_' + i + '_Processed_D_T__c';
						String roleProcessedDT = 'Role_' + i + '_Processed_D_T__c';
						//if the user name and role name are not null then
						if(dist.get(userFieldName) != null && dist.get(roleFieldName) != null) {
							//call AccountTMHelper and get the team member using the user Id and role Id
							AccountTMHelper tm = new AccountTMHelper((Id) dist.get(userFieldName), roleDefMap.get((Id) dist.get(roleFieldName)));
							//put the User Id and team member into a map
							allTms.put((Id) dist.get(userFieldName), tm);
							
							//Ramana: Added acctIdsUpdateTM.size() == 1 to debug an issue with Sync link on Account page ; 
							if(dist.get(userProcessedDT) == null || dist.get(roleProcessedDT) == null || isInsert || acctIdsUpdateTM.size() == 1) { 
								tms.add(tm);
							}
						}
						//get the prior user and role and
						if(dist.get(userPriorValue) != null || dist.get(rolePriorValue) != null) {
							Set<Id> userIds = distPriorUserMap.containsKey(dist.Id) ? distPriorUserMap.get(dist.Id) : new Set<Id>();
							userIds.add((Id) dist.get(userPriorValue) == null ? (Id) dist.get(userFieldName) : (Id) dist.get(userPriorValue));
							distPriorUserMap.put(dist.Id, userIds);
						}
					}
					if(!allTms.isEmpty()) {
						distCurrentUserTMMap.put(dist.Id, allTms);
					}
				}
			}
			if(!regTMMap.isEmpty()) {
				Set<Id> keySet = regTMMap.keySet();
				String query = DistrictRegionSchemaUtility.generateQuery('Region__c', 'Id', 'keySet');
				for(Region__c reg : (List<Region__c>) Database.query(query)) {
					List<AccountTMHelper> tms = regTMMap.get(reg.Id);
					Map<Id, AccountTMHelper> allTms = new Map<Id, AccountTMHelper>();

					for(Integer i = 1; i <= 5; i++) {
						String userFieldName = 'User_' + i + '__c';
						String roleFieldName = 'Role_' + i + '__c';
						String userPriorValue = 'User_' + i + '_Prior_Value__c';
						String rolePriorValue = 'Role_' + i + '_Prior_Value__c';
						String userProcessedDT = 'User_' + i + '_Processed_D_T__c';
						String roleProcessedDT = 'Role_' + i + '_Processed_D_T__c';

						if(reg.get(userFieldName) != null && reg.get(roleFieldName) != null) {
							AccountTMHelper tm = new AccountTMHelper((Id) reg.get(userFieldName), roleDefMap.get((Id) reg.get(roleFieldName)));
							allTms.put((Id) reg.get(userFieldName), tm);
							//Ramana: Added acctIdsUpdateTM.size() == 1 to debug an issue with Sync link on Account page
							if(reg.get(userProcessedDT) == null || reg.get(roleProcessedDT) == null || isInsert || acctIdsUpdateTM.size() == 1) {
								tms.add(tm);
							}
						}

						if(reg.get(userPriorValue) != null || reg.get(rolePriorValue) != null) {
							Set<Id> userIds = regPriorUserMap.containsKey(reg.Id) ? regPriorUserMap.get(reg.Id) : new Set<Id>();
							userIds.add((Id) reg.get(userPriorValue) == null ? (Id) reg.get(userFieldName) : (Id) reg.get(userPriorValue));
							regPriorUserMap.put(reg.Id, userIds);
						}
					}

					if(!allTms.isEmpty()) {
						regCurrentUserTMMap.put(reg.Id, allTms);
					}
				}
			} 

			Map<Id, AccountTeamMember> atmsToDelete = new Map<Id, AccountTeamMember>();

			if(!acctDelMap.isEmpty()) {
				Map<Id, Map<Id, AccountTeamMember>> acctTMMap = new Map<Id, Map<Id, AccountTeamMember>>();
				for(AccountTeamMember atm : [SELECT Id, UserId, AccountId FROM AccountTeamMember WHERE AccountId IN :acctDelMap.keySet()]) {
					Map<Id, AccountTeamMember> atmMap = acctTMMap.containsKey(atm.AccountId) ? acctTMMap.get(atm.AccountId) : new Map<Id, AccountTeamMember>();
					atmMap.put(atm.UserId, atm);
					acctTMMap.put(atm.AccountId, atmMap);
				}

				for(Id acctId : acctTMMap.keySet()) {
					Map<Id, AccountTeamMember> atmMap = acctTMMap.get(acctId);

					for(Id drId : acctDelMap.get(acctId)) {
						if(distTMMap.containsKey(drId)) {
							if(acctZipStateChange.contains(acctId) && distCurrentUserTMMap.containsKey(drId)) {
								for(AccountTMHelper ath : distCurrentUserTMMap.get(drId).values()) {
									if(atmMap.containsKey(ath.userId)) {
										AccountTeamMember atm = atmMap.get(ath.userId);
										atmsToDelete.put(atm.Id, atm);
									}
								}
							}

							if(distPriorUserMap.containsKey(drId)) {
								for(Id priorUserId : distPriorUserMap.get(drId)) {
									if(atmMap.containsKey(priorUserId)) {
										AccountTeamMember atm = atmMap.get(priorUserId);
										atmsToDelete.put(atm.Id, atm);
									}
								}
							}
						} else if(regTMMap.containsKey(drId)) {
							if(acctZipStateChange.contains(acctId) && regCurrentUserTMMap.containsKey(drId)) {
								for(AccountTMHelper ath : regCurrentUserTMMap.get(drId).values()) {
									if(atmMap.containsKey(ath.userId)) {
										AccountTeamMember atm = atmMap.get(ath.userId);
										atmsToDelete.put(atm.Id, atm);
									}
								}
							}

							if(regPriorUserMap.containsKey(drId)) {
								for(Id priorUserId : regPriorUserMap.get(drId)) {
									if(atmMap.containsKey(priorUserId)) {
										AccountTeamMember atm = atmMap.get(priorUserId);
										atmsToDelete.put(atm.Id, atm);
									}
								}
							}
						}
					}
				}

				if(!atmsToDelete.isEmpty()) {
					for(AccountTeamMember atm : atmsToDelete.values()) {
						Account acct = newMap.get(atm.AccountId);

						if(currAcctTMMap.containsKey(atm.AccountId) && currAcctTMMap.get(atm.AccountId).containsKey(atm.UserId)) {
							currAcctTMMap.get(atm.AccountId).remove(atm.UserId);

							if(currAcctTMMap.get(atm.AccountId).isEmpty()) {
								currAcctTMMap.remove(atm.AccountId);
							}
						}
					}
					//DELETE TEAM MEMBERS
					delete atmsToDelete.values();
				}
			}

			for(Id acctId : acctDelMap.keySet()) {
				Account acct = newMap.get(acctId);

				for(Id distRegId : new Set<Id> { acct.VAT_District__c, acct.VIN_District__c, acct.HAY_District__c, acct.VAT_Region__c, acct.VIN_Region__c, acct.HAY_Region__c }) {
					if(distCurrentUserTMMap.containsKey(distRegId) || regCurrentUserTMMap.containsKey(distRegId)) {
						for(AccountTeamMember atm : atmsToDelete.values()) {
							if(distCurrentUserTMMap.containsKey(distRegId) && distCurrentUserTMMap.get(distRegId).containsKey(atm.UserId)) {
								List<AccountTMHelper> tms = distTMMap.get(distRegId);
								tms.add(distCurrentUserTMMap.get(distRegId).get(atm.UserId));
							} else if(regCurrentUserTMMap.containsKey(distRegId) && regCurrentUserTMMap.get(distRegId).containsKey(atm.UserId)) {
								List<AccountTMHelper> tms = regTMMap.get(distRegId);
								tms.add(regCurrentUserTMMap.get(distRegId).get(atm.UserId));
							}
						}
					}
				}
			}

			if(!acctAddMap.isEmpty()) {
				for(Id acctId : acctAddMap.keySet()) {
					Account acct = newMap.get(acctId);
					Map<Id, AccountTMHelper> userMap = new Map<Id, AccountTMHelper>();
					for(Id drId : acctAddMap.get(acctId)) {
						if(distTMMap.containsKey(drId)) {
							if(acctZipStateChange.contains(acctId) && distCurrentUserTMMap.containsKey(drId)) {
								for(AccountTMHelper ath : distCurrentUserTMMap.get(drId).values()) {
									if(ath.userId != acct.OwnerId) {
										userMap.put(ath.UserId, userMap.containsKey(ath.userId) ? userMap.get(ath.userId).mergeTM(ath) : ath.cloneTM(acctId));
									}
								} 
							} else {
								for(AccountTMHelper ath : distTMMap.get(drId)) {
									if(ath.userId != acct.OwnerId) {
										userMap.put(ath.UserId, userMap.containsKey(ath.userId) ? userMap.get(ath.userId).mergeTM(ath) : ath.cloneTM(acctId));
									}
								}
							}
						} else if(regTMMap.containsKey(drId)) {

							if(acctZipStateChange.contains(acctId) && distCurrentUserTMMap.containsKey(drId)) {
								for(AccountTMHelper ath : regCurrentUserTMMap.get(drId).values()) {
									if(ath.userId != acct.OwnerId) {
										userMap.put(ath.UserId, userMap.containsKey(ath.userId) ? userMap.get(ath.userId).mergeTM(ath) : ath.cloneTM(acctId));
									}
								}
							} else {
								for(AccountTMHelper ath : regTMMap.get(drId)) {
									if(ath.userId != acct.OwnerId) {
										userMap.put(ath.UserId, userMap.containsKey(ath.userId) ? userMap.get(ath.userId).mergeTM(ath) : ath.cloneTM(acctId));
									}
								}
							}
						}
					}
					
					if(!userMap.isEmpty()) {											
						for(AccountTMHelper ath : userMap.values()) {
							//ignore if it is empty
							if(ath.tm.UserId == null) {system.debug('null ath.tm.UserId, ignoring..'); continue;}
							if(currAcctTMMap.containsKey(ath.acctId) && currAcctTMMap.get(ath.acctId).containsKey(ath.userId)) {
								System.debug(System.loggingLevel.info, 'Hello debugger this is the merge section ' + ath.userId);
								ath = ath.mergeTM(currAcctTMMap.get(ath.acctId).get(ath.userId));
							}
                            
							acctShares.add(ath.acctShare);
							acctTms.add(ath.tm);
						}
					}
				}

				if(!acctTms.isEmpty()) {
					try {
						//INSERT ACCOUNT TEAM MEMBERS
						insert acctTms;
					} catch (Exception ex) {
						System.debug(System.logginglevel.INFO, 'ACCOUNT TEAM INSERT FAILED:' + ex.getMessage());
					}
				}

				if(!acctShares.isEmpty()) {
					try {
						//INSERT SHARING RULES
						insert acctShares;
					} catch (Exception ex) {
						System.debug(System.logginglevel.INFO, 'ACCOUNT SHARE INSERT FAILED:' + ex.getMessage());
					}
				}
			}
		}
		if(!acctIdsUpdateTM.isEmpty()) {
			List<Account> accts = new List<Account>();

			for(Account acct : [SELECT Id, Update_Team_Members__c FROM Account WHERE Id IN :acctIdsUpdateTM]) {
				acct.Update_Team_Members__c = false;
				accts.add(acct);
			}
			//UPDATE ACCOUNTS SETTING Update_Team_Members__c to false
			update accts;
		}
	}
}