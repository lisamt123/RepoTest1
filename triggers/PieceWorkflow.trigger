trigger PieceWorkflow on Project_Piece__c (before update) 
{
    /*
//Find the User Offices
    string TM;
    string TF;
    string TA;
    string PS;
    string PSemail;
    string PSname;
    string Clk;
    string Clkemail;
    string VCA; 
            
    for(User U :[SELECT Id, VinCamera_Assets__c, FirstName, LastName,Email, Manager_of_Training__c,In_charge_of_Printing_Shipping__c,
        Travel_Financer__c,Travel_Arranger__c, Click_to_Chat_Specialist__c from User where Manager_of_Training__c=True 
        OR Travel_Financer__c=True OR Travel_Arranger__c=True OR In_charge_of_Printing_Shipping__c=True 
        OR Click_to_Chat_Specialist__c=True OR VinCamera_Assets__c=True])
    {
        if(U.Manager_of_Training__c==TRUE)
        {
            TM = U.id;
        }
        if(U.Travel_Arranger__c==TRUE)
        {
            TA = U.id;
        }
        if(U.Travel_Financer__c==TRUE)
        {
            TF = U.id;
        }
        if(U.In_charge_of_Printing_Shipping__c==TRUE)
        {
            PS = U.id;
            PSname = U.FirstName+' '+U.LastName;
            PSemail= U.email;
        }
        if(U.Click_to_Chat_Specialist__c==TRUE)
        {
            Clk = U.id;
            Clkemail= U.email;
        }
        if(U.VinCamera_Assets__c==TRUE)
        {
            VCA = U.id;             
        }
    }
    
    MAP<Id, Project_Piece__c> thesePieceProjects = new MAP<Id, Project_Piece__c>();
    MAP<Id, Project_Piece__c> thesePieceTasks = new MAP<Id, Project_Piece__c>();    
    
    for(Project_Piece__c thisPiece: Trigger.new)
    {
        thesePieceProjects.put(thisPiece.Project__c, thisPiece);    
        thesePieceTasks.put(thisPiece.Id, thisPiece);   
    }
    
    LIST<SFDC_520_Quote__c> theseProjects = 
    [select Id, name, Approval_Stage__c, Project_Type__c 
    from SFDC_520_Quote__c 
    where Id IN : thesePieceProjects.keySet()];
    
    LIST<Task> allRelatedOpenTasks = 
    [select id, Date_Time_Completed__c, WhatId, Status 
    from Task 
    where WhatId IN:thesePieceTasks.keySet() and Status!='Completed'];
        
    
    for(Project_Piece__c P: Trigger.new)
    {
        Project_Piece__c O = trigger.oldMap.get(P.Id);          
        SFDC_520_Quote__c currentProject = new SFDC_520_Quote__c();
        LIST<Task> currentOpenTasks = new LIST<Task>();
        
        for(SFDC_520_Quote__c thisProject: theseProjects)
        {
            if(thisProject.Id==P.Project__c)
            {
                currentProject = thisProject;
            }
        }
        for(Task thisTask: allRelatedOpenTasks)
        {
            if(thisTask.WhatId==P.Id)
            {
                currentOpenTasks.add(thisTask);
            }   
        }       
        
        if(P.OwnerId==O.OwnerId)
        {
            /*if(P.RecordTypeId=='012700000005e2z')//Creative
            {
                
                ProjectPiecesWorkflow.runCreative(P, O, TM, TF,TA, PS, PSemail, Clk, Clkemail, currentOpenTasks, currentProject);
                
            }*/
            /*if(P.RecordTypeId=='012700000005e3J')//DDM
            {               
                ProjectPiecesWorkflow.runDDM(P, O, currentOpenTasks, currentProject);
            } *//*
            if(P.RecordTypeId=='012700000005e2u')//Default Issues
            {
                //ProjectPiecesWorkflow.runDefaultIssues(P, O, TM, TF,TA, PS, PSemail, Clk, Clkemail, currentOpenTasks, currentProject);
            }
            /*if(P.RecordTypeId=='012700000005e34')//Implementation Standard
            { 
                ProjectPiecesWorkflow.runImplementationStandard(P, O, currentOpenTasks, currentProject); 
            } */
            /*if(P.RecordTypeId=='012700000005eOy')//Implementation Click to Chat
            {
                ProjectPiecesWorkflow.runImplementationClicktoChat(P, O, TM, TF,TA, PS, PSemail, Clk, Clkemail, currentOpenTasks, currentProject);
            } */
            /*if(P.RecordTypeId=='012700000005eOt')//Implementation Hardware
            {
                ProjectPiecesWorkflow.runImplementationHardware(P, O, TM, TF,TA, PS, PSname, PSemail, Clk, Clkemail,VCA, currentOpenTasks, currentProject);
            }*/
            /*if(P.RecordTypeId=='01270000000Q3VI')//Implementation - VinVideos
            {
                ProjectPiecesWorkflow.runImplementationVinVideos(P, O, currentOpenTasks, currentProject);
            } */
            /*if(P.RecordTypeId=='012700000005e3E')//Shipping
            {
                ProjectPiecesWorkflow.runShipping(P, O, TM, TF,TA, PS, PSemail, Clk, Clkemail, currentOpenTasks, currentProject);
            } */
            /*if(P.RecordTypeId=='012700000005euh')//HardwareShipped
            {
                ProjectPiecesWorkflow.runHardwareShipped(P, O, currentOpenTasks, currentProject);
            }*/  
            /*if(P.RecordTypeId=='012700000005e3O')//Integration
            {
                ProjectPiecesWorkflow.runIntegration(P, O, currentOpenTasks, currentProject);
            } */
            /*if(P.RecordTypeId=='012700000005e3T')//Support
            {
                ProjectPiecesWorkflow.runSupport(P, O, currentOpenTasks, currentProject);
            } */
            /*if(P.RecordTypeId=='012700000005ejj')//Support - Custom Form Design
            {
                ProjectPiecesWorkflow.runSupportCustomFormDesign(P, O, TM, TF,TA, PS, PSemail, Clk, Clkemail, currentOpenTasks, currentProject);
            } */
            /*if(P.RecordTypeId=='01270000000Q3eo')//700 Credit
            {
                ProjectPiecesWorkflow.SevenHundredCredit(P, O, currentOpenTasks, currentProject);
            } */
            /*if(P.RecordTypeId=='01270000000Q3hd')//AIS Rebates
            {
                ProjectPiecesWorkflow.AISRebates(P, O, currentOpenTasks, currentProject);
            } */
            /*if(P.RecordTypeId=='01270000000Q3rn')//Craigslist Manual
            {
                PieceWorkflow2.runCraigslistManual(P, O, currentOpenTasks, currentProject); 
            }*/
            /*if(P.RecordTypeId=='01270000000Q3rh')//Desking Module
            {
                PieceWorkflow2.runDeskingModule(P, O, currentOpenTasks, currentProject);
            }*/
            /*if(P.RecordTypeId=='01270000000Q3rm')//Inventory Gallery
            {
                PieceWorkflow2.runInventoryGallery(P, O, currentOpenTasks, currentProject);
            }*/
            /*if(P.RecordTypeId=='01270000000Q3rv')//Inventory Module
            {
                PieceWorkflow2.runInventoryModule(P, O, currentOpenTasks, currentProject);
            }*/
            /*if(P.RecordTypeId=='01270000000Q3rg')//KnowMe
            {
                PieceWorkflow2.runKnowMe(P, O, currentOpenTasks, currentProject);
            }*/
            /*if(P.RecordTypeId=='01270000000Q3rw')//Market Pricing Tool
            {
                PieceWorkflow2.runMarketPricingTool(P, O, currentOpenTasks, currentProject);
            }*/     
            /*if(P.RecordTypeId=='01270000000Q3rl')//Training (WebEx) & Internet
            {
                PieceWorkflow2.runTrainingWebex(P, O, currentOpenTasks, currentProject);
            }*/ 
            /*      
            
    //END PRODUCT SPECIFIC PROCESSES LIST   
         
            ProjectPiecesWorkflow.runWorkflowRules(P, O, currentOpenTasks, currentProject);//Universal Workflow
        }
    }
    */
}