public class WebsitePacket 
{
    public Account account;
    public Welcome_Packet__c welcome;
    
    
        
    //Get records=====================================================  
    public Account getAccount() 
    {
        if(account == null) account = new Account();
        return account;
    }   
   
       
    public Welcome_Packet__c getWelcome() 
    {        
        if(welcome == null) welcome = 
        [Select w.DO_NOT_EXPORT_INVENTORY_TO_LEAD_PROVIDER__c, w.how_sold_data_will_be_acquired__c, w.Zip_Code__c, 
        w.X__c, w.X3_Used_Stock__c, w.X3_Used_Selling_Price__c, w.X3_Used_Internet_Price__c, w.X3_Used_Cost__c, 
        w.X3_New_Selling_Price__c, w.X3_New_Internet_Price__c, w.X3_New_Cost__c, w.X2_Used_Stock__c, 
        w.X2_Used_Selling_Price__c, w.X2_Used_Internet_Price__c, w.X2_Used_Cost__c, w.X2_New_Stock__c, 
        w.X2_New_Selling_Price__c, w.X2_New_Internet_Price__c, w.X2_New_Cost__c, w.X1_Used_Stock__c, 
        w.X1_Used_Selling_Price__c, w.X1_Used_Internet_Price__c, w.X1_Used_Cost__c, w.X1_New_Stock__c, 
        w.X1_New_Selling_Price__c, w.X1_New_Cost__c, w.X1_NEw_Internet_Price__c, 
        w.Will_you_need_VinSolutions_to_host_email__c, w.Wholesale__c, w.Wednesday_Open__c, w.Wednesday_Close__c, 
        w.Website_to_be_transferred__c, w.Web_Address__c, w.VS_ID__c, w.Username_to_registrar__c, 
        w.Type_of_network_Connection_building_5__c, w.Type_of_network_Connection_building_4__c, 
        w.Type_of_network_Connection_building_3__c, w.Type_of_network_Connection_building_2__c, 
        w.Tuesday_Open__c, w.Tuesday_Close__c, w.Trim_Level__c, w.Total__c, w.Time_Zone__c, w.Thursday_Open__c, 
        w.Thursday_Close__c, w.Technical_Contact_Phone_Number__c, w.Technical_Contact_Name__c, w.SystemModstamp, 
        w.Sunday_Open__c, w.Sunday_Close__c, w.State__c, w.Standard_Forms__c, w.Shipping_Zip_Code__c, 
        w.Shipping_State__c, w.Shipping_Contact_Name__c, w.Shipping_City__c, w.Shipping_Address__c, w.Selling_Price__c, 
        w.Secondary_Contact__c, w.Secondary_Contact_Phone__c, w.Secondary_Contact_Email__c, 
        w.Secondary_Contact_Access__c,w.Saturday_Open__c, w.Saturday_Close__c, 
        w.Registrar_to_transfer_to__c, w.Primary_Contact__c, 
        w.Primary_Contact_Phone__c, w.Primary_Contact_Email__c, w.Primary_Contact_Access__c, w.Predefined_Exports__c, 
        w.Secondary_Contact_Position__c, w.Primary_Contact_Position__c, 
        w.Photo_s_on_a_daily_recurring_basis__c, w.Photo_s_for_Initial_Setup__c, 
        w.Phone_Number__c, w.Password_to_registrar__c, w.OwnerId, w.Other__c, w.Number_of_new_PC_s_to_be_added__c, 
        w.Number_of_existing_PC_s_for_MotoSnap__c, w.Number_of_existing_Network_Printers__c, 
        w.Number_of_Salespersons_using_MotoSnap__c, w.Number_of_Network_Printers_to_be_added__c, 
        w.Number_of_Managers_using_MotoSnap__c, w.Number_of_F_I_persons_using_MotoSnap__c, w.Number_of_Buildings__c, 
        w.Name, w.Monday_Open__c, w.Monday_Close__c, w.Model_Number__c, w.LastModifiedDate, w.LastModifiedById, 
        w.LastActivityDate, w.Is_your_Dealership_setup_with_Route_One__c, w.Is_your_Dealership_setup_w_DealerTrack__c, 
        w.Is_this_person_a_dealership_employee__c, w.IsDeleted, w.Inventory_Verification__c,
        w.Inventory_Data_on_Daily_recurring_basis__c, w.Inventory_Data_for_Initial_Setup__c, w.Internet_Price__c, 
        w.Interior_Color_Code__c, w.If_not_who_do_they_work_for__c, w.Id, w.House_Deals__c, w.Friday_Open__c, 
        w.Friday_Close__c, w.Fax_Number__c, w.Exterior_Color_Code__c, w.Enable_stock_photos__c, 
        w.Enable_color_matched_stock_photos__c, w.Dealership_Name__c, w.Dealer_Trades__c, w.Dealer_Name__c, w.Date__c, 
        w.DMS_to_exclude4__c, w.DMS_to_exclude3__c, w.DMS_to_exclude2__c, w.DMS_to_exclude1__c, w.Custom_Form_3__c, 
        w.Custom_Form_2__c, w.Custom_Form_1__c, w.Current_Web_Host__c, w.Current_Web_Browser__c, w.Current_Registrar__c, 
        w.Current_Operating_System__c, w.Current_Dealer_Specialties_Client__c, w.CreatedDate, w.CreatedById, 
        w.Cost_for_commissionable_gross__c, w.Contract_End_Date__c, w.ConnectionSentId, w.ConnectionReceivedId, 
        w.City__c, w.Certification__c, w.Certification_Flag__c,  w.Building_Location_Address__c,
        w.Auto_Trader_Username__c, w.Auto_Trader_Password__c, 
        w.Are_all_the_Buildings_in_the_same_lot__c, w.All_Route_One_Dealer_ID_s__c, w.Address__c, w.Additional_Form_6__c, 
        w.Additional_Form_5__c, w.Additional_Form_4__c, w.Additional_Form_3__c, w.Additional_Form_2__c, 
        w.Additional_Form_1__c,w.RecordType.Name, w.Packet_Includes__c, w.RecordTypeId ,w.Account__r.ConnectionSentId, 
        w.Account__r.ConnectionReceivedId, w.Account__r.LastActivityDate, w.Account__r.SystemModstamp, 
        w.Account__r.LastModifiedById, w.Account__r.LastModifiedDate, w.Account__r.CreatedById, w.Account__r.CreatedDate, 
        w.Account__r.OwnerId, w.Account__r.Description, w.Account__r.NumberOfEmployees, w.Account__r.AnnualRevenue, 
        w.Account__r.Industry, w.Account__r.Website, w.Account__r.Fax, w.Account__r.Phone, w.Account__r.ShippingCountry, 
        w.Account__r.ShippingPostalCode, w.Account__r.ShippingState, w.Account__r.ShippingCity, 
        w.Account__r.ShippingStreet,w.Account__r.BillingCountry, w.Account__r.BillingPostalCode, 
        w.Account__r.BillingState, w.Account__r.BillingCity, w.Account__r.BillingStreet, w.Account__r.ParentId, 
        w.Account__r.Type, w.Account__r.Name, w.Account__r.MasterRecordId,w.Account__r.IsDeleted, w.Account__r.Id, 
        w.Account__c, w.Jump_to__c, w.Jump_to_formula__c, w.Welcome_Packet_URL__c,w.Building_Number_1_2_3_etc__c, 
        w.Building_Description_Main_Used_Etc__c, w.ReachedCRMConfirm__c, w.ReachedWebConfirm__c, 
        w.Including_Excluding_certain_vehicles__c, w.X3_New_Stock__c, w.additional_inventory_feeds__c, w.Secondary_Packet_Includes__c,
        w.secondary_welcome_packet_URL__c, w.Vehicle_Make__c, w.Vehicle_Model__c, w.Vehicle_Year__c, w.Vehicle_Trim_if_entered_in_DMS__c,
        w.Vehicle_Color_interior__c,w.Vehicle_Color_exterior__c, w.Lot_Price_Field__c, w.Web_Price_Field__c, w.Cost_Price_Field__c,
        Color_Preferences__c, Sales_Phone__c, Internet_Sales_Phone__c,Parts_Phone__c,Service_Phone__c,Body_Shop_Phone__c,
        Other_Phone__c,Physical_Address__c,Sales_Hours__c,Parts_Service_Hours__c,Facebook_URL__c, YouTube_Channel_URL__c, 
        Blogger_URL__c, Myspace_URL__c, Ning_URL__c, Twitter_URL__c, live_chat__c, Check_To_Upload_Graphics_Custom_Content__c,
        Comments_on_header_layout__c, Pick_Your_Packet__c, w.Orphaned_Prospects__c, (Select Id, OwnerId, IsDeleted, Name, 
        CreatedDate, CreatedById, LastModifiedDate, LastModifiedById, SystemModstamp, LastActivityDate, 
        ConnectionReceivedId, ConnectionSentId, First_Name__c, Welcome_Packet__c, DMS_ID__c, Email__c, Receive_Leads__c, 
        Receive_Orphans__c, Access__c, Day_s_Off__c, Position__c, Inventory_Access__c From WelcomePacketUsers__r), 
        Website_Packet_Url__c, w.Main_Menu_Bar_Tab_Selections__c,w.Select_Specials_Tab_Features__c, 
        w.Select_Service_Tab_Features__c, w.Select_Research_Section_Tab_Features__c, 
        w.Select_Pre_Owned_Inventory_Features__c, w.Select_Parts_Tab_Features__c, w.Select_New_Inventory_Tab_Features__c,
        w.Select_Hours_and_Locations_Tab_Features__c, w.Select_Financing_Tab_Features__c, 
        w.Select_Dealer_Information_Tab_Features__c, w.Select_Certified_Inventory_Tab_Features__c, 
        w.URL_s_of_Other_Dealerships_to_Link_to__c, w.Select_Parts_Service_Tab_Features__c, w.Search_by_Brand_5_links_preferred__c,
        w.Search_Quick_Links_5_links_preferred__c, Number_of_Selected_Menus__c
        From Welcome_Packet__c w 
        where Id=:System.currentPageReference().getParameters().get('Id') limit 1];        
                                              
        return welcome;        
    }


//=======================WEBSITE PACKET===================================
  public PageReference cancel()
  {
    update welcome;
    return Page.WebsitePacketSaveQuit;
  }
  
