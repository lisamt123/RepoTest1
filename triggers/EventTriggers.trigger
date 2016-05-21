trigger EventTriggers on Event (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) 
{

/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('EventTriggers')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}
//==========================BEFORE====================================================================
    if(Trigger.isBefore)
    {
        if(Trigger.isUpdate||Trigger.isInsert)
        {       
            //Query Event/Project information for addEventSubject
            MAP<Id, Event> theseEvents = new MAP<Id, Event>();          
            MAP<Id, Event> theseCreators = new MAP<Id, Event>();
            LIST<SFDC_520_Quote__c> theseProjects = new LIST<SFDC_520_Quote__c>();
            LIST<User> theseUsers = new LIST<USer>();
            
            //Create Maps for Related to and CreatedBy on Events being edited                       
            for(Event E:Trigger.new)
            {
                theseEvents.put(E.WhatId, E);
                theseCreators.put(E.CreatedById, E);
            }
            
            //Query User/Role info for addSalesPerson           
            for(User Us: [select Id, User.Name, UserRole.Name from User where Id IN: theseCreators.keySet()])
            {               
                theseUsers.add(Us); 
            }
                        
                        
            for(SFDC_520_Quote__c addProject: 
            [select id, Products_to_be_discussed__c,Who_will_be_attending__c 
            from SFDC_520_Quote__c 
            where id IN :theseEvents.keySet()])
            {
                theseProjects.add(addProject);
            }
            
            for(Event E:Trigger.new) 
            {
                string salesPersonName;
                string salesPersonRole;
                
                for(User salesPerson:theseUsers)
                {
                    if(e.CreatedById==salesPerson.Id)
                    {
                        salesPersonName = salesPerson.Name;
                        salesPersonRole = salesPerson.UserRole.Name;    
                    }
                }
                
                EventClass.addEventSubject(E, theseProjects);
                EventClass.addSalesPerson(E, salesPersonName, salesPersonRole);
                
            }
        }
        
    }
