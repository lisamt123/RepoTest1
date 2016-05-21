public without sharing class case_ctrl_listView {
	
	//--------------------------------------------------------------------------
	/*
	Standard Controller variables to embed visualforce page into
	record page layout
	*/
	
	private ApexPages.StandardController controller {get;set;}
	
	private Case c;
	
	
	//--------------------------------------------------------------------------
	
	// ----
	//..Custom wrapper classes...
	// ----
	/*
	public class influencerWrapper {
		
		public string userId {get;set;}
		public string userName {get;set;}
		
		public integer ranking {get;set;}
		
		public influencerWrapper() {
			
			
		}
	}
	*/
	
	
	public class listWrapper { 
		
		public string recordId {get;set;}
		public string recordName {get;set;}
		public DateTime recordLM {get;set;}
		public string recordLMDisplay {get;set;}
		
		public string userName {get;set;}
		public string userId {get;set;}
		
		//
		public string hoverFormattedText {get;set;}
		public string hoverLinkText {get;set;}
		
		//
		public string altURL {get;set;}
		
		public boolean bold1 {get;set;}
		public boolean bold2 {get;set;}
		public boolean bold3 {get;set;}
		public boolean bold4 {get;set;}
		public boolean bold5 {get;set;}
		public boolean bold6 {get;set;}
		public boolean bold7 {get;set;}
		public boolean bold8 {get;set;}
		public boolean bold9 {get;set;}
		
		public boolean disableRecordLink {get;set;}
		
		//set boolean to display/hide preview line on Activity History
		public boolean showPreview {get;set;}
		
		//controls if hover iframe is shown or not
		public boolean showHover {get;set;}
		
		//
		public boolean showAltURL {get;set;}
		
		
		public string feedOutput1 {get;set;}
		public string feedOutput2 {get;set;}
		public string feedOutput3 {get;set;}
		public string feedOutput4 {get;set;}
		public string feedOutput5 {get;set;}
		public string feedOutput6 {get;set;}
		public string feedOutput7 {get;set;}
		public string feedOutput8 {get;set;}
		public string feedOutput9 {get;set;}
		
		public string feedActivityHistoryPreview {get;set;}
		
		public string debugString {get;set;}
		
		//boolean to remove a item from the list
		public boolean removeItem {get;set;}
		
		/*
		public listWrapper(string Id, DateTime Lm, String objectName) {
			
			recordId = Id;
			recordLM = Lm;
			recordName = objectName;
		}
		*/
		
		public listWrapper(EmailMessage em, String tUserName) {
			
			userId = em.LastModifiedById;
			userName = tUserName;
			
			recordId = em.Id;
			altURL = '';
			recordLM = em.LastModifiedDate;
			//recordLMDisplay = string.ValueOf(em.LastModifiedDate);
			recordLMDisplay = em.LastModifiedDate.formatLong();
			recordName = 'Email Message';
			
			hoverFormattedText = '';
			hoverLinkText = '';
			
			bold1 = false;
			bold2 = false;
			bold3 = false;
			bold4 = false;
			bold5 = false;
			bold6 = false;
			bold7 = false;
			bold8 = false;
			bold9 = false;
			
			disableRecordLink = false;
			
			showPreview = false;
			
			showHover = false;
			
			removeItem = false;
			
			showAltURL = false;
			
			feedOutput1 = '';
			feedOutput2 = '';
			feedOutput3 = '';
			feedOutput4 = '';
			feedOutput5 = '';
			feedOutput6 = '';
			feedOutput7 = '';
			feedOutput8 = '';
			feedOutput9 = '';
			
			feedActivityHistoryPreview = '';
			
			if(em.Status == '3') {
				
				feedOutput2 = 'sent';
				feedOutput3 = ' an email to ';
				feedOutput4 = em.ToAddress;
				feedOutput5 = ' - Subject: ';
				feedOutput6 = em.Subject;
				
				if(em.TextBody.length() > 76) {
					
					feedActivityHistoryPreview = em.TextBody.substring(0, 77) + '...';
				}
				else {
					
					feedActivityHistoryPreview = em.TextBody;
				}
				
				showPreview = true;
			}
			
			bold4 = true;
			bold6 = true; 
		}
		
		public listWrapper(ActivityHistory ah, String tUserName, String tOwnerName) {
			
			userId = ah.LastModifiedById;
			userName = tUserName;
			
			recordId = ah.Id;
			altURL = '';
			recordLM = ah.LastModifiedDate;
			//recordLMDisplay = string.ValueOf(ah.LastModifiedDate);
			recordLMDisplay = ah.LastModifiedDate.formatLong();
			recordName = 'Activity History';
			
			hoverFormattedText = '';
			hoverLinkText = '';
			
			bold1 = false;
			bold2 = false;
			bold3 = false;
			bold4 = false;
			bold5 = false;
			bold6 = false;
			bold7 = false;
			bold8 = false;
			bold9 = false;
			
			disableRecordLink = false;
			
			showPreview = false;
			
			showHover = false;
			
			removeItem = false;
			
			showAltURL = false;
			
			feedOutput1 = '';
			feedOutput2 = '';
			feedOutput3 = '';
			feedOutput4 = '';
			feedOutput5 = '';
			feedOutput6 = '';
			feedOutput7 = '';
			feedOutput8 = '';
			feedOutput9 = '';
			
			feedActivityHistoryPreview = '';
			
			//need to display the preview line below and lined up with the
			// .. rest of the text
			
			//feedOutput1 = ah.LastModifiedById + '  Activity History ... ';
			//feedOutput2 = ah.Subject + ' .. ' + ah.OwnerId; //Assigned To
			
			feedOutput2 = 'created a task - ';
			feedOutput3 = ah.Subject;
			feedOutput4 = ' - assigned to ';
			feedOutput5 = tOwnerName;
			
			if(ah.Preview__c != null) {
				
				showPreview = true;
				
				feedActivityHistoryPreview = ah.Preview__c; 
			}
			
			bold3 = true;
			bold5 = true;   
		}
		
		public listWrapper(Case_Runner__c cr, String tUserName, String ownerName) {
			
			userId = cr.CreatedById;
			userName = tUserName;
			
			recordId = cr.Id;
			altURL = '';
			recordLM = cr.LastModifiedDate;
			//recordLMDisplay = string.ValueOf(cr.LastModifiedDate);
			recordLMDisplay = cr.LastModifiedDate.formatLong();
			recordName = 'Case Runner';
			
			hoverFormattedText = '';
			hoverLinkText = '';
			
			bold1 = false;
			bold2 = false;
			bold3 = false;
			bold4 = false;
			bold5 = false;
			bold6 = false;
			bold7 = false;
			bold8 = false;
			bold9 = false;
			
			disableRecordLink = false;
			
			showPreview = false;
			
			showHover = false;
			
			removeItem = false;
			
			showAltURL = false;
			
			feedOutput1 = '';
			feedOutput2 = '';
			feedOutput3 = '';
			feedOutput4 = '';
			feedOutput5 = '';
			feedOutput6 = '';
			feedOutput7 = '';
			feedOutput8 = '';
			feedOutput9 = '';
			
			feedActivityHistoryPreview = '';
			
			string ra;
			
			//Runner Action
			//determine a or an (a,e,i,o,u)
			if(cr.Runner_Action__c != null) {
				
				ra = cr.Runner_Action__c.toLowerCase();
				
				if(ra.substring(0,1) == 'a' ||
				   ra.substring(0,1) == 'e' ||
				   ra.substring(0,1) == 'o' ||
				   ra.substring(0,1) == 'e' ||
				   ra.substring(0,1) == 'e') {
				   	
					ra = 'an';   	
				}
				else {
					
					ra = 'a';
				}
			}
			
			
			feedOutput2 = 'created ';
			feedOutput3 = ra;
			feedOutput4 = ' ' + cr.Runner_Action__c;
			feedOutput5 = ' Case Runner';
			
			if(cr.Escalated_To__c != null) {
				
				feedOutput6 = ' for ';
				feedOutput7 = cr.Escalated_To__c;
				
				if(ownerName != null) {
					
					feedOutput8 = ' assigned to ';
					feedOutput9 = ownerName;
				}
			}
			
			showHover = true;
			
			showPreview = true;
			
			feedActivityHistoryPreview = cr.Name;
			
			
			
			hoverFormattedText = cr.Runner_Request__c;
			hoverLinkText = 'Runner Request';
			
			bold4 = true;
			bold7 = true;
			bold9 = true;
		}
		
		public listWrapper(CaseComment cc, String tUserName) {
			
			userId = cc.LastModifiedById;
			userName = tUserName;
			
			recordId = cc.Id;
			altURL = '';
			recordLM = cc.LastModifiedDate;
			//recordLMDisplay = string.ValueOf(cc.LastModifiedDate);
			recordLMDisplay = cc.LastModifiedDate.formatLong();
			recordName = 'Case Comment';
			
			hoverFormattedText = '';
			hoverLinkText = '';
			
			bold1 = false;
			bold2 = false;
			bold3 = false;
			bold4 = false;
			bold5 = false;
			bold6 = false;
			bold7 = false;
			bold8 = false;
			bold9 = false;
			
			disableRecordLink = false;
			
			showPreview = false;
			
			showHover = false;
			
			removeItem = false;
			
			showAltURL = false;
			
			feedOutput1 = '';
			feedOutput2 = '';
			feedOutput3 = '';
			feedOutput4 = '';
			feedOutput5 = '';
			feedOutput6 = '';
			feedOutput7 = '';
			feedOutput8 = '';
			feedOutput9 = '';
			
			feedActivityHistoryPreview = '';
			
			feedOutput1 = cc.LastModifiedById;
			
			if(cc.IsPublished) {
				
				feedOutput2 = 'made a public comment - ';
			}
			else {
				
				feedOutput2 = 'made a private comment - ';
			}
			
			if(cc.CommentBody.length() > 76) {
				
				feedOutput3 = cc.CommentBody.substring(0, 77) + '...';
			}
			else {
				
				feedOutput3 = cc.CommentBody;
			}
			
			altURL = '/' + cc.Id + '/e?parent_id=' + cc.ParentId + '&retURL=%2F' + cc.ParentId;
			
			showAltURL = true;
			
			showHover = true;
			
			hoverFormattedText = cc.CommentBody;
			hoverLinkText = 'Comment Body';
			
			bold3 = true;
			
			//disableRecordLink = true;
		}
		
		public listWrapper(CaseHistory ch, String tUserName) {
			
			userId = ch.CreatedById;
			userName = tUserName;
			
			recordId = ch.Id;
			altURL = '';
			recordLM = ch.CreatedDate;
			//recordLMDisplay = string.ValueOf(ch.CreatedDate);
			recordLMDisplay = ch.CreatedDate.formatLong();
			recordName = 'Case History';
			
			hoverFormattedText = '';
			hoverLinkText = '';
			
			feedOutput1 = '';
			feedOutput2 = '';
			feedOutput3 = '';
			feedOutput4 = '';
			feedOutput5 = '';
			feedOutput6 = '';
			feedOutput7 = '';
			feedOutput8 = '';
			feedOutput9 = '';
			
			feedActivityHistoryPreview = '';
			
			bold1 = false;
			bold2 = false;
			bold3 = false;
			bold4 = false;
			bold5 = false;
			bold6 = false;
			bold7 = false;
			bold8 = false;
			bold9 = false;
			
			disableRecordLink = false;
			
			showPreview = false;
			
			showHover = false;
			
			removeItem = false;
			
			showAltURL = false;
			
			
			if(ch.Field == 'created') {
				
				feedOutput1 = ch.CreatedById;
				feedOutput2 = ' Created.';
				
				recordLM = ch.CreatedDate.addSeconds(-1);
			}
			else if(ch.NewValue == null) {
				
				feedOutput1 = ch.CreatedById;
				feedOutput2 = ' deleted ';
				feedOutput3 = string.ValueOf(ch.OldValue);
				feedOutput4 = ' in ';
				feedOutput5 = ch.Field;
				
				bold5 = true;
			}
			else if(ch.OldValue != null) {
				
				if(string.ValueOf(ch.OldValue).contains('0127')) {
					
					removeItem = true;
				}
				
				feedOutput1 = ch.CreatedById;
				feedOutput2 = ' changed ';
				feedOutput3 = ch.Field;
				feedOutput4 = ' from ';
				feedOutput5 = string.ValueOf(ch.OldValue);
				feedOutput6 = ' to ';
				feedOutput7 = string.ValueOf(ch.NewValue);
				
				//parse out underscores in field names
				if(feedOutput3.contains('__c')) {
					
					feedOutput3 = feedOutput3.remove('__c');
					feedOutput3 = feedOutput3.replaceAll('_',' ');
				}
				
				if(feedOutput3.contains('RecordType')) {
					
					feedOutput3 = 'Ticket Record Type';
				}
				
				bold3 = true;
				bold7 = true;
			}
			else if(ch.OldValue == null) {
				
				if(string.ValueOf(ch.NewValue).contains('5007')) {
					
					removeItem = true;
				}
				
				feedOutput1 = ch.CreatedById;
				feedOutput2 = ' changed ';
				feedOutput3 = ch.Field;
				feedOutput4 = ' to ';
				feedOutput5 = string.ValueOf(ch.NewValue);
				
				//parse out underscores in field names
				if(feedOutput3.contains('__c')) {
					
					feedOutput3 = feedOutput3.remove('__c');
					feedOutput3 = feedOutput3.replaceAll('_',' ');
				}
				
				//add in word Ticket when ownership changes
				if(feedOutput3.contains('Parent')) {
					
					feedOutput3 = 'Parent Ticket';
				}
				
				bold3 = true;
				bold5 = true;
			}
			
			disableRecordLink = true;
		}
	}
	
	
	
	
	
	//#6B6B6B nice dark gray color
	
	//variable to control how many records displayed
	public integer recordsShown {get;set;}
	public boolean isScroll {get;set;}
	public string scrollLinkText {get;set;}
	
	public boolean listEmpty {get;set;}
	
	public string caseId {get;set;}
	
	public boolean isASC {get;set;}
	public string sortOrder {get;set;}
	
	public boolean isShowAll {get;set;}
	public string show {get;set;}
	
	public boolean displayCaseRunners {get;set;}
	public boolean displayCaseComments {get;set;}
	public boolean displayCaseHistory {get;set;}
	public boolean displayActivityHistory {get;set;}
	public boolean displayCaseEmails {get;set;}
	
	public string caseRunnerIcon {get;set;}
	public string caseCommentsIcon {get;set;}
	public string caseHistoryIcon {get;set;}
	public string activityHistoryIcon {get;set;}
	public string caseEmailsIcon {get;set;}
	
	public string caseRunnerQTY {get;set;}
	public string caseCommentQTY {get;set;}
	public string caseHistoryQTY {get;set;}
	public string activityHistoryQTY {get;set;}
	public string caseEmailQTY {get;set;}
	
	public string selectedFilter {get;set;}
		
	public case_ctrl_listView(ApexPages.StandardController controller) {
		
		//--------------------------------------------------------------------------
		/*
		Standard Controller variables to embed visualforce page into
		record page layout
		*/
		
		//initialize the standard controller
		this.controller = controller;
		this.c = (Case)controller.getRecord();
		
		//--------------------------------------------------------------------------
		
		isScroll = false;
		
		isShowAll = true;
		show = 'NONE';
		
		displayCaseRunners = true;
		displayCaseComments = true;
		displayCaseHistory = true;
		displayActivityHistory = true;
		displayCaseEmails = true;
		
		caseRunnerIcon = '0 -27px';
		caseCommentsIcon = '0 -27px';
		caseHistoryIcon = '0 -27px';
		activityHistoryIcon = '0 -27px';
		caseEmailsIcon = '0 -27px';
		
		isASC = false;
		sortOrder = 'DESC';
		
		//caseId = Apexpages.currentPage().getParameters().get('caseId');
		caseId = c.Id;
		
		queryList();
	}
	
	
	/* .. sample email for error handling ..
	
	// send email saying it failed
  	string message = 'Change Request Email Submit Error: Could not find a match for ' + envelope.fromAddress + ' and ' + senderName + ' in Salesforce. The Change Request has been created under the API User';

    // Send an email to the Apex job's submitter notifying of job completion.
    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
    String[] toAddresses = new String[] {'dean.lukowski@vinsolutions.com', 'dean.lukowski@vinsolutions.com'};
    mail.setToAddresses(toAddresses);
    mail.setSubject('Change Request Error');
    mail.setPlainTextBody(message);
    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
	 
	.. */
	
	// 0 0 .. plus icon
	// 0 -27px .. blue checkmark
	
	public void toggleFilter() {
		
		if(selectedFilter == 'displayCaseRunners') {
			
			if(displayCaseRunners) {
				
				displayCaseRunners = false;
				
				caseRunnerIcon = '0 0';
			}
			else {
				
				displayCaseRunners = true;
				caseRunnerIcon = '0 -27px';
			}
		}
		else if(selectedFilter == 'displayCaseComments') {
			
			if(displayCaseComments) {
				
				displayCaseComments = false;
				
				caseCommentsIcon = '0 0';
			}
			else {
				
				displayCaseComments = true;
				caseCommentsIcon = '0 -27px';
			}
		}
		else if(selectedFilter == 'displayCaseHistory') {
			
			if(displayCaseHistory) {
				
				displayCaseHistory = false;
				caseHistoryIcon = '0 0';
			}
			else {
				
				displayCaseHistory = true;
				caseHistoryIcon = '0 -27px';
			}
		}
		else if(selectedFilter == 'displayActivityHistory') {
			
			if(displayActivityHistory) {
				
				displayActivityHistory = false;
				activityHistoryIcon = '0 0';
			}
			else {
				
				displayActivityHistory = true;
				activityHistoryIcon = '0 -27px';
			}
		}
		else if(selectedFilter == 'displayCaseEmails') {
			
			if(displayCaseEmails) {
				
				displayCaseEmails = false;
				caseEmailsIcon = '0 0';
			}
			else {
				
				displayCaseEmails = true;
				caseEmailsIcon = '0 -27px';
			}
		}
		
		updateList();
	}
	
	public void showAllNone() {
		
		if(isShowAll) {
			
			displayCaseRunners = false;
			displayCaseComments = false;
			displayCaseHistory = false;
			displayActivityHistory = false;
			displayCaseEmails = false;
			
			caseRunnerIcon = '0 0';
			caseCommentsIcon = '0 0';
			caseHistoryIcon = '0 0';
			activityHistoryIcon = '0 0';
			caseEmailsIcon = '0 0';
			
			
			
			isShowAll = false;
			
			show = 'ALL';
		}
		else {
			
			displayCaseRunners = true;
			displayCaseComments = true;
			displayCaseHistory = true;
			displayActivityHistory = true;
			displayCaseEmails = true;
			
			caseRunnerIcon = '0 -27px';
			caseCommentsIcon = '0 -27px';
			caseHistoryIcon = '0 -27px';
			activityHistoryIcon = '0 -27px';
			caseEmailsIcon = '0 -27px';
			
			isShowAll = true;
			
			show = 'NONE';
		}
		
		updateList();
	}
	
	public void toggleSort() {
		
		if(isASC) {
			
			isASC = false;
			sortOrder = 'DESC';
		}
		else {
			
			isASC = true;
			sortOrder = 'ASC';
		}
		
		updateList();
	}
	
	public Map<Id, String> userNameMap = new Map<Id, String>();
	    
	
	
	
	public List<listWrapper> relatedObjects {get;set;}
	
	public List<Case_Runner__c> caseRunners {get;set;}
	public Case caseComment {get;set;}
	public Case caseHistory {get;set;}
	public Case theCase {get;set;}
	public Case caseEmail {get;set;}
	
	public Set<Id> userIds = new Set<Id>();
	
	public Map<Id, Integer> userInfluencerRankingMap = new Map<Id, Integer>();
	
	public void queryList() {
		
		//**query
		
		
		//case runners
		caseRunners = [SELECT Id, LastModifiedDate, Name, CreatedById, CreatedDate, LastModifiedById,
									Runner_Action__c, Escalated_To__c, Assigned_To__c, Runner_Request__c
					   FROM Case_Runner__c
					   WHERE Case__c = :caseId];
											
		//case comments
		caseComment = [SELECT Id,
							(SELECT Id, LastModifiedDate, CommentBody, LastModifiedById, IsPublished, ParentId
							 FROM CaseComments)
					   FROM Case
					   WHERE Id = :caseId];
		
		//Case History
		caseHistory = [SELECT Id,
							(SELECT Id, CreatedDate, Field, OldValue, NewValue, IsDeleted, CreatedById
							 FROM Histories)
					   FROM Case
					   WHERE Id = :caseId];
							
		//activity history
		theCase = [SELECT Id,
						(SELECT Id, LastModifiedDate, Status, Activity_Status__c, Subject, Preview__c, LastModifiedById, ActivityType,
							Last_Assigned_By__c, OwnerId
						 FROM ActivityHistories
						 LIMIT 500)
			       FROM Case
			       WHERE Id = :caseId];
		
		//Emails
		caseEmail = [SELECT Id,
						(SELECT Id, LastModifiedDate, Status, Subject, ToAddress, LastModifiedById, TextBody
				 		 FROM EmailMessages)
				     FROM Case
				     WHERE Id = :caseId];
				     
     	
     	//grab user ids and query ////////
		for(Case_Runner__c cr : caseRunners) {
			
			userIds.add(cr.CreatedById);
			userIds.add(cr.Assigned_To__c);
			
			/*
			//Influencer
			if(userInfluencerRankingMap.containsKey(cr.CreatedById)) {
				
				//userInfluencerRankingMap.get(cr.CreatedById)++;
			}
			*/
		}
	
		for(CaseComment cc : caseComment.CaseComments) {
			
			userIds.add(cc.LastModifiedById);
		}
		
		for(CaseHistory ch : caseHistory.Histories) {   ////////
			
			userIds.add(ch.CreatedById);
		}
	
		for(ActivityHistory ah : theCase.ActivityHistories) {
			
			userIds.add(ah.LastModifiedById);
			userIds.add(ah.OwnerId);
		}
	
		for(EmailMessage em : caseEmail.EmailMessages) {
			
			userIds.add(em.LastModifiedById);
		}
     	
     	queryUsers();
     	
				     
 		updateList();
	}
	
	public void queryUsers() {
 		
		for(User u : [SELECT Id, Name
					  FROM User
					  WHERE Id IN :userIds]) {
					  	
			userNameMap.put(u.Id, u.Name);			  	
		}
	}
	
	public void updateList() {
		
		relatedObjects = new List<listWrapper>();
		
		/////////////////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////////////////
		/////////////////////////////////////////////////////////////////////////////////
		
		//**poppulate list
		
		if(displayCaseRunners) {
			for(Case_Runner__c cr : caseRunners) {
				
				relatedObjects.add(new listWrapper(cr, userNameMap.get(cr.CreatedById), userNameMap.get(cr.Assigned_To__c)));
			}
		}
		
		if(displayCaseComments) {
			for(CaseComment cc : caseComment.CaseComments) {
				
				relatedObjects.add(new listWrapper(cc, userNameMap.get(cc.LastModifiedById)));
			}
		}
		
		//--
		//hardcode look for and exclude ...
		//-- '0127' for record type changes
		//-- '5007' for ticket Ids
		//-- OldValue, NewValue
		if(displayCaseHistory) {
			for(CaseHistory ch : caseHistory.Histories) {
				
				relatedObjects.add(new listWrapper(ch, userNameMap.get(ch.CreatedById)));
			}
		}
		
		if(displayActivityHistory) {
			for(ActivityHistory ah : theCase.ActivityHistories) {
				
				relatedObjects.add(new listWrapper(ah, userNameMap.get(ah.LastModifiedById), userNameMap.get(ah.OwnerId)));
			}
		}
		
		if(displayCaseEmails) {
			for(EmailMessage em : caseEmail.EmailMessages) {
				
				relatedObjects.add(new listWrapper(em, userNameMap.get(em.LastModifiedById)));
			}
		}
		
		//remove items
		if(relatedObjects.size() > 0) {
			
			relatedObjects = removeItems(relatedObjects);
		}
		
		//only sort if the list has items in it
		if(relatedObjects.size() > 0) {
			
			//**sort list
			if(isASC) {
				
				relatedObjects = sortASC(relatedObjects);
			}
			else {
				
				relatedObjects = sortDESC(relatedObjects);
			}
		}
		
		if(isScroll) {
			
			recordsShown = relatedObjects.size();
			scrollLinkText = 'Show Less (5)';
		}
		else {
			
			recordsShown = 5;	
			
			if(relatedObjects.size() > 5) {
				
				scrollLinkText = 'Show More (' + (relatedObjects.size() - 5) + ')';
			}
			else if(relatedObjects.size() == 5) {
				
				scrollLinkText = 'Show More (5)';
			}
			else if(relatedObjects.size() < 5) {
				
				scrollLinkText = 'Show More (' + (relatedObjects.size()) + ')';
			}
		}
		
		if(relatedObjects.size() == 0) {
			
			listEmpty = true;
		}
		else {
			
			listEmpty = false;
		}
		
		
		//update qtys
		calculateQuantities();
		
		
		//method to only display first 5 records in the list
		if(relatedObjects.size() > recordsShown) {
			
			relatedObjects = limitRecordsShown(relatedObjects);
		}
		
	}
	
	//remove items marked as removeItem = true
	public List<listWrapper> removeItems(List<listWrapper> originalList) {
		
		List<listWrapper> newListWrapper = new List<listWrapper>();
		
		for(listWrapper lw : originalList) {
			
			if(!lw.removeItem) {
				
				newListWrapper.add(lw);
			}
		}
		
		return newListWrapper;
	}
	
		
	//limit records shown
	public List<listWrapper> limitRecordsShown(List<listWrapper> originalList) {
		
		List<listWrapper> newListWrapper = new List<listWrapper>();
		
		integer i = 0;
		
		do {
			
			newListWrapper.add(originalList.get(i));
			i++;
		}
		while(i < recordsShown);
		
		return newListWrapper;
	}
	
	public void showMoreLess() {
		
		//set variable
		if(isScroll) {
			
			isScroll = false;
		}
		else {
			
			isScroll = true;
		}
		
		//run updateList()
		updateList();
	}
	
	
	//..QTY
	public void calculateQuantities() {
		
		caseRunnerQTY = string.ValueOf(caseRunners.size()); 
		caseCommentQTY = string.ValueOf(caseComment.CaseComments.size());  
		caseHistoryQTY = string.ValueOf(caseHistory.Histories.size());
		activityHistoryQTY = string.ValueOf(theCase.ActivityHistories.size());
		caseEmailQTY = string.ValueOf(caseEmail.EmailMessages.size());
	}
	
	public List<listWrapper> sortDESC(List<listWrapper> originalList) {
		
		List<listWrapper> newListWrapper = new List<listWrapper>();
		
		List<listWrapper> newDESCListWrapper = new List<listWrapper>();
		
		List<DateTime> sortIndexes = new List<DateTime>();
		
		//map does not work b/c key will never be unique with duplicate dates
		//Map<DateTime, listWrapper> dtMap = new Map<DateTime, listWrapper>();
		
		for(listWrapper lw : originalList) {
			
			sortIndexes.add(lw.recordLM);
		}
		
		sortIndexes.sort();
		
		for(DateTime dt : sortIndexes) {
			
			for(listWrapper lw : originalList) {
				
				if(lw.recordLM == dt) {
					
					newListWrapper.add(lw);
					lw.recordLM = null;
					break;
				}
			}
		}
		
		integer i = newListWrapper.size() - 1;
		
		do {
			
			newDESCListWrapper.add(newListWrapper.get(i));
			
			i--;
		}
		while(i >= 0);
		
		return newDESCListWrapper;
	}
	
	
	public List<listWrapper> sortASC(List<listWrapper> originalList) {
		
		List<listWrapper> newListWrapper = new List<listWrapper>();
		
		List<DateTime> sortIndexes = new List<DateTime>();
		
		//map does not work b/c key will never be unique with duplicate dates
		//Map<DateTime, listWrapper> dtMap = new Map<DateTime, listWrapper>();
		
		for(listWrapper lw : originalList) {
			
			sortIndexes.add(lw.recordLM);
		}
		
		sortIndexes.sort();
		
		for(DateTime dt : sortIndexes) {
			
			for(listWrapper lw : originalList) {
				
				if(lw.recordLM == dt) {
					
					newListWrapper.add(lw);
					lw.recordLM = null;
					break;
				}
			}
		}
		
		return newListWrapper;
	}
	
	public PageReference nullPR() {
		
		return null;
	}
}