  public PageReference backToStart()
  {
    update welcome;
    return Page.WebsitePacketStart;
  }
    
  public PageReference toPage1()
  {
    if(welcome != null)
    update welcome;
    return Page.WebsitePacketPage1;
  }
 
  public PageReference toPage1x5()
  {     
    
    if(welcome.Check_To_Upload_Graphics_Custom_Content__c==true)
    {
        update welcome;
        PageReference uploadGraphics = new PageReference('/WebsitePacketPage1x5?parentId='+welcome.id);
        uploadGraphics.setRedirect(true);
        return uploadGraphics;
    }
    else 
    {
        if(System.currentPageReference().getUrl().toLowerCase().contains('page2'))
        {
            update welcome;
            return toPage1();
        }
        else return toPage2();
    }
  } 
  
  public PageReference toPage2()
  {
    update welcome;
    return Page.WebsitePacketPage2;
  } 
  
  public PageReference toPage3()
  {
  	update welcome;
  	return Page.WebsitePacketPage3;
  }
  
  public PageReference toPage4()
  {
  	update welcome;
  	return Page.WebsitePacketPage4;
  }
  
  public PageReference complete()
  {
    update welcome;
    return Page.WebsitePacketComplete;
  }
  
  public PageReference goBack()
  {
  	update welcome;
  	  	
  	if(System.currentPageReference().getUrl().toLowerCase().contains('page4'))
  	{
  		return toPage3(); 
  	}
  	else if(System.currentPageReference().getUrl().toLowerCase().contains('page3'))
  	{
  		return toPage2();
  	}
  	else if(System.currentPageReference().getUrl().toLowerCase().contains('page2'))
  	{
  		if(welcome.Check_To_Upload_Graphics_Custom_Content__c==true)
  		{
  			return toPage1x5();
  		}
  		else return toPage1();
  	}
  	else return backToStart();
  }
  
  
}