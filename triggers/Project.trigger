trigger Project on SFDC_520_Quote__c (after update, before delete, before insert, before update) {
    
/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('Project')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}
    
    
    if(trigger.isBefore && trigger.isDelete) {
        
        for(SFDC_520_Quote__c Project:Trigger.old) {
            
            integer remainingPieces = [select count() from Project_Piece__c where Project__c = :Project.Id];
            
            if(remainingPieces > 0) {
                
                Project.addError('A Project cannot be deleted without first deleting the related Project Pieces.');
            }
        }
    }
    
    
    if(trigger.isBefore && trigger.isInsert) {
        
        for(SFDC_520_Quote__c nProj:Trigger.new) {
            
            //Ramana: 09/04/2014: Looks like this method is copying the fullname, email, TeamName and SquadName
            //Confirmed this; and seems ti be used in so many reports and Dashborsa.. Mark/Ramana left it the way it is for now.
            ProjectClass2.UpdateOwnerName(nProj);
            
            /*
            Ramana: 09/04/2014: This is done when the project is created from ProjectHandler class            
            if(nProj.Opportunity__r.Implementation_Contact__c != null) {
                
                try {
                    
                    nproj.Contact__c = nProj.Opportunity__r.Implementation_Contact__c;  
                }
                catch(Exception ex) {
                    
                    system.debug(ex);
                }
            }*/
        }
    }
    
    if(trigger.isBefore && trigger.isUpdate) {
        
        Map<Id, SFDC_520_Quote__c> theseProjects = new Map<Id, SFDC_520_Quote__c>();
        MAP<Id, Project_Piece__c> runPieces = new MAP<Id, Project_Piece__c>();
        
        LIST<Project_Piece__c> projPieceList = new LIST<Project_Piece__c>();
        LIST<Task> openTasks = new LIST<Task>(); 
        
        boolean run = false;
        
        //Populate MAP of IDs for all Projects to being updated
        for(SFDC_520_Quote__c thisProject : trigger.new) {
            
            SFDC_520_Quote__c old = trigger.oldMap.get(thisProject.Id);
            
            if(thisProject.OwnerId != old.OwnerId) {
                
                run=true;
            }
                        
            theseProjects.put(thisProject.Id, thisProject);
        }
        
        if(run == true) {
            
            //Populate a List of Project Pieces related to the Project IDs in the "theseProjects" MAP
            for(Project_Piece__c PrP : [SELECT id, Project_Piece_Stage__c, Project__c, ownerid 
                                        FROM Project_Piece__c   
                                        WHERE Project__c IN: theseProjects.keySet() 
                                        AND Project_Piece_Stage__c != 'Completed']) {
                                            
                projPieceList.add(PrP);
                runPieces.put(PrP.Id, PrP);
            }
            
            //Populate a list of Tasks related to the Project Pieces related to the Project MAP list    
            for(Task T : [SELECT Status, WhatId, OwnerId, Id 
                          FROM Task 
                          WHERE whatId IN: runPieces.keySet() 
                          AND Status!='Completed']) {
                            
                openTasks.add(T);
            }
        }
        
        //Get a list of all the User Office Assignments
     
      string TM = null;
        string TMemail = null;
        string TF = null;
        string TFemail = null;
        string TA = null;
        string TAemail = null;
        string PS = null;
        string PSemail = null;
     
     
                     UtilityClass.debugSystemLimits();
        List<User> userList = [SELECT Id, Email, Manager_of_Training__c, IsActive, In_charge_of_Printing_Shipping__c,
                            Travel_Financer__c,Travel_Arranger__c 
                      FROM User 
                      WHERE (Manager_of_Training__c=True 
                      OR Travel_Financer__c=True 
                      OR Travel_Arranger__c=True 
                      OR In_charge_of_Printing_Shipping__c=True) 
                      AND IsActive = True];
        for(User U :userList ) {
                        
            if(U.Manager_of_Training__c == TRUE) {
                
                TM = U.id;
                TMemail = U.Email;
            }
            
            if(U.Travel_Arranger__c == TRUE) {
                
                TA = U.id;
                TAemail = U.Email;
            }
            
            if(U.Travel_Financer__c == TRUE) {
                
                TF = U.id;
                TFemail = U.Email;
            }
            
            if(U.In_charge_of_Printing_Shipping__c == TRUE) {
                
                PS = U.id;
                PSemail = U.Email;
            }
        }
            
                
        for(SFDC_520_Quote__c nProj : trigger.new) {
            
            SFDC_520_Quote__c oProj = Trigger.oldMap.Get(nProj.Id);
        
            ProjectOwnerChange.updatePacketSent(nProj, oProj, projPieceList, openTasks, TM, TMemail, TA, TAemail, TF, TFemail, PS, PSemail); 
            //ProjectOwnerChange.updatePacketSent(nProj, oProj, projPieceList, openTasks);
        }
    }
    
    
    if((trigger.isAfter && trigger.isUpdate) || (trigger.isBefore && trigger.isUpdate)) {
        
        for(SFDC_520_Quote__c Proj : trigger.new) {
            
            SFDC_520_Quote__c Old = Trigger.oldMap.get(Proj.Id);
            
            if(trigger.isBefore) {
                
                if(Proj.Approval_Stage__c != 'GO LIVE') {
                    
                    if(Old.Date_Packet_Sent__c == null && Proj.Date_Packet_Sent__c != null) {
                        
                        Proj.Approval_Stage__c = 'Requirement Gathering';
                    }
                    
                    if(Old.Date_Packet_Ret_d__c == null && Proj.Date_Packet_Ret_d__c != null) {
                        
                        Proj.Approval_Stage__c = 'DMS Access';
                    }
                    
                    if(Old.DMS_Accessed__c == null && Proj.DMS_Accessed__C != null) {
                        
                        Proj.Approval_Stage__c = 'Configuration-Inventory';
                    }
                    
                    if(Old.Inventory_Completed__c == null && Proj.Inventory_Completed__c != null) {
                        
                        Proj.Approval_Stage__c = 'Configuration-ILM';
                    }
                    
                    if(Old.ILM_Completed__c == null && Proj.ILM_Completed__c != null) {
                        
                        Proj.Approval_Stage__c = 'Configuration-CRM';
                    }
                    
                    if(Old.CRM_Completed__c == null && Proj.CRM_Completed__C != null) {
                        
                        Proj.Approval_Stage__c = 'Finalization';
                    }
                
                    //ProjectClass2.UpdateOwnerName(Proj); 
                }
                if(Proj.Approval_Stage__c != 'GO LIVE' && Proj.Approval_Stage__c != 'Work Complete' && Proj.Approval_Stage__c != 'Cancelled' && Proj.RecordType.Name != 'FROZEN'){
                    ProjectClass2.UpdateOwnerName(Proj);
                }
            }
    
            if(trigger.isAfter) {   
                
                if(Old.Date_Packet_Sent__c == null && Proj.Date_Packet_Sent__c != null) {
                    
                    ProjectClasses.closeValidateTask(Trigger.New);
                }
                
                if(Old.Date_Packet_Ret_d__c == null && Proj.Date_Packet_Ret_d__c != null) {
                    
                    ProjectClasses.PacketReturned(Trigger.New); 
                }
                
                if(Old.Date_Graphics_Obtained__c == null && Proj.Date_Graphics_Obtained__c != null) {
                    
                    ProjectClasses.GraphicsObtained(Proj);
                }
                
                if(Old.Approval_Stage__c != 'Cancelled' && Proj.Approval_Stage__c == 'Cancelled') {
                    
                    //ProjectClasses.updateCancelledProjectPieces(Proj);
                }
                
                if(Old.Confirmed_Training_End__c == null && Proj.Confirmed_Training_End__c != null) {
                    
                    ProjectClasses.TrainingEndDateConfirmed(Trigger.New);           
                }
                
                if((Old.Proposed_Training_Start__c == null || Old.Proposed_Training_End__c == null || 
                    Old.Proposed_Training_End__c != Proj.Proposed_Training_End__c || 
                    Old.Proposed_Training_Start__c != Proj.Proposed_Training_Start__c/*|| old.Trainer__c == null*/) &&
                   (Proj.Proposed_Training_Start__c != null && Proj.Proposed_Training_End__c != null /*&& Proj.Trainer__c != null*/)) {
                    
                    Id assignmentId = null; 
                    
                    If(Proj.Trainer__c != null) {
                        
                        assignmentId = Proj.Trainer__c;
                    }
                    else {
                        
                        assignmentId = '00570000001doga';
                    }
                    
                    PhasedImplementationUpdate.CreateTrainingEvents(Proj.Proposed_Training_Start__c, Proj.Proposed_Training_End__c, assignmentId, Proj.Id);
                }
                
                if((Old.Approval_Stage__c != 'Billable-Not Complete' || Old.Approval_Stage__c != 'GO LIVE') && 
                   (Proj.Approval_Stage__c == 'Billable-Not Complete' || Proj.Approval_Stage__c == 'GO LIVE')) {
                    
                    ProjectClasses.updateImplementationDate(Proj.Account__c);
                }               
            }           
        }
    }
    
    if(trigger.isAfter && trigger.isUpdate) {
        
        handler_ProjectTrigger.updateProjectOwnerEmail(trigger.new, trigger.old);
        handler_Project.BuildAssetRecUpdate(trigger.new);
    }
}