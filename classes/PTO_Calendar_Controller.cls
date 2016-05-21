public with sharing class PTO_Calendar_Controller {
        
        public LIST<SFDC_Paid_Time_Off__c> ptoRequests {get; set;}
        public String selectedDepartment{get; set;}
        public String departmentString {get; set;}
        public String managerString {get; set;}
        public LIST<SelectOption> requestOptions = new LIST<SelectOption>();
        public LIST<SelectOption> requestOptionsB = new LIST<SelectOption>();
        
        
        
        public PTO_Calendar_Controller()        
        {
                departmentString = 'All Departments';
                managerString = 'All Managers';
                setptoRequests();       
                        
        }
        
        public Pagereference returnHome()
        {
                
                return new PageReference('/home/home.jsp');
        }
        
        public Pagereference PTOobjrctPage()
        {
        
                return new PageReference('/a0Q/o');     
                
        }
        
        public void setptoRequests()
        {
                
                Date lDate = date.today();
                lDate = lDate.addDays(-15);
                Datetime dt = datetime.newInstance(lDate.year(), lDate.month(),lDate.day());
                String ptoRequestQuery = 'Select Type__c, Total_Days_Requested__c, To_Date__c, Time_Off_Balance__c, SystemModstamp, Request_Type__c, Notes__c, Name, Manager_Email_Address__c,'; 
                ptoRequestQuery += 'LastModifiedDate, LastModifiedById, LastActivityDate, IsDeleted, Id, Hours_to_be_Used__c,';
                ptoRequestQuery += 'Help_Information__c, From_Date__c, Exclude_Weekends__c, Employee_s_Name__c, Employee_Role__c,'; 
                ptoRequestQuery += 'Employee_Notes__c, Description__c, Approving_Manager__c, Approval_Status__c,'; 
                ptoRequestQuery += 'Employee_s_Name__r.Name, Employee_s_Name__r.Department '; 
                ptoRequestQuery += 'From SFDC_Paid_Time_Off__c where ';
                ptoRequestQuery += '(Approval_Status__c = \'Awaiting Manager Approval\' OR Approval_Status__c = \'Approved\')';
                ptoRequestQuery += 'AND To_Date__c > :dt';
                
                //add an if statement here to only go off the manager
                if (departmentString != 'All Departments')
                {
                        ptoRequestQuery += ' AND Employee_s_Name__r.Department = \'' + departmentString + '\'';
                }       else  {
                
                
                if (managerString != 'All Managers')
                {
                        
                        ptoRequestQuery += ' AND Approving_Manager__c = \'' + managerString + '\'';
                        
                }
                }
                //Added by ProCore 6/16/12 for debugging
               	//ptoRequestQuery += ' AND Approving_Manager__c != \'Kevin Broderick\'';
        		ptoRequestQuery += ' ORDER BY From_Date__c asc';
        		//ptoRequestQuery += 'AND Id != \'a0Q70000008Dzey\'';
        		
                
                ptoRequests = Database.query(ptoRequestQuery); 
                system.debug(ptoRequestQuery);
                
        }
        
        public LIST<SelectOption> getRequestOptions()
        {
                requestOptions = new LIST<SelectOption>();        
                //Commented by Procore 6/16/2012 for bulkified aggregateresult
                /*
                LIST<User> userList= [select Id, Department, IsActive, IsPortalEnabled from User where IsActive = true AND IsPortalEnabled = false];              
                LIST<String> uniqueDepartments = new LIST<String>();
                MAP<String, String> departmentMap = new MAP<String, String>();
                        
                for (User user: userList)
                {
                        if (user.Department != null)
                        {
                                departmentMap.put(user.Department, user.Department);    
                        }                                               
                }
                uniqueDepartments = departmentMap.values();
                
                requestOptions.add(new SelectOption('All Departments', 'All Departments'));
                
                for (String department: uniqueDepartments)
                {
                        requestOptions.add(new SelectOption(department, department));
                }                       
                */
                
                requestOptions.add(new SelectOption('All Departments', 'All Departments'));
                List<AggregateResult> arDepts = [SELECT department department 
                                                                                        FROM User
                                                                                        WHERE isActive = true
                                                                                        AND isPortalEnabled = false
                                                                                        AND department != null
                                                                                        GROUP BY department];
                
                for(AggregateResult ar : arDepts){
                        requestOptions.add(new SelectOption(string.valueOf(ar.get('department')), string.valueOf(ar.get('department'))));
                }
                return requestOptions;
        }
        
        public LIST<SelectOption> getRequestOptionsB()
        {
                requestOptionsB = new LIST<SelectOption>();
                //Commented by Procore 6/16/2012 for bulkified aggregateresult
                /*
                LIST<User> userList= [select Id, firstName, lastName, Department, IsActive, managerId, IsPortalEnabled from User where IsActive = true AND IsPortalEnabled = false AND managerId != null];
                MAP<String, String> managerMap = new MAP<String, String>();
                LIST<String> managerList = new LIST<String>();
                
                
                String mName = '';

                for (User userO: userList)
                {

                        for (User userI: userList)
                        {

                                if (userO.id == userI.managerId)
                                {
                                        mName = userO.firstName + ' ' + userO.lastName;
                                                                
                                        managerMap.put( mName, mName);

                                }
        
                        }
        
                
                }
                requestOptionsB.add(new SelectOption('All Managers', 'All Managers'));

                for (string manOut: managerMap.keySet())
                {

                        requestOptionsB.add(new SelectOption(manOut, manOut));
        
                }
                */
                requestOptionsB.add(new SelectOption('All Managers', 'All Managers'));
                List<AggregateResult> arManagers = [SELECT Manager.Name managerName
                                                                                        FROM User 
                                                                                        WHERE IsActive = true 
                                                                                        AND IsPortalEnabled = false 
                                                                                        AND managerId != null
                                                                                        GROUP BY Manager.Name];
                for(AggregateResult ar : arManagers){
                        requestOptionsB.add(new SelectOption(string.valueOf(ar.get('managerName')), string.valueOf(ar.get('managerName'))));
                }
                return requestOptionsB;
        }
        
        
        /*
        public LIST<SFDC_Paid_Time_Off__c> getptoRequests()
        {
                return ptoRequests;
        }
        */


}