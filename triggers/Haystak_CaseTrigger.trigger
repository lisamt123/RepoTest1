/**
 * @author			Pranav Raulkar
 * @date            28/05/2015
 * @version			1.0
 * @description     Trigger for Case.
 */
trigger Haystak_CaseTrigger on Case (after delete, after insert, after undelete, after update) {
	if(Trigger.isAfter) {
		Haystak_CaseTriggerHandler.updateCaseCountOnPOA();
	}
}