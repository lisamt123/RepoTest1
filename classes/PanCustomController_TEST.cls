@isTest
private class PanCustomController_TEST {

    static testMethod void PanCustomController_TestMethod() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	PAN__c testPan = new PAN__c();
	    	testPan.Bonus__c = true;
	    	testPan.Commission_Eligible__c = true;
	    	testPan.Commission_to_Non_Commission__c = true;
	    	testPan.Current_Salary__c = 10000;
	    	testPan.Salary_Amount_Encrypted__c = '12000';
	    	testPan.Demotion__c = false;
	    	testPan.Department__c = '2 – Sales';
	    	testPan.Department_Change__c = true;
	    	testPan.Effective_Date__c = system.now();
	    	testPan.Email_Address__c = 'test@test.com';
	    	testPan.Email_Password__c = 'testpass';
	    	testPan.Email_Username__c = 'testuser';
	    	testPan.Equipment__c = 'Desktop Computer';
	    	testPan.Equipment_Notes__c = 'test equipment notes';
	    	testPan.Exempt_to_Non_Exempt__c = true;
	    	testPan.First_Name__c = 'testfirstname';
	    	testPan.Floor__c = '3rd Floor';
	    	testPan.Home_Address__c = '123 test st.';
	    	testPan.Home_City_State__c = 'test city';
	    	testPan.Home_Phone__c = '1234567890';
	    	testPan.Job_Title__c = 'test job title';
	    	testPan.Last_Name__c = 'testlastname';
	    	testPan.Location__c = 'Building 3';
	    	testPan.Modify__c = 'Demotion';
	    	testPan.Motosnap_Password__c = 'motosnappassword';
	    	testPan.Motosnap_Username__c = 'motosnapusername';
	    	testPan.Name_As_It_Appears_In_Email__c = 'Tommy';
	    	testPan.New_Hire_Only__c = 'New Hire';
	    	testPan.Nickname__c = 'testnickname';
	    	testPan.Non_Commission_to_Commission__c = true;
	    	testPan.Non_Exempt_to_Exempt__c = true;
	    	testPan.Other_Equipment__c = 'test other equip';
	    	testPan.Other_Negotiables__c = 'Car Allowance';
	    	testPan.Other_Negotiables_Additional_Comments__c = 'other neg add comment';
	    	testPan.Pay__c = 'Salary';
			testPan.PC_Password__c = 'pcpassword';
			testPan.PC_Username__c = 'pcusername';
			testPan.Phone_Extension__c = '123';
			testPan.Phone_Password__c = '123';
			testPan.Promotion__c = true;
			testPan.PTO_Payout__c = 40;
			testPan.Relocation__c = true;
			testPan.Reporting_Change__c = true;
			testPan.Reports_To__c = Userinfo.getUserId();
			testPan.Request_Status__c = 'New';
			testPan.Role__c = 'Accounting';
			testPan.Salary_Amount_Encrypted__c = '100000';
			testPan.Salary_Change__c = false;
			testPan.Salesforce_Password__c = 'sfdcpassword';
			testPan.Salesforce_Username__c = 'sfdcusername';
			testPan.Separation_Date_Time__c = system.now();
			testPan.Separation_Notes__c = 'sep notes';
			testPan.Seperation_Reason__c = 'Other';
			testPan.Status__c = 'F/T';
			testPan.System_Access__c = 'MotoSnap';
			testPan.Time_Off_Balance__c = 40;
			testPan.Title_Change__c = false;
			testPan.Verbal_Offer_made_to_Candidate__c = 'Yes';
			testPan.Vin_Employee__c = userinfo.getUserId();
			testPan.New_Job_Title__c = 'S1091 - Web Design';
			
			insert testPan;
			
			test.startTest();
			
			ApexPages.currentPage().getParameters().put('id', testPan.Id);
	        
	        ApexPages.StandardController controller = new ApexPages.StandardController(testPan);
	        
	       	PanCustomController PCC = new PanCustomController(controller);
	       	       	
	       	PageReference testStart = Page.Panform;
			Test.setCurrentPage(testStart);
			
