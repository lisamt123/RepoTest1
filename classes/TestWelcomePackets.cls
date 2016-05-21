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
@isTest
private class TestWelcomePackets {

    //TESTING++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    public static testmethod void testWebsitePackets()
    {
    	Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        W.Check_To_Upload_Graphics_Custom_Content__c=true;
        insert W;
        
        PageReference testStart = Page.WebsitePacketStart;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);
        
        
        WebsitePacket WbPW = new WebsitePacket();
        
        Welcome_Packet__c WP = WbPW.getWelcome();    
        
        WbPW.backToStart();
        WbPW.cancel();
        WbPW.complete();
        WbPW.getAccount();
        WbPW.getWelcome();
        WbPW.goBack();
        WbPW.toPage1();
        WbPW.toPage1x5();
        WbPW.toPage2();
        WbPW.toPage3();
        WbPW.toPage4();
        
		Test.setCurrentPage(Page.WebsitePacketPage1);		
		WbPW.goBack();
		Test.setCurrentPage(Page.WebsitePacketPage1x5);		
		WbPW.goBack();
		Test.setCurrentPage(Page.WebsitePacketPage2);		
		WbPW.goBack();
        Test.setCurrentPage(Page.WebsitePacketPage3);		
		WbPW.goBack();
		Test.setCurrentPage(Page.WebsitePacketPage4);		
		WbPW.goBack();
        
        W.Check_To_Upload_Graphics_Custom_Content__c=false;
        update W;
        
