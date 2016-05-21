trigger DemoTriggers on Demo__c (after delete, after insert, after undelete, 
after update, before delete, before insert, before update) 
{

	/*Ramana: Adding a check to support migration effort so that we can disable trigegrs in some cases*/    
if(StaticData.DisabledTriggers!= null && StaticData.DisabledTriggers.contains('DemoTriggers')){
	system.debug('UserInfo.getUserId(): '+UserInfo.getUserId());
	system.debug('UserInfo.getUserName(): '+UserInfo.getUserName());
	system.debug('Skipping the Trigger run since TriggerDisable__c setting includes this trigger to skip');
	return;
}

	
	if(trigger.isAfter&&!trigger.isDelete)
	{
		//Map out the demos being updated
		MAP<Id, Demo__c> theseDemos = new MAP<Id, Demo__c>();
		for(Demo__c thisDemo:Trigger.new)
		{
			theseDemos.put(thisDemo.Opportunity__c, thisDemo);
		}
				
		//create a list of all opportunities related to updating demos			
		LIST<Opportunity> theseOpportunities = [select id, Number_of_Webex_Demos__c from Opportunity where id IN:theseDemos.keySet()];
		
		
		//create a list of all demos related to all opptys
		LIST<Demo__c> allDemos = [select Id, Opportunity__c from Demo__c where Opportunity__c IN: theseDemos.keySet()];
		
		if(trigger.isInsert)
		{			
			for(Demo__c Dmo :Trigger.new)
			{
				Opportunity thisOppty = new Opportunity();
				
				if(Dmo.Opportunity__c!=null)
				{
					for(Opportunity sendOppty:theseOpportunities)
					{
						if(sendOppty.Id==Dmo.Opportunity__c)
						{
							thisOppty = sendOppty;
						}
					}
					
					integer numberDemos = 0;
					for(Demo__c countDemos:allDemos)
					{
						if(countDemos.Opportunity__c==Dmo.Opportunity__c)
						{
							numberDemos+=1;
						}
					}
					thisOppty.Number_of_Webex_Demos__c = numberDemos;					
					//DemosClass.UpdateNumberOfDemosOnOppty(Dmo);
				}
				update thisOppty;
			}
		}
		if(trigger.isUpdate)
		{
			Opportunity thisOppty = new Opportunity();
			
			for(Demo__c Dmo:Trigger.new)
			{
				/*for(Demo__c oDmo:Trigger.old)
				{*/
					Demo__c oDmo = trigger.oldMap.get(Dmo.Id);
					for(Opportunity sendOppty:theseOpportunities)
					{
						if(sendOppty.Id==Dmo.Opportunity__c)
						{
							thisOppty = sendOppty;
						}
					}
				
					integer numberDemos = 0;
					for(Demo__c countDemos:allDemos)
					{
						if(countDemos.Opportunity__c==Dmo.Opportunity__c)
						{
							numberDemos+=1;
						}
					}
					thisOppty.Number_of_Webex_Demos__c = numberDemos;					
					//DemosClass.UpdateNumberOfDemosOnOppty(Dmo);				
					
					update thisOppty;
				//}
			}
		}
	}
	if(trigger.isAfter&&trigger.isDelete)
	{
		//Map out the demos being updated
		MAP<Id, Demo__c> theseDemosDelete = new MAP<Id, Demo__c>();
		for(Demo__c thisDemo:Trigger.old)
		{
			theseDemosDelete.put(thisDemo.Opportunity__c, thisDemo);
		}
				
		//create a list of all opportunities related to updating demos			
		LIST<Opportunity> theseOpportunities = [select id, Number_of_Webex_Demos__c from Opportunity where id IN:theseDemosDelete.keySet()];
		
		
		//create a list of all demos related to all opptys
		LIST<Demo__c> allDemos = [select Id, Opportunity__c from Demo__c where Opportunity__c IN: theseDemosDelete.keySet()];
		
		Opportunity thisOppty = new Opportunity();
		
		for(Demo__c Dmo: Trigger.old)
		{
			for(Opportunity sendOppty:theseOpportunities)
			{
				if(sendOppty.Id==Dmo.Opportunity__c)
				{
					thisOppty = sendOppty;
				}
			}
			
			integer numberDemos = 0;
			for(Demo__c countDemos:allDemos)
			{
				if(countDemos.Opportunity__c==Dmo.Opportunity__c)
				{
					numberDemos+=1;
				}
			}
			thisOppty.Number_of_Webex_Demos__c = numberDemos;
								
			//DemosClass.UpdateNumberOfDemosOnOppty(Dmo);
		}
		update thisOppty;
	}	
}