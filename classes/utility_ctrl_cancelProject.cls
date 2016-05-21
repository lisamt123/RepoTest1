public with sharing class utility_ctrl_cancelProject {
	
	
	public String projectId {get;set;}
	
	public utility_ctrl_cancelProject() {
		
		projectId = ApexPages.currentPage().getParameters().get('projectId');
	}
	
	
	
	public static void cancelProjectAndProjectPieces(Id projId) {
		
		
		
		SFDC_520_Quote__c project = [SELECT Id, Approval_Stage__c
	    							 FROM SFDC_520_Quote__c
	    							 WHERE Id = :projId
	    							 LIMIT 1];
	    							 
	 	
	    							 
	 	project.Approval_Stage__c = 'Cancelled';
	 	
	 	update project;
		
		
		
		List<Project_Piece__c> projectPieces = [SELECT Id, Project_Piece_Stage__c
											    FROM Project_Piece__c
											    WHERE Project__c = :projId];
		
		if(projectPieces.size() > 0) {
								    
		    for(Project_Piece__c pp : projectPieces) {
		    	
		    	pp.Project_Piece_Stage__c = 'Cancelled';
		    }
		    
		    system.debug('Bazinga....queries 1: ' + Limits.getQueries());
		    
		    update projectPieces;
		    
		    system.debug('Bazinga....after update');
		}
	    
	    
	}
	
	
	
	
	
	public PageReference redirect() {
		
		//do something
		cancelProjectAndProjectPieces(projectId);
		
		PageReference pr = new PageReference('/' + projectId);
		return pr.setRedirect(true);
	}

}