public with sharing class EditTeamMemberController {
	public Boolean hasErrors { get { return ApexPages.hasMessages(ApexPages.Severity.ERROR) || ApexPages.hasMessages(ApexPages.Severity.FATAL); } }
	public AccountTMHelper atmh { get; set; }
	private AccountTMHelper oldAtmh { get; set; }
	public Boolean renderPageMessage { get; set; }
	private Id acctId { get; set; }
	private Id userId { get; set; }
	private Set<Id> acctTMIds { get; set; }

	private ApexPages.StandardController stdController;
	
	public EditTeamMemberController(ApexPages.StandardController stdController) {
		this.stdController = stdController;
		renderPageMessage = false;
	}

	public void init() {
		Map<String, String> paramMap = ApexPages.currentPage().getParameters();

		try {
			acctId = stdController.getId();
		} catch(StringException ex) {}

		if(acctId == null || acctId.getSobjectType() != Account.sObjectType) {
			addError('The id parameter is required and must be a valid Account Id.');
			renderPageMessage = true;
			return;
		}

		if(!paramMap.containsKey('UserId')) {
			addError('The userId paramater is required and must be a valid Account Team Member Id.');
			renderPageMessage = true;
			return;
		} else {
			userId = paramMap.get('UserId');
		}

		AccountShare acctShare = [SELECT Id, AccountAccessLevel, CaseAccessLevel, OpportunityAccessLevel, ContactAccessLevel, UserOrGroupId, AccountId FROM AccountShare WHERE UserOrGroupId = :userId AND AccountId = :acctId];
		acctTMIds = new Set<Id>();

		for(AccountTeamMember atm : [SELECT Id, AccountId, UserId, TeamMemberRole FROM AccountTeamMember WHERE AccountId = :acctId]) {
			if(atm.UserId == userId) {
				atmh = new AccountTMHelper(acctId);
				atmh.tm.UserId = atm.UserId;
				atmh.tm.TeamMemberRole = atm.TeamMemberRole;
				atmh.cloneAccountShare(acctShare);
				oldAtmh = new AccountTMHelper(atm, acctShare);
			} else {
				acctTMIds.add(atm.UserId);
			}
		}		
	}

	public PageReference save() {

		Map<String, Object> params = new Map<String, Object>(); //Used to send values to Flow

		try {
			if(atmh.tm.UserId == null) {
				atmh.tm.UserId.addError('User is a required field.');
				return null;
			} else if (atmh.tm.TeamMemberRole == null) {
				atmh.tm.TeamMemberRole.addError('Team Role is a required field.');
				return null;
			} else {
				if(acctTMIds.contains(atmh.userId)) {
					atmh.tm.UserId.addError('This User is already a team member of this account.');
					return null;
				}
				
				if(atmh.userId != oldAtmh.userId) {
					delete oldAtmh.tm;
				}

				atmh.acctShare.UserOrGroupId = atmh.UserId;

				upsert atmh.tm;
				upsert atmh.acctShare;
			}

			system.debug('==================>>>>> atmh.tm.UserId = ' + atmh.tm.UserId);
			system.debug('==================>>>>> userId = ' + userId);
			system.debug('==================>>>>> atmh.tm.TeamMemberRole = ' + atmh.tm.TeamMemberRole);
			system.debug('==================>>>>> acctId = ' + acctId);
			if(atmh.tm.UserId != null && atmh.tm.TeamMemberRole != null && acctId != null){
				//Calling Flow
				//Add the variables to the Map
				params.put('varAccountID', acctId);
				params.put('varUserID', atmh.tm.UserId);
				params.put('varRoleName', atmh.tm.TeamMemberRole);
				system.debug('==================>>>>> varAccountID = ' + params.get('varAccountID'));
				system.debug('==================>>>>> varUserID = ' + params.get('varUserID'));
				system.debug('==================>>>>> varRoleName = ' + params.get('varRoleName'));
				//Call the Flow and pass the variables
				Flow.Interview.Set_Account_Fields_from_Account_Teams setAcctFieldsFromAcctTeams = new Flow.Interview.Set_Account_Fields_from_Account_Teams(params);
				//system.debug('==================>>>>> Flow UserId = ' + setAcctFieldsFromAcctTeams.getVariableValue('varUserID'));
				//system.debug('==================>>>>> Flow acctId = ' + setAcctFieldsFromAcctTeams.getVariableValue('varAccountID'));
				//system.debug('==================>>>>> Flow RoleName = ' + setAcctFieldsFromAcctTeams.getVariableValue('varRoleName'));
				setAcctFieldsFromAcctTeams.start();
				String flowUserID = (String) setAcctFieldsFromAcctTeams.getVariableValue('varUserID');
				system.debug('==================>>>>> Flow UserId = ' + flowUserID);
				system.debug('==================>>>>> Flow acctId = ' + setAcctFieldsFromAcctTeams.getVariableValue('varAccountID'));
				system.debug('==================>>>>> Flow RoleName = ' + setAcctFieldsFromAcctTeams.getVariableValue('varRoleName'));
			}
			
		} catch(Exception ex) {}

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

		return cancel();
	}

	public PageReference cancel() {
		return new PageReference('/' + acctId);
	}

	@TestVisible private void addError(String msg) {
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
	}
}