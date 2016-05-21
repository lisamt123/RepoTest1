@isTest(SeeAllData=true)
private class ATLeadToVinSF_TEST {

    static testMethod void myUnitTest() {
    	
    Messaging.Inboundemail email = new Messaging.Inboundemail();
	Messaging.Inboundemail email2 = new Messaging.Inboundemail();
	Messaging.Inboundemail email3 = new Messaging.Inboundemail();
	Messaging.Inboundenvelope env = new Messaging.Inboundenvelope();	
	
	email.subject = 'test atc lead';
	email.fromName = 'test lead submitter';
	email.fromAddress = 'dean.lukowski@vinsolutions.com';
	email.plainTextBody = 'Dealer Name: Test Delaer 2\n'
	+ 'Dealer Contact First Name: Test\n'
	+ 'Dealer Contact Last Name: Tester\n'
	+ 'Dealer Contact Number: (555) 555-555\n'
	+ 'Dealer Billing Street: 123 Elm\n'
	+ 'Dealer Billing City: KC\n'
	+ 'Dealer Billing State: MO\n'
	+ 'Dealer Billing Zip: 64093\n'
	+ 'vAuto Status: Prospect\n'
	+ 'VinSolutions Status: Prospect\n'
	+ 'HomeNet Status: Prospect\n'
	+ 'ATC Status: Prospect\n'
	+ 'KBB Status: Prospect\n'
	+ 'Product Type: Haystak\n'
	+ 'Referral Notes: \nTest Notes'
	+ 'Referral Submitted by: Test Tester\n'
	+ 'Submitter Phone: (999) 999-9999\n'
	+ 'Submitter Email: 1@2.com\n';
	
	email2.subject = 'test atc lead';
	email2.fromName = 'test lead submitter';
	email2.fromAddress = 'dean.lukowski@vinsolutions.com';
	email2.htmlBody = 'Dealer Name: Test Delaer 2\n'
	+ 'Dealer Contact First Name: Test\n'
	+ 'Dealer Contact Last Name: Tester\n'
	+ 'Dealer Contact Number: (555) 555-555\n'
	+ 'Dealer Billing Street: 123 Elm\n'
	+ 'Dealer Billing City: KC\n'
	+ 'Dealer Billing State: MO\n'
	+ 'Dealer Billing Zip: 64093\n'
	+ 'vAuto Status: Prospect\n'
	+ 'VinSolutions Status: Prospect\n'
	+ 'HomeNet Status: Prospect\n'
	+ 'ATC Status: Prospect\n'
	+ 'KBB Status: Prospect\n'
	+ 'Product Type: VinSolutions\n'
	+ 'Referral Notes: \nTest Notes'
	+ 'Referral Submitted by: Test Tester\n'
	+ 'Submitter Phone: (999) 999-9999\n'
	+ 'Submitter Email: 1@2.com\n';
	
	/*email3.subject = 'test lead';
	email3.fromName = 'test lead submitter';
	email3.fromAddress = 'dean.lukowski@vinsolutions.com';
	email3.plainTextBody = '';
	email3.htmlBody = '';*/
	
	ATLeadToVinSF emailProcess = new ATLeadToVinSF();
	emailProcess.handleInboundEmail(email, env);
	emailProcess.handleInboundEmail(email2, env);
	//emailProcess.handleInboundEmail(email3, env);
        
    }
}