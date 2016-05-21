@isTest(SeeAllData=True) 
private class ContractRollupBRRtoAccount_test{
    static testMethod void myUnitTest() {
       /* // get  Billed Recurring Revenue on test account 0017000000PTIu8 TestDealer
        system.debug('LYNNTEST Get BRR from TestDealer account');
        
        Account a1 = [SELECT Id,Billed_Recurring_Revenue__c FROM Account WHERE Id =:'0017000000PTIu8'];     
        //use contract on test account 80070000000szeS
        system.debug('LYNNTEST Old BRR:');        
        system.debug(a1.Billed_Recurring_Revenue__c);
        //get Total_MRR__c from contract
        //Contract c = [SELECT Id,Total_MRR__c FROM Contract WHERE Id =:'80070000000szeS'];
        Contract c = [Select Id, Total_MRR__c FROM Contract Where Id =: '80070000000tHGG'];       
        system.debug('LYNNTEST Contract Total MRR:');        
        system.debug(c.Total_MRR__c);
        // trigger by modifying active contract billing item a1T70000000YDES
        //Billing_Item__c bi1 = [SELECT Id,Sale_Price__c FROM Billing_Item__c WHERE Id =:'a1T70000000YDES'];    
        Billing_Item__c bi1 = [SELECT Id,Sale_Price__c FROM Billing_Item__c WHERE Id =:'a1T70000000YEdOEAW'];    
        bi1.Sale_Price__c = 5000;
        update bi1;
        
        //Billing_Item__c bi2 = [SELECT Id,Sale_Price__c FROM Billing_Item__c WHERE Id =:'a1T70000000YDES'];    
        Billing_Item__c bi2 = [SELECT Id,Sale_Price__c FROM Billing_Item__c WHERE Id =:'a1T70000000YEdOEAW'];   
        // get new Billed Recurring Revenue
        Account a2 = [SELECT Id,Billed_Recurring_Revenue__c FROM Account WHERE Id =:'0017000000PTIu8']; 
        system.debug('LYNNTEST New sale price:');        
        system.debug(bi2.Sale_Price__c);
        
        //Contract c2 = [SELECT Id,Total_MRR__c FROM Contract WHERE Id =:'80070000000szeS'];
          Contract c2 = [SELECT Id,Total_MRR__c FROM Contract WHERE Id =:'80070000000tHGG'];    
        system.debug('LYNNTEST New Contract Total MRR:');        
        system.debug(c2.Total_MRR__c);
  
        system.debug('LYNNTEST New BRR:');        
        system.debug(a2.Billed_Recurring_Revenue__c);
        
        delete c;
        delete bi2;
        update a2;
                       
        test.startTest();
        
        test.stopTest();*/
   }
}