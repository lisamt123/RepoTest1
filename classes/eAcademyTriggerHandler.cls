public with sharing class eAcademyTriggerHandler extends TriggerHandler {

	public List<eAcademy__c> eAcademyWithMotosnapId = new List<eAcademy__c>();
	public Map<String, Id> contactAccount = new Map<String, Id>();
	public Set<String> motoSnapUserIds = new Set<String>();
	
	protected override void beforeInsert(){
		//Find all eLearning records that have passed a BrainShark userId(GBCustom5) and add them to a Set for querying
		//Brainshark field GBCustom5 = salesforce eAcademy field Vin_User_ID__c
		system.debug('========================>>>>> Trigger.new = ' + Trigger.new);
		system.debug('========================>>>>> Trigger.Size = ' + Trigger.new.size());
		for(eAcademy__c eA : (List<eAcademy__c>)Trigger.new){
			if(eA.Vin_User_ID__c != null && eA.Vin_User_ID__c != ''){
				motoSnapUserIds.add(eA.Vin_User_ID__c);
			}
		}
		//Make a Map from Contacts of all the Accounts on a Contact that match the BrainShark userId(GBCustom5) with the
		//MotoSnap_User_Id__c on the Contact record
		system.debug('========================>>>>> motoSnapUserIds = ' + motoSnapUserIds);
		if(motoSnapUserIds.size() > 0){
			for(Contact c : [SELECT MotoSnap_User_Id__c, AccountId FROM Contact WHERE MotoSnap_User_Id__c LIKE :motoSnapUserIds]){
				contactAccount.put(c.MotoSnap_User_Id__c.toLowerCase(), c.AccountId);
			}
		}
		//Assign the found Account of the Contact to the eAcademy record so the eAcademy record can be displayed in a 
		//related list on the Account Page
		for(eAcademy__c eA : (List<eAcademy__c>)Trigger.new){
			if(eA.Vin_User_ID__c != null && eA.Vin_User_ID__c != ''){
				eA.Account_Name__c = contactAccount.get(eA.Vin_User_ID__c.toLowerCase());
			}
			//Names are coming over, starting and ending with [], removing them below
			if(eA.ViewerInfo__c != null && eA.ViewerInfo__c != ''){
				eA.ViewerInfo__c = eA.ViewerInfo__c.replaceAll('[\\p{Punct}&&[^,]]', '');
			}
			if(eA.Sort_ViewerInfo__c != null && eA.Sort_ViewerInfo__c != ''){
				eA.Sort_ViewerInfo__c = eA.Sort_ViewerInfo__c.replaceAll('[\\p{Punct}&&[^,]]', '');
			}
		}
	}
}