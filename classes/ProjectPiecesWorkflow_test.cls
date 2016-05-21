@isTest
private class ProjectPiecesWorkflow_test {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
    }
    
    public static testMethod void TestDefaultIssues()
	{	
		
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
                       	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
        //Ac.Territory_State__c = TS.Id;
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getuserId();
		insert Pro;
				
		Project_Piece__c A = new Project_Piece__c();
		A.Project__c = Pro.Id;
		A.Project__c = Pro.Id;
		A.Piece_Issue__c = 'TestPiece - Sticker';
		A.Name = 'VinSticker';
		A.RecordTypeId = '012700000005e2u';//Default Issues
		insert A;
		A.Contact_Made__c = System.today();
		update A;
		A.Contact_Made__c = null;
		A.Project_Piece_Stage__c = 'completed';
		update A;
		//Reset Fields
		A.Project_Piece_Stage__c = 'Introduction';
		A.Contact_Made__c = null;
		A.Requirements_Gathered__c = null;
		A.Design_Completed__c = null;
		A.Proof_Approved__c = null;
		A.Uploaded_Printed_Shipped__c = null;
		update A;
	}	
//======Creative Tasks====================================
	public static testMethod void TestCreativev()
	{	
		
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
		
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
               	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
        //Ac.Territory_State__c = TS.Id;
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c A = new Project_Piece__c();
		A.Project__c = Pro.Id;
		A.Piece_Issue__c = 'TestPiece - Sticker';
		A.Name = 'test';
		A.RecordTypeId = '012700000005e2u';//Creative
		insert A;
		A.Contact_Made__c = system.today();
		update A;
		A.Contact_Made__c = null;
		update A;
		//----------------------------
		A.Requirements_Gathered__c = system.today();
		update A;
		
		A.Project_Piece_Stage__c = 'introduction';	
		A.Contact_Made__c = null;
		A.Requirements_Gathered__c = null;
		update A;//reset
		//-----------------------------
		A.Design_Completed__c = system.today();
		update A;
		
		A.Project_Piece_Stage__c = 'introduction';
		A.Contact_Made__c = null;
		A.Requirements_Gathered__c = null;
		A.Design_Completed__c = null;
		update A;//reset
		//---------------------------------------
		A.Quality_Assurance__c = system.today();
		update A;
		
		//------------------------------------------	
		A.Project_Piece_Stage__c = 'Completed';
		update A;
		
		A.Project_Piece_Stage__c = 'introduction';
		A.Contact_Made__c = null;
		A.Requirements_Gathered__c = null;
		A.Design_Completed__c = null;
		A.Proof_Approved__c = null;
		A.Uploaded_Printed_Shipped__c = null;
		
		A.name = 'sticker';
		update A;//reset
		
		//A.Project_Piece_Stage__c = 'Completed';
		//update A;
	}
	public static testMethod void Testnext()
	{	
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
		
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
               	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
       // Ac.Territory_State__c = TS.Id;
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c A = new Project_Piece__c();
		A.Project__c = Pro.Id;
		A.Piece_Issue__c = 'TestPiece - Sticker';
		A.Name = 'VinSticker';
//========================================================
		
		A.RecordTypeId = '012700000005e2u';
		insert A;
		update A;
		A.RecordTypeId = '012700000005e2u';
		update A;
		A.RecordTypeId = '012700000005e2u';
		update A;
//==============CLICK TO CHAT TESTS
		A.RecordTypeId = '012700000005e2u';//Click-to-Chat
		update A;
		A.Start_Process__c=system.today();
		update A;
		A.Requirements_Gathered__c = system.today();
		update A;
		A.Code_Request_Made__c = system.today();
		update A;
		A.Code_Implemented__c = system.today();
		update A;
		A.Start_Process__c=null;
		A.Requirements_Gathered__c = null;
		A.Code_Request_Made__c = null;
		A.Code_Implemented__c = null;
		update A;
		
	}
	public static testMethod void Testnext2()
	{	
		
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
		
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
               	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
       // Ac.Territory_State__c = TS.Id;
        
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c A = new Project_Piece__c();
		A.Project__c = Pro.Id;
		A.Piece_Issue__c = 'TestPiece - Sticker';
		A.Name = 'VinSticker';
		/**/A.Requirements_Gathered__c = system.today();
		
		insert A;
		A.Start_Process__c=null;
		A.Requirements_Gathered__c = null;
		update A;
		A.Code_Request_Made__c = system.today();
		update A;
		A.Start_Process__c=null;
		A.Requirements_Gathered__c = null;
		A.Code_Request_Made__c = null;
		update A;
		A.Code_Implemented__c = system.today();
		update A;
		A.Start_Process__c=null;
		A.Requirements_Gathered__c = null;
		A.Code_Request_Made__c = null;
		A.Code_Implemented__c = null;
		A.Project_Piece_Stage__c = 'Introduction';
		update A;/**/
		A.Project_Piece_Stage__c = 'Completed';
		update A;
		
	}	