//++++++++++++++++++++++++++++++++++++++++++++++AFTER++++++++++++++++++++++++++++++++++++++++++++++++++++++
    if(Trigger.isAfter)
    {
        MAP<Id, Event> theseEvents = new MAP<Id, Event>();
        LIST<Opportunity> theseOpportunities = new LIST<Opportunity>();
        LIST<Event> evntSibs = new LIST<Event>();
        
        if(Trigger.isInsert||Trigger.isUnDelete||Trigger.isUpdate)
        {   
            for(Event E:Trigger.new)
            {
                theseEvents.put(E.WhatId, E);
            }           
            
            for(Opportunity O: 
            [select id, Opportunity_Names__c, StageName, Number_Of_Webex_Events__c, isClosed 
            from Opportunity 
            where Id IN:theseEvents.keySet()])
            {
                theseOpportunities.add(O);
            }
            
            for(Event sibs: [
            select id, subject, webexer_rating__c, regional_rating__c, whatId 
            from Event 
            where whatId IN: theseEvents.keySet() 
            and subject Like 'WebEx%'])
            {
                evntSibs.add(sibs);
            }
    //===========================================INSERT===================================================
        
            if(Trigger.isInsert){
                
                for(Event E:Trigger.new){ 
                                  
                    //EventClass.PopulateOpptyWebexCount(E, theseOpportunities, evntSibs);                
                    boolean isClosedWon = false;
                    string sub;// = E.Subject.toLowerCase();
                    if(E.Subject != null){
                        sub = E.Subject.toLowerCase();           
                        if (sub.contains('web ex') ||sub.contains('webex') ||sub.contains('wx')) {
                            
                            if(E.WhatId!=null){
                                
                                string relatedTo = E.WhatId;
                                string shortRelatedTo = relatedTo.substring(0,3);
                                if(shortRelatedTo == '006'){
                                    
                                    Opportunity relatedOpp = [select Id, StageName from Opportunity where Id =: relatedTo];                             
                                    if (relatedOpp.StageName == 'Closed or Won') isClosedWon = true;
                                                                                            
                                    /*if(sub.contains('meeting')!= TRUE && shortRelatedTo == '006' && !isClosedWon){ 
                                        EventClass.CreateDemos(E);
                                    }
                                    else if (sub.contains('meeting')!= TRUE && shortRelatedTo == '006' && isClosedWon){
                                        E.addError('Cannot add a WebEx event to a Closed/Won opportunity');
                                    } */
                                }
                            }
                        }
                    }                  
                }
            }
        //===========================================UNDELETE===================================================
            if(Trigger.isUnDelete)
            {           
                for(Event E:Trigger.new)
                {   
                    //EventClass.PopulateOpptyWebexCount(E, theseOpportunities, evntSibs);                
                }
            }
        
        //=======================================================UPDATE========================================
            if(Trigger.isUpdate)
            {               
                boolean changeOwner=false;
                for(Event pE:trigger.new)
                {
                    //for(Event pOE:trigger.old)
                    //{
                        Event pOE = trigger.oldMap.get(pE.Id);
                        if(pE.OwnerId!=pOE.OwnerId) changeOwner=true;                       
                    //}
                }
                
                MAP<ID, Event> allTheseEvents = new MAP<ID, Event>();
                for(Event E:Trigger.new)
                {
                    allTheseEvents.put(E.Id, E);
                }
                
                  
            
                
                
                /*Ramana 05/14/2014*/
                /*START HANDLING WEBEX EVENTS TO UPDATE OPPRTUNITES*/                
                /*Updated to add changing the opportunity webex field details when the event is a webex event*/
                
                //collect the related Opportunites
                Map<Id,Opportunity> eventOpportunities = new Map<Id,Opportunity>();       
                List<Opportunity> eventOpportunitiesToUpdate = new List<Opportunity>();     
                List<Id> eventWhatIds = new List<Id>();
                for(Event ED:Trigger.new)
                {                   
                    eventWhatIds.add(ED.WhatId);
                }
                
                //get opportunites
                for(Opportunity opp: [select id, Initial_Webex_Completed__c, Last_Completed_Webex_Date__c, Number_Of_Webex_Events__c, StageName from Opportunity where Id IN:eventWhatIds ]){
                    eventOpportunities.put(opp.id, opp);
                }
                
                for(Event E:Trigger.new)
                {
                    double numEvents;
                    //if it is a webex event and it is completed
                    if(E.Subject != null){
                        if(
                        (E.Subject.toLowerCase().startsWith('webex') || E.Subject.toLowerCase().startsWith('haystak demo')  || E.Subject.toLowerCase().startsWith('vauto demo') )
                        && E.Webex_Status__c=='Completed'){
                            //get the last saved version
                            Event OE = trigger.oldMap.get(E.Id);
                            //check if the status is just changed to Complete from something else
                            if(E.Webex_Status__c=='Completed'&&OE.Webex_Status__c!='Completed'){
                                
                            
                               //Get the Opportunity related to the event
                               if(eventOpportunities.containsKey(E.WhatId)){
                                Opportunity opp = eventOpportunities.get(E.WhatId);
                                if(EventClass.firstRun){ 
                                    if(opp.Number_Of_Webex_Events__c == null){
                                        opp.Number_Of_Webex_Events__c =0;
                                    }                          
                                    opp.Number_Of_Webex_Events__c ++;
                                EventClass.firstRun = false;
                                }
                                //Only if the Opportunity state is Prospect
                                if(opp.StageName  == 'Prospect'){
                                   
                                      opp.StageName = 'Webex Complete';                               
                                }
                                //Only update the Initial_Webex_Completed__c  if it is not set
                                if(opp.Initial_Webex_Completed__c == null){
                                       opp.Initial_Webex_Completed__c = date.newinstance(E.StartDateTime.year(), E.StartDateTime.month(), E.StartDateTime.day());
                                       
                                   }
                                //Always reset the Last_Completed_Webex_Date__c
                                opp.Last_Completed_Webex_Date__c =  date.newinstance(E.StartDateTime.year(), E.StartDateTime.month(), E.StartDateTime.day());
                                
                                //Add Opportunity to the update list
                                eventOpportunitiesToUpdate.add(opp);
                                
                               }
                               
                            }
                        }
                    }
                }
                
                //Update Opportunites
                if(eventOpportunitiesToUpdate.size() > 0){
                    update eventOpportunitiesToUpdate;
                }
                //EventClass.PopulateOpptyWebexCount(E, theseOpportunities, evntSibs);
                /*END HANDLING WEBEX EVENTS TO UPDATE OPPRTUNITES*/
                
                
                /*LIST<Demo__c> theseDemos = new LIST<Demo__c>();
                if(changeOwner==true)
                {
                    theseDemos = [select Id, Webex_Event_ID__c, Webexer__c 
                    from Demo__c
                    where Webex_Event_ID__c IN: allTheseEvents.keySet()];
                }
                                        
                //The following will update information on Webex Events
                for(Event E: Trigger.new)
                {
                    //for(Event OE: Trigger.old)
                    //{ 
                                            
                    Event OE = trigger.oldMap.get(E.Id);    
                    for(Demo__c thisDemo:theseDemos)
                    {
                        if(E.Id==thisDemo.Webex_Event_ID__c&&changeOwner==true)
                        {
                            thisDemo.Webexer__c = E.OwnerId;
                        }
                    }
                    
                    string sub = E.Subject.toLowerCase();
                      
                    if (sub.contains('web ex')||sub.contains('webex')||sub.contains('wx')) 
                    {
                        if(E.WhatId!=null)
                        {
                            string relatedTo = E.WhatId;
                            string shortRelatedTo = relatedTo.substring(0,3);
                          
                            string oldShortRelatedTo = '';
                            if(OE.WhatId!=null)
                            {
                                string oldRelatedTo = OE.WhatId;
                                oldShortRelatedTo = oldRelatedTo.substring(0,3);
                            }
                                
                            if(sub.contains('meeting')!= TRUE && shortRelatedTo == '006' && oldShortRelatedTo != '006')
                            {  
                                EventClass.CreateDemos(E);
                            }
                            if(sub.contains('meeting')!= TRUE && shortRelatedTo == '006' && E.Webex_Status__c == 'Completed' && OE.Webex_Status__c != 'Completed')
                            {
                                if ((E.WebEx_Level__c == 'Initial' || E.WebEx_Level__c == 'Initial Upgrade') && E.Intital_WebEx_Completed__c == null)
                                {
                                    EventClass.CreateDemos(E);
                                }
                                else if(E.WebEx_Level__c != 'Initial' && E.WebEx_Level__c != 'Initial Upgrade' && E.Intital_WebEx_Completed__c == null)
                                {   
                                    EventClass.CreateDemos(E);
                                } 
                            }
                            
                            if(sub.contains('meeting')!= TRUE && shortRelatedTo == '006'&& E.Webex_Status__c=='Completed'&&OE.Webex_Status__c!='Completed')
                            {   
                                for(Opportunity O: theseOpportunities) 
                                {
                                    if(E.WebEx_Level__c == 'Initial'&&O.Id==E.WhatId&&E.WebEx_Topic__c!=null && !O.isClosed) 
                                    {
                                        O.StageName = 'Webex Complete';
                                        O.Initial_Webex_Completed__c = system.today();
                                        
                                        string opptyType;
                                        double opptyAmnt;
                                        if(E.WebEx_Topic__c.contains('Nickel Pro'))
                                        {
                                            opptyType = 'Nickel Pro Solution';
                                            opptyAmnt = 1298.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('Nickel Plus'))
                                        {
                                          opptyType = 'Nickel Plus Solution';
                                          opptyAmnt = 1298.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('Bronze'))
                                        {
                                          opptyType = 'Bronze Solution';
                                          opptyAmnt = 2198.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('Silver'))
                                        {
                                          opptyType = 'Silver Solution';
                                          opptyAmnt = 3198.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('Gold'))
                                        {
                                          opptyType = 'Gold Solution';
                                          opptyAmnt = 6498.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('Platinum'))
                                        {
                                            opptyType = 'Platinum Solution';
                                            opptyAmnt = 7998.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('DIY'))
                                        {
                                            opptyType = 'DIY';
                                            opptyAmnt = 1298.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('ILM'))
                                        {
                                            opptyType = 'ILM';
                                            opptyAmnt = 3198.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('Website'))
                                        {
                                            opptyType = 'Website';
                                            opptyAmnt = 3198.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('CRM'))
                                        {
                                            opptyType = 'CRM';
                                            opptyAmnt = 3198.00;
                                        }
                                        if(E.WebEx_Topic__c.contains('Diamond'))
                                        {
                                            opptyType = 'Diamond';
                                            opptyAmnt = 17998.00;
                                        }
                                        if (opptyType != null) O.Opportunity_Names__c = opptyType;
                                        O.Amount = opptyAmnt;
                                    }
                                    if(E.WebEx_Level__c == 'Second')O.StageName = 'Second WX Complete';
                                    if(E.Webex_Level__c == 'Third') O.StageName = 'Third WX';                                       
                                }                                   
                            }
                            EventClass.PopulateOpptyWebexCount(E, theseOpportunities, evntSibs);
                        }
                    }
                    //}
                }
                update theseDemos;*/ 
            }           
        }
    //===========================================DELETE===================================================
        if(Trigger.isDelete)
        {
            MAP<Id, Event> theseEventsD = new MAP<Id, Event>();
            LIST<Opportunity> theseOpportunitiesD = new LIST<Opportunity>();
            LIST<Event> evntSibsD = new LIST<Event>();
            
            for(Event ED:Trigger.old)
            {
                theseEventsD.put(ED.WhatId, ED);
            }           
            
            for(Opportunity OD: [select id, Number_Of_Webex_Events__c from Opportunity where Id IN:theseEventsD.keySet()])
            {
                theseOpportunitiesD.add(OD);
            }
            
            for(Event sibsD: [select id, webexer_rating__c, regional_rating__c, whatId, Subject from Event where whatId IN: theseEventsD.keySet() and (subject Like 'WebEx%')])
            {
                evntSibsD.add(sibsD);
            }
            
            for(Event OE: Trigger.old)
            {  
                //EventClass.PopulateOpptyWebexCount(OE, theseOpportunitiesD, evntSibsD);
            }
        }
    }
}