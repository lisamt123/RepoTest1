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
private class createAndEmailProposals_TEST {

    static testMethod void previewPDF(){
        /*
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opporutunity';
        //opp.Deal_Contact__c = Ctc.id;
        opp.CloseDate = System.today();
        opp.StageName = 'Prospect';
        opp.Type = 'New Business';
        opp.Salesperson__c = userinfo.getUserId();
        //opp.We_Owe__c = 'N/A';
        opp.Proposal_Previewed__c = true;
        insert opp;
        
        PageReference pref = Page.QuoteShell;
        pref.getParameters().put('id', opp.Id);
        Test.setCurrentPage(pref);
        
        createAndEmailProposal prop = new createAndEmailProposal();
        
        Test.startTest();
        
        //populate the field with value
        prop.parentId = opp.Id;
        prop.fileName = 'Test Pdf';
        //prop.inputTo = 'me@foo.com';
       
        
        
        //submit the record
        pref = prop.previewPDF();
        
        Test.stopTest();
        
        
    }
    static testMethod void testPDFEmailer(){
        
        
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opporutunity';
        //opp.Deal_Contact__c = Ctc.id;
        opp.CloseDate = System.today();
        opp.StageName = 'Prospect';
        opp.Type = 'New Business';
        opp.Salesperson__c = userinfo.getUserId();
        //opp.We_Owe__c = 'N/A';
        insert opp;
        
        
        
        
        PageReference pref = Page.QuoteShell;
        pref.getParameters().put('id', opp.Id);
        Test.setCurrentPage(pref);
        
        Blob body = Blob.ValueOf('dummy text');
        //body = pref.getContentAsPdf();
        
        /*Attachment att = new Attachment();
        att.Body = body;
        att.Name = 'Test PDF';
        att.IsPrivate = false;
        att.contentType = 'pdf';
        att.ParentId = opp.Id;
        insert att;*/
        /*
        createAndEmailProposal prop = new createAndEmailProposal();
        
        Test.startTest();
        
        //populate the field with value
        prop.parentId = opp.Id;
        prop.fileName = 'Test Pdf';
        prop.inputTo = 'me@foo.com';
       
        
        
        //submit the record
        pref = prop.saveAndEmailPdf();
        
        Test.stopTest();
    */
    } 
}