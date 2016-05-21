<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <flowActions>
        <fullName>Set_Account_Billing_Type_from_Contract</fullName>
        <flow>Set_Account_Billing_Type</flow>
        <flowInputs>
            <name>varAccountSVOCID</name>
            <value>{!Dealer_SVOC_ID__c}</value>
        </flowInputs>
        <flowInputs>
            <name>varClickerName</name>
            <value>{!$User.User_Full_Name__c}</value>
        </flowInputs>
        <label>Set Account Billing Type from Contract</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
</Workflow>
