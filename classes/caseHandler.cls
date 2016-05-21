public class caseHandler {
	
	/*
	public static void updateCaseDescriptionOnRunner(List<Case_Runner__c> runners){
		List<Case> updateCases = new List<Case>();
		Set<Id> caseIds = new Set<Id>();
		for(Case_Runner__c r : runners){
			if(r.case__c != null){
				caseIds.add(r.case__c);
			}
		}
		
		Map<Id, Case> caseMap = new Map<Id, Case>([Select Id, Defect__c, Description 
													FROM Case 
													WHERE Id = :caseIds]);
		for(Case_Runner__c r : runners){
			//Begin old logic
			if(r.RecordTypeId == '012700000005eL7' && r.Defect_Id__c != null && caseMap.containsKey(r.case__c)){
				//Case D = [Select Id, Defect__c, Description from Case where Id = : r.Case__c];
				Case c = caseMap.get(r.case__c);
				r.Case_Description__c = c.Description;
				
				if(c.Defect__c == null){
					c.Defect__c = r.Defect_Id__c;
					updateCases.add(c);
					//update D;
				}
			}
			//end old logic
		}
		update updateCases;
	}
	*/
	
	@future	
	public static void updateRelatedCases (Set<Id> caseIds){
		List<Case> updateCases = [select Id from Case where Id IN :caseIds];
		update updateCases;
	}
		
}