			PCC.next();
			PCC.next2();
			PCC.getPersonnelChangesList();
			PCC.getPanForm();
			
			
			test.stopTest();
        	
        }
    }
    
    static testMethod void PanCustomController_TestMethod2() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	PAN__c testPan = new PAN__c();
	    	testPan.Bonus__c = true;
	    	testPan.Commission_Eligible__c = true;
	    	testPan.Commission_to_Non_Commission__c = true;
	    	testPan.Current_Salary__c = 10000;
	    	testPan.Salary_Amount_Encrypted__c = '12000';
	    	testPan.Demotion__c = false;
	    	testPan.Department__c = '2 – Sales';
	    	testPan.Department_Change__c = true;
	    	
	    	//datetime myDate = datetime.newInstance(2012, 8, 5);
	    	datetime myDate = datetime.newInstance(2014, 2, 2);
	    	
	    	testPan.Effective_Date__c = myDate;
	    	testPan.Email_Address__c = 'test@test.com';
	    	testPan.Email_Password__c = 'testpass';
	    	testPan.Email_Username__c = 'testuser';
	    	testPan.Equipment__c = 'Desktop Computer';
	    	testPan.Equipment_Notes__c = 'test equipment notes';
	    	testPan.Exempt_to_Non_Exempt__c = true;
	    	testPan.First_Name__c = 'testfirstname';
	    	testPan.Floor__c = '3rd Floor';
	    	testPan.Home_Address__c = '123 test st.';
	    	testPan.Home_City_State__c = 'test city';
	    	testPan.Home_Phone__c = '1234567890';
	    	testPan.Job_Title__c = 'test job title';
	    	testPan.Last_Name__c = 'testlastname';
	    	testPan.Location__c = 'Building 3';
	    	testPan.Modify__c = 'Demotion';
	    	testPan.Motosnap_Password__c = 'motosnappassword';
	    	testPan.Motosnap_Username__c = 'motosnapusername';
	    	testPan.Name_As_It_Appears_In_Email__c = 'Tommy';
	    	testPan.New_Hire_Only__c = 'New Hire';
	    	testPan.Nickname__c = 'testnickname';
	    	testPan.Non_Commission_to_Commission__c = true;
	    	testPan.Non_Exempt_to_Exempt__c = true;
	    	testPan.Other_Equipment__c = 'test other equip';
	    	testPan.Other_Negotiables__c = 'Car Allowance';
	    	testPan.Other_Negotiables_Additional_Comments__c = 'other neg add comment';
	    	testPan.Pay__c = 'Salary';
			testPan.PC_Password__c = 'pcpassword';
			testPan.PC_Username__c = 'pcusername';
			testPan.Phone_Extension__c = '123';
			testPan.Phone_Password__c = '123';
			testPan.Promotion__c = true;
			testPan.PTO_Payout__c = 40;
			testPan.Relocation__c = true;
			testPan.Reporting_Change__c = true;
			testPan.Reports_To__c = Userinfo.getUserId();
			testPan.Request_Status__c = 'New';
			testPan.Role__c = 'Accounting';
			testPan.Salary_Amount_Encrypted__c = '100000';
			testPan.Salary_Change__c = true;
			testPan.Salesforce_Password__c = 'sfdcpassword';
			testPan.Salesforce_Username__c = 'sfdcusername';
			testPan.Separation_Date_Time__c = system.now();
			testPan.Separation_Notes__c = 'sep notes';
			testPan.Seperation_Reason__c = 'Other';
			testPan.Status__c = 'F/T';
			testPan.System_Access__c = 'MotoSnap';
			testPan.Time_Off_Balance__c = 40;
			testPan.Title_Change__c = false;
			testPan.Verbal_Offer_made_to_Candidate__c = 'Yes';
			testPan.Vin_Employee__c = userinfo.getUserId();
			testPan.New_Job_Title__c = 'S1091 - Web Design';
			
			insert testPan;
			
			test.startTest();
			
			ApexPages.currentPage().getParameters().put('id', testPan.Id);
	        
	        ApexPages.StandardController controller = new ApexPages.StandardController(testPan);
	        
	       	PanCustomController PCC = new PanCustomController(controller);
	       	       	
	       	PageReference testStart = Page.Panform;
			Test.setCurrentPage(testStart);
			
			PCC.next();
			PCC.next2();
			PCC.getPersonnelChangesList();
			PCC.getPanForm();
			
			
			test.stopTest();
        	
        }
    }
}