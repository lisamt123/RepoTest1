@isTest
private class vAutoHierarchyStructure_Test {
	public static vAutoHierarchy_TestUtilities testUtils = new vAutoHierarchy_TestUtilities();
	@isTest static void test_vAutoCustomHierarchy() {
	
    Set<String> fieldsToCheck = new Set<String>{'AnnualRevenue', 'BillingCity','BillingCountry','BillingPostalCode','BillingState', 'BillingStreet', 'Description', 'ShippingCity', 'ShippingStreet', 'Name', 'ShippingState', 'ShippingPostalCode', 'ShippingCountry' };

    /*Test data Setup*/
    //Create set of Accounts
    testUtils.createAccounts( 4 , fieldsToCheck );
    testUtils.testAccList[0].Name = 'vAutoHierarchyAccount0';
    //first child for 0
    testUtils.testAccList[1].Name = 'vAutoHierarchyAccount1';
    testUtils.testAccList[1].vAuto_Parent_Account__c = testUtils.testAccList[0].Id;
    //second child for 0
    testUtils.testAccList[2].Name = 'vAutoHierarchyAccount2';
    testUtils.testAccList[2].vAuto_Parent_Account__c = testUtils.testAccList[0].Id;
    //child for 2
    ////grandchild for 0
    testUtils.testAccList[3].Name = 'vAutoHierarchyAccount3';
    testUtils.testAccList[3].vAuto_Parent_Account__c = testUtils.testAccList[2].Id;

    testUtils.updateAccountList( fieldsToCheck );

    system.assert(testUtils.testAccList.size() == 4,'Test Data not created correctly');
  

    test.startTest();
    Account currentAccount = [ Select id, name from account where name = 'vAutoHierarchyAccount0' limit 1 ];
	PageReference accountCustomHierarchyPage = Page.AccountCustomHierarchyPage;
	Test.setCurrentPage( accountCustomHierarchyPage );
	ApexPages.currentPage().getParameters().put( 'id', currentAccount.id ); 

	//Instanciate Controller
	vAutoHierarchyStructure controller = new vAutoHierarchyStructure();

	// Call Methodes for top account
	controller.setcurrentId( null ); 
	vAutoHierarchyStructure.ObjectStructureMap[] smt1 = new vAutoHierarchyStructure.ObjectStructureMap[]{};
	smt1 = controller.getObjectStructure();
	System.Assert( smt1.size() > 0, 'Test failed at Top account, no Id' );

	controller.setcurrentId( String.valueOf( currentAccount.id ) );
	vAutoHierarchyStructure.ObjectStructureMap[] smt2 = new vAutoHierarchyStructure.ObjectStructureMap[]{};
	smt2 = controller.getObjectStructure();
	System.Assert( smt2.size() > 0, 'Test failed at Top account, with Id: '+smt2.size() );

	vAutoHierarchyStructure.HierarchyObject obj = new vAutoHierarchyStructure.HierarchyObject();
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
	vAutoHierarchyStructure.HierarchyObject smbAccount  = smt2[0].getaccount();

	// Call Methodes for middle account
	system.assert(testUtils.findAccountByName('vAutoHierarchyAccount1') != null,'Could not find the account in testdata');
	 
	controller.setcurrentId( String.valueOf( testUtils.findAccountByName('vAutoHierarchyAccount1').Id ) );
	vAutoHierarchyStructure.ObjectStructureMap[] smm = new vAutoHierarchyStructure.ObjectStructureMap[]{};
	smm = controller.getObjectStructure();
	System.Assert( smm.size() > 0, 'Test failed at middle account' );


	// Call Methodes for bottom account
	controller.setcurrentId( String.valueOf(  testUtils.findAccountByName('vAutoHierarchyAccount3').Id  ) );
	vAutoHierarchyStructure.ObjectStructureMap[] smb = new vAutoHierarchyStructure.ObjectStructureMap[]{};
	smb = controller.getObjectStructure();
	System.Assert( smb.size() > 0, 'Test failed at bottom account' );

	}
	
	
}