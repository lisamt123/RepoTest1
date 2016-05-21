/**
 * Email services are automated processes that use Apex classes
 * to process the contents, headers, and attachments of inbound
 * email.
 */

global class VGLLeadToSD implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.inboundEmail email, Messaging.InboundEnvelope env) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
        
        //Set string to pull out HTML to insert in fields in VIN
        String companyNameString = 'Dealer Name:';
        String contactFirstNameString = 'Dealer Contact First Name:';
        String contactLastNameString = 'Dealer Contact Last Name:';
        String phoneString ='Dealer Contact Phone:';
        String mobilePhoneString ='Dealer Contact Mobile Phone:';
        String contactEmail = 'Dealer Contact Email:';
        String streetString = 'Dealer Street:';
        String cityString = 'Dealer City:';
        String stateString = 'Dealer State:';
        String zipString = 'Dealer Zip:';
        String urgencyString = '*****Urgency:';
        String productInterestString = 'Product of Interest:';
        String notesString = 'Notes:';
        String demoString = 'Demo Scheduled:';
        String referredByString = 'Referred by:';
        String submitterString = 'Submitter :';
        String submitterBUString = 'Submitter BU:';
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
        String mobilePhoneValue = '0000000000';
        String contactEmailValue = '';
        String streetValue = 'No Street Provided';
        String cityValue = 'No City Provided';
        String stateValue = 'NA';
        String zipValue = '';
        String urgencyValue = '';
        String productInterestValue = '';
        String notesValue = '';
        String demoValue = '';
        String referredValue = '';
        String submitterValue = '';
        String submitterBUValue = '';
        Date demoDate;

        Lead newLead = new Lead();
        //get dealer name
        nameValue = body.substringBetween(companyNameString, '\n');
        //get contact first name
        contactFirstNameValue = body.substringBetween(contactFirstNameString, '\n');
        //get contact last name
        contactLastNameValue = body.substringBetween(contactLastNameString, '\n');
        //get phone
        phoneValue = body.substringBetween(phoneString, '\n');
        //get mobile phone
        mobilePhoneValue = body.substringBetween(mobilePhoneString, '\n');
        //get email
        contactEmailValue = body.substringBetween(contactEmail, '\n');
        //get street
        streetValue = body.substringBetween(streetString, '\n');
        //get city
        cityValue = body.substringBetween(cityString, '\n');
        //get state
        stateValue = body.substringBetween(stateString, '\n');
        //get zip
        zipValue = body.substringBetween(zipString, '\n');
        //get urgency
        urgencyValue = body.substringBetween(urgencyString, '\n');
        //get interested product
        productInterestValue = body.substringBetween(productInterestString, '\n');
        //get notes
        notesValue = body.substringBetween(notesString, '\n');
        //get demo
        demoValue = body.substringBetween(demoString, '\n');
        //get referred by
        referredValue = body.substringBetween(referredByString, '\n');
        //get submitter
        submitterValue = body.substringBetween(submitterString, '\n');
        //get submitter bu
        submitterBUValue = body.substringAfter(submitterBUString);
        
        newLead.Company = nameValue;
        newLead.FirstName = contactFirstNameValue;
        newLead.LastName = contactLastNameValue;
        newLead.Phone = phoneValue;
        newLead.MobilePhone = mobilePhoneValue;
        newLead.Email = contactEmailValue;
        newLead.Street = streetValue;
        newLead.City = cityValue;
        newLead.State = stateValue;
        newLead.PostalCode = zipValue;
        newLead.Rating = urgencyValue;
        newLead.Opp_Type__c = productInterestValue;
        newLead.Description = notesValue;
        system.debug('==========================>>>>>> demoValue = ' + demoValue);
        try{
            demoDate = Date.valueOf(demoValue);
        }
        catch(Exception e){
            
        }
        if(demoDate != null){
            newLead.Scheduled_WebEx__c = datetime.newInstance(demoDate.year(), demoDate.month(), demoDate.day());
        system.debug('==========================>>>>>> Scheduled_WebEx__c = ' + newLead.Scheduled_WebEx__c);
        }
        newLead.mkto2__Original_Referrer__c = referredValue;
        newLead.Affiliate_Name__c = submitterValue;
        newLead.Affiliate__c = submitterBUValue;
        newLead.Business_Unit__c = 'vAuto';
        if(urgencyValue.contains('Hot Transfer')){
            newLead.Hot_Transfer__c = true;
        }

        insert newLead;
        
        // Add lead to the AutoTrader Campaign
        Campaign vglCampaign = [select Id, Name, IsActive from Campaign where Name = 'VGL Leads' AND isActive = true limit 1];
        CampaignMember mem = new CampaignMember (campaignid=vglCampaign.id, leadid=newlead.id);
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