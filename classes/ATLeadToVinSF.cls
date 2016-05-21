/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 */
global class ATLeadToVinSF implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();

        //Set string to pull out HTML to insert in fields in VIN
        String companyNameString = 'Dealer Name:';
    	String contactFirstNameString = 'Dealer Contact First Name:';
    	String contactLastNameString = 'Dealer Contact Last Name:';
    	String phoneString ='Dealer Contact Number:';
        String billingStreetString = 'Dealer Billing Street:';
        String billingCityString = 'Dealer Billing City:';
        String billingStateString = 'Dealer Billing State:';
        String billingZipString = 'Dealer Billing Zip:';
        String vAutoStatusString = 'vAuto Status:';
        String vinStatusString = 'VinSolutions Status:';
        String homeNetStatusString = 'HomeNet Status:';
        String atcStatusString = 'ATC Status:';
        String kbbStatusString = 'KBB Status:';
        String productDesiredString = 'Product Type:';
        String referralNotesString = 'Referral Notes: \n';
        String leadOwnerString = 'Referral Submitted by:';
        String leadOwnerPhoneString = 'Submitter Phone:';
        String leadOwnerEmailString = 'Submitter Email:';

        String body = '';

        try{
        	body = removeHTML(email.htmlBody);
        }
        catch(Exception ex){
        	body = removeHTML(email.plainTextBody);
        }

        String nameValue = 'No Comapany/Account Provided';
        String contactValue = 'No Contact Provided';
        String contactFirstNameValue = '';
        String contactLastNameValue = '';
        String phoneValue = '0000000000';
        String streetValue = 'No Street Provided';
        String cityValue = 'No City Provided';
        String stateValue = 'NA';
        String zipValue = '';
        String vAutoStatusValue = '';
        String vinStatusValue = '';
        String homeNetStatusValue = '';
        String atcStatusValue = '';
        String kbbStatusValue = '';
        String productDesiredValue = '';
        String referralNotesValue = '';
        String leadOwnerValue = '';
        String leadOwnerPhoneValue = '';
        String leadOwnerEmailValue = '';

        Lead newLead = new Lead();
        //get dealer name
        nameValue = body.substringBetween(companyNameString, '\n');
        //get contact first name
        contactFirstNameValue = body.substringBetween(contactFirstNameString, '\n');
        //get contact last name
        contactLastNameValue = body.substringBetween(contactLastNameString, '\n');
    	//get phone
    	phoneValue = body.substringBetween(phoneString, '\n');
    	//get street
    	streetValue = body.substringBetween(billingStreetString, '\n');
    	//get city
    	cityValue = body.substringBetween(billingCityString, '\n');
    	//get state
    	stateValue = body.substringBetween(billingStateString, '\n');
    	//get zip
    	zipValue = body.substringBetween(billingZipString, '\n');
    	//get vAuto status
    	vAutoStatusValue = body.substringBetween(vAutoStatusString, '\n');
    	//get vin status
    	vinStatusValue = body.substringBetween(vinStatusString, '\n');
    	//get homeNet status
    	homeNetStatusValue = body.substringBetween(homeNetStatusString, '\n');
    	//get atc status
    	atcStatusValue = body.substringBetween(atcStatusString, '\n');
    	//get kbb status
    	kbbStatusValue = body.substringBetween(kbbStatusString, '\n');
    	//get desired product
    	productDesiredValue = body.substringBetween(productDesiredString, '\n');
    	//get notes
    	referralNotesValue = body.substringBetween(referralNotesString, leadOwnerString);
    	//get lead owner
    	leadOwnerValue = body.substringBetween(leadOwnerString, '\n');
    	//get lead owner cell phone
    	leadOwnerPhoneValue = body.substringBetween(leadOwnerPhoneString, '\n');
        //get lead owner email
        leadOwnerEmailValue = body.substringAfter(leadOwnerEmailString);
    	
    	newLead.Company = nameValue;
    	newLead.FirstName = contactFirstNameValue;
    	newLead.LastName = contactLastNameValue;
    	newLead.Phone = phoneValue;
    	newLead.Street = streetValue;
    	newLead.City = cityValue;
    	newLead.State = stateValue;
    	newLead.PostalCode = zipValue;
    	newLead.vAuto_Status__c = vAutoStatusValue;
    	newLead.Vin_Status__c = vinStatusValue;
    	newLead.HomeNet_Status__c = homeNetStatusValue;
    	newLead.ATC_Status__c = atcStatusValue;
    	newLead.KBB_Status__c = kbbStatusValue;
    	newLead.Opp_Type__c = productDesiredValue;
    	newLead.ImportedNotes__c = referralNotesValue;
        newLead.Affiliate__c = 'AutoTrader';
    	newLead.Affiliate_Name__c = leadOwnerValue;
    	newLead.Affiliate_Phone__c = leadOwnerPhoneValue;
        newLead.Affiliate_Email__c = leadOwnerEmailValue;
    	newLead.LeadSource = 'ATG';
    	if(productDesiredValue.contains('Haystak')){
            newLead.Business_Unit__c = 'Haystak';
        }
        else if(productDesiredValue.contains('vAuto')){
            newlead.Business_Unit__c = 'vAuto';
        }
        else{
            newLead.Business_Unit__c = 'VinSolutions';
        }

    	insert newLead;
    	
        // Add lead to the AutoTrader Campaign
        Campaign atcCampaign = [select Id, Name, IsActive from Campaign where Name = 'AutoTrader Leads' AND isActive = true limit 1];
    	CampaignMember mem = new CampaignMember (campaignid=atcCampaign.id, leadid=newlead.id);
        insert mem;

        return result;
        
        
    }
    
    public static String removeHTML(String source){
        	String html = source;
        	//replace all <br> tags with \n to support new lines
        	string result = html.replaceAll('<br/>', '\n');
        	result = result.replaceAll('<br/>', '\n');
        	result = result.replaceAll('</p>', '\n');
        	result = result.replaceAll('~~EOL~~', '\n');
        	result = result.replaceAll('&nbsp;', '');
        	
        	//regular expression to match all HTML/XML tags
        	string HTML_TAG_PATTERN = '<,*?>';
        	
        	//complie the pattern
        	pattern myPattern = pattern.compile(HTML_TAG_PATTERN);
        	
        	//get your matcher instance
        	matcher myMatcher = myPattern.matcher(result);
        	//remove tags
        	result = myMatcher.replaceAll('');
        	return result;
        }
}