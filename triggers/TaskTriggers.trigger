trigger TaskTriggers on Task (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) 
{

    /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('TaskTriggers')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}
//========================================AFTER==================================================
    LIST<SFDC_520_Quote__c> updatedProjects = new LIST<SFDC_520_Quote__c>();    
    if(trigger.isAfter)
    {
    //===================================INSERT==================================================
        if(trigger.isInsert)
        {
            LIST<Case> updtCase = new LIST<Case>();
            LIST<Task> projectTasks = new LIST<Task>(); 
            LIST<Opportunity> updtOpportunity = new LIST<Opportunity>();        
            
            MAP<ID, Task> theseTasks = new MAP<ID, Task>();
            for(Task thisTask:Trigger.new)
            {
                theseTasks.put(thisTask.whatId,thisTask);
            }
            
            //LIST<Case> theseCases = new LIST<Case>();
            LIST<Case> theseCases = new LIST<CASE>([select id, Status, Origin from Case where id IN:theseTasks.keySet()]);
            LIST<Project_Piece__c> thesePieces = [select id, Project__c, Name from Project_Piece__c where id IN:theseTasks.keySet()];
            LIST<Opportunity> theseOpportunities = [select Id, LastActivityDate from Opportunity where id IN: theseTasks.keyset()];
            
            
            for(Task T:trigger.new)
            {
                
                //system.debug('New Task Created: ' + T.id);
                for(Opportunity thisOpportunity: theseOpportunities)
                {
                    String thisTaskNextStep = T.ActivityDate + ' ' + T.Subject;
                    integer numberOfOpenTasks = 0;
                    if (thisOpportunity.LastActivityDate <= T.LastModifiedDate && (T.Type == 'Call' || T.Type == 'Email'))
                    {
                        if (T.Description == null) thisOpportunity.Last_Activity_Preview__c = 'No Activity Description Provided';                       
                        else if (T.Description.length() > 96) thisOpportunity.Last_Activity_Preview__c = T.Description.substring(0, 96);
                        else thisOpportunity.Last_Activity_Preview__c = T.Description;                      
                        updtOpportunity.add(thisOpportunity);
                    }
                    /*if (T.WhatId == thisOpportunity.Id)
                    {
                        if (T.Status != 'Completed' && thisOpportunity.NextStep != thisTaskNextStep)
                        {
                            thisOpportunity.NextStep = thisTaskNextStep;
                        }
                    }*/                 
                }
                
                for(Case relatedcase:theseCases)
                {
                    if(T.WhatId==relatedcase.Id && !relatedcase.Status.tolowercase().contains('closed'))
                    {                       
                        //system.debug('This task:' + T.id + ' ,is associated with Case: ' + relatedcase.Id);
                        if(relatedcase.Status=='New' && T.Status=='Completed' && ((T.Subject.length()>=3 && T.Subject.substring(0,3)=='O/G')||(T.Subject.length()>=3&& T.Subject.substring(0,3)=='I/C')||(T.Subject.length()>=8&& T.Subject.substring(0,8)=='Email: 0')))
                            
                        relatedcase.Status='Working'; //if (relatedCase.Origin != 'Customer Portal') 
                        //system.debug('Case added/updated' + relatedcase.Id);  
                        updtCase.add(relatedcase);
                    }                   
                }
                for (Project_Piece__c relatedPiece:thesePieces)
                {
                    if(T.WhatId==relatedPiece.Id && (T.Type == 'Email' || T.Type == 'Call') && T.Subject.substring(0,3) != 'WFT')
                    {
                        Contact thisContact = new Contact();
                        SFDC_520_Quote__c thisProject = [select Id from SFDC_520_Quote__c where Id =: relatedPiece.Project__c limit 1];
                        if (T.WhoId != null) thisContact = [select Id, Full_Name__c from Contact where Id =: T.WhoId limit 1];
                        //else if (thisProject.Contact__c != null) thisContact = thisProject.Contact__c;                        
                        
                        Task newTask = T.clone(false, false);
                        
                        String taskWho;
                        if (thisContact != null) taskWho = thisContact.Full_Name__c;
                        
                        String taskSubject = newTask.Subject;
                        String taskComments = newTask.Description;
                        String taskPiece = relatedPiece.Name;
                        
                        newTask.WhatId = thisProject.Id;                        
                        newTask.Subject = taskSubject + ' ' + taskWho;
                        newTask.Description = newTask.Description + ' **Added to Project from ' + taskPiece;
                        newTask.WhoId = null;
                        thisProject.LastModifiedDate = system.today();
                        thisProject.LastModifiedById = userinfo.getuserid();
                        updatedProjects.add(thisProject);
                        projectTasks.add(newTask);
                    }   
                }               
            }
            if(projectTasks!=null)
            {
                try
                {
                    database.insert(projectTasks);
                }
                catch(Exception Ex)
                {
                    system.debug(Ex);
                }
            }
            if(updtCase!=null)
            { 
                try
                {
                    update updtCase;
                }
                catch(Exception Ex)
                {
                    system.debug(Ex);
                }
            }
            if(updtOpportunity != null)
            {
                try
                {
                    update updtOpportunity;
                }
                catch(Exception Ex)
                {
                    system.debug(Ex);
                }
            }
            
            
            
        }
    //======================================================UPDATE========================================
        if(trigger.isUpdate)
        {
            
            MAP<ID, Task> theseTasks = new MAP<ID, Task>();
            MAP<ID, SFDC_520_Quote__c> opptyIds = new MAP<ID, SFDC_520_Quote__c>();
            
            for(Task thisTask:Trigger.new)
            {
                theseTasks.put(thisTask.whatId,thisTask);
            }
            
            LIST<SFDC_520_Quote__c> theseProjects = new LIST<SFDC_520_Quote__c>();
            LIST<Opportunity> theseOpportunities = new LIST<Opportunity>();
            
            for(SFDC_520_Quote__c addProject: 
            [select Id, Date_Packet_Sent__c, Opportunity__c 
            from SFDC_520_Quote__c 
            where Id 
            IN: theseTasks.keySet()])
            {
                theseProjects.add(addProject);
                opptyIds.put(addProject.Opportunity__c, addProject);
            }
            
            for(Opportunity addOppty:
            [select Id, Packet_send_date__c 
            from Opportunity 
            where Id IN: opptyIds.keySet()])
            {
                theseOpportunities.add(addOppty);
            }
            
            
            LIST<Opportunity> updatedOpportunities = new LIST<Opportunity>();
            
            for(Task T:Trigger.new)
            {
                if (T.Subject != null)
                {
                    if(T.subject.contains('Send Packet')&&T.Status=='Completed')
                    {
                        SFDC_520_Quote__c project = new SFDC_520_Quote__c();
                        Opportunity opportunity = new Opportunity();                    
                        
                        for(SFDC_520_Quote__c thisProject:theseProjects)
                        {
                            if(thisproject.Id == T.WhatId)
                            {
                                thisProject.Date_Packet_Sent__c = system.today();
                                project = thisProject;                          
                                
                                for(Opportunity thisOpportunity: theseOpportunities)
                                {
                                    if(thisProject.Opportunity__c == thisOpportunity.Id)
                                    {
                                        thisOpportunity.Packet_send_date__c = system.now();
                                        opportunity = thisOpportunity;
                                    }
                                }
                            }                       
                        }
                        if(project!=null)updatedProjects.add(project);
                        if(opportunity!=null)updatedOpportunities.add(opportunity);
                    
                    }
                }
            }
            
            update updatedOpportunities;            
        }       
    }
    //10/06/2014: This commented line causes an exception : |FATAL_ERROR|System.ListException: Duplicate id in list: in vAutoOpportunity Tests
    //update updatedProjects;
    
    //Updated to use the set
    Set<SFDC_520_Quote__c> updatedProjectSet = new Set<SFDC_520_Quote__c>();
    updatedProjectSet.addAll(updatedProjects);
    if(updatedProjectSet.size()> 0){
        updatedProjects = new List<SFDC_520_Quote__c>(updatedProjectSet);
        update updatedProjects;
    }
    
}