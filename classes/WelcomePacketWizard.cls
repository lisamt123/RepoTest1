public class WelcomePacketWizard 
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
        Packet_Complete__c, w.Dealer_Manufacturer_Code_BAC__c, w.Project__c 
        From Welcome_Packet__c w 
        where Id=:System.currentPageReference().getParameters().get('Id') limit 1];
        
                                              
        return welcome;
        
    }
    
    
    
    //PageReferences==============================================
    public PageReference saveQuit()
    {
        update welcome;
        return Page.Welcome_Packet_Save_and_Quit;
    }
    
    
    public PageReference start()
    {
        update welcome;
        return Page.Welcome_Packet_Start_Page;
    }
    
    public PageReference step1() 
    {   
        //Step 1 Bundled 
        if(welcome.Packet_Includes__c!=null)
        {    
            welcome.Jump_to__c = 'CRM Step 1';
            update welcome;
            return Page.Welcome_Packet_Page_1;
        } 
        //Step 1 Picked 
        else if(welcome.Pick_Your_Packet__c!=null)
        {
            //Back
            if(System.currentPageReference().getUrl().contains('page_2'))
            {
                return Page.Welcome_Packet_Page_1;
            }
            //Forward (NOT APPLICABLE)
            else return Page.WelcomePacketNotSetUp;         
        }
        else return Page.WelcomePacketNotSetUp;      
    }
    public PageReference step2() 
    {           
        //Step 2 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'ACCOUNT SET UP FORM (Page 2)'; 
            update welcome;
            return Page.Welcome_Packet_Page_2;
        }
        //Step 2 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_3'))
            {
                if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward
            else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
            {
                welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                update welcome;
                return Page.Welcome_Packet_Page_2;
            }
            else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
            {
                welcome.Jump_to__c = 'INVENTORY';
                update welcome;
                return Page.Welcome_Packet_Page_3;
            }
            else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
            {
                welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                update welcome;
                return Page.Welcome_Packet_Page_4;
            }
            else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
            {
                welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                update welcome;
                return Page.Welcome_Packet_Page_5;
            }
            else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
            {
                welcome.Jump_to__c = 'DMS PUSHING';
                update welcome;
                return Page.Welcome_Packet_Page_6;
            }
            else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
            {
                welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                update welcome;
                return Page.Welcome_Packet_Page_7;
            }
            else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
            {
                welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                update welcome;
                return Page.Welcome_Packet_Page_8;
            }
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
            {
                welcome.Jump_to__c = 'SOLD DATA';
                update welcome;
                return Page.Welcome_Packet_Page_9;
            }
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp; 
    }
    public PageReference step3() 
    {
        //Step 3 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'INVENTORY';
            update welcome;
            return Page.Welcome_Packet_Page_3;
        }        
        //Step 3 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_4'))
            {
                if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else return Page.Welcome_Packet_Start_Page;
            }
            //Forward
            else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
            {
                welcome.Jump_to__c = 'INVENTORY';
                update welcome;
                return Page.Welcome_Packet_Page_3;
            }
            else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
            {
                welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                update welcome;
                return Page.Welcome_Packet_Page_4;
            }
            else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
            {
                welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                update welcome;
                return Page.Welcome_Packet_Page_5;
            }
            else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
            {
                welcome.Jump_to__c = 'DMS PUSHING';
                update welcome;
                return Page.Welcome_Packet_Page_6;
            }
            else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
            {
                welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                update welcome;
                return Page.Welcome_Packet_Page_7;
            }
            else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
            {
                welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                update welcome;
                return Page.Welcome_Packet_Page_8;
            }
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
            {
                welcome.Jump_to__c = 'SOLD DATA';
                update welcome;
                return Page.Welcome_Packet_Page_9;
            }
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        }
        else return Page.WelcomePacketNotSetUp;  
    }   
    public PageReference step4() 
    {
        //Step 4 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'THIRD PARTY EXPORTS';
            update welcome;
            return Page.Welcome_Packet_Page_4;
        }
        
        //Step 4 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_5'))
            {               
                if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward
            else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
            {
                welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                update welcome;
                return Page.Welcome_Packet_Page_4;
            }
            else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
            {
                welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                update welcome;
                return Page.Welcome_Packet_Page_5;
            }
            else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
            {
                welcome.Jump_to__c = 'DMS PUSHING';
                update welcome;
                return Page.Welcome_Packet_Page_6;
            }
            else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
            {
                welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                update welcome;
                return Page.Welcome_Packet_Page_7;
            }
            else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
            {
                welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                update welcome;
                return Page.Welcome_Packet_Page_8;
            }
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
            {
                welcome.Jump_to__c = 'SOLD DATA';
                update welcome;
                return Page.Welcome_Packet_Page_9;
            }
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;  
    }
    public PageReference step5() 
    {
        //Step 5 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'PREDEFINED EXPORTS';
            update welcome;
            return Page.Welcome_Packet_Page_5;
        }
        //Step 5 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_6'))
            {               
                if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward
            else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
            {
                welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                update welcome;
                return Page.Welcome_Packet_Page_5;
            }
            else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
            {
                welcome.Jump_to__c = 'DMS PUSHING';
                update welcome;
                return Page.Welcome_Packet_Page_6;
            }
            else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
            {
                welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                update welcome;
                return Page.Welcome_Packet_Page_7;
            }
            else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
            {
                welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                update welcome;
                return Page.Welcome_Packet_Page_8;
            }
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
            {
                welcome.Jump_to__c = 'SOLD DATA';
                update welcome;
                return Page.Welcome_Packet_Page_9;
            }
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;         
        
    }
    public PageReference step6() 
    {
        //Step 6 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'DMS PUSHING';
            update welcome;
            return Page.Welcome_Packet_Page_6;
        }
        //Step 6 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_7'))
            {               
                if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                {
                    welcome.Jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
                else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward           
            else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
            {
                welcome.Jump_to__c = 'DMS PUSHING';
                update welcome;
                return Page.Welcome_Packet_Page_6;
            }
            else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
            {
                welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                update welcome;
                return Page.Welcome_Packet_Page_7;
            }
            else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
            {
                welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                update welcome;
                return Page.Welcome_Packet_Page_8;
            }
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
            {
                welcome.Jump_to__c = 'SOLD DATA';
                update welcome;
                return Page.Welcome_Packet_Page_9;
            }
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;  
    }
    public PageReference step7() 
    {
        //Step 7 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'ROUTE ONE / DEALERTRACK';
            update welcome;
            return Page.Welcome_Packet_Page_7;
        }
        //Step 7 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_8'))
            {               
                if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
                {
                    welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                    update welcome;
                    return Page.Welcome_Packet_Page_7;
                }
                else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                {
                    welcome.Jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
                else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward           
            else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
            {
                welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                update welcome;
                return Page.Welcome_Packet_Page_7;
            }
            else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
            {
                welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                update welcome;
                return Page.Welcome_Packet_Page_8;
            }
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
            {
                welcome.Jump_to__c = 'SOLD DATA';
                update welcome;
                return Page.Welcome_Packet_Page_9;
            }
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;  
    }
    public PageReference step8() 
    {
        //Step 8 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
            update welcome;
            return Page.Welcome_Packet_Page_8;
        }
        //Step 8 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_9'))
            {               
                if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
                {
                    welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_8;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
                {
                    welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                    update welcome;
                    return Page.Welcome_Packet_Page_7;
                }
                else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                {
                    welcome.Jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
                else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward           
            else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
            {
                welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                update welcome;
                return Page.Welcome_Packet_Page_8;
            }
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
            {
                welcome.Jump_to__c = 'SOLD DATA';
                update welcome;
                return Page.Welcome_Packet_Page_9;
            }
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;  
    }
    public PageReference step9() 
    {
        //Step 9 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'SOLD DATA';
            update welcome;
            return Page.Welcome_Packet_Page_9;
        }
        //Step 9 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_10'))
            {               
                if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
                {
                    welcome.Jump_to__c = 'SOLD DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_9;
                }
                else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
                {
                    welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_8;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
                {
                    welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                    update welcome;
                    return Page.Welcome_Packet_Page_7;
                }
                else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                {
                    welcome.Jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
                else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward           
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
            {
                welcome.Jump_to__c = 'SOLD DATA';
                update welcome;
                return Page.Welcome_Packet_Page_9;
            }
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp; 
    }
    public PageReference step10() 
    {
        //Step 10 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
            update welcome;
            return Page.Welcome_Packet_Page_10;
        }
        //Step 10 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_11'))
            {   
                if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
                {
                    welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_10;
                }           
                else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
                {
                    welcome.Jump_to__c = 'SOLD DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_9;
                }
                else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
                {
                    welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_8;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
                {
                    welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                    update welcome;
                    return Page.Welcome_Packet_Page_7;
                }
                else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                {
                    welcome.Jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
                else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward           
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
            {
                welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                update welcome;
                return Page.Welcome_Packet_Page_10;
            }
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;
    }
    public PageReference step11() 
    {
        //Step 11 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'STANDARD FORMS REQUEST SHEET';
            update welcome;
            return Page.Welcome_Packet_Page_11;
        }
        //Step 11 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_12'))
            {   
                if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
                {
                    welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                    update welcome;
                    return Page.Welcome_Packet_Page_11;
                }
                else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
                {
                    welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_10;
                }           
                else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
                {
                    welcome.Jump_to__c = 'SOLD DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_9;
                }
                else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
                {
                    welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_8;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
                {
                    welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                    update welcome;
                    return Page.Welcome_Packet_Page_7;
                }
                else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                {
                    welcome.Jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
                else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward           
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
            {
                welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                update welcome;
                return Page.Welcome_Packet_Page_11;
            }
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;
    }
    public PageReference step12() 
    {
        //Step 12 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.jump_to__c = 'CUSTOM FORMS';
            update welcome;
            return Page.Welcome_Packet_Page_12;
        }
        //Step 12 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            //Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('page_13'))
            {   
                if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
                {
                    welcome.Jump_to__c = 'CUSTOM FORMS';
                    update welcome;
                    return Page.Welcome_Packet_Page_12;
                }
                else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
                {
                    welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                    update welcome;
                    return Page.Welcome_Packet_Page_11;
                }
                else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
                {
                    welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_10;
                }           
                else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
                {
                    welcome.Jump_to__c = 'SOLD DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_9;
                }
                else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
                {
                    welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_8;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
                {
                    welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                    update welcome;
                    return Page.Welcome_Packet_Page_7;
                }
                else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                {
                    welcome.Jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
                else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward           
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
            {
                welcome.Jump_to__c = 'CUSTOM FORMS';
                update welcome;
                return Page.Welcome_Packet_Page_12;
            }
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                return step13();
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;
    }
    public PageReference step13() 
    {
        //Step 13 Bundled
        if(welcome.Packet_Includes__c!=null)
        {
           /* welcome.jump_to__c = 'Add User List';
            update welcome;
            return Page.Welcome_Packet_Page_13;*/
            update welcome;
            PageReference userEnter = 
            new PageReference('/VINWelcomePackets/Welcome_Packet_User?parentID='+welcome.Id);
            userEnter.setRedirect(True);
            return userEnter;
        }
        //Step 13 Picked
        else if(welcome.Pick_Your_Packet__c != null)
        {           
            /*//Back
            if(System.currentPageReference().getUrl().toLowerCase().contains('complete'))
            {   
                if(welcome.Pick_Your_Packet__c.contains(' User Access'))
                {
                    welcome.Jump_to__c = ' User Access';
                    update welcome;
                    return Page.Welcome_Packet_Page_13;
                }
                else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
                {
                    welcome.Jump_to__c = 'CUSTOM FORMS';
                    update welcome;
                    return Page.Welcome_Packet_Page_12;
                }
                else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
                {
                    welcome.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                    update welcome;
                    return Page.Welcome_Packet_Page_11;
                }
                else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
                {
                    welcome.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_10;
                }           
                else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
                {
                    welcome.Jump_to__c = 'SOLD DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_9;
                }
                else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
                {
                    welcome.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_8;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
                {
                    welcome.Jump_to__c = 'ROUTE ONE / DEALERTRACK';
                    update welcome;
                    return Page.Welcome_Packet_Page_7;
                }
                else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                {
                    welcome.Jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
                else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                {
                    welcome.Jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5;
                }
                else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                {
                    welcome.Jump_to__c = 'THIRD PARTY EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_4;
                }
                else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                {
                    welcome.Jump_to__c = 'INVENTORY';
                    update welcome;
                    return Page.Welcome_Packet_Page_3;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';
                    update welcome;
                    return Page.Welcome_Packet_Page_2;
                }
                else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                {
                    welcome.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';
                    update welcome;
                    return Page.Welcome_Packet_Page_1;
                }
                else
                {
                    update welcome;
                    return Page.Welcome_Packet_Start_Page;
                }
            }
            //Forward           
            else */if(welcome.Pick_Your_Packet__c.contains('Add User List'))
            {
                welcome.Jump_to__c = 'Add User List';
                update welcome;
                Pagereference page13 = new Pagereference('/VINWelcomePackets/Welcome_Packet_User?parentId='+welcome.Id);
                page13.setredirect(true);
                return page13;
            }
            else 
            {
                update welcome;
                return Complete();
            }
        } 
        else return Page.WelcomePacketNotSetUp;
    }
 
 
 
 //WELCOME PACKET USER UPLOAD======================  
    public PageReference uploadUser()
    {
        update welcome;
        return Page.DocumentCreate;
    }
    
    public PageReference confirmCRM()
    {
        if(welcome.Packet_Includes__c!=null)
        {
            welcome.ReachedCRMConfirm__c = true;
            welcome.Jump_to__c = 'Confirmation Page';
            update welcome;
            return Page.Welcome_Packet_Confirm_CRM;
        }
        else 
        {
            update welcome;
            return Complete();
        }
    }   
   
    
    
    
    //JUMP TO=======================================================================
    public PageReference jumpTo()
    {
        if(welcome.Jump_to__c=='ACCOUNT SET UP FORM (Page 1)')
        {
            return step1();
        }
        if(welcome.Jump_to__c=='ACCOUNT SET UP FORM (Page 2)')
        {
            return step2();
        }
        if(welcome.Jump_to__c=='INVENTORY')
        {
            return step3(); 
        }
        if(welcome.Jump_to__c=='THIRD PARTY EXPORTS')
        {
            return step4();
        }
        if(welcome.Jump_to__c=='PREDEFINED EXPORTS')
        {
            return step5();
        }
        if(welcome.Jump_to__c=='DMS PUSHING')
        {
            return step6();
        }
        if(welcome.Jump_to__c=='ROUTE ONE / DEALERTRACK')
        {
            return step7();
        }
        if(welcome.Jump_to__c=='MINIMUM SYSTEM REQUIRMENTS')
        {
            return step8();
        }
        if(welcome.Jump_to__c=='SOLD DATA')
        {
            return step9();
        }
        if(welcome.Jump_to__c=='UNSOLD (CRM) PROSPECT DATA')
        {
            return step10();
        }
        if(welcome.Jump_to__c=='STANDARD FORMS REQUEST SHEET')
        {
            return step11();
        }
        if(welcome.Jump_to__c=='CUSTOM FORMS')
        {
            return step12();
        }
        if(welcome.Jump_to__c=='Add User List')
        {
            return step13();
        }
        if(welcome.Jump_to__c=='Confirmation Page')
        {
            return confirmCRM();
        }
        else return null;
        
    }
    
    public Pagereference skipSteps()
    {
        if(welcome.Jump_to__c=='PREDEFINED EXPORTS'
        ||System.currentPageReference().getUrl().toLowerCase().contains('page_7'))
        {
            if(welcome.Packet_Includes__c!=null)
            {
                if((welcome.Packet_Includes__c.contains('DIY')
                ||welcome.Packet_Includes__c.contains('ILM'))
                &&!welcome.Packet_Includes__c.contains('CRM'))
                {
                    welcome.jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_8; 
                }
                else
                {
                    welcome.jump_to__c = 'DMS PUSHING';
                    update welcome;
                    return Page.Welcome_Packet_Page_6;
                }
            }
            else return step6();
        }
        else if(welcome.Jump_to__c=='MINIMUM SYSTEM REQUIRMENTS'
        ||System.currentPageReference().getUrl().toLowerCase().contains('page_8'))
        {
            if(welcome.Packet_Includes__c!=null)
            {
                if(welcome.Packet_Includes__c.contains('DIY')
                &&!welcome.Packet_Includes__c.contains('CRM')
                &&!welcome.Packet_Includes__c.contains('ILM'))
                {
                    welcome.jump_to__c = 'Add User List';
                    update welcome;                 
                    return step13(); 
                }
                else
                {
                    welcome.jump_to__c = 'SOLD DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_9;
                }
            }
            else return step9();
        }
        else if(welcome.Jump_to__c=='UNSOLD (CRM) PROSPECT DATA'
        ||System.currentPageReference().getUrl().toLowerCase().contains('page_10'))//ILM Skip
        {
            if(welcome.Packet_Includes__c!=null)
            {
                if(welcome.Packet_Includes__c.contains('ILM')
                &&!welcome.Packet_Includes__c.contains('CRM'))
                {
                    welcome.jump_to__c = 'Add User List';
                    update welcome;
                    return step13(); 
                }
                else
                {
                    welcome.jump_to__c = 'STANDARD FORMS REQUEST SHEET';
                    update welcome;
                    return Page.Welcome_Packet_Page_11;
                }
            }
            else return step11();
        }
        else 
        {
            return Page.WelcomePacketNotSetUp;
        }
    }
    public Pagereference skipBackSteps()
    {
        if(welcome.Jump_to__c=='MINIMUM SYSTEM REQUIRMENTS')//DIY & ILM Skipback
        {
            if(welcome.Packet_Includes__c!=null)
            {
                if((welcome.Packet_Includes__c.contains('DIY')
                ||welcome.Packet_Includes__c.contains('ILM'))
                &&!welcome.Packet_Includes__c.contains('CRM'))
                {
                    welcome.jump_to__c = 'PREDEFINED EXPORTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_5; 
                }
                else
                {
                    welcome.jump_to__c = 'ROUTE ONE / DEALERTRACK';
                    update welcome;
                    return Page.Welcome_Packet_Page_7;
                }
            }
            else return step7();
        }       
        else if(welcome.Jump_to__c=='Add User List')
        {
            if(welcome.Packet_Includes__c!=null)
            {
                if(welcome.Packet_Includes__c.contains('DIY')//DIY Skipback
                &&!welcome.Packet_Includes__c.contains('CRM')
                &&!welcome.Packet_Includes__c.contains('ILM'))
                {
                    welcome.jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';
                    update welcome;
                    return Page.Welcome_Packet_Page_8; 
                }
                else if(!welcome.Packet_Includes__c.contains('CRM')//ILM Skipback
                &&welcome.Packet_Includes__c.contains('ILM'))
                {
                    welcome.jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';
                    update welcome;
                    return Page.Welcome_Packet_Page_10; 
                }
                else
                {
                    welcome.jump_to__c = 'CUSTOM FORMS';
                    update welcome;
                    return Page.Welcome_Packet_Page_12;
                }
            }
            else return step12();
        }
        else 
        {
            return Page.Welcome_Packet_Start_Page;
        }
    }
    
    //Get Total=======================================
    
    public double getTotal()
    {
        double total=0.00;
        if(  welcome.Additional_Form_1__c !=null) total+= 200.00; 
        if(  welcome.Additional_Form_2__c !=null) total+=200.00; 
        if(  welcome.Additional_Form_3__c !=null) total+=200.00; 
        if(  welcome.Additional_Form_4__c !=null) total+=200.00; 
        if(  welcome.Additional_Form_5__c !=null)  total+=200.00; 
        if(  welcome.Additional_Form_6__c !=null) total+=200.00;
        return total;
    }
    
    //CANCEL===================================
    public PageReference startPointCheck()
    {
        if(welcome.Packet_Includes__c!=null)
        {
            if(welcome.Packet_Includes__c.contains('CRM')||welcome.Packet_Includes__c.contains('ILM')||welcome.Packet_Includes__c.contains('DIY'))
            {
                return Page.Welcome_Packet_Page_1;
            }
            return Page.WelcomePacketNotSetUp;
        }
        if(welcome.Pick_Your_Packet__c != null)
        {           
            if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 1)')) 
                return Page.Welcome_Packet_Page_1;
            else if(welcome.Pick_Your_Packet__c.contains('ACCOUNT SET UP FORM (Page 2)'))
                return Page.Welcome_Packet_Page_2;
            else if(welcome.Pick_Your_Packet__c.contains('INVENTORY'))
                return Page.Welcome_Packet_Page_3;
            else if(welcome.Pick_Your_Packet__c.contains('THIRD PARTY EXPORTS'))
                return Page.Welcome_Packet_Page_4;
            else if(welcome.Pick_Your_Packet__c.contains('PREDEFINED EXPORTS'))
                return Page.Welcome_Packet_Page_5;
            else if(welcome.Pick_Your_Packet__c.contains('DMS PUSHING'))
                return Page.Welcome_Packet_Page_6;
            else if(welcome.Pick_Your_Packet__c.contains('ROUTE ONE / DEALERTRACK'))
                return Page.Welcome_Packet_Page_7;
            else if(welcome.Pick_Your_Packet__c.contains('MINIMUM SYSTEM REQUIRMENTS'))
                return Page.Welcome_Packet_Page_8;
            else if(welcome.Pick_Your_Packet__c.contains('SOLD DATA'))
                return Page.Welcome_Packet_Page_9;
            else if(welcome.Pick_Your_Packet__c.contains('UNSOLD (CRM) PROSPECT DATA'))
                return Page.Welcome_Packet_Page_10;
            else if(welcome.Pick_Your_Packet__c.contains('STANDARD FORMS REQUEST SHEET'))
                return Page.Welcome_Packet_Page_11;
            else if(welcome.Pick_Your_Packet__c.contains('CUSTOM FORMS'))
                return Page.Welcome_Packet_Page_12;
            else if(welcome.Pick_Your_Packet__c.contains('Add User List'))
                return step13();
            else return Page.WelcomePacketNotSetUp;
        }           
        else 
        {
            return Page.WelcomePacketNotSetUp;
        }
       
    }
       
    
    
    public PageReference Complete()
    {
        User owner = 
        [select Id, Email 
        from User
        where Id=:welcome.OwnerId];
        
        string ownerEmail = owner.Email;
        
        String[] toAddresses = new String[]{ownerEmail};
		Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
		email.setToAddresses(toAddresses);
		email.setWhatId(welcome.Id);		
		email.setSenderDisplayName('VinSolutions Welcome Packets');
        email.setBccSender(false);
        email.setUseSignature(false);
        email.setSaveAsActivity(true);
        email.setSubject('Welcome Packet Complete'); 
        String msg = 'The welcome packet for '+welcome.Account__r.Name+' has been completed.<br/><br/>';       	        
        email.setHtmlBody(msg);
		Messaging.sendEmail(new Messaging.Email[] { email } , TRUE);
        
        welcome.Packet_Complete__c = system.today();
        update welcome;
        
        if(welcome.Project__c!=null)
    	{
	    	SFDC_520_Quote__c project = 
	    	[select id, Date_Packet_Ret_d__c 
	    	from SFDC_520_Quote__c 
	    	where id=: welcome.Project__c];    	
    	
    		project.Date_Packet_Ret_d__c=system.today();
    		update project;
    	}
        return Page.Welcome_Packet_Complete;
    }
    
    public PageReference cancel() 
    {           
        return saveQuit();
    }

    
//=========================SECONDARY=====================================

    //WEBSITE====================================================================
    
    public PageReference secondaryStartPointCheck()
    {
        if(welcome.Secondary_Packet_Includes__c!=null)
        {
            if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('website'))
                return Page.Welcome_Packet_Website_Page_1;
            else if(welcome.Secondary_Packet_Includes__c.toLowerCase().contains('motoblast'))
                return Page.Welcome_Packet_Motoblast;
            else if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('inventory verification'))
                return Page.Welcome_Packet_Inventory_Verification;
            else return Page.Welcome_Packet_Confirm_Website;
        }           
        else 
        {
            return Page.WelcomePacketNotSetUp2;
        }  
    } 
    
    public PageReference jumpToMotoBlast() 
    {        
        if(welcome.Secondary_Packet_Includes__c!=null)
        {   
            if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('motoblast'))
                return Page.Welcome_Packet_Motoblast;           
            else if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('inventory verification'))
                return Page.Welcome_Packet_Inventory_Verification;
            else return Page.Welcome_Packet_Confirm_Website;
        }           
        else 
        {
            return Page.WelcomePacketNotSetUp2;
        }  
        
    }
    
    public PageReference jumpToInventoryVerification()
    {        
        update welcome;
        if(welcome.Secondary_Packet_Includes__c!=null)
        {               
            if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('inventory verification'))
                return Page.Welcome_Packet_Inventory_Verification;
            else return Page.Welcome_Packet_Confirm_Website;
        }           
        else 
        {
            return Page.WelcomePacketNotSetUp2;
        }  
    }
    
    public PageReference jumpBackFromConfirm()
    {        
        update welcome;
        if(welcome.Secondary_Packet_Includes__c!=null)
        {               
            if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('inventory verification'))
                return Page.Welcome_Packet_Inventory_Verification;
            else if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('motoblast'))
                return Page.Welcome_Packet_MotoBlast;
            else if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('website'))
                return Page.Welcome_Packet_Website_Page_1;
            else return Page.Welcome_Packet_Website_Start_Page;
        }           
        else 
        {
            return Page.WelcomePacketNotSetUp2;
        }  
    }
    
    public PageReference jumpBackFromInventory()
    {        
        update welcome;
        if(welcome.Secondary_Packet_Includes__c!=null)
        {               
            if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('motoblast'))
                return Page.Welcome_Packet_MotoBlast;
            else if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('website'))
                return Page.Welcome_Packet_Website_Page_1;
            else return Page.Welcome_Packet_Website_Start_Page;
        }           
        else 
        {
            return Page.WelcomePacketNotSetUp2;
        }  
    }
    
     public PageReference jumpBackFromMotoBlast()
     {        
        update welcome;
        if(welcome.Secondary_Packet_Includes__c!=null)
        {               
            if(welcome.Secondary_Packet_Includes__c.tolowercase().contains('website'))
                return Page.Welcome_Packet_Website_Page_1;
            else return Page.Welcome_Packet_Website_Start_Page;
        }           
        else 
        {
            return Page.WelcomePacketNotSetUp2;
        }  
    }
    
    public PageReference jumpBackFromWebsite()
     {        
        update welcome;
        if(welcome.Secondary_Packet_Includes__c!=null)
            return Page.Welcome_Packet_Website_Start_Page;
        else 
            return Page.WelcomePacketNotSetUp2;        
    }
    
    public PageReference saveQuitWeb()
    {
        update welcome;
        return Page.Welcome_Packet_Save_and_Quit_Sec;
    }
    
    
    public PageReference confirmWebsite()
    {
        welcome.ReachedWebConfirm__c = true;
        update welcome;
        return Page.Welcome_Packet_Confirm_Website; 
    }
    
    public PageReference secondaryComplete()
    {
        update welcome;
        return Page.Welcome_Packet_Secondary_Complete;
    }
    
    
    
 
    
    
    
    
    
    
    
    
    


}