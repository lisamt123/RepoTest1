public class TrainingQuestionnaire
{   
    public Account account;
    public SFDC_520_Quote__c project;
    
    
        
    //Get records=====================================================  
    public Account getAccount() 
    {
        if(account == null) account = new Account();
        return account;
        
    }   
   
       
    public SFDC_520_Quote__c getProject() 
    {
        if(project == null) project = 
        [Select s.What_local_hotel_do_you_recommend__c, s.What_is_the_nearest_airport__c, 
        s.Training_Questionnaire_Completed_By__c, s.Room_for_10_students_plus_trainer__c, 
        s.Projector_that_can_display_PC_screen__c, s.Projection_screen_or_large_empty_wall__c,
        s.Internet_Access__c, s.Internet_Access_Keys_Passwords_IP_add__c, s.Hotel_Distance__c, 
        s.Available_exclusively_for_training__c, s.Airport_Distance__c,s.Account__r.Name 
        From SFDC_520_Quote__c s        
        where Id=:System.currentPageReference().getParameters().get('Id') limit 1];        
                                              
        return project;        
    }
    
    public pageReference next()
    {
        update project;
        if(System.currentPageReference().getUrl().toLowerCase().contains('trainingquestionnaire1'))
        {
        	return Page.TrainingQuestionnaire2;
        }
        if(System.currentPageReference().getUrl().toLowerCase().contains('trainingquestionnaire2'))
        {
        	return Page.TrainingQuestionnaireComplete;
        }
        else return Page.TrainingQuestionnaire1;
    }
    public pageReference back()
    {
       update project;
        if(System.currentPageReference().getUrl().toLowerCase().contains('trainingquestionnaire1'))
        {
        	return Page.TrainingQuestionnaire;
        }
        if(System.currentPageReference().getUrl().toLowerCase().contains('trainingquestionnaire2'))
        {
        	return Page.TrainingQuestionnaire1;
        }
        else return Page.TrainingQuestionnaire2;
    }
    public pageReference cancel()
    {
        update project;
        return null;
    }
    
    public static testmethod void testTraining()
    {    	
    	SFDC_520_Quote__c W = new SFDC_520_Quote__c();
        W.name = 'test';        
        insert W;
        
        PageReference testStart = Page.TrainingQuestionnaire;
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);        
        
        TrainingQuestionnaire TQ = new TrainingQuestionnaire();
        
        SFDC_520_Quote__c WP = TQ.getProject();    
        
        TQ.next();    	
    	TQ.back();
    	TQ.cancel();
    	TQ.getAccount();
    }
}