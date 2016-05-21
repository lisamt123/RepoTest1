public with sharing class DataIntegrationController { 
    
    private final ApexPages.Standardcontroller controller;
    Id id;
    public String notes {get; set;}
    public String requestType {get; set;}
    public SFDC_520_Quote__c thisProject = new SFDC_520_Quote__c();
    public Boolean pieceExists;
    public Project_Piece__c dataIntegrationPiece = new Project_Piece__c();
    public LIST<Selectoption> requestOptions = new LIST<SelectOption>();
    public Account thisAccount = new Account();
    public LIST<Project_Runner__c> pieceRunnerHistory = new LIST<Project_Runner__c>();

    public DataIntegrationController(ApexPages.Standardcontroller controller){
        this.controller = controller;
        id = Apexpages.currentPage().getParameters().get('id');
        thisProject = [select id, OwnerId, Account__c, Contact__c, Name from SFDC_520_Quote__c where id =: id];
        thisAccount = [select id, OwnerId, Name from Account where id =: thisProject.Account__c limit 1];
    }
    
    public Id getId(){
        id = Apexpages.currentPage().getParameters().get('id');
        return id;
    }
    
    public Account getThisAccount(){
        return thisAccount;
    }
    
    public SFDC_520_Quote__c getThisProject(){
        return thisProject;
    }
    
    
    public String getNotes(){
    //------- Getter/Setter for notes
    
        return notes;
    }
    
    public String getRequestType(){
    //------- Getter/Setter for requestType
    
        return requestType; 
    }
    
    public LIST<Selectoption> getRequestOptions(){
       //update code here!
      sObject pr = new Project_Runner__c();
       
       return getPickValues(pr, 'Runner_Type__c', '');
       
    
    
    }
    
    public LIST<Project_Runner__c> getPieceRunnerHistory(){
        pieceRunnerHistory = [select id, CreatedDate, Run_To__c, Runner_Action__c, Runner_Type__c from Project_Runner__c where project_Piece__c =: dataIntegrationPiece.Id order by CreatedDate DESC];
        return pieceRunnerHistory;

    }
    
    

    public void setNotes (String theseNotes){
        notes = theseNotes; 
    }
    
    public void setRequestType (String thisRequest){
        requestType = thisRequest;
    }
    
    public boolean getPieceExists(){
        boolean hasDataIntegration = false;
        LIST <Project_Piece__c> thesePieces = [select id, OwnerId, Project__c, Name, Piece_Issue__c from Project_Piece__c where Project__c =: id];

        for (Project_Piece__c thisPiece: thesePieces){
            string thisPieceName = thisPiece.Name.toLowerCase();
            string thisPieceIssue = thisPiece.Piece_Issue__c.toLowerCase();
            if (thisPieceName.contains('data integration') || thisPieceIssue.contains('data integration')) {
                dataIntegrationPiece = thisPiece;
                hasDataIntegration = true;
            }       
            system.debug(thisPiece.Name);   
        }
        if (hasDataIntegration) return true;
        else return false;          
    }
    
    
    public Pagereference generateProjectPiece(){       
        PageReference projectPage = new ApexPages.StandardController(thisProject).view();
                
        Product2 thisProduct = [select id, Name from Product2 where Name =: 'Data Integration' limit 1];
        Product_Process__c thisProductProcess = [select id, OwnerId, Name from Product_Process__c where Name =: 'Data Integration' limit 1];             
        
                
        Datetime dateTimeTemp = System.now();
		Date dateTemp = Date.newInstance(dateTimeTemp.year(), dateTimeTemp.month(), dateTimeTemp.day());
		String x = dateTemp.format();
        
        Project_Piece__c newProjectPiece = new Project_Piece__c();
        newProjectPiece.Project__c = thisProject.Id;
        newProjectPiece.Piece_Issue__c = 'PP-Data Integration -' + thisAccount.Name + ' - ' + system.now();
        newProjectPiece.Name = 'PP-Data Integration -' + thisAccount.Name + ' - ' + x;
        newProjectPiece.Product_Name__c = thisProduct.Name;
        newProjectPiece.Product_Process__c = thisProductProcess.Id; 
        newProjectPiece.Account__c = thisAccount.Id;
        newProjectPiece.Contact__c = thisProject.Contact__c;
        newProjectPiece.Project_Piece_Stage__c = 'Introduction';
    
        insert newProjectPiece;
             
        Project_Runner__c newRunner = new Project_Runner__c();
        newRunner.Project_Piece__c = newProjectPiece.Id;
        newRunner.Run_To__c = 'Integration';
        newRunner.Runner_Action__c = 'Request';
        newRunner.Runner_Type__c = requestType;
        newRunner.Comments__c = notes;
        newRunner.Piece_Owner__c = dataIntegrationPiece.OwnerId;
        newRunner.Priority__c = '3 - Normal';
 		
 		if (requestType == 'Comp'){
	        newRunner.Event_Date_Time__c = system.now();
	        newRunner.Event_End_Date_Time__c = system.now() + 120;
        }
        
        insert newRunner; 

        
                
        return projectPage;
    }
    
    
        
    public Pagereference updateProjectPiece(){
        PageReference projectPage = new ApexPages.StandardController(thisProject).view();
        
        Project_Runner__c newRunner = new Project_Runner__c();
        newRunner.Project_Piece__c = dataIntegrationPiece.Id;
        newRunner.Run_To__c = 'Integration';
        newRunner.Runner_Action__c = 'Request';
        newRunner.Runner_Type__c = requestType;
        newRunner.Comments__c = notes;
        newRunner.Piece_Owner__c = dataIntegrationPiece.OwnerId;
        newRunner.Priority__c = '3 - Normal';
        
        if (requestType == 'Comp'){
	        newRunner.Event_Date_Time__c = system.now();
	        newRunner.Event_End_Date_Time__c = system.now() + 120;
        }
        insert newRunner; 
        
        return projectPage;
    } 
    

    
    public Pagereference returnToProject(){
        PageReference projectPage = new ApexPages.StandardController(thisProject).view();
        return projectPage;
    }
    
    public Pagereference goToPiece(){
        pageReference dataPiecePage = new ApexPages.StandardController(dataIntegrationPiece).view();
        return dataPiecePage;
    }
    
    public List<selectOption> getPickValues(Sobject object_name, String field_name, String first_val) {
      List<selectOption> options = new List<selectOption>(); //new list for holding all of the picklist options
      if (first_val != null) { //if there is a first value being provided
         options.add(new selectOption(first_val, first_val)); //add the first option
      }
      Schema.sObjectType sobject_type = object_name.getSObjectType(); //grab the sobject that was passed
      Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe(); //describe the sobject
      Map<String, Schema.SObjectField> field_map = sobject_describe.fields.getMap(); //get a map of fields for the passed sobject
      List<Schema.PicklistEntry> pick_list_values = field_map.get(field_name).getDescribe().getPickListValues(); //grab the list of picklist values for the passed field on the sobject
      for (Schema.PicklistEntry a : pick_list_values) { //for all values in the picklist list
         options.add(new selectOption(a.getLabel(), a.getValue())); //add the value and label to our final list
      }
      return options; //return the List
   }

}