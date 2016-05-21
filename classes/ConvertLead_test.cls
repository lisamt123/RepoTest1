@isTest
private class ConvertLead_test {

    static testMethod void myUnitTest() {
        
        Account testAcct = TestData.setupAccount();
        insert testAcct;
        Contact testContact = TestData.setupContact(testAcct, 'VinSolutions');
        insert testContact;
        
        ConvertLead plugin = new ConvertLead();
        
        Map<String,Object> inputParams = new Map<String,Object>();

        Lead testLead = TestData.setupLead();
        insert testLead;
        
        InputParams.put('AccountID', testAcct.Id);
        InputParams.put('ContactID', testContact.Id);
        InputParams.put('LeadID', testLead.Id);
        InputParams.put('ConvertedStatus', null);
        InputParams.put('OverwriteLeadSource', null);
        InputParams.put('CreateOpportunity', null);
        InputParams.put('OpportunityName', 'testOppty');
        InputParams.put('SendEmailToOwner', null);
        
        Process.Pluginrequest request = new Process.PluginRequest(inputParams);
        
        plugin.invoke(request);
        plugin.describe();
        
    }
}