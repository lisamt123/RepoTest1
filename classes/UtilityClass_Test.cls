@isTest
public with sharing class UtilityClass_Test {
	
static testMethod void CreateLog(){
	//create user
	Profile pfl = [select id from profile where name='Standard User'];	
   User usrAux = new User();
   
    Datetime myDatetime = Datetime.now();
	String userName = myDatetime.format('MMMM-d-yyyy-hhmmss')+Math.random()*10+'@test.com';
    usrAux.Username = userName;
    usrAux.FirstName= 'FirstName';
    usrAux.LastName= 'LastName';
    usrAux.Alias = usrAux.FirstName.SubString(0,1)+usrAux.LastName.SubString(0,1);
    usrAux.IsActive= true;
    usrAux.Email = userName;    
    usrAux.TimeZoneSidKey= 'America/Los_Angeles';
    usrAux.LocaleSidKey= 'en_US';
    usrAux.EmailEncodingKey ='UTF-8';
    
    usrAux.ProfileId = pfl.id;
    usrAux.LanguageLocaleKey ='en_US';
    insert usrAux;
	String message = 'Test Message';
	System.runAs(usrAux){
		
		UtilityClass.CreateApexLog(message);	
	}
	List<ApexLog__c> logs = [Select a.Details__c, a.User__r.Name, a.User__c, a.Owner.Name, a.OwnerId From ApexLog__c a];
	System.Assert(logs!= null ,'NO Logs were created');
		System.Assert(logs.size()!= 0 ,'NO Logs were created');
		System.Assert(logs.size()==1 ,'NUmber of Logs created does not match, expected 1 found: '+logs.size());
	logs = [Select a.Details__c, a.User__r.Name, a.User__c, a.Owner.Name, a.OwnerId From ApexLog__c a where a.User__c=: usrAux.Id];
		System.Assert(logs!= null ,'NO Logs were created');
		System.Assert(logs.size()!= 0 ,'NO Logs were created');
		System.Assert(logs.size()== 1,'Number of logs reated do not match');
		System.Assert(logs[0].Details__c== message,'Log message did not match');
		System.debug('Log Owner: '+logs[0].Owner.Name);
		System.debug('Log User: '+logs[0].User__r.Name);
		
		usrAux = new User();
   
    myDatetime = Datetime.now();
	userName = myDatetime.format('MMMM-d-yyyy-hhmmss')+Math.random()*10+'@test.com';
    usrAux.Username = userName;
    usrAux.FirstName= '2FirstName';
    usrAux.LastName= '2LastName';
    usrAux.Alias = usrAux.FirstName.SubString(0,1)+usrAux.LastName.SubString(0,1);
    usrAux.IsActive= true;
    usrAux.Email = userName;    
    usrAux.TimeZoneSidKey= 'America/Los_Angeles';
    usrAux.LocaleSidKey= 'en_US';
    usrAux.EmailEncodingKey ='UTF-8';
    
    usrAux.ProfileId = pfl.id;
    usrAux.LanguageLocaleKey ='en_US';
    insert usrAux;
    
    	System.runAs(usrAux){
		
		UtilityClass.CreateApexLog(message);	
	}
	logs = [Select a.Details__c, a.User__r.Name, a.User__c, a.Owner.Name, a.OwnerId From ApexLog__c a];
	System.Assert(logs!= null ,'NO Logs were created');
		System.Assert(logs.size()!= 0 ,'NO Logs were created');
		System.Assert(logs.size()==2 ,'NUmber of Logs created does not match, expected 2 found: '+logs.size());
	logs = [Select a.Details__c, a.User__r.Name, a.User__c, a.Owner.Name, a.OwnerId From ApexLog__c a where a.User__c=: usrAux.Id];
		System.Assert(logs!= null ,'NO Logs were created');
		System.Assert(logs.size()!= 0 ,'NO Logs were created');
		System.Assert(logs.size()== 1,'Number of logs reated do not match');
		System.Assert(logs[0].Details__c== message,'Log message did not match');
		System.debug('Log Owner: '+logs[0].Owner.Name);
		System.debug('Log User: '+logs[0].User__r.Name);
		
		
				usrAux = new User();
   
    myDatetime = Datetime.now();
	userName = myDatetime.format('MMMM-d-yyyy-hhmmss')+Math.random()*10+'@test.com';
    usrAux.Username = userName;
    usrAux.FirstName= '3FirstName';
    usrAux.LastName= '3LastName';
    usrAux.Alias = usrAux.FirstName.SubString(0,1)+usrAux.LastName.SubString(0,1);
    usrAux.IsActive= true;
    usrAux.Email = userName;    
    usrAux.TimeZoneSidKey= 'America/Los_Angeles';
    usrAux.LocaleSidKey= 'en_US';
    usrAux.EmailEncodingKey ='UTF-8';
    
    usrAux.ProfileId = pfl.id;
    usrAux.LanguageLocaleKey ='en_US';
    insert usrAux;
    
			System.runAs(usrAux){
		CoxAutomotiveException exp1 =  new CoxAutomotiveException('Test Exception1');
		CoxAutomotiveException exp2 =  new CoxAutomotiveException('Test Exception2');
		exp2.initCause(exp1);
		UtilityClass.DebugException(exp2);
			
	}
	
	logs = [Select a.Details__c, a.User__r.Name, a.User__c, a.Owner.Name, a.OwnerId From ApexLog__c a];
	System.Assert(logs!= null ,'NO Logs were created');
		System.Assert(logs.size()!= 0 ,'NO Logs were created');
		System.Assert(logs.size()==3 ,'NUmber of Logs created does not match, expected 3 found: '+logs.size());
	logs = [Select a.Details__c, a.User__r.Name, a.User__c, a.Owner.Name, a.OwnerId From ApexLog__c a where a.User__c=: usrAux.Id];
		System.Assert(logs!= null ,'NO Logs were created');
		System.Assert(logs.size()!= 0 ,'NO Logs were created');
		System.Assert(logs.size()== 1,'Number of logs reated do not match');
		System.Assert(logs[0].Details__c.contains('CoxAutomotiveException'),'Log message did not match');		
		System.debug('Log Owner: '+logs[0].Owner.Name);
		System.debug('Log User: '+logs[0].User__r.Name);
	
	
}

static testMethod void testDeveloperEmail(){
	Developer_Email__c email1 = new Developer_Email__c(Name = 'TestEmail1', Developer__c = '1@2.com');
    insert email1;
    Developer_Email__c email2 = new Developer_Email__c(Name = 'TestEmail2', Developer__c = '2@3.com');
    insert email2;
    Developer_Email__c email3 = new Developer_Email__c(Name = 'TestEmail3', Developer__c = '3@4.com');
    insert email3;
    Test.startTest();
	UtilityClass.DevelopersEmail('test message', 'test subject');
	Test.stopTest();
}

}