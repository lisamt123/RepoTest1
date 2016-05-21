global class BSNightlyATGCatalogReportHandler implements Messaging.InboundEmailHandler {

  static List<string> reportColumnHeaders = new List<String>{ 'CourseTitle'
																,'PresentationID'
																,'CourseDeleted'
																,'CourseActive'
																,'CourseArchived'
																,'Author'
																,'Student'	
																,'StudentActive'
																,'StudentDeleted'
																,'StudentEMail'	
																,'StudentUserName'
																,'StudentTitle'	
																,'StudentDepartment'	
																,'StudentCompany'
																,'StudentPhone'
																,'StudentAddress1'
																,'StudentAddress2'
																,'StudentCity'	
																,'StudentState'	
																,'StudentCountry'	
																,'StudentPostalCode'	
																,'StudentCustom1'	
																,'StudentCustom2'	
																,'StudentCustom3'	
																,'StudentCustom4'	
																,'Student Custom5'	
																,'Student Custom6'	
																,'Student Custom7'	
																,'Student Custom8'	
																,'Student Custom9'	
																,'Student Custom10'
																,'ViewingTime'	
																,'PercentDuration'	
																,'SlidesViewed'	
																,'PercentSlidesViewed'	
																,'Points'	
																,'Score'
																,'PassFail'	
																,'Status'	
																,'EnrolledDate'	
																,'CompletedDate'	
																,'CourseCreateDate'	
																,'ContentType'	
																,'CourseDescription'	
																,'CourseExtendedDescription'
																,'Credits'	
																,'SCORM Duration'
};

 global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
  	Messaging.InboundEmailResult result = new Messaging.InboundEmailResult();
  	try{	 	
		if(email.binaryAttachments != null && email.binaryAttachments.size() > 0){
			for (Messaging.Inboundemail.BinaryAttachment bAttachment : email.binaryAttachments) {
				system.debug('Processing Binary Attachement: '+ bAttachment.fileName);
				blob reportContent =bAttachment.body;
				ProcessAttachement(reportContent.toString());
			}
		} 
		else{
			system.debug('No Binary Attachements');
		}
		if(email.textAttachments != null && email.textAttachments.size() > 0){
			for (Messaging.Inboundemail.TextAttachment tAttachment : email.textAttachments) {
				system.debug('Processing Text Attachement: '+ tAttachment.fileName);
				ProcessAttachement(tAttachment.body);
			}
		} 
		else{
			system.debug('No Text Attachements');
		}
	}
	catch(Exception ex){	
		String subject = 'Error Parsing Email: '+email.subject;
		String message =  UtilityClass.DebugException(ex);		
		UtilityClass.DevelopersEmail(subject, message);
	}
	result.success = true;
	return result;
}


 private void ProcessAttachement(string reportContent){
	list<list<string>> parsedCSV = UtilityCSVParser.parse(reportContent,false);
	System.debug('======================>>>>>> parsedCSV = ' + parsedCSV);
	System.debug('======================>>>>>> parsedCSV.size = ' + parsedCSV.size());

//START VALIDATION
//Validate the file
	list<string> header = parsedCSV.remove(0);
	system.debug('Number of Header Columns #: '+ header.size());
	system.debug('Number of Valid Header Columns #: '+ reportColumnHeaders.size());


	     //New report contains more columns than report columns -3-25-2016
		if(header.size() != reportColumnHeaders.size()){
			throw new CoxAutomotiveException('Report columns count did not match: Expected: '+reportColumnHeaders.size() +'; Found: '+ header.size());			
		}
	 //setting to zero based
	Integer reportColumnCount = reportColumnHeaders.size() -1;

	while(reportColumnCount >= 0){
		String field = header[reportColumnCount];

		field = field.trim();
    	//there is a ANSI character  ï»¿Sort ViewerInfo that is shows up
    	//removing non-US-ASCII 
		field = field.replaceall('[^\\x00-\\x7F]', '');

		system.debug('Processing column: '+header[reportColumnCount] + '; converted to remove special character and got: '+field);
		if(!field.equalsIgnoreCase(reportColumnHeaders[reportColumnCount])){
			String strValidColumnHeaders='';
			for(String str : reportColumnHeaders){
			 strValidColumnHeaders += str + ',' ;
			}
			String strEmailReportColumnHeaders='';
			for(String str : header){
			 strEmailReportColumnHeaders += str + ',' ;
			}
			throw new CoxAutomotiveException('Column '+reportColumnCount+1 + ' is invalid Expected: '+ reportColumnHeaders[reportColumnCount] +' but found: '+field +'; Report columns did not match: Expected: '+strValidColumnHeaders +'; Found: '+ strEmailReportColumnHeaders);
		}
		reportColumnCount = reportColumnCount-1;	
	}
//END VALIDATION

			//Now the file is Valid proceed to process
			list<eAcademy__c> eAcademyObjListToInsert = new list<eAcademy__c>();
			for(list<string> line:parsedCSV){
				eAcademy__c eAcademyobj = new eAcademy__c();
				String strDebugLine='';
				Integer columnOrdinalPosition = 0;
				for(String str : line){
					 strDebugLine += header[columnOrdinalPosition] + ':'+str + ', ' ;
					 columnOrdinalPosition ++;
				}
				system.debug(strDebugLine);
				eAcademyobj.Sort_ViewerInfo__c = line[6]; 
				if(eAcademyobj.Sort_ViewerInfo__c.equalsIgnoreCase('user, public')){
					continue;
				}
				else{
					eAcademyobj.Sort_Title__c = line[0];					
	  				eAcademyobj.ViewerInfo__c = line[6];
	  				eAcademyobj.Vin_User_ID__c = line[10];
	  				eAcademyobj.Dealership_Name__c = line[13];
	  				eAcademyobj.View_Total_Pct_of_Duration__c = line[32];
	  				eAcademyobj.View_Total_Slides_Viewed__c = line[33];	  				
	  				eAcademyobj.View_Total_Pct_of_Slides__c = line[34];
	  				eAcademyobj.View_Total_Points__c = line[35];
	  				eAcademyobj.View_Total_Score__c = line[36];
	  				eAcademyobj.View_Type__c = line[38];
	  				eAcademyobj.Course_Completed_Date__c=line[40];
	  				eAcademyobj.Viewing_Time__c = line[46];
	  				
	  					  				  				
	  				eAcademyObjListToInsert.add(eAcademyobj);  				
	  					  				
	  			   
  				}
			}
			if(eAcademyObjListToInsert.size() > 0){
				System.debug('======================>>>>>> eAcademyObjListToInsert.size = ' + eAcademyObjListToInsert.size());
				insert eAcademyObjListToInsert;
			}
}

}