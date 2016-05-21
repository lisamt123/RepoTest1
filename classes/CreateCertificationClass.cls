public with sharing class CreateCertificationClass {
	
	public static void CreateCertification(List<Id> cntctList)
	{
		List<String> specTrainList = new List<String>();
		List<Certification__c> insertCerts = new List<Certification__c>();
		list<Contact> ucList = new list<Contact>();
		
		Contact tcontact;
		Integer saleComp = 0;
		Integer ManagerComp = 0;
		Integer bdcComp = 0;
		Integer fmComp = 0;
		Integer idComp = 0; //Internet Director
		//Integer isComp = 0; //Internet Salesman REMOVED FROM Level_of_Certification__c
		Integer iwsComp = 0; //Inventory & Website Specialist
		/*Integer maComp = 0; //Master Admin
		Integer orComp = 0; //Operator/Receptionist
		Integer sdComp = 0; //Service Director
		Integer swComp = 0; //Service Writer
		Integer crmComp = 0; //CRM Sales Manager */
		String tests;
		string cIssued;
		
		system.debug('Inside CreateCertification: ' + cntctList);
		//build a map of all the certifications for the contacts in the trigger, the key is the contact id
		MAP<Id, Contact> contactCertMap = new MAP<Id, Contact>([Select Id, Certifications_Issued__c From Contact where id in : cntctList ]);
		
		//build a map of all the time cards associated with contacts in this trigger (or in the thisCont list) 
		MAP<Id, SFDC_Service_Timecard__c> ClassList = new MAP<Id, SFDC_Service_Timecard__c>([Select s.Id, s.Contact__c, s.Class__c, s.Class_Status__c, s.Class_Number__c, s.Access_Level__c From SFDC_Service_Timecard__c s where s.Contact__c  in : cntctList]);
		
		for (Contact cmp : contactCertMap.values() )
		{
			system.debug(cmp.id + 'Has these certs: ' + cmp.Certifications_Issued__c);
		}
		for (SFDC_Service_Timecard__c cmd : ClassList.values() )
		{
			system.debug(cmd.Contact__c + 'Has taken these classes: ' + cmd.Class__c);
		}
		
		
		
		//begin main loop
		for(Id lId : cntctList)
		
		{
					//loop through the timecard map values and build a list of time cards for the current contact
					for(SFDC_Service_Timecard__c tcLoop : ClassList.values())
					{
						//add the class for the timecard to a list to check against, if the user completed it
						if ((lId == tcloop.Contact__c) && (tcloop.Class_Status__c == 'Completed' || tcloop.Class_Status__c == 'Waitlisted and Completed'))
						{
						specTrainList.add(tcloop.Class__c);
						}
						system.debug('Here are the classes this contact:' + lId + ', has completed: ' + specTrainList);
					}
					
					//loop through the list of classes specific to this contact and add up all the classes they have taken
					for(String chkLoop : specTrainList)
					
					{	
						
							if(chkLoop == 'Sales Consultant Level 1' || chkLoop == 'Recorded: Salesperson Level 1') 
							{
								saleComp = saleComp + 1;
								ManagerComp = ManagerComp + 1;
								bdcComp = bdcComp + 1;
								system.debug('+1 ADDED TO SCORE!');
							}
							if(chkLoop == 'Sales Consultant Level 2' || chkLoop == 'Recorded: Salesperson Level 2') 
							{
								saleComp = saleComp + 2;
								ManagerComp = ManagerComp + 2;
								bdcComp = bdcComp + 2;
								system.debug('+2 ADDED TO SCORE!');
							}
							if(chkLoop == 'Sales Consultant Level 3' || chkLoop == 'Recorded: Salesperson Level 3')
							{
								saleComp = saleComp + 3;
								ManagerComp = ManagerComp + 3;
								bdcComp = bdcComp + 3;
								system.debug('+3 ADDED TO SCORE!');
							}
							/*if(chkLoop == 'Distribution AKA Bulk Mail')
							{
								saleComp = saleComp + 4;
								ManagerComp = ManagerComp + 4;
								bdcComp = bdcComp + 4;
								system.debug('+4 ADDED TO SCORE!');
							}*/
									
							/*if(chkLoop == 'Mobile MotoSnap') 
							{
								saleComp = saleComp +5;
								ManagerComp = ManagerComp + 5;
								bdcComp = bdcComp + 5;
								system.debug('+5 ADDED TO SCORE!');
							}
							if(chkLoop == 'Basic ILM Overview') 
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}							
							
							if(chkLoop == 'BDC Training') 
							{
								saleComp = saleComp +5;
								ManagerComp = ManagerComp + 5;
								bdcComp = bdcComp + 5;
								system.debug('+5 ADDED TO SCORE!');
							}
							if(chkLoop == 'ILM/CRM Reporting')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Inventory Tool Training')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							
							if(chkLoop == 'Beginner Admin 1')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							
							if(chkLoop == 'Website Monitoring')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Admin Website Custom Content/Forms')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Admin Website Management')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'VinCamera')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Manager 1 Training')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Advanced Desking & Trade Appraisal')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'ILM/CRM Reporting')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Service Dashboard & Scheduler')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Admin Templates Building')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Admin Lead Assignment')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Admin Activity Alerts')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Operator’s Panel')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Admin 1')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Admin 2')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}
							if(chkLoop == 'Website Basics')
							{
								saleComp = saleComp + 6;
								ManagerComp = ManagerComp + 6;
								bdcComp = bdcComp +6;
								system.debug('+6 ADDED TO SCORE!');
							}*/
							
							
					}
					
					system.debug(lId + ' - Salesman score: ' + saleComp);
					system.debug(lId + ' - Manager score: ' + ManagerComp);
					system.debug(lId + ' - BDC score: ' + bdcComp);
					system.debug(lId + ' - Finance Manager score: ' + fmComp);
					system.debug(lId + ' - Inventory & Website Specialist: ' + iwsComp);
					
					//get the certs issued for this user and test to see if they currently have any of them
					if(contactCertMap.get(lId).Certifications_Issued__c != null)
					{
						tests = contactCertMap.get(lId).Certifications_Issued__c;
						
						//
						if (saleComp == 6)
						{
							if(!tests.contains('Salesman'))
							{
								contactCertMap.get(lId).Certifications_Issued__c = tests + ';Salesman';
								Certification__c salesCert = new Certification__c();
								salesCert.Contact__c = lId;
								salesCert.Set_By_Trigger__c = true;
								salesCert.Certification_Date__c = system.today();
								salesCert.Level_of_Certification__c = 'Salesman';
								insertCerts.add(salesCert);
								system.debug('Salesman certification created for: ' + lId);
								
							}
						}
						
						//if (ManagerComp == 21) changing because code was commented out above which
						//makes this number impossible to obtain
						if (ManagerComp == 6)
						{
							if(!tests.contains('Sales Manager'))
							{
								contactCertMap.get(lId).Certifications_Issued__c = tests + ';Sales Manager';
								Certification__c managerCert = new Certification__c();
								managerCert.Contact__c = lId;
								managerCert.Set_By_Trigger__c = true;
								managerCert.Certification_Date__c = system.today();
								managerCert.Level_of_Certification__c = 'Sales Manager';
								insertCerts.add(ManagerCert);
								system.debug('Sales Manager certification created for: ' + lId);
								
							}
							
						}
						
						/*//commenting out because code was commented out above which makes this number impossible to obtain
						if (bdcComp == 21 ) 
						{
							if(!tests.contains('BD Agent'))
							{
								contactCertMap.get(lId).Certifications_Issued__c = tests + ';BD Agent';
								Certification__c bdcCert = new Certification__c();
								bdcCert.Contact__c = lId;
								bdcCert.Set_By_Trigger__c = true;
								bdcCert.Certification_Date__c = system.today();
								bdcCert.Level_of_Certification__c = 'BD Agent';
								insertCerts.add(bdcCert);
								system.debug('BD Agent certification created for: ' + lId);
								
							}
							
							if (fmComp == 12)
							{
								if(!tests.contains('Finance Manager'))
								{
									contactCertMap.get(lID).Certifications_Issued__c = tests + ';Finance Manager';
									Certification__c fmCert = new Certification__c();
									fmCert.Contact__c = lId;
									fmCert.Set_By_Trigger__c = true;
									fmCert.Certification_Date__c = system.today();
									fmCert.Level_of_Certification__c = 'Finance Manager';
									insertCerts.add(fmCert);
									system.debug('Finance Manager certification created for: ' + lId);
								}
							}
							
							if(iwsComp == 36)
							{
								if(tests.contains('Inventory & Website Specialist'))
								{
									contactCertMap.get(lId).Certifications_issued__c = tests + ';Inventory & Website Specialist';
									Certification__c iwsCert = new Certification__c();
									iwsCert.Contact__c = lId;
									iwsCert.Set_By_Trigger__c = true;
									iwsCert.Certification_Date__c = system.today();
									iwsCert.Level_of_Certification__c = 'Inventory & Website Specialist';
									insertCerts.add(iwsCert);
									system.debug('Inventory & Website certification created for: ' + lId);
								}
							}
							
						}*/
					
					} else {
						
						if (saleComp == 6)
						
						{	
								contactCertMap.get(lId).Certifications_Issued__c = 'Salesman';
								Certification__c salesCert = new Certification__c();
								salesCert.Contact__c = lId;
								salesCert.Set_By_Trigger__c = true;
								salesCert.Certification_Date__c = system.today();
								salesCert.Level_of_Certification__c = 'Salesman';
								insertCerts.add(salesCert);
								system.debug('Salesman certification created for: ' + lId);
						}
						
						//if (ManagerComp == 21) changing because code was commented out above which
						//makes this number impossible to obtain
						if (ManagerComp == 6)
						{
							
								contactCertMap.get(lId).Certifications_Issued__c = 'Sales Manager';
								Certification__c managerCert = new Certification__c();
								managerCert.Contact__c = lId;
								managerCert.Set_By_Trigger__c = true;
								managerCert.Certification_Date__c = system.today();
								managerCert.Level_of_Certification__c = 'Sales Manager';
								insertCerts.add(ManagerCert);
								system.debug('Sales Manager certification created for: ' + lId);
							
						}
						
						//if (bdcComp == 21 ) changing because code was commented out above which
						//makes this number impossible to obtain
						if (bdcComp == 6)
						{
								contactCertMap.get(lId).Certifications_Issued__c = 'BD Agent';
								Certification__c bdcCert = new Certification__c();
								bdcCert.Contact__c = lId;
								bdcCert.Set_By_Trigger__c = true;
								bdcCert.Certification_Date__c = system.today();
								bdcCert.Level_of_Certification__c = 'BD Agent';
								insertCerts.add(bdcCert);
								system.debug('BD Agent certification created for: ' + lId);
							
						}	
						/*//commenting out because code was commented out above which makes this number impossible to obtain
						if (fmComp == 12)
						{
									contactCertMap.get(lID).Certifications_Issued__c = tests + ';Finance Manager';
									Certification__c fmCert = new Certification__c();
									fmCert.Contact__c = lId;
									fmCert.Set_By_Trigger__c = true;
									fmCert.Certification_Date__c = system.today();
									fmCert.Level_of_Certification__c = 'Finance Manager';
									insertCerts.add(fmCert);
									system.debug('Finance Manager certification created for; ' + lId);
						}	
						
						if (iwsComp == 36)
						{
									contactCertMap.get(lId).Certifications_issued__c = tests + ';Inventory & Website Specialist';
									Certification__c iwsCert = new Certification__c();
									iwsCert.Contact__c = lId;
									iwsCert.Set_By_Trigger__c = true;
									iwsCert.Certification_Date__c = system.today();
									iwsCert.Level_of_Certification__c = 'Inventory & Website Specialist';
									insertCerts.add(iwsCert);
									system.debug('Inventory & Website certification created for: ' + lId);
						}*/
									
						
					}
					
	saleComp = 0;
	ManagerComp = 0;
	bdcComp = 0;
	fmComp = 0;
	iwsComp = 0;
	specTrainList.clear();
	//insertCerts.clear();
	
	}  //end main loop
	
	//build a list using the values from the contact map
	ucList = contactCertMap.values();
	update ucList;	

	//insert the list of new certifications	
	if(insertCerts != null)
					
		{
			insert insertCerts;
		}
				
	
		
	}
}