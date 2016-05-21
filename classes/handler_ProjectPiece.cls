public without sharing class handler_ProjectPiece {
	
	public static void autofollow(List<Project_Piece__c> projectPieces) {
		
		//..
		//..
		List<EntitySubscription> insertEntitySubscriptions = new List<EntitySubscription>();
		Set<Id> closedProjectPieceIds = new Set<Id>();
		
		
		
		for(Project_Piece__c pp : projectPieces) {
			
			//if(pp.Owner.UserRoleId)
			//String roleName = 
			
			if(pp.Owner.userrole.DeveloperName != 'DirectorofImplementation' && pp.Owner.userrole.DeveloperName != 'Director_of_Websites' && pp.Owner.Name != 'Brian Schmid') {
			
				insertEntitySubscriptions.add(new EntitySubscription(ParentId = pp.Id, SubscriberId = pp.OwnerId));
				
				/* -------------------------------------------------
				------------------------------------------------- */
				if(pp.isClosed__c == 'True') {
					
					closedProjectPieceIds.add(pp.Id);
				}
			
			}
		}
		
		try {
			
			insert insertEntitySubscriptions;
		}
		catch(Exception e) {
			
			//do nothing
		}
		
		
		
		//User apiUser = [SELECT Id FROM User WHERE Name = 'API User'];
		
		
		//auto-UNfollow
		
		List<EntitySubscription> deleteEntitySubscriptions = new List<EntitySubscription>();
		
		if(closedProjectPieceIds.size() > 0) {
			
			deleteEntitySubscriptions = [SELECT Id, ParentId FROM EntitySubscription WHERE ParentId IN :closedProjectPieceIds LIMIT 500]; 
			
			//System.runas(apiUser) {
			
			delete deleteEntitySubscriptions;
			//}
		}
	}
	
	public static void updateProjectMilestoneComplete(List<Project_Piece__c> oldPPs, List<Project_Piece__c> newPPs) {
		
		Map<Id, Project_Piece__c> ppMap = new Map<Id, Project_Piece__c>();
		
		Set<Id> projectIds = new Set<Id>();
		
		for(Project_Piece__c pp : newPPs) {
			
			ppMap.put(pp.Id, pp);
			
			projectIds.add(pp.Project__c);	
		}
		
		List<SFDC_520_Quote__c> relatedProjects = new List<SFDC_520_Quote__c>();
		
		/**/
		relatedProjects = [SELECT Id, MS1_PP_Inventory__c, MS4_PP_Inventory__c, MS5_PP_Inventory__c, MS9_PP_Inventory__c,
								MS3_PP_Inventory__c, MS2_PP_ebayListings__c, MS6_PP_PhotoOverlay__c, MS2_PP_ILM__c,
								MS9_PP_ILM__c, MS6_PP_EmailBanner__c, MS1_PP_ILM__c, MS3_PP_Launch__c, MS6_PP_CRMImp__c,
								MS8_PP_CRMImp__c, MS8_PP_Desking__c, MS5_PP_Desking__c, MS4_PP_TextMsgs__c, MS3_PP_AIS_Site__c,
								MS3_PP_AIS_Desking__c, MS6_PP_PBX__c, MS5_PP_DataAppend__c, MS1_PP_Survey__c, MS2_PP_Launch__c,
								MS4_PP_Launch__c, MS1_PP_FormMapping__c, MS6_PP_Launch__c, MS5_PP_Launch__c
						   FROM SFDC_520_Quote__c
						   WHERE Id IN :projectIds];
		
		Map<Id, SFDC_520_Quote__c> projMap = new Map<Id, SFDC_520_Quote__c>();
		
		for(Project_Piece__c pp : newPPs) {
			
			for(SFDC_520_Quote__c proj : relatedProjects) {
				
				if(pp.Project__c == proj.Id) {
					
					projMap.put(pp.Id, proj);
				}
			}
		}
		
		//List<SFDC_520_Quote__c> updateProjects;// = new List<SFDC_520_Quote__c>();
		
		for(Project_Piece__c pp : oldPPs) {
			
			//updateProjects = new List<SFDC_520_Quote__c>();
			
			boolean projUpdate = false;
			
			Project_Piece__c newPP = ppMap.get(pp.Id);
			
			SFDC_520_Quote__c updateProj = projMap.get(newPP.Id);
			
			if(pp.Name.contains('PP-Inventory Module-')) {
				
				//
				if(pp.Milestone_1_Completed__c != newPP.Milestone_1_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_1_Completed__c != null) {
						
						updateProj.MS1_PP_Inventory__c = 'Complete ' + newPP.Milestone_1_Completed__c.format();
					}
					else {
						
						updateProj.MS1_PP_Inventory__c = '';
					}
				}
				
				//
				if(pp.Milestone_4_Completed__c != newPP.Milestone_4_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_4_Completed__c != null) {
						
						updateProj.MS4_PP_Inventory__c = 'Complete ' + newPP.Milestone_4_Completed__c.format();
					}
					else {
						
						updateProj.MS4_PP_Inventory__c = '';
					}
				}
				
				//
				if(pp.Milestone_5_Completed__c != newPP.Milestone_5_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_5_Completed__c != null) {
						
						updateProj.MS5_PP_Inventory__c = 'Complete ' + newPP.Milestone_5_Completed__c.format();
					}
					else {
						
						updateProj.MS5_PP_Inventory__c = '';
					}
				}
				
				//
				if(pp.Milestone_9_Completed__c != newPP.Milestone_9_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_9_Completed__c != null) {
						
						updateProj.MS9_PP_Inventory__c = 'Complete ' + newPP.Milestone_9_Completed__c.format();
					}
					else {
						
						updateProj.MS9_PP_Inventory__c = '';
					}
				}
				
				//
				if(pp.Milestone_3_Completed__c != newPP.Milestone_3_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_3_Completed__c != null) {
						
						updateProj.MS3_PP_Inventory__c = 'Complete ' + newPP.Milestone_3_Completed__c.format();
					}
					else {
						
						updateProj.MS3_PP_Inventory__c = '';
					}
				}
				
				//
				if(pp.Milestone_10_Completed__c != newPP.Milestone_10_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_10_Completed__c != null) {
						
						updateProj.MS10_PP_Inventory__c = 'Complete ' + newPP.Milestone_10_Completed__c.format();
					}
					else {
						
						updateProj.MS10_PP_Inventory__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-eBay listings - 10 free')) {
				
				//
				if(pp.Milestone_2_Completed__c != newPP.Milestone_2_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_2_Completed__c != null) {
						
						updateProj.MS2_PP_eBayListings__c = 'Complete ' + newPP.Milestone_2_Completed__c.format();
					}
					else {
						
						updateProj.MS2_PP_eBayListings__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-Photo overlay-')) {
				
				//
				if(pp.Milestone_6_Completed__c != newPP.Milestone_6_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_6_Completed__c != null) {
						
						updateProj.MS6_PP_PhotoOverlay__c = 'Complete ' + newPP.Milestone_6_Completed__c.format();
					}
					else {
						
						updateProj.MS6_PP_PhotoOverlay__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-ILM Implementation-')) {
				
				//
				if(pp.Milestone_2_Completed__c != newPP.Milestone_2_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_2_Completed__c != null) {
						
						updateProj.MS2_PP_ILM__c = 'Complete ' + newPP.Milestone_2_Completed__c.format();
					}
					else {
						
						updateProj.MS2_PP_ILM__c = '';
					}
				}
				
				//
				if(pp.Milestone_9_Completed__c != newPP.Milestone_9_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_9_Completed__c != null) {
						
						updateProj.MS9_PP_ILM__c = 'Complete ' + newPP.Milestone_9_Completed__c.format();
					}
					else {
						
						updateProj.MS9_PP_ILM__c = '';
					}
				}
				
				//
				if(pp.Milestone_1_Completed__c != newPP.Milestone_1_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_1_Completed__c != null) {
						
						updateProj.MS1_PP_ILM__c = 'Complete ' + newPP.Milestone_1_Completed__c.format();
					}
					else {
						
						updateProj.MS1_PP_ILM__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-Email Banners-')) {
				
				//
				if(pp.Milestone_6_Completed__c != newPP.Milestone_6_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_6_Completed__c != null) {
						
						updateProj.MS6_PP_EmailBanner__c = 'Complete ' + newPP.Milestone_6_Completed__c.format();
					}
					else {
						
						updateProj.MS6_PP_EmailBanner__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-Launch Coordinator-')) {
				
				//
				if(pp.Milestone_3_Completed__c != newPP.Milestone_3_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_3_Completed__c != null) {
						
						updateProj.MS3_PP_Launch__c = 'Complete ' + newPP.Milestone_3_Completed__c.format();
					}
					else {
						
						updateProj.MS3_PP_Launch__c = '';
					}
				}
				
				//
				if(pp.Milestone_2_Completed__c != newPP.Milestone_2_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_2_Completed__c != null) {
						
						updateProj.MS2_PP_Launch__c = 'Complete ' + newPP.Milestone_2_Completed__c.format();
					}
					else {
						
						updateProj.MS2_PP_Launch__c = '';
					}
				}
				
				//
				if(pp.Milestone_4_Completed__c != newPP.Milestone_4_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_4_Completed__c != null) {
						
						updateProj.MS4_PP_Launch__c = 'Complete ' + newPP.Milestone_4_Completed__c.format();
					}
					else {
						
						updateProj.MS4_PP_Launch__c = '';
					}
				}
				
				//
				if(pp.Milestone_6_Completed__c != newPP.Milestone_6_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_6_Completed__c != null) {
						
						updateProj.MS6_PP_Launch__c = 'Complete ' + newPP.Milestone_6_Completed__c.format();
					}
					else {
						
						updateProj.MS6_PP_Launch__c = '';
					}
				}
				
				//
				if(pp.Milestone_5_Completed__c != newPP.Milestone_5_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_5_Completed__c != null) {
						
						updateProj.MS5_PP_Launch__c = 'Complete ' + newPP.Milestone_5_Completed__c.format();
					}
					else {
						
						updateProj.MS5_PP_Launch__c = '';
					}
				}
				
				//
				if(pp.Milestone_8_Completed__c != newPP.Milestone_8_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_8_Completed__c != null) {
						
						updateProj.MS8_PP_Launch__c = 'Complete ' + newPP.Milestone_8_Completed__c.format();
					}
					else {
						
						updateProj.MS8_PP_Launch__c = '';
					}
				}
				
				//
				if(pp.Milestone_9_Completed__c != newPP.Milestone_9_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_9_Completed__c != null) {
						
						updateProj.MS9_PP_Launch__c = 'Complete ' + newPP.Milestone_9_Completed__c.format();
					}
					else {
						
						updateProj.MS9_PP_Launch__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-CRM Implementation-')) {
				
				//
				if(pp.Milestone_6_Completed__c != newPP.Milestone_6_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_6_Completed__c != null) {
						
						updateProj.MS6_PP_CRMImp__c = 'Complete ' + newPP.Milestone_6_Completed__c.format();
					}
					else {
						
						updateProj.MS6_PP_CRMImp__c = '';
					}
				}
				
				//
				if(pp.Milestone_8_Completed__c != newPP.Milestone_8_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_8_Completed__c != null) {
						
						updateProj.MS8_PP_CRMImp__c = 'Complete ' + newPP.Milestone_8_Completed__c.format();
					}
					else {
						
						updateProj.MS8_PP_CRMImp__c = '';
					}
				}
				
				//
				if(pp.Milestone_9_Completed__c != newPP.Milestone_9_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_9_Completed__c != null) {
						
						updateProj.MS9_PP_CRMImp__c = 'Complete ' + newPP.Milestone_9_Completed__c.format();
					}
					else {
						
						updateProj.MS9_PP_CRMImp__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-Desking-')) {
				
				//
				if(pp.Milestone_8_Completed__c != newPP.Milestone_8_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_8_Completed__c != null) {
						
						updateProj.MS8_PP_Desking__c = 'Complete ' + newPP.Milestone_8_Completed__c.format();
					}
					else {
						
						updateProj.MS8_PP_Desking__c = '';
					}
				}
				
				//
				if(pp.Milestone_5_Completed__c != newPP.Milestone_5_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_5_Completed__c != null) {
						
						updateProj.MS5_PP_Desking__c = 'Complete ' + newPP.Milestone_5_Completed__c.format();
					}
					else {
						
						updateProj.MS5_PP_Desking__c = '';
					}
				}
				
				//
				if(pp.Milestone_9_Completed__c != newPP.Milestone_9_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_9_Completed__c != null) {
						
						updateProj.MS9_PP_Desking__c = 'Complete ' + newPP.Milestone_9_Completed__c.format();
					}
					else {
						
						updateProj.MS9_PP_Desking__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-Text messages-')) {
				
				//
				if(pp.Milestone_4_Completed__c != newPP.Milestone_4_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_4_Completed__c != null) {
						
						updateProj.MS4_PP_TextMsgs__c = 'Complete ' + newPP.Milestone_4_Completed__c.format();
					}
					else {
						
						updateProj.MS4_PP_TextMsgs__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-AIS Rebates (Site Integration)-')) {
				
				//
				if(pp.Milestone_3_Completed__c != newPP.Milestone_3_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_3_Completed__c != null) {
						
						updateProj.MS3_PP_AIS_Site__c = 'Complete ' + newPP.Milestone_3_Completed__c.format();
					}
					else {
						
						updateProj.MS3_PP_AIS_Site__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-AIS Rebates (Desking integration) - Inventory-')) {
				
				//
				if(pp.Milestone_3_Completed__c != newPP.Milestone_3_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_3_Completed__c != null) {
						
						updateProj.MS3_PP_AIS_Desking__c = 'Complete ' + newPP.Milestone_3_Completed__c.format();
					}
					else {
						
						updateProj.MS3_PP_AIS_Desking__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-PBX Integration-')) {
				
				//
				if(pp.Milestone_6_Completed__c != newPP.Milestone_6_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_6_Completed__c != null) {
						
						updateProj.MS6_PP_PBX__c = 'Complete ' + newPP.Milestone_6_Completed__c.format();
					}
					else {
						
						updateProj.MS6_PP_PBX__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-Data Append Authenticom-')) {
				
				//
				if(pp.Milestone_5_Completed__c != newPP.Milestone_5_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_5_Completed__c != null) {
						
						updateProj.MS5_PP_DataAppend__c = 'Complete ' + newPP.Milestone_5_Completed__c.format();
					}
					else {
						
						updateProj.MS5_PP_DataAppend__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-Survey Tool-')) {
				
				//
				if(pp.Milestone_1_Completed__c != newPP.Milestone_1_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_1_Completed__c != null) {
						
						updateProj.MS1_PP_Survey__c = 'Complete ' + newPP.Milestone_1_Completed__c.format();
					}
					else {
						
						updateProj.MS1_PP_Survey__c = '';
					}
				}
			}
			else if(pp.Name.contains('PP-Form Mapping-')) {
				
				//
				if(pp.Milestone_1_Completed__c != newPP.Milestone_1_Completed__c) {
					
					projUpdate = true;
					
					if(newPP.Milestone_1_Completed__c != null) {
						
						updateProj.MS1_PP_FormMapping__c = 'Complete ' + newPP.Milestone_1_Completed__c.format();
					}
					else {
						
						updateProj.MS1_PP_FormMapping__c = '';
					}
				}
			}
			
			if(projUpdate == true) {
			
				update updateProj;
			}	
		}	
	}
}