public class vAutoProjectHandler extends ProjectHandler{  
       
    
    public override void afterUpdate(SFDC_520_Quote__c newProj, SFDC_520_Quote__c oldProj){   	
        newProj = [Select Id, Status__c,Project_Type__c,Approval_Stage__c
                          ,Related_POA__r.OwnerId, Related_POA__c, Related_POA__r.Acquisition_Pro__c, Action__c
                    from  SFDC_520_Quote__c where id =: newProj.Id];
   	
       	/*
        system.debug('Current User LastName: '+Userinfo.getLastName());
       	if(Userinfo.getLastName() != 'Mosali'){
       		System.debug('running base method');	
       		super.afterUpdate(newProj,oldProj);
       		return;
       	}
       	*/
       	
        System.debug('oldProj.Status__c: '+oldProj.Status__c);

        if(newProj.Approval_Stage__c == 'Completed' && newProj.Related_POA__r.Acquisition_Pro__c != null
            && newProj.Project_Type__c.contains('Stockwave') && newProj.Action__c == 'Sale'){
            CreateTask('* AP Call',0,newProj.Related_POA__r.Acquisition_Pro__c,newProj.Related_POA__c);
        }
       	
       	//do not run if the project was completed once
       	if(oldProj.Status__c != 'Completed'){
       		
       	    System.debug('newProj.Project_Type__c :'+newProj.Project_Type__c);
       		System.debug('newProj.Approval_Stage__c :'+newProj.Approval_Stage__c);
       		//If Provision Project
       		if(newProj.Project_Type__c == 'Account Setup'){
       		   if(newProj.Approval_Stage__c == 'Integration' && oldProj.Approval_Stage__c != 'Integration'){
       		       UpdateProductStatus(newProj,'Pending Needs  Data');	
       		   }
       		   else if(newProj.Approval_Stage__c == 'Integration Complete' && oldProj.Approval_Stage__c != 'Integration Complete'){
       		       UpdateProductStatus(newProj,'Pending Needs Training');	
       		   }
       		   else if(newProj.Approval_Stage__c == 'Training 2' && oldProj.Approval_Stage__c != 'Training 2'){
       		       UpdateProductStatus(newProj,'Pending Launch Approval');	
       		
       		       //Create Task
       		       CreateTask('* 1st PM Call',0,newProj.Related_POA__r.OwnerId,newProj.Related_POA__c);
       	        }   		
       		}
       		//Conquest Project
       		else if(newProj.Project_Type__c == 'Conquest' || newProj.Project_Type__c == 'Conquest Stand-Alone'){
       		   if(newProj.Approval_Stage__c == 'Integration' && oldProj.Approval_Stage__c != 'Integration'){
       		       UpdateProductStatus(newProj,'Pending Needs  Data');	
       		   }
       		   else if(newProj.Approval_Stage__c == 'Integration Complete' && oldProj.Approval_Stage__c != 'Integration Complete'){
       		       UpdateProductStatus(newProj,'Pending Needs Training');	
       		   }
       		   else if(newProj.Approval_Stage__c == 'Completed' && oldProj.Approval_Stage__c != 'Completed'){
       			
               		UpdateProductStatus(newProj,'Pending Launch Approval');	
               		//Create Task
               		//String CurrentClassName = String.valueOf(this).substring(0,String.valueOf(this).indexOf(':'));
               		//System.debug('Creating 1st PM Call: '+CurrentClassName );
               		//CreateTask('* 1st PM Call',0,newProj.Related_POA__r.OwnerId,newProj.Related_POA__c);
           		}   		
       		}
            //Auction Genius
            else if(newProj.Project_Type__c != null && newProj.Project_Type__c.startsWithIgnoreCase('Auction Genius -')){
                if(newProj.Approval_Stage__c == 'Integration' && oldProj.Approval_Stage__c != 'Integration'){
                    UpdateProductStatus(newProj,'Pending Needs  Data'); 
                }
                else if(newProj.Approval_Stage__c == 'Integration Complete' && oldProj.Approval_Stage__c != 'Integration Complete'){
                    UpdateProductStatus(newProj,'Pending Needs Training');  
                }
                else if(newProj.Approval_Stage__c == 'Completed' && oldProj.Approval_Stage__c != 'Completed'){
            
                    UpdateProductStatus(newProj,'Good'); 
                }             
       		}
        } 
   	}
   
