public with sharing class handler_caseTrigger {

	public static void SetChildInfoFromParentChange(Case parentCase){
		boolean parentFR = false;
		List<Case> casesToUpdate = new List<Case>();
		for(Case c : [SELECT Id, ParentOTFR__c, Escalation_Type__c, ParentEscType__c, Escalate_To__c, ParentEscTo__c,
							 Status, ParentStatus__c, OT_Feature_Request__c, Feature_request_ID__c, ParentFRID__c,
							 Date_Escalated__c, ParentEscDate__c, ParentOTD__c
						FROM Case
					   WHERE ParentId =: parentCase.Id]){
			if(c.Escalation_Type__c != c.ParentEscType__c
			|| c.Escalate_To__c != c.ParentEscTo__c
			|| c.Status != c.ParentStatus__c
			|| c.Date_Escalated__c != c.ParentEscDate__c){	
				SetParentInfoOnChild(c);
				casesToUpdate.add(c);
			}
		}
		if(casesToUpdate.size() > 0){
			update casesToUpdate;
		}
	}

	public static Case SetParentInfoOnChild(Case newCase){
		//Update this child from it's parent				
		if(newCase.Escalation_Type__c != newCase.ParentEscType__c) {					
			newCase.Escalation_Type__c = newCase.ParentEscType__c;
		}				
		if(newCase.Escalate_To__c != newCase.ParentEscTo__c) {					
			newCase.Escalate_To__c = newCase.ParentEscTo__c;
		}				
		if(newCase.Status != newCase.ParentStatus__c) {					
			newCase.Status = newCase.ParentStatus__c;
		}					
		if(newCase.Date_Escalated__c != newCase.ParentEscDate__c) {				
			newCase.Date_Escalated__c = newCase.ParentEscDate__c;
		}
		
		return newCase;
	}
	
	public static void calculateNumberOfChildTickets(Set<Id> parents) {
		List<AggregateResult> groupedResults = [SELECT Count(Id)TotalChildren, ParentId parent
											  	  FROM Case
										     	 WHERE ParentId IN :parents
										  	  group by ParentId];

  		Map<Id, Integer> childrenPerParent = new Map<Id, Integer>();
  		for(AggregateResult ar : groupedResults){
  			childrenPerParent.put((Id)ar.get('parent'), (Integer)ar.get('TotalChildren'));
  		}
		if(childrenPerParent.size() > 0){
			for(Case p : [SELECT Number_of_Child_Tickets__c
					    FROM Case
					   WHERE Id IN :childrenPerParent.KeySet()]){
				p.Number_of_Child_Tickets__c = childrenPerParent.get(p.Id);
				update p;
			}
		}
		else{
			for(Case p : [SELECT Number_of_Child_Tickets__c
					    FROM Case
					   WHERE Id IN :parents]){
				p.Number_of_Child_Tickets__c = 0;
				update p;
			}
		}
	}
}