public with sharing class PTO_StartPage{

	private final Time_Off_Balance__c ptoBal;
	
	public String balName {get; Set;}
	public String avail {get; Set;}
	public String totalApproved {get; Set;}
	public String balId {get; Set;}
	public String userName {get; Set;}
	public String userId {get; Set;}
	public String totalApp2015 {get; set;}
	public String avail2015 {get; set;}
	
	public PTO_StartPage(ApexPages.StandardController stdController){
		
		this.ptoBal = (Time_Off_Balance__c)stdController.getRecord();
		
		balName = ApexPages.currentPage().getParameters().get('balName');
		avail = ApexPages.currentPage().getParameters().get('avail');
		totalApproved = ApexPages.currentPage().getParameters().get('totalApproved');
		balId = ApexPages.currentPage().getParameters().get('id');
		userName = ApexPages.currentPage().getParameters().get('user');
		userId = ApexPages.CurrentPage().getParameters().get('userId');
		avail2015 = ApexPages.CurrentPage().getParameters().get('avail2015');
		totalApp2015 = ApexPages.CurrentPage().getParameters().get('totalApp2015');
		
		
	}
	
	public PageReference next(){
		
		//PageReference nextPage = new PageReference('/apex/PTO_PageOneEmpDays?BN='+balName+'&avail='+avail+'&totalApproved='+totalApproved);
		PageReference nextPage = new PageReference('/apex/PTO_PageOneEmpDays');
		nextPage.getParameters().put('balName', balName);
		nextPage.getParameters().put('avail', avail);
		nextPage.getParameters().put('totalApproved', totalApproved);
		nextPage.getParameters().put('balId', balId);
		nextPage.getParameters().put('userName', userName);
		nextPage.getParameters().put('userId', userId);
		nextPage.getParameters().put('avail2015', avail2015);
		nextPage.getParameters().put('totalApp2015', totalApp2015);
		nextPage.setRedirect(true);
		return nextPage;
		
	}

}