    private void CreateTask(String subject, Integer dueInDays, Id ownerId, Id poaId){
   	
   	    //check if the task created
        List<Task> tasks = [Select Id from Task where ownerId=:ownerId
                                                    and whatId=:poaId
                                                    and Subject =: subject
                                                    and Status =: 'Not Started'];
      
        if(tasks == null || tasks.size() == 0){
            Task task = new Task();
            task.Subject =  subject;
            task.ActivityDate = System.today().addDays(dueInDays);
            task.OwnerId = ownerId;
            task.WhatId = poaId;
            insert task;
        }
    }
    //this will set the status of billed Items related to a 
    // base product to the specfied status
    private static void UpdateProductStatus(SFDC_520_Quote__c newProj, String status){
   	
        system.debug('Updating Product status: '+status+' because Project Type: '+newProj.Project_Type__c+'Approval Stage changed');
   	
        // first find all project pieces
        List<Project_Piece__c> projPieces = [SELECT Id, Opportunity_Line_Item_ID__c
                                                FROM Project_Piece__c
                                                WHERE Project__c =: newProj.Id];
           
        //find all the related billing Items for above project pieces
        //which are marked with LOB; to showup as product suites/status in POA
        List<Billing_Item__c> billingItemsMarkedWithLOB = [Select Id from Billing_Item__c where Related_Project_Piece__c IN :projPieces
   								                                                             AND LOB__c !=null];
   								
        //set the status 
        for(Billing_Item__c item : billingItemsMarkedWithLOB){
   		   item.LOB_Status__c = status;	   	  
        }
        system.debug('Updated :'+billingItemsMarkedWithLOB.size()+' many Billing Items Status to:'+ status);
   
        //update the status
        if(billingItemsMarkedWithLOB.size() > 0){
   	        update billingItemsMarkedWithLOB;
        }   									   								   				
    }

