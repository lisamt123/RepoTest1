<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <flowActions>
        <fullName>Generate_PM_Call_POA_Task</fullName>
        <flow>Generate_PM_Call_POA_Task</flow>
        <flowInputs>
            <name>varBillingAssetID</name>
            <value>{!Id}</value>
        </flowInputs>
        <flowInputs>
            <name>varPOAID</name>
            <value>{!Related_POA__c}</value>
        </flowInputs>
        <flowInputs>
            <name>varPOAOwnerID</name>
            <value>{!Related_POA__r.OwnerId}</value>
        </flowInputs>
        <flowInputs>
            <name>varProductName</name>
            <value>{!Suite_Name__c}</value>
        </flowInputs>
        <flowInputs>
            <name>varProductStatus</name>
            <value>{!LOB_Status__c}</value>
        </flowInputs>
        <label>Generate PM Call POA Task</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <flowActions>
        <fullName>Set_Account_Billing_Type</fullName>
        <flow>Set_Account_Billing_Type</flow>
        <flowInputs>
            <name>varAccountSVOCID</name>
            <value>{!Subscriber_SVOC_ID__c}</value>
        </flowInputs>
        <flowInputs>
            <name>varClickerName</name>
            <value>{!$User.User_Full_Name__c}</value>
        </flowInputs>
        <label>Set Account Billing Type</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
</Workflow>
