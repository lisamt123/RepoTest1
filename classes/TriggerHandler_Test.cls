@isTest
private class TriggerHandler_Test {
	
	@isTest static void test_method_one() {
		// Implement test code
		OpportunityTriggerHandler oppHandler = new OpportunityTriggerHandler();
		oppHandler.setMaxLoopCount(10);
		oppHandler.clearMaxLoopCount();
		//oppHandler.Run();
		TriggerHandler.bypass('OpportunityTriggerHandler');
		TriggerHandler.clearBypass('OpportunityTriggerHandler');
		TriggerHandler.isBypassed('OpportunityTriggerHandler');
		TriggerHandler.clearAllBypasses();
	}
	
	@isTest static void test_method_two() {
		// Implement test code
		// 
	}
	
}