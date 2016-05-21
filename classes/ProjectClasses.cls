public class ProjectClasses 
{
    public static void closeValidateTask(SFDC_520_Quote__c[] Proj) 
    {   
        for (SFDC_520_Quote__c p:Proj)
        {
            
 //=======================Start Packet Sent Complete Trigger===================================           
            if(p.Date_Packet_Sent__c!=null)
            {
              	/*LIST<Opportunity> O = new LIST<Opportunity>();
              	
              	for(Opportunity Oppt: [select Id, Welcome_Packet_Sent__c, Packet_returned_by_dealer__c from Opportunity where Id = :p.Opportunity__c])
              	{
              		if(Oppt.Welcome_Packet_Sent__c==null)
              		{
              			Oppt.Welcome_Packet_Sent__c=System.now();              			
              		}
              		O.add(Oppt);             		           		
              	}
              	update O;*/
              	              
                
                LIST<Task> Tsk = new LIST<Task>();
                
                for(Task T: [select Id, Status, Date_Time_Completed__c from Task where WhatId =:p.Id AND Subject = 'WFT-Intro Call/Intro Email/Send Packet' limit 1])
                {
                	T.Status='Completed';
                	T.Date_Time_Completed__c=System.Now();
                	Tsk.add(T);
                }
                update Tsk;
                
                
            }
            
            
            //===========================Start Search for Creative Project Pieces - Contact Made=================================           
            /*LIST <Project_Piece__c> CreativePP1 = new LIST <Project_Piece__c>();
            
            if(p.Date_Packet_Sent__c != null)
			{
				for(Project_Piece__c PrjP:[select Id, Contact_Made__c, 
				OwnerId, Requirements_Gathered__c, Design_Completed__c, 
				Proof_Approved__c, Uploaded_Printed_Shipped__c  
				from Project_Piece__c where RecordTypeId='012700000005e2z' 
				and Project__c =:P.Id and Project_Piece_Stage__c = 'Introduction'])
				{
					PrjP.Contact_Made__c = p.Date_Packet_Sent__c;
					CreativePP1.add(PrjP);
				}
				
				update CreativePP1;			
				
			}*/            
          
//========================================================PACKET RETURNED==========================================================       
        }
    }
    
    public static void PacketReturned(SFDC_520_Quote__c[] Proj) 
    {   
        for (SFDC_520_Quote__c p:Proj)
        {
            if(p.Date_Packet_Ret_d__c!=null)
            {
            	Opportunity parent;
            	
            	try {
        	 		
        	 		parent = [select Id, Packet_returned_by_dealer__c from Opportunity where Id = :p.Opportunity__c];
            	}
            	catch(Exception e) {
            		// do nothing
            	}
        	 	
        	 	if(parent != null) {
        	 	
	            	if(parent.Packet_returned_by_dealer__c==null)
	            	{
		   			 	parent.Packet_returned_by_dealer__c = system.now();
		       			update parent;
	            	}
        	 	}
            }
  
        }
    }
    
    public static void TrainingEndDateConfirmed (SFDC_520_Quote__c[] Projects)
    {
    	LIST<Task> theseTasksToInsert = new LIST<Task>();
    	
    	MAP<Id, String> theseProjectsMap = new MAP<Id, String>();
    	
    	for (SFDC_520_Quote__c Proj: Projects)
    	{
    		theseProjectsMap.put(Proj.Id, null);
    	}
    	
    	LIST<Task> allCurrentTasks = [select Id, WhatId, Subject from Task where WhatId IN: theseProjectsMap.keyset() and Subject =: 'Introduction Call'];
    	    	
    	for (SFDC_520_Quote__c Proj: Projects)
    	{    	
	    	boolean hasIntroTask = false;
	    	
	    	for (Task thisTask: allCurrentTasks)
	    	{
	    		if (thisTask.WhatId == Proj.Id)
	    		{
	    			hasIntroTask = true;
	    		}
	    	}
	    	
	    	if (!hasIntroTask)
    		{
		    	Task DATask = new Task();
				if (Proj.Account_Manager_ID__c != null) DATask.OwnerId = Proj.Account_Manager_ID__c;
				else DATask.OwnerId = userinfo.getuserId();
				DATask.WhatId = Proj.Id;
				DATask.Subject = 'Introduction Call';
				DATask.ActivityDate = Proj.Confirmed_Training_End__c - 1;
				DATask.Type = 'Call';
				DATask.Description =  'New Customer - Training Completed - Please introduce yourself and help the customer with support issues.';
				theseTasksToInsert.add(DATask);
    		}
    	}	
    	insert theseTasksToInsert;
    }
  
 //===========================Start Search for Creative Project Pieces - Requirement Gathering=================================           
 	public static void GraphicsObtained(SFDC_520_Quote__c p) 
    {             
		if(p.Date_Graphics_Obtained__c != null)
		{			
			/*LIST<Project_Piece__c> updatePieces = new LIST<Project_Piece__c>();
			LIST<Project_Piece__c> theseCreativePieces =
			[select Id, OwnerId, Contact_Made__c, Requirements_Gathered__c, Design_Completed__c, 
			Proof_Approved__c, Uploaded_Printed_Shipped__c  
			from Project_Piece__c 
			where RecordTypeId='012700000005e2z' 
			and Project__c =:P.Id 
			and Project_Piece_Stage__c = 'Requirement Gathering'];
		
			for(Project_Piece__c thisPiece:theseCreativePieces)
			{				
				if(thisPiece.Requirements_Gathered__c == null)
				{
					thisPiece.Requirements_Gathered__c = p.Date_Graphics_Obtained__c;
										
					updatePieces.add(thisPiece);
		
				}
			}
			update updatePieces;*/
		}        
    }
    @future
    public static void updateImplementationDate(String AccountId)
    {
    	if (AccountId != null) 
    	{
    		Account thisAccount = [select Id, Implementation_Date__c from Account where Id =: AccountId limit 1];
	    	if (thisAccount != null)
	    	{
		    	if (thisAccount.Implementation_Date__c == null)
		    	{ 
		    		thisAccount.Implementation_Date__c = system.today();
		    		update thisAccount;
		    	}
	    	}
    	}
    }















 //====================================================================================================                       
        
   
    
    public static void updateCancelledProjectPieces(SFDC_520_Quote__c proj)
    {
    	LIST<Project_Piece__c> thesePieces = [select Id, Project__c from Project_Piece__c where Project__c =: proj.Id];
    	for (Project_Piece__c thisPiece: thesePieces)
    	{
    		thisPiece.Project_Piece_Stage__c = 'Cancelled';
    	}
    	//update thesePieces;
    }
    
    
}