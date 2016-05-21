public class UserUpdate
{
	public static void addOffices(User[] Usr, User[] prev) 
	{/*		
		LIST<User> updatedUsers = new LIST<User>();
		LIST<User> theseUsers = UserUpdate.UserList(Usr[0].Id);
		system.debug(theseUsers);
		if(Usr[0].Manager_of_Training__c==TRUE)
		{
			if(prev[0].Manager_of_Training__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{			
					u.Current_Manager_of_Training__c = Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_Manager_of_Training__c=Usr[0].FirstName +' '+Usr[0].LastName;
				
			}				
		}
		if(Usr[0].Manager_of_Training__c==FALSE)
		{
			if(Usr[0].Current_Manager_of_Training__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{
				
				if(prev[0].Manager_of_Training__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{					
						u.Current_Manager_of_Training__c= null;
										
						updatedUsers.add(u); 
					}		
					
					//update updatedUsers;
					Usr[0].Current_Manager_of_Training__c=null;
					
				}
			}
			
		} 
	
		if(Usr[0].Click_to_Chat_Specialist__c==TRUE) 
		{
			if(prev[0].Click_to_Chat_Specialist__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{	
					u.Current_Click_to_Chat_Specialist__c = Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_Click_to_Chat_Specialist__c=Usr[0].FirstName +' '+Usr[0].LastName;
			}				
		}
		if(Usr[0].Click_to_Chat_Specialist__c==FALSE)
		{
			if(Usr[0].Current_Click_to_Chat_Specialist__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{
				if(prev[0].Click_to_Chat_Specialist__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{			
						u.Current_Click_to_Chat_Specialist__c= null;
										
						updatedUsers.add(u); 
					}	
					//update updatedUsers;
					Usr[0].Current_Click_to_Chat_Specialist__c=null;
					
				}
			}
			
		}
		
		
		if(Usr[0].Travel_Arranger__c==True)
		{
			if(prev[0].Travel_Arranger__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{			
					u.Current_Travel_Arranger__c = Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_Travel_Arranger__c=Usr[0].FirstName +' '+Usr[0].LastName;
			}				
		}
		if(Usr[0].Travel_Arranger__c==FALSE)
		{
			if(Usr[0].Current_Travel_Arranger__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{
				if(prev[0].Travel_Arranger__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{	
						u.Current_Travel_Arranger__c= null;
										
						updatedUsers.add(u); 
					}	
					//update updatedUsers;
					Usr[0].Current_Travel_Arranger__c=null;
					
				}
			}
			
		}
		
		if(Usr[0].Travel_Financer__c ==TRUE)
		{
			if(prev[0].Travel_Financer__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{	
					u.Current_Travel_Financer__c = Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_Travel_Financer__c=Usr[0].FirstName +' '+Usr[0].LastName;
			}				
		}
		if(Usr[0].Travel_Financer__c==FALSE)
		{
			if(Usr[0].Current_Travel_Financer__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{
				if(prev[0].Travel_Financer__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{	
						u.Current_Travel_Financer__c= null;
										
						updatedUsers.add(u); 
					}	
					//update updatedUsers;
					Usr[0].Current_Travel_Financer__c=null;
					
				}
			}
			
		}
		
		if(Usr[0].In_charge_of_Printing_Shipping__c==TRUE)
		{
			if(prev[0].In_charge_of_Printing_Shipping__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{	
					u.Current_Person_In_charge_of_Printing_Shi__c= Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_Person_In_charge_of_Printing_Shi__c=Usr[0].FirstName +' '+Usr[0].LastName;
			}
		}
		if(Usr[0].In_charge_of_Printing_Shipping__c==FALSE)
		{
			if(Usr[0].Current_Person_In_Charge_of_Printing_shi__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{	
				if(prev[0].In_charge_of_Printing_Shipping__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{	
						u.Current_Person_In_charge_of_Printing_Shi__c= null;
										
						updatedUsers.add(u); 
					}	
					//update updatedUsers;
					Usr[0].Current_Person_In_charge_of_Printing_Shi__c=null;
					
				}
			}
			
		}
		if(Usr[0].VinCamera_Assets__c==TRUE)
		{
			if(prev[0].VinCamera_Assets__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{	
					u.Current_VinCamera_Assets__c = Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_VinCamera_Assets__c=Usr[0].FirstName +' '+Usr[0].LastName;
			}				
		}
		if(Usr[0].VinCamera_Assets__c==FALSE)
		{
			if(Usr[0].Current_VinCamera_Assets__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{
				if(prev[0].VinCamera_Assets__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{	
						u.Current_VinCamera_Assets__c= null;
										
						updatedUsers.add(u); 
					}	
					//update updatedUsers;
					Usr[0].Current_VinCamera_Assets__c=null;
					
				}
			}
			
		}
		if(Usr[0].Default_Project_Owner__c==TRUE)
		{
			if(prev[0].Default_Project_Owner__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{	
					u.Current_Default_Project_Owner__c = Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_Default_Project_Owner__c=Usr[0].FirstName +' '+Usr[0].LastName;
			}				
		}
		if(Usr[0].Default_Project_Owner__c==FALSE)
		{
			if(Usr[0].Current_Default_Project_Owner__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{
				if(prev[0].Default_Project_Owner__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{	
						u.Current_Default_Project_Owner__c=null;
										
						updatedUsers.add(u); 
					}	
					//update updatedUsers;
					Usr[0].Current_Default_Project_Owner__c=null;
					
				}
			}
			
		}
		
		if(Usr[0].Welcome_Packet_Rep__c==TRUE)
		{
			if(prev[0].Welcome_Packet_Rep__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{	
					u.Current_Welcome_Packet_Rep__c = Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_Welcome_Packet_Rep__c=Usr[0].FirstName +' '+Usr[0].LastName;
			}				
		}
		if(Usr[0].Welcome_Packet_Rep__c==FALSE)
		{
			if(Usr[0].Current_Welcome_Packet_Rep__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{
				if(prev[0].Welcome_Packet_Rep__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{	
						u.Current_Welcome_Packet_Rep__c=null;
										
						updatedUsers.add(u); 
					}	
					//update updatedUsers;
					Usr[0].Current_Welcome_Packet_Rep__c=null;
					
				}
			}
			
		}
		
		if(Usr[0].Email_Banner_Rep__c==TRUE)
		{
			if(prev[0].Email_Banner_Rep__c==FALSE)
			{
				//List<User> updatedUsers = new List<User>();
				
				for(User u: theseUsers)
				{	
					u.Current_Email_Banner_Rep__c = Usr[0].FirstName+' '+Usr[0].LastName;
									
					updatedUsers.add(u); 
				}	
				//update updatedUsers;
				Usr[0].Current_Email_Banner_Rep__c=Usr[0].FirstName +' '+Usr[0].LastName;
			}				
		}
		if(Usr[0].Email_Banner_Rep__c==FALSE)
		{
			if(Usr[0].Current_Email_Banner_Rep__c==Usr[0].FirstName+' '+Usr[0].LastName)
			{
				if(prev[0].Email_Banner_Rep__c==TRUE)
				{
					//List<User> updatedUsers = new List<User>();
					
					for(User u: theseUsers)
					{	
						u.Current_Email_Banner_Rep__c=null;
										
						updatedUsers.add(u); 
					}	
					//update updatedUsers;
					Usr[0].Current_Email_Banner_Rep__c=null;
					
				}
			}
			
		}
		
		
		
		
		
		if(Usr[0].DelegatedApproverId!=null&&Usr[0].Delegated_Approver_2__c==null&&Usr[0].DelegatedApproverId!=Usr[0].Id&&Usr[0].IsActive==TRUE)
		{
			Usr[0].Delegated_Approver_2__c = Usr[0].DelegatedApproverId;
		}
				
		update updatedUsers;*/
	}

	/*public static void LIST<User> UserList(string Id)
	{
		/*MAP<Id, User> mappedUsers = new MAP<Id, User>();
		
					
		for (User u : [select id, Current_VinCamera_Assets__c, VinCamera_Assets__c, 
		Current_Travel_Financer__c,Current_Travel_Arranger__c,
		Current_Person_In_charge_of_Printing_Shi__c,Current_Manager_of_Training__c,
		Manager_of_Training__c, Travel_Arranger__c, Travel_Financer__c,
		In_charge_of_Printing_Shipping__c from User where id !=:Id and IsActive=TRUE and 
		((VinCamera_Assets__c != null) or 
		(Travel_Arranger__c != null) or 
		(Travel_Financer__c != null) or 
		(In_charge_of_Printing_Shipping__c != null))]) 
		{							
			mappedUsers.put(u.id, u);
		}	
		
		LIST<User> updatedUsers = mappedUsers.values();
			
		return updatedUsers;*/
	/*}*/ 
	
	public static testMethod void testMt() 
	{/*
		
		
		User MT = [select id, DelegatedApproverId, Manager_of_Training__c, 
				Travel_Arranger__c, Travel_Financer__c,In_charge_of_Printing_Shipping__c
				from User where Manager_of_Training__c!=false limit 1];

				
		MT.Manager_of_Training__c=TRUE;
		MT.DelegatedApproverId = userinfo.getUserId();
		MT.Delegated_Approver_2__c = null;
		update MT;
		MT.Manager_of_Training__c=FALSE;
		update MT;
		MT.Manager_of_Training__c=TRUE;
		update MT;*/
	}
	
	
	public static testMethod void testTF() 
	{/*
		
		User TF = [select id, Manager_of_Training__c, 
				Travel_Arranger__c, Travel_Financer__c,In_charge_of_Printing_Shipping__c
				from User where Travel_Financer__c!=false limit 1];

		TF.Travel_Financer__c=FALSE;
		update TF;
		TF.Travel_Financer__c=TRUE;
		update TF;*/
	}
	public static testMethod void testDPO() 
	{/*
		
		/*User DPO = [select id, Manager_of_Training__c, 
				Current_Default_Project_Owner__c, Default_Project_Owner__c, FirstName, LastName 
				from User where Travel_Financer__c!=false limit 1];
		
		if(DPO==null)
		{
			DPO = [select id, FirstName, LastName from User where Id=:userinfo.getUserId()];
			
			DPO.Default_Project_Owner__c=TRUE;
			update DPO;
			DPO.Default_Project_Owner__c=FALSE;
			DPO.Current_Default_Project_Owner__c = DPO.FirstName+' '+DPO.LastName;
			update DPO;
			DPO.Default_Project_Owner__c=TRUE;
			update DPO;
			DPO.Default_Project_Owner__c=FALSE;
			update DPO;
		}
		else
		{		
			DPO.Default_Project_Owner__c=FALSE;
			update DPO;
			DPO.Default_Project_Owner__c=TRUE;
			update DPO;	
			DPO.Default_Project_Owner__c=FALSE;
			DPO.Current_Default_Project_Owner__c = DPO.FirstName+' '+DPO.LastName;
			update DPO;
			DPO.Default_Project_Owner__c=TRUE;
			update DPO;			
		}*/
		
	}
	
	public static testMethod void testWPR() 
	{
		
		/*User WPR = [select id, Manager_of_Training__c, 
				Current_Default_Project_Owner__c, Default_Project_Owner__c 
				from User where Travel_Financer__c!=false limit 1];
		
		if(WPR==null)
		{
			WPR = [select id from User where Id=:userinfo.getUserId()];
			
			WPR.Welcome_Packet_Rep__c=TRUE;
			update WPR;
			WPR.Welcome_Packet_Rep__c=FALSE;
			update WPR;
			WPR.Welcome_Packet_Rep__c=TRUE;
			update WPR;
			WPR.Welcome_Packet_Rep__c=FALSE;
			update WPR;
		}
		else
		{		
			WPR.Welcome_Packet_Rep__c=FALSE;
			update WPR;
			WPR.Welcome_Packet_Rep__c=TRUE;
			update WPR;	
			WPR.Welcome_Packet_Rep__c=FALSE;
			update WPR;
			WPR.Welcome_Packet_Rep__c=TRUE;
			update WPR;			
		}*/
		
		}
	public static testMethod void testEBR() 
	{
		
		/*User EBR = [select id, Manager_of_Training__c, Email_Banner_Rep__c, Current_Email_Banner_Rep__c,
				Welcome_Packet_Rep__c, Current_Default_Project_Owner__c, Default_Project_Owner__c, FirstName, LastName
				from User where Travel_Financer__c!=false limit 1];
		
		if(EBR==null)
		{
			EBR = [select id, FirstName, LastName from User where Id=:userinfo.getUserId()];
			
			
			
			EBR.Welcome_Packet_Rep__c=TRUE;
			update EBR;
			EBR.Email_Banner_Rep__c=FALSE;
			EBR.Welcome_Packet_Rep__c=FALSE;
			update EBR;
			EBR.Welcome_Packet_Rep__c=TRUE;
			update EBR;
			EBR.Welcome_Packet_Rep__c=FALSE;
			update EBR; 
		}
		else
		{	
			
			EBR.Welcome_Packet_Rep__c=FALSE;
			update EBR;
			EBR.Welcome_Packet_Rep__c=TRUE;
			update EBR;	
			EBR.Welcome_Packet_Rep__c=FALSE;
			update EBR;
			EBR.Welcome_Packet_Rep__c=TRUE;
			update EBR;			
		}*/
		 
	}
	
	public static testMethod void testEBR2() 
	{/*
		
		/*User EBR2 = [select id, Manager_of_Training__c, Email_Banner_Rep__c, Current_Email_Banner_Rep__c,
				Current_Default_Project_Owner__c, Default_Project_Owner__c, FirstName, LastName
				from User where Travel_Financer__c!=false limit 1];
		
		if(EBR2==null)
		{
			EBR2 = [select id, FirstName, LastName from User where Id=:userinfo.getUserId()];
			
			
			EBR2.Email_Banner_Rep__c=TRUE;
			
			update EBR2;
			EBR2.Current_Email_Banner_Rep__c = EBR2.FirstName+' '+EBR2.LastName;
			EBR2.Email_Banner_Rep__c=FALSE;
			update EBR2;
			EBR2.Email_Banner_Rep__c=TRUE;
			update EBR2;
			
		}
		else
		{	
			
			EBR2.Email_Banner_Rep__c=FALSE;
			update EBR2;
			EBR2.Email_Banner_Rep__c=TRUE;
			update EBR2;	
			EBR2.Current_Email_Banner_Rep__c = EBR2.FirstName+' '+EBR2.LastName;
			EBR2.Email_Banner_Rep__c=FALSE;
			update EBR2;
				
		}*/
		 
	}
	
	public static testMethod void testTA() 
	{/*
		User TA = [select id, Manager_of_Training__c, 
				Travel_Arranger__c, Travel_Financer__c,In_charge_of_Printing_Shipping__c
				from User where Travel_Arranger__c!=false limit 1];
				
		TA.Travel_Arranger__c=FALSE;
		update TA;
		TA.Travel_Arranger__c=TRUE;
		update TA;*/
	}
	public static testMethod void testCt() 
	{/*
		User Ct = [select id, Manager_of_Training__c, Click_to_Chat_Specialist__c,
				Travel_Arranger__c, Travel_Financer__c,In_charge_of_Printing_Shipping__c
				from User where Click_to_Chat_Specialist__c!=false limit 1];
				
		Ct.Click_to_Chat_Specialist__c=FALSE;
		update Ct; 
		Ct.Click_to_Chat_Specialist__c=TRUE;
		update Ct;*/
		
		
	}
	public static testMethod void testPS() 
	{/*
		User PS = [select id, Manager_of_Training__c, Click_to_Chat_Specialist__c,
				Travel_Arranger__c, Travel_Financer__c,In_charge_of_Printing_Shipping__c
				from User where In_Charge_of_Printing_Shipping__c!=false limit 1];
				
		PS.In_charge_of_Printing_Shipping__c=FALSE;
		update PS; 
		PS.In_charge_of_Printing_Shipping__c=TRUE;
		update PS;
		
	*/	
	}   
	public static testMethod void testVC() 
	{/*
		User VC = [select id, VinCamera_Assets__c, Manager_of_Training__c, Click_to_Chat_Specialist__c,
				Travel_Arranger__c, Travel_Financer__c,In_charge_of_Printing_Shipping__c
				from User where VinCamera_Assets__c!=false limit 1];
				
		VC.VinCamera_Assets__c=FALSE;
		update VC; 
		VC.VinCamera_Assets__c=TRUE;
		update VC;
		*/
		
	}   

}