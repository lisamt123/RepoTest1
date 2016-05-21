@isTest
private class Multiple_Attachments_Test {
	
	private static testMethod void testController()
	{
		Account TestAcct = TestData.setupAccount();
        Database.SaveResult SR1 = Database.insert(TestAcct);
		Id sobjId = SR1.getid();

		Test.startTest();

		ApexPages.currentPage().getParameters().put('sobjId', sobjId);
		Multiple_Attachments controller = new Multiple_Attachments();
		
		System.assertEquals(0, controller.getAttachments().size());
		System.assertEquals(1, controller.newAttachments.size());
		
		controller.addMore();
		
		System.assertEquals(1 + Multiple_Attachments.NUM_ATTACHMENTS_TO_ADD, controller.newAttachments.size());
		
		// populate the first and third new attachments
		List<Attachment> newAtts=controller.newAttachments;
		newAtts[0].Name = 'Unit Test 1';
		newAtts[0].Description = 'Unit Test 1';
		newAtts[0].Body = Blob.valueOf('Unit Test 1');

		newAtts[2].Name = 'Unit Test 2';
		newAtts[2].Description = 'Unit Test 2';
		newAtts[2].Body = Blob.valueOf('Unit Test 2');
		
		controller.save();
		
		System.assertEquals(2, controller.getAttachments().size());
		System.assertNotEquals(null, controller.done());

		Test.stopTest();

	}
	
}