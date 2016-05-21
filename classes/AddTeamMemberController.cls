public with sharing class AddTeamMemberController {
	public Boolean hasErrors { get { return ApexPages.hasMessages(ApexPages.Severity.ERROR) || ApexPages.hasMessages(ApexPages.Severity.FATAL); } }
	public AccountTMHelper atmh { get; set; }
	public Boolean renderPageMessage { get; set; }
	private Id acctId { get; set; }

	private ApexPages.StandardController stdController;
	
	public AddTeamMemberController(ApexPages.StandardController stdController) {
		this.stdController = stdController;
		renderPageMessage = false;
	}

	public void init() {
		try {
			acctId = stdController.getId();
		} catch(StringException ex) {}

		if(acctId == null || acctId.getSobjectType() != Account.sObjectType) {
			addError('The id parameter is required and must be a valid Account Id.');
			renderPageMessage = true;
			return;
		}

		atmh = new AccountTMHelper(acctId);
	}

	public PageReference save() {


		if(atmh.tm.UserId == null) {
			atmh.tm.UserId.addError('User is a required field.');
			return null;
		} else if (atmh.tm.TeamMemberRole == null) {
			atmh.tm.TeamMemberRole.addError('Team Role is a required field.');
			return null;
		} else {
			atmh.acctShare.UserOrGroupId = atmh.tm.UserId;
			insert atmh.tm;
			insert atmh.acctShare;
		}

		if(atmh.tm.TeamMemberRole.equalsIgnoreCase('Vin Performance Manager') || atmh.tm.TeamMemberRole.equalsIgnoreCase('Website Account Manager')) {
			List<SFDC_520_Quote__c> projs = [SELECT Id, Vin_Performance_Manager__c, WAM_Digital_Marketing_Advisor__c FROM SFDC_520_Quote__c WHERE Status__c = 'Open' AND Account__c = :acctId];

			if(!projs.isEmpty()) {
				for(SFDC_520_Quote__c proj : projs) {
					proj.Vin_Performance_Manager__c = null;
					proj.WAM_Digital_Marketing_Advisor__c = null;
				}

				update projs;
			}
		}

		runFlow(atmh.tm.UserId, atmh.tm.TeamMemberRole, acctId);
		//return null;
		return new PageReference('/' + acctId);
	}

	public PageReference cancel() {
		return new PageReference('/' + acctId);
	}

	@TestVisible private void addError(String msg) {
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
	}

	public void runFlow(Id user, String role, Id acct){

		Map<String, Object> params = new Map<String, Object>(); //Used to send values to Flow

		system.debug('==================>>>>> user = ' + user);
		system.debug('==================>>>>> role = ' + role);
		system.debug('==================>>>>> acct = ' + acct);
		if(user != null && role != null && acct != null){
			//Calling Flow
			//Add the variables to the Map
			params.put('varAccountID', acct);
			params.put('varUserID', user);
			params.put('varRoleName', role);
			//params.put('varSpecialTeamID', null);
			system.debug('==================>>>>> varAccountID = ' + params.get('varAccountID'));
			system.debug('==================>>>>> varUserID = ' + params.get('varUserID'));
			system.debug('==================>>>>> varRoleName = ' + params.get('varRoleName'));
			//Call the Flow and pass the variables
			Flow.Interview.Set_Account_Fields_from_Account_Teams setAcctFieldsFromAcctTeams = new Flow.Interview.Set_Account_Fields_from_Account_Teams(params);
			//system.debug('==================>>>>> Flow UserId = ' + setAcctFieldsFromAcctTeams.getVariableValue('varUserID'));
			//system.debug('==================>>>>> Flow acctId = ' + setAcctFieldsFromAcctTeams.getVariableValue('varAccountID'));
			//system.debug('==================>>>>> Flow RoleName = ' + setAcctFieldsFromAcctTeams.getVariableValue('varRoleName'));
			try{
				setAcctFieldsFromAcctTeams.start();
			}
			catch(DmlException e) {
    			System.debug('The following DmlException has occurred: ' + e.getMessage());
			}
			catch (exception e) {
				System.debug('setAcctFieldsFromAcctTeams.start() encountered an exception: '+e.getMessage());
			}
			String flowUserID = (String) setAcctFieldsFromAcctTeams.getVariableValue('varUserID');
			system.debug('==================>>>>> Flow UserId = ' + flowUserID);
			system.debug('==================>>>>> Flow acctId = ' + setAcctFieldsFromAcctTeams.getVariableValue('varAccountID'));
			system.debug('==================>>>>> Flow RoleName = ' + setAcctFieldsFromAcctTeams.getVariableValue('varRoleName'));
		}
	}

}