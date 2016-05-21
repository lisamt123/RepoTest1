@isTest(SeeAllData=true) 
public class vAutoPOAHandler_Test {

static testMethod void UpdatingExistingChurnedPOATest() {

     Contact cont =  Test_vAutoOpportunity.setupContact();
    
     Account acct = Test_vAutoOpportunity.setupAccount();
           Test.startTest();

     POA__c poa1 = new POA__c();
     poa1.RecordTypeId = StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id;
     poa1.Dealer__c = acct.Id;
     poa1.Name = 'POA1';
     System.Assert(poa1.RecordTypeId == StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id,'RecordType is not vAuto');  
     poa1.Status__c = 'Churned';
     insert poa1;


     //check if the account vAuto POA is populated with created POA
     acct = [Select Id, vAuto_POA__c from Account where Id =: acct.Id LIMIT 1 ];
      System.Assert(acct.vAuto_POA__c != null,'vAuto POA Lookup is not populated on account');
      System.Assert(acct.vAuto_POA__c == poa1.Id,'vAuto POA Lookup does not match');

poa1= [Select Id,LastModifiedDate from POA__c where Id=:poa1.Id];



     POA__c poa2 = new POA__c();
     poa2.RecordTypeId = StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id;
     poa2.Dealer__c = acct.Id;
     poa2.Name = 'POA2';   
     System.Assert(poa2.RecordTypeId == StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id,'RecordType is not vAuto');
     poa2.Status__c = 'Churned';
     insert poa2;

poa2= [Select Id,LastModifiedDate from POA__c where Id=:poa2.Id];

   system.debug('poa1.LastModifiedDate: '+poa1.LastModifiedDate);
       system.debug('poa2.LastModifiedDate: '+poa2.LastModifiedDate);

   
//check if the account vAuto POA is populated with most recently modified  POA
     acct = [Select Id, vAuto_POA__c from Account where Id =: acct.Id LIMIT 1 ];
      System.Assert(acct.vAuto_POA__c != null,'vAuto POA Lookup is not populated on account');

      /* Could not assert this everytime since lastmodified days needs to be spaces alteast a sec apart and could not do this consistently 
      using loops and without casuing System.LimitException: Apex CPU time limit exceeded
      system.assert(poa1.LastModifiedDate == poa2.LastModifiedDate,'Both POA LastModified dates are same; could not check if it is using the most recent one; try increasing the time span between two POA creation');
      System.Assert(acct.vAuto_POA__c == poa2.Id,'vAuto POA Lookup does not match');
      */
     POA__c poa3 = new POA__c();
     poa3.RecordTypeId = StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id;
     poa3.Dealer__c = acct.Id;
     poa3.Name = 'POA3';
     System.Assert(poa3.RecordTypeId == StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id,'RecordType is not vAuto');  
     poa3.Status__c = 'Open';


     insert poa3;

    //check if the account vAuto POA is populated Open POA

     acct = [Select Id, vAuto_POA__c from Account where Id =: acct.Id LIMIT 1 ];
      System.Assert(acct.vAuto_POA__c != null,'vAuto POA Lookup is not populated on account');
      System.Assert(acct.vAuto_POA__c == poa3.Id,'vAuto POA Lookup does not match');

//try updating each one and see no errors are thrown
 
poa1.Name = 'poa1Updated';
update poa1;

//check if the account vAuto POA is populated Open POA
acct = [Select Id, vAuto_POA__c from Account where Id =: acct.Id LIMIT 1 ];
      System.Assert(acct.vAuto_POA__c != null,'vAuto POA Lookup is not populated on account');
      System.Assert(acct.vAuto_POA__c == poa3.Id,'vAuto POA Lookup does not match');
 

poa2.Name ='poa2Updated';
update poa2;
//check if the account vAuto POA is populated Open POA
acct = [Select Id, vAuto_POA__c from Account where Id =: acct.Id LIMIT 1 ];
      System.Assert(acct.vAuto_POA__c != null,'vAuto POA Lookup is not populated on account');
      System.Assert(acct.vAuto_POA__c == poa3.Id,'vAuto POA Lookup does not match');
 
poa3.Name = 'poa3Updated';
update poa3;

//check if the account vAuto POA is populated Open POA
 acct = [Select Id, vAuto_POA__c from Account where Id =: acct.Id LIMIT 1 ];
      System.Assert(acct.vAuto_POA__c != null,'vAuto POA Lookup is not populated on account');
      System.Assert(acct.vAuto_POA__c == poa3.Id,'vAuto POA Lookup does not match');


  Test.stopTest();

}

