global class job_updateCaseRankings implements 
    Database.Batchable<SObject>, Database.Stateful, Schedulable{
    	
    	string query;
    	
    	public job_updateCaseRankings(){
    		query = 'SELECT Id, parentId FROM Case WHERE isClosed = false';
    		if(test.isRunningTest()){
    			query += ' LIMIT 100';
    		}
    	}
    	
    	global void execute(SchedulableContext sc){
    		database.executebatch(new job_updateCaseRankings(),1);
	    }
	    
	    global Database.queryLocator start(Database.BatchableContext ctx){
	        return Database.getQueryLocator(query);  
	    } 
	    
	    global void execute(Database.BatchableContext ctx, List<Sobject> scope){ 
	    	processCases((List<Case>)scope);
	    }
	    
	    public void processCases(List<Case> cases){
	    	Set<Id> parentCaseIds = new Set<Id>();
	    	Set<Id> childCaseIds = new Set<Id>();
	    	
	    	for(Case c : cases){
	    		if(c.parentId == null){
	    			parentCaseIds.add(c.Id);		
	    		}
	    		else{
	    			childCaseIds.add(c.Id);
	    		}
	    	}
	    	WeightedRanking wr = new WeightedRanking();
	    	wr.CalculateParentRanking(parentCaseIds);
	    	wr.CalculateChildRanking(childCaseIds);
	    }
    	
    	global void finish(Database.BatchableContext ctx){
        
        AsyncApexJob a = [SELECT id, ApexClassId, 
                       JobItemsProcessed, TotalJobItems, 
                       NumberOfErrors, CreatedBy.Email 
                       FROM AsyncApexJob 
                       WHERE id = :ctx.getJobId()];
    	}
    	


}