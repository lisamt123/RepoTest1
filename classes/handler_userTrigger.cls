public with sharing class handler_userTrigger {
	
	public static void lockDownUserFields(List<User> oldList, List<User> newList) {
		
		for(User oldUser : oldList) {
			for(User newUser : newList) {
				if(oldUser.Id == newUser.Id) {
					
					//check if not admin profiles
					//VinSystem Admin: 00e70000000wzXQAAY
					//VinSystem Dev Admin: 00e70000001FaWMAA0
					//David Tinsley: 00570000001Jg6xAAC
					//Angel Bourret: 00570000001eNX0AAM
					
					system.debug('Bazinga... profileId: ' + UserInfo.getProfileId());
					system.debug('Bazinga... userId: ' + UserInfo.getUserId());
					
					if((UserInfo.getProfileId() != '00e70000000wzXQAAY' && UserInfo.getProfileId() != '00e70000001FaWMAA0' && UserInfo.getUserId() != '00570000001eNX0AAM') || UserInfo.getUserId() == '00570000001Jg6xAAC') {
							
						//Role
						if(oldUser.UserRoleId != newUser.UserRoleId) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Role. ***');
						}
						
						//Profile
						if(oldUser.ProfileId != newUser.ProfileId) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Profile. ***');
						}
						
						//Title
						if(oldUser.Title != newUser.Title) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Title. ***');
						}
						
						//Department
						if(oldUser.Department != newUser.Department) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Department. ***');
						}
						
						//Employee Number
						if(oldUser.Employee_Number__c != newUser.Employee_Number__c) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Employee Number. ***');
						}
						
						//Employee Number
						if(oldUser.EmployeeNumber != newUser.EmployeeNumber) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Employee Number. ***');
						}
						
						//PTO Approver
						if(oldUser.PTO_Approver__c != newUser.PTO_Approver__c) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your PTO Approver. ***');
						}
						
						//Alternate PTO Approver
						if(oldUser.Alternate_PTO_Approver__c != newUser.Alternate_PTO_Approver__c) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Alternate PTO Approver. ***');
						}
						
						//HR Department
						if(oldUser.HR_Department__c != newUser.HR_Department__c) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your HR Department. ***');
						}
						
						//HR Job Title
						if(oldUser.HR_Job_Title__c != newUser.HR_Job_Title__c) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your HR Job Title. ***');
						}
						
						//Delegated Approver
						if(oldUser.Delegated_Approver_2__c != newUser.Delegated_Approver_2__c) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Delegated Approver. ***');
						}
						
						//Delegated Approver
						if(oldUser.DelegatedApproverId != newUser.DelegatedApproverId) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Delegated Approver. ***');
						}
						
						//Manager
						if(oldUser.ManagerId != newUser.ManagerId) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Manager. ***');
						}
						
						//First Name
						if(oldUser.FirstName != newUser.FirstName) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your First Name. ***');
						}
						
						//Last Name
						if(oldUser.LastName != newUser.LastName) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Last Name. ***');
						}
						
						//Start Date
						if(oldUser.Start_Date__c != newUser.Start_Date__c) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Start Date. ***');
						}
						
						//Team Lead
						if(oldUser.Team_Lead__c != newUser.Team_Lead__c) {
							
							newUser.addError('*** Error: Insufficient Privileges, you cannot change your Team Lead. ***');
						}
						
						//Receive Approval Request Emails
						//if(oldUser.)
					}
				}
			}
		}
	}
}