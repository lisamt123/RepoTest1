global class ATC_Lead_Generation_Email_Service implements Messaging.InboundEmailHandler {

    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        
        String accountIdString = 'Account ID:';
        String companyAccountString = 'Account:';
        String streetString = 'Street:';
        String cityString = 'City:';
        String stateProvinceString = 'Province:';
        String zipPostalCodeString = 'Postal Code:';
        String websiteString = 'Website:';
        String firstNameString = 'First Name:';
        String lastNameString = 'Last Name:';
        String titleString = 'Title:';        
        String phoneString = 'Phone:';
        String emailString = 'Email:';
        String uvspmString = 'Used vehicle sales per month:';
        String atcatgString = 'ATC/ATG package:';
        String compprodString = 'Competitive product:';
        String affiliateString = 'Affiliate:';
        String affiliateEmailString = 'Affiliate Email:';
        String affiliateNameString = 'Affiliate Name:';
        String affiliatePhoneString = 'Affiliate Phone:';
        String atcDivisionString = 'ATC Division:';
        String atcRegionString = 'ATC Region:';
        String atcDistrictString = 'ATC District:';
        String secondaryContactString = 'Secondary Contact:';
        String secondaryEmailString = 'Secondary Email:';
        String secondaryPhoneString = 'Secondary Phone:';
        String importedNotesString = 'Imported Notes:';        
        
        String body= '';
        try
        {
        	body = removeHTML(email.htmlBody);        	
        }
        catch (Exception Ex)
        {
        	body = removeHTML(email.plainTextBody);
        }
        
        
        system.debug('BODY:  ' + body);
       
        integer lastIdx = body.length();   
        String snippet = '';
        String streetValue = 'No Street Provided';
		String companyAccountvalue = 'No Company/Account Provided';
		String cityValue = 'No City Provided';
		String stateProvinceValue = 'NA';
		String zipPostalCodeValue = '00000';
		String firstNameValue = 'NotProvided';
		String lastNameValue = 'NotProvided';
		String phonevalue = '';
		String emailValue = '';
		String uvspmvalue = '';
		String atcatgvalue= '';
		String compprodvalue = '';
		String titleValue = '';
		String affiliateValue = '';
		String affiliateEmailValue = '';
		String affiliateNameValue = '';
		String affiliatePhoneValue = '0000000000';
		String importedNotesValue = '';
		String accountIdValue = '';
		String websiteValue = '';
		String atcDivisionValue = '';
		String atcRegionValue = '';
		String atcDistrictValue = '';
		String secondaryContactValue = '';
		String secondaryEmailValue = '';
		String secondaryPhoneValue = '0000000000';
        
        Lead newlead = new Lead();
        
        try{
			integer companyAccountIdx = body.indexOf(companyAccountString);
			snippet = body.substring(companyAccountIdx, lastIdx);                
	        companyAccountValue = snippet.substring(companyAccountString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {        	
        	system.debug('companyAccountValue EXCEPTION FOUND: ' + ex);
        }
        
        try{
        	integer streetIdx = body.indexOf(streetString);
        	snippet = body.substring(streetIdx, lastIdx);
	        streetValue = snippet.substring(streetString.length(), snippet.indexOf('\n'));        	
        }
        catch (Exception ex)
        {        	
        	system.debug('streetValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer cityIdx  = body.indexOf(cityString);
        	snippet = body.substring(cityIdx, lastIdx);
	        cityValue = snippet.substring(cityString.length(), snippet.indexOf('\n'));        
        }
        catch (Exception ex)
        {        	
        	system.debug('cityValue EXCEPTION FOUND: ' + ex);        	
        }
        try{
        	integer stateProvinceIdx = body.indexOf(stateProvinceString);
        	snippet = body.substring(stateProvinceIdx, lastIdx);
	        stateProvinceValue = snippet.substring(stateProvinceString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {        	
        	system.debug('stateProvinceValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer zipPostalCodeIdx = body.indexOf(zipPostalCodeString);
        	snippet = body.substring(zipPostalCodeIdx, lastIdx);
	        zipPostalCodeValue = snippet.substring(zipPostalCodeString.length(), snippet.indexOf('\n'));             	
        }
        catch (Exception ex)
        {        	
        	system.debug('zipPostalCodeValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer firstNameIdx = body.indexOf(firstNameString);
        	snippet = body.substring(firstNameIdx, lastIdx);
	        firstNameValue = snippet.substring(firstNameString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {
        	system.debug('firstNameValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer lastNameIdx = body.indexOf(lastNameString);
        	snippet = body.substring(lastNameIdx, lastIdx);
	        lastNameValue = snippet.substring(lastNameString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {
        	system.debug('lastNameValue EXCEPTION FOUND: ' + ex);        	
        }
        try{
        	integer titleIdx = body.indexOf(titleString);
        	snippet = body.substring(titleIdx, lastIdx);
	        titleValue = snippet.substring(titleString.length(), snippet.indexOf('\n'));    
        }
        catch (Exception ex)
        {        	
        	system.debug('titleValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer phoneIdx = body.indexOf(phoneString);
        	snippet = body.substring(phoneIdx, lastIdx);
	        phoneValue = snippet.substring(phoneString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {        	
        	system.debug('phoneValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer emailIdx = body.indexOf(emailString);  
        	snippet = body.substring(emailIdx, lastIdx);
	        emailValue = snippet.substring(emailString.length(), snippet.indexOf('\n')).split('<mailto:', 2)[0];
        }
        catch (Exception ex)
        {        	
        	system.debug('emailValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer uvspmIdx = body.indexOf(uvspmString);
        	snippet = body.substring(uvspmIdx, lastIdx);
        	uvspmvalue = snippet.substring(uvspmString.length(), snippet.indexOf('\n')); 
        }
        catch (Exception ex)
        {
        	system.debug('Used vehicel sales per month EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer atcatgIdx = body.indexOf(atcatgString);
        	snippet = body.substring(atcatgIdx, lastIdx);
        	atcatgvalue = snippet.substring(atcatgString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {
        	system.debug('ATC/ATG EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer compprodIdx = body.indexOf(compprodString);
        	snippet = body.substring(compprodIdx, lastIdx);
        	compprodvalue = snippet.substring(compprodString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {
        	system.debug('Competitive Product EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer affiliateIdx = body.indexOf(affiliateString);
        	snippet = body.substring(affiliateIdx, lastIdx);
	        affiliateValue = snippet.substring(affiliateString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {        	
        	system.debug('affiliateValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer affiliateEmailIdx = body.indexOf(affiliateEmailString);
        	snippet = body.substring(affiliateEmailIdx, lastIdx);
	        affiliateEmailValue = snippet.substring(affiliateEmailString.length(), snippet.indexOf('\n')).split('<mailto:', 2)[0];
        }
        catch (Exception ex)
        {
        	system.debug('affiliateEmailValue EXCEPTION FOUND: ' + ex);
        }

        try{
        	integer affiliateNameIdx = body.indexOf(affiliateNameString);  
        	snippet = body.substring(affiliateNameIdx, lastIdx);
	        affiliateNameValue = snippet.substring(affiliateNameString.length(), snippet.indexOf('\n'));   
        }
        catch (Exception ex)
        {
			system.debug('affiliateNameValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer affiliatePhoneIdx  = body.indexOf(affiliatePhoneString);
        	snippet = body.substring(affiliatePhoneIdx, lastIdx);
	        affiliatePhoneValue = snippet.substring(affiliatePhoneString.length(), snippet.indexOf('\n'));
        }
        catch (Exception ex)
        {        
        	system.debug('affiliatePhoneValue EXCEPTION FOUND: ' + ex);
        }
        try{
        	integer importedNotesIdx = body.indexOf(importedNotesString);
        	snippet = body.substring(importedNotesIdx, lastIdx);	        
	        importedNotesValue = snippet.substring(importedNotesString.length(), snippet.length());
        }
        catch (Exception ex)
        {        	
        	system.debug('importedNotesValue EXCEPTION FOUND: ' + ex);
        }
		if (body.contains('Account ID:'))
		{
	        	
			try{
				integer accountIdIdx = body.indexOf(accountIdString);
				snippet = body.substring(accountIdIdx, lastIdx);
				accountIdValue = snippet.substring(accountIdString.length(), snippet.indexOf('\n'));	        	
	        }
	        catch (Exception ex)
	        {	        	
	        	system.debug('accountIdValue EXCEPTION FOUND: ' + ex);
	        }
	        try{
	        	integer websiteIdx = body.indexOf(websiteString);
				snippet = body.substring(websiteIdx, lastIdx);
				websiteValue = snippet.substring(websiteString.length(), snippet.indexOf('\n')).replaceAll('http://', '');	        	
	        }
	        catch (Exception ex)
	        {	        	
	        	system.debug('websiteValue EXCEPTION FOUND: ' + ex);
	        }
	        try{
	        	integer atcDivisionIdx = body.indexOf(atcDivisionString);
				snippet = body.substring(atcDivisionIdx, lastIdx);
				atcDivisionValue = snippet.substring(atcDivisionString.length(), snippet.indexOf('\n'));	        	
	        }
	        catch (Exception ex)
	        {	        	
	        	system.debug('atcDivisionValue EXCEPTION FOUND: ' + ex);
	        }
	        try{
	        	integer atcRegionIdx = body.indexOf(atcRegionString);
				snippet = body.substring(atcRegionIdx, lastIdx);
				atcRegionValue = snippet.substring(atcRegionString.length(), snippet.indexOf('\n'));	        	
	        }
	        catch (Exception ex)
	        {	        	
	        	system.debug('atcRegionValue EXCEPTION FOUND: ' + ex);
	        }
	        try{
	        	integer atcDistrictIdx = body.indexOf(atcDistrictString);
				snippet = body.substring(atcDistrictIdx, lastIdx);
				atcDistrictValue = snippet.substring(atcDistrictString.length(), snippet.indexOf('\n'));
	        }
	        catch (Exception ex)
	        {	        	
	        	system.debug('atcDistrictValue EXCEPTION FOUND: ' + ex);
	        }
	        try{
	        	integer secondaryContactIdx = body.indexOf(secondaryContactString);
				snippet = body.substring(secondaryContactIdx, lastIdx);
				secondaryContactValue = snippet.substring(secondaryContactString.length(), snippet.indexOf('\n'));	        	
	        }
	        catch (Exception ex)
	        {	        	
	        	system.debug('secondaryContactValue EXCEPTION FOUND: ' + ex);
	        }
	        try{
	        	integer secondaryEmailIdx = body.indexOf(secondaryEmailString);
				snippet = body.substring(secondaryEmailIdx, lastIdx);
				secondaryEmailValue = snippet.substring(secondaryEmailString.length(), snippet.indexOf('\n'));
	        }
	        catch (Exception ex)
	        {	        	
	        	system.debug('secondaryEmailValue EXCEPTION FOUND: ' + ex);
	        }
	        try{
	        	integer secondaryPhoneIdx = body.indexOf(secondaryPhoneString);
				snippet = body.substring(secondaryPhoneIdx, lastIdx);
				secondaryPhoneValue = snippet.substring(secondaryPhoneString.length(), snippet.indexOf('\n'));
	        }
	        catch (Exception ex)
	        {	        
	        	system.debug('secondaryPhoneValue EXCEPTION FOUND: ' + ex);
	        }
	    	newlead.Website = websiteValue;
	    }	    
			
		try
		{   
	        Campaign atcCampaign = [select Id, Name, IsActive from Campaign where Name = 'AutoTrader Leads' AND isActive = true limit 1];
	        
	        newlead.Company = companyAccountValue;
	        newlead.Street = streetValue;
	        newlead.City = cityValue;
	        newlead.State = stateProvinceValue;
	        newlead.PostalCode = zipPostalCodeValue;
	        newlead.FirstName = firstNameValue;
	        newlead.LastName = lastNameValue;
	        newlead.Title = titleValue;
	        newlead.Phone = phoneValue;
	        newlead.Email = emailValue;
	        newlead.Used_Vehicle_Sales_per_Month_avg__c = uvspmvalue;
	        newlead.Competitive_Product__c = compprodvalue;
	        newlead.ATC_ATG_Package__c = atcatgvalue;
	        newlead.Description = importedNotesValue;
	        newlead.LeadSource = 'Auto Trader.com';
	        newlead.Franchise_1__c = 'AutoTrader Lead';
	        newlead.ATC_District__c = atcDistrictValue;
	        newlead.ATC_Division__c = atcDivisionValue;
	        newlead.ATC_Region__c = atcRegionValue;
	        newlead.Dealer_ID__c = accountIdValue;
	        newlead.Affiliate__c = affiliateValue;
	        newlead.Affiliate_Email__c = affiliateEmailValue;
	        newlead.Affiliate_Name__c = affiliateNameValue;
	        newlead.Affiliate_Phone__c = affiliatePhoneValue;
	        newlead.Secondary_Contact__c = secondaryContactValue;
	        newlead.Secondary_Email__c = secondaryEmailValue;
	        newlead.Secondary_Phone__c = secondaryPhoneValue;
	        
			
			insert newlead;
			
			CampaignMember mem = new CampaignMember (campaignid=atcCampaign.id, leadid=newlead.id);
			
			insert mem;
			
        	try
        	{
	        	Attachment newAttachment = new Attachment();
		        newAttachment.ParentId = newlead.Id;
		        
		        newAttachment.Body = Blob.valueOf(body);
		        newAttachment.Name = 'Lead Email.txt';
		        newAttachment.ContentType = 'text';
		        	        
		        insert newAttachment;
        	}
        	catch (Exception ex2)
        	{        		
        		system.debug('ERROR WITH BODY ATTACHMENT: ' + ex2);
        	} 
        }
        catch(Exception ex){
        	Lead blankLead = new Lead(Company = 'ATC LEAD', 
			LastName = 'ATC LEAD', 
			Franchise_1__c = 'AutoTrader Lead',
			LeadSource = 'Auto Trader.com');
        	
        	insert blankLead;
        	
        	try
        	{
        		Attachment blankAttachment = new Attachment();
        		blankAttachment.ParentId = blankLead.Id;
        		blankAttachment.Body = Blob.valueOf(body);
        		blankAttachment.Name = 'Lead Email.txt';
	        	blankAttachment.ContentType = 'text';
        	        
       			insert blankAttachment;        		
        	}
        	catch (Exception ex2)
        	{        		
        		system.debug('ERROR WITH BODY ATTACHMENT: ' + ex2);
        	}        	
        }  
        return result;
    }
    
    public static String removeHTML(String source)
    {
    	string html = source;
		 //first replace all <BR> tags with \n to support new lines
		string result = html.replaceAll('<br/>', '\n');
		result = result.replaceAll('<br />', '\n');
		result = result.replaceAll('</p>', '\n');
		result = result.replaceAll('~~EOL~~', '\n');
		result = result.replaceAll('&nbsp;', '');		
		
		//regular expression to match all HTML/XML tags
		string HTML_TAG_PATTERN = '<.*?>';
		
		// compile the pattern     
		pattern myPattern = pattern.compile(HTML_TAG_PATTERN);
		
		// get your matcher instance
		matcher myMatcher = myPattern.matcher(result);
		
		//remove the tags     
		result = myMatcher.replaceAll('');
		return result;
    }
    
    static testMethod void testATCLeadGenEmailService()
    {
    	Messaging.Inboundemail email = new Messaging.Inboundemail();
    	Messaging.Inboundemail email2 = new Messaging.Inboundemail();
    	Messaging.Inboundemail email3 = new Messaging.Inboundemail();
    	Messaging.Inboundenvelope env = new Messaging.Inboundenvelope();    	
    	
    	email.subject = 'test lead';
    	email.fromName = 'test lead submitter';
    	email.fromAddress = 'atcLeads@vinsolutions.com';
    	email.plainTextBody = 'Account ID: 555555555\n'
		+ 'Company / Account: Acme Test Account\n'
		+ 'Street:   3170 Dundee Ridge Way\n'
		+ 'City: Duluth\n'
		+ 'State / Province: GA\n'
		+ 'Zip/Postal Code: 00222\n'
		+ 'Website: http://www.MustangsUnlimited.com\n'
		+ 'First Name:    Luke\n'
		+ 'Last Name: Skywalker\n'
		+ 'Title: Jedi Knight\n'
		+ 'Phone: (123) 456-7890\n'
		+ 'Email: Iknow.theforce@starwars.com\n'
		+ 'Used vehicle sales per month: 67\n'
		+ 'ATC/ATG Package: ATC\n'
		+ 'Competitive package: yes\n'
		+ 'Affiliate: AutoTrader\n'
		+ 'Affiliate Email: Paul.Mayo@autotrader.com\n'
		+ 'Affiliate Name: Paul Mayo\n'
		+ 'Affiliate Phone: 404-568-4085\n'
		+ 'ATC Division: Unassigned\n'
		+ 'ATC Region: 00 - Unassigned\n'
		+ 'ATC District: n/a\n'
		+ 'Secondary Contact:  Barney Rubble\n'
		+ 'Secondary Email: \n'
		+ 'Secondary Phone: (770) 555-1212\n'
		+ 'Imported Notes: This is a test email lead for VinSolutions using an existing account.\n';
		
		email2.subject = 'test lead';
    	email2.fromName = 'test lead submitter';
    	email2.fromAddress = 'atcLeads@vinsolutions.com';
		email2.htmlBody = 'Account ID: 555555555\n'
		+ 'Company / Account: Acme Test Account\n'
		+ 'Street:   3170 Dundee Ridge Way\n'
		+ 'City: Duluth\n'
		+ 'State / Province: GA\n'
		+ 'Zip/Postal Code: 00222\n'
		+ 'Website: http://www.MustangsUnlimited.com\n'
		+ 'First Name:    Luke\n'
		+ 'Last Name: Skywalker\n'
		+ 'Title: Jedi Knight\n'
		+ 'Phone: (123) 456-7890\n'
		+ 'Email: Iknow.theforce@starwars.com\n'
		+ 'Used vehicle sales per month: 67\n'
		+ 'ATC/ATG Package: ATC\n'
		+ 'Competitive package: yes\n'
		+ 'Affiliate: AutoTrader\n'
		+ 'Affiliate Email: Paul.Mayo@autotrader.com\n'
		+ 'Affiliate Name: Paul Mayo\n'
		+ 'Affiliate Phone: 404-568-4085\n'
		+ 'ATC Division: Unassigned\n'
		+ 'ATC Region: 00 - Unassigned\n'
		+ 'ATC District: n/a\n'
		+ 'Secondary Contact:  Barney Rubble\n'
		+ 'Secondary Email: \n'
		+ 'Secondary Phone: (770) 555-1212\n'
		+ 'Imported Notes: This is a test email lead for VinSolutions using an existing account.\n'; 
		
		email3.subject = 'test lead';
    	email3.fromName = 'test lead submitter';
    	email3.fromAddress = 'atcLeads@vinsolutions.com';
    	email3.plainTextBody = '';
    	email3.htmlBody = '';
		
		ATC_Lead_Generation_Email_Service emailProcess = new ATC_Lead_Generation_Email_Service();
		emailProcess.handleInboundEmail(email, env);
		emailProcess.handleInboundEmail(email2, env);
		emailProcess.handleInboundEmail(email3, env);
    }
    
    
}