//======================================================

//Hardware Testing=========================================
	public static testMethod void TestScanner()
	{
		
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
		
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
               	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
        //Ac.Territory_State__c = TS.Id;
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c A = new Project_Piece__c();
		A.Project__c = Pro.Id;
		A.Piece_Issue__c = 'scanner';
		A.Name = 'scanner';
		A.RecordTypeId = '012700000005e2u';//Hardware
		insert A;
		A.Project_Piece_Stage__c = 'Completed';
		update A;
		
		A.Start_Process__c = null;
		A.Hardware_Set_Up__c = null;
		A.Printed__c = FALSE;
		A.Shipped__c = FALSE;
		update A;
					
		A.Start_Process__c = system.today();
		update A;
		A.Hardware_Set_Up__c = system.today();
		update A;
	}
	public static testMethod void TestVinCamera()
	{	
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
			
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
               	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
       // Ac.Territory_State__c = TS.Id;
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c A = new Project_Piece__c();
		A.Project__c = Pro.Id;
		A.Piece_Issue__c = 'vincamera';
		A.Name = 'vincamera';
		A.RecordTypeId = '012700000005e2u';//Hardware
		insert A;
		A.Project_Piece_Stage__c = 'Completed';
		update A;
			
		
//============================================================		
		
		
		A.RecordTypeId = '012700000005e2u';
		update A;
	}
//==========Shipping Tests===========================================
	public static testMethod void TestShipping()
	{	
		
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
			
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
               	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
        //Ac.Territory_State__c = TS.Id;
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c A = new Project_Piece__c();
		A.Project__c = Pro.Id;
		A.Piece_Issue__c = 'TestPiece - Sticker';
		A.Name = 'VinSticker';
		A.RecordTypeId = '012700000005e2u';//Shipping
		A.Project_Piece_Stage__c = 'Introduction';
		insert A;
	
		A.Printed__c = true;
		update A;
		A.Shipped__c = true;
		update A;
		
		A.Printed__c = false;
		A.Date_Printed__c = null;
		A.Shipped__c = false;
		A.Date_Shipped__c = null;
		A.Project_Piece_Stage__c = 'Printing/Shipping/Upload';
		update A;//reset
		A.Project_piece_stage__c = 'Completed';
		update A;
	}
	public static testmethod void shipping()
	{
		
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
			
		Account A = new Account();
		A.BillingState = 'KS';
		A.Name = 'test'; 
		A.AccountNumber = '1';
		A.BillingCity = 'test';
        A.BillingCountry = 'USA';
        A.BillingPostalCode = '66212';
        A.BillingState = 'KS';
        A.BillingStreet = '1234';
               	A.ShippingCity = 'test';
	        A.ShippingCountry = 'USA';
	        A.ShippingPostalCode = '66212'; 
	        A.ShippingState = 'KS';
	        A.ShippingStreet = '1234';
        //A.Territory_State__c = TS.Id;
		insert A;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = A.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = A.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c B = new Project_Piece__c();
		B.Project__c = Pro.Id;
		B.Piece_Issue__c = 'guide';
		B.Name = 'guide';
		B.RecordTypeId = '012700000005e2u';//Shipping
		B.Project_Piece_Stage__c = 'Introduction';
		insert B;
	
		B.Printed__c = true;
		update B;
		B.Shipped__c = true;
		update B;
		
		B.Printed__c = false;
		B.Date_Printed__c = null;
		B.Shipped__c = false;
		B.Date_Shipped__c = null;
		B.Project_Piece_Stage__c = 'Printing/Shipping/Upload';
		update B;//reset
		B.Project_piece_stage__c = 'Completed';
		update B;
	
//========================================================


		//A.RecordTypeId = '012700000005e3T';
		//update A;
//========================================================
	}

