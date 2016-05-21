@isTest
private class BSNightlyATGCatalogReportHandler_Test {
	
	@isTest static void testInBoundEmail() {
		//Creating an email
		Messaging.InboundEmail email = new Messaging.InboundEmail();
		Messaging.InboundEnvelope env = new Messaging.InboundEnvelope();

		email.subject = 'eAcademy Test Record';
		email.fromAddress = 'someaddress@email.com';
		email.plainTextBody = 'Test Email Body';
		// Binary Attachment
		Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
		attachment.body = blob.valueOf('CourseTitle, PresentationID, CourseDeleted, CourseActive, CourseArchived, Author, ' +
											'Student, StudentActive, StudentDeleted, StudentEMail, StudentUserName, StudentTitle, StudentDepartment, StudentCompany,' +
											'StudentPhone, StudentAddress1, StudentAddress2, StudentCity, StudentState, StudentCountry, StudentPostalCode, ' +
											'StudentCustom1,StudentCustom2,StudentCustom3,StudentCustom4,Student Custom5,Student Custom6,Student Custom7, ' +
											'Student Custom8,Student Custom9,Student Custom10,ViewingTime,PercentDuration,SlidesViewed, PercentSlidesViewed, '+
											'Points,Score,PassFail, Status,EnrolledDate,CompletedDate,CourseCreateDate, ContentType,'+
											'CourseDescription,CourseExtendedDescription, Credits,SCORM Duration  \r\n' + //end Header line
										'COX-65,762508739,0,1,0, Aisha OMalley, David Stephen,1,0,David.Stephens@vinsolutions.com,dastephens,,,VinSolutions,,,,,,,,,,,,,,,,,, ' +
											'1230, 75, 8, 100,30,100,,Completed,3/20/2016,3/1/2016,2/17/2016,Brainshark,Admin1,,0,480'//end second line
											);
		attachment.fileName = 'textFileOne.txt';
		attachment.mimeTypeSubType = 'text/plain';
		email.binaryAttachments = new Messaging.InboundEmail.BinaryAttachment[]{attachment};

		Messaging.InboundEmail.TextAttachment attachmentText = new Messaging.InboundEmail.TextAttachment();
		attachmentText.body = 'CourseTitle, PresentationID, CourseDeleted, CourseActive, CourseArchived, Author, ' +
											'Student, StudentActive, StudentDeleted, StudentEMail, StudentUserName, StudentTitle, StudentDepartment, StudentCompany,' +
											'StudentPhone, StudentAddress1, StudentAddress2, StudentCity, StudentState, StudentCountry, StudentPostalCode, ' +
											'StudentCustom1,StudentCustom2,StudentCustom3,StudentCustom4,Student Custom5,Student Custom6,Student Custom7, ' +
											'Student Custom8,Student Custom9,Student Custom10,ViewingTime,PercentDuration,SlidesViewed, PercentSlidesViewed, '+
											'Points,Score,PassFail, Status,EnrolledDate,CompletedDate,CourseCreateDate, ContentType,'+
											'CourseDescription,CourseExtendedDescription, Credits,SCORM Duration  \r\n' + //end Header line
										'COX-65,762508739,0,1,0, Aisha OMalley, David Stephen,1,0,David.Stephens@vinsolutions.com,dastephens,,,VinSolutions,,,,,,,,,,,,,,,,,, ' +
											'1230, 75, 8, 100,30,100,,Completed,3/20/2016,3/1/2016,2/17/2016,Brainshark,Admin1,,0,480';//end second line
		attachmentText.fileName = 'textFileTwo.txt';
		attachmentText.mimeTypeSubType = 'textTwo/plain';
		email.textAttachments = new Messaging.InboundEmail.TextAttachment[]{attachmentText};



		/*Mismatched reportColumnHeaders  StudentCustom5 to StudentCustom10(without spaces) to get better code coverage*/
		Messaging.InboundEmail.TextAttachment attachmentText2 = new Messaging.InboundEmail.TextAttachment();
		attachmentText2.body = 'CourseTitle, PresentationID, CourseDeleted, CourseActive, CourseArchived, Author, ' +
											'Student, StudentActive, StudentDeleted, StudentEMail, StudentUserName, StudentTitle, StudentDepartment, StudentCompany,' +
											'StudentPhone, StudentAddress1, StudentAddress2, StudentCity, StudentState, StudentCountry, StudentPostalCode, ' +
											'StudentCustom1,StudentCustom2,StudentCustom3,StudentCustom4,StudentCustom5,StudentCustom6,StudentCustom7, ' +
											'StudentCustom8,StudentCustom9,StudentCustom10,ViewingTime,PercentDuration,SlidesViewed, PercentSlidesViewed, '+
											'Points,Score,PassFail, Status,EnrolledDate,CompletedDate,CourseCreateDate, ContentType,'+
											'CourseDescription,CourseExtendedDescription, Credits,SCORM Duration  \r\n' + //end Header line
										'COX-65,762508739,0,1,0, Aisha OMalley, David Stephen,1,0,David.Stephens@vinsolutions.com,dastephens,,,VinSolutions,,,,,,,,,,,,,,,,,, ' +
											'1230, 75, 8, 100,30,100,,Completed,3/20/2016,3/1/2016,2/17/2016,Brainshark,Admin1,,0,480';//end second line
		attachmentText.fileName = 'textFileTwo.txt';
		attachmentText.mimeTypeSubType = 'textTwo/plain';
		email.textAttachments = new Messaging.InboundEmail.TextAttachment[]{attachmentText2};

		
		BSNightlyATGCatalogReportHandler testInbound = new BSNightlyATGCatalogReportHandler();
		testInbound.handleInboundEmail(email, env);
		
	}
}