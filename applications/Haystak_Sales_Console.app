<?xml version="1.0" encoding="UTF-8"?>
<CustomApplication xmlns="http://soap.sforce.com/2006/04/metadata">
    <defaultLandingTab>standard-home</defaultLandingTab>
    <detailPageRefreshMethod>none</detailPageRefreshMethod>
    <enableCustomizeMyTabs>false</enableCustomizeMyTabs>
    <enableKeyboardShortcuts>true</enableKeyboardShortcuts>
    <enableListViewReskin>true</enableListViewReskin>
    <enableMultiMonitorComponents>true</enableMultiMonitorComponents>
    <enablePinTabs>true</enablePinTabs>
    <enableTabHover>false</enableTabHover>
    <enableTabLimits>false</enableTabLimits>
    <isServiceCloudConsole>true</isServiceCloudConsole>
    <keyboardShortcuts>
        <defaultShortcut>
            <action>FOCUS_CONSOLE</action>
            <active>true</active>
            <keyCommand>ESC</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_NAVIGATOR_TAB</action>
            <active>true</active>
            <keyCommand>V</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_DETAIL_VIEW</action>
            <active>true</active>
            <keyCommand>SHIFT+S</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_PRIMARY_TAB_PANEL</action>
            <active>true</active>
            <keyCommand>P</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_SUBTAB_PANEL</action>
            <active>true</active>
            <keyCommand>S</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_LIST_VIEW</action>
            <active>true</active>
            <keyCommand>N</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_FIRST_LIST_VIEW</action>
            <active>true</active>
            <keyCommand>SHIFT+F</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_SEARCH_INPUT</action>
            <active>true</active>
            <keyCommand>R</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>MOVE_LEFT</action>
            <active>true</active>
            <keyCommand>LEFT ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>MOVE_RIGHT</action>
            <active>true</active>
            <keyCommand>RIGHT ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>UP_ARROW</action>
            <active>true</active>
            <keyCommand>UP ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>DOWN_ARROW</action>
            <active>true</active>
            <keyCommand>DOWN ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>OPEN_TAB_SCROLLER_MENU</action>
            <active>true</active>
            <keyCommand>D</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>OPEN_TAB</action>
            <active>true</active>
            <keyCommand>T</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>CLOSE_TAB</action>
            <active>true</active>
            <keyCommand>C</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>REFRESH_TAB</action>
            <active>false</active>
            <keyCommand>SHIFT+R</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>ENTER</action>
            <active>true</active>
            <keyCommand>ENTER</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>EDIT</action>
            <active>true</active>
            <keyCommand>E</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>SAVE</action>
            <active>true</active>
            <keyCommand>CTRL+S</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>CONSOLE_LINK_DIALOG</action>
            <active>false</active>
            <keyCommand>U</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>HOTKEYS_PANEL</action>
            <active>false</active>
            <keyCommand>SHIFT+K</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_MACRO</action>
            <active>false</active>
            <keyCommand>M</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>FOCUS_FOOTER_PANEL</action>
            <active>false</active>
            <keyCommand>F</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>TOGGLE_LIST_VIEW</action>
            <active>false</active>
            <keyCommand>SHIFT+N</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>TOGGLE_LEFT_SIDEBAR</action>
            <active>false</active>
            <keyCommand>SHIFT+LEFT ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>TOGGLE_RIGHT_SIDEBAR</action>
            <active>false</active>
            <keyCommand>SHIFT+RIGHT ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>TOGGLE_TOP_SIDEBAR</action>
            <active>false</active>
            <keyCommand>SHIFT+UP ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>TOGGLE_BOTTOM_SIDEBAR</action>
            <active>false</active>
            <keyCommand>SHIFT+DOWN ARROW</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>TOGGLE_APP_LEVEL_COMPONENTS</action>
            <active>false</active>
            <keyCommand>Z</keyCommand>
        </defaultShortcut>
        <defaultShortcut>
            <action>REOPEN_LAST_TAB</action>
            <active>false</active>
            <keyCommand>SHIFT+C</keyCommand>
        </defaultShortcut>
    </keyboardShortcuts>
    <label>Haystak Sales Console</label>
    <listPlacement>
        <height>10</height>
        <location>top</location>
        <units>percent</units>
    </listPlacement>
    <listRefreshMethod>none</listRefreshMethod>
    <logo>Company_Logos/Haystak_Logo.png</logo>
    <pushNotifications>
        <pushNotification>
            <fieldNames>Escalate_To__c</fieldNames>
            <fieldNames>Escalation_Type__c</fieldNames>
            <fieldNames>IsChild__c</fieldNames>
            <fieldNames>IsEscalated</fieldNames>
            <fieldNames>Owner</fieldNames>
            <fieldNames>Resolved__c</fieldNames>
            <fieldNames>Status</fieldNames>
            <fieldNames>Status1__c</fieldNames>
            <fieldNames>Subject</fieldNames>
            <objectName>Case</objectName>
        </pushNotification>
    </pushNotifications>
    <saveUserSessions>true</saveUserSessions>
    <tab>standard-Account</tab>
    <tab>standard-Contact</tab>
    <tab>standard-Opportunity</tab>
    <tab>eAcademy__c</tab>
    <tab>eAcademies_Portal</tab>
    <tab>Subscription__c</tab>
    <tab>Functional_Requirement__c</tab>
    <workspaceMappings>
        <mapping>
            <tab>Functional_Requirement__c</tab>
        </mapping>
        <mapping>
            <tab>Subscription__c</tab>
        </mapping>
        <mapping>
            <tab>eAcademies_Portal</tab>
        </mapping>
        <mapping>
            <tab>eAcademy__c</tab>
        </mapping>
        <mapping>
            <tab>standard-Account</tab>
        </mapping>
        <mapping>
            <fieldName>AccountId</fieldName>
            <tab>standard-Contact</tab>
        </mapping>
        <mapping>
            <fieldName>AccountId</fieldName>
            <tab>standard-Opportunity</tab>
        </mapping>
    </workspaceMappings>
</CustomApplication>