public class EventClass 
{
   public static boolean firstRun = true;
   /* November 3, 2014 Commented out for code coverage. Found all calls to this method were commented out in the trigger.
    public static  void PopulateOpptyWebexCount(Event evnt, Opportunity[] opps, Event[] siblingEvents){
        
        string sub;
        double numEvents;
        if(evnt.Subject != null){
            sub = evnt.Subject.toLowerCase();
            if(sub.contains('web ex') || sub.contains('webex') || sub.contains('wx') || sub.contains('haystak demo')){
                if(evnt.Webex_Status__c == 'Completed'){
                    numEvents = 1;
                }
                else if(evnt.Webex_Status__c != 'Completed'){
                    numEvents = 0;
                }
            }
            
            list<Opportunity> oppsToUpdate = new list<Opportunity>();
            
            for(Opportunity o : opps){
                o.Number_Of_Webex_Events__c = o.Number_Of_Webex_Events__c + numEvents;
                
                oppsToUpdate.add(o);
            }
            update oppsToUpdate;
        }
    }*/
    
    public static void addEventSubject(Event e, SFDC_520_Quote__c[] proj)
    {   string sub; 
        if(e.Subject != null){
            sub = e.Subject.toLowerCase();
        
            if (sub.contains('web ex')||sub.contains('webex')||sub.contains('wx')) {
                
                if(sub.contains('meeting')!= TRUE){
                     
                    string subjecta = 'WebEx - '+e.Salesperson__c+' - '+e.WebEx_Topic__c+' - '+e.Webex_Status__c + ' - ' + system.now().format();
                    integer subjectlength = subjecta.length();                  
                    if(subjectlength>=81){              
                        integer nonsub = subjecta.length()-e.WebEx_Topic__c.length();
                        integer lmt = 80 - nonsub;
                        string webextopic= e.WebEx_Topic__c.substring(0,lmt);
                        string subjectb = 'WebEx - '+e.Salesperson__c+' - '+webextopic+' - '+e.Webex_Status__c + ' - ' + system.now().format();
                        e.Subject = subjectb;
                    }
                    else{
                        e.Subject = subjecta;
                    }
                }                            
            }
            else if(sub.contains('haystak demo')){
                    string subjectahs = 'Haystak Demo -' + e.Salesperson__c + ' - ' + e.Webex_Topic__c + ' - ' + e.Webex_Status__c + ' - ' + system.now().format();
                    integer subjectLengthHS = subjectahs.length();
                    if(subjectLengthHS >= 81){
                        integer nonsub2 = subjectahs.length() - e.WebEx_Topic__c.length();
                        integer lmt1 = 80 - nonsub2;
                        string webextopic2 = e.WebEx_Topic__c.substring(0, lmt1);
                        string subjectbHS = 'Haystak Demo - '+e.Salesperson__c+' - '+webextopic2+' - '+e.Webex_Status__c + ' - ' + system.now().format();
                        e.Subject = subjectbHS;
                    }
                    else{
                        e.Subject = subjectahs;
                    }
            }
                        
            string whatType = e.WhatId;
            
            if(sub.contains('onsite')&& e.WhatId!=null && whatType.startsWith('a0Y'))
            {   
                for(SFDC_520_Quote__c project:proj)
                {
                    if(project.Id == e.WhatId)
                    {
                        if(e.WebEx_Topic__c!=null) project.Products_to_be_discussed__c = e.WebEx_Topic__c;
                        if(e.WebEx_With__c!=null) project.Who_will_be_attending__c =  e.WebEx_With__c;
                        if(e.WebEx_Topic__c!=null || e.WebEx_Topic__c!=null) update project;
                    }
                }
            }
        }
    }
    public static void addSalesPerson(Event e, string sPersonName, string sPersonRole)
    {   
        string sub;
          
        if(e.Subject != null){
            sub = e.Subject.toLowerCase();
            if (sub.contains('web ex')||sub.contains('webex')||sub.contains('wx')) 
            {
                if(sub.contains('meeting')!= TRUE)
                { 
            
                    string SalespersonName;
                            
                    if(e.Exception_Salesperson__c != null)
                    {
                        SalespersonName = e.Exception_Salesperson__c;
                    }
                    if(e.Exception_Salesperson__c == null)
                    {                   
                        SalespersonName = sPersonName;
                    }
                    e.Created_By_Role__c = sPersonRole;                 
                }
            }       
        }
    }
    /*public static void CreateDemos(Event e)
    {
        LIST<Demo__c> newDemo = new LIST<Demo__c>();
        
        string sub = e.Subject.toLowerCase();
                
        if (sub.contains('web ex')||sub.contains('webex')||sub.contains('wx')) 
        {
            if(e.WhatId!=null && sub.contains('completed'))
            {
                string relatedTo = e.WhatId;
                string shortRelatedTo = relatedTo.substring(0,3);                   
                        
                if(sub.contains('meeting')!= TRUE && shortRelatedTo == '006' )
                {
                    Demo__c D = new Demo__c();
                    D.Name = 'WebEx'+' - '+e.StartDateTime;
                    D.Webex_Event_ID__c = e.Id;
                    D.Webexer__c = e.OwnerId;
                    D.Opportunity__c = e.WhatId;   
                        
                    newDemo.add(D);                     
                }
            }
        }           
        insert newDemo;                 
    }   */  
    
}