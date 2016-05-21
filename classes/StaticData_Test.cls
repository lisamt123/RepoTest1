@isTest(SeeAllData=True) 
public class StaticData_Test { 
    static testMethod void testOpportunityRecTypesMap() {    	
    	Map<Id,RecordType> recTypes = StaticData.getInstance().OpportunityRecTypesMap;
    	System.Assert(recTypes != null,'No Opportunity record types returned');
    	System.Assert(recTypes.size() >0,'No Opportunity record types returned');
    	System.Assert(recTypes.values()[0].sObjectType == 'Opportunity','Did not return Opportunity recordTypes');
    	Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().OpportunityRecTypesMapByDevName;
    	System.Assert(recTypesMapByDevName != null,'No Opportunity record types returned');
    	System.Assert(recTypesMapByDevName.size() >0,'No Opportunity record types returned');
    	System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'Opportunity','Did not return Opportunity recordTypes');
    }
    
    static testMethod void testProjectRecTypesMap() {    	
    	Map<Id,RecordType> recTypes = StaticData.getInstance().ProjectRecTypesMap;
    	System.Assert(recTypes != null,'No Project record types returned');
    	System.Assert(recTypes.size() >0,'No Project record types returned');
    	System.Assert(recTypes.values()[0].sObjectType == 'SFDC_520_Quote__c','Did not return Project recordTypes');
    	Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().ProjectRecTypesMapByDevName;    	
    	System.Assert(recTypesMapByDevName != null,'No Project record types returned');
    	System.Assert(recTypesMapByDevName.size() >0,'No Project record types returned');
    	System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'SFDC_520_Quote__c','Did not return Project recordTypes');
    	Map<String,RecordType> recTypesMapByName = StaticData.getInstance().ProjectRecTypesMapByName;    	
    	System.Assert(recTypesMapByName != null,'No Project record types returned');
    	System.Assert(recTypesMapByName.size() >0,'No Project record types returned');
    	System.Assert(recTypesMapByName.values()[0].sObjectType == 'SFDC_520_Quote__c','Did not return Project recordTypes');
    }
    
    static testMethod void testProjectPiecesRecTypesMap() {    	
    	Map<Id,RecordType> recTypes = StaticData.getInstance().ProjectPiecesRecTypesMap;
    	System.Assert(recTypes != null,'No ProjectPieces record types returned');
    	System.Assert(recTypes.size() >0,'No ProjectPieces record types returned');
    	System.Assert(recTypes.values()[0].sObjectType == 'Project_Piece__c','Did not return ProjectPieces recordTypes');
    	Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().ProjectPiecesRecTypesMapByDevName;    	
    	System.Assert(recTypesMapByDevName != null,'No ProjectPieces record types returned');
    	System.Assert(recTypesMapByDevName.size() >0,'No ProjectPieces record types returned');
    	System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'Project_Piece__c','Did not return ProjectPieces recordTypes');
    }
    
   static testMethod void testPOARecTypesMap() {    	
    	Map<Id,RecordType> recTypes = StaticData.getInstance().POARecTypesMap;
    	System.Assert(recTypes != null,'No POA record types returned');
    	System.Assert(recTypes.size() >0,'No POA record types returned');
    	System.Assert(recTypes.values()[0].sObjectType == 'POA__c','Did not return POA recordTypes');
    	Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().POARecTypesMapByDevName;    	
    	System.Assert(recTypesMapByDevName != null,'No POA record types returned');
    	System.Assert(recTypesMapByDevName.size() >0,'No POA record types returned');
    	System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'POA__c','Did not return POA recordTypes');
    }
   static testMethod void testContractRecTypesMap() {    	
    	Map<Id,RecordType> recTypes = StaticData.getInstance().ContractRecTypesMap;
    	System.Assert(recTypes != null,'No Contract record types returned');
    	System.Assert(recTypes.size() >0,'No Contract record types returned');
    	System.Assert(recTypes.values()[0].sObjectType == 'Contract','Did not return Contract recordTypes');
    	Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().ContractRecTypesMapByDevName;    	
    	System.Assert(recTypesMapByDevName != null,'No Contract record types returned');
    	System.Assert(recTypesMapByDevName.size() >0,'No Contract record types returned');
    	System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'Contract','Did not return Contract recordTypes');
    }
       static testMethod void testBillinItemRecTypesMap() {    	
    	Map<Id,RecordType> recTypes = StaticData.getInstance().BillingItemRecTypesMap;
    	System.Assert(recTypes != null,'No BillingItem record types returned');
    	System.Assert(recTypes.size() >0,'No BillingItem record types returned');
    	System.Assert(recTypes.values()[0].sObjectType == 'Billing_Item__c','Did not return BillingItem recordTypes');
    	Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().BillingItemRecTypesMapByDevName;    	
    	System.Assert(recTypesMapByDevName != null,'No BillingItem record types returned');
    	System.Assert(recTypesMapByDevName.size() >0,'No BillingItem record types returned');
    	System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'Billing_Item__c','Did not return BillingItem recordTypes');
    }
    
           static testMethod void testProjectDefinitionsMap() {    	
    	Map<Id,Project_Definition__c> projDefList = StaticData.getInstance().ProjectDefinitions();
    	System.Assert(projDefList != null,'No Project Definitions returned');
    	System.Assert(projDefList.size() >0,'No Project Definitions returned');    	
    }
    static testmethod void testTaskRecordTypesMapByDevName() {
        Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().TaskRecordTypeMapByDevName;     
        System.Assert(recTypesMapByDevName != null,'No Task record types returned');
        System.Assert(recTypesMapByDevName.size() >0,'No Task record types returned');
        System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'Task','Did not return Task recordTypes');
    }
    static testMethod void testCaseRecordTypesMap() {       
        Map<Id,RecordType> recTypes = StaticData.getInstance().CaseRecTypesMap;
        System.Assert(recTypes != null,'No Case record types returned');
        System.Assert(recTypes.size() >0,'No Case record types returned');
        System.Assert(recTypes.values()[0].sObjectType == 'Case','Did not return Case recordTypes');
        Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().CaseRecTypesMapByDevName;     
        System.Assert(recTypesMapByDevName != null,'No Case record types returned');
        System.Assert(recTypesMapByDevName.size() >0,'No Case record types returned');
        System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'Case','Did not return Case recordTypes');
        Map<String,RecordType> recTypesMapByName = StaticData.getInstance().CaseRecTypesMapByName;       
        System.Assert(recTypesMapByName != null,'No Case record types returned');
        System.Assert(recTypesMapByName.size() >0,'No Case record types returned');
        System.Assert(recTypesMapByName.values()[0].sObjectType == 'Case','Did not return Case recordTypes');
    }
    static testMethod void testAccountRecordTypesMap() {       
        Map<Id,RecordType> recTypes = StaticData.getInstance().AccountRecTypesMap;
        System.Assert(recTypes != null,'No Account record types returned');
        System.Assert(recTypes.size() >0,'No Account record types returned');
        System.Assert(recTypes.values()[0].sObjectType == 'Account','Did not return Account recordTypes');
        Map<String,RecordType> recTypesMapByDevName = StaticData.getInstance().AccountRecTypesMapByDevName;     
        System.Assert(recTypesMapByDevName != null,'No Account record types returned');
        System.Assert(recTypesMapByDevName.size() >0,'No Account record types returned');
        System.Assert(recTypesMapByDevName.values()[0].sObjectType == 'Account','Did not return Account recordTypes');
        Map<String,RecordType> recTypesMapByName = StaticData.getInstance().AccountRecTypesMapByName;       
        System.Assert(recTypesMapByName != null,'No Account record types returned');
        System.Assert(recTypesMapByName.size() >0,'No Account record types returned');
        System.Assert(recTypesMapByName.values()[0].sObjectType == 'Account','Did not return Account recordTypes');
    }

     static testMethod void testPricebookEntry() {             
        System.Assert(StaticData.getInstance().GetPricebookEntry('2014 Standard Price Book','SVC-MSDIAPAC') != null,'No product entry is returned');
        //check invalid pricebook data
        try{
                StaticData.getInstance().GetPricebookEntry('NonExistingPriceBook','SVC-MSDIAPAC');
        }
        catch(Exception ex){
            System.assert(ex.getMessage().contains('Could not find Price Book'));
        }

        //check invalid product
        try{
                StaticData.getInstance().GetPricebookEntry('2014 Standard Price Book','NonExistingProduct');
        }
        catch(Exception ex){
            System.assert(ex.getMessage().contains('Could not find Product'));
        }                
    }

    static testMethod void testDisabledTriggers() {             
        Set<String> results = StaticData.DisabledTriggers;
        system.assert(results != null ,'Did not return a valid object');
    }
}