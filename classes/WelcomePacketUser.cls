public with sharing class WelcomePacketUser 
{

	public List<Welcome_Packet_User__c> user {get; set;}
	public string removeId {get; set;}
	
    
    public WelcomePacketUser(){
        
        user = /*new LIST<Welcome_Packet_User__c>();//*/ [Select 
        w.Welcome_Packet__c, w.User_Created_In_MotoSnap__c, w.SystemModstamp, 
        w.Receive_Orphans__c, w.Receive_Leads__c, w.Position__c, w.OwnerId, 
        w.Name, w.LastModifiedDate, w.LastModifiedById, w.LastActivityDate, 
        w.IsDeleted, w.Inventory_Access__c, w.Id, w.First_Name__c, 
        w.Email__c, w.Day_s_Off__c, w.DMS_ID__c, w.CreatedDate, 
        w.CreatedById, w.ConnectionSentId, w.ConnectionReceivedId, w.Access__c 
        From Welcome_Packet_User__c w where Welcome_Packet__c =: parentId];
        
       	if (user == null)
       	user.add(new Welcome_Packet_User__c());

    }
    
    public void addrow(){
        user.add(new Welcome_Packet_User__c());
    
    }
    
    public LIST<Welcome_Packet_User__c> getUser()
    {
    	return user;
    }
    
    /*public string getRemoveId()
    {
    	return removeId;
    }  
    
    public void removerow(){
   		integer i = 0;
   		
   		for (Welcome_Packet_User__c thisRemovedUser: user)
   		{
   			if (thisRemovedUser.Id == removeId) user.remove(i);
   			i++;
   		}
    	
    }*/
    
    string parentId = System.currentPageReference().getParameters().get('parentId').substring(0,15);
    
    public PageReference save()
    {
        LIST<Welcome_Packet_User__c> insertUsers = new LIST<Welcome_Packet_User__c>();
        for(Welcome_Packet_User__c users:user)
        {        	
        	if(users.Name!=null)
        	{
        		users.Welcome_Packet__c = parentId;
        		insertUsers.add(users);
        	}        	
        }
        upsert insertUsers;
        
        Welcome_Packet__c welcome =
    	[select id, Project__c, Packet_Includes__c, Pick_Your_Packet__c, User_List_Finalized__c
    	from Welcome_Packet__c 
    	where id=: parentId];
    	
    	   	
    	//set the checkbox to reflect what the dealer decides 
    	//about the completion status of the User List
    	if(welcome.Project__c!=null)
    	{
	    	SFDC_520_Quote__c project = 
	    	[select id, User_List_Finalized__c 
	    	from SFDC_520_Quote__c
	    	where id=: welcome.Project__c];    	
	    	project.User_List_Finalized__c=false;
	    	
	    	update project;
    	}
	    	
    	welcome.User_List_Finalized__c=false;
    	update welcome;
    	
    	
    	
    	PageReference home = new PageReference('/WelcomePacketNotSetUp');
    	
    	if(welcome.Packet_Includes__c!=null)home = 
    	new PageReference('/VINWelcomePackets/Welcome_Packet_Confirm_CRM?id='+parentId);
        
        else if(welcome.Pick_Your_Packet__c!=null)home = 
        new PageReference('/Welcome_Packet_Complete');
        
        
        home.setRedirect(true);
        return home;
    }
    
    public PageReference saveUserListComplete()
    {
        LIST<Welcome_Packet_User__c> insertUsers = new LIST<Welcome_Packet_User__c>();
        for(Welcome_Packet_User__c users:user)
        {        	
        	if(users.Name!=null)
        	{
        		users.Welcome_Packet__c = parentId;
        		insertUsers.add(users);
        	}        	
        }
        insert insertUsers;
        
        Welcome_Packet__c welcome =
    	[select id, Project__c, Packet_Includes__c, Pick_Your_Packet__c, User_List_Finalized__c 
    	from Welcome_Packet__c 
    	where id=: parentId];
    	
    	   	
    	//set the checkbox to reflect what the dealer decides 
    	//about the completion status of the User List
    	if(welcome.Project__c!=null)
    	{    		
	    	SFDC_520_Quote__c project = 
	    	[select id, User_List_Finalized__c 
	    	from SFDC_520_Quote__c
	    	where id=: welcome.Project__c];    	
	    	project.User_List_Finalized__c=true;
	    	update project;
    	}
    	
    	welcome.User_List_Finalized__c=true;
    	update welcome;
    	
    	PageReference home = new PageReference('/WelcomePacketNotSetUp');
    	
    	if(welcome.Packet_Includes__c!=null)home = 
    	new PageReference('/VINWelcomePackets/Welcome_Packet_Confirm_CRM?id='+parentId);
        
        else if(welcome.Pick_Your_Packet__c!=null)home = 
        new PageReference('/Welcome_Packet_Complete');
        
        
        home.setRedirect(true);
        return home;
    }
    
    
    public PageReference goBack()
    {
    	PageReference back = new PageReference('/WelcomePacketNotSetUp?id='+parentId);
    	
    	Welcome_Packet__c welcome =
    	[select id, Project__c, Packet_Includes__c, Pick_Your_Packet__c 
    	from Welcome_Packet__c 
    	where id=: parentId];
    	if(welcome.Packet_Includes__c!=null)
    	{
    		if(welcome.Packet_Includes__c.contains('CRM'))
    		{
    			back = new Pagereference('/Welcome_Packet_Page_12?id='+welcome.Id);
    		}
    		else if(welcome.Packet_Includes__c.contains('ILM'))
    		{
    			back = new Pagereference('/Welcome_Packet_Page_10?id='+welcome.Id); 
    		}   		
    		else if(welcome.Packet_Includes__c.contains('DIY'))
    		{
    			back = new Pagereference('/Welcome_Packet_Page_8?id='+welcome.Id);
    		}
    	}
    	else if(welcome.Pick_Your_Packet__c!=null)
    	{
    		Pagereference page = new Pagereference('');
    		/*if(welcome.Pick_Your_Packet__c.contains('Add User List'))
			{
    			welcome.Jump_to__c = 'Add User List';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_User?parentId='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_13;
			}
    		else */if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
			{
    			welcome.Jump_to__c = 'CUSTOM FORMS';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_12?Id='+welcome.Id);
        		page.setredirect(true);
    			return page; //Page.Welcome_Packet_Page_12;
			}
    		else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
			{
				welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_11?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_11;
			}
    		else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
			{
    			welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_10?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_10;
			}     		
    		else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
			{
    			welcome.Jump_to__c = 'SOLD DATA';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_9?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_9;
			}
    		else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
			{
    			welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_8?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_8;
			}
    		else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
			{
    			welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_7?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_7;
			}
    		else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
			{
    			welcome.Jump_to__c = 'DMS PUSHING';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_6?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_6;
			}
    		else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
			{
    			welcome.Jump_to__c = 'PREDEFINED EXPORTS';
        		update welcome;
        		page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_5?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_5;
			}
    		else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
			{
    			welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
    			update welcome;
    			page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_4?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_4;
			}
    		else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
    		{
    			welcome.Jump_to__c = 'INVENTORY';
				update welcome;
				page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_3?Id='+welcome.Id);
        		page.setredirect(true);
				return page;//Page.Welcome_Packet_Page_3;
    		}
    		else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
    		{
    			welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
				update welcome;
				page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_2?Id='+welcome.Id);
        		page.setredirect(true);
				return page;//Page.Welcome_Packet_Page_2;
    		}
			else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
			{
    			welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
				update welcome;
				page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_1?Id='+welcome.Id);
        		page.setredirect(true);
    			return page;//Page.Welcome_Packet_Page_1;
			}
			else
			{
				update welcome;
				page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Page_Start_Page?Id='+welcome.Id);
        		page.setredirect(true);
				return page;//Page.Welcome_Packet_Start_Page;
			}
    	}
    	else back = new Pagereference('/WelcomePacketNotSetUp?id='+welcome.Id);
    	back.setRedirect(true);
        return back;
    }
    
    public pageReference Skip()
    {
    	Welcome_Packet__c packet =
    	[select id, Project__c, Packet_Includes__c, Pick_Your_Packet__c 
    	from Welcome_Packet__c 
    	where id=: parentId];
    	
    	Pagereference page = new Pagereference('/VINWelcomePackets/WelcomePacketNotSetUp');
    	if(packet.Project__c!=null)
    	{
	    	SFDC_520_Quote__c project = 
	    	[select id, Date_Packet_Ret_d__c 
	    	from SFDC_520_Quote__c 
	    	where id=: packet.Project__c];    	
    	
    		project.Date_Packet_Ret_d__c=system.today();
    		update project;
    	}
    	if(packet.Pick_Your_Packet__c!=null)
    	{
    		 page = new Pagereference('/VINWelcomePackets/Welcome_Packet_Complete?Id='+packet.Id);    		
    	}
    	
    	else if(packet.Packet_Includes__c!=null)
    	{
	    	page = new PageReference('/VINWelcomePackets/Welcome_Packet_Confirm_CRM?Id='+packet.Id);
    	}
    	
    	page.setredirect(true);
    	return page;
    }   



}