    //Create Project
    public void GenerateProjectAndPieces(Opportunity opp, OpportunityLineItem[] oppLines, Product_Process__c[] prodProc,
                                            Territory_State__c territoryState, Map<String, POA__c> eixstingPOAList  ) {  
        //Map<Id, POA__c> productPOAMap  ) { 	
        Map<String,RecordType> projectRecordTypes = StaticData.getInstance().ProjectRecTypesMapByDevName;
        Map<String,RecordType> projectPieceRecordTypes = StaticData.getInstance().ProjectPiecesRecTypesMapByDevName;
   
        boolean requiresImplementationProject = false;
        boolean requiresWebsitesProject = false;
        decimal mrr = 0;

        //For cases where we can have Opportunites with out products
        //and need special handling
        //check if opp has products
        if(oppLines == null || oppLines.size() ==0){
   	        //if no
   	        //check if the Opportunity type
   	        if(opp.Type == 'Remove' || opp.Type == 'Price Changes' || opp.Opportunity_Names__c == 'AUX Account Setup'){
                POA__c poa; 
                //Create POA If Needed
                RecordType poaRecordType = StaticData.getInstance().POARecTypesMapByName.get('vAuto');
   		
                if(poaRecordType == null){
                    throw new CoxAutomotiveException('Could not find POA recordType vAuto');
                }
                List<POA__c> existingPOA = [Select Id from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId =: poaRecordType.Id and status__c !=: 'Churned'];
	    
                //if exists use
                if(existingPOA != null && existingPOA.size() > 0){	    	
                    poa = existingPOA[0];	
                }
                else{
                    //create one.
    	        	String poaName =  StaticData.getInstance().getBUIdentifierByOppRecType(opp.RecordTypeId)+'-';
                    if(opp.Account.Name.length() > 61){        
                        poaName  += opp.Account.Name.substring(0,58) + '...';
                    }
                    else {        
                        poaName  += opp.Account.Name; 
                    }
                    poa = POAHandler.CreatePOA(opp.AccountId, poaName, poaRecordType);		  
                }
                //Only for Type Remove Opportunites; create project
                //if(opp.Type == 'Remove'){
   		
                //create a project
                SFDC_520_Quote__c proj = new SFDC_520_Quote__c();
                proj.RecordTypeId = projectRecordTypes.get('vAuto').Id;
   		    	proj.Related_POA__c = poa.Id;
                proj =super.InitializeImplementationProject(opp,
                                                            oppLines,
                                                            territoryState,
                                                            mrr,
                                                            proj);	 
                if(opp.Account.Name.length() > 66) {    
                    proj.Name = StaticData.vAutoIdenitifer+'-' + opp.Account.Name.substring(0,63);
                }
                else {    
                    proj.Name = StaticData.vAutoIdenitifer+'-' + opp.Account.Name;  
                }

                if(opp.Opportunity_Names__c == 'AUX Account Setup'){
                    String auxProjownerEmail = vAuto__c.getOrgDefaults().Default_Project_Owner__c;
                    if(auxProjownerEmail ==null || auxProjownerEmail =='' ){
                        throw new CoxAutomotiveException('Could not find the project owner; NO value for Default_Project_Owner__c in vAuto__c custom setting');  
                    }
                    List<User> auxProjOwnerusers = [Select Id from User where email =:auxProjownerEmail];  
        
                    if(auxProjOwnerusers== null || auxProjOwnerusers.size() == 0){  
                        throw new CoxAutomotiveException('Could not find the project owner; No users with email: '+auxProjownerEmail); 
                    }
                    proj.OwnerId  = auxProjOwnerusers[0].Id;          

                    insert proj;
                    vAutoAsynHandler.handleProjectCreation(proj.Id);
                }
                else if(opp.Type == 'Price Changes'){
                    //get the project owner from custom settings
                    String priceChangeownerEmail = vAuto__c.getOrgDefaults().Removal_Project_Owner__c;
                    if(priceChangeownerEmail ==null || priceChangeownerEmail =='' ){
                        throw new CoxAutomotiveException('Could not find the project owner; NO value for Removal_Project_Owner__c in vAuto__c custom setting');  
                    }
                    List<User> priceChangeownerusers = [Select Id from User where email =:priceChangeownerEmail];  
        
                    if(priceChangeownerusers== null || priceChangeownerusers.size() == 0){  
                        throw new CoxAutomotiveException('Could not find the project owner; No users with email: '+priceChangeownerEmail); 
                    }
                    proj.OwnerId  = priceChangeownerusers[0].Id;
                    proj.Approval_Stage__c = 'Completed';
                    insert proj;
                }
                else{
                    //get the project owner from custom settings
                    String ownerEmail = vAuto__c.getOrgDefaults().Removal_Project_Owner__c;
                    if(ownerEmail ==null || ownerEmail =='' ){
                        throw new CoxAutomotiveException('Could not find the project owner; NO value for Removal_Project_Owner__c in vAuto__c custom setting');  
                    }
                    List<User> users = [Select Id from User where email =:ownerEmail];  
        
                    if(users== null || users.size() == 0){  
                        throw new CoxAutomotiveException('Could not find the project owner; No users with email: '+ownerEmail); 
                    }
                    proj.OwnerId  = users[0].Id;
                    proj.Approval_Stage__c = 'Integration';
                    insert proj;
                }
            }
        return;  	
        }
   
   
        List<OpportunityLineItem> mrrOLI = [SELECT Id, PricebookEntry.Product2.Name, PricebookEntry.Product2.Disable_Price_Change__c, ProductId__c, Quantity, UnitPrice, UserPriceChange__c, List_Price_Formula__c
                                             FROM OpportunityLineItem
                                             WHERE OpportunityId = :opp.Id AND One_Time_Fee__c = false AND Setup_Fee__c = false AND PricebookEntry.Product2.Disable_Price_Change__c = false];
                                             
        for(OpportunityLineItem oli : mrrOLI){
            mrr += oli.List_Price_Formula__c;
        }
    
        //Creat all projects that needs to be created for this opportunity
        Map<String,SFDC_520_Quote__c> projectsMapByCategory = new Map<String,SFDC_520_Quote__c>();
        Map<Id, SFDC_520_Quote__c>  projectsMapByProjectDefinitionId = CreateProjectsByProjectDefinitions(opp, 
                                                                                                            oppLines,
                                                                                                            territoryState,
                                                                                                            eixstingPOAList,
                                                                                                            mrr,
                                                                                                            projectsMapByCategory);
    
    
        //Update the Project Names
        /*for(Id projectDefId : projectsMapByProjectDefinitionId.keySet()){ 
        	if(opp.Account.Name.length() > 66) {    
                projectsMapByProjectDefinitionId.get(projectDefId).Name = StaticData.vAutoIdenitifer+'-' + opp.Account.Name.substring(0,63);
            }
            else {    
                projectsMapByProjectDefinitionId.get(projectDefId).Name = StaticData.vAutoIdenitifer+'-' + opp.Account.Name;  
            }
        }*/

        //update project.Project_Name__c = 
        for(SFDC_520_Quote__c project : projectsMapByCategory.values()){
    	   system.debug('Updating vAuto Project.Name From:' +project.Name);
            system.debug('Updating vAuto Project.Project_Name__c From:' +project.Project_Name__c);
            String projectName = '';
            projectName =  StaticData.vAutoIdenitifer+ '-' + Utility.substring(opp.Account.Name,0,40);
            projectName =  projectName + '-' + Utility.substring(opp.Opportunity_Names__c,0,30);
            projectName =  projectName +'-' + Utility.substring(opp.Type,0,10);
            project.Name = projectName;
            project.Project_Name__c = projectName;      
            system.debug('Updated vAuto Project.Name: to:'+ project.Name);
            system.debug('Updated vAuto Project.Project_Name__c: to:'+ project.Project_Name__c);
        }
   
        //Create Projects
        //insert projectsMapByProjectDefinitionId.values();
        insert projectsMapByCategory.values();
    
        //Create a list of Project Pieces to be generated   
        LIST<Project_Piece__c> piecesToCreate = CreateProjectPieces(opp,oppLines,projectsMapByProjectDefinitionId,
                                                                    prodProc,
                                                                    territoryState);
    
        //Generate all the project pieces in the list
        try {
            insert piecesToCreate;    
            system.debug('piecesToCreate.size(): ' + piecesToCreate.size());    
        }
        catch(Exception Ex) {
    	   try{
                String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
                Messaging.Singleemailmessage mail = new Messaging.Singleemailmessage();   
                String[] toAddresses = new String[] {'ramana.mosali@autotradergroup.com'};
                mail.setToAddresses(toAddresses);
                mail.setReplyTo('ramana.mosali@autotradergroup.com');
                mail.setSubject('Error creating project pieces for ' + opp.Id);
                mail.setPlainTextBody('Error creating project pieces for opportunity ' + opp.Id + '<br /> Error: ' + Ex);
                mail.setHtmlBody('Error creating project pieces for opportunity <a href=' + fullURL + opp.Id + '>' +
                opp.Id + '</a><br /> Error:' + Ex);
                //Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
                system.debug(Ex);
            }
            catch(Exception e){}
        }
        //Invoke the @future method to update the stage to Integration 
        //since there are other workflow rules that are happening from this which will hit Gonvern Limit
        if( projectsMapByProjectDefinitionId!= null &&  projectsMapByProjectDefinitionId.Values() != null && projectsMapByProjectDefinitionId.Values().size()> 0){
            if(projectsMapByProjectDefinitionId.Values().size()> 10){
                throw new CoxAutomotiveException('Could not fire more than 10 future methods; current future calls:'+projectsMapByProjectDefinitionId.Values().size());
            }
            for(SFDC_520_Quote__c proj : projectsMapByProjectDefinitionId.Values()){
                //handler_async_ConsolidationOpportunity.assginProjectStage(proj.Id, 'Integration');
                vAutoAsynHandler.handleProjectCreation(proj.Id);
            }    
        }
    }

