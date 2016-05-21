Public class ProjectPieceProcess
{
    Public Static LIST<Task> generateTasks(Project_Piece__c PP, Project_Piece__c oPP,
    Task[] newTasks,Product_Process__c productProcesses, Product_Process_Task__c[] productProcessTasks,
    Account TS, Messaging.Singleemailmessage[] emails)
    {	
//==========================================================================================================================      
        //Check to see if the Stage has been set to "Completed" for quick complete and updates the Date Stage Updated Field to system.today()
        if(oPP.Project_Piece_Stage__c!='Completed'&&PP.Project_Piece_Stage__c=='Completed')
        {
        	if(PP.Number_of_Milestones__c==10&&PP.Milestone_10_Completed__c==null)
        	{
        		PP.Milestone_10_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	if(PP.Number_of_Milestones__c==9&&PP.Milestone_9_Completed__c==null)
        	{
        		PP.Milestone_9_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}        	
        	if(PP.Number_of_Milestones__c==8&&PP.Milestone_8_Completed__c==null)
        	{
        		PP.Milestone_8_Completed__c=system.today();
				PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}    	
        	if(PP.Number_of_Milestones__c==7&&PP.Milestone_7_Completed__c==null)
        	{
        		PP.Milestone_7_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	if(PP.Number_of_Milestones__c==6&&PP.Milestone_6_Completed__c==null)
        	{
        		PP.Milestone_6_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	if(PP.Number_of_Milestones__c==5&&PP.Milestone_5_Completed__c==null)
        	{
        		PP.Milestone_5_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	if(PP.Number_of_Milestones__c==4&&PP.Milestone_4_Completed__c==null)
        	{
        		PP.Milestone_4_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	
        	if(PP.Number_of_Milestones__c==3&&PP.Milestone_3_Completed__c==null)
        	{
        		PP.Milestone_3_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	if(PP.Number_of_Milestones__c==2&&PP.Milestone_2_Completed__c==null)
        	{
        		PP.Milestone_2_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	if(PP.Number_of_Milestones__c==1&&PP.Milestone_1_Completed__c==null)
        	{
        		PP.Milestone_1_Completed__c=system.today();
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	if(PP.Start_Process__c==null)PP.Start_Process__c=system.today();        	
       }
//============================================================================================================================     
        //This section checks to see how far the user has possibly skipped 
        //ahead in the process and fills in the gaps between where they last 
        //left off and where they are now...creating open & completed tasks accoridingly    
        
        integer processDistance = 0;
        
        if(PP.Milestone_10_Completed__c!=null)
        {
        	/*if(PP.Milestone_9_Completed__c==null)
        	PP.Milestone_9_Completed__c = system.today();*/        	
        	processDistance += 1;
        }
        if(PP.Milestone_9_Completed__c!=null) 
        {
        	/*if(PP.Milestone_8_Completed__c==null)
        	PP.Milestone_8_Completed__c = system.today();*/        	
        	processDistance += 1;
        }
        if(PP.Milestone_8_Completed__c!=null) 
        {
        	/*if(PP.Milestone_7_Completed__c==null)
        	PP.Milestone_7_Completed__c = system.today();*/        	
        	processDistance += 1;
        }
        if(PP.Milestone_7_Completed__c!=null) 
        {
        	/*if(PP.Milestone_6_Completed__c==null)
        	PP.Milestone_6_Completed__c = system.today();*/
        	processDistance += 1;
        }
        if(PP.Milestone_6_Completed__c!=null)
        {
        	/*if(PP.Milestone_5_Completed__c==null)
        	PP.Milestone_5_Completed__c = system.today();*/
        	processDistance += 1;
        }
        if(PP.Milestone_5_Completed__c!=null)
        {
        	/*if(PP.Milestone_4_Completed__c==null)
        	PP.Milestone_4_Completed__c = system.today();*/
        	processDistance += 1;
        }
        if(PP.Milestone_4_Completed__c!=null) 
        {
        	/*if(PP.Milestone_3_Completed__c==null)
        	PP.Milestone_3_Completed__c = system.today();*/
        	processDistance += 1;
        }
        if(PP.Milestone_3_Completed__c!=null) 
        {
        	/*if(PP.Milestone_2_Completed__c==null)
        	PP.Milestone_2_Completed__c = system.today();*/
        	processDistance += 1;
        }
        if(PP.Milestone_2_Completed__c!=null) 
        {
        	/*if(PP.Milestone_1_Completed__c==null)
        	PP.Milestone_1_Completed__c = system.today();*/
        	processDistance += 1;
        }
        if(PP.Milestone_1_Completed__c!=null) 
        {
        	/*if(PP.Start_Process__c==null)
        	PP.Start_Process__c = system.today();*/
        	processDistance += 1;
        }        

//=============================================================================================================================
        //Set the project piece stage - determine if the project piece is complete based on Number of Milestones on the Process     
        if(processDistance==10)
        {
        	if(PP.Number_of_Milestones__c==10) 
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();	
        	}
        	        	
        }
        else if(processDistance==9)
        {
        	if(PP.Number_of_Milestones__c==9) 
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_10_Stage__c;
        		if(PP.Milestone_10_Owner__c!=null)PP.OwnerId = PP.Milestone_10_Owner__c;
        		if(PP.Milestone_10_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_10_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_10_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_10_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_10_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_10_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_10_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        }
        else if(processDistance==8)
        {
        	if(PP.Number_of_Milestones__c==8) 
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_9_Stage__c;
        		if(PP.Milestone_9_Owner__c!=null)PP.OwnerId = PP.Milestone_9_Owner__c;
        		if(PP.Milestone_9_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_9_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_9_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_9_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_9_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_9_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_9_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        }
        else if(processDistance==7)
        {
        	if(PP.Number_of_Milestones__c==7)
			{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_8_Stage__c;
        		if(PP.Milestone_8_Owner__c!=null)PP.OwnerId = PP.Milestone_8_Owner__c;
        		if(PP.Milestone_8_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_8_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_8_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_8_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_8_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_8_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_8_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        }
        else if(processDistance==6)
        {
        	if(PP.Number_of_Milestones__c==6) 
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_7_Stage__c;
        		if(PP.Milestone_7_Owner__c!=null)PP.OwnerId = PP.Milestone_7_Owner__c;
        		if(PP.Milestone_7_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_7_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_7_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_7_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_7_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_7_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_7_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        }
        else if(processDistance==5)
        {
        	if(PP.Number_of_Milestones__c==5) 
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_6_Stage__c;
        		if(PP.Milestone_6_Owner__c!=null)PP.OwnerId = PP.Milestone_6_Owner__c;
        		if(PP.Milestone_6_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_6_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_6_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_6_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_6_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_6_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_6_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        }
        else if(processDistance==4)
        {
        	if(PP.Number_of_Milestones__c==4) 
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_5_Stage__c;
        		if(PP.Milestone_5_Owner__c!=null)PP.OwnerId = PP.Milestone_5_Owner__c;
        		if(PP.Milestone_5_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_5_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_5_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_5_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_5_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_5_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_5_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        }
        else if(processDistance==3)
        {
        	if(PP.Number_of_Milestones__c==3) 
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_4_Stage__c;
        		if(PP.Milestone_4_Owner__c!=null)PP.OwnerId = PP.Milestone_4_Owner__c;
        		if(PP.Milestone_4_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_4_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_4_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_4_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_4_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_4_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_4_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        }
        else if(processDistance==2)
        {
        	if(PP.Number_of_Milestones__c==2) 
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_3_Stage__c;
        		if(PP.Milestone_3_Owner__c!=null)PP.OwnerId = PP.Milestone_3_Owner__c;
        		if(PP.Milestone_3_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_3_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_3_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_3_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_3_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_3_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_3_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        }
        else if(processDistance==1)
        {
        	if(PP.Number_of_Milestones__c==1)
        	{
        		PP.project_piece_stage__c = 'Completed';
        		PP.Date_Stage_Updated_to_Completed__c = system.today();
        	}
        	else 
        	{
        		PP.Project_Piece_Stage__c = PP.Milestone_2_Stage__c;
        		if(PP.Milestone_2_Owner__c!=null)PP.OwnerId = PP.Milestone_2_Owner__c;
        		if(PP.Milestone_2_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_2_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_2_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_2_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_2_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_2_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_2_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        	}
        } 
        else if(processDistance==0&&PP.Start_Process__c!=null&&oPP.Start_Process__c==null) 
        {
        	PP.Project_Piece_Stage__c = PP.Milestone_1_Stage__c;
        	if(PP.Milestone_1_Owner__c!=null)PP.OwnerId = PP.Milestone_1_Owner__c;
        	if(PP.Milestone_1_Role_Owner__c!=null)
        		{        			      			
        			if(PP.Milestone_1_Role_Owner__c=='Dealer Advocate')
        			{
        				if(TS.Territory_State__r.Account_Manager__c!=null)
        					PP.OwnerId = TS.Territory_State__r.Account_Manager__c;
        				/*if(TS.Exception_Account_Manager__c!=null) 
        					PP.OwnerId = TS.Exception_Account_Manager__c;*/
        			}
					else if(PP.Milestone_1_Role_Owner__c=='DDM')
        			{
        				if(TS.Territory_State__r.DDM__c!=null)
        					PP.OwnerId = TS.Territory_State__r.DDM__c;
    					if(TS.Exception_DDM__c!=null)
    						PP.OwnerId = TS.Exception_DDM__c;
        			}
					else if(PP.Milestone_1_Role_Owner__c=='Implementation Manager')
        			{
        				if(TS.Territory_State__r.Implementation_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Implementation_Manager__c;
        			}
					else if(PP.Milestone_1_Role_Owner__c=='Project Owner')
        			{
        				if(PP.Project_Owner_Id__c!=null)
        				PP.OwnerId = PP.Project_Owner_Id__c;
        			}
					else if(PP.Milestone_1_Role_Owner__c=='Regional')
        			{
        				if(TS.Territory_State__r.Regional__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Regional__c;
        			}
					else if(PP.Milestone_1_Role_Owner__c=='Territory Manager')
        			{
        				if(TS.Territory_State__r.Territory_Manager__c!=null)
        				PP.OwnerId = TS.Territory_State__r.Territory_Manager__c;
        			}        			
        		}
        }
        
        
//========================================================================================================
        //This section generates the tasks for each milestone based on the processDistance 
        //and sets the status of "surpassed" tasks to "Completed" based on the user's "highest" point in the process.
        for(Product_Process_Task__c pptList: productProcessTasks)
        {
        	Integer deadLine = 0;
    		if(pptList.Completion_Timeframe__c!=null) deadLine = pptList.Completion_Timeframe__c.IntValue(); 
    		
    		string taskOwner = PP.OwnerId;
    		string taskOwnerEmail; 
    		
    		boolean suppressTask=false;
    		      		
    		if(pptList.Assigned_To__c!=null)
    		{
    			taskOwner = pptList.Assigned_To__c;
    			taskOwnerEmail = pptList.Assigned_To__r.Email;    			
    		}
    		if(pptList.Assign_to_Role__c!=null)
    		{
    			if(pptList.Assign_to_Role__c=='Dealer Advocate')
    			{
    				if(TS.Territory_State__r.Account_Manager__c!=null)
    					taskOwner = TS.Territory_State__r.Account_Manager__c;
    					taskOwnerEmail = TS.Territory_State__r.Account_Manager__r.Email;
    				/*if(TS.Exception_Account_Manager__c!=null)
    					taskOwner = TS.Exception_Account_Manager__c;
    					taskOwnerEmail = TS.Exception_Account_Manager__r.Email;*/
    					
    				suppressTask = productProcesses.Suppress_Dealer_Advocate_Tasks__c;
    			}    			
				if(pptList.Assign_to_Role__c=='DDM')
				{
					if(TS.Territory_State__r.DDM__c!=null)
						taskOwner = TS.Territory_State__r.DDM__c;
						taskOwnerEmail = TS.Territory_State__r.DDM__r.Email;
					if(TS.Exception_DDM__c!=null)
						taskOwner = TS.Exception_DDM__c;
						taskOwnerEmail = TS.Exception_DDM__r.Email;
					
					suppressTask = productProcesses.Suppress_DDM_Tasks__c;
				}
				if(pptList.Assign_to_Role__c=='Implementation Manager'
				&& TS.Territory_State__r.Implementation_Manager__c!=null)
				{
					taskOwner = TS.Territory_State__r.Implementation_Manager__c;
					suppressTask = productProcesses.Suppress_Implementation_Manager_Tasks__c;
				}
				if(pptList.Assign_to_Role__c=='Project Owner'
				&& PP.Project_Owner_Id__c!=null)
				{
					taskOwner = PP.Project_Owner_Id__c;
					suppressTask = productProcesses.Suppress_Project_Owner_Tasks__c;
				}
				if(pptList.Assign_to_Role__c=='Regional'
				&& TS.Territory_State__r.Regional__c!=null)
				{
					taskOwner = TS.Territory_State__r.Regional__c;
					suppressTask = productProcesses.Suppress_Regional_Tasks__c;					
				}
				if(pptList.Assign_to_Role__c=='Territory Manager'
				&& TS.Territory_State__r.Territory_Manager__c!=null)
				{
					taskOwner = TS.Territory_State__r.Territory_Manager__c;
					suppressTask = productProcesses.Suppress_Territory_Manager_Tasks__c;					
				}
    		}
    		
    		if(!suppressTask)
    		{
	    		
    			Task T = new Task(ActivityDate = system.today()+deadLine, isProjectPieceTask__c = true,
    							Description=pptList.Task_Description__c, WhatId = PP.Id, OwnerId = taskOwner, Type = 'Task');
    								    		
				string subject;
				
				
				if(pptList.Name.length()>=73) subject = pptList.Name.substring(0,73);
				else subject = pptList.Name;
				
				T.Subject = 'WFT - '+subject;        	
	        	   	
	        	if(pptList.Process_Milestone__c=='1'&&oPP.Start_Process__c==null&&PP.Start_Process__c!=null)
	        	{
	        		if(processDistance>=1)
	        		{
	        			T.Date_Time_Completed__c = system.now();
		        		T.Status = 'Completed';	        			
	        		}
	        		newTasks.add(T);        	
	        	}
	        	if(pptList.Process_Milestone__c=='2'&&PP.Milestone_1_Completed__c!=null&&oPP.Milestone_1_Completed__c==null)
	    		{
	    			if(processDistance>=2)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';	        			
	        		}
	    			newTasks.add(T);
	    		}        	
	        	if(pptList.Process_Milestone__c=='3'&&oPP.Milestone_2_Completed__c==null&&PP.Milestone_2_Completed__c!=null)
	        	{
	        		if(processDistance>=3)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';
	        		}
	        		newTasks.add(T);        	
	        	}
	        	if(pptList.Process_Milestone__c=='4'&&oPP.Milestone_3_Completed__c==null&&PP.Milestone_3_Completed__c!=null)
	        	{
	        		if(processDistance>=4)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';
	        		}
	        		newTasks.add(T);   
	        	}     	
	        	if(pptList.Process_Milestone__c=='5'&&oPP.Milestone_4_Completed__c==null&&PP.Milestone_4_Completed__c!=null)
				{
	        		if(processDistance>=5)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';
	        		}
	        		newTasks.add(T);   
	        	}         	
	        	if(pptList.Process_Milestone__c=='6'&&oPP.Milestone_5_Completed__c==null&&PP.Milestone_5_Completed__c!=null)
				{
	        		if(processDistance>=6)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';
	        		}
	        		newTasks.add(T);   
	        	}         	        	
	        	if(pptList.Process_Milestone__c=='7'&&oPP.Milestone_6_Completed__c==null&&PP.Milestone_6_Completed__c!=null)
				{
	        		if(processDistance>=7)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';
	        		}
	        		newTasks.add(T);   
	        	}         	        	
	        	if(pptList.Process_Milestone__c=='8'&&oPP.Milestone_7_Completed__c==null&&PP.Milestone_7_Completed__c!=null)
				{
	        		if(processDistance>=8)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';
	        		}
	        		newTasks.add(T);   
	        	}         	       	
	        	if(pptList.Process_Milestone__c=='9'&&oPP.Milestone_8_Completed__c==null&&PP.Milestone_8_Completed__c!=null)
				{
	        		if(processDistance>=9)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';
	        		}
	        		newTasks.add(T);   
	        	}         	        	
	        	if(pptList.Process_Milestone__c=='10'&&oPP.Milestone_9_Completed__c==null&&PP.Milestone_9_Completed__c!=null)
				{
	        		if(processDistance>=10)
	        		{
	        			T.Date_Time_Completed__c = system.now();
	        			T.Status = 'Completed';
	        		}
	        		newTasks.add(T);   
	        	} 
	        }
	          	         	
        }
        //upsert newTasks;
        
           
//==================================================================================================================================================
	//Generate a related shipment if in Printing/Shipping/Uploading Stage  
		//string stageText = PP.Project_Piece_Stage__c.toLowerCase();
		if(PP.Project_Piece_Stage__c!=null&&PP.Project_Piece_Stage__c.toLowerCase().contains('shipping')==true&&
		(oPP.Project_Piece_Stage__c==null||oPP.Project_Piece_Stage__c!=null&&oPP.Project_Piece_Stage__c.toLowerCase().contains('shipping')!= true))
		{			
			Shipment__c shpmnt = new Shipment__c();
			shpmnt.Name = PP.Name;
			shpmnt.Project_Piece__c = PP.Id;
			insert shpmnt;
		}   
		if(oPP.Project_Piece_Stage__c!='Completed'
		&& PP.Project_Piece_Stage__c=='Completed' 
		&& productProcesses.Notify_Imp_Contact_Upon_Completion__c==true)
		{
			if(productProcesses.Notify_Imp_Contact_Template_ID__c==null)
			{
				PP.addError(' This Product Process has been set to send '+
				'an email notification to the Implementation Contact; '+
				'however, there is no Email Template assigned to the Product Process');
			}
			else
			{
				String[] toAddresses = new String[]{PP.Implementation_Contact_Email__c};
				Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
				email.setToAddresses(toAddresses);
				email.setWhatId(PP.Id);
				//email.setSubject('Product Implementation Complete'); 
				email.setSenderDisplayName('VinSolutions Implementation/Creative/Training');
		        email.setBccSender(false);
		        email.setUseSignature(false);	        
		        email.setTemplateId(productProcesses.Notify_Imp_Contact_Template_Id__c);
		        email.setTargetObjectId(PP.Implementation_Contact_Id__c);
		        email.setSaveAsActivity(true);
		        //String msg = 'The product '+PP.Product_Name__c+' has been implemented.';       	        
		        //email.setHtmlBody(msg);
				//Messaging.sendEmail(new Messaging.Email[] { email } , TRUE);
				emails.add(email);
			}
		}
		if(emails.size()>0)
		{
			try
			{
				Messaging.sendEmail(emails , TRUE); 
			}
			catch(Exception Ex)
			{
				system.debug(Ex);
			}
		}   
		return newTasks;      
    }    
    
    public static void updatePPOwnerEmail(Project_Piece__c pp) {
    	
    	{
		
		for(User pOwner: [select email from User where Id =: pp.Project_Owner_ID__c limit 1])
	
		{
			
			pp.Project_Owner_Email__c = pOwner.Email;
			//system.Debug('Project Piece Owner Email updated: ' + pp.Project_Owner_Email__c)  ;
			
			
		}
		
	}	
	
    }
//===============================================================================================================================================

	
	/*public static testmethod void testNewMilestoneProjectPiecesFast()
	{
			Territory_State__c TS = new Territory_State__c();
			TS.DDM__c = userinfo.getUserId();
			TS.Account_Manager__c = userinfo.getUserId();
			TS.Territory_Manager__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			
			TS.Name = 'TS';
			insert TS;
			
			Account A = new Account();
			A.BillingState = 'TS';
			A.BillingCity = 'Test City';
			A.BillingStreet = '123 Test'; 
			A.BillingPostalCode = '123456'; 
			A.BillingCountry = 'USA';
			A.Name = 'test';
			insert A;
			
			Contact C = new Contact();
			C.FirstName = 'Testfirst';
			C.LastName = 'Testlast';
			C.Account = A;
			insert C;
			
			Opportunity O = new Opportunity();
			O.AccountId = A.Id;
			O.Name = 'test';
			O.CloseDate = system.today();
			O.Deal_Contact__c = C.Id;
			O.StageName = 'Closed or Won';
			insert O;
			
			Product2 product = new Product2(
			name = 'test');		
			insert product;
			
			LIST<Project_Piece__c> projPc = new LIST<Project_Piece__c>();
			insert projPc;
			
			for (Integer t=1; t<11; t++)
			{
				LIST<Product_Process_Task__c> taskList = new LIST<Product_Process_Task__c>();
				
				integer i;
				
				Product_Process__c pProc = new Product_Process__c();
				pProc.Product__c = product.Id;				
										
				for(i=1;i<=t;i++)
				{
					Product_Process_Task__c pProcTask = new Product_Process_Task__c(
					Assigned_To__c = userinfo.getUserId(),
					Name = 'test',
					Process_Milestone__c = i.format(),
					Completion_Timeframe__c = i,
					Product_Process__c = pProc.Id);
					taskList.add(pProcTask);						
				}							
								
				SFDC_520_Quote__c project = new SFDC_520_Quote__c();
				project.Opportunity__c = O.Id;		
				User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];		
				project.DDM_Email__c = thisUser.Email;
				insert project;				
				
				Project_Piece__c PP = new Project_Piece__c(
				Name = 'test',
				Product_Process__c = pProc.Id, 
				Piece_Issue__c = 'test',
				Project__c = project.Id,
				Project_Piece_Stage__c = 'Introduction');
				insert PP;
								
				if (t>=1)
				{					
					pProc.Milestone_1__c = 'Test1';
					pProc.Milestone_1_Stage__c = 'Introduction';
					pProc.Assign_to_Role_1__c = 'DDM';
					//if (t==i) PP.Milestone_1_Completed__c = system.today();
				}
				if (t>=2)
				{					
					pProc.Milestone_2__c = 'Test1';
					pProc.Milestone_2_Stage__c = 'Introduction';
					pProc.Assign_to_Role_2__c = 'DDM';
					//if (t==i) PP.Milestone_2_Completed__c = system.today();
				}
				if (t>=3)
				{					
					pProc.Milestone_3__c = 'Test1';
					pProc.Milestone_3_Stage__c = 'Introduction';
					pProc.Assign_to_Role_3__c = 'DDM';
					//if (t==i) PP.Milestone_3_Completed__c = system.today();
				}
				if (t>=4)
				{					
					pProc.Milestone_4__c = 'Test1';
					pProc.Milestone_4_Stage__c = 'Introduction';
					pProc.Assign_to_Role_4__c = 'DDM';
					//if (t==i) PP.Milestone_4_Completed__c = system.today();
				}
				if (t>=5)
				{					
					pProc.Milestone_5__c = 'Test1';
					pProc.Milestone_5_Stage__c = 'Introduction';
					pProc.Assign_to_Role_5__c = 'DDM';
					//if (t==i) PP.Milestone_5_Completed__c = system.today();					
				}
				if (t>=6)
				{					
					pProc.Milestone_6__c = 'Test1';
					pProc.Milestone_6_Stage__c = 'Introduction';
					pProc.Assign_to_Role_6__c = 'DDM';
					//if (t==i) PP.Milestone_6_Completed__c = system.today();					
				}
				if (t>=7)
				{					
					pProc.Milestone_7__c = 'Test1';
					pProc.Milestone_7_Stage__c = 'Introduction';
					pProc.Assign_to_Role_7__c = 'DDM';
					//if (t==i) PP.Milestone_7_Completed__c = system.today();					
				}
				if (t>=8)
				{					
					pProc.Milestone_8__c = 'Test1';
					pProc.Milestone_8_Stage__c = 'Introduction';
					pProc.Assign_to_Role_8__c = 'DDM';
					//if (t==i) PP.Milestone_8_Completed__c = system.today();					
				}
				if (t>=9)
				{					
					pProc.Milestone_9__c = 'Test1';
					pProc.Milestone_9_Stage__c = 'Introduction';
					pProc.Assign_to_Role_9__c = 'DDM';
					//if (t==i) PP.Milestone_9_Completed__c = system.today();
				}
				if (t>=10)
				{					
					pProc.Milestone_10__c = 'Test1';
					pProc.Milestone_10_Stage__c = 'Introduction';
					pProc.Assign_to_Role_10__c = 'DDM';
					//if (t==i) PP.Milestone_10_Completed__c = system.today();					
				}
				insert pProc;
				//insert taskList;
				PP.Project_Piece_Stage__c = 'Completed';
				ProjPc.add(PP);
			}
			update ProjPc;
	}
	
	// Creates 10 new Milestone Project Pieces, one for each layout and closes them accordingly.
	public static testmethod void testNewMilestoneProjectPieces()
	{
			Territory_State__c TS = new Territory_State__c();
			TS.DDM__c = userinfo.getUserId();
			TS.Account_Manager__c = userinfo.getUserId();
			TS.Territory_Manager__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			
			TS.Name = 'TS';
			insert TS;
			
			Account A = new Account();
			A.BillingState = 'TS';
			A.BillingCity = 'Test City';
			A.BillingStreet = '123 Test'; 
			A.BillingPostalCode = '12345'; 
			A.BillingCountry = 'USA';
			A.ShippingStreet = '123 Test';
			A.ShippingState = 'TS';
			A.ShippingPostalCode = '12345';
			A.ShippingCountry = 'USA';
			A.ShippingCity = 'Test City';
			A.Name = 'test';
			insert A;
			
			Contact C = new Contact();
			C.FirstName = 'Testfirst';
			C.LastName = 'Testlast';
			C.Account = A;
			insert C;
			
			Opportunity O = new Opportunity();
			O.AccountId = A.Id;
			O.Name = 'test';
			O.CloseDate = system.today();
			O.Deal_Contact__c = C.Id;
			O.StageName = 'Closed or Won';
			insert O;
			
			Product2 product = new Product2(
			name = 'test');		
			insert product;
			
			LIST<Project_Piece__c> projPc = new LIST<Project_Piece__c>();
			//insert projPc;
			LIST<Product_Process__c> theseProcesses = new LIST<Product_Process__c>();
			
			for (Integer t=1; t<11; t++)
			{
				LIST<Product_Process_Task__c> taskList = new LIST<Product_Process_Task__c>();
				
				integer i;				
				
				Product_Process__c pProc = new Product_Process__c();
				pProc.Product__c = product.Id;				
										
				for(i=1;i<=t;i++)
				{
					Product_Process_Task__c pProcTask = new Product_Process_Task__c(
					Assigned_To__c = userinfo.getUserId(),
					Name = 'test',
					Process_Milestone__c = i.format(),
					Completion_Timeframe__c = i,
					Product_Process__c = pProc.Id);
					taskList.add(pProcTask);	
				}							
								
				SFDC_520_Quote__c project = new SFDC_520_Quote__c();
				project.Opportunity__c = O.Id;		
				User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];		
				project.DDM_Email__c = thisUser.Email;
				insert project;			
										
				if (t>=1)
				{					
					pProc.Milestone_1__c = 'Test1';
					pProc.Milestone_1_Stage__c = 'Introduction';
					pProc.Assign_to_Role_1__c = 'DDM';
					//PP.Milestone_1_Completed__c = system.today();
				}
				if (t>=2)
				{					
					pProc.Milestone_2__c = 'Test1';
					pProc.Milestone_2_Stage__c = 'Execution';
					pProc.Assign_to_Role_2__c = 'DDM';
					//PP.Milestone_2_Completed__c = system.today();
					//if (t == i)update PP;
				}
				if (t>=3)
				{					
					pProc.Milestone_3__c = 'Test1';
					pProc.Milestone_3_Stage__c = 'Execution';
					pProc.Assign_to_Role_3__c = 'DDM';
					//PP.Milestone_3_Completed__c = system.today();
					//if (t == i)update PP;
				}
				if (t>=4)
				{					
					pProc.Milestone_4__c = 'Test1';
					pProc.Milestone_4_Stage__c = 'Execution';
					pProc.Assign_to_Role_4__c = 'DDM';
					//PP.Milestone_4_Completed__c = system.today();
					//if (t == i)update PP;
				}
				if (t>=5)
				{					
					pProc.Milestone_5__c = 'Test1';
					pProc.Milestone_5_Stage__c = 'Execution';
					pProc.Assign_to_Role_5__c = 'DDM';
					//PP.Milestone_5_Completed__c = system.today();
					//if (t == i)update PP;
				}
				if (t>=6)
				{					
					pProc.Milestone_6__c = 'Test1';
					pProc.Milestone_6_Stage__c = 'Execution';
					pProc.Assign_to_Role_6__c = 'DDM';
					//PP.Milestone_6_Completed__c = system.today();
					//if (t == i)update PP;
				}
				if (t>=7)
				{					
					pProc.Milestone_7__c = 'Test1';
					pProc.Milestone_7_Stage__c = 'Execution';
					pProc.Assign_to_Role_7__c = 'DDM';
					//PP.Milestone_7_Completed__c = system.today();
					//if (t == i)update PP;
				}
				if (t>=8)
				{					
					pProc.Milestone_8__c = 'Test1';
					pProc.Milestone_8_Stage__c = 'Execution';
					pProc.Assign_to_Role_8__c = 'DDM';
					//PP.Milestone_8_Completed__c = system.today();
					//if (t == i)update PP;
				}
				if (t>=9)
				{					
					pProc.Milestone_9__c = 'Test1';
					pProc.Milestone_9_Stage__c = 'Execution';
					pProc.Assign_to_Role_9__c = 'DDM';
					//PP.Milestone_9_Completed__c = system.today();
					//if (t == i)update PP;
				}
				if (t>=10)
				{					
					pProc.Milestone_10__c = 'Test1';
					pProc.Milestone_10_Stage__c = 'Execution';
					pProc.Assign_to_Role_10__c = 'DDM';
					//PP.Milestone_10_Completed__c = system.today();
					//if (t == i)update PP;
				}
				insert pProc;
				
				Project_Piece__c PP = new Project_Piece__c(
				Name = 'test',
				Product_Process__c = pProc.Id, 
				Piece_Issue__c = 'test',
				Project__c = project.Id);
				
				insert PP;
				
				//insert taskList;			
				projPc.add(PP);
				PP.Project_Piece_Stage__c = 'Completed';
			}
			insert theseProcesses;
			
			insert ProjPc;	
	}
	*/
	
	
	public static testmethod void testQuickComplete1()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=1;t<2;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
	public static testmethod void testQuickComplete2()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=2;t<3;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
	public static testmethod void testQuickComplete3()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=3;t<4;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
	public static testmethod void testQuickComplete4()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=4;t<5;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
	public static testmethod void testQuickComplete5()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=5;t<6;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
		public static testmethod void testQuickComplete6()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=6;t<7;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
		public static testmethod void testQuickComplete7()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=7;t<8;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
				 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
		public static testmethod void testQuickComplete8()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=8;t<9;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
		public static testmethod void testQuickComplete9()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=9;t<10;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
		public static testmethod void testQuickComplete10()
	{
		LIST<Product_Process__c> tenProcesses = new LIST<Product_Process__c>();
		
		LIST<Project_Piece__c> tenPieces = new LIST<Project_Piece__c>();
		
		SFDC_520_Quote__c parentProject = 
		[Select s.Opportunity__c, s.Account__c 
		From SFDC_520_Quote__c s 
		where Opportunity__c != null 
		and Account__c !=null 
		limit 1];
		
		Product2 testProduct = [select id from Product2 limit 1];	
		
		for(integer t=10;t<11;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = testProduct.Id;
			
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			tenProcesses.add(pProc);	
		}
		 
		insert tenProcesses;
		
		for(Product_Process__c thisProcess:tenProcesses)
		{
			Project_Piece__c newPiece = new Project_Piece__c();
			newPiece.Account__c = parentProject.Account__c;
			newPiece.Project__c = parentProject.Id;
			newPiece.Product_Process__c = thisProcess.Id;
			newpiece.Piece_Issue__c = 'test';
			newPiece.Name = 'test';

			tenPieces.add(newPiece);						
		}
		
		test.startTest();
		insert tenPieces;
		
		for (integer i=0; i< tenProcesses.size(); i++)
		{
			tenPieces[i].Project_Piece_Stage__c = 'Completed';	
		}		
		if (tenPieces[0].Product_Process__c !=null)update tenPieces;
		test.stopTest();
	}
	
	

	
	
	public static testmethod void testProjProcess1to5()
	{		
			Territory_State__c TS = new Territory_State__c();
			TS.DDM__c = userinfo.getUserId();
			TS.Account_Manager__c = userinfo.getUserId();
			TS.Territory_Manager__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
        	TS.Implementation_Specialist__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			
			TS.Name = 'TS';
			insert TS;
			
			Account A = new Account();
			A.BillingState = 'TS';
			A.BillingCity = 'Test City';
			A.BillingStreet = '123 Test'; 
			A.BillingPostalCode = '12345'; 
			A.BillingCountry = 'USA';
			A.ShippingStreet = '123 Test';
			A.ShippingState = 'TS';
			A.ShippingPostalCode = '12345';
			A.ShippingCountry = 'USA';
			A.ShippingCity = 'Test City';
			A.Name = 'test';
			insert A;
			
			Contact C = new Contact();
			C.FirstName = 'Testfirst';
			C.LastName = 'Testlast';
			C.Account = A;
            C.Phone = '9999999999';
			insert C;
			
			Opportunity O = new Opportunity();
			O.AccountId = A.Id;
                                       O.ValidationRules__c = true;
			O.Name = 'test';
			O.CloseDate = system.today();
			O.Deal_Contact__c = C.Id;
			O.StageName = 'Closed or Won';
			insert O;
			
			Product2 product = new Product2(
			name = 'test');		
			insert product;
		
			LIST<Project_Piece__c> updatePPS = new LIST<Project_Piece__c>();
			List<Project_Piece__c> thesePieces= new LIST<Project_Piece__c>();
		
		for(integer t=1;t<4;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = product.Id;
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Assign_to_Role_1__c = 'DDM';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			insert pProc;	
			
			SFDC_520_Quote__c project = new SFDC_520_Quote__c();
			project.Opportunity__c = O.Id;		
			User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];		
			//project.DDM_Email__c = thisUser.Email;
			insert project;
			
			LIST<Product_Process_Task__c> taskList = new LIST<Product_Process_Task__c>();
			for(integer i=1;i<=10;i++)
			{
				Product_Process_Task__c pProcTask = new Product_Process_Task__c(
				Assigned_To__c = userinfo.getUserId(),
				Name = 'test',
				Process_Milestone__c = i.format(),
				Completion_Timeframe__c = i,
				Product_Process__c = pProc.Id);
				taskList.add(pProcTask);	
			}	
			insert taskList;
			
			Product_Process_Task__c pProcTask2 = new Product_Process_Task__c(
			Assigned_To__c = userinfo.getUserId(),
			Name = 'test',
			Process_Milestone__c = '2',
			Completion_Timeframe__c = 3,
			Product_Process__c = pProc.Id);		
			insert pProcTask2;
			
			Project_Piece__c PP = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			thesePieces.add(PP);
			
			
			/*Project_Piece__c PP2 = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			thesePieces.add(PP2);	
			
			Project_Piece__c PP3 = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			thesePieces.add(PP3);*/
			
			//insert thesePieces;	
			
			if(t==1)PP.Milestone_1_Completed__c = system.today();				
			if(t==2)PP.Milestone_2_Completed__c = system.today();
			if(t==3)PP.Milestone_3_Completed__c = system.today();
			if(t==4)PP.Milestone_4_Completed__c = system.today();
			if(t==5)PP.Milestone_5_Completed__c = system.today();
		}
		insert thesePieces;
		for (Project_Piece__c PP: thesePieces)
		{
			PP.Project_Piece_Stage__c = 'Completed';
			PP.Date_Stage_Updated_to_Completed__c = system.today();
			updatePPS.add(PP);
		}
		update updatePPS;
	}
	public static testmethod void testProjProcess6to10()
	{
	
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
    	TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
		
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
        C.Phone = '9999999999';
		insert C;
		
		Opportunity O = new Opportunity();
		O.AccountId = A.Id;
		O.Name = 'test';
		O.CloseDate = system.today();
                          O.ValidationRules__c = true;
		O.Deal_Contact__c = C.Id;
		O.StageName = 'Closed or Won';
		insert O;
		
		Product2 product = new Product2(
		name = 'test');		
		insert product;
			
		LIST<Project_Piece__c> updatePPS = new LIST<Project_Piece__c>();
		LIST<Project_Piece__c> projPc = new LIST<Project_Piece__c>();
		
		for(integer t=6;t<10;t++)
		{
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = product.Id;
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Execution';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			insert pProc;	
			
			SFDC_520_Quote__c project = new SFDC_520_Quote__c();
			project.Opportunity__c = O.Id;		
			User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];		
			//project.DDM_Email__c = thisUser.Email;
			insert project;
			
			LIST<Product_Process_Task__c> taskList = new LIST<Product_Process_Task__c>();
			for(integer i=1;i<=10;i++)
			{
				Product_Process_Task__c pProcTask = new Product_Process_Task__c(
				Assigned_To__c = userinfo.getUserId(),
				Name = 'test',
				Process_Milestone__c = i.format(),
				Completion_Timeframe__c = i,
				Product_Process__c = pProc.Id);
				taskList.add(pProcTask);	
			}	
			insert taskList;
			
			Product_Process_Task__c pProcTask2 = new Product_Process_Task__c(
			Assigned_To__c = userinfo.getUserId(),
			Name = 'test',
			Process_Milestone__c = '2',
			Completion_Timeframe__c = 3,
			Product_Process__c = pProc.Id);		
			insert pProcTask2;
			
			Project_Piece__c PP = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			projPc.add(PP);	
			
			/*Project_Piece__c PP2 = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			projPc.add(PP2);	
			
			Project_Piece__c PP3 = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			projPc.add(PP3);*/
			
			//insert projPc;		
			
			if(t==6)PP.Milestone_6_Completed__c = system.today();
			if(t==7)PP.Milestone_7_Completed__c = system.today();
			if(t==8)PP.Milestone_8_Completed__c = system.today();
			if(t==9)PP.Milestone_9_Completed__c = system.today();
			if(t==10)PP.Milestone_10_Completed__c = system.today();
		}
		//insert ProjPc;
		for (Project_Piece__c PP: ProjPc)
		{
			PP.Project_Piece_Stage__c = 'Completed';
			PP.Date_Stage_Updated_to_Completed__c = system.today();
			updatePPS.add(PP);
		}
		//update updatePPS;
	}
	
	
    
//=================================================================================================================================================


public static testmethod void testProjProcess1to5SHORTSTOP()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
    	TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
		
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
        C.Phone = '9999999999';
		insert C;
		
		Opportunity O = new Opportunity();
		O.AccountId = A.Id;
		O.Name = 'test';
		O.CloseDate = system.today();
                          O.ValidationRules__c = true;
		O.Deal_Contact__c = C.Id;
		O.StageName = 'Closed or Won';
		insert O;
		
		Product2 product = new Product2(
		name = 'test');		
		insert product;
		
		
		for(integer t=1;t<6;t++)
		{
			
			
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = product.Id;
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Milestone_1_Owner__c = userinfo.getuserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Execution';
				pProc.Milestone_2_Owner__c = userinfo.getuserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getuserId();				
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getuserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getuserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getuserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getuserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getuserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getuserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getuserId();
			}
			insert pProc;	
			
			SFDC_520_Quote__c project = new SFDC_520_Quote__c();
			project.Opportunity__c = O.Id;		
			User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];		
			//project.DDM_Email__c = thisUser.Email;
			//insert project;
			
			LIST<Product_Process_Task__c> taskList = new LIST<Product_Process_Task__c>();
			for(integer i=1;i<=10;i++)
			{
				Product_Process_Task__c pProcTask = new Product_Process_Task__c(
				Assigned_To__c = userinfo.getUserId(),
				Name = 'test',
				Process_Milestone__c = i.format(),
				Completion_Timeframe__c = i,
				Product_Process__c = pProc.Id);
				taskList.add(pProcTask);	
			}	
			insert taskList;
			
			Product_Process_Task__c pProcTask2 = new Product_Process_Task__c(
			Assigned_To__c = userinfo.getUserId(),
			Name = 'test',
			Process_Milestone__c = '2',
			Completion_Timeframe__c = 3,
			Product_Process__c = pProc.Id);		
			insert pProcTask2;
					
			LIST<Project_Piece__c> projPc = new LIST<Project_Piece__c>();
			Project_Piece__c PP = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			projPc.add(PP);	
			
			Project_Piece__c PP2 = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			projPc.add(PP2);	
			
			Project_Piece__c PP3 = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			projPc.add(PP3);
			
			//insert projPc;		
			
			if(t==1)PP.Start_Process__c = system.today();
			if(t==2)PP.Milestone_1_Completed__c = system.today();
			if(t==3)PP.Milestone_2_Completed__c = system.today();
			if(t==4)PP.Milestone_3_Completed__c = system.today();
			if(t==5)PP.Milestone_4_Completed__c = system.today();
			//update PP;
			
			PP3.Project_Piece_Stage__c = 'Completed';
			PP.Date_Stage_Updated_to_Completed__c = system.today();
			//update PP3;			
		}
	}
	public static testmethod void testProjProcess6to10SHORTSTOP()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
    	TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
		
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
        C.Phone = '9999999999';
		insert C;
		
		Opportunity O = new Opportunity();
		O.AccountId = A.Id;
		O.Name = 'test';
		O.CloseDate = system.today();
                          O.ValidationRules__c = true;
		O.Deal_Contact__c = C.Id;
		O.StageName = 'Prospect';
		insert O;
		
		Product2 product = new Product2(
		name = 'test');		
		insert product;
		
		LIST<Project_Piece__c> UpdatePieces = new LIST<Project_Piece__c>();
		
		for(integer t=6;t<11;t++)
		{
			
			
			Product_Process__c pProc = new Product_Process__c();
			pProc.Product__c = product.Id;
			if(t>=1)
			{
				pProc.Milestone_1__c = 'Test1';
				pProc.Milestone_1_Stage__c = 'Introduction';
				pProc.Milestone_1_Owner__c = userinfo.getUserId();
			}
			if(t>=2)
			{ 
				pProc.Milestone_2__c = 'Test2';
				pProc.Milestone_2_Stage__c = 'Execution';
				pProc.Milestone_2_Owner__c = userinfo.getUserId();
			}
			if(t>=3)
			{
				pProc.Milestone_3__c = 'Test3';
				pProc.Milestone_3_Stage__c = 'Execution';
				pProc.Milestone_3_Owner__c = userinfo.getUserId();
			}
			if(t>=4)
			{
				pProc.Milestone_4__c = 'Test4';
				pProc.Milestone_4_Stage__c = 'Execution';
				pProc.Milestone_4_Owner__c = userinfo.getUserId();
			}
			if(t>=5)
			{				
				pProc.Milestone_5__c = 'Test5';
				pProc.Milestone_5_Stage__c = 'Execution';
				pProc.Milestone_5_Owner__c = userinfo.getUserId();
			}
			if(t>=6)
			{				
				pProc.Milestone_6__c = 'Test6';
				pProc.Milestone_6_Stage__c = 'Execution';
				pProc.Milestone_6_Owner__c = userinfo.getUserId();
			}
			if(t>=7)
			{			
				pProc.Milestone_7__c = 'Test7';
				pProc.Milestone_7_Stage__c = 'Execution';
				pProc.Milestone_7_Owner__c = userinfo.getUserId();
			}
			if(t>=8)
			{				
				pProc.Milestone_8__c = 'Test8';
				pProc.Milestone_8_Stage__c = 'Execution';
				pProc.Milestone_8_Owner__c = userinfo.getUserId();
			}
			if(t>=9)
			{				
				pProc.Milestone_9__c = 'Test9';
				pProc.Milestone_9_Stage__c = 'Execution';
				pProc.Milestone_9_Owner__c = userinfo.getUserId();
			}
			if(t>=10)
			{				
				pProc.Milestone_10__c = 'Test10';
				pProc.Milestone_10_Stage__c = 'Execution';
				pProc.Milestone_10_Owner__c = userinfo.getUserId();
			}
			insert pProc;	
			
			SFDC_520_Quote__c project = new SFDC_520_Quote__c();
			project.Opportunity__c = O.Id;		
			User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];		
			//project.DDM_Email__c = thisUser.Email;
			insert project;
			
			LIST<Product_Process_Task__c> taskList = new LIST<Product_Process_Task__c>();
			for(integer i=1;i<=10;i++)
			{
				Product_Process_Task__c pProcTask = new Product_Process_Task__c(
				Assigned_To__c = userinfo.getUserId(),
				Name = 'test',
				Process_Milestone__c = i.format(),
				Completion_Timeframe__c = i,
				Product_Process__c = pProc.Id);
				taskList.add(pProcTask);	
			}	
			insert taskList;
			
			Product_Process_Task__c pProcTask2 = new Product_Process_Task__c(
			Assigned_To__c = userinfo.getUserId(),
			Name = 'test',
			Process_Milestone__c = '2',
			Completion_Timeframe__c = 3,
			Product_Process__c = pProc.Id);		
			insert pProcTask2;
					
			LIST<Project_Piece__c> thesePieces = new LIST<Project_Piece__c>();
			
			Project_Piece__c PP = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			thesePieces.add(PP);
			
			Project_Piece__c PP2 = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			thesePieces.add(PP2);	
			
			Project_Piece__c PP3 = new Project_Piece__c(
			Name = 'test',
			Product_Process__c = pProc.Id, 
			Piece_Issue__c = 'test',
			Project__c = project.Id);
			thesePieces.add(PP3);
			
			insert thesePieces;		
			
			if(t==6)PP.Milestone_5_Completed__c = system.today();
			if(t==7)PP.Milestone_6_Completed__c = system.today();
			if(t==8)PP.Milestone_7_Completed__c = system.today();
			if(t==9)PP.Milestone_8_Completed__c = system.today();
			if(t==10)PP.Milestone_9_Completed__c = system.today();
			//update PP;
			
			PP3.Project_Piece_Stage__c = 'Completed';
			PP.Date_Stage_Updated_to_Completed__c = system.today();
			updatePieces.add(PP3);
		}
				
		//update UpdatePieces;
	}
	
	
	public static testmethod void testProjProcessLONGROUTE()
	{
		Territory_State__c TS = new Territory_State__c();
		TS.DDM__c = userinfo.getUserId();
		TS.Account_Manager__c = userinfo.getUserId();
		TS.Territory_Manager__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		
		TS.Name = 'TS';
		insert TS;
		
		Account A = new Account();
		A.BillingState = 'TS';
		A.BillingCity = 'Test City';
		A.BillingStreet = '123 Test'; 
		A.BillingPostalCode = '12345'; 
		A.BillingCountry = 'USA';
		A.ShippingStreet = '123 Test';
		A.ShippingState = 'TS';
		A.ShippingPostalCode = '12345';
		A.ShippingCountry = 'USA';
		A.ShippingCity = 'Test City';
		A.Name = 'test';
		insert A;
		
		Contact C = new Contact();
		C.FirstName = 'Testfirst';
		C.LastName = 'Testlast';
		C.Account = A;
        C.Phone = '9999999999';
		insert C;
		
		Opportunity O = new Opportunity();
		O.AccountId = A.Id;
		O.Name = 'test';
		O.CloseDate = system.today();
                          O.ValidationRules__c = true;
		O.Deal_Contact__c = C.Id;
		O.StageName = 'Closed or Won';
		insert O;
		
		//Installment__c Inst = new Installment__c();
		//Inst.Name = 'TEST INSTALLMENT';
		//Inst.Opportunity__c = O.Id;
		//Inst.Installment_Number__c = 1;
		//Inst.Installment_Due_Date__c = system.today();
		//Inst.Installment_Amount__c = 1000.00;
		//Inst.Contact_Email__c = 'test@test.com';
		
		//insert Inst;
		
		Product2 product = new Product2(
		name = 'test', Description = 'website', IsPackageParent__c = true,
		Production_Department__c = 'creative', Production_Issue__c = 'website',
		ProdProj_Default_Owner__c = userinfo.getUserId(), requiresWelcomePacket__c = true
		);		
		insert product;
		
		
		Product_Process__c pProc = new Product_Process__c();
		pProc.Product__c = product.Id;
		pProc.Milestone_1__c = 'Test1';
		pProc.Milestone_1_Stage__c = 'Introduction';
		pProc.Milestone_1_Owner__c = userinfo.getUserId();
		pProc.Milestone_2__c = 'Test3';
		pProc.Milestone_2_Stage__c = 'Printing/Shipping/Uploading';	
		pProc.Milestone_2_Owner__c = userinfo.getUserId();		
		insert pProc;	
		
		SFDC_520_Quote__c project = new SFDC_520_Quote__c();
		project.Opportunity__c = O.Id;	
		//project.Account__c = A.id;	
		User thisUser = [select id, Email from User where Id=:userinfo.getuserId()];		
		//project.DDM_Email__c = thisUser.Email;
		insert project;
		
		LIST<Product_Process_Task__c> taskList = new LIST<Product_Process_Task__c>();
		for(integer i=0;i<2;i++)
		{
			Product_Process_Task__c pProcTask = new Product_Process_Task__c(
			Assigned_To__c = userinfo.getUserId(),
			Name = 'test',
			Process_Milestone__c = i.format(),
			Completion_Timeframe__c = i,
			Product_Process__c = pProc.Id);
			taskList.add(pProcTask);	
		}	
		insert taskList;			
				
		Project_Piece__c PP = new Project_Piece__c(
		Name = 'test',
		Product_Process__c = pProc.Id, 
		Piece_Issue__c = 'test',
		Project__c = project.Id);
		insert PP;	
		
		PP.Start_Process__c = system.today();
		update PP;
		
		PP.Milestone_1_Completed__c = system.today();
		update PP;
		
		try
		{
			delete project;	
		}
		catch (Exception ex)
		{
			system.debug(ex);
		}
		
		delete PP;
		delete project;
		delete O;
	}

}