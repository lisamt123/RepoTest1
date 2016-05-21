trigger VinCase on Case (before insert, before update, after update) {

            /*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('VinCase')){
    system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
    system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
    system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
    return;
}  

    //==============================BEFORE========================//

    if(trigger.isBefore) {
        List<Case> parentCases = new List<Case>();
        List<Case> childCases = new List<Case>();
        Map<Id, Schema.RecordTypeInfo> rtMap = Schema.SObjectType.Case.getRecordTypeInfosById();

        for(Case c : trigger.new)
        {
            if(c.RecordTypeId != null){
                String rtName = rtMap.get(c.RecordTypeId).getName();
                if(rtName.containsIgnoreCase('vAuto')){
                    c.Reason = c.vAuto_Case_Reason__c;
                    c.Product_Line__c = c.vAuto_Product_Line__c;
                }
            }
            if(c.ParentId != null){
                handler_caseTrigger.SetParentInfoOnChild(c);
                childCases.add(c);
            }
            else {          
                parentCases.add(c);
                if(trigger.isInsert){
                    c.Number_of_Child_Tickets__c = 0;
                }
            }
        }
        if(parentCases.size() > 0){
            WeightedRanking.triggerCalculateParentRanking(parentCases);
        }
        if(childCases.size() > 0){
            WeightedRanking.triggerCalculateChildRanking(childCases);
        }

        Set<Id> theseCases = new Set<Id>();
        for(Case thisCase:trigger.new){
            theseCases.add(thisCase.Id);
        }
        
        if(!theseCases.contains(null)){
            List<Task> theseTasks = [SELECT Id, whatId, subject, Created_Date_Time__c, CreatedDate, Description, 
                                        Type, Call_Value_Formula__c, Email_Value_Formula__c 
                                   FROM Task 
                                  WHERE WhatId IN :theseCases order by CreatedDate desc];
        
            // Get call and email values from the list of tasks on the case 
            // and then update the Last Activity with the most recent activity
            
            for(Case C: Trigger.new)
            {
                Datetime mostRecent;      
                
                for(Task tasks: theseTasks){    
                    if(tasks.WhatId==C.Id){   
                        if( ((tasks.Subject.length()>=3 && tasks.Subject.substring(0,3)=='O/G')
                            || (tasks.Subject.length()>=8 && tasks.Subject.substring(0,8)=='Email: 0')
                            || (tasks.Subject.length()>=13 && tasks.Subject.substring(0,13)=='Outgoing Call')
                            || (tasks.Subject.contains('[ ref:'))
                            || (tasks.Subject.length()>=21 && tasks.Subject.substring(0,21)=='Call/Customer Service'))
                            && ((tasks.CreatedDate > mostRecent)||(mostRecent==null))){               
                                Datetime createdDate = tasks.CreatedDate;
                                Date subCreatedDate = createdDate.date(); 
                                C.Last_Activity_Date__c = subCreatedDate;
                                system.debug('date set to: ' + subCreatedDate);
                                string lastActivity='No Description on Call';
                                if(tasks.Description !=null){
                                    lastActivity = tasks.Description;
                                }
                                if(tasks.Subject.length()>=8&&tasks.Subject.substring(0,8)=='Email: 0'){
                                    lastActivity='Email: '+tasks.Subject.substring(8,tasks.Subject.length());
                                }
                                if(lastActivity.length()>150){
                                    lastActivity = lastActivity.substring(0,150)+'...';
                                } 
                                if (C.First_Contact__c == null || C.First_Contact__c > createdDate){
                                    C.First_Contact__c = createdDate;
                                }

                                C.Last_Activity_Preview__c = lastActivity;
                                mostRecent = tasks.CreatedDate;
                        }
                        if (tasks.Subject.contains('Resolve Notice Sent to Customer')
                            || tasks.Subject.contains('Feature Request Notice to Contact Sent')){
                                Datetime createdDate = tasks.CreatedDate;                            
                                if (C.First_Contact__c == null
                                    || C.First_Contact__c > createdDate){
                                        C.First_Contact__c = createdDate;
                                }
                        }  
                    }
                }   
            }
        }

    }
        
    //==============================AFTER=========================//

    //Update the parent ticket when a new child ticket is attached.
    //specifically the Number of Child Tickets field on the Parent Record
    //it should always match the number of Related Tickets on the respective related list
    if(trigger.isAfter){
        Set<Id> ParentIDs = new Set<Id>();
        //checking to see if a child removed the parent, if so we want to update the parent also.
        if(!trigger.isInsert){
            for(Case oc : trigger.old){
                if(oc.ParentId != null){
                    ParentIDs.add(oc.ParentId);
                }
            }
        }

        for(Case lookingForParentId : trigger.new)
        {
            if(lookingForParentId.ParentId != null){
                ParentIDs.add(lookingForParentId.ParentId);
            }
            else if(lookingForParentId.Number_of_Child_Tickets__c > 0){
                handler_caseTrigger.SetChildInfoFromParentChange(lookingForParentId);  
            }
        }
        if(ParentIDs.size() > 0){
            handler_caseTrigger.calculateNumberOfChildTickets(ParentIDs);
        }
    }
    
}