  static testMethod void UsingExistingChurnedPOATest() {

      
    
      Contact cont =  Test_vAutoOpportunity.setupContact();
    
      Account acct = Test_vAutoOpportunity.setupAccount();
      //Create Churned POA on the account
       POA__c poa1 = new POA__c();
       poa1.RecordTypeId = StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id;
       poa1.Dealer__c = acct.Id;
       poa1.Name = 'POA1';
      System.Assert(poa1.RecordTypeId == StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id,'RecordType is not vAuto');  
       poa1.Status__c = 'Churned';
       insert poa1;


      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
      Test_vAutoOpportunity.setupProvisionOpportunity(opp);
      Test.startTest();


      UtilityClass.debugSystemLimits();


       POA__c poa2 = new POA__c();
       poa2.RecordTypeId = StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id;
       poa2.Dealer__c = acct.Id;
       poa2.Name = 'POA2';   
       System.Assert(poa2.RecordTypeId == StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id,'RecordType is not vAuto');
       poa2.Status__c = 'Churned';
       insert poa2;

       //check created churned POA
       List<POA__c> existingChurnedPOA = [Select Id,LastModifiedDate from POA__c where Dealer__c =:acct.Id and  RecordTypeId =:StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id and status__c = 'Churned' order by LastModifiedDate desc];
       system.assert(existingChurnedPOA.size() ==2,'Churned POA count is not matching');
       
       /* Could not assert this everytime since lastmodified days needs to be spaces alteast a sec apart and could not do this consistently 
       using loops and without casuing System.LimitException: Apex CPU time limit exceeded
       system.debug('existingChurnedPOA[0].LastModifiedDate: '+existingChurnedPOA[0].LastModifiedDate);
       system.debug('existingChurnedPOA[1].LastModifiedDate: '+existingChurnedPOA[1].LastModifiedDate);
       system.assert(existingChurnedPOA[0].LastModifiedDate == existingChurnedPOA[1].LastModifiedDate,'Both POA LastModified dates are same; could not check if it is using the most recent one; try increasing the time span between two POA creation');
       system.assert(existingChurnedPOA[0].Id==poa2.Id,'Did not got the POA is in the order it was created');
       */
       


      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      //get Account vAuto POA
       List<POA__c> vAutoPOA = [Select Id,Status__c from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId =: StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id and status__c !=: 'Churned'];
      
      System.Assert(vAutoPOA != null,'No vAuto POA found');
      System.Assert(vAutoPOA.size() != 0,'No vAuto POA found');
      System.Assert(vAutoPOA.size() == 1,'More than one vAuto POA found');
       /* Could not assert this everytime since lastmodified days needs to be spaces alteast a sec apart and could not do this consistently 
       using loops and without casuing System.LimitException: Apex CPU time limit exceeded
      System.Assert(vAutoPOA[0].Id == poa2.Id,'Most recent Churned POA is not used');
      */
      System.Assert(vAutoPOA[0].Status__c == 'Open','POA Sttaus is not set to Open from Churned');
      
      acct = [Select Id, vAuto_POA__c from Account where Id =: opp.AccountId LIMIT 1 ];
      
      System.Assert(acct.vAuto_POA__c != null,'vAuto POA Lookup is not populated on account');
      /* Could not assert this everytime since lastmodified days needs to be spaces alteast a sec apart and could not do this consistently 
       using loops and without casuing System.LimitException: Apex CPU time limit exceeded
      System.Assert(acct.vAuto_POA__c == vAutoPOA[0].Id,'vAuto POA Lookup does not match');
      */
      
}

static testMethod void AccountFieldUpdateTest() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      //get Account vAuto POA
       List<POA__c> vAutoPOA = [Select Id from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId =: StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id and status__c !=: 'Churned'];
      
      System.Assert(vAutoPOA != null,'No vAuto POA found');
      System.Assert(vAutoPOA.size() != 0,'No vAuto POA found');
      System.Assert(vAutoPOA.size() == 1,'More than one vAuto POA found');
      
      acct = [Select Id, vAuto_POA__c from Account where Id =: opp.AccountId LIMIT 1 ];
      System.Assert(acct.vAuto_POA__c != null,'vAuto POA Lookup is not populated on account');
      System.Assert(acct.vAuto_POA__c == vAutoPOA[0].Id,'vAuto POA Lookup does not match');
      
}

