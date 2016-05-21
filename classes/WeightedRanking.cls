public class WeightedRanking { 
	
	public static void triggerCalculateParentRanking(List<Case> parentCases) {
		
		Set<Id> accountIds = new Set<Id>();
		
		for(Case c : parentCases) {
			
			if(c.accountId != null) {
				
				accountIds.add(c.accountId);
			}
		}
		
		Map<Id,Account> accountMap = new Map<Id, Account>([SELECT Id, name, Flag_for_Heat__c, Special_Account_Status__c, 
																ParentId, Implementation_Date__c, Premium_Account__c, MRRRanking__c
														   FROM Account 
														   WHERE Id IN :accountIds]);
														   
		List<Case> childCases = new List<Case>();
		
		if(trigger.isUpdate) {
			
			childCases = [SELECT ID, parentId, CaseNumber, Ranking2__c, Days_Open__c, Has_Been_Flagged_Manager__c,
									Has_Been_Flagged__c, Priority, Super_Priority__c, Reason, Force_High__c,
									Account.Flag_for_Heat__c, Account.Special_Account_Status__c, Account.ParentId,
									Account.Implementation_Date__c, Account.Premium_Account__c, Origin, Account.MRRRanking__c,
									POA__c
						  FROM Case 
						  WHERE parentId IN :parentCases];
		}	
									
		Map<Id, LIST<Case>> caseMap = new Map<Id, LIST<Case>>();
		
		for(Case cc : childCases) {
			
			if(caseMap.containsKey(cc.parentId)) {
				
				caseMap.get(cc.parentId).add(cc);
			}
			else {
				
				caseMap.put(cc.parentId, new List<Case>{cc});
			}
		}
		
		Map<String, Decimal> mrrMap = new map<String, Decimal>();
		mrrMap.put('10', 10);
		mrrMap.put('8', 8);
		mrrMap.put('6', 6);
		mrrMap.put('4', 4);
		mrrMap.put('1', 1);
		
		Map<String, Decimal> caseOriginMap = new Map<String, Decimal>();
        caseOriginMap.put('UrgentVinCare', 2);
            
		Map<String, Decimal> premAcctMap = new Map<String, Decimal>();
		premAcctMap.put('Yes', 50000);
		premAcctMap.put('No', 0);
			
		Map<String, Decimal> priorityMap = new MAP<String, Decimal>();
		priorityMap.put('1 - Hot (Fix it Now)', 7);
		priorityMap.put('2 - Warm (Fix in next release)', 3);
		priorityMap.put('3 - Cold (Fix in the future)', 1);
		
		Map<Boolean, Decimal> hbfmanagerMap = new MAP<Boolean, Decimal>();
		hbfmanagerMap.put(true, 2);
		
		Map<Boolean, Decimal> hbfMap = new MAP<Boolean, Decimal>();
		hbfMap.put(true, 2);
			
		Map<Boolean, Decimal> ffhMap = new MAP<Boolean, Decimal>();
		ffhMap.put(true, 1);
			
		Map<String, Decimal> superPriorityMap = new MAP<String, Decimal>(); 
		superPriorityMap.put('1 - Hot', 12);
		superPriorityMap.put('2 - Warm', 9);
		superPriorityMap.put('3 - Cool', 6);
		superPriorityMap.put('4 - Cold', 3);
			
		Map<Boolean,Decimal> fhcMap = new MAP<Boolean, Decimal>();
		fhcMap.put(true, 500000000);
			
		Map<String, Decimal> crvMap = new Map<String, Decimal>();
		crvMap.put('Public Inaccuracy', 7);
		crvMap.Put('Lead Issue' , 7);
		crvMap.put('DMS Integration', 3);
					
		Map<String, Decimal> sasMap = new MAP<String, Decimal>();
	 	//sasMap.put('DAB Heat', 13);
	 	//sasMap.put('DAB Member', 6);
	 	sasMap.put('Heat Account', 7);
	 	sasMap.put('Revenue Opportunity', 6);
	 	sasMap.put('Revenue opp Heat', 12);
		 	
		Map<String, Decimal> reasonMap = new MAP<String, Decimal>();
	 	reasonMap.put('Public Inaccuracy', 7);
	 	reasonMap.put('Lead Issue', 7);
	 	reasonMap.put('DMS Integration', 3);
		 			 
		for(Case c : parentCases) {
			
			Account iterAcct = new Account();
			
			if(accountMap.containsKey(c.accountId)) {
				
				iterAcct = accountMap.get(c.accountId);
			}
			
			Decimal priorityWeight = 1;
			Decimal days = 1;
			Decimal flaggedManager = 1;
			Decimal flaggedWorker = 1;
			//Decimal caseReasons = 1;
			Decimal sas = 1;
			Decimal forceHigh = 0;
			//Decimal newRankingValue = 0;
			Decimal wrangler = 1;
			Decimal	newAcct = 1;
			Decimal hasChildTicket = 1;
			Decimal numChildTicket = 1;
			Decimal premAcct = 0;
			Decimal origin = 1;
			Decimal mrr = 1;
			Decimal poa = 0;
			
					
			if(iterAcct.Implementation_date__c != null) {
				
				Integer daysBetween = iterAcct.implementation_date__c.daysBetween(system.today());
				
				if(daysBetween >= 90) {
					
					newAcct = 4;
				}
			}
			/*
			if(trigger.isUpdate) {
				
				days = (c.Days_Open__c + 1);
			}
			else {
				
				days = 1.0;
			}
			*/
			
			if(c.POA__c != null) {
				
				poa += 500;
			}
			
			if(caseOriginMap.containsKey(c.Origin)) {
				
				origin = caseOriginMap.get(c.Origin);
			}
			
			if(priorityMap.containsKey(c.priority)) {
				
				priorityWeight = priorityMap.get(c.priority); 
			}
			
			if(hbfmanagerMap.containsKey(c.Has_Been_Flagged_Manager__c)) {
				
				flaggedManager = hbfmanagerMap.get(c.Has_Been_Flagged_Manager__c);
			}
			
			if(hbfMap.containsKey(c.Has_Been_Flagged__c)) {
				
				flaggedWorker = hbfMap.get(c.Has_Been_Flagged__c);
			}
			
			if(superPriorityMap.containsKey(c.Super_Priority__c)) {
				
				wrangler = superPriorityMap.get(c.Super_Priority__c);
			}
			
			if(mrrMap.containsKey(iterAcct.MRRRanking__c)) {
				
				mrr = mrrMap.get(iterAcct.MRRRanking__c);
			}
			
			if(premAcctMap.containsKey(iterAcct.Premium_Account__c)) {
				
				premAcct = premAcctMap.get(iterAcct.Premium_Account__c);
			}
			
			//if(reasonMap.containsKey(c.Reason)) {
				
				//caseReasons = reasonMap.get(c.Reason);
			//}
			
			if(sasMap.containsKey(iterAcct.Special_Account_Status__c)) {
				
				sas = sasMap.get(iterAcct.Special_Account_Status__c);
			}
			
			if(fhcMap.containsKey(c.Force_High__c)) {
				
				forceHigh = fhcMap.get(c.Force_High__c);
			}
			
			if(trigger.isUpdate) {
				
				days = (c.Days_Open__c + 1);
			}
			else {
				
				days = 1.0;
			}
			
			if(caseMap.containsKey(c.Id)) {
				
				hasChildTicket = 4;
				numChildTicket += caseMap.get(c.Id).size() * .5;
				
				for(Case cc : caseMap.get(c.Id)) {
					
					if(cc.Days_Open__c > days) {
						
						days = cc.Days_Open__c;
					}
					
					if(sasMap.get(cc.Account.Special_Account_Status__c) > sas) {
						
						sas = sasMap.get(cc.Account.Special_Account_Status__c);
					}
					
					if(poa == 0 && cc.POA__c != null) {
						
						poa += 500;
					}
				}
			}
			
			days++;
			
			system.debug('priorityWeight: ' + priorityWeight);
			system.debug('days: ' + days);
			system.debug('flaggedManager: ' + flaggedManager);
			system.debug('flaggedWorker: ' + flaggedWorker);
			//system.debug('caseReasons: ' + caseReasons);
			system.debug('forceHigh: ' + forceHigh);
			system.debug('wrangler: ' + wrangler);
			system.debug('newAcct: ' + newAcct);
			system.debug('hasChildTicket: ' + hasChildTicket);
			system.debug('numChildTicket: ' + numChildTicket);
			
			//string values for Ranking Debug field
			String pw = String.valueOf(priorityWeight);
			String dys = String.valueOf(days);
			String fm = String.valueOf(flaggedManager);
			String fw = String.valueOf(flaggedWorker);
			//String cr = String.valueOf(caseReasons);
			String sas1 = String.valueOf(sas);
			String fh = String.valueOf(forceHigh);
			String wrg = String.valueOf(wrangler);
			String na = String.valueOf(newAcct);
			String hct = String.valueOf(hasChildTicket);
			String nct = String.valueOf(numChildTicket);
			String prmAcct = String.valueOf(premAcct);
			String orig = String.valueOf(origin);
			String mrrRanking = String.valueOf(mrr);
			String poa1 = String.valueOf(poa);
			
			
			String rankingDebug = dys + '*' + pw + '*' + fm + '*' + fw + '*' + wrg + '*' + sas1 + '*' + na + '*' + hct + '*' + nct + '*' + orig + '*' + mrrRanking + '+' + fh + '+' + prmAcct + '+' + poa1;//switch pri and days - done
			
			decimal ranking = (days * priorityWeight * flaggedManager * flaggedWorker * wrangler * sas * newAcct * hasChildTicket * numChildTicket * origin * mrr) + forceHigh + premAcct + poa;
			//String rankingString = String.valueOf(ranking);
			
			system.debug('parent ranking: ' + ranking);
			
			if(c.Ranking2__c != ranking) {
				
				c.Ranking2__c = ranking;
				c.Ranking_Debug__c = rankingDebug;
			}
		}													
	}
	
	public static void triggerCalculateChildRanking(List<Case> childCases) {
		
		Set<Id> accountIds = new Set<Id>();
		
		Decimal days2 = 0;
		
		for(Case c : childCases) {
			
			if(c.Days_Open__c > days2) {
				
				days2 = c.Days_Open__c;
			}
			
			if(c.accountId != null) {
				
				accountIds.add(c.accountId);
			}
		}
		
		Map<Id, Account> accountMap = new Map<Id, Account>([SELECT ID, name, Flag_for_Heat__c, Special_Account_Status__c, 
																ParentId, Implementation_Date__c, Premium_Account__c, MRRRanking__c
															FROM Account 
															WHERE Id IN :accountIds]);
		
		Map<String, Decimal> caseOriginMap = new Map<String, Decimal>();
        caseOriginMap.put('UrgentVinCare', 2);
            							
		Map<String, Decimal> premAcctMap = new Map<String, Decimal>();
		premAcctMap.put('Yes', 50000);
		premAcctMap.put('No', 0);
			
		Map<String, Decimal> mrrMap = new map<String, Decimal>();
		mrrMap.put('10', 10);
		mrrMap.put('8', 8);
		mrrMap.put('6', 6);
		mrrMap.put('4', 4);
		mrrMap.put('1', 1);
		
		MAP<String, Decimal> priorityMap = new MAP<String, Decimal>();
		priorityMap.put('1 - Hot (Fix it Now)', 7);
		priorityMap.put('2 - Warm (Fix in next release)', 3);
		priorityMap.put('3 - Cold (Fix in the future)', 1);
		
		MAP<Boolean, Decimal> hbfmanagerMap = new MAP<Boolean, Decimal>();
		hbfmanagerMap.put(true, 2);
		
		MAP<Boolean, Decimal> hbfMap = new MAP<Boolean, Decimal>();
		hbfMap.put(true, 2);
			
		MAP<Boolean, Decimal> ffhMap = new MAP<Boolean, Decimal>();
		ffhMap.put(true, 1);
			
		Map<String, Decimal> superPriorityMap = new MAP<String, Decimal>();
		superPriorityMap.put('1 - Hot', 12);
		superPriorityMap.put('2 - Warm', 9);
		superPriorityMap.put('3 - Cool', 6);
		superPriorityMap.put('4 - Cold', 3);
			
		Map<Boolean,Decimal> fhcMap = new MAP<Boolean, Decimal>();
		fhcMap.put(true, 500000000);
			
		MAP<String, Decimal> crvMap = new Map<String, Decimal>();
		crvMap.put('Public Inaccuracy', 7);
		crvMap.Put('Lead Issue' , 7);
		crvMap.put('DMS Integration', 3);
			
		//MAP<Decimal, Decimal> days = new MAP<Decimal, Decimal>();
		
		Map<String, Decimal> sasMap = new MAP<String, Decimal>();
	 	//sasMap.put('DAB Heat', 13);
	 	//sasMap.put('DAB Member', 6);
	 	sasMap.put('Heat Account', 7);
	 	sasMap.put('Revenue Opportunity', 6);
	 	sasMap.put('Revenue opp Heat', 12);
		 	
		MAP<String, Decimal> reasonMap = new MAP<String, Decimal>();
	 	reasonMap.put('Public Inaccuracy', 7);
	 	reasonMap.put('Lead Issue', 7);
	 	reasonMap.put('DMS Integration', 3);
		 	
		Map<Datetime, Decimal> newAcctMap  = new MAP<Datetime, Decimal>();
	
		for(Case c : childCases) {
			
			Account iterAcct = new Account();
			
			if(accountMap.containsKey(c.accountId)) {
				
				iterAcct = accountMap.get(c.accountId);
			}
			
			Decimal priorityWeight = 1;
			Decimal days = 1;
			Decimal flaggedManager = 1;
			Decimal flaggedWorker = 1;
			//Decimal caseReasons = 1;
			Decimal sas = 1;
			Decimal forceHigh = 0;
			//Decimal newRankingValue = 0;
			Decimal wrangler = 1;
			Decimal	newAcct = 1;
			Decimal premAcct = 0;
			Decimal origin = 1;
			Decimal mrr = 1;
			Decimal poa = 0;
			
			if(c.Account.Implementation_date__c != null) {
				
				Integer daysBetween = iterAcct.implementation_date__c.daysBetween(system.today());
				
				if(daysBetween >= 90) {
				
					newAcct = 4;
				}
			}
			
			
			//
			days = days2;
			/*
			if(trigger.isUpdate) {
				
				days = (c.Days_Open__c + 1);
			}
			else {
				
				days = 1.0;
			}
			*/
			
			if(c.POA__c != null) {
				
				poa += 500;
			}
			
			if(mrrMap.containsKey(iterAcct.MRRRanking__c)) {
				
				mrr = mrrMap.get(iterAcct.MRRRanking__c);
			}
			
			if(priorityMap.containsKey(c.priority)) {
				
				priorityWeight = priorityMap.get(c.priority); 
			}
			
			if(hbfmanagerMap.containsKey(c.Has_Been_Flagged_Manager__c)) {
				
				flaggedManager = hbfmanagerMap.get(c.Has_Been_Flagged_Manager__c);
			}
			
			if(hbfMap.containsKey(c.Has_Been_Flagged__c)) {
				
				flaggedWorker = hbfMap.get(c.Has_Been_Flagged__c);
			}
			
			if(superPriorityMap.containsKey(c.Super_Priority__c)) {
				
				wrangler = superPriorityMap.get(c.Super_Priority__c);
			}
			
			//if(reasonMap.containsKey(c.Reason)) {
				
				//caseReasons = reasonMap.get(c.Reason);
			//}
			
			if(sasMap.containsKey(iterAcct.Special_Account_Status__c)) {
				
				sas = sasMap.get(iterAcct.Special_Account_Status__c);
			}
			
			if(premAcctMap.containsKey(iterAcct.Premium_Account__c)) {
				
				premAcct = premAcctMap.get(iterAcct.Premium_Account__c);
			}
			
			if(fhcMap.containsKey(c.Force_High__c)) {
				
				forceHigh = fhcMap.get(c.Force_High__c);
			}
			
			days++;
			
			system.debug('priorityWeight: ' + priorityWeight);
			system.debug('days: ' + days);
			system.debug('flaggedManager: ' + flaggedManager);
			system.debug('flaggedWorker: ' + flaggedWorker);
			//system.debug('caseReasons: ' + caseReasons);
			system.debug('forceHigh: ' + forceHigh);
			system.debug('wrangler: ' + wrangler);
			system.debug('newAcct: ' + newAcct);
			
			//string values for Ranking Debug field
			String pw = String.valueOf(priorityWeight);
			String dys = String.valueOf(days);
			String fm = String.valueOf(flaggedManager);
			String fw = String.valueOf(flaggedWorker);
			//String cr = String.valueOf(caseReasons);
			String sas1 = String.valueOf(sas);
			String fh = String.valueOf(forceHigh);
			String wrg = String.valueOf(wrangler);
			String na = String.valueOf(newAcct);
			//String hct = String.valueOf(hasChildTicket);
			//String nct = String.valueOf(numChildTicket);
			String prmAcct = String.valueOf(premAcct);
			String orig = String.valueOf(origin);
			String mrrRanking = String.valueOf(mrr);
			String poa1 = String.valueOf(poa);
			
			
			String rankingDebug = dys + '*' + pw + '*' + fm + '*' + fw + '*' + wrg + '*' + sas1 + '*' + na + '*' + prmAcct + '*' + orig + '*' + mrrRanking + '+' + poa1;
			
			decimal ranking = (days * priorityWeight * flaggedManager * flaggedWorker * wrangler * sas * newAcct * origin * mrr) + forceHigh + premAcct + poa;
			
			system.debug('child ranking: ' + ranking);
			
			if(c.Ranking2__c != ranking) {
				
				c.Ranking2__c = ranking;
				c.Ranking_Debug__c = rankingDebug;
			}
		}
	}

	public void CalculateParentRanking(SET<Id> parentCaseIds) {

		LIST<Case> parentCases = [SELECT ID, CaseNumber, Ranking2__c, Days_Open__c, Has_Been_Flagged_Manager__c,
										Has_Been_Flagged__c, Priority, Super_Priority__c, Reason, Force_High__c,
										Account.Flag_for_Heat__c, Account.Special_Account_Status__c, Account.ParentId,
										Account.Implementation_Date__c, Account.Premium_Account__c, Origin, Account.MRRRanking__c,
										POA__c
								  FROM Case 
								  WHERE ID IN :parentCaseIds];
									
		LIST<Case> childCases = [SELECT ID, parentId, CaseNumber, Ranking2__c, Days_Open__c, Has_Been_Flagged_Manager__c,
										Has_Been_Flagged__c, Priority, Super_Priority__c, Reason, Force_High__c,
										Account.Flag_for_Heat__c, Account.Special_Account_Status__c, Account.ParentId,
										Account.Implementation_Date__c, Account.Premium_Account__c, Origin, Account.MRRRanking__c,
										POA__c
								 FROM Case 
								 WHERE parentId IN :parentCaseIds];
									
		MAP<Case, LIST<Case>> caseMap = new MAP<Case, LIST<Case>>();
		
		for(Case pc : parentCases) {
			
			caseMap.put(pc, new LIST<Case>());
			
			for(Case cc : childCases) {
				
				if(cc.parentId == pc.Id) {
					
					caseMap.get(pc).add(cc);
				}
			}
		}
		
		Map<String, Decimal> mrrMap = new map<String, Decimal>();
		mrrMap.put('10', 10);
		mrrMap.put('8', 8);
		mrrMap.put('6', 6);
		mrrMap.put('4', 4);
		mrrMap.put('1', 1);
		
		Map<String, Decimal> caseOriginMap = new Map<String, Decimal>();
        caseOriginMap.put('UrgentVinCare', 2);
            							
		Map<String, Decimal> premAcctMap = new Map<String, Decimal>();
		premAcctMap.put('Yes', 50000);
		premAcctMap.put('No', 0);
									
		MAP<String, Decimal> priorityMap = new MAP<String, Decimal>();
		priorityMap.put('1 - Hot (Fix it Now)', 7);
		priorityMap.put('2 - Warm (Fix in next release)', 3);
		priorityMap.put('3 - Cold (Fix in the future)', 1);
		
		MAP<Boolean, Decimal> hbfmanagerMap = new MAP<Boolean, Decimal>();
		hbfmanagerMap.put(true, 2);
		
		MAP<Boolean, Decimal> hbfMap = new MAP<Boolean, Decimal>();
		hbfMap.put(true, 2);
			
		MAP<Boolean, Decimal> ffhMap = new MAP<Boolean, Decimal>();
		ffhMap.put(true, 1);
			
		Map<String, Decimal> superPriorityMap = new MAP<String, Decimal>();
		superPriorityMap.put('1 - Hot', 12);
		superPriorityMap.put('2 - Warm', 9);
		superPriorityMap.put('3 - Cool', 6);
		superPriorityMap.put('4 - Cold', 3);
			
		Map<Boolean,Decimal> fhcMap = new MAP<Boolean, Decimal>();
		fhcMap.put(true, 500000000);
			
		MAP<String, Decimal> crvMap = new Map<String, Decimal>();
		crvMap.put('Public Inaccuracy', 7);
		crvMap.Put('Lead Issue' , 7);
		crvMap.put('DMS Integration', 3);
			
		//MAP<Decimal, Decimal> days = new MAP<Decimal, Decimal>();
		
		Map<String, Decimal> sasMap = new MAP<String, Decimal>();
	 	//sasMap.put('DAB Heat', 13);
	 	//sasMap.put('DAB Member', 6);
	 	sasMap.put('Heat Account', 7);
	 	sasMap.put('Revenue Opportunity', 6);
	 	sasMap.put('Revenue opp Heat', 12);
		 	
		MAP<String, Decimal> reasonMap = new MAP<String, Decimal>();
	 	reasonMap.put('Public Inaccuracy', 7);
	 	reasonMap.put('Lead Issue', 7);
	 	reasonMap.put('DMS Integration', 3);
		 	
		Map<Datetime, Decimal> newAcctMap  = new MAP<Datetime, Decimal>();
	
	
		//Main iteration Loop
		//Loop thru child cases list
		List<Case> updateCases = new List<Case>();
		
		for(Case c: caseMap.keyset()) {
			
			Decimal priorityWeight = 1;
			Decimal days = 1;
			Decimal flaggedManager = 1;
			Decimal flaggedWorker = 1;
			//Decimal caseReasons = 1;
			Decimal sas = 1;
			Decimal forceHigh = 0;
			//Decimal newRankingValue = 0;
			Decimal wrangler = 1;
			Decimal	newAcct = 1;
			Decimal hasChildTicket = 1;
			Decimal numChildTicket = 1;
			Decimal premAcct = 0;
			Decimal origin = 1;
			Decimal mrr = 1;
			Decimal poa = 0;
			
			if(c.Account.Implementation_date__c != null) {
				
				Integer daysBetween = c.account.implementation_date__c.daysBetween(system.today());
				
				if(daysBetween >= 90) {
				
					newAcct = 4;
				}
			}
			
			days = (c.Days_Open__c + 1);
			
			if(c.POA__c != null) {
				
				poa += 500;
			}
			
			if(mrrMap.containsKey(c.Account.MRRRanking__c)) {
				
				mrr = mrrMap.get(c.Account.MRRRanking__c);
			}
			
			if(priorityMap.containsKey(c.priority)) {
				
				priorityWeight = priorityMap.get(c.priority); 
			}
			
			if(hbfmanagerMap.containsKey(c.Has_Been_Flagged_Manager__c)) {
				
				flaggedManager = hbfmanagerMap.get(c.Has_Been_Flagged_Manager__c);
			}
			
			if(hbfMap.containsKey(c.Has_Been_Flagged__c)) {
				
				flaggedWorker = hbfMap.get(c.Has_Been_Flagged__c);
			}
			
			if(superPriorityMap.containsKey(c.Super_Priority__c)) {
				
				wrangler = superPriorityMap.get(c.Super_Priority__c);
			}
			
			//if(reasonMap.containsKey(c.Reason)) {
				
				//caseReasons = reasonMap.get(c.Reason);
			//}
			
			if(sasMap.containsKey(c.Account.Special_Account_Status__c)) {
				
				sas = sasMap.get(c.Account.Special_Account_Status__c);
			}
			
			if(premAcctMap.containsKey(c.Account.Premium_Account__c)) {
				
				premAcct = premAcctMap.get(c.Account.Premium_Account__c);
			}
			
			if(fhcMap.containsKey(c.Force_High__c)) {
				
				forceHigh = fhcMap.get(c.Force_High__c);
			}
			
			if(caseMap.get(c).size() > 0) {
				
				hasChildTicket = 4;
				numChildTicket += caseMap.get(c).size() * .5;
				
				for(Case cc : caseMap.get(c)) {
					
					if(cc.Days_Open__c > days) {
						
						days = cc.Days_Open__c;
					}
					
					if(sasMap.get(cc.Account.Special_Account_Status__c) > sas) {
						
						sas = sasMap.get(cc.Account.Special_Account_Status__c);
					}
					
					if(poa == 0 && cc.POA__c != null) {
						
						poa += 500;
					}
				}
			}
			
			days++;
			
			system.debug('priorityWeight: ' + priorityWeight);
			system.debug('days: ' + days);
			system.debug('flaggedManager: ' + flaggedManager);
			system.debug('flaggedWorker: ' + flaggedWorker);
			//system.debug('caseReasons: ' + caseReasons);
			system.debug('forceHigh: ' + forceHigh);
			system.debug('wrangler: ' + wrangler);
			system.debug('newAcct: ' + newAcct);
			system.debug('hasChildTicket: ' + hasChildTicket);
			system.debug('numChildTicket: ' + numChildTicket);
			
			//string values for Ranking Debug field
			String pw = String.valueOf(priorityWeight);
			String dys = String.valueOf(days);
			String fm = String.valueOf(flaggedManager);
			String fw = String.valueOf(flaggedWorker);
			//String cr = String.valueOf(caseReasons);
			String sas1 = String.valueOf(sas);
			String fh = String.valueOf(forceHigh);
			String wrg = String.valueOf(wrangler);
			String na = String.valueOf(newAcct);
			String hct = String.valueOf(hasChildTicket);
			String nct = String.valueOf(numChildTicket);
			String prmAcct = String.valueOf(premAcct);
			String orig = String.valueOf(origin);
			String mrrRanking = String.valueOf(mrr);
			String poa1 = String.valueOf(poa);
			
			
			String rankingDebug = dys + '*' + pw + '*' + fm + '*' + fw + '*' + wrg + '*' + sas1 + '*' + na + '*' + hct + '*' + nct + '*' + prmAcct + '*' + orig + '*' + mrrRanking + '+' + poa1;//switch pri and days - done
			
			decimal ranking = (days * priorityWeight * flaggedManager * flaggedWorker * wrangler * sas * newAcct * hasChildTicket * numChildTicket * origin * mrr) + forceHigh + premAcct + poa;
			//String rankingString = String.valueOf(ranking);
			
			
			
			system.debug('parent ranking: ' + ranking);
			
			if(c.Ranking2__c != ranking) {
				
				c.Ranking2__c = ranking;
				c.Ranking_Debug__c = rankingDebug;
				   
				updateCases.add(c);
			}
			
			/*if(c.Ranking_Debug__c == null){
				
				c.Ranking_Debug__c = rankingString;
				
				updateCases.add(c);
			}*/
			
			
		}
			 
		if(updateCases.size() > 0) {
			
			update updateCases;
		}
	}
	
	
	public void CalculateChildRanking(SET<Id> childCaseIds) {

									
		LIST<Case> childCases = [SELECT ID, CaseNumber, Ranking2__c, Days_Open__c, Has_Been_Flagged_Manager__c,
										Has_Been_Flagged__c, Priority, Super_Priority__c, Reason, Force_High__c,
										Account.Flag_for_Heat__c, Account.Special_Account_Status__c, Account.ParentId,
										Account.Implementation_Date__c, Account.Premium_Account__c, Origin, Account.MRRRanking__c, POA__c
								 FROM Case 
								 WHERE Id IN :childCaseIds];
		
		Decimal days2 = 0;
		
		for(Case c : childCases) {
			
			if(c.Days_Open__c > days2) {
				
				days2 = c.Days_Open__c;
			}
		}
		
				
		Map<String, Decimal> mrrMap = new map<String, Decimal>();
		mrrMap.put('10', 10);
		mrrMap.put('8', 8);
		mrrMap.put('6', 6);
		mrrMap.put('4', 4);
		mrrMap.put('1', 1);
		
		Map<String, Decimal> caseOriginMap = new Map<String, Decimal>();
        caseOriginMap.put('UrgentVinCare', 2);
            							
		Map<String, Decimal> premAcctMap = new Map<String, Decimal>();
		premAcctMap.put('Yes', 50000);
		premAcctMap.put('No', 0);
									
		MAP<String, Decimal> priorityMap = new MAP<String, Decimal>();
		priorityMap.put('1 - Hot (Fix it Now)', 7);
		priorityMap.put('2 - Warm (Fix in next release)', 3);
		priorityMap.put('3 - Cold (Fix in the future)', 1);
		
		MAP<Boolean, Decimal> hbfmanagerMap = new MAP<Boolean, Decimal>();
		hbfmanagerMap.put(true, 2);
		
		MAP<Boolean, Decimal> hbfMap = new MAP<Boolean, Decimal>();
		hbfMap.put(true, 2);
			
		MAP<Boolean, Decimal> ffhMap = new MAP<Boolean, Decimal>();
		ffhMap.put(true, 1);
			
		Map<String, Decimal> superPriorityMap = new MAP<String, Decimal>();
		superPriorityMap.put('1 - Hot', 12);
		superPriorityMap.put('2 - Warm', 9);
		superPriorityMap.put('3 - Cool', 6);
		superPriorityMap.put('4 - Cold', 3);
			
		Map<Boolean,Decimal> fhcMap = new MAP<Boolean, Decimal>();
		fhcMap.put(true, 500000000);
			
		MAP<String, Decimal> crvMap = new Map<String, Decimal>();
		crvMap.put('Public Inaccuracy', 7);
		crvMap.Put('Lead Issue' , 7);
		crvMap.put('DMS Integration', 3);
			
		//MAP<Decimal, Decimal> days = new MAP<Decimal, Decimal>();
		
		Map<String, Decimal> sasMap = new MAP<String, Decimal>();
	 	//sasMap.put('DAB Heat', 13);
	 	//sasMap.put('DAB Member', 6);
	 	sasMap.put('Heat Account', 7);
	 	sasMap.put('Revenue Opportunity', 6);
	 	sasMap.put('Revenue opp Heat', 12);
		 	
		MAP<String, Decimal> reasonMap = new MAP<String, Decimal>();
	 	reasonMap.put('Public Inaccuracy', 7);
	 	reasonMap.put('Lead Issue', 7);
	 	reasonMap.put('DMS Integration', 3);
		 	
		Map<Datetime, Decimal> newAcctMap  = new MAP<Datetime, Decimal>();
	
	
		//Main iteration Loop
		//Loop thru child cases list
		List<Case> updateCases = new List<Case>();
		
		for(Case c : childCases) {
			
			Decimal priorityWeight = 1;
			Decimal days = 1;
			Decimal flaggedManager = 1;
			Decimal flaggedWorker = 1;
			//Decimal caseReasons = 1;
			Decimal sas = 1;
			Decimal forceHigh = 0;
			//Decimal newRankingValue = 0;
			Decimal wrangler = 1;
			Decimal	newAcct = 1;
			Decimal premAcct = 0;
			Decimal origin = 1;
			Decimal mrr = 1;
			Decimal poa = 0;
			
			if(c.Account.Implementation_date__c != null) {
				
				Integer daysBetween = c.account.implementation_date__c.daysBetween(system.today());
				
				if(daysBetween >= 90) {
				
					newAcct = 4;
				}
			}
			
			/////days = (c.Days_Open__c + 1);
			days = days2;
			
			if(c.POA__c != null) {
				
				poa += 500;
			}
			
			if(mrrMap.containsKey(c.Account.MRRRanking__c)) {
				
				mrr = mrrMap.get(c.Account.MRRRanking__c);
			}
			
			if(priorityMap.containsKey(c.priority)) {
				
				priorityWeight = priorityMap.get(c.priority); 
			}
			
			if(hbfmanagerMap.containsKey(c.Has_Been_Flagged_Manager__c)) {
				
				flaggedManager = hbfmanagerMap.get(c.Has_Been_Flagged_Manager__c);
			}
			
			if(hbfMap.containsKey(c.Has_Been_Flagged__c)) {
				
				flaggedWorker = hbfMap.get(c.Has_Been_Flagged__c);
			}
			
			if(superPriorityMap.containsKey(c.Super_Priority__c)) {
				
				wrangler = superPriorityMap.get(c.Super_Priority__c);
			}
			
			//if(reasonMap.containsKey(c.Reason)) {
				
				//caseReasons = reasonMap.get(c.Reason);
			//}
			
			if(sasMap.containsKey(c.Account.Special_Account_Status__c)) {
				
				sas = sasMap.get(c.Account.Special_Account_Status__c);
			}
			
			if(premAcctMap.containsKey(c.Account.Premium_Account__c)) {
				
				premAcct = premAcctMap.get(c.Account.Premium_Account__c);
			}
			
			if(fhcMap.containsKey(c.Force_High__c)) {
				
				forceHigh = fhcMap.get(c.Force_High__c);
			}
			
			days++;
			
			system.debug('priorityWeight: ' + priorityWeight);
			system.debug('days: ' + days);
			system.debug('flaggedManager: ' + flaggedManager);
			system.debug('flaggedWorker: ' + flaggedWorker);
			//system.debug('caseReasons: ' + caseReasons);
			system.debug('forceHigh: ' + forceHigh);
			system.debug('wrangler: ' + wrangler);
			system.debug('newAcct: ' + newAcct);
			
			//string values for Ranking Debug field
			String pw = String.valueOf(priorityWeight);
			String dys = String.valueOf(days);
			String fm = String.valueOf(flaggedManager);
			String fw = String.valueOf(flaggedWorker);
			//String cr = String.valueOf(caseReasons);
			String sas1 = String.valueOf(sas);
			String fh = String.valueOf(forceHigh);
			String wrg = String.valueOf(wrangler);
			String na = String.valueOf(newAcct);
			//String hct = String.valueOf(hasChildTicket);
			//String nct = String.valueOf(numChildTicket);
			String prmAcct = String.valueOf(premAcct);
			String orig = String.valueOf(origin);
			String mrrRanking = String.valueOf(mrr);
			String poa1 = String.valueOf(poa);
			
			String rankingDebug = dys + '*' + pw + '*' + fm + '*' + fw + '*' + wrg + '*' + sas1 + '*' + na + '*' + prmAcct + '*' + orig + '*' + mrrRanking + '+' + poa1;
			
			decimal ranking = (days * priorityWeight * flaggedManager * flaggedWorker * wrangler * sas * newAcct * origin * mrr) + forceHigh + premAcct + poa;
			
			system.debug('child ranking: ' + ranking);
			
			if(c.Ranking2__c != ranking) {
				
				c.Ranking2__c = ranking;
				c.Ranking_Debug__c = rankingDebug;
				
				updateCases.add(c);
			}
		}
			 
		if(updateCases.size() > 0) {
			
			update updateCases; 
		}
		
	}
}