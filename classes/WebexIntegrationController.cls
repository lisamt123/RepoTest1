public with sharing class WebexIntegrationController {
    
    public String username {get; set;}
    public String password {get; set;}
    public String XMLOutput {get; set;}
    public String loginError {get; set;}
    public String exceptionError {get; set;}
    private String requestCommand {get; set;}
    public String startDate {get; set;}
    public String endDate {get; set;}
    public String startDateTimeString {get; set;}
    public String endDateTimeString {get; set;}
    public Set<String> wsAttendeeEmails {get;set;}
    public Set<Id> contactIds {get;set;}
    
    public String clientIPaddress {get; set;} 
    
    public LIST<Access_Level> accessLevelList {get; set;}
    public MAP<String, Access_Level> accessLevelMap {get; set;}    
    
    public String publicSessionKey {get; set;}
    public String publicSessionName {get; set;}
    public String publicClassName {get; set;}
    private String publicSessionClassId {get; set;}
    public Online_Class__c publicClass {get; set;}
    public String singleClassSessionKey {get; set;}
    
    public LIST<MAP<String, MAP<String, String>>> commandList{get; set;}
    public MAP<String, MAP<String, String>> commandAttributes{get; set;}
    
    public LIST<Online_Class__c> onlineClassList {get; set;}
    public MAP<String, Classes__c> allClasses {get; set;}
    public LIST<Classes__c> allClassesList {get; set;}    
    public MAP<String, Online_Class__c> classMap {get; set;}
    //public MAP<Id, Online_Class__c> classIdMap;  
    
    public pageReference thisPage {get; set;}  
    
    public boolean rememberUsername {get; set;}
    
    
    public LIST<SFDC_Service_Timecard__c> currentTimecardList {get; set;}
    public MAP<String, LIST<SFDC_Service_Timecard__c>> timecardsMap {get; set;}
    
    public MAP<String, Contact> relatedContactMap {get; set;}
    public MAP<Id, Contact> relatedContactMapId {get; set;}
    public LIST<Contact> relatedContactList {get; set;}
    
    public String errorLogArea {get; set;}    
    
    private final String partnerID = '268vi';
    private final String siteID = '268075';    
    private final String xmlURL = 'https://vinsolutions.webex.com/WBXService/preview/XMLService';
    private final String xmlServerURL = 'https://vinsolutions.webex.com/WBXService/preview/XMLService';
    
   /*public String ad = 'Admin';
    public String man = 'Manager';
    public String sales = 'Salesperson';*/
    
      
    /*public MAP<String, String> classNameMap;
    
    public void updateClassNameMap(){
        classNameMap = new MAP<String, String>();
                classNameMap.put('Admin - CRS Surveys', 'Admin');
                classNameMap.put('Admin 1', 'Admin');
                classNameMap.put('Admin 2', 'Admin');
                classNameMap.put('Admin Activity Alerts', 'Admin');
                classNameMap.put('Admin Check List', 'Admin');
                classNameMap.put('Admin Lead Assignment', 'Admin');
                classNameMap.put('Admin Sales Process Building', 'Admin');
                classNameMap.put('Admin Template Building','Admin');
                classNameMap.put('Admin Templates and Sales Processes', 'Admin');
                classNameMap.put('Admin Website Custom Content and Forms', 'Admin');
                classNameMap.put('Admin Website Management', 'Admin');
                classNameMap.put('Admin Websites', 'Admin');
                classNameMap.put('Advanced Desking & Trade Appraisal', 'Manager');
                classNameMap.put('Advanced Desking Settings', 'Admin');
                classNameMap.put('Basic CRM Overview', 'Manager');
                classNameMap.put('Basic ILM Overview', 'Manager');
                classNameMap.put('BDC Training', 'Manager');
                classNameMap.put('Campaigns', 'Manager');
                classNameMap.put('Craiglist and Ebay', 'Manager');
                classNameMap.put('Customer Portal', 'Manager');
                classNameMap.put('Distrubution AKA Bulk Email', 'Salesperson');
                classNameMap.put('ILM/CRM Reporting', 'Manager');
                classNameMap.put('Inventory Reporting', 'Manager');
                classNameMap.put('Inventory Training', 'Manager');
                classNameMap.put('Manager 1', 'Manager');
                classNameMap.put('Manager 2', 'Manager');
                classNameMap.put('Mobile MotoSnap', 'Salesperson');
                classNameMap.put('New General Motors (GM) Dealer Orientation', 'Admin');
                classNameMap.put('Operator’s Panel', 'Manager');
                classNameMap.put('Other', 'Manager');
                classNameMap.put('Recorded: Distrubution AKA Bulk Mail', 'Salesperson');
                classNameMap.put('Recorded: Mobile MotoSnap', 'Salesperson');
                classNameMap.put('Recorded: Salesperson Level 1', 'Salesperson');
                classNameMap.put('Recorded: Salesperson Level 2', 'Salesperson');
                classNameMap.put('Recorded: Salesperson Level 3', 'Salesperson');
                classNameMap.put('Sales Consultant Level 1', 'Salesperson');
                classNameMap.put('Sales Consultant Level 2', 'Salesperson');
                classNameMap.put('Sales Consultant Level 3', 'Salesperson');
                classNameMap.put('Sales Process', 'Admin');
                classNameMap.put('Service Dashboard & Scheduler','Admin');
                classNameMap.put('Templates', 'Admin');
                classNameMap.put('Updates Training', 'Salesperson');
                classNameMap.put('VinCamera Training', 'Manager');
    }*/
    
    public String getClientIPaddress()
    {
        return clientIPaddress;
    }
    
    public Online_Class__c getPublicClass()
    {
        return publicClass;
    }
    
    public void setPublicClass()
    {
        this.publicClass = publicClass;
    }
    
    public void setClientIPaddress()
    {
        if (Apexpages.currentPage().getHeaders().get('X-Salesforce-SIP') != null)
        clientIPaddress = Apexpages.currentPage().getHeaders().get('X-Salesforce-SIP');
        if (Apexpages.currentPage().getHeaders().get('True-Client-IP') != null)
        clientIPaddress = Apexpages.currentPage().getHeaders().get('True-Client-IP');
    }
    
    public void getCookies (Pagereference thisPage)
    {                   
        try
        {
                Cookie usernameCookie = thisPage.getCookies().get('wbxUsername');
                username = usernameCookie.getValue();
        }
        catch (Exception ex)
        {
                 //will fall here if initially loading and no cookie found.  nbd really.
                 system.debug ('usernameCookie error:' + ex);
        }                       
    }
    
    public void setCookies (Pagereference thisPage)
    {
        Cookie wbxUsername = new Cookie('wbxUsername', username, null, -1, true);
         
        thisPage.setCookies(new Cookie[]{wbxUsername});
    }
    
    public boolean loginIsSuccess {get; set;}
    
    public void setAccessLevelList()
    {
                accessLevelList = new LIST<Access_Level>();
                accessLevelMap = new MAP<String, Access_Level>();
                
                //classIdMap = new MAP<Id, Online_Class__c>();
                
        LIST<Classes__c> allClasses = [select Id, Name, Access_Level__c from Classes__c];
        
        for (Classes__c thisClass: allClasses)
        {
                Access_Level access_level = new Access_Level();
                access_level.access_level = thisClass.Access_Level__c;
                access_level.class_name = thisClass.Name;
                accessLevelList.add(access_level);
                //classIdMap.put(thisClass.Id, thisClass);
        }
        
        for (Access_Level thisAccessLevel: accessLevelList)
        {
                accessLevelMap.put(thisAccessLevel.class_name, thisAccessLevel);
        }
    }    
 
    public WebexIntegrationController()    {
        wsAttendeeEmails = new Set<String>();
        contactIds = new Set<Id>();
        //updateClassNameMap();
        thisPage = ApexPages.currentPage();        
        getCookies(thisPage);
        loginIsSuccess = false;
        startDate = String.valueOf(system.now().format('MM/dd/yyyy'));
        endDate = String.valueOf(system.now().format('MM/dd/yyyy'));
        setAllClasses();
        currentTimecardList = new LIST<SFDC_Service_Timecard__c>();
        clearTimecardsandContactsClass();
        //publicClass = new Online_Class__c();
        
        setClientIPaddress();
        exceptionError = '';
        setAccessLevelList();
        }
        
    public PageReference saveSingleOnlineClass()
    {    
        publicClass = classMap.get(singleClassSessionKey);
        try
        {
                upsert publicClass;
                exceptionError = '';
        }
        catch (Exception ex)
        {
                system.debug('FATAL ERROR IN saveSingleOnlineClass: ' + ex);
                exceptionError = 'Error in saving online class';
        }
        
        clearTimecardsandContactsClass();
        return null;
    }
    
    public void clearTimecardsandContactsClass()
    {
        relatedContactMap = new MAP<String, Contact>();
        relatedContactMapId = new MAP<Id, Contact>();
        relatedContactList = new LIST<Contact>();
        currentTimecardList = new LIST<SFDC_Service_Timecard__c>();
        timecardsMap = new MAP<String, LIST<SFDC_Service_Timecard__c>>();
    }
    
    public PageReference clearTimecardsAndContacts()
    {
        relatedContactMap = new MAP<String, Contact>();
        relatedContactMapId = new MAP<Id, Contact>();
        relatedContactList = new LIST<Contact>();
        currentTimecardList = new LIST<SFDC_Service_Timecard__c>();
        timecardsMap = new MAP<String, LIST<SFDC_Service_Timecard__c>>();
        return null;
    }
    
    public pageReference saveClassWithTimecards()
    {
        Online_Class__c thisClass = classMap.get(publicSessionKey);
        try
        {
                upsert thisClass;
                exceptionError = '';
        }
        catch (Exception ex)
        {
                system.debug('FATAL ERROR IN saveClassList: ' + ex);
                exceptionError='Error: saving class failed';
        }
             
        if (currentTimecardList != null)
        {
                for (SFDC_Service_Timecard__c thisTimecard: currentTimecardList)
                {
                        if (thisTimecard.Online_Class__c == null) thisTimecard.Online_Class__c = thisClass.Id;                              
                }
                try
                {
                        upsert currentTimecardList;     
                        exceptionError = '';
                }
                catch (Exception ex)
                {
                        system.debug('FATAL ERROR IN saveClassWithTimecards: ' + ex);
                        exceptionError = 'Error: saving Timecards failed.';
                }
        }        
        clearTimecardsandContactsClass();
        return null;
    }    
    
    
    public void setAllClasses ()
    {
        allClasses = new MAP<String, Classes__c>();
        allClassesList = [select Id, Name, Class_Description__c, Custom_Class__c from Classes__c];
        for (Classes__c thisClass: allClassesList)
        {
                allClasses.put(thisClass.Name, thisClass);
        }
        
    }
    
    public void createClassList()
    {
        Http http = new Http();
        HttpRequest req = createClassListRequest(http);
        HttpResponse res = invokeWebService(http, req);
        setOnlineClassList(res);
    }
    
    public void setOnlineClassList(HttpResponse res)
    {
            XmlStreamReader reader = res.getXmlStreamReader();        
    
                onlineClassList = cleanClassList(parseOnlineClassList(reader));
                superSort.sortList(onlineClassList, 'sessionTrainerAlias__c', 'asc');
                superSort.sortList(onlineClassList,'Start_Day_and_Time_del__c' ,'asc');
    }
    
    public HttpRequest createClassListRequest(Http http)
    {
        commandList= new LIST<MAP<String, MAP<String, String>>>();
        
        startDateTimeString = startDate + ' 00:00:00';
        endDateTimeString = endDate + ' 23:59:59';
        exceptionError = '';
        
       
        String requestCommand = 'java:com.webex.service.binding.training.LstsummaryTrainingSession';        
        LIST<String> outerKeys = new LIST<String>{
                        'start',        //<listControl>   
                        'both',         //<maximumNum>200</maximumNum>
                        'both',         //<listMethod>OR</listMethod>
                        'end',          //</listControl>
                        'start',        //<order>
                        'both',         //<orderBy>STARTTIME</orderBy>
                        'both',         //<orderAD>ASC</orderAD>
                        'end',          //</order>
                        'start',        //<dateScope>
                        'both',         //<startDateStart>06/16/2011 00:00:00</startDateStart>
                        'both',         //<startDateEnd>06/16/2011 23:00:00</startDateEnd>
                        'both',         //<timeZoneID>5</timeZoneID>
                        'end'           //</dateScope>
                };
        LIST<String> innerKeys = new LIST<String>{
                        'listControl',  //<listControl>           
                        'maximumNum',   //<maximumNum>200</maximumNum>
                        'listMethod',   //<listMethod>OR</listMethod>
                        null,                   //</listControl>
                        'order',                //<order>
                        'orderBy',              //<orderBy>STARTTIME</orderBy>
                        'orderAD',              //<orderAD>ASC</orderAD>
                        null,                   //</order>
                        'dateScope',    //<dateScope>
                        'startDateStart',//<startDateStart>06/16/2011 00:00:00</startDateStart>
                        'startDateEnd', //<startDateEnd>06/16/2011 23:00:00</startDateEnd>
                        'timeZoneID',   //<timeZoneID>5</timeZoneID>
                        null//</dateScope>
                };
        LIST<String> values = new LIST<String>{
                        null,                                   //<listControl>           
                        '200',                                  //<maximumNum>200</maximumNum>
                        'OR',                                   //<listMethod>OR</listMethod>
                        null,                                   //</listControl>
                        null,                                   //<order>
                        'STARTTIME',                    //<orderBy>STARTTIME</orderBy>
                        'ASC',                                  //<orderAD>ASC</orderAD>
                        null,                                   //</order>
                        null,                                   //<dateScope>
                        startDateTimeString,    //<startDateStart>06/16/2011 00:00:00</startDateStart>
                        endDateTimeString,              //<startDateEnd>06/16/2011 23:00:00</startDateEnd>
                        '7',                                    //<timeZoneID>5</timeZoneID>
                        null                                    //</dateScope>
        };
        
        commandList = setupVariableList(outerKeys, innerKeys, values);              
                
        HttpRequest req = queryWebexInfo(commandList, partnerID, siteID, requestCommand, http);
        
        return req;              
    }
    
    public void saveClassList()
    {
        try
        {
                upsert onlineClassList;
                exceptionError = '';
        }
        catch (Exception ex)
        {
                system.debug('FATAL ERROR IN saveClassList: ' + ex);
                exceptionError = 'ERROR: Saving class list failed.';
        }
        clearTimecardsandContactsClass();
    }
    
    public LIST<Online_Class__c> parseOnlineClassList(XmlStreamReader reader)    
    {
        LIST<Online_Class__c> theseClasses = new LIST<Online_Class__c>();           
        while(reader.hasNext())
        {               
                if (reader.getEventType() == XmlTag.START_ELEMENT)
                {
                        if (reader.getLocalName() == 'trainingSession')                         
                        {       Online_Class__c thisClass = parseOnlineClass(reader);
                                theseClasses.add(thisClass);
                        }
                }               
                reader.next();                  
        }
        return theseClasses;
    }
    
    public LIST<Online_Class__c> cleanClassList(LIST<Online_Class__c> thisClassList) 
    {       
        classMap = new MAP<String, Online_Class__c>();
        
        for (Online_Class__c thisClass: thisClassList)        
        {       
                //add found classes to the map and default the trainer to the user and the status to Schedule
                thisClass.Trainer_del__c = userinfo.getUserId();
                thisClass.Status_del__c = 'Schedule';
                classMap.put(thisClass.sessionKey__c, thisClass);
        }
        
        LIST<Online_Class__c> existingClasses = [Select 
        sessionKey__c, Trainer_del__c, Status_del__c, sessionName__c, 
        Start_Day_and_Time_del__c, Private__c, OwnerId, Name_of_Class__c, 
        Name, Id, End_Day_and_Time_del__c, Class__c, sessionTrainerAlias__c, 
        Class__r.Name 
        From Online_Class__c where sessionKey__c IN: classMap.keyset()];
        
        for (Online_Class__c existingClass: existingClasses)
        {
                //this will overwrite any of the found classes with the classes that are already in SFDC
           classMap.put(existingClass.sessionKey__c, existingClass);
        }       
        return classMap.values();
    }
    
    public Online_Class__c parseOnlineClass(XmlStreamReader reader)
    {
        Online_Class__c thisClass = new Online_Class__c();
        while(reader.hasNext())
        {
                if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == 'trainingSession')
                {
                        return thisClass;
                }
                if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'sessionKey')
                {
                    reader.next();
                    if (reader.getEventType() == XmlTag.CHARACTERS) thisClass.sessionKey__c = reader.getText();                     
                }
                if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'confName')
                {
                    reader.next();
                    if (reader.getEventType() == XmlTag.CHARACTERS)
                    { 
                        thisClass.sessionName__c = reader.getText();
                        try{
                            thisClass.Class__c = allClasses.get(reader.getText()).Id;   
                        }
                        catch (Exception e)
                        {
                            errorLogArea += ' CLASS NOT FOUND:' +  reader.getText();
                        }
                    }
                }
                if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'hostWebExID')
                {
                        reader.next();
                        if (reader.getEventType() == XmlTag.CHARACTERS) thisClass.sessionTrainerAlias__c = reader.getText();
                }
                if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'startDate')
                {
                    reader.next();
                    if (reader.getEventType() == XmlTag.CHARACTERS)
                    {
                        LIST<String> classDateTime = reader.getText().split(' ');
                        LIST<String> classDateDivided = classDateTime[0].split('/');
                        LIST<String> classTimeDivided = classDateTime[1].split(':');                                                
                        String stringDate = classDateDivided[2] + '-' + classDateDivided[0] + '-' + classDateDivided[1] + ' ' + classTimeDivided[0] + ':' + classTimeDivided[1] +  ':' + classTimeDivided[2];
                        thisClass.Start_Day_and_Time_del__c = DateTime.valueOf(stringDate);
                    }
                }
                reader.next();          
        }
        return null; //should never reach here
    }
    
    public void setRelatedContacts()
    {           
        MAP<String, SFDC_Service_Timecard__c> mapOfTimecardsEmailKey = new MAP<String, SFDC_Service_Timecard__c>();
        MAP <String, Contact> relatedContactMap = new MAP<String, Contact>();
        List<Contact> newUnhandledContacts = new List<Contact>();
        
        for (SFDC_Service_Timecard__c thisTimecard: currentTimecardList)
        {
            if(thisTimeCard.Attendee_Email_Address__c != null && thisTimeCard.Attendee_Email_Address__c != ''){
                mapOfTimecardsEmailKey.put(thisTimecard.Attendee_Email_Address__c, thisTimecard);    
                wsAttendeeEmails.add(thisTimeCard.Attendee_Email_Address__c);  
            }    
            contactIds.add(thisTimecard.contact__c);     
        }
        
        system.debug('wsAttendeeEmails: ' + wsAttendeeEmails);
        relatedContactList = [SELECT Id, Name, Email, Phone, AccountId, account_name__c, Account_Number__c, 
                                        ILM_CRM_Access__c, Inventory_Access__c, motosnap_access__c 
                                    FROM Contact 
                                    WHERE email IN :wsAttendeeEmails
                                    OR Id IN :contactIds];
                                    //WHERE Email IN: mapOfTimecardsEmailKey.keyset()];
        system.debug('relatedContactList: ' + relatedContactList);                           
                                         
        for (Contact thisContact: relatedContactList)
        {
                relatedContactMap.put(thisContact.Email, thisContact);
                relatedContactMapId.put(thisContact.Id, thisContact);
                relatedContactMapId.put(thisContact.AccountId, thisContact);
                //relatedContactMapId.put(thisContact.Name, thisContact);  
        }       
        
        Set<string> searchEmails = new Set<string>();
        for (SFDC_Service_Timecard__c thisTimeCard: currentTimecardList){
                if (relatedContactMap.containsKey(thisTimeCard.Attendee_Email_Address__c)  && thisTimeCard.Contact__c == null){
                        thisTimeCard.Contact__c = relatedContactMap.get(thisTimeCard.Attendee_Email_Address__c).Id;
                        system.debug('Time Card Contact Assignment: ' + thisTimeCard);
                }
                else{
                	searchEmails.add(thisTimeCard.Attendee_Email_Address__c.trim());
                }
                   
        }
        system.debug('Search Emails: ' + searchEmails);
        List<Contact> searchContacts = [SELECT Id, Name, Email, Phone, AccountId, account_name__c, Account_Number__c, 
	                                        ILM_CRM_Access__c, Inventory_Access__c, motosnap_access__c 
	                                    FROM Contact 
	                                    WHERE email IN :searchEmails];
	                                  
	    Map<string, Contact> searchMap = new Map<string, Contact>();
	    for(Contact c : searchContacts){
	    	searchMap.put(c.email, c);
	    }    
	    system.debug('Search Map: ' + searchMap);   
	    for (SFDC_Service_Timecard__c thisTimeCard: currentTimecardList){
	    	if(searchMap.containsKey(thisTimeCard.Attendee_Email_Address__c) && thisTimeCard.Contact__c == null){
	    		thisTimeCard.Contact__c = searchMap.get(thisTimeCard.Attendee_Email_Address__c).Id;
	    	}
	    	else if(thisTimeCard.Contact__c == null){
	            //Create new contact if one is not found on email or contactid search
	            List<String> name = new List<String>();
	            string fName;
	            string lName;
	            if(thisTimeCard.Attendee_Name__c.contains(' ')){
	                    name = thisTimeCard.Attendee_Name__c.split(' ', 2);
	            }
	            if(name.size()>0){
	                    fName = name[0];
	                    lName = name[1];
	            }
	            else{
	                    fName = thisTimeCard.Attendee_Name__c;
	                    lName = thisTimeCard.Attendee_Name__c;
	            }
	            
	            Contact c = new Contact(email = thisTimeCard.Attendee_Email_Address__c, firstName = fName, lastName = lName, description = thisTimeCard.Attendee_Account_Name__c, Needs_Resolution__c = true);
	            system.debug('New Unhandled Contact: ' + c);
	            newUnhandledContacts.add(c);
	    	}
	    }                             
        insert newUnhandledContacts;
        system.debug('Unhandled Contact Results: ' + newUnhandledContacts);
        
        //Loop through the currentTimecardList and populate the null contact references with the new contacts
        for (SFDC_Service_Timecard__c thisTimeCard: currentTimecardList)
        {
                        if(thisTimeCard.Contact__c == null){
                                for(Contact c : newUnhandledContacts){
                                        if(c.email == thisTimeCard.Attendee_Email_Address__c){
                                                thisTimeCard.Contact__c = c.Id;
                                                relatedContactMapId.put(c.Id, c);
                                                break;
                                        }
                                }
                        }
                
        }
        
    }
    
    public PageReference returnClassTimecards ()
    {   
            Http http = new Http();         
            HttpRequest req = setCurrentTimecardListRequest(http);
            HttpResponse res = invokeWebService(http, req);
            setCurrentTimecardList(res);            
            return null;
    }
   
    public void setCurrentTimecardList(HttpResponse res)
    {
        currentTimecardList = new LIST<SFDC_Service_Timecard__c>();       
        
        Online_Class__c thisOnlineClass = classMap.get(publicSessionKey);
        XmlStreamReader reader = res.getXmlStreamReader();
                
        currentTimecardList = cleanTimecards(parseTimecards(reader, thisOnlineClass.Id));
        
        /*for(SFDC_Service_Timecard__c tc : currentTimecardList){
                
                if(classNameMap.containskey(thisOnlineClass.Name)){
                        
                        tc.Service_Performed__c = classNameMap.get(thisOnlineClass.Name);
                }
        }*/
        setRelatedContacts();   
    }
    
    public HttpRequest setCurrentTimecardListRequest (Http http)
    {
        String requestCommand = 'java:com.webex.service.binding.attendee.LstMeetingAttendee';        
        
        currentTimecardList = new LIST<SFDC_Service_Timecard__c>();
        
        LIST<String> outerKeys = new LIST<String>{                          
                        'both'           //<sesesionKey>(String)</sessionKey>
                };
        LIST<String> innerKeys = new LIST<String>{
                        
                        'sessionKey'    //<sesesionKey>(String)</sessionKey>
                };
        LIST<String> values = new LIST<String>{                             
                        publicSessionKey //<sesesionKey>(String)</sessionKey>
        };
        commandList = setupVariableList(outerKeys, innerKeys, values);          
                HttpRequest req = queryWebexInfo(commandList, partnerID, siteID, requestCommand, http);
                
                return req;
    }
    
    public LIST<SFDC_Service_Timecard__c> cleanTimecards (LIST<SFDC_Service_Timecard__c> thisTimecardList)
    {
        MAP<String, SFDC_Service_Timecard__c> theseTimecardsMap = new MAP<String, SFDC_Service_Timecard__c>();
        MAP<String, SFDC_Service_Timecard__c> theseTimecardsMapEmailKey = new MAP<String, SFDC_Service_Timecard__c>();
        SET<ID> onlineClassIds = new SET<ID>();
        MAP<Id, SFDC_Service_Timecard__c> theseTimecardsMapContactIds = new MAP<Id, SFDC_Service_Timecard__c>();        
        relatedContactMapId = new MAP<Id, Contact>();
        for (SFDC_Service_Timecard__c thisTimecard: thisTimecardList){
                
                onlineClassIDs.add(thisTimeCard.Online_Class__c);
                
        }
        
        MAP<Id, Online_Class__c> onlineClassMap = new MAP<Id, Online_Class__c>([SELECT Id, Class__r.Access_Level__c
                                                                                                                                                        FROM Online_Class__c
                                                                                                                                                        WHERE Id IN : onlineClassIds]);
                                                                                                                                                        
        
        for (SFDC_Service_Timecard__c thisTimecard: thisTimecardList){
                
                /*try //put the access level to the current
                {                       
                        thisTimecard.Service_Performed__c = accessLevelMap.get(publicClassName).access_level;
                        
                }
                catch(Exception ex)
                {
                        system.debug('accessLevelMap: '+ accessLevelMap);
                        system.debug('publicClassName: ' + publicClassName);                    
                        system.debug('Exception when trying to set Access Level: ' + ex);
                }*/
                
                if(onlineClassMap.containsKey(thisTimeCard.Online_Class__c)){
                        
                        thisTimecard.Service_Performed__c = onlineClassMap.get(thisTimecard.Online_Class__c).Class__r.Access_Level__c;
                        
                }
                theseTimecardsMap.put(thisTimecard.Attendee_Email_Address__c, thisTimecard);
                theseTimecardsMapEmailKey.put(thisTimecard.Attendee_Email_Address__c, thisTimecard);
        }
        /*LIST<SFDC_Service_Timecard__c> existingTimecards = [Select attendeeID__c, User__c, Test_Score__c, 
                                                            SystemModstamp, Service_Performed__c, Service_Notes__c, 
                                                            Private_Class__c, OwnerId, Online_Class__c, Name,                                                                                                                
                                                            Id, Dealer_Name__c, Dealer_Group__c,
                                                            Date_of_Service__c, Date_Time_of_Training_Old__c, 
                                                            Custom_Class_Old__c, Contact__c, Class__c, Class_Status__c, 
                                                            Class_Number__c, Class_Name_Old__c, Class_Date_Time_text__c, 
                                                            Class_Date_Time__c, Certifications_Issued__c, Attendee_Name__c, 
                                                            Attendee_Email_Address__c, Attendee_Account_Name__c, Approved_by_Manager__c, 
                                                            Account__c, Account_Number__c, Access_Level__c, Online_Class_Session_Key__c
                                                            From SFDC_Service_Timecard__c
                                                            where attendeeID__c IN: theseTimecardsMap.keySet() 
                                                            AND Online_Class_Session_Key__c =: publicSessionKey];
                                                            
        for (SFDC_Service_Timecard__c thisTimecard: existingTimecards)
        {
                
                 
                theseTimecardsMap.put(thisTimecard.Attendee_Email_Address__c, thisTimecard);
                theseTimecardsMapContactIds.put(thisTimecard.Contact__c, thisTimecard);                
        }*/                                                  
         
                LIST<SFDC_Service_Timecard__c> existingTimecards2 = [Select attendeeID__c, User__c, Test_Score__c, 
                                                            SystemModstamp, Service_Performed__c, Service_Notes__c, 
                                                            Private_Class__c, OwnerId, Online_Class__c, Name,                                                                                                                
                                                            Id, Dealer_Name__c, Dealer_Group__c,
                                                            Date_of_Service__c, Date_Time_of_Training_Old__c, 
                                                            Custom_Class_Old__c, Contact__c, Class__c, Class_Status__c, 
                                                            Class_Number__c, Class_Name_Old__c, Class_Date_Time_text__c, 
                                                            Class_Date_Time__c, Certifications_Issued__c, Attendee_Name__c, 
                                                            Attendee_Email_Address__c, Attendee_Account_Name__c, Approved_by_Manager__c, 
                                                            Account__c, Account_Number__c, Access_Level__c, Online_Class_Session_Key__c 
                                                            From SFDC_Service_Timecard__c
                                                            where Attendee_Email_Address__c IN: theseTimecardsMapEmailKey.keySet() 
                                                            AND Online_Class_Session_Key__c =: publicSessionKey];                                                   
                                                       
                                                                                                                
        
        
        for(SFDC_Service_Timecard__c thisTimecard: existingTimecards2)
        {
                                theseTimecardsMap.put(thisTimecard.Attendee_Email_Address__c, thisTimecard);
                                theseTimecardsMapContactIds.put(thisTimecard.Contact__c, thisTimecard);
                                //theseTimecardsMap.put(thisTimecard.Service_Performed__c, thisTimecard);  
                                contactIds.add(thisTimeCard.Contact__c);
        }
        
        //Also including the known contacts information to output to the VF page
        LIST<Contact> theseKnownContacts = [select Id, Name, Email, Phone, AccountId, account_name__c, Account_Number__c, 
                                                                                        ILM_CRM_Access__c, Inventory_Access__c, motosnap_access__c
                                                                                        from Contact where Id IN: theseTimecardsMapContactIds.keyset()];
                                                                                        
       
        
        
        for (Contact thisContact: theseKnownContacts)
        {
                relatedContactMapId.put(thisContact.Id, thisContact);
                
        }    
        
        return theseTimecardsMap.values();
    }
    
    
    
    public LIST<SFDC_Service_Timecard__c> parseTimecards(XmlStreamReader reader, Id onlineClassId)
    {   
        LIST<SFDC_Service_Timecard__c> thisTimecardList = new LIST<SFDC_Service_Timecard__c>();
        while (reader.hasNext())
        {       
                if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'attendee')
                {               
                                thisTimecardList.add(parseTimecard(reader, onlineClassId));
                }               
                reader.next();
                }       
        return thisTimecardList;
    }
    
    public SFDC_Service_Timecard__c parseTimecard(XmlStreamReader reader, Id onlineClassId)
    {
        SFDC_Service_Timecard__c thisTimecard = new SFDC_Service_Timecard__c(User__c = userinfo.getUserId());
        while (reader.hasNext())
        {               
                if(reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'person')
                {                       
                                thisTimeCard.Online_Class__c = onlineClassId;
                                
                                while (reader.hasNext())
                                {       
                                        if (reader.getEventType() == XmlTag.END_ELEMENT && reader.getLocalName() == 'attendee') return thisTimecard;                                    
                                
                                        if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'name')
                                        {
                                                reader.next();  
                                                thisTimeCard.Attendee_Name__c = reader.getText();
                                        }                                                               
                                        if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'email')
                                        {
                                                reader.next();
                                                string tmpEmail = reader.getText(); 
                                                thisTimeCard.Attendee_Email_Address__c = tmpEmail;
                                                wsAttendeeEmails.add(tmpEmail.trim());                                            
                                        }
                                        if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'company')
                                        {
                                                reader.next();
                                                thisTimeCard.Attendee_Account_Name__c = reader.getText();                                               
                                        }
                                        if (reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'attendeeId')
                                        {
                                                reader.next();
                                                thisTimeCard.attendeeID__c = reader.getText();                                          
                                        }
                                        reader.next();                          
                                }
                } 
                reader.next();                  
        }       
        
        return thisTimeCard;
    }              
  
    public LIST<MAP<String, MAP<String, String>>> setupVariableList(LIST<String> outerKeys, LIST<String> innerKeys, LIST<String> values)
    {
        commandList= new LIST<MAP<String, MAP<String, String>>>();
        commandAttributes = new MAP<String, MAP<String, String>>();
        
        for(Integer i = 0; i< outerKeys.size(); i++)
        {       
                        Map<String,String> innerMap = new Map<String,String>();
                        commandAttributes = new MAP<String, MAP<String, String>>();                  
                        
                        innerMap.put(innerKeys[i],values[i]);                   
                        commandAttributes.put(outerKeys[i],innerMap);
                        
                        commandList.add(commandAttributes);                     
                }
                return commandList; 
    } 
    
    public void setLoginIsSuccess()
    {       
        LIST<MAP<String, MAP<String, String>>> loginCommandList= new LIST<MAP<String, MAP<String, String>>>();
        MAP<String, MAP<String, String>> loginCommandAttributes = new MAP<String, MAP<String, String>>();
        MAP<String, String> elements = new MAP<String, String>();
        
        //username = 'jenniferm';//REMOVE BEFORE GOING LIVE
        //password = 'Water1';//REMOVE BEFORE GOING LIVE
        
        elements.put('webExId',username);
        loginCommandAttributes.put('both', elements);
        loginCommandList.add(logincommandAttributes);
        
        Http http = new Http();
        
        HttpRequest req = queryWebexInfo(loginCommandList, partnerId, siteId, 'java:com.webex.service.binding.user.GetUser', http);      
        HttpResponse res = invokeWebService(http, req);
        Xmlstreamreader reader = res.getXmlStreamReader();
        loginIsSuccess = checkLoginSuccess(reader);
        if (loginIsSuccess && rememberUsername) setCookies(thisPage);
    }
    
    public boolean checkLoginSuccess(XmlStreamReader reader)
    {
        while(reader.hasNext())
        {
                if (reader.getEventType() == XmlTag.START_ELEMENT)
                {                       
                        if (reader.getLocalName() == 'response')
                        {                               
                                return parseResponse(reader);                           
                        }
                }               
                reader.next();  
        }
        return false;        
    }
    
    public boolean parseResponse(XmlStreamReader reader)
    {
        while (reader.hasNext())
        {
                if (reader.getEventType() == XmlTag.END_ELEMENT){break;}
                else if (reader.getEventType() == XmlTag.CHARACTERS)
                {
                        if ('SUCCESS' == reader.getText()) 
                        { 
                                return true; 
                        } 
                        else if ('FAILURE' == reader.getText())
                        {                               
                                while (reader.hasNext())
                                {
                                        if(reader.getEventType() == XmlTag.START_ELEMENT && reader.getLocalName() == 'reason')
                                        {
                                                reader.next();
                                                if (reader.getEventType() == XmlTag.CHARACTERS) loginError = reader.getTexT();
                                                return false;                                           
                                        }
                                        reader.next();
                                }
                        }                       
                }
                reader.next();
        }
        return false;
    }
    
    public boolean getLoginIsSuccess()
    {
        return loginIsSuccess;
    }
    
    class Access_Level
    {
        String class_name {get; set;}
        String access_level {get; set;}         
    }
    
    public HttpRequest queryWebexInfo (LIST<MAP<String, MAP<String, String>>> commandList, String partnerId, String siteId, String requestCommand, Http http){    
        
        Set <String> commandOptionSet = new Set<String>();
        Set <String> elements = new Set<String>();
        MAP<String, String> elementValuePair = new MAP<String, String>();
        if (password == null) password='';
 
        Xmlstreamwriter w = new XmlStreamWriter();
        
        w.writeStartDocument('UTF-8', '1.0');
        w.writeStartElement('serv', 'message', 'http://www.webex.com/schemas/2002/06/service');
        w.writeNamespace('xsi', 'http://www.w3.org/2001/XMLSchema-instance');
        w.writeNamespace('schemaLocation', 'http://www.webex.com/schemas/2002/06/service http://www.webex.com/schemas/2002/06/service/service.xsd');        
        w.writeStartElement(null, 'header', null); //start header
        w.writeStartElement(null, 'securityContext', null);//start securityContext
        
        w.writeStartElement(null, 'webExID', null);//start webExID
        w.writeCharacters(username);//input username
        w.writeEndElement();//end webExID
        
        w.writeStartElement(null, 'password', null);//start password
        w.writeCharacters(password);//input username
        w.writeEndElement();//end password
        
        w.writeStartElement(null, 'siteID', null);//start siteID
        w.writeCharacters(siteID);//input siteID
        w.writeEndElement();//end siteID
        
        w.writeStartElement(null, 'partnerID', null);//start partnerID
        w.writeCharacters(partnerID);//input partnerID
        w.writeEndElement();//end partnerID
        
        w.writeEndElement();//end securityContext
        w.writeEndElement();//end header
        
        w.writeStartElement(null, 'body', null);//start body
        
        w.writeStartElement(null, 'bodyContent', null);//start bodyContent for request call type
        w.writeAttribute('xsi', '', 'type', requestCommand);//input the request command as an attribute
        
        
        //below is iterating through the elements and values needed for the requestCommand
        if (commandList != null)
        {
            for (MAP<String, MAP<String, String>> command: commandList)
            {
                commandOptionSet = command.keySet();
                for (String commandOption: commandOptionSet)
                {
                    elementValuePair = command.get(commandOption);
                    elements = elementValuePair.keySet();
                    for (String element: elements)
                    {
                        if (commandOption == 'both')
                        {
                            w.writeStartElement(null, element, null);//start new element
                            w.writeCharacters(elementValuePair.get(element));//input value of element
                            w.writeEndElement();//end element
                        }
                        if (commandOption == 'start')
                        {
                            w.writeStartElement(null, element, null);//start new element                   
                        }
                        if (commandOption == 'end')
                        {
                            w.writeEndElement();//end element
                        }
                    }
                }
            }
        }
        
        w.writeEndElement();//end bodyContent for request call type
        w.writeEndElement();//end body
        w.writeEndElement();//end serv:message
        w.writeEndDocument();
        String reqXML = w.getXmlString();
        w.close();        
    
        http = new Http();
        HttpRequest req = new HttpRequest();
        req.setTimeout(60000);
        req.setEndpoint(xmlServerURL);
        system.debug('XML: ' + reqXML);
        req.setBody(reqXML);
        req.setMethod('POST');
        
        return req;         
    }
    
    public HttpResponse invokeWebService(http h, HttpRequest req)
    {
        HttpResponse res = h.send(req);
        return res;
    }
        
}