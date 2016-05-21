public with sharing class AccountTMHelper {
	public AccountTeamMember tm { get; set; }
	public AccountShare acctShare { get; set; } 
	public String source { get; set; }
	public Id userId { get { return tm.UserId != null ? tm.UserId : acctShare.UserOrGroupId; } set; }
	public Id acctId { get { return tm.AccountId != null ? tm.AccountId : acctShare.AccountId; } set; }

	private Map<String, String> shareMap = new Map<String, String> {
		'Private' => 'None',
		'Read Only' => 'Read',
		'Read/Write' => 'Edit'
	};
	private Map<String, Integer> roleMap = new Map<String, Integer> {
		null => -1,
		'None' => 0,
		'Read' => 1,
		'Edit' => 2
	};

	public AccountTMHelper() {
		this.tm = new AccountTeamMember();
		this.acctShare = new AccountShare();
		this.source = '';
	}

	public AccountTMHelper(Id acctId) {
		this();

		this.tm.AccountId = acctId;
		this.acctShare.AccountId = acctId;
	}

	public AccountTMHelper(AccountTeamMember tm, AccountShare acctShare) {
		this();

		this.tm = tm;
		this.acctShare = acctShare;
	}

	public AccountTMHelper(AccountTeamMember tm) {
		this();

		this.tm = tm;
	}

	public AccountTMHelper(AccountShare acctShare) {
		this();

		this.acctShare = acctShare;
	}

	public AccountTMHelper(Id userId, Role_Definition__c role) {
		tm = new AccountTeamMember(
			UserId = userId,
			TeamMemberRole = role.Name
		);

		acctShare = new AccountShare(
			UserOrGroupId = userId,
			AccountAccessLevel = shareMap.containsKey(role.Account_Access__c) ? shareMap.get(role.Account_Access__c) : 'None',
			OpportunityAccessLevel = shareMap.containsKey(role.Opportunity_Access__c) ? shareMap.get(role.Opportunity_Access__c) : 'None',
			CaseAccessLevel = shareMap.containsKey(role.Case_Access__c) ? shareMap.get(role.Case_Access__c) : 'None',
			ContactAccessLevel = shareMap.containsKey(role.Contact_Access__c) ? shareMap.get(role.Contact_Access__c) : 'None'
		);
	}

	public void setAccountShare(AccountShare acctShare) {
		this.acctShare = acctShare;
	}

	public void cloneAccountShare(AccountShare acctShare) {
		this.acctShare.AccountId = acctId;
		this.acctShare.UserOrGroupId = acctShare.UserOrGroupId;
		this.acctShare.AccountAccessLevel = acctShare.AccountAccessLevel;
		this.acctShare.OpportunityAccessLevel = acctShare.OpportunityAccessLevel;
		this.acctShare.CaseAccessLevel = acctShare.CaseAccessLevel;
		this.acctShare.ContactAccessLevel = acctShare.ContactAccessLevel;
	}

	public void setUserId(Id userId) {
		this.tm.UserId = userId;
		this.acctShare.UserOrGroupId = userId;
	}

	public AccountTMHelper cloneTM(Id acctId) {
		AccountTMHelper atm = new AccountTMHelper();
		this.acctId = acctId;
		this.userId = userId;

		atm.tm = new AccountTeamMember(
			AccountId = acctId,
			UserId = tm.UserId,
			TeamMemberRole = tm.TeamMemberRole
		);

		atm.acctShare = new AccountShare(
			AccountId = acctId,
			UserOrGroupId = acctShare.UserOrGroupId,
			AccountAccessLevel = acctShare.AccountAccessLevel,
			OpportunityAccessLevel = acctShare.OpportunityAccessLevel,
			CaseAccessLevel = acctShare.CaseAccessLevel,
			ContactAccessLevel = acctShare.ContactAccessLevel
		);

		return atm;
	}

	public AccountTMHelper mergeTM(AccountTMHelper atm) {
		acctShare.AccountAccessLevel = roleMap.get(atm.acctShare.AccountAccessLevel) > roleMap.get(acctShare.AccountAccessLevel) ? atm.acctShare.AccountAccessLevel : acctShare.AccountAccessLevel;
		acctShare.OpportunityAccessLevel = roleMap.get(atm.acctShare.OpportunityAccessLevel) > roleMap.get(acctShare.OpportunityAccessLevel) ? atm.acctShare.OpportunityAccessLevel : acctShare.OpportunityAccessLevel;
		acctShare.CaseAccessLevel = roleMap.get(atm.acctShare.CaseAccessLevel) > roleMap.get(acctShare.CaseAccessLevel) ? atm.acctShare.CaseAccessLevel : acctShare.CaseAccessLevel;
		acctShare.ContactAccessLevel = roleMap.get(atm.acctShare.ContactAccessLevel) > roleMap.get(acctShare.ContactAccessLevel) ? atm.acctShare.ContactAccessLevel : acctShare.ContactAccessLevel;

		return this;
	}
}