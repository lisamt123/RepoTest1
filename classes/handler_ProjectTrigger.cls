public with sharing class handler_ProjectTrigger {
	
	public static void updateProjectOwnerEmail(List<SFDC_520_Quote__c> projects, List<SFDC_520_Quote__c> oldProjects) {
		
		List<SFDC_520_Quote__c> ownerChangedProjects = new List<SFDC_520_Quote__c>();
		Set<Id> ownerChangedProjectIds = new Set<Id>();
		
		for(SFDC_520_Quote__c proj : projects) {
			
			for(SFDC_520_Quote__c oldProj : oldProjects) {
				
				if(proj.Id == oldProj.Id && proj.OwnerId != oldProj.OwnerId) {
					
					ownerChangedProjects.add(proj);
					ownerChangedProjectIds.add(proj.Id);
				}
			}
		}
		
		if(ownerChangedProjectIds.size() > 0) {
		
			List<Project_Piece__c> relatedProjectPieces = [SELECT Id, Project_Owner_Email__c, Project__c
														   FROM Project_Piece__c
														   WHERE Project__c IN :ownerChangedProjectIds];
														   
		   	for(SFDC_520_Quote__c proj : ownerChangedProjects) {
		   		
		   		for(Project_Piece__c pp : relatedProjectPieces) {
		   			
		   			if(proj.Id == pp.Project__c) {
		   				
		   				pp.Project_Owner_Email__c = proj.Owner.Email;
		   			}
		   		}
		   	}
		   	
			update relatedProjectPieces;
		}
	}
	
	public static void updateProjectMilestoneNA(List<SFDC_520_Quote__c> projects) {
		
		Set<Id> projIds = new Set<Id>();
		
		for(SFDC_520_Quote__c proj : projects) {
			
			projIds.add(proj.Id);
		}
		
		Map<Id, List<Project_Piece__c>> projPPMap = new Map<Id, List<Project_Piece__c>>();
		
		
		
		//List<Project_Piece__c> ppsT = [SELECT Id, Project__c, Name FROM Project_Piece__c WHERE Project__c IN :projIds];
		
		for(Project_Piece__c pp : [SELECT Id, Project__c, Name
							       FROM Project_Piece__c
							       WHERE Project__c IN :projIds]) {
			
			system.debug('Bazinga... projectPiece query loop');
			
			if(projPPMap.containsKey(pp.Project__c)) {
				
				/*
				List<Project_Piece__c> pps = projPPMap.get(pp.Project__c);
				
				pps.add(pp);
				
				projPPMap.put(pp.Project__c, pps);
				*/
				
				projPPMap.get(pp.Project__c).add(pp);
			}			
			else {
				
				/*
				List<Project_Piece__c> pps = new List<Project_Piece__c>();
				
				pps.add(pp);
				
				projPPMap.put(pp.Project__c, pps);
				*/
				
				projPPMap.put(pp.Project__c, new List<Project_Piece__c>{pp});
			}		       	
		}
		
		List<SFDC_520_Quote__c> updateProjects = new List<SFDC_520_Quote__c>();
		
		for(SFDC_520_Quote__c proj : projects) {
			
			boolean ppInventoryModule = false;
			boolean ppEbay = false;
			boolean ppPhotoOverlay = false;
			boolean ppILMImplementation = false;
			boolean ppEmailBanners = false;
			boolean ppLaunchCoordinator = false;
			boolean ppCRMImplementation = false;
			boolean ppDesking = false;
			boolean ppTextMessages = false;
			boolean ppAISRebatesSiteIntegration = false;
			boolean ppAISRebatesDeskingIntegration = false;
			boolean ppPBXIntegration = false;
			boolean ppDateAppendAuthenticom = false;
			boolean ppSurveyTool = false;
			boolean ppFormMapping = false;
			
			List<Project_Piece__c> pps = projPPMap.get(proj.Id);
			
			for(Project_Piece__c pp : pps) {
				
				if(pp.Name.contains('PP-Inventory Module-')) {
					
					ppInventoryModule = true;
				}
				else if(pp.Name.contains('PP-eBay listings - 10 free')) {
					
					ppEbay = true;
				}
				else if(pp.Name.contains('PP-Photo overlay-')) {
					
					ppPhotoOverlay = true;
				}
				else if(pp.Name.contains('PP-ILM Implementation-')) {
					
					ppILMImplementation = true;
				}
				else if(pp.Name.contains('PP-Email Banners-')) {
					
					ppEmailBanners = true;
				}
				else if(pp.Name.contains('PP-Launch Coordinator-')) {
					
					ppLaunchCoordinator = true;
				}
				else if(pp.Name.contains('PP-CRM Implementation-')) {
					
					ppCRMImplementation = true;
				}
				else if(pp.Name.contains('PP-Desking-')) {
					
					ppDesking = true;
				}
				else if(pp.Name.contains('PP-Text messages-')) {
					
					ppTextMessages = true;
				}
				else if(pp.Name.contains('PP-AIS Rebates (Site Integration)-')) {
					
					ppAISRebatesSiteIntegration = true;
				}
				else if(pp.Name.contains('PP-AIS Rebates (Desking integration) - Inventory-')) {
					
					ppAISRebatesDeskingIntegration = true;
				}
				else if(pp.Name.contains('PP-PBX Integration-')) {
					
					ppPBXIntegration = true;
				}
				else if(pp.Name.contains('PP-Data Append Authenticom-')) {
					
					ppDateAppendAuthenticom = true;
				}
				else if(pp.Name.contains('PP-Survey Tool-')) {
					
					ppSurveyTool = true;
				}
				else if(pp.Name.contains('PP-Form Mapping-')) {
				
					ppFormMapping = true;
				}
			}
			
			if(ppInventoryModule == false) {
				
				proj.MS1_PP_Inventory__c = 'N/A';
				proj.MS3_PP_Inventory__c = 'N/A';
				proj.MS4_PP_Inventory__c = 'N/A';
				proj.MS5_PP_Inventory__c = 'N/A';
				proj.MS9_PP_Inventory__c = 'N/A'; 
				proj.MS10_PP_Inventory__c = 'N/A';    
			}
			
			if(ppEbay == false) {
				
				proj.MS2_PP_eBayListings__c = 'N/A';
			}
			
			if(ppPhotoOverlay == false) {
				
				proj.MS6_PP_PhotoOverlay__c = 'N/A';
			}
			
			if(ppILMImplementation == false) {
				
				proj.MS1_PP_ILM__c = 'N/A';
				proj.MS2_PP_ILM__c = 'N/A';
				proj.MS9_PP_ILM__c = 'N/A';
			}
			
			if(ppEmailBanners == false) {
				
				proj.MS6_PP_EmailBanner__c = 'N/A';
			}
			
			if(ppLaunchCoordinator == false) {
				
				proj.MS2_PP_Launch__c = 'N/A';
				proj.MS3_PP_Launch__c = 'N/A';
				proj.MS4_PP_Launch__c = 'N/A';
				proj.MS5_PP_Launch__c = 'N/A';
				proj.MS6_PP_Launch__c = 'N/A';
				proj.MS8_PP_Launch__c = 'N/A';
				proj.MS9_PP_Launch__c = 'N/A';
			}
			
			if(ppCRMImplementation == false) {
				
				proj.MS6_PP_CRMImp__c = 'N/A';
				proj.MS8_PP_CRMImp__c = 'N/A';
				proj.MS9_PP_CRMImp__c = 'N/A';
			}
			
			if(ppDesking == false) {
				
				proj.MS5_PP_Desking__c = 'N/A';
				proj.MS8_PP_Desking__c = 'N/A';
				proj.MS9_PP_Desking__c = 'N/A';
			}
			
			if(ppTextMessages == false) {
				
				proj.MS4_PP_TextMsgs__c = 'N/A';
			}
			
			if(ppAISRebatesSiteIntegration == false) {
				
				proj.MS3_PP_AIS_Site__c = 'N/A';
			}
			
			if(ppAISRebatesDeskingIntegration == false) {
				
				proj.MS3_PP_AIS_Desking__c = 'N/A';
			}
			
			if(ppPBXIntegration == false) {
				
				proj.MS6_PP_PBX__c = 'N/A';
			}
			
			if(ppDateAppendAuthenticom == false) {
				
				proj.MS5_PP_DataAppend__c = 'N/A';
			}
			
			if(ppSurveyTool == false) {
				
				proj.MS1_PP_Survey__c = 'N/A';
			}
			
			if(ppFormMapping == false) {
				
				proj.MS1_PP_FormMapping__c = 'N/A';
			}
			
			updateProjects.add(proj);
		}
		
		update updateProjects;
	}
}