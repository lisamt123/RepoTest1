/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest(seeAllData=true)

private class PTO_PageOneEmpDays_TEST {
	
	public static testmethod void testselectLists(){
		
		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	    insert u_testMethodUser;
	    
	    System.runas(u_testMethodUser){
			SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
			
			ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);		
			ApexPages.currentPage().getParameters().put('avail', '150');
			PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
			
			test.startTest();
			
			//ct.totalAvailable = decimal.valueOf(avail);
			ct.getLunch();
			ct.getItems();
			ct.getPartialTimes();
			ct.getMultiDayTimes();
			ct.cancelReturn();
			ct.cancelUpdate();
			
			test.stopTest();
			
	    }
		
	}
	
	public static testmethod void holidays1(){
		
		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	    insert u_testMethodUser;
	    
	    System.runas(u_testMethodUser){
			SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
			
			ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);		
			ApexPages.currentPage().getParameters().put('avail', '150');
			PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
			date newYearsDay = Date.newInstance(2013, 01, 01);
			date mlk = Date.newInstance(2013, 01, 21);
			date memorialDay = Date.newInstance(2013, 05, 27);
			date independenceDay = Date.newInstance(2013, 07, 04);
			date laborDay = Date.newInstance(2013, 09, 02);
			date thanksgiving = Date.newInstance(2013, 11, 28);
			date dayAfterThanksgiving = Date.newInstance(2013, 11, 29);
			date christmasEve = Date.newInstance(2013, 12, 24);
			date christmasDay = Date.newInstance(2013, 12, 25);
			integer sameYear = system.today().year();
			
			test.startTest();
			
			ct.days = 'Full Day';
			ct.pto.Full_Day_Date__c = system.today();
			ct.holidays();
			
			ct.days = 'Full Day';
			ct.pto.Full_Day_Date__c = mlk;
			ct.holidays();
			
			ct.days = 'Partial Day';
			ct.pto.Partial_Day_Date__c = system.today();
			ct.holidays();
			
			ct.days = 'Partial Day';
			ct.pto.Partial_Day_Date__c = mlk;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.pto.Multi_Day_From__c = system.today();
			ct.pto.Multi_Day_To__c = system.today().addDays(2);
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = newYearsDay;
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = mlk;
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = memorialDay;
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = independenceDay;
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = laborDay;
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = thanksgiving;
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = dayAfterThanksgiving;
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = christmasEve;
			ct.daysbetween = 5;
			ct.holidays();
			
			ct.days = 'Multiple Days';
			ct.day1Date = christmasDay;
			ct.daysbetween = 5;
			ct.holidays();
			
			test.stopTest();
			
	    }
		
	}
	
	public static testmethod void testtypeChange(){
		
		SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.days = 'Partial Day';
		ct.typeChange();
		
		ct.days = 'Full Day';
		ct.typeChange();
		   
    }
    
    public static testmethod void testmultiPartialDays(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.multiPartialDays();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiPartialDays();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiPartialDays();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiPartialDays();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiPartialDays();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiPartialDays();
     	
     }
     
     public static testmethod void testmultiPartialDaysEdit(){
     	

     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');
 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
}
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJj';  //sandbox
     	pto.RecordTypeId = '01270000000Q9s6';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(5);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_1__c = true;
		ct.pto.Partial_Day_2__c = true;
		ct.pto.Partial_Day_3__c = true;
		ct.pto.Partial_Day_4__c = true;
		ct.pto.Partial_Day_5__c = true;
		ct.multiPartialDaysEdit();
		
		test.stopTest();
     	
     	
     	
     	
     }
     
      public static testmethod void testmultiPartialDaysEdit1(){
     	


     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
}
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJj';  //sandbox
     	pto.RecordTypeId = '01270000000Q9s6';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_1__c = false;
		ct.pto.Partial_Day_2__c = false;
		ct.pto.Partial_Day_3__c = false;
		ct.pto.Partial_Day_4__c = false;
		ct.pto.Partial_Day_5__c = false;
		ct.multiPartialDaysEdit();
		
		test.stopTest();
     	
     }
     
     public static testmethod void testmultiPartialDaysEdit2(){
     	

     
     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
	    }
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJo';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sB';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_1__c = false;
		ct.pto.Partial_Day_2__c = false;
		ct.pto.Partial_Day_3__c = false;
		ct.pto.Partial_Day_4__c = false;
		ct.pto.Partial_Day_5__c = false;
		ct.multiPartialDaysEdit();
		
		test.stopTest();
     	
     }
     
       public static testmethod void testmultiPartialDaysEdit3(){
     	
     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
}
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sG';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_1__c = false;
		ct.pto.Partial_Day_2__c = false;
		ct.pto.Partial_Day_3__c = false;
		ct.pto.Partial_Day_4__c = false;
		ct.pto.Partial_Day_5__c = false;
		ct.multiPartialDaysEdit();
		
		test.stopTest();
     	
     }
     
        public static testmethod void testmultiPartialDayHoursEdit(){
     	

     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
}

     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sG';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_1__c = false;
		ct.pto.Partial_Day_2__c = false;
		ct.pto.Partial_Day_3__c = false;
		ct.pto.Partial_Day_4__c = false;
		ct.pto.Partial_Day_5__c = false;
		ct.multiPartialDayHoursEdit();
		
		test.stopTest();
     	
     }
     
     public static testmethod void testmultiPartialDayHoursEdit1(){
     	
     	     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
}
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sG';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
     	ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '7.25';
		ct.multiDayPartialDay1EndTime = '13.25';
		ct.lunch1 = 'NO';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '13.50';
		ct.multiDayPartialDay1EndTime = '15.50';
		ct.lunch1 = 'YES';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '7.00';
		ct.multiDayPartialDay1EndTime = '13.00';
		ct.lunch1 = 'NO';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '13.75';
		ct.multiDayPartialDay1EndTime = '15.75';
		ct.lunch1 = 'YES';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '7.00';
		ct.multiDayPartialDay1EndTime = '19.00';
		ct.lunch1 = 'YES';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '13.75';
		ct.multiDayPartialDay1EndTime = '7.75';
		ct.lunch1 = 'YES';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_1__c = false;
		ct.multiPartialDayHoursEdit();
		
		test.stopTest();
     }
     
     public static testmethod void testmultiPartialDayHoursEdit2(){
     	
     	

     	     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
	    }

     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sG';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
     	ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '7.25';
		ct.multiDayPartialDay2EndTime = '13.25';
		ct.lunch2 = 'NO';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '13.50';
		ct.multiDayPartialDay2EndTime = '15.50';
		ct.lunch2 = 'YES';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '7.00';
		ct.multiDayPartialDay2EndTime = '13.00';
		ct.lunch2 = 'NO';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '13.75';
		ct.multiDayPartialDay2EndTime = '15.75';
		ct.lunch2 = 'YES';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '7.00';
		ct.multiDayPartialDay2EndTime = '19.00';
		ct.lunch2 = 'YES';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '13.75';
		ct.multiDayPartialDay2EndTime = '7.75';
		ct.lunch2 = 'YES';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_2__c = false;
		ct.multiPartialDayHoursEdit();
     	test.stopTest();	
     }
     
     public static testmethod void testmultiPartialDayHoursEdit3(){
     	
     	     	     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
     	}
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sG';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
     	ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '7.25';
		ct.multiDayPartialDay3EndTime = '13.25';
		ct.lunch3 = 'NO';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '13.50';
		ct.multiDayPartialDay3EndTime = '15.50';
		ct.lunch3 = 'YES';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '7.00';
		ct.multiDayPartialDay3EndTime = '13.00';
		ct.lunch3 = 'NO';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '13.75';
		ct.multiDayPartialDay3EndTime = '15.75';
		ct.lunch3 = 'YES';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '7.00';
		ct.multiDayPartialDay3EndTime = '19.00';
		ct.lunch3 = 'YES';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '13.75';
		ct.multiDayPartialDay3EndTime = '7.75';
		ct.lunch3 = 'YES';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_3__c = false;
		ct.multiPartialDayHoursEdit();
     	test.stopTest();	
     }
     
     public static testmethod void testmultiPartialDayHoursEdit4(){


     	
     	     	     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
}
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sG';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
     	ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '7.25';
		ct.multiDayPartialDay4EndTime = '13.25';
		ct.lunch4 = 'NO';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '13.50';
		ct.multiDayPartialDay4EndTime = '15.50';
		ct.lunch4 = 'YES';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '7.00';
		ct.multiDayPartialDay4EndTime = '13.00';
		ct.lunch4 = 'NO';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '13.75';
		ct.multiDayPartialDay4EndTime = '15.75';
		ct.lunch4 = 'YES';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '7.00';
		ct.multiDayPartialDay4EndTime = '19.00';
		ct.lunch4 = 'YES';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '13.75';
		ct.multiDayPartialDay4EndTime = '7.75';
		ct.lunch4 = 'YES';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_4__c = false;
		ct.multiPartialDayHoursEdit();
     	test.stopTest();	
     }
     
     public static testmethod void testmultiPartialDayHoursEdit5(){
     	

     	     	     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
}
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sG';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
     	ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '7.25';
		ct.multiDayPartialDay5EndTime = '13.25';
		ct.lunch5 = 'NO';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '13.50';
		ct.multiDayPartialDay5EndTime = '15.50';
		ct.lunch5 = 'YES';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '7.00';
		ct.multiDayPartialDay5EndTime = '13.00';
		ct.lunch5 = 'NO';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '13.75';
		ct.multiDayPartialDay5EndTime = '15.75';
		ct.lunch5 = 'YES';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '7.00';
		ct.multiDayPartialDay5EndTime = '19.00';
		ct.lunch5 = 'YES';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '13.75';
		ct.multiDayPartialDay5EndTime = '7.75';
		ct.lunch5 = 'YES';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHoursEdit();
		
		ct.pto.Partial_Day_5__c = false;
		ct.multiPartialDayHoursEdit();
     	test.stopTest();	
     }
     
     public static testmethod void totalHoursTaken(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.daysBetween = 5;
		ct.day1HoursDisplay = 5;
		ct.day2HoursDisplay = 5;
		ct.day3HoursDisplay = 5;
		ct.day4HoursDisplay = 5;
		ct.day5HoursDisplay = 5;
		ct.totalHoursTaken();
		
     }
	
	public static testmethod void testfullDay(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.fullDay(); 
     	
     }
     
     public static testmethod void testpartialDateNull(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.partialDateNull();
     	
     }
     
     public static testmethod void testpartialDay1PartialDays(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		//ct.partialDay1();
		//ct.partialDays();
		
     	ct.partialTimeStart = '9.00';
    	ct.partialTimeEnd = '11.00';
    	ct.lunches = 'NO';
    	ct.partialDays();
    	
    	ct.partialTimeStart = '9.00';
    	ct.partialTimeEnd = '11.00';
    	ct.lunches = 'YES';
    	ct.PartialDay1();
    	
    	ct.partialTimeStart = '9.00';
    	ct.partialTimeEnd = '7.00';
    	ct.partialDay1();
    	
    	ct.partialTimeStart = '7.00';
    	ct.partialTimeEnd = '17.00';
    	ct.days = 'Multiple Days';
    	ct.partialDay1();
     }
     
     public static testmethod void testmultiPartialDayHours(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '7.25';
		ct.multiDayPartialDay1EndTime = '13.25';
		ct.lunch1 = 'NO';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '13.50';
		ct.multiDayPartialDay1EndTime = '15.50';
		ct.lunch1 = 'YES';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '7.00';
		ct.multiDayPartialDay1EndTime = '13.00';
		ct.lunch1 = 'NO';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '13.75';
		ct.multiDayPartialDay1EndTime = '15.75';
		ct.lunch1 = 'YES';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '7.00';
		ct.multiDayPartialDay1EndTime = '19.00';
		ct.lunch1 = 'YES';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_1__c = true;
		ct.multiDayPartialDay1StartTime = '13.75';
		ct.multiDayPartialDay1EndTime = '7.75';
		ct.lunch1 = 'YES';
		ct.day1HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_1__c = false;
		ct.multiPartialDayHours();
		
     }
     
     public static testmethod void testmultiPartialDayHours2(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '7.25';
		ct.multiDayPartialDay2EndTime = '13.25';
		ct.lunch2 = 'NO';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '13.50';
		ct.multiDayPartialDay2EndTime = '15.50';
		ct.lunch2 = 'YES';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '7.00';
		ct.multiDayPartialDay2EndTime = '13.00';
		ct.lunch2 = 'NO';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '13.75';
		ct.multiDayPartialDay2EndTime = '15.75';
		ct.lunch2 = 'YES';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '7.00';
		ct.multiDayPartialDay2EndTime = '19.00';
		ct.lunch2 = 'YES';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_2__c = true;
		ct.multiDayPartialDay2StartTime = '13.75';
		ct.multiDayPartialDay2EndTime = '7.75';
		ct.lunch2 = 'YES';
		ct.day2HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_2__c = false;
		ct.multiPartialDayHours();
		
     }
      public static testmethod void testmultiPartialDayHours3(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '7.25';
		ct.multiDayPartialDay3EndTime = '13.25';
		ct.lunch3 = 'NO';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '13.50';
		ct.multiDayPartialDay3EndTime = '15.50';
		ct.lunch3 = 'YES';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '7.00';
		ct.multiDayPartialDay3EndTime = '13.00';
		ct.lunch3 = 'NO';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '13.75';
		ct.multiDayPartialDay3EndTime = '15.75';
		ct.lunch3 = 'YES';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '7.00';
		ct.multiDayPartialDay3EndTime = '19.00';
		ct.lunch3 = 'YES';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_3__c = true;
		ct.multiDayPartialDay3StartTime = '13.75';
		ct.multiDayPartialDay3EndTime = '7.75';
		ct.lunch3 = 'YES';
		ct.day3HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_3__c = false;
		ct.multiPartialDayHours();
		
     }
     
      public static testmethod void testmultiPartialDayHours4(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '7.25';
		ct.multiDayPartialDay4EndTime = '13.25';
		ct.lunch4 = 'NO';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '13.50';
		ct.multiDayPartialDay4EndTime = '15.50';
		ct.lunch4 = 'YES';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '7.00';
		ct.multiDayPartialDay4EndTime = '13.00';
		ct.lunch4 = 'NO';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '13.75';
		ct.multiDayPartialDay4EndTime = '15.75';
		ct.lunch4 = 'YES';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '7.00';
		ct.multiDayPartialDay4EndTime = '19.00';
		ct.lunch4 = 'YES';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_4__c = true;
		ct.multiDayPartialDay4StartTime = '13.75';
		ct.multiDayPartialDay4EndTime = '7.75';
		ct.lunch4 = 'YES';
		ct.day4HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_4__c = false;
		ct.multiPartialDayHours();
		
     }
     
      public static testmethod void testmultiPartialDayHours5(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '7.25';
		ct.multiDayPartialDay5EndTime = '13.25';
		ct.lunch5 = 'NO';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '13.50';
		ct.multiDayPartialDay5EndTime = '15.50';
		ct.lunch5 = 'YES';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '7.00';
		ct.multiDayPartialDay5EndTime = '13.00';
		ct.lunch5 = 'NO';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '13.75';
		ct.multiDayPartialDay5EndTime = '15.75';
		ct.lunch5 = 'YES';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '7.00';
		ct.multiDayPartialDay5EndTime = '19.00';
		ct.lunch5 = 'YES';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '13.75';
		ct.multiDayPartialDay5EndTime = '7.75';
		ct.lunch5 = 'YES';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHours();
		
		ct.pto.Partial_Day_5__c = false;
		ct.multiPartialDayHours();
		
     }
     
     public static testmethod void testmultiPartialDayHours6(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '2');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.pto.Partial_Day_5__c = true;
		ct.multiDayPartialDay5StartTime = '7.25';
		ct.multiDayPartialDay5EndTime = '13.25';
		ct.lunch5 = 'NO';
		ct.day5HoursDisplay = 3;
		ct.multiPartialDayHours();
		
     }
     
     public static testmethod void testmultiDays(){
		
		SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '1');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(-10);
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(6);
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(1);
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(10);
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today();
		ct.multiDays();
		
     }
     
     public static testmethod void testmultiDaysEdit(){
     	
     	     	     	     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

 // start new context via system.runAs() for the same user for test code only
 //to get rid of MIXED_DML_OPERATION errors
      System.runAs(new User(Id = Userinfo.getUserId())) {
	        insert emp_testMethodEMp;
	    }


     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	pto.Hours_to_be_Used__c = 8;
     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     	pto.RecordTypeId = '01270000000Q9sG';  //prod
     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		pto.Time_Off_Balance__c = 'a067000000aBdaI';
     	//pto.Full_Day_Date__c = system.today().addDays(5);
     	pto.From__c = system.today().addDays(1);
     	pto.To__c = system.today().addDays(5);
     	
     	insert pto;
     	
     	test.startTest();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		ApexPages.currentPage().getParameters().put('recordId', pto.Id);
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.multiDaysEdit();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(-10);
		ct.multiDaysEdit();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(6);
		ct.multiDaysEdit();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(1);
		ct.multiDaysEdit();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(10);
		ct.multiDaysEdit();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today();
		ct.multiDaysEdit();
		
		test.stopTest();
     	
     }
     
     public static testmethod void testmultiDays1(){
		
		SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		
		ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
		PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(-10);
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(6);
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(1);
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today().addDays(10);
		ct.multiDays();
		
		ct.pto.Multi_Day_From__c = system.today();
		ct.pto.Multi_Day_To__c = system.today();
		ct.multiDays();
		
     }
     
     public static testmethod void testcreateNewPTOFullDay(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        
	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		        	     	     	     	     	     	        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Full Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
				
				ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = '00570000003L0mn';
				ct.days = 'Full Day';
				ct.pto.Full_Day_Date__c = system.today().addDays(1);
				ct.balReturn();

			
	        }
     }
     
     public static testmethod void testcreateNewPTOFullDay1(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        
	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '1');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		    Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;
				
				ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Full Day';
				ct.pto.Hours_to_be_Used__c = 8;
				ct.pto.Full_Day_Date__c = system.today().addDays(1);
				ct.balReturn();

			
	        }
     }
     
     public static testmethod void editPTOFullDay(){
     	
     		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');

        	insert u_testMethodUser;

        	Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        	
        	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;
	        
	        System.runas(u_testMethodUser){
	        	
	        	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		     	pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id; //'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Full_Day_Date__c = system.today();
		     	pto.From__c = system.today();
		     	pto.To__c = system.today();
		     	
		     	insert pto;
		     	
		     	test.startTest();
		     	
		     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				ct.balId = '00570000003L0mn';
				ct.pto.Employee_s_Name__c =  emp_testMethodEMp.Id;//'a067000000aBdaI';
				ct.days = 'Full Day';
				ct.pto.Full_Day_Date__c = system.today().addDays(1);
				ct.updatePTO();
				
				test.stopTest();
	        	
	        	
	        	
	        }
     	
     }
     
     public static testmethod void editPTOFullDay1(){
     	
     		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        
	        System.runas(u_testMethodUser){
	        	
	        	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		     	pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Full_Day_Date__c = system.today();
		     	pto.From__c = system.today();
		     	pto.To__c = system.today();
		     	
		     	insert pto;
		     	
		     	test.startTest();
		     	
		     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				ct.balId = '00570000003L0mn';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'a067000000aBdaI';
				ct.days = 'Full Day';
				ct.pto.Full_Day_Date__c = null;
				ct.updatePTO();
				
				test.stopTest();
	        	
	        	
	        	
	        }
     	
     }
     
        public static testmethod void testcreateNewPTOPartialDay(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;

Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	        
	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c =  emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '7.00';
				ct.partialTimeEnd = '13.00';
				ct.lunches = 'NO';
				ct.balReturn();
				
	        }
        }
        
        
        public static testmethod void testcreateNewPTOPartialDay2(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	 	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	          
	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c =  emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '7.00';
				ct.partialTimeEnd = '13.00';
				ct.lunches = 'YES';
				ct.balReturn();
				
		        
	        }
        }public static testmethod void testcreateNewPTOPartialDay3(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	 	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	    

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '7.00';
				ct.partialTimeEnd = '19.00';
				ct.lunches = 'YES';
				ct.balReturn();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOPartialDay4(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	 	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '7.25';
				ct.partialTimeEnd = '13.25';
				ct.lunches = 'YES';
				ct.balReturn();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOPartialDay5(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];

	        	 	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        
	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c =emp_testMethodEMp.Id;// '00570000003L0mn';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '7.50';
				ct.partialTimeEnd = '13.50';
				ct.lunches = 'YES';
				ct.balReturn();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOPartialDay6(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	 	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '7.75';
				ct.partialTimeEnd = '13.75';
				ct.lunches = 'YES';
				ct.balReturn();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOPartialDay7(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	 	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '13.00';
				ct.partialTimeEnd = '17.00';
				ct.lunches = 'YES';
				ct.balReturn();
				
		        
	        }
        }
        
        public static testmethod void editPTOPartialDay1(){
  		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
	        Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	 	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

   
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        
	        System.runas(u_testMethodUser){
	        	
	        	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		     	pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Partial_Day_Date__c = system.today();
		     	pto.From__c = system.today();
		     	pto.To__c = system.today();
		     	
		     	insert pto;
		     	
		     	test.startTest();
		     	
		     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				ct.balId = '00570000003L0mn';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'a067000000aBdaI';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '7.00';
				ct.partialTimeEnd = '13.00';
				ct.lunches = 'NO';
				ct.updatePTO();
				
				test.stopTest();
	        	
	        	
	        	
	        }
     	
     }
     
      public static testmethod void editPTOPartialDay2(){
     	 Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
     		        	        	 	                	    		User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

     		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        
	        System.runas(u_testMethodUser){
	        	
	        	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		     	pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Partial_Day_Date__c = system.today();
		     	pto.From__c = system.today();
		     	pto.To__c = system.today();
		     	
		     	insert pto;
		     	
		     	test.startTest();
		     	
		     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				ct.balId = '00570000003L0mn';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'a067000000aBdaI';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '13.25';
				ct.partialTimeEnd = '16.25';
				ct.lunches = 'YES';
				ct.updatePTO();
				
				test.stopTest();
	        	
	        	
	        	
	        }
     	
     }
     
     public static testmethod void editPTOPartialDay3(){
     	
     		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	    Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
	        	
	        	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		     	pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Partial_Day_Date__c = system.today();
		     	pto.From__c = system.today();
		     	pto.To__c = system.today();
		     	
		     	insert pto;
		     	
		     	test.startTest();
		     	
		     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				ct.balId = '00570000003L0mn';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'a067000000aBdaI';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '7.50';
				ct.partialTimeEnd = '13.50';
				ct.lunches = 'NO';
				ct.updatePTO();
				
				test.stopTest();
	        	
	        	
	        	
	        }
     	
     }
     
      public static testmethod void editPTOPartialDay4(){
     	
     		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        


	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	                	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	
	        
	        System.runas(u_testMethodUser){
	        	
	        	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		     	pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id; //'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Partial_Day_Date__c = system.today();
		     	pto.From__c = system.today();
		     	pto.To__c = system.today();
		     	
		     	insert pto;
		     	
		     	test.startTest();
		     	
		     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				ct.balId = '00570000003L0mn';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id; //'a067000000aBdaI';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = system.today().addDays(1);
				ct.partialTimeStart = '13.75';
				ct.partialTimeEnd = '16.75';
				ct.lunches = 'YES';
				ct.updatePTO();
				
				test.stopTest();
	        	
	        	
	        	
	        }
     	
     }
     
     public static testmethod void editPTOPartialDay5(){
     	
     		Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	                	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
	        	
	        	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
		     	pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Partial_Day_Date__c = system.today();
		     	pto.From__c = system.today();
		     	pto.To__c = system.today();
		     	
		     	insert pto;
		     	
		     	test.startTest();
		     	
		     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				ct.balId = '00570000003L0mn';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'a067000000aBdaI';
				ct.days = 'Partial Day';
				ct.pto.Partial_Day_Date__c = null;
				ct.partialTimeStart = 'Select Time...';
				ct.partialTimeEnd = 'Select Time...';
				ct.lunches = 'YES';
				ct.updatePTO();
				
				test.stopTest();
	        	
	        	
	        	
	        }
     	
     }
     
     public static testmethod void testcreateNewPTOMultiDayEdit1a(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	                	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
		     	pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				test.startTest();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today().addDays(4);
				ct.pto.Multi_Day_To__c = system.today().addDays(5);
				ct.pto.Partial_Day_1__c = false;
				ct.pto.Partial_Day_2__c = false;
				ct.updatePTO();
				
		        test.stopTest();
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay1a(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	                	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(1);
				ct.pto.Partial_Day_1__c = false;
				ct.pto.Partial_Day_2__c = false;
				ct.balReturn();
				
		        
	        }
        }
        
         public static testmethod void testcreateNewPTOMultiDayEdit1b(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        
 Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        	                	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(1);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '20.25';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '20.50';
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay1b(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        	        	                	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;	

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(1);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '20.25';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '20.50';
				ct.createNewPTO();
				
		        
	        }
        }
        public static testmethod void testcreateNewPTOMultiDay1b1(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	       User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(1);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '19.25';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '19.50';
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay1c(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	       User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(1);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.lunch1 = 'YES';
				ct.multiDayPartialDay1StartTime = '7.25';
				ct.multiDayPartialDay1EndTime = '20.50';
				ct.lunch2 = 'YES';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '20.75';
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay2a(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	       User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(2);
				ct.pto.Partial_Day_1__c = false;
				ct.pto.Partial_Day_2__c = false;
				ct.pto.Partial_Day_3__c = false;
				//ct.pto.Partial_Day_4__c = false;
				//ct.pto.Partial_Day_5__c = false;
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay2b(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
 Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	       User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(2);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				//ct.pto.Partial_Day_4__c = true;
				//ct.pto.Partial_Day_5__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'NO';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				/*ct.lunch4 = 'NO';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				ct.lunch5 = 'NO';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';*/
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay2c(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	        
	        
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	       User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(2);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				//ct.pto.Partial_Day_4__c = true;
				//ct.pto.Partial_Day_4__c = true;
				ct.lunch1 = 'YES';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'YES';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'YES';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				/*ct.lunch4 = 'YES';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				ct.lunch5 = 'YES';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';*/
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay3a(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        	       User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(3);
				ct.pto.Partial_Day_1__c = false;
				ct.pto.Partial_Day_2__c = false;
				ct.pto.Partial_Day_3__c = false;
				ct.pto.Partial_Day_4__c = false;
				//ct.pto.Partial_Day_5__c = false;
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay3b(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        	        	       User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1; 
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(3);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				ct.pto.Partial_Day_4__c = true;
				//ct.pto.Partial_Day_5__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'NO';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				ct.lunch4 = 'NO';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				/*ct.lunch5 = 'NO';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';*/
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay3c(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(3);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				ct.pto.Partial_Day_4__c = true;
				//ct.pto.Partial_Day_4__c = true;
				ct.lunch1 = 'YES';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'YES';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'YES';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				ct.lunch4 = 'YES';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				/*ct.lunch5 = 'YES';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';*/
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay4a(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(4);
				ct.pto.Partial_Day_1__c = false;
				ct.pto.Partial_Day_2__c = false;
				ct.pto.Partial_Day_3__c = false;
				ct.pto.Partial_Day_4__c = false;
				ct.pto.Partial_Day_5__c = false;
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay4b(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(4);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				ct.pto.Partial_Day_4__c = true;
				ct.pto.Partial_Day_5__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'NO';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				ct.lunch4 = 'NO';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				ct.lunch5 = 'NO';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';
				ct.createNewPTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDay4c(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
 Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
		     	
		     	Time_Off_Balance__c tob1 = new Time_Off_Balance__c();
				tob1.Starting_Balance__c = 144;
		        	
				insert tob1;
		        	
		    	SFDC_Paid_Time_Off__c pto1 = new SFDC_Paid_Time_Off__c();
		    	pto1.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
		    	pto1.Time_Off_Balance__c = 'a067000000aBdaI';
		   		pto1.Multi_Day_From__c = system.today();
		   		ct.days = 'Partial Day';
		   		pto1.Multi_day_To__c = system.today() + 1;
		        	
		        insert pto1;
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(4);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				ct.pto.Partial_Day_4__c = true;
				ct.pto.Partial_Day_5__c = true;
				ct.lunch1 = 'YES';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'YES';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'YES';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				ct.lunch4 = 'YES';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				ct.lunch5 = 'YES';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';
				ct.createNewPTO();
				
		        
	        }
        }
     
     public static testmethod void testbalReturn(){
     	
     	SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
     	
     	ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
		ApexPages.currentPage().getParameters().put('avail', '150');
     	PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
     	
     	Time_Off_Balance__c tob = new Time_Off_Balance__c();
     	
     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
     	PTO_StartPage ctsp = new PTO_StartPage(sctob);
     	
     	
     	ct.balReturn();
     	
     	ct.days = 'Full Day';
     	ct.pto.Full_Day_Date__c = null;
     	ct.balReturn();
     	
     	ct.days = 'Partial Day';
     	ct.pto.Partial_Day_Date__c = null;
     	ct.balReturn();
     	
     	ct.partialTimeStart = 'Select Time...';
     	ct.partialTimeEnd = 'Select Time...';
     	ct.balReturn();
     	
     	ct.pto.Partial_Day_1__c = true;
     	ct.multiDayPartialDay1StartTime = 'Select Time...';
     	ct.balReturn();
     	
     	ct.days = 'Full Day';
     	ct.pto.Full_Day_Date__c = system.today();
     	//ct.balReturn();
     	
     }
     
      public static testmethod void testcreateNewPTOMultiDayEdit1b1(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(1);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '19.25';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '19.50';
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit1c(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
 Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(1);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.lunch1 = 'YES';
				ct.multiDayPartialDay1StartTime = '7.25';
				ct.multiDayPartialDay1EndTime = '20.50';
				ct.lunch2 = 'YES';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '20.75';
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit2a(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
		        
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(2);
				ct.pto.Partial_Day_1__c = false;
				ct.pto.Partial_Day_2__c = false;
				ct.pto.Partial_Day_3__c = false;
				//ct.pto.Partial_Day_4__c = false;
				//ct.pto.Partial_Day_5__c = false;
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit2b(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);

		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(2);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				//ct.pto.Partial_Day_4__c = true;
				//ct.pto.Partial_Day_5__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'NO';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				/*ct.lunch4 = 'NO';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				ct.lunch5 = 'NO';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';*/
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit2c(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
   
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(2);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				//ct.pto.Partial_Day_4__c = true;
				//ct.pto.Partial_Day_4__c = true;
				ct.lunch1 = 'YES';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'YES';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'YES';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				/*ct.lunch4 = 'YES';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				ct.lunch5 = 'YES';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';*/
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit3a(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
				Time_Off_Balance__c tob = new Time_Off_Balance__c();
		     	
		     	ApexPages.Standardcontroller sctob = new ApexPages.Standardcontroller(tob);
		     	PTO_StartPage ctsp = new PTO_StartPage(sctob);

		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(3);
				ct.pto.Partial_Day_1__c = false;
				ct.pto.Partial_Day_2__c = false;
				ct.pto.Partial_Day_3__c = false;
				ct.pto.Partial_Day_4__c = false;
				//ct.pto.Partial_Day_5__c = false;
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit3b(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
 Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);

		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(3);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				ct.pto.Partial_Day_4__c = true;
				//ct.pto.Partial_Day_5__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'NO';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				ct.lunch4 = 'NO';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				/*ct.lunch5 = 'NO';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';*/
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit3c(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
 Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);

		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = '00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(3);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				ct.pto.Partial_Day_4__c = true;
				//ct.pto.Partial_Day_4__c = true;
				ct.lunch1 = 'YES';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'YES';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'YES';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				ct.lunch4 = 'YES';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				/*ct.lunch5 = 'YES';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';*/
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit4a(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
 Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);
				
		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(4);
				ct.pto.Partial_Day_1__c = false;
				ct.pto.Partial_Day_2__c = false;
				ct.pto.Partial_Day_3__c = false;
				ct.pto.Partial_Day_4__c = false;
				ct.pto.Partial_Day_5__c = false;
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit4b(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);

		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = '00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(4);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				ct.pto.Partial_Day_4__c = true;
				ct.pto.Partial_Day_5__c = true;
				ct.lunch1 = 'NO';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'NO';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'NO';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				ct.lunch4 = 'NO';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				ct.lunch5 = 'NO';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';
				ct.updatePTO();
				
		        
	        }
        }
        
        public static testmethod void testcreateNewPTOMultiDayEdit4c(){
		
			Profile pro = [SELECT Id FROM Profile WHERE Name = 'VinSystem Admin'];
    	
    		User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
	        insert u_testMethodUser;
	         Profile stdpro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
	        	        	        	        User emp_testMethodEMp = new User(alias = 'testMeth', email = 'testMethodEmp@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method Emp', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = stdpro.Id, UserRoleId = '00E70000001GBsB',
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodEmp@salesforce.com');

	        insert emp_testMethodEMp;

	        System.runas(u_testMethodUser){
			
				SFDC_Paid_Time_Off__c pto = new SFDC_Paid_Time_Off__c();
				
				pto.Hours_to_be_Used__c = 8;
		     	//pto.RecordTypeId = '012S00000008sJt';  //sandbox
     			pto.RecordTypeId = '01270000000Q9sG';  //prod
		     	pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				pto.Time_Off_Balance__c = 'a067000000aBdaI';
		     	pto.Multi_Day_From__c = system.today();
				pto.Multi_Day_To__c = system.today().addDays(1);
		     	pto.From__c = system.today();
		     	pto.To__c = system.today().addDays(1);
		     	
		     	insert pto;
				
				ApexPages.Standardcontroller sc = new ApexPages.Standardcontroller(pto);
				ApexPages.currentPage().getParameters().put('avail', '150');
				ApexPages.currentPage().getParameters().put('recordId', pto.Id);
				PTO_PageOneEmpDays ct = new PTO_PageOneEmpDays(sc);

		        ct.balId = 'a067000000aBdaI';
				ct.pto.Employee_s_Name__c = emp_testMethodEMp.Id;//'00570000003L0mn';
				ct.days = 'Multiple Days';
				ct.pto.Multi_Day_From__c = system.today();
				ct.pto.Multi_Day_To__c = system.today().addDays(4);
				ct.pto.Partial_Day_1__c = true;
				ct.pto.Partial_Day_2__c = true;
				ct.pto.Partial_Day_3__c = true;
				ct.pto.Partial_Day_4__c = true;
				ct.pto.Partial_Day_5__c = true;
				ct.lunch1 = 'YES';
				ct.multiDayPartialDay1StartTime = '7.00';
				ct.multiDayPartialDay1EndTime = '13.00';
				ct.lunch2 = 'YES';
				ct.multiDayPartialDay2StartTime = '7.00';
				ct.multiDayPartialDay2EndTime = '13.00';
				ct.lunch3 = 'YES';
				ct.multiDayPartialDay3StartTime = '7.00';
				ct.multiDayPartialDay3EndTime = '13.00';
				ct.lunch4 = 'YES';
				ct.multiDayPartialDay4StartTime = '7.00';
				ct.multiDayPartialDay4EndTime = '13.00';
				ct.lunch5 = 'YES';
				ct.multiDayPartialDay5StartTime = '7.00';
				ct.multiDayPartialDay5EndTime = '13.00';
				ct.updatePTO();
				
		        
	        }
        }
 }