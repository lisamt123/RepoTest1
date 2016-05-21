@isTest
public class MotosnapCalloutMock implements HttpCalloutMock {

    public HTTPResponse respond(HTTPRequest req) {
        // Grabbing callout data from a custom setting
        Motosnap_Callout__c callOutCustSet = Motosnap_Callout__c.getValues('MotosnapCustSet'); 
        System.assertEquals(callOutCustSet.callOutURL__c, req.getEndpoint());
        System.assertEquals(callOutCustSet.apikey__c, req.getHeader('apikey'));
        System.assertEquals('POST', req.getMethod());
        // Create a fake response
        HttpResponse res = new HttpResponse();
        if(TestData.isMotoSnapCalloutSuccess){
            //return a suuccess full response;
            res.setHeader('apikey', 'Test APIkey');
            res.setBody('{"DealerId":8499,"InvoiceItemsToEnable":[{"Amount":-0.01,"SalesforceId":"a1T70000004GpMREA0","InvoiceItemId":"SVC-PHONSYIN","Type":3,"OrderNumber":"80070000000tdtkAAA"}],"InvoiceItemIdsToDisable":[]}');
            res.setStatusCode(202);
            res.setStatus('Accepted');
        }
        else if(!TestData.isMotoSnapCalloutSuccess){
            //return something failed
            if(TestData.isMotoSnapTimeOutError){
                //Make sure throw an exception
                throw new CoxAutomotiveException('Motosnap service timedout');
                res.setHeader('apikey', 'Test APIkey');
                res.setBody('Change Once we log a timedout error');
                res.setStatusCode(304);
                res.setStatus('Timedout');
            }
        }
        return res;
    }
}