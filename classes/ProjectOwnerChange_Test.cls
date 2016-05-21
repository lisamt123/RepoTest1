@isTest
public class ProjectOwnerChange_Test {
	public static testMethod void TestTask()
	{
		/*Territory_State__c TS = new Territory_State__c();
		TS.Name = 'XX';
		TS.Account_Manager__c = userinfo.getUserId();
		TS.DDM__c = userinfo.getUserId();
		TS.Regional__c = userinfo.getUserId();
		TS.Implementation_Manager__c = userinfo.getUserId();
        TS.Implementation_Specialist__c = userinfo.getUserId();		
		insert TS;*/
		
		Account A = new Account();
		A.BillingState = 'KS';
		A.Name = 'test';
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
		
		insert A; 
		
		Opportunity O = new Opportunity();
		O.AccountId = A.id;
		O.Type = 'SEO';
		O.Name = A.name;
		O.Type = 'New Business';
		O.CloseDate = system.today();
		O.StageName = 'Prospect';
		insert O;
		
		SFDC_520_Quote__c pr = new SFDC_520_Quote__c();
		pr.Account__c = A.id;
		pr.Opportunity__c = O.id;
		pr.Name = O.Name;
		pr.OwnerId = userinfo.getUserId();
		pr.Training_Included__c = true;		
						
		insert pr;
					
		Project_Piece__c pc = new Project_Piece__c();
		pc.Project__c = pr.Id;
		pc.Piece_Issue__c = 'test';
		pc.ownerId = userinfo.getUserId();
		//insert pc; 
		/*
		Task ppTask = new Task();
		ppTask.OwnerId = pc.OwnerId;
		ppTask.WhatId = pc.Id;
		ppTask.Subject = 'test';
		ppTask.Status = 'In Progress';
		ppTask.Type = 'Task';
		insert ppTask;
		*/
		/*
		Project_Piece__c pc2 = new Project_Piece__c();
		pc2.Project__c = pr.Id;
		pc2.Piece_Issue__c = 'test2';
		pc2.ownerId = userinfo.getUserId();
		
		insert pc2;
		*/
		
		pr.Date_Packet_Ret_d__c = system.today();
		pr.Date_Graphics_Obtained__c = system.today();
		update pr;	
		
		pr.OwnerId = '00570000001KeZm';
		update pr;
		//pr.OwnerId = userinfo.getUserId();
		//update pr;
		//pr.Regional__c = null;
		//pr.DDM__c = null;
		
	
		pr.Proposed_Training_Start__c = system.today();
		pr.Proposed_Training_End__c = system.today();		
		update pr;
		pr.Trainer__c = userinfo.getUserId();
		pr.Trainer_2__c = userinfo.getUserId();
		pr.Trainer_3__c = userinfo.getUserId();
		pr.Trainer_4__c = userinfo.getUserId();
		update pr;
		//===============================
	
		

		
		//pr.Confirmed_Training_Start__c=system.today();
		//update pr;
		
		//pr.Confirmed_Training_End__c=null;
		pr.Training_Expenses_Paid_by_Dealer__c = TRUE;
		pr.Training_Dates_Confirmed__c = TRUE;
		update pr;
		//pr.Confirmed_Training_End__c = system.today();
		//=================================
		pr.Travel_Proposed__c = system.today();
		//update pr; 
		pr.Training_Coordinated__c = system.today();
		//update pr;
		//==================================
		
		
		
			
		
	}
	public static testmethod void part2()
	{
		User adminUser = [select Id, ProfileId, IsActive from User where ProfileId =: '00e70000001FaWM' AND IsActive =: true limit 1];
		
		system.runAs(adminUser)
		{
			/*Territory_State__c TS = new Territory_State__c();
			TS.Name = 'XX';
			TS.Account_Manager__c = userinfo.getUserId();
			TS.DDM__c = userinfo.getUserId();
			TS.Regional__c = userinfo.getUserId();
			TS.Implementation_Manager__c = userinfo.getUserId();
	        TS.Implementation_Specialist__c = userinfo.getUserId();		
			insert TS;*/
			
			Account A = new Account();
			A.BillingState = 'KS';
			A.Name = 'test';
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
			
			insert A; 
			
			Opportunity O = new Opportunity();
			O.AccountId = A.id;
			O.Type = 'SEO';
			O.Name = A.name;
			O.Type = 'New Business';
			O.CloseDate = system.today();
			O.StageName = 'Prospect';
			insert O;
			
			SFDC_520_Quote__c pr = new SFDC_520_Quote__c();
			pr.Account__c = A.id;
			pr.Opportunity__c = O.id;
			pr.Name = O.Name;
			pr.OwnerId = userinfo.getUserId();
			pr.Training_Included__c = true;									
			insert pr;		
			
			pr.Total_number_of_users__c='test';
			update pr;
			
			pr.Travel_Approved_Trainer__c= system.today();
			update pr;
			//===================================
			pr.Travel_Approved_Financed__c=system.today();
			update pr;
			//===================================
			//pr.Training_is_GO__c = system.today();
			//update pr;
			//=====================================
			pr.Travel_Purchased__c=system.today();
			update pr;
			//=====================================
			//pr.Training_Completed__c = system.today();
			//update pr;
			//=======================================
			pr.Trainer_Expenses_Submitted__c = system.today();
			update pr;
			//=====================================
			pr.DDM_Finalization_Complete__c = system.today();
			update pr; 
		
			pr.Total_number_of_users__c = 'test';
			update pr;
		}
	}
}