public class UtilityClass{


 public static String DebugException(Exception ex){
        
           String errorDetails = '';
           
           String errorMessage = 'Error Message:' +ex.getMessage();
           errorDetails  = errorDetails + '::'+ errorMessage;
           System.debug(errorMessage);
           
           String errorStackTrace = 'Error StackTraceString:' +ex.getStackTraceString();
           errorDetails  = errorDetails + '::'+ errorStackTrace;
           System.debug(errorStackTrace);
           
           String errorLineNumber = 'Error LineNumber:' +ex.getLineNumber();
           errorDetails  = errorDetails + '::'+ errorLineNumber;
           System.debug(errorLineNumber);
           
           String errorType = 'Error TypeName:' +ex.getTypeName();
           errorDetails  = errorDetails + '::'+ errorType;
           System.debug(errorType);
           
           Integer errorLevel = 0;
           while(ex.getCause() != null){
           ex  = ex.getCause();
           errorLevel++;
           
           errorMessage = errorLevel+'Error Message:' +ex.getMessage();
           errorDetails  = errorDetails + '::'+ errorMessage; 
           System.debug(errorMessage);
           
           errorStackTrace = errorLevel+'Error StackTraceString:' +ex.getStackTraceString();
           errorDetails  = errorDetails + '::'+ errorStackTrace; 
           System.debug(errorStackTrace);
           
           errorLineNumber = errorLevel+'Error LineNumber:' +ex.getLineNumber();
           errorDetails  = errorDetails + '::'+ errorLineNumber;           
           System.debug(errorLineNumber);
           
           errorType = errorLevel+'Error TypeName:' +ex.getTypeName();
           errorDetails  = errorDetails + '::'+ errorType;           
           System.debug(errorType);           
           }
           //create a log
           CreateApexLog(errorDetails);
           return errorDetails;
        }

	public static void CreateApexLog(String message){
		
		try{			
			ApexLog__c log = new ApexLog__c();
			log.Details__c = message;
			log.User__c = System.UserInfo.getUserId();
			insert log;			
		}
		catch(Exception ex){
			//ignore if could not log			
			system.debug('Could not create a apex log: '+message);
		}
	}
    public static void debugSystemLimits(){
    
        System.debug('SOQL queries Used:'+Limits.getQueries());
         System.debug('SOQL queries remaining:'+Limits.getLimitQueries());
         
                 System.debug('Records returned using SOQL queries :'+Limits.getQueryRows());
         System.debug('Records that can be retrived using SOQL queries'+Limits.getLimitQueryRows());
         
                                   System.debug('Heap sized used:'+Limits.getHeapSize());
         System.debug('Heap size remaining: '+Limits.getLimitHeapSize());
         
                                   System.debug('Heap sized used:'+Limits.getHeapSize());
         System.debug('Heap size remaining: '+Limits.getLimitHeapSize());
         
                          System.debug('DML statements used:'+Limits.getDMLStatements());
         System.debug('DML statements remaining: '+Limits.getLimitDMLStatements());
    }

    public static void DevelopersEmail(String subject, String message){
        try{
            List<Developer_Email__c> devEmails = Developer_Email__c.getAll().values();
            String[] toAddresses = new String[]{};
            for(Developer_Email__c email : devEmails){
                toAddresses.add(email.Developer__c);
            }
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            mail.setToAddresses(toAddresses);
            mail.setSubject(subject);
            mail.setPlainTextBody(message);
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
        catch(Exception e){
            system.debug('Email failed to send: ' + e.getMessage());
        }
    }

    public static void SendEmail(String emailAddress, String subject, String message){
      try{
              
          String[] toAddresses = emailAddress.split(';');    
         
          Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
          mail.setToAddresses(toAddresses);
          mail.setSubject(subject);
          mail.setPlainTextBody(message);
          Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
      }
      catch(Exception e){
          system.debug('Email failed to send: ' + e.getMessage());
      }
  }

}