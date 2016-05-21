/*
 * Class/Method Name: ViewKeyContacts
 * Author/Date: Dean Lukowski November 7, 2014
 * Purpose: To create a visualforce related list on the vAuto POA page layout,
 * as to filter out contacts that are not vAuto on the associated account.
 */

public with sharing class ViewKeyContacts {

    public String POAId{get;set;}
    public POA__c poaObj{get;set;}
    public String poaAccount{get;set;}
    public String poaAccountName{get;set;}
    public List<Contact> keyContacts{get;set;}
    public List<KeyContactsWrapper> keyContactWrapList{get;set;}
    public KeyContactsWrapper keyContactsWrap{get;set;}
    public String removeKCId {get;set;}
    public String editKCId {get;set;}
    public String viewKCId {get;set;}
    public Integer numOfKCRows {get;set;}
    public Boolean sendEmails {get;set;}
    public String pageURL {get;set;}

    private ApexPages.StandardController stdController;
    public ViewKeyContacts(ApexPages.StandardController stdController) {
        this.stdController = stdController;
        POAId = String.valueOf(stdController.getRecord().get('id'));
        pageURL = ApexPages.currentPage().getUrl();
        if(pageURL.contains('&inline')){
            sendEmails = true;
        }
        else{
            sendEmails = false;
        }
        getAccount();
        getvAutoContacts();
        initializeKeyContactsWrapper();
    }

    public PageReference Refresh(){
        getvAutoContacts();
        initializeKeyContactsWrapper();
        return null;
    }

    //Grabbing the Account on the POA.
    public void getAccount(){
        try {
            if (POAId != null){
                poaObj = [SELECT Id, Name, Dealer__r.Id,Dealer__r.Name, Business_Unit__c
                          FROM   POA__c
                          WHERE  Id =: POAId LIMIT 1];

                if (poaObj != null){
                    poaAccount = poaObj.Dealer__r.Id;
                }
            }
            else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to retrieve an ID for a POA.');
                ApexPages.addMessage(myMsg);
            }
        }
        catch (exception e) {
            System.debug('getAccount() encountered an exception: ' + e.getMessage());
            throw e;
        }
    }

    //Grabbing the vAuto Contacts from the Account on the POA.
    public void getvAutoContacts(){
        try{
            if (poaAccount != null) {
                keyContacts = [SELECT Id, Name, Email, MobilePhone, Phone, Title, Business_Unit__c, Gone__c, Trained_Date__c,
                                      vAuto_Account__c, Role__c
                               FROM   Contact
                               WHERE  AccountId =: poaAccount AND vAuto_Account__c != null ORDER BY Gone__c Asc, Name Asc];
            numOfKCRows = keyContacts.size();
            }
            else{
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Unable to retrieve an AccountId from the POA.');
                ApexPages.addMessage(myMsg);
            }
        }
        catch (exception e) {
            System.debug('getvAutoContacts() encountered an exception: ' + e.getMessage());
            throw e;
        }
    }

    //Utilizing a class to setup each record to appear in a custom related list.
    public void initializeKeyContactsWrapper(){
        keyContactWrapList = null;
        if(keyContacts != null && keyContacts.size() > 0){
            keyContactWrapList = new List<KeyContactsWrapper>();
            for(Contact thisContact : keyContacts){
                keyContactsWrap = new KeyContactsWrapper();
                keyContactsWrap.contactId = thisContact.Id;
                keyContactsWrap.contactName = thisContact.Name;
                keyContactsWrap.contactTitle = thisContact.Title;
                keyContactsWrap.contactPhone = thisContact.Phone;
                keyContactsWrap.contactMobilePhone = thisContact.MobilePhone;
                keyContactsWrap.contactEmail = thisContact.Email;
                keyContactsWrap.contactGone = thisContact.Gone__c;
                keyContactsWrap.contactTrainedDate = thisContact.Trained_Date__c;
                keyContactsWrap.contactRole = thisContact.Role__c;
                keyContactWrapList.add(keyContactsWrap);
            }
        }
    }

    //The class for all related contacts
    public class KeyContactsWrapper{
        public String contactId{get;set;}
        public String contactName{get;set;}
        public String contactEmail{get;set;}
        public String contactMobilePhone{get;set;}
        public String contactPhone{get;set;}
        public String contactTitle{get;set;}
        public Boolean contactGone{get;set;}
        public String vAutoAccount{get;set;}
        public String vAutoAccountStatus{get;set;}
        public Date contactTrainedDate{get;set;}
        public String contactRole{get;set;}
    }
}