    public override LIST<Project_Piece__c> CreateProjectPieces(Opportunity opp,OpportunityLineItem[] oppLines,
                                                                Map<Id, SFDC_520_Quote__c> projectsMapByProjectDefinitionId,
                                                                Product_Process__c[] prodProc,
                                                                Territory_State__c territoryState){
	
        system.debug('CReate Project Pieces: ');
        LIST<Project_Piece__c> projectPieces = super.CreateProjectPieces(opp,oppLines,projectsMapByProjectDefinitionId,prodProc,territoryState);
        //update the Project Peice record Type to vAuto
        Map<String,RecordType> projectPieceRecordTypes = StaticData.getInstance().ProjectPiecesRecTypesMapByDevName;
        //create a map
        Map<Id,OpportunityLineItem> mapOppLines = new Map<Id,OpportunityLineItem>(oppLines); 
        for(Project_Piece__c piece : projectPieces){
            system.debug('CReate Project Piece: '+piece.Product_Name__c+ ' Project:'+piece.project__c);
            OpportunityLineItem oppLine = mapOppLines.get(piece.Opportunity_Line_Item_ID__c);
    		//if(piece.OwnerId == null)
    		//{
    		//	 throw new CoxAutomotiveException('Project Piece does not have a owner'+ piece.Id);	
    		//}
            piece.RecordTypeId = projectPieceRecordTypes.get('vAuto').Id;

            //update name
            string pieceName = 'VAT-' + oppLine.Product_Issue__c + '-' + opp.Account.Name;			
            if(opp.Opportunity_Names__c == 'Conquest' && 
                (opp.Type == 'Sale' || opp.Type == 'Reactivate')){

                piece.Contact__c = oppLine.Product_Contact__c;
                pieceName = 'VAT-' + oppLine.Product_Issue__c + '-' + opp.Account.Name + '-'+ piece.Product_Make__c;	
            }
            if(pieceName.length() >= 78) {    
                pieceName = piecename.substring(0,73);
            }
            piece.Name =pieceName;
	    }	
        return projectPieces;
    }
}