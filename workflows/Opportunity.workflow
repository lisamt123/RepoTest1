<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <flowActions>
        <fullName>Set_Salesperson_from_Current_User</fullName>
        <flow>Set_Opp_Salesperson</flow>
        <flowInputs>
            <name>varCurrentUserID</name>
            <value>{!$User.Id}</value>
        </flowInputs>
        <flowInputs>
            <name>varOppID</name>
            <value>{!Id}</value>
        </flowInputs>
        <flowInputs>
            <name>varOppStage</name>
            <value>{!StageName}</value>
        </flowInputs>
        <label>Set Salesperson from Current User</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
</Workflow>