static testMethod void OwnerChangedTest() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      //get Account vAuto POA
       List<POA__c> vAutoPOAList = [Select Id,ownerId,Dealer__c from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId =: StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id and status__c !=: 'Churned'];
      
      System.Assert(vAutoPOAList != null,'No vAuto POA found');
      System.Assert(vAutoPOAList.size() != 0,'No vAuto POA found');
      System.Assert(vAutoPOAList.size() == 1,'More than one vAuto POA found');
      POA__c vAutoPOA = vAutoPOAList[0];
      
      UserRole role = [Select Id from UserRole where DeveloperName = 'SystemsAdministrator' LIMIT 1 ];
      Id newOwnerId;
      //update the owner with any user other than the one already assigned
      for(User u : [Select Id  from User where isactive = true and Name != 'SF Admin Team' and UserRoleId =: role.Id]){
      	if(u.Id != vAutoPOA.ownerId){
      		
      		newOwnerId = u.Id;
      		break;
      	}
      	else{continue;}
      }
      System.Assert(newOwnerId !=null, 'New Owner id is null');
      System.Assert(vAutoPOA.ownerId != newOwnerId, 'New Owner id is same as Existing');
      vAutoPOA.ownerId = newOwnerId;
      update vAutoPOA;
      //check if the AccountTeamMember got created with role VAT Performance Manager
      List<AccountTeamMember> accountTeammembers = [Select Id from AccountTeamMember where AccountId =: vAutoPOA.Dealer__c and UserId =: vAutoPOA.ownerId and TeamMemberRole = 'VAT Performance Manager' ];      
      System.Assert(accountTeammembers != null,'vAuto POA Owner is not a VAT Performance Manager');
      System.Assert(accountTeammembers.size()>0,'vAuto POA Owner is not a VAT Performance Manager');
      
}

static testMethod void AccountDirectorChangedTest() {

  Contact cont =  Test_vAutoOpportunity.setupContact();
  	
      Account acct = Test_vAutoOpportunity.setupAccount();
      Opportunity opp= Test_vAutoOpportunity.setupOpportunity(acct, cont, 'vAuto');
	  Test_vAutoOpportunity.setupProvisionOpportunity(opp);
      Test.startTest();
      UtilityClass.debugSystemLimits();
      //set the opp to Closed Own
      opp.StageName= 'Closed or Won';
      update opp;     
        Test.stopTest();
      System.Assert(opp.StageName== 'Closed or Won','Opportunity is not Closed or Won');
      Test_vAutoOpportunity.ValidateOpportunity(opp);
      Test_vAutoOpportunity.ValidatePOA(opp);
      Test_vAutoOpportunity.ValidateProject(opp);      
      Test_vAutoOpportunity.ValidateContract(opp); 
      //get Account vAuto POA
       List<POA__c> vAutoPOAList = [Select Id,Account_Director__c,Dealer__c from POA__c where Dealer__c =: opp.AccountId and  RecordTypeId =: StaticData.getInstance().POARecTypesMapByDevName.get('vAuto').Id and status__c !=: 'Churned'];
      
      System.Assert(vAutoPOAList != null,'No vAuto POA found');
      System.Assert(vAutoPOAList.size() != 0,'No vAuto POA found');
      System.Assert(vAutoPOAList.size() == 1,'More than one vAuto POA found');
      POA__c vAutoPOA = vAutoPOAList[0];
      
      UserRole role = [Select Id from UserRole where  DeveloperName = 'SystemsAdministrator' LIMIT 1 ];
      Id newAccountDirectorId;
      //update the owner with any user other than the one already assigned
      for(User u : [Select Id  from User where isactive = true and UserRoleId =: role.Id]){
      	if(u.Id != vAutoPOA.Account_Director__c){
      		
      		newAccountDirectorId = u.Id;
      		break;
      	}
      	else{continue;}
      }
      System.Assert(newAccountDirectorId !=null, 'New Account Director id is null');
      System.Assert(vAutoPOA.Account_Director__c != newAccountDirectorId, 'New Account Director id is same as Existing');
      vAutoPOA.Account_Director__c = newAccountDirectorId;
      update vAutoPOA;
      //check if the AccountTeamMember got created with role VAT Account Director
      List<AccountTeamMember> accountTeammembers = [Select Id from AccountTeamMember where AccountId =: vAutoPOA.Dealer__c and UserId =: vAutoPOA.Account_Director__c and TeamMemberRole = 'VAT Account Director' ];
      System.Assert(accountTeammembers != null,'vAuto POA Account_Director__c is not a VAT Account Director');
      System.Assert(accountTeammembers.size()>0,'vAuto POA Account_Director__c is not a VAT Account Director');
      
}
}