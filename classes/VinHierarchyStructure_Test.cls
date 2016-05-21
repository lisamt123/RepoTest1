@isTest
private class VinHierarchyStructure_Test {
	public static vAutoHierarchy_TestUtilities testUtils = new vAutoHierarchy_TestUtilities();
	@isTest static void test_VinCustomHierarchy() {
	
    Set<String> fieldsToCheck = new Set<String>{'AnnualRevenue', 'BillingCity','BillingCountry','BillingPostalCode','BillingState', 'BillingStreet', 'Description', 'ShippingCity', 'ShippingStreet', 'Name', 'ShippingState', 'ShippingPostalCode', 'ShippingCountry' };

    /*Test data Setup*/
    //Create set of Accounts
    testUtils.createAccounts( 4 , fieldsToCheck );
    testUtils.testAccList[0].Name = 'VinHierarchyAccount0';
    //first child for 0
    testUtils.testAccList[1].Name = 'VinHierarchyAccount1';
    testUtils.testAccList[1].VinSolutions_Parent_Account__c = testUtils.testAccList[0].Id;
    //second child for 0
    testUtils.testAccList[2].Name = 'VinHierarchyAccount2';
    testUtils.testAccList[2].VinSolutions_Parent_Account__c = testUtils.testAccList[0].Id;
    //child for 2
    ////grandchild for 0
    testUtils.testAccList[3].Name = 'VinHierarchyAccount3';
    testUtils.testAccList[3].VinSolutions_Parent_Account__c = testUtils.testAccList[2].Id;

    testUtils.updateAccountList( fieldsToCheck );

    system.assert(testUtils.testAccList.size() == 4,'Test Data not created correctly');
  

    test.startTest();
    Account currentAccount = [ Select id, name from account where name = 'VinHierarchyAccount0' limit 1 ];
	PageReference accountCustomHierarchayVin = Page.AccountCustomHierarchayVin;
	Test.setCurrentPage( accountCustomHierarchayVin );
	ApexPages.currentPage().getParameters().put( 'id', currentAccount.id ); 

	//Instanciate Controller
	VinHierarchyStructure controller = new VinHierarchyStructure();

	// Call Methodes for top account
	controller.setcurrentId( null ); 
	VinHierarchyStructure.ObjectStructureMap[] smt1 = new VinHierarchyStructure.ObjectStructureMap[]{};
	smt1 = controller.getObjectStructure();
	System.Assert( smt1.size() > 0, 'Test failed at Top account, no Id' );

	controller.setcurrentId( String.valueOf( currentAccount.id ) );
	VinHierarchyStructure.ObjectStructureMap[] smt2 = new VinHierarchyStructure.ObjectStructureMap[]{};
	smt2 = controller.getObjectStructure();
	System.Assert( smt2.size() > 0, 'Test failed at Top account, with Id: '+smt2.size() );

	VinHierarchyStructure.HierarchyObject obj = new VinHierarchyStructure.HierarchyObject();
	obj.Id = currentAccount.Id;

	//Call ObjectStructureMap methodes
	smt2[0].setnodeId( '1234567890' );
	smt2[0].setlevelFlag( true );
	smt2[0].setlcloseFlag( false );
	smt2[0].setnodeType( 'parent' );
	smt2[0].setcurrentNode( false );
	smt2[0].setaccount( obj );

	String nodeId       = smt2[0].getnodeId();
	Boolean[] levelFlag = smt2[0].getlevelFlag();
	Boolean[] closeFlag = smt2[0].getcloseFlag();
	String nodeType     = smt2[0].getnodeType();
	Boolean currentName = smt2[0].getcurrentNode();
	VinHierarchyStructure.HierarchyObject smbAccount  = smt2[0].getaccount();

	// Call Methodes for middle account
	system.assert(testUtils.findAccountByName('VinHierarchyAccount1') != null,'Could not find the account in testdata');
	 
	controller.setcurrentId( String.valueOf( testUtils.findAccountByName('VinHierarchyAccount1').Id ) );
	VinHierarchyStructure.ObjectStructureMap[] smm = new VinHierarchyStructure.ObjectStructureMap[]{};
	smm = controller.getObjectStructure();
	System.Assert( smm.size() > 0, 'Test failed at middle account' );


	// Call Methodes for bottom account
	controller.setcurrentId( String.valueOf(  testUtils.findAccountByName('VinHierarchyAccount3').Id  ) );
	VinHierarchyStructure.ObjectStructureMap[] smb = new VinHierarchyStructure.ObjectStructureMap[]{};
	smb = controller.getObjectStructure();
	System.Assert( smb.size() > 0, 'Test failed at bottom account' );

	}
	
}