//==============Implementation Custom Form Design Testing
	public static testMethod void TestCustomFormDesign()
	{	
		
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
			
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
               	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
        //Ac.Territory_State__c = TS.Id;
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c A = new Project_Piece__c();
		A.Project__c = Pro.Id;
		A.Piece_Issue__c = 'TestPiece - Sticker';
		A.Name = 'VinSticker';
		A.RecordTypeId = '012700000005e2u';//Implementation - Custom Form Design
		A.Project_Piece_Stage__c = 'Introduction';
		insert A;
		A.Project_Piece_Stage__c = 'Completed';
		update A;
//==============================================
		update A;
		A.RecordTypeId = '012700000005e2u';
		update A;
		A.RecordTypeId = '012700000005e2u';
		update A;
		A.RecordTypeId = '012700000005e2u';
		update A;
		
//====================================================VinVideo TESTING
		Project_Piece__c V = new Project_Piece__c();
		V.RecordTypeId = '012700000005e2u';
		V.Project__c = Pro.Id;
		V.Piece_Issue__c = 'VinVideos';
		V.Name = 'VinVideo';
		V.Project_Piece_Stage__c = 'Introduction';
		insert V;
		V.Start_Process__c = system.today();
		update V;
		//V.VinVideos_Enabled__c = system.today();
		//update V;
	}
	public static testmethod void testCredit()
	{
//====================================================700 Credit TESTING
		/*Territory_State__c TS = new Territory_State__c();
  		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();	
        TS.Website_Manager__c = userInfo.getUserId();	
		insert TS;*/
		
			
		Account Ac = new Account();
		Ac.BillingState = 'KS';
		Ac.Name = 'test'; 
		Ac.AccountNumber = '1';
		Ac.BillingCity = 'test';
        Ac.BillingCountry = 'USA';
        Ac.BillingPostalCode = '66212';
        Ac.BillingState = 'KS';
        Ac.BillingStreet = '1234';
               	Ac.ShippingCity = 'test';
	        Ac.ShippingCountry = 'USA';
	        Ac.ShippingPostalCode = '66212'; 
	        Ac.ShippingState = 'KS';
	        Ac.ShippingStreet = '1234';
        //Ac.Territory_State__c = TS.Id;
		insert Ac;
		
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'Hardware';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c X = new Project_Piece__c();
		X.RecordTypeId = '012700000005e2u';
		X.Project__c = Pro.Id;
		X.Piece_Issue__c = '700 Credit';
		X.Name = '700 Credit';
		X.Project_Piece_Stage__c = 'Introduction';
		insert X;
		X.Start_Process__c = system.today();
		update X;
		X.Information_Gathered__c = system.today();
		update X;
		X.Configuration_Complete__c = system.today();
		update X;
		X.Accuracy_Confirmed__c = system.today();
		update X;
		
//====================================================AIS Rebates TESTING
		Project_Piece__c Y = new Project_Piece__c();
		Y.RecordTypeId = '012700000005e2u';
		Y.Project__c = Pro.Id;
		Y.Piece_Issue__c = 'AIS Rebate';
		Y.Name = 'AIS Rebate';
		Y.Project_Piece_Stage__c = 'Introduction';
		insert Y;
		Y.Start_Process__c = system.today();
		update Y;
		Y.Information_Gathered__c = system.today();
		update Y;
		Y.Configuration_Complete__c = system.today();
		update Y;
		Y.Accuracy_Confirmed__c = system.today();
		//update Y;
		
		
		
		
	}
}