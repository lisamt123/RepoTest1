@isTest(SeeAllData=True)
private class case_ctrl_listView_test {

    static testMethod void myUnitTest() {
        
        Profile pro = [SELECT Id FROM Profile WHERE Name = 'Standard User'];
        
        User u_testMethodUser = new User(alias = 'testMeth', email = 'testMethodUser@salesforce.com',
        	emailencodingkey = 'UTF-8', lastname = 'Test Method User', languagelocalekey = 'en_US',
        	localesidkey = 'en_US', profileid = pro.Id, 
        	timezonesidkey = 'America/Los_Angeles', username = 'testMethodUser@salesforce.com');
        	
        insert u_testMethodUser;
        
        System.runas(u_testMethodUser) {
        	
        	Case c = new Case();
        	
        	insert c;
        	
        	Case_Runner__c cr = new Case_Runner__c();
			cr.Runner_Action__c = 'Escalate';
			cr.Escalated_To__c = 'Creative';
			//cr.Assigned_To__c = userinfo.getUserId();
			cr.Case__c = c.Id;
			 
			insert cr;  
			
			CaseComment cc = new CaseComment();
			cc.CommentBody = 'Test Comment Public';
			cc.IsPublished = true;
			cc.ParentId = c.Id;
			
			insert cc;
        	
        	CaseComment cc2 = new CaseComment();
			cc2.CommentBody = 'Test Comment Private';
			cc2.IsPublished = false;
			cc2.ParentId = c.Id;
			
			insert cc2;
			
			EmailMessage em = new EmailMessage();
			em.Status = '3';
			em.Subject = 'Test';
			em.ToAddress = 'dean.lukowski@vinsolutions.com';
			em.TextBody = 'TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest';
			em.ParentId = c.Id;
			
			insert em;
			
			EmailMessage em2 = new EmailMessage();
			em2.Status = '3';
			em2.Subject = 'Test'; 
			em2.ToAddress = 'dean.lukowski@vinsolutions.com';
			em2.TextBody = 'Test';
			em2.ParentId = c.Id;
			
			insert em2;
        	
        	
        	ApexPages.StandardController sc = new ApexPages.Standardcontroller(c);
        	
        	
        	case_ctrl_listView controller = new case_ctrl_listView(sc);
        	
        	/*
        	ApexPages.currentPage().getParameters().put('toDate', '2013-03-25');        	
        	*/
        	test.startTest();
        	
        	controller.selectedFilter = 'displayCaseRunners';
        	controller.toggleFilter();
        	controller.toggleFilter();
        	
			controller.displayCaseComments = true;
        	controller.selectedFilter = 'displayCaseComments';
        	controller.toggleFilter();
        	controller.toggleFilter();
        	
			controller.displayCaseHistory = true;
        	controller.selectedFilter = 'displayCaseHistory';
        	controller.toggleFilter();
        	controller.toggleFilter();
        	
			controller.displayActivityHistory = true;
        	controller.selectedFilter = 'displayActivityHistory';
        	controller.toggleFilter();
        	controller.toggleFilter();
        	
			controller.displayCaseEmails = true;
        	controller.selectedFilter = 'displayCaseEmails';
        	controller.toggleFilter();
        	controller.toggleFilter();
        	
        	controller.showAllNone();
        	controller.isShowAll = false;
        	controller.showAllNone();
        	
        	controller.toggleSort();
        	controller.isASC = true;
        	controller.toggleSort();
        	
        	controller.nullPR();
        	controller.showMoreLess();
        	controller.isScroll = true;
        	controller.showMoreLess();
        	
        	test.stopTest();
        }
    }
}