global class HayAsyncHandler {
@future
public static void handleProjectCreation(Id projectId){

	
	try{

List<SFDC_520_Quote__c> projectList = [Select Id from SFDC_520_Quote__c where Id =: projectId];
  if(projectList != null && projectList.size() > 0){
  	     SFDC_520_Quote__c project = projectList[0];
      
       List<Project_Piece__c> projectPieces = [Select Id,  Product_Family__c, Product_Name__c,Project_Piece_Stage__c ,RecordTypeId from Project_Piece__c where Project__c =: project.Id];
       Boolean hasRecurring = false;
       Boolean websiteIncluded = false;

      //TODO: Update 
      for(Project_Piece__c piece :projectPieces){
      // check Has Recurring Products if any of the generated Project Assets are for products where the Product Family is Monthly Reoccurring
      if(piece.Product_Family__c != null && piece.Product_Family__c.contains('Reoccuring')){
		hasRecurring = true;
	  }

	  // check Website Included if any of the the generated Proejct Assets are for products that have 'website' in the Product Name
	  if(piece.Product_Name__c != null && piece.Product_Name__c.contains('Website')){
		websiteIncluded = true;
	  }
	  }
	  project.Has_Recurring_Products__c = hasRecurring;
	  project.Website_Custom__c = websiteIncluded;
	  update project;

  }
  else{
      System.debug('No Project found with Id: '+projectId);
  }
  
	}
	catch(Exception ex){
		 try{
		  string errorDetails = UtilityClass.DebugException(ex);
          string message = 'There has been an error in vAutoAsynHandler.handleProjectCreation '+ errorDetails;
		  Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          String[] toAddresses = new String[] {'ramana.mosali@autotradergroup.com'};
          mail.setToAddresses(toAddresses);
          mail.setSubject('vAutoAsynHandler.handleProjectCreation Error');
          mail.setPlainTextBody(message);
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
		  }catch(Exception e){
		  	//Ignore if anything else fail
		  }
	}
  

}
}