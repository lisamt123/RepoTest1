@isTest(SeeAllData=true)
private class VGLLeadToSD_Test {

    static testMethod void myUnitTest() {
    	
    Messaging.Inboundemail email = new Messaging.Inboundemail();
	Messaging.Inboundemail email2 = new Messaging.Inboundemail();
	Messaging.Inboundemail email3 = new Messaging.Inboundemail();
	Messaging.Inboundenvelope env = new Messaging.Inboundenvelope();	
	
	email.subject = 'test vgl lead';
	email.fromName = 'test lead submitter';
	email.fromAddress = 'dean.lukowski@vinsolutions.com';
	email.plainTextBody = 'Dealer Name: Test Delaer 2\n'
	+ 'Dealer Contact First Name: Test\n'
	+ 'Dealer Contact Last Name: Tester\n'
	+ 'Dealer Contact Phone: (555) 555-555\n'
	+ 'Dealer Contact Mobile Phone: (444) 444-4444\n'
	+ 'Dealer Contact Email: 1@2.com\n'
	+ 'Dealer Street: 1625 S. Fordham #400\n'
	+ 'Dealer City: Longmont\n'
	+ 'Dealer State: CO\n'
	+ 'Dealer Zip: 80503\n'
	+ '*****Urgency: Hot Transfer\n'
	+ 'Product of Interest: VGL\n'
	+ 'Notes: Test Notes\n'
	+ 'Demo Scheduled: 2011-01-10\n'
	+ 'Referred by: Test Tester\n'
	+ 'Submitter : Test Submitter\n'
	+ 'Submitter BU: \n';
	
	email2.subject = 'test vgl lead';
	email2.fromName = 'test lead submitter';
	email2.fromAddress = 'dean.lukowski@vinsolutions.com';
	email2.htmlBody = 'Dealer Name: Test Delaer 2\n'
	+ 'Dealer Contact First Name: Test\n'
	+ 'Dealer Contact Last Name: Tester\n'
	+ 'Dealer Contact Number: (555) 555-555\n'
	+ 'Dealer Contact Mobile Phone: (444) 444-4444\n'
	+ 'Dealer Contact Email: 1@2.com\n'
	+ 'Dealer Street: 123 Elm\n'
	+ 'Dealer City: KC\n'
	+ 'Dealer State: MO\n'
	+ 'Dealer Zip: 64093\n'
	+ '*****Urgency: High\n'
	+ 'Product of Interest: VGL\n'
	+ 'Notes: Test Notes\n'
	+ 'Demo Scheduled: 2011-01-10\n'
	+ 'Referred by: Test Tester\n'
	+ 'Submitter : Test Submitter\n'
	+ 'Submitter BU: \n';
	
	VGLLeadToSD emailProcess = new VGLLeadToSD();
	emailProcess.handleInboundEmail(email, env);
	emailProcess.handleInboundEmail(email2, env);
    }
}