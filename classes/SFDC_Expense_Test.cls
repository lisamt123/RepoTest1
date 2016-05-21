@isTest

private class SFDC_Expense_Test {
	
	static testMethod void expenseTest()
	{
		
		SFDC_Expense_Header__c tstExpnse = new SFDC_Expense_Header__c();
		tstExpnse.User__c = '00570000000n1KZAAY';
		tstExpnse.Week_Ending__c = date.valueOf('2013-10-21');
		//tstExpnse.Account_Name__c = '001S000000SzoddlAB';
		//tstExpnse.Owner = 'Thomas Vogt';
		insert tstExpnse;
		
		
	}

}