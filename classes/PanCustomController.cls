public with sharing class PanCustomController {
    public LIST<PersonnelChanges> personnelChangesList {get; set;}
    public PAN__c panForm {get; set;}
    String PANID {get; set;}
    public String EmpSalary {get; set;}
    public String SalChange {get; set;}
    
    public PageReference next(){
		
		PageReference nextPage = new PageReference('/apex/PanForm');  
		nextPage.setRedirect(False);
		return nextPage;
	}
	
	public PageReference next2(){
		PageReference nextPage = new PageReference('/apex/PanFormNotNewEmp');
		nextPage.setRedirect(False);
		return nextPage;
	}

    public PanCustomController(ApexPages.StandardController controller) {
		PANID = Apexpages.currentPage().getParameters().get('id');           
        setPanForm();
        setPersonnelChangesList();
    }
    
    public LIST<PersonnelChanges> getPersonnelChangesList(){
        if (personnelChangesList == null) setPersonnelChangesList();
        return personnelChangesList;
    }
    
    public PAN__c getPanForm(){
    	if (panForm == null) setPanForm();
    	return panForm;
    }
    public void setPanForm(){
    	panForm = new PAN__c();
    	panForm = [select Id, Relocation__c, Department_Change__c, Title_Change__c, Demotion__c, 
    					Reporting_Change__c, Salary_Change__c, Bonus__c, Commission_to_Non_Commission__c, 
    					Non_Commission_to_Commission__c, Non_Exempt_to_Exempt__c, Exempt_to_Non_Exempt__c,
    					Current_Department__c, Current_Manager__c, Current_Role__c, Current_Title__c, 
    					Department__c, Reports_To__c, Current_Salary__c, Salary_Amount_Encrypted__c,
    					Reports_To__r.Name, Role__c, Job_Title__c, Vin_Employee__r.Home_Address__c, New_Job_Title__c,
    					Promotion__c, MI__c, Justification__c 					
    					from Pan__c where Id =: PANID];
    					
    }
    public void setPersonnelChangesList(){
    	personnelChangesList = new LIST<PersonnelChanges>();    	
    	if (panForm.Relocation__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Relocation';
    		personnelChange.CurrentInformation = '';
    		personnelChange.NewInformation = '';
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Department_Change__c == true) {
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Department Change';
    		personnelChange.CurrentInformation = panForm.Current_Department__c;
    		personnelChange.NewInformation = panForm.Department__c;
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Title_Change__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Title Change';
    		personnelChange.CurrentInformation = panForm.Current_Title__c;
    		personnelChange.NewInformation = panForm.New_Job_Title__c;
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Reporting_Change__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Reporting Change';
    		personnelChange.CurrentInformation = panForm.Current_Manager__c;
    		personnelChange.NewInformation = panForm.Reports_To__r.Name;
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Salary_Change__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Salary Change';
    		personnelChange.CurrentInformation = String.valueOf(panform.Current_Salary__c);
    		personnelChange.NewInformation = String.valueOf(panform.Salary_Amount_Encrypted__c);
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Bonus__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Bonus';
    		personnelChange.CurrentInformation = '';
    		personnelChange.NewInformation = '';
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Commission_to_Non_Commission__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Commission to Non Commission';
    		personnelChange.CurrentInformation = '';
    		personnelChange.NewInformation = '';
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Non_Commission_to_Commission__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Non Commission to Commission';
    		personnelChange.CurrentInformation = '';
    		personnelChange.NewInformation = '';
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Non_Exempt_to_Exempt__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Non Exempt to Exempt';
    		personnelChange.CurrentInformation = '';
    		personnelChange.NewInformation = '';
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Exempt_to_Non_Exempt__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Exempt to Non Exempt';
    		personnelChange.CurrentInformation = '';
    		personnelChange.NewInformation = '';
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Demotion__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Demotion';
    		personnelChange.CurrentInformation = '';
    		personnelChange.NewInformation = '';
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (panForm.Promotion__c == true){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'Promotion';
    		personnelChange.CurrentInformation = '';
    		personnelChange.NewInformation = '';
    		personnelChangesList.add(personnelChange);    	
    	}
    	if (personnelChangesList.isEmpty()){
    		PersonnelChanges personnelChange = new PersonnelChanges();
    		personnelChange.ActionRequired = 'No Changes';
    		personnelChange.CurrentInformation = 'No Changes';
    		personnelChange.NewInformation = 'No Changes';
    		personnelChangesList.add(personnelChange); 
    	}
    }
    
    public class PersonnelChanges{
        public String ActionRequired {get; set;}
        public String CurrentInformation {get; set;}
        public String NewInformation {get;  set;}
        
    }
}