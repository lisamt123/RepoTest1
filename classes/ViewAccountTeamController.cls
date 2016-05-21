public class ViewAccountTeamController {
	public Boolean hasErrors { get { return ApexPages.hasMessages(ApexPages.Severity.ERROR) || ApexPages.hasMessages(ApexPages.Severity.FATAL); } }
	public List<AccountTeamMember> tms { get; private set; }
	public Map<Id, AccountTeamMember> tmMap { get; private set; }
	public Map<Id, AccountTMHelper> tmHelperMap { get; private set; }
	public String memberId { get; set; }
	public boolean renderTable { get; private set; }
	public boolean renderAdd { get; private set; }
	public boolean renderEdit { get; private set; }
	public boolean renderDel { get; private set; }
	public Id acctId;
	public Map<Id, Id> distUserMap { get; private set; }
	public Map<Id, Id> regUserMap { get; private set; }
	
	private ApexPages.StandardController stdController;
	
	public ViewAccountTeamController(ApexPages.StandardController stdController) {
		this.stdController = stdController;
		tmMap = new Map<Id, AccountTeamMember>();
	}
	
	public void init() {
		Id userId = UserInfo.getUserId();
		Advanced_Team_Management__c atmSettings = Advanced_Team_Management__c.getInstance(userId);
		renderAdd = atmSettings.Add_Member__c;
		renderEdit = atmSettings.Edit_Member__c;
		renderDel = atmSettings.Delete_Member__c;

		try {
			acctId = stdController.getId();
		} catch(StringException ex) {}

		if(acctId == null || acctId.getSobjectType() != Account.sObjectType) {
			addError('The id parameter is required and must be a valid Account Id.');
			return;
		}

		tmHelperMap = new Map<Id, AccountTMHelper>();

		for(AccountTeamMember atm : [SELECT Id, User.Name, AccountId, TeamMemberRole, UserId, AccountAccessLevel, User.IsActive FROM AccountTeamMember WHERE AccountId = :acctId ORDER BY User.Name]) {
			tmHelperMap.put(atm.UserId, new AccountTMHelper(atm));
		}

		renderTable = !tmHelperMap.isEmpty();

		Account acct = [SELECT Id, HAY_District__c, HAY_Region__c, VIN_District__c, VIN_Region__c, VAT_District__c, VAT_Region__c FROM Account WHERE Id =:acctId];
		distUserMap = new Map<Id, Id>();
		regUserMap = new Map<Id, Id>();

		for(District__c dist : [SELECT Id, User_1__c, User_2__c, User_3__c, User_4__c, User_5__c, User_6__c, User_7__c, User_8__c, User_9__c, User_10__c FROM District__c WHERE Id IN :new Set<Id> { acct.VAT_District__c, acct.VIN_District__c, acct.HAY_District__c}]) {
			distUserMap.put(dist.User_1__c, dist.Id);
			distUserMap.put(dist.User_2__c, dist.Id);
			distUserMap.put(dist.User_3__c, dist.Id);
			distUserMap.put(dist.User_4__c, dist.Id);
			distUserMap.put(dist.User_5__c, dist.Id);
			distUserMap.put(dist.User_6__c, dist.Id);
			distUserMap.put(dist.User_7__c, dist.Id);
			distUserMap.put(dist.User_8__c, dist.Id);
			distUserMap.put(dist.User_9__c, dist.Id);
			distUserMap.put(dist.User_10__c, dist.Id);
		}

		for(Region__c reg : [SELECT Id, User_1__c, User_2__c, User_3__c, User_4__c, User_5__c FROM Region__c WHERE Id IN :new Set<Id> { acct.VAT_Region__c, acct.VIN_Region__c, acct.HAY_Region__c}]) {
			regUserMap.put(reg.User_1__c, reg.Id);
			regUserMap.put(reg.User_2__c, reg.Id);
			regUserMap.put(reg.User_3__c, reg.Id);
			regUserMap.put(reg.User_4__c, reg.Id);
			regUserMap.put(reg.User_5__c, reg.Id);
		}

		for(AccountTMHelper atmh : tmHelperMap.values()) {
			if(regUserMap.containsKey(atmh.userId)) {
				atmh.source = 'Region';

				if(distUserMap.containsKey(atmh.userId)) {
					atmh.source += '/District';
				}
			} else if(distUserMap.containsKey(atmh.userId)) {
				atmh.source = 'District';
			} else {
				atmh.source = 'Manual';
			}
		}
	}
	
	public void deleteMember() {
		AccountTeamMember tm;
		Map<String, Object> params = new Map<String, Object>(); //Used to send values to Flow

		try {
			System.debug(System.logginglevel.info, memberId);
			tm = tmHelperMap.get((Id) memberId).tm;
			delete tm;
		} catch(Exception ex) {}
		if(tm != null && (tm.TeamMemberRole.equalsIgnoreCase('Vin Performance Manager') || tm.TeamMemberRole.equalsIgnoreCase('Website Account Manager'))) {
			List<SFDC_520_Quote__c> projs = [SELECT Id, Vin_Performance_Manager__c, WAM_Digital_Marketing_Advisor__c FROM SFDC_520_Quote__c WHERE Status__c = 'Open' AND Account__c = :acctId];
			
			if(!projs.isEmpty()) {
				for(SFDC_520_Quote__c proj : projs) {
					if(tm.TeamMemberRole.equalsIgnoreCase('Vin Performance Manager') && proj.Vin_Performance_Manager__c == tm.UserId) {
						proj.Vin_Performance_Manager__c = null;
						proj.Account_Team_Updating__c = true;
					} else if(tm.TeamMemberRole.equalsIgnoreCase('Website Account Manager') && proj.WAM_Digital_Marketing_Advisor__c == tm.UserId) {
						proj.WAM_Digital_Marketing_Advisor__c = null;
						proj.Account_Team_Updating__c = true;
					}
				}

				update projs;
			}
		}

		//Calling Flow
		//Add the variables to the Map and set the varUserID to null to delete in the Flow
		params.put('varAccountID', acctId);
		params.put('varUserID', null);
		params.put('varRoleName', tm.TeamMemberRole);
		system.debug('==================>>>>> varAccountID = ' + params.get('varAccountID'));
		system.debug('==================>>>>> varUserID = ' + params.get('varUserID'));
		system.debug('==================>>>>> varRoleName = ' + params.get('varRoleName'));
		//Call the Flow and pass the variables
		Flow.Interview.Set_Account_Fields_from_Account_Teams setAcctFieldsFromAcctTeams = new Flow.Interview.Set_Account_Fields_from_Account_Teams(params);
		setAcctFieldsFromAcctTeams.start();

	}

	private void addError(String msg) {
		ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, msg));
	}
}