public with sharing class TimeLogDashboardController {
        
        public Time_Log__c thisTimeLog {get; set;}
        public LIST<Time_Log__c> theseTimeLogs = new LIST<Time_Log__c>();
        public LIST<Selectoption> requestOptions = new LIST<SelectOption>();
        public String currentStatus {get;}
        public String requestType {get; set;}
        public boolean isError {get; set;}
        public String errorMessage {get; set;}
        public String color {get; set;}
        public String ipAddress {get; set;}
                
        public TimeLogDashboardController() 
        {
                setThisTimeLog();
        }

        public void setIpAddress()      
        {
                if (Apexpages.currentPage().getHeaders().get('X-Salesforce-SIP') != null)
        ipAddress = Apexpages.currentPage().getHeaders().get('X-Salesforce-SIP');
        else if (Apexpages.currentPage().getHeaders().get('True-Client-IP') != null)
        ipAddress = Apexpages.currentPage().getHeaders().get('True-Client-IP');
        else ipAddress = 'IP UNKNOWN';
        }
        
        public String getIpAddress()
        {
                return ipAddress;
        }
        
        public void setThisTimeLog()
        {               
                String UserId = userinfo.getUserId();
                theseTimeLogs = [select VS_Employee__c, Time_Log_Date__c, 
                                                                SystemModstamp, Status__c, OwnerId, Name,
                                                                Lunch_Start__c, Lunch_Start_Time__c, Lunch_End__c, 
                                                                Lunch_End_Time__c, Logout__c, Logout_Time__c, Login__c, 
                                                                Login_Time__c, LastModifiedDate, LastModifiedById, IsDeleted, 
                                                                Id, Break_2_Start__c, Break_2_Start_Time__c, Break_2_End__c, 
                                                                Break_2_End_Time__c, Break_1_Start__c, Break_1_Start_Time__c, 
                                                                Break_1_End__c, Break_1_End_Time__c, Login_IP_Address__c, Logout_IP_Address__c 
                                                                From Time_Log__c 
                                                                where VS_Employee__c =: UserId AND Time_Log_Date__c =: system.today() limit 1];
                                                                
                if (theseTimeLogs.isEmpty())
                {
                        thisTimeLog = new Time_Log__c();
                        thisTimeLog.VS_Employee__c = userinfo.getuserId();
                        thisTimeLog.Time_Log_Date__c = system.today();
                        thisTimeLog.Status__c = 'Not Logged In';
                        color = 'red';
                }               
                else thisTimeLog = theseTimeLogs[0];            
                setIpAddress();         
        }
        
        public String getColor()
        {
                if (thisTimeLog.Status__c == 'Not Logged In') color = 'red';
                else if (thisTimeLog.Status__c == 'Logged In') color = 'green';
                else if (thisTimeLog.Status__c == 'At Break 1') color = 'yellow';
                else if (thisTimeLog.Status__c == 'At Break 2') color = 'yellow';
                else if (thisTimeLog.Status__c == 'At Lunch') color = 'yellow';
                else if (thisTimeLog.Status__c == 'Logged Out') color = 'red';
                return color;
        }
        
        public Time_Log__c getThisTimeLog()
        {
                return thisTimeLog; 
        }

        public LIST<Selectoption> getRequestOptions()
        {
                requestOptions.add(new Selectoption('Login/Logout', 'Login/Logout'));
                requestOptions.add(new Selectoption('Break 1', 'Break 1'));
                requestOptions.add(new Selectoption('Break 2', 'Break 2'));
                requestOptions.add(new Selectoption('Lunch', 'Lunch'));
                return requestOptions;
        }
        
        public String getRequestType()
        //------- Getter/Setter for requestType
        {
                return requestType; 
        }
        
        public void setRequestType (String thisRequest)
        {
                requestType = thisRequest;
        }       
                
        public void updateTimeLogIn()
        {
                setThisTimeLog();
                if (requestType == 'Login/Logout')
                {
                        if (thisTimeLog.Login__c == true)
                        {
                                isError = true;
                                errorMessage = 'Already Logged In';                             
                        }
                        else
                        {
                                isError = false;
                                thisTimeLog.Login__c = true;
                                thisTimeLog.Status__c = 'Logged In';
                                thisTimeLog.Login_IP_Address__c = ipAddress;
                                color = 'green';
                        }
                }
                if (requestType == 'Break 1')
                {
                        if (thisTimeLog.Break_1_Start__c == true)
                        {
                                isError = true;
                                errorMessage = 'Already Started Break 1';
                        }
                        else
                        {
                                isError = false;
                                thisTimeLog.Break_1_Start__c = true;
                                thisTimeLog.Status__c = 'At Break 1';
                                color = 'yellow';
                        }
                }
                if (requestType == 'Break 2')
                {
                        if (thisTimeLog.Break_2_Start__c == true)
                        {
                                isError = true;
                                errorMessage = 'Already Started Break 2';
                        }
                        else
                        {
                                isError = false;
                                thisTimeLog.Break_2_Start__c = true;
                                thisTimeLog.Status__c = 'At Break 2';
                                color = 'yellow';
                        }
                }  
                if (requestType == 'Lunch')
                {
                        if (thisTimeLog.Lunch_Start__c == true)
                        {
                                isError = true;
                                errorMessage = 'Already Started Lunch';
                        }
                        else
                        {
                                isError = false;
                                thisTimeLog.Lunch_Start__c = true;
                                thisTimeLog.Status__c = 'At Lunch';
                                color = 'yellow';
                        }
                } 
                upsert thisTimeLog;
                requestOptions.clear();
        }
        
        public void updateTimeLogOut()
        {
                if (requestType == 'Login/Logout')
                {
                        if (thisTimeLog.Logout__c == true)
                        {
                                isError = true;
                                errorMessage = 'Already Logged Out';
                        }
                        else
                        {
                                isError = false;
                                thisTimeLog.Status__c = 'Logged Out';
                                thisTimeLog.Logout__c = true;
                                color = 'red';
                                thisTimeLog.Logout_IP_Address__c = ipAddress;
                        }                       
                }
                if (requestType == 'Break 1')
                {                       
                        if (thisTimeLog.Break_1_End__c == true)
                        {
                                isError = true;
                                errorMessage = 'Already Ended Break 1';
                        }
                        else
                        {
                                isError = false;
                                thisTimeLog.Break_1_End__c = true;
                                thisTimeLog.Status__c = 'Logged In';
                                color = 'green';
                        }
                }
                if (requestType == 'Break 2')
                {
                        if (thisTimeLog.Break_2_End__c == true)
                        {
                                isError = true;
                                errorMessage = 'Already Ended Break 2';
                        }
                        else
                        {
                                isError = false;
                                thisTimeLog.Break_2_End__c = true;
                                thisTimeLog.Status__c = 'Logged In';
                                color = 'green';
                        }
                }  
                if (requestType == 'Lunch')
                {
                        if (thisTimeLog.Lunch_End__c == true)
                        {
                                isError = true;
                                errorMessage = 'Already Ended Lunch';
                        }
                        else
                        {
                                isError = false;
                                thisTimeLog.Lunch_End__c = true;
                                thisTimeLog.Status__c = 'Logged In';
                                color = 'green';
                        }
                } 
                upsert thisTimeLog;
                requestOptions.clear();
        }
        
        public String getCurrentStatus()
        {
                return thisTimeLog.Status__c;
        }
        
        
        
}