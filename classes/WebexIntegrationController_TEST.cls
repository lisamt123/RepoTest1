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
private class WebexIntegrationController_TEST {

    public static testMethod void testWebexIntegration()
    {
        PageReference testStart = Page.Webex_Training;
        Test.setCurrentPage(testStart);
        
        WebexIntegrationController WIC = new WebexIntegrationController();
        
        WIC.setPublicClass();
        
        WIC.getClientIPaddress();
        
        WIC.getPublicClass();
        
        WIC.setCookies(testStart);
        
        //WIC.saveSingleOnlineClass();
        
        WIC.clearTimecardsAndContacts();
        
        //WIC.createClassList();
        
        //WIC.returnClassTimecards();
        
        //WIC.setLoginIsSuccess();
        
        WIC.getLoginIsSuccess();
        
        
        
        
        Account A = new Account();
        A.BillingState = 'TS';
        A.Name = 'test';
        A.AccountNumber = '1234';
        A.ShippingStreet = '1234';
        A.ShippingState = 'TS';
        A.ShippingPostalCode = '66212';
        A.ShippingCountry = 'USA';
        A.ShippingCity = 'test';
        A.BillingCity = 'test';
        A.BillingCountry = 'USA';
        A.BillingPostalCode = '66212';
        A.BillingState = 'TS';
        A.BillingStreet = '1234';
        insert A;
                
                Contact C = new Contact();
        C.FirstName = 'test';
        C.LastName = 'testing';
        C.AccountId = A.Id;
        C.Email = 'testemail@email.com';
        C.Phone = '9999999999';
        insert C;

        Test.startTest();
        WIC.username = 'mjolitz';
        WIC.password = 'Vinsol12';
        WIC.startDate = '06/20/2011';
        WIC.endDate = '06/20/2011';
        WIC.publicSessionKey = '579540354';
        WIC.classMap = new MAP<String, Online_Class__c>();
        Online_Class__c testOnlineClass = new Online_Class__c(sessionKey__c = '579540354');
        insert testOnlineClass;         
        WIC.classMap.put('579540354', testOnlineClass);
        WIC.setAllClasses();
        Http http = new Http();
        HttpRequest req = WIC.createClassListRequest(http);
        HttpResponse res = new HttpResponse();
        res.setBody('<?xml version="1.0" encoding="UTF-8"?><serv:message xmlns:serv="http://www.webex.com/schemas/2002/06/service" xmlns:com="http://www.webex.com/schemas/2002/06/common" xmlns:sess="http://www.webex.com/schemas/2002/06/service/session" xmlns:train="http://www.webex.com/schemas/2002/06/service/trainingsession" xmlns:qti="http://www.webex.com/schemas/2002/06/service/trainingsessionqti" xmlns:qtiasi="http://www.webex.com/schemas/2002/06/service/trainingsessionqtiasi"><serv:header><serv:response><serv:result>SUCCESS</serv:result><serv:gsbStatus>PRIMARY</serv:gsbStatus></serv:response></serv:header><serv:body><serv:bodyContent xsi:type="train:lstsummaryTrainingSessionResponse" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><train:trainingSession><train:sessionKey>579540354</train:sessionKey><train:confName>Distributions AKA Bulk Email</train:confName><train:meetingType>233</train:meetingType><train:hostWebExID>culmer</train:hostWebExID><train:otherHostWebExID>culmer</train:otherHostWebExID><train:timeZoneID>7</train:timeZoneID><train:timeZone>GMT-05:00, Central (Chicago)</train:timeZone><train:status>NOT_INPROGRESS</train:status><train:startDate>06/01/2011 13:30:00</train:startDate><train:duration>20</train:duration><train:listStatus>PUBLIC</train:listStatus></train:trainingSession><train:matchingRecords><serv:total>1</serv:total><serv:returned>11</serv:returned><serv:startFrom>1</serv:startFrom></train:matchingRecords></serv:bodyContent></serv:body></serv:message>');
        WIC.setOnlineClassList(res);
        XmlStreamReader reader = res.getXmlStreamReader();              
        
        WIC.onlineClassList = WIC.cleanClassList(WIC.parseOnlineClassList(reader)); 
        WIC.saveClassList();
        
        http = new Http();              
        req = WIC.setCurrentTimecardListRequest(http);                          
        res.setBody('<?xml version="1.0" encoding="UTF-8"?><serv:message xmlns:serv="http://www.webex.com/schemas/2002/06/service" xmlns:com="http://www.webex.com/schemas/2002/06/common" xmlns:att="http://www.webex.com/schemas/2002/06/service/attendee"><serv:header><serv:response><serv:result>SUCCESS</serv:result><serv:gsbStatus>PRIMARY</serv:gsbStatus></serv:response></serv:header><serv:body><serv:bodyContent xsi:type="att:lstMeetingAttendeeResponse" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"><att:matchingRecords><serv:total>1</serv:total><serv:returned>1</serv:returned><serv:startFrom>1</serv:startFrom></att:matchingRecords><att:attendee><att:person><com:name>Kevin Loney</com:name><com:firstName>Kevin</com:firstName><com:lastName>Loney</com:lastName><com:title>IT Manager</com:title><com:company>Korum Automotive Group</com:company><com:address><com:addressType>PERSONAL</com:addressType></com:address><com:phones/><com:email>testemail@email.com</com:email><com:type>VISITOR</com:type></att:person><att:contactID>1231518292</att:contactID><att:joinStatus>ACCEPT</att:joinStatus><att:meetingKey>579540354</att:meetingKey><att:sessionKey>579540354</att:sessionKey><att:language>ENGLISH</att:language><att:role>ATTENDEE</att:role><att:locale>U.S.</att:locale><att:timeZoneID>4</att:timeZoneID><att:languageID>1</att:languageID><att:attendeeId>1231518292</att:attendeeId><att:confID>774768661</att:confID><att:registerID>464688</att:registerID></att:attendee></serv:bodyContent></serv:body></serv:message>');
        WIC.setCurrentTimecardList(res);
        
        WIC.currentTimecardList[0].Contact__c = C.Id;   
        
        WIC.saveClassWithTimecards();
        test.stopTest();
    }  
}