        Test.setCurrentPage(Page.WebsitePacketPage2);
        WbPW.toPage1x5();
       	WbPW.goBack();
    }
    
    
    
    public static testmethod void testPackets()
    {
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);
        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WPW.cancel();
        WPW.complete();
        WPW.confirmCRM();
        WPW.getAccount();
        WPW.start();
        WPW.step1();
        WPW.step2();
        WPW.step3();
        WPW.step4();
        WPW.step5();
        WPW.step6();
        WPW.step7();
        WPW.step8();
        WPW.step9();
        WPW.step10();
        WPW.step11();
        WPW.step12();
        WPW.step13();
        
        WP.Packet_Includes__c = 'CRM';
        WPW.cancel();
        WPW.complete();
        WPW.confirmCRM();
        WPW.getAccount();
        WPW.start();
        WPW.step1();
        WPW.step2();
        WPW.step3();
        WPW.step4();
        WPW.step5();
        WPW.step6();
        WPW.step7();
        WPW.step8();
        WPW.step9();
        WPW.step10();
        WPW.step11();
        WPW.step12();
        WPW.step13();
        
        WP.Secondary_Packet_Includes__c = '';
        WPW.jumpToInventoryVerification();
        WP.Secondary_Packet_Includes__c = 'test';
        WPW.jumpToInventoryVerification();
        WP.Secondary_Packet_Includes__c = 'inventory verification';
        WPW.jumpToInventoryVerification();
        
        WP.Secondary_Packet_Includes__c = 'test';
        WPW.jumpToMotoBlast();
        WP.Secondary_Packet_Includes__c = 'motoblast';
        WPW.jumpToMotoBlast();
        WP.Secondary_Packet_Includes__c = 'Inventory Verification';
        WPW.jumpToMotoBlast();
        WP.Secondary_Packet_Includes__c = 'Website';
        WPW.jumpToMotoBlast();
        WP.Secondary_Packet_Includes__c = '';
        WPW.jumpToMotoBlast();
        
        WPW.confirmWebsite();        
        WPW.secondaryComplete();
        
        WP.Jump_to__c = '';        
        WPW.jumpTo();	
        WP.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'ACCOUNT SET UP FORM (Page 1)';        
        WPW.jumpTo();       
        WP.Jump_to__c = 'ACCOUNT SET UP FORM (Page 2)';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'INVENTORY';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'THIRD PARTY EXPORTS';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'PREDEFINED EXPORTS';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'DMS PUSHING';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'ROUTE ONE / DEALERTRACK';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'MINIMUM SYSTEM REQUIRMENTS';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'SOLD DATA';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'UNSOLD (CRM) PROSPECT DATA';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'STANDARD FORMS REQUEST SHEET';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'CUSTOM FORMS';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'ILM CRM Inventory User Access';        
        WPW.jumpTo();        
        WP.Jump_to__c = 'Confirmation Page';        
        WPW.jumpTo();
        
        WP.Packet_Includes__c = 'CRM';
        WPW.startPointCheck();
        
        WP.Packet_Includes__c = null;
        WPW.startPointCheck();
        
        WP.Packet_Includes__c = 'Website';
        WPW.startPointCheck(); 
         
        WP.Secondary_Packet_Includes__c = 'Website';
        WPW.secondaryStartPointCheck(); 
        WP.Secondary_Packet_Includes__c = 'motoblast';
        WPW.secondaryStartPointCheck();  
        WP.Secondary_Packet_Includes__c = 'Inventory verification';
        WPW.secondaryStartPointCheck();  
        WP.Secondary_Packet_Includes__c = 'test';
        WPW.secondaryStartPointCheck();  
        WP.Secondary_Packet_Includes__c = '';
        WPW.secondaryStartPointCheck();  
         
        WP.Secondary_Packet_Includes__c = '';
        WPW.jumpBackFromConfirm();
        WP.Secondary_Packet_Includes__c = 'test';
        WPW.jumpBackFromConfirm();
        WP.Secondary_Packet_Includes__c = 'website';
        WPW.jumpBackFromConfirm();
        WP.Secondary_Packet_Includes__c = 'inventory verification';
        WPW.jumpBackFromConfirm();
        WP.Secondary_Packet_Includes__c = 'motoblast';
        WPW.jumpBackFromConfirm();
        
        WP.Secondary_Packet_Includes__c = '';
        WPW.jumpBackFromInventory();
        WP.Secondary_Packet_Includes__c = 'test';
        WPW.jumpBackFromInventory();
        WP.Secondary_Packet_Includes__c = 'website';
        WPW.jumpBackFromInventory();
        WP.Secondary_Packet_Includes__c = 'motoblast';
        WPW.jumpBackFromInventory();
        
        WP.Secondary_Packet_Includes__c = '';
        WPW.jumpBackFromMotoBlast();
        WP.Secondary_Packet_Includes__c = 'test';
        WPW.jumpBackFromMotoBlast();
        WP.Secondary_Packet_Includes__c = 'website';
        WPW.jumpBackFromMotoBlast();
        
        WPW.jumpBackFromWebsite();
        WP.Secondary_Packet_Includes__c = '';  
        WPW.jumpBackFromWebsite();
        
        WPW.uploadUser();  
        WPW.saveQuitWeb();
       
        WPW.getTotal();
        
        WP.Jump_to__c='PREDEFINED EXPORTS';
        WP.Packet_Includes__c='DIY';
        WPW.skipSteps();
        WPW.skipBackSteps();
        WP.Packet_Includes__c='CRM';
        WPW.skipSteps();
        WPW.skipBackSteps();
        
        WP.Jump_to__c='MINIMUM SYSTEM REQUIRMENTS';
        WP.Packet_Includes__c='DIY';
        WPW.skipSteps();
        WPW.skipBackSteps();
        WP.Packet_Includes__c='CRM';
        WPW.skipSteps();
        WPW.skipBackSteps();
        
        WP.Jump_to__c='UNSOLD (CRM) PROSPECT DATA';
        WP.Packet_Includes__c='ILM';
        WPW.skipSteps();
        WPW.skipBackSteps();
        WP.Packet_Includes__c='CRM';
        WPW.skipSteps();
        WPW.skipBackSteps();
        
        WP.Jump_to__c='PREDEFINED EXPORTS';
        WP.Packet_Includes__c='Website';
        WPW.skipSteps();
        WPW.skipBackSteps();
        WP.Packet_Includes__c='CRM';
        WP.Jump_to__c='MINIMUM SYSTEM REQUIRMENTS';        
        WPW.skipBackSteps();
        
        WP.Jump_to__c='ACCOUNT SET UP FORM (Page 1)';
        WP.Packet_Includes__c='Website';
        WPW.skipSteps();
        
        WP.Jump_to__c='ILM CRM Inventory User Access';
        WP.Packet_Includes__c='CRM';
        WPW.skipBackSteps();
        
        WP.Additional_Form_1__c='test';
        WPW.getTotal();
        WP.Additional_Form_2__c='test';
        WPW.getTotal();
        WP.Additional_Form_3__c='test';
        WPW.getTotal();
        WP.Additional_Form_4__c='test';
        WPW.getTotal();
        WP.Additional_Form_5__c='test';
        WPW.getTotal();
        WP.Additional_Form_6__c='test';
        WPW.getTotal();   
        WPW.step1();           
        
    }
    public static testmethod void testPickedPackets()
    {
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        WP.Pick_Your_Packet__c = 'TEST';
        WP.Pick_Your_Packet__c = 
        'ACCOUNT SET UP FORM (Page 1);'+
        'ACCOUNT SET UP FORM (Page 2);'+
		'INVENTORY;'+
		'THIRD PARTY EXPORTS;'+
		'PREDEFINED EXPORTS;'+
		'DMS PUSHING;'+
		'ROUTE ONE / DEALERTRACK;'+
		'MINIMUM SYSTEM REQUIRMENTS;'+
		'SOLD DATA;'+
		'UNSOLD (CRM) PROSPECT DATA;'+
		'STANDARD FORMS REQUEST SHEET;'+
		'CUSTOM FORMS;'+
		'Add User List';
        WPW.startPointCheck();
        WPW.step2();        
        WPW.step1();
        
        WPW.step3();
        WPW.step2();
        
        WPW.step4();
        WPW.step3();
        
        WPW.step5();
        WPW.step4();
        
        WPW.step6();
        WPW.step5();
        
        WPW.step7();
        WPW.step6();
        
        WPW.step8();
        WPW.step7();
        
        WPW.step9();
        WPW.step8();
        
        WPW.step10();
        WPW.step9();
        
        WPW.step11();
        WPW.step10();
        
        WPW.step12();
        WPW.step11();
        
        WPW.step13();
        WPW.step12();
        
        WPW.step2();
        PageReference jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedAccountSetUp1()
    {
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //ACCOUNT SET UP FORM (Page 1) TESTS =====================================
        WP.Pick_Your_Packet__c = 
        'ACCOUNT SET UP FORM (Page 1);'+
        'ACCOUNT SET UP FORM (Page 2);'+
		'INVENTORY;'+
		'THIRD PARTY EXPORTS;'+
		'PREDEFINED EXPORTS;'+
		'DMS PUSHING;'+
		'ROUTE ONE / DEALERTRACK;'+
		'MINIMUM SYSTEM REQUIRMENTS;'+
		'SOLD DATA;'+
		'UNSOLD (CRM) PROSPECT DATA;'+
		'STANDARD FORMS REQUEST SHEET;'+
		'CUSTOM FORMS;'+
		'Add User List';
        
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedAccountSetUp2()
    {
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //ACCOUNT SET UP FORM (Page 2) TESTS =====================================
        WP.Pick_Your_Packet__c = 'ACCOUNT SET UP FORM (Page 2)';
        WP.Pick_Your_Packet__c = 
        'ACCOUNT SET UP FORM (Page 1);'+
        'ACCOUNT SET UP FORM (Page 2);'+
		'INVENTORY;'+
		'THIRD PARTY EXPORTS;'+
		'PREDEFINED EXPORTS;'+
		'DMS PUSHING;'+
		'ROUTE ONE / DEALERTRACK;'+
		'MINIMUM SYSTEM REQUIRMENTS;'+
		'SOLD DATA;'+
		'UNSOLD (CRM) PROSPECT DATA;'+
		'STANDARD FORMS REQUEST SHEET;'+
		'CUSTOM FORMS;'+
		'Add User List';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedINVENTORY()
    {
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        //INVENTORY TESTS =====================================
        WP.Pick_Your_Packet__c = 'INVENTORY';
        WP.Pick_Your_Packet__c = 
        'ACCOUNT SET UP FORM (Page 1);'+
        'ACCOUNT SET UP FORM (Page 2);'+
		'INVENTORY;'+
		'THIRD PARTY EXPORTS;'+
		'PREDEFINED EXPORTS;'+
		'DMS PUSHING;'+
		'ROUTE ONE / DEALERTRACK;'+
		'MINIMUM SYSTEM REQUIRMENTS;'+
		'SOLD DATA;'+
		'UNSOLD (CRM) PROSPECT DATA;'+
		'STANDARD FORMS REQUEST SHEET;'+
		'CUSTOM FORMS;'+
		'Add User List';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedTHIRDPARTYEXPORTS()
    {
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //THIRD PARTY EXPORTS TESTS =====================================
        WP.Pick_Your_Packet__c = 'THIRD PARTY EXPORTS';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    
    public static testmethod void testPickedPREDEFINEDEXPORTS()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //PREDEFINED EXPORTS TESTS =====================================
        WP.Pick_Your_Packet__c = 'PREDEFINED EXPORTS';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedDMSPUSHING()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //DMS PUSHING TESTS =====================================
        WP.Pick_Your_Packet__c = 'DMS PUSHING';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedROUTEONEDEALERTRACK()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //ROUTE ONE / DEALERTRACK TESTS =====================================
        WP.Pick_Your_Packet__c = 'ROUTE ONE / DEALERTRACK';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedMINIMUMSYSTEMREQUIRMENTS()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //MINIMUM SYSTEM REQUIRMENTS TESTS =====================================
        WP.Pick_Your_Packet__c = 'MINIMUM SYSTEM REQUIRMENTS';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedSOLDDATA()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //SOLD DATA TESTS =====================================
        WP.Pick_Your_Packet__c = 'SOLD DATA';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedUNSOLDCRMPROSPECTDATA()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //UNSOLD (CRM) PROSPECT DATA TESTS =====================================
        WP.Pick_Your_Packet__c = 'UNSOLD (CRM) PROSPECT DATA';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedSTANDARDFORMSREQUESTSHEET()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //STANDARD FORMS REQUEST SHEET TESTS =====================================
        WP.Pick_Your_Packet__c = 'STANDARD FORMS REQUEST SHEET';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedCUSTOMFORMS()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //CUSTOM FORMS TESTS =====================================
        WP.Pick_Your_Packet__c = 'CUSTOM FORMS';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }
    public static testmethod void testPickedILMCRMInventoryUserAccess()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //ILM CRM Inventory User Access TESTS =====================================
        WP.Pick_Your_Packet__c = 'ILM CRM Inventory User Access';
        WP.Pick_Your_Packet__c = 
        'ACCOUNT SET UP FORM (Page 1);'+
        'ACCOUNT SET UP FORM (Page 2);'+
		'INVENTORY;'+
		'THIRD PARTY EXPORTS;'+
		'PREDEFINED EXPORTS;'+
		'DMS PUSHING;'+
		'ROUTE ONE / DEALERTRACK;'+
		'MINIMUM SYSTEM REQUIRMENTS;'+
		'SOLD DATA;'+
		'UNSOLD (CRM) PROSPECT DATA;'+
		'STANDARD FORMS REQUEST SHEET;'+
		'CUSTOM FORMS;'+
		'Add User List';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }    
    public static testmethod void testPickedCOMPLETE()
    {        
        Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = Page.Welcome_Packet_Start_Page;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        WelcomePacketWizard WPW = new WelcomePacketWizard();
        
        Welcome_Packet__c WP = WPW.getWelcome();    
        
        WP.Packet_Includes__c=null;
        
        //ILM CRM Inventory User Access TESTS =====================================
        WP.Pick_Your_Packet__c = 'Complete';
        WP.Pick_Your_Packet__c = 
        'ACCOUNT SET UP FORM (Page 1);'+
        'ACCOUNT SET UP FORM (Page 2);'+
		'INVENTORY;'+
		'THIRD PARTY EXPORTS;'+
		'PREDEFINED EXPORTS;'+
		'DMS PUSHING;'+
		'ROUTE ONE / DEALERTRACK;'+
		'MINIMUM SYSTEM REQUIRMENTS;'+
		'SOLD DATA;'+
		'UNSOLD (CRM) PROSPECT DATA;'+
		'STANDARD FORMS REQUEST SHEET;'+
		'CUSTOM FORMS;'+
		'Add User List';
        WPW.startPointCheck();
        PageReference jumpPage = Page.welcome_packet_page_1;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        jumpPage = Page.welcome_packet_page_2;
        Test.setCurrentPage(jumpPage); 
        WPW.step1();
        
        WPW.step3();
        jumpPage = Page.welcome_packet_page_3;
        Test.setCurrentPage(jumpPage); 
        WPW.step2();
        
        WPW.step4();
        jumpPage = Page.welcome_packet_page_4;
        Test.setCurrentPage(jumpPage); 
        WPW.step3();
        
        WPW.step5();
        jumpPage = Page.welcome_packet_page_5;
        Test.setCurrentPage(jumpPage); 
        WPW.step4();
        
        WPW.step6();
        jumpPage = Page.welcome_packet_page_6;
        Test.setCurrentPage(jumpPage); 
        WPW.step5();
        
        WPW.step7();
        jumpPage = Page.welcome_packet_page_7;
        Test.setCurrentPage(jumpPage); 
        WPW.step6();
        
        WPW.step8();
        jumpPage = Page.welcome_packet_page_8;
        Test.setCurrentPage(jumpPage); 
        WPW.step7();
        
        WPW.step9();
        jumpPage = Page.welcome_packet_page_9;
        Test.setCurrentPage(jumpPage); 
        WPW.step8();
        
        WPW.step10();
        jumpPage = Page.welcome_packet_page_10;
        Test.setCurrentPage(jumpPage); 
        WPW.step9();
        
        WPW.step11();
        jumpPage = Page.welcome_packet_page_11;
        Test.setCurrentPage(jumpPage); 
        WPW.step10();
        
        WPW.step12();
        jumpPage = Page.welcome_packet_page_12;
        Test.setCurrentPage(jumpPage); 
        WPW.step11();
        
        WPW.step13();
        jumpPage = Page.welcome_packet_page_13;
        Test.setCurrentPage(jumpPage); 
        WPW.step12();
    }    
}