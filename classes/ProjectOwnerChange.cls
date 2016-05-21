public class ProjectOwnerChange{
	
	public static void updatePacketSent(SFDC_520_Quote__c p, SFDC_520_Quote__c oldProject, Project_Piece__c[] projectPieceList, Task[] taskList, 
	string TM, string TMemail, string TA, string TAemail, string TF, string TFemail, string PS, string PSemail)
	//public static void updatePacketSent(SFDC_520_Quote__c p, SFDC_520_Quote__c oldProject, Project_Piece__c[] projectPieceList, Task[] taskList)
	{
		/*string TM=null;
		string TMemail=null;
		string TF=null;
		string TFemail=null;
		string TA=null;
		string TAemail=null;
		string PS=null;
		string PSemail=null;
				
		for(User U :[SELECT Id,Email,Manager_of_Training__c,In_charge_of_Printing_Shipping__c,
		Travel_Financer__c,Travel_Arranger__c from User where Manager_of_Training__c=True 
		OR Travel_Financer__c=True OR Travel_Arranger__c=True OR In_charge_of_Printing_Shipping__c=True])
		{
			if(U.Manager_of_Training__c==TRUE)
			{
				TM = U.id;
				TMemail = U.Email;
			}
			if(U.Travel_Arranger__c==TRUE)
			{
				TA = U.id;
				TAemail = U.Email;
			}
			if(U.Travel_Financer__c==TRUE)
			{
				TF = U.id;
				TFemail = U.Email;
				
			}
			if(U.In_charge_of_Printing_Shipping__c==TRUE)
			{
				PS = U.id;
				PSemail = U.Email;
			}
		}
		*/
		
		//if(TM==null)TM = p.OwnerId;
		//if(TF==null)TF = p.OwnerId;
		//if(TA==null)TA = p.OwnerId;
		//if(PS==null)PS = p.OwnerId;				 
			
			if(oldProject.OwnerId!=P.OwnerId)
			{
				LIST<Project_Piece__c> projPieceOwner = new LIST<Project_Piece__c>();
				LIST<Task> taskOwner = new LIST<Task>();
								
				for(Project_Piece__c PrP:projectPieceList)
				{
					if(PrP.Project__c==p.Id&&Prp.OwnerId==oldProject.OwnerId)
					{
						for(Task tL: taskList)
						{
							if(tL.WhatId==PrP.Id&&tL.OwnerId==oldProject.OwnerId)
							{
								tL.OwnerId = p.OwnerId;
								taskOwner.add(tL);
							}
						}
						PrP.OwnerId = p.OwnerId;
						projPieceOwner.add(PrP);
					}
				}
				update projPieceOwner;
				update taskOwner;
				
				
				
				/*MAP<Id, Project_Piece__c> projectPiecesWithTasks = new MAP<Id, Project_Piece__c>();
				
				List<Project_Piece__c> updatePieceOwner = new List<Project_Piece__c>();
								
				for(Project_Piece__c Pieces : [select id, Project_Piece_Stage__c, ownerid from Project_Piece__c 
				where project__c = :P.Id and ownerid=:oldProject.OwnerId and Project_Piece_Stage__c != 'Completed'])
				{
					projectPiecesWithTasks.put(Pieces.Id, Pieces);
					
					Pieces.OwnerId = P.OwnerId;
					updatePieceOwner.add(Pieces);
				}
				update updatePieceOwner;
								
				List<Task> tsk = new List<Task>();
					
				for(Task t:[select id, OwnerId, Status from Task where WhatId in: projectPiecesWithTasks.keyset() and OwnerId =:oldProject.OwnerId and status!='Completed'])
				{
					t.OwnerId = p.OwnerId;
					tsk.add(t);
				}
					
				update tsk;		*/	
				
			}
		
//================================TRAINING PROCESS=====================================================
			
			if(P.Training_Included__c==TRUE)
			{
				LIST<Task> createTasks = new LIST<Task>();
				
				/*if(P.Total_number_of_users__c!=null&&oldProject.Total_number_of_users__c==null)
				{
										
					Project_Piece__c PrintManuals = new Project_Piece__c();
					PrintManuals.Project__c = P.Id;
					PrintManuals.Name = 'PP-Training Manuals';
					PrintManuals.Piece_Issue__c = 'Training Manuals';
					PrintManuals.OwnerId = PS;
					PrintManuals.Account__c = P.Account__c;
					PrintManuals.Project_Piece_Stage__c = 'Printing/Shipping/Uploading';
					PrintManuals.Product_Process__c = 'a0O70000001IUmV';
					PrintManuals.RecordTypeId = '01270000000Q4V2';
					PrintManuals.Piece_Issue_Description__c = p.Total_number_of_users__c;
					insert PrintManuals;
					
					Shipment__c shpmnt = new Shipment__c();
					shpmnt.Name = PrintManuals.Name;
					shpmnt.Project_Piece__c = PrintManuals.Id;
					insert shpmnt;
					
					String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
					String[] toAddresses = new String[]{PSemail};
					Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
					email.setToAddresses(toAddresses);
					email.setWhatId(p.Id);
					email.setSubject('Build Training Manuals'+p.Name); 
					email.setSenderDisplayName('VinSupport/Training');
			        email.setBccSender(false);
			        email.setUseSignature(false);
			        String msg = 'Training Manuals need to be built for '+p.Name+'.<br><br>Click the link below to view the Project.  <br><br>' + fullURL +P.Id; 
			        email.setHtmlBody(msg);
					Messaging.sendEmail(new Messaging.Email[] { email } , TRUE);
					
				}     */
				//TTTTT
				string regionalid = p.OwnerId;
				string DDMid = p.OwnerId;
				string accountManagerId = p.OwnerId;
				
				if(p.Account_Manager_ID__c!=null)accountManagerId = p.Account_Manager_ID__c;
				if(p.Regional_ID__c!=null)regionalid = p.Regional_ID__c;
				//if(p.DDM_ID__c!=null)DDMid = p.DDM_ID__c;	
				
				//Trainer 1 notification
				
				if(P.Trainer__c!=null&&oldProject.Trainer__c==null)
				{
					string Uemail;
					
					for(User U :[SELECT Id, Email from User where Id=:P.Trainer__c])
					{
							Uemail = U.Email;
					}
					String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
					String[] toAddresses = new String[]{Uemail};
					Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
					email.setToAddresses(toAddresses);
					email.setWhatId(p.Id);
					email.setSubject('You have been assigned as the lead trainer on an Implementation Project'); 
					email.setSenderDisplayName('VinSupport/Training');
			        email.setBccSender(false);
			        email.setUseSignature(false);
			        String msg = 'You have been assigned as the Lead Trainer on the following Implementation Project.<br><br>Click the link below to view the Project.  <br><br>' + fullURL +P.Id; 
			        email.setHtmlBody(msg);
					Messaging.sendEmail(new Messaging.Email[] { email } , TRUE);	
				}
				
				//Trainers 2-4 notification
				if(P.Trainer_2__c!=null&&oldProject.Trainer_2__c==null)
				{	
					string Uemail;
					
					for(User U :[SELECT Id, Email from User where Id=:P.Trainer_2__c])
					{
							Uemail = U.Email;
					}
					String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
					String[] toAddresses = new String[]{Uemail};
					Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
					email.setToAddresses(toAddresses);
					email.setWhatId(p.Id);
					email.setSubject('You have been assigned as the 2nd trainer on an Implementation Project'); 
					email.setSenderDisplayName('VinSupport/Training');
			        email.setBccSender(false);
			        email.setUseSignature(false);
			        String msg = 'You have been assigned as Trainer 2 on the following Implementation Project.<br><br>Click the link below to view the Project.  <br><br>' + fullURL +P.Id; 
			        email.setHtmlBody(msg);
					Messaging.sendEmail(new Messaging.Email[] { email } , TRUE);	
				}
				if(P.Trainer_3__c!=null&&oldProject.Trainer_3__c==null)
				{
					string Uemail;
					
					for(User U :[SELECT Id, Email from User where Id=:P.Trainer_3__c])
					{
							Uemail = U.Email;
					}
					String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
					String[] toAddresses = new String[]{Uemail};
					Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
					email.setToAddresses(toAddresses);
					email.setWhatId(p.Id);
					email.setSubject('You have been assigned as the 3rd trainer on an Implementation Project'); 
					email.setSenderDisplayName('VinSupport/Training');
			        email.setBccSender(false);
			        email.setUseSignature(false);
			        String msg = 'You have been assigned as Trainer 3 on the following Implementation Project.<br><br>Click the link below to view the Project.  <br><br>' + fullURL +P.Id; 
			        email.setHtmlBody(msg);
					Messaging.sendEmail(new Messaging.Email[] { email } , TRUE);	
				}
				if(P.Trainer_4__c!=null&&oldProject.Trainer_4__c==null)
				{
					string Uemail;
					
					for(User U :[SELECT Id, Email from User where Id=:P.Trainer_4__c])
					{
							Uemail = U.Email;
					}
					String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
					String[] toAddresses = new String[]{Uemail};
					Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
					email.setToAddresses(toAddresses);
					email.setWhatId(p.Id);
					email.setSubject('You have been assigned as the 4th trainer on an Implementation Project'); 
					email.setSenderDisplayName('VinSupport/Training');
			        email.setBccSender(false);
			        email.setUseSignature(false);
			        String msg = 'You have been assigned as Trainer 4 on the following Implementation Project.<br><br>Click the link below to view the Project.  <br><br>' + fullURL +P.Id; 
			        email.setHtmlBody(msg);
					Messaging.sendEmail(new Messaging.Email[] { email } , TRUE);		
				}
				
				
				
				//Jim's 1st tasks are saved as WFT that will be generated after the button is hit
				//Stage 1 (Set & Assign)
				//---Generate Milestone 1 Requirements (Start Process)---
				
				//===Close Dates Proposed
				if(p.Proposed_Training_Start__c!=null&&oldProject.Proposed_Training_Start__c==null
					&&p.Proposed_Training_End__c!=null&&oldproject.Proposed_Training_End__c==null)
				{
					List<Task> CloseTasks = new List<Task>();
					
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and Status!='Completed']) 
					{
						string sub = t.Subject.tolowercase();
						if(sub.contains('propose training dates'))
						{
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
				
						CloseTasks.add(t);
						}
					}		

					update CloseTasks;
					
					
				}
				//===Close Trainer Assigned
				if(p.Trainer__c!=null&&oldProject.Trainer__c==null)
				{
					List<Task> CloseTasks = new List<Task>();
					
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and Status!='Completed']) 
					{
						string sub = t.Subject.tolowercase();
						if(sub.contains('assign a trainer'))
						{
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
						
						CloseTasks.add(t);
						}
					}		
				
					update CloseTasks;
				}
				if((oldProject.Confirmed_Training_Start__c!=null&&p.Trainer__c!=null&&oldproject.Trainer__c==null)
				||(oldProject.Trainer__c!=null&&p.Confirmed_Training_Start__c!=null&oldProject.Confirmed_Training_Start__c==null)
				||(p.Confirmed_Training_Start__c!=null&&oldProject.Confirmed_Training_Start__c==null&&p.Trainer__c!=null&&oldproject.Trainer__c==null))
				{
					//Trainer Tasks
					Task t1 = new Task();
					t1.subject = 'WFT - Training Coordinated - Complete Agenda';
					t1.WhatId = p.Id;
					t1.OwnerId = p.Trainer__c;
					t1.Description = 'Complete the training agenda';
					t1.ActivityDate = system.Today()+3;
					t1.Type = 'Task';
					createTasks.add(t1);//insert t1;
					
					Task t2 = new Task();
					t2.subject = 'WFT - Training Coordinated - Send Intro Letter, User List, and Agenda';
					t2.WhatId = p.Id;
					t2.OwnerId = p.Trainer__c;
					t2.Description = 'Review any unclear data to avoid confusion.';
					t2.ActivityDate = system.Today()+4;
					t2.Type = 'Task';
					createTasks.add(t2);//insert t2;
					
					Task t3 = new Task();
					t3.subject = 'WFT - Training Coordinated - Test all purchased Integrations';
					t3.WhatId = p.Id;
					t3.OwnerId = p.Trainer__c;
					t3.Description = 'AIS/DT/Route One/DMS Push/700 CR/';
					t3.ActivityDate = system.Today()+14;
					t3.Type = 'Task';
					createTasks.add(t3);//insert t3;
					
					
				}
				if(
				p.Proposed_Training_Start__c!=null
				&&p.Proposed_Training_End__c!=null
				&&p.Trainer__c!=null
				&&p.Date_Packet_Ret_d__c!=null
				&&p.Date_Graphics_Obtained__c!=null
				&&
				(oldProject.Proposed_Training_Start__c==null
				||oldProject.Proposed_Training_End__c==null
				||oldProject.Trainer__c==null
				||oldProject.Date_Packet_Ret_d__c==null
				||oldProject.Date_Graphics_Obtained__c==null)
				)
				/*if((oldProject.Proposed_Training_Start__c!=null&&p.Trainer__c!=null&&oldproject.Trainer__c==null&&p.Date_Packet_Ret_d__c!=null)
				||(oldProject.Trainer__c!=null&&p.Proposed_Training_Start__c!=null&oldProject.Proposed_Training_Start__c==null&&p.Date_Packet_Ret_d__c!=null)
				||(oldProject.Date_Packet_Ret_d__c==null&&p.Date_Packet_Ret_d__c!=null&&p.Proposed_Training_Start__c!=null&&p.Trainer__c!=null)
				||(p.Proposed_Training_Start__c!=null&&oldProject.Proposed_Training_Start__c==null&&p.Trainer__c!=null&&oldproject.Trainer__c==null&&oldProject.Date_Packet_Ret_d__c==null&&p.Date_Packet_Ret_d__c!=null))*/
				{
					//DDM Tasks (was previously assigned to the Regional)
					
					
					/*Task r1 = new Task();
					r1.subject = 'WFT - Training Dates Confirmed - Contact Client and Confirm Training Dates ';
					r1.WhatId = p.Id;
					r1.OwnerId = DDMid;
					r1.Description = 'Confirm tenative dates, arrange acceptable dates, and/or sell additional training days ';
					r1.ActivityDate = system.Today()+1;
					r1.Type = 'Task';
					//createTasks.add(r1);//insert r1;
					
					Task r2 = new Task();
					r2.subject = 'WFT - Training Dates Confirmed - Update Confirmed Training Dates on Project';
					r2.WhatId = p.Id;
					r2.OwnerId = DDMid;
					r2.Description = 'If the confirmed training dates are different from the proposed training dates, enter the confirmed training dates in the Confirmed Training Start/End fields on the project and check the box \"Training Dates Confirmed\".  If the confirmed dates match the proposed dates, you may leave the confirmed date fields blank and simply check the box (the dates will automatically populate into the confirmed dates field).';
					r2.ActivityDate = system.Today()+1;
					r2.Type = 'Task';
					//createTasks.add(r2);//insert r2;*/
				}
				insert createTasks;
				createTasks.clear();
				
	       	 	//Stage 2A (Training Dates Confirmed -- Assign Travel Tasks)
	       	 	//Milestone 2 Requirements
	       	 	if(p.Training_Dates_Confirmed__c==TRUE && oldProject.Training_Dates_Confirmed__c==False)
				{
					//Close the DDM's open tasks related to this project as they should all be done once this is checked (were previously assigned to the regional)
					List<Task> CloseTasks = new List<Task>();
					
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:DDMid and Status!='Completed']) 
					{
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
						
						CloseTasks.add(t);
					}
					update CloseTasks;
					
					//Pop over the dates if they are blank
					if(p.Confirmed_Training_Start__c==null)
					{
						p.Confirmed_Training_Start__c = p.Proposed_Training_Start__c;
					}
					if(p.Confirmed_Training_End__c==null)
					{
						p.Confirmed_Training_End__c = p.Proposed_Training_End__c;
					}
					
					p.Training_Stage__c='Preparation';
					
					//Propose Travel
					string travelSubject1 = 'WFT - Travel Proposed - Work Up Potential Flights';
					string travelSubject1b = '.  <br><br>Please find and propose potential flight arrangements for the scheduled training.';
					
					string travelSubject2 = 'WFT - Travel Proposed - Work Up Potential Hotel';
					string travelSubject2b = '.  <br><br>Please find and propose potential hotel arrangements for the scheduled training.';
					
					string travelSubject3 = 'WFT - Travel Proposed - Work Up Potential Rental Car';
					string travelSubject3b = '.  <br><br>Please find and propose potential rental car arrangements for the scheduled training.';
					
					if(p.Training_Expenses_Paid_by_Dealer__c==True)
					{
						travelSubject1 = 'WFT - Travel Proposed - Work Up Potential Flights - DEALER PAID';
						travelSubject1b = '.  <br><br>Please find and propose (to the Dealer) potential flight arrangements for the scheduled training.';
					
						travelSubject2 = 'WFT - Travel Proposed - Work Up Potential Hotel - DEALER PAID';
						travelSubject2b = '.  <br><br>Please find and propose (to the Dealer) potential hotel arrangements for the scheduled training.';
						
						travelSubject3 = 'WFT - Travel Proposed - Work Up Potential Rental Car - DEALER PAID';
						travelSubject3b = '.  <br><br>Please find and propose (to the Dealer) potential rental car arrangements for the scheduled training.';
					}
					
					Task r1 = new Task();
					r1.subject = travelSubject1;
					r1.WhatId = p.Id;
					r1.OwnerId = TA;
					r1.Description = 'Training has been scheduled for '+p.Name+' from '+p.Confirmed_Training_Start__c+' to '+p.Confirmed_Training_End__c+travelSubject1b;
					r1.ActivityDate = system.Today()+5;
					r1.Type = 'Task';
					createTasks.add(r1);//insert r1;
					
					Task r2 = new Task();
					r2.subject = travelSubject2;
					r2.WhatId = p.Id;
					r2.OwnerId = TA;
					r2.Description = 'Training has been scheduled for '+p.Name+' from '+p.Confirmed_Training_Start__c+' to '+p.Confirmed_Training_End__c+travelSubject2b;
					r2.ActivityDate = system.Today()+5;
					r2.Type = 'Task';
					createTasks.add(r2);//insert r2;
					
					Task r3 = new Task();
					r3.subject = travelSubject3;
					r3.WhatId = p.Id;
					r3.OwnerId = TA;
					r3.Description = 'Training has been scheduled for '+p.Name+' from '+p.Confirmed_Training_Start__c+' to '+p.Confirmed_Training_End__c+travelSubject3b;
					r3.ActivityDate = system.Today()+5;
					r3.Type = 'Task';
					createTasks.add(r3);//insert r3;
					
	       	 	}
	       	 	//insert createTasks;
				createTasks.clear();
	       	 	
	       	 	//Stage 2B (Training Preparation Complete  )
	       	 	//Close Trainer's remaining open tasks
	       	 	if(p.Training_Coordinated__c!=null && oldProject.Training_Coordinated__c==null)
				{
					List<Task> CloseTasks = new List<Task>();
					
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:p.Trainer__c and Status!='Completed']) 
					{
						string sub = t.Subject.tolowercase();
						if(sub.contains('training coordinated '))
						{
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
						
						CloseTasks.add(t);
						}
					}
					update CloseTasks;
						
	       	 	}
	       	 	
	       	 	 
	       	 	//Stage 3 (Approve Proposed Travel)
	       	 	//Milestone 3 Requirements
	       	 	if(p.Travel_Proposed__c!=null && oldProject.Travel_Proposed__c==null)
				{	
					//Close Karen's tasks
					List<Task> CloseTasks = new List<Task>();
					
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:TA and Status!='Completed']) 
					{
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
						
						CloseTasks.add(t);
					}
					update CloseTasks;
					
					string approvalTrainer = p.OwnerId;
					if(p.Trainer__c!=null) approvalTrainer = p.Trainer__c;
					
					//Trainer Approve
					Task a1 = new Task();
					a1.subject = 'WFT - Approve Travel - Approve Travel Arrangements';
					a1.WhatId = p.Id;
					a1.OwnerId = approvalTrainer;
					a1.Description = 'Review proposed Travel Arrangements.  Complete the \"Travel Approved (Trainer)\" field on the project if you approve.';
					a1.ActivityDate = system.Today()+1;
					a1.Type = 'Task';
					createTasks.add(a1);//insert a1;
					
					//Finance Approve
					Task a2 = new Task();
					a2.subject = 'WFT - Approve Travel - Approve Travel Arrangements';
					if(p.Training_Expenses_Paid_by_Dealer__c==True)a2.subject = 'WFT - Approve Travel - Bill Dealer for Travel Arrangements';					
					a2.WhatId = p.Id;
					a2.OwnerId = TF;
					a2.Description = 'Review proposed Travel Arrangements.  Complete the \"Travel Approved (Financed)\" field on the project if you approve and the financing is ready.';
					if(p.Training_Expenses_Paid_by_Dealer__c==True)a2.Description = 'Review proposed Travel Arrangements.  Complete the \"Travel Approved (Financed)\" field on the project if you approve and the billing for the dealer to pay for travel arrangements is ready.';
					a2.ActivityDate = system.Today()+1;
					a2.Type = 'Task';
					createTasks.add(a2);//insert a2;
					
					String fullURL = URL.getSalesforceBaseUrl().toExternalForm() + '/';    
					String[] toAddresses = new String[]{TFemail};
					Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
					email.setToAddresses(toAddresses);
					email.setWhatId(p.Id);
					email.setSubject('You have a new task to approve Travel Arrangements'); 
					email.setSenderDisplayName('VinSupport/Training');
			        email.setBccSender(false);
			        email.setUseSignature(false);
			        String msg = 'You have a new task to approve Travel Arrangements.<br><br>Click the following link to view the Task:<br><br>' + fullURL +a2.Id; 
			        email.setHtmlBody(msg);
					Messaging.sendEmail(new Messaging.Email[] { email } , TRUE);
					
					//Jim Approve
					Task a3 = new Task();
					a3.subject = 'WFT - Approve Travel - Check Cut-off Date and Approve Travel Arrangements';
					a3.WhatId = p.Id;
					a3.OwnerId = TM;
					a3.Description = 'Review proposed Travel Arrangements.  Complete the \"Training is GO\" field on the project if you approve and all of the planets are aligned for training to take place.';
					a3.ActivityDate = system.Today()+1;
					a3.Type = 'Task';
					createTasks.add(a3);//insert a3;	
	       	 	}
	       	 	//insert createTasks;
				createTasks.clear();
	       	 	
	       	 	 
	       	 	//Stage 4 (Training is GO - and other approvals)
	       	 	//Milestone 4 Requirements
	       	 	
	       	 	//Travel Approved by Trainer
	       	 	if(p.Travel_Approved_Trainer__c!=null && oldProject.Travel_Approved_Trainer__c==null)
				{
					//close Trainer's open task for training
					List<Task> CloseTasks = new List<Task>();
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:p.Trainer__c and Status!='Completed']) 
					{
						string sub = t.Subject.tolowercase();
						if(sub.contains('approve travel'))
						{
							t.Date_Time_Completed__c = system.now();
							t.Status = 'Completed';
				
						CloseTasks.add(t);
						}
					}
					update CloseTasks;			
				
   	 			}  
   	 			//Stage 5 (Travel Financed)
   	 			if(p.Travel_Approved_Financed__c!=null && oldProject.Travel_Approved_Financed__c==null)
				{
					List<Task> CloseTasks = new List<Task>();
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:TF and Status!='Completed']) 
					{
						string sub = t.Subject.tolowercase();
						if(sub.contains('approve travel'))
						{
							t.Date_Time_Completed__c = system.now();
							t.Status = 'Completed';
				
						CloseTasks.add(t);
						}
					}
					update CloseTasks;			
				
   	 			}  
   	 			//Stage 6 (Training is GO - and other approvals)
   	 			//Thundercats are go
   	 			if(p.Training_is_GO__c!=null && oldProject.Training_is_GO__c==null)
				{
					List<Task> CloseTasks = new List<Task>();
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:TM and Status!='Completed']) 
					{
						
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
				
						CloseTasks.add(t);
						
					}
					update CloseTasks;
					p.Training_Stage__c='Execution';
					
					//Task for Karen to Purchase Travel
					/*Task p1 = new Task();
					p1.subject = 'WFT - Travel Purchased - Purchase Travel Arrangements ';
					p1.WhatId = p.Id;
					p1.OwnerId = TA;
					p1.Description = 'Purchase the approved travel arrangements';
					p1.ActivityDate = system.Today()+1;
					p1.Type = 'Task';
					createTasks.add(p1);//insert p1;
					
					Task p2 = new Task();
					p2.subject = 'WFT - Travel Purchased - Forward final agenda(s) to Trip-it ';
					p2.WhatId = p.Id;
					p2.OwnerId = TA;
					p2.Description = 'Final travel arrangements to be posted on Trip-it';
					p2.ActivityDate = system.Today()+2;
					p2.Type = 'Task';
					createTasks.add(p2);//insert p2;
					
					
								
					//Trainer Execution Tasks
					Date start = p.Confirmed_Training_Start__c;
					Date enddate = p.Confirmed_Training_End__c;
					
					Task t1 = new Task();
					t1.subject = 'WFT - Execute Training - Monitor Attendance';
					t1.WhatId = p.Id;
					t1.OwnerId = p.Trainer__c;
					t1.Description = 'Monitor Attendance/put no-shows on CIT';
					t1.ActivityDate = start;
					t1.Type = 'Task';
					createTasks.add(t1);//insert t1;
					
					Task t2 = new Task();
					t2.subject = 'WFT - Execute Training - Configure/Test VinCamera/Scanner';
					t2.WhatId = p.Id;
					t2.OwnerId = p.Trainer__c;
					t2.Description = 'Install/Verify camera/Scanner operational';
					t2.ActivityDate = start;
					t2.Type = 'Task';
					createTasks.add(t2);//insert t2;
					
					Task t3 = new Task();
					t3.subject = 'WFT - Execute Training - Verify Sticker printing, Letter printing process';
					t3.WhatId = p.Id;
					t3.OwnerId = p.Trainer__c;
					t3.Description = 'Verify Sticker printing, Letter printing process';
					t3.ActivityDate = start;
					t3.Type = 'Task';
					createTasks.add(t3);//insert t3;
					
					Task t4 = new Task();
					t4.subject = 'WFT - Execute Training - Verify leads Routing';
					t4.WhatId = p.Id;
					t4.OwnerId = p.Trainer__c;
					t4.Description = 'Verify leads routing to VS/Lead Assignment/Lead Settings';
					t4.ActivityDate = start;
					t4.Type = 'Task';
					createTasks.add(t4);//insert t4;
					
					Task t5 = new Task();
					t5.subject = 'WFT - Execute Training - Set up Bad lead rejection/Review Processes';
					t5.WhatId = p.Id;
					t5.OwnerId = p.Trainer__c;
					t5.Description = 'Set up Bad lead rejection/Review Processes';
					t5.ActivityDate = start;
					t5.Type = 'Task';
					createTasks.add(t5);//insert t5;
					
					Task t6 = new Task();
					t6.subject = 'WFT - Execute Training - Set up appropriate groups for users';
					t6.WhatId = p.Id;
					t6.OwnerId = p.Trainer__c;
					t6.Description = 'Set up appropriate groups for users';
					t6.ActivityDate = start;
					t6.Type = 'Task';
					createTasks.add(t6);//insert t6;
					
					Task t7 = new Task();
					t7.subject = 'WFT - Execute Training - Verify Desking Settings';
					t7.WhatId = p.Id;
					t7.OwnerId = p.Trainer__c;
					t7.Description = 'Verify Desking Settings';
					t7.ActivityDate = start;
					t7.Type = 'Task';
					createTasks.add(t7);//insert t7;
					
					Task t8 = new Task();
					t8.subject = 'WFT - Execute Training - Enable Processes';
					t8.WhatId = p.Id;
					t8.OwnerId = p.Trainer__c;
					t8.Description = 'Enable Processes';
					t8.ActivityDate = start;
					t8.Type = 'Task';
					createTasks.add(t8);//insert t8;
					
					Task t9 = new Task();
					t9.subject = 'WFT - Execute Training - Verify Accurate VS website contact info is entered';
					t9.WhatId = p.Id;
					t9.OwnerId = p.Trainer__c;
					t9.Description = 'Verify Accurate VS website contact info is entered';
					t9.ActivityDate = enddate;
					t9.Type = 'Task';
					createTasks.add(t9);//insert t9;
					
					Task t10 = new Task();
					t10.subject = 'WFT - Execute Training - Exit interview/dealer recommendations/Intro DDM';
					t10.WhatId = p.Id;
					t10.OwnerId = p.Trainer__c;
					t10.Description = 'Exit interview/dealer recommendations/Intro DDM';
					t10.ActivityDate = enddate;
					t10.Type = 'Task';
					createTasks.add(t10);//insert t10;*/
					
								
				
   	 			}
   	 			//insert createTasks;
				createTasks.clear();  
   	 			//Stage 7 (Travel is Purchased)
   	 			//Close Travel Purchased Task for Karen
				if(p.Travel_Purchased__c!=null&&oldproject.Travel_Purchased__c==null)
				{
					List<Task> CloseTasks2 = new List<Task>();
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:TA and Status!='Completed']) 
					{
					
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
				
						CloseTasks2.add(t);
					
					}
					update CloseTasks2;
				}
   	 			//Stage 8 (Training is Completed)
   	 			//Close Trainer's Execution Tasks & Open DDM & Trainer EXPENSE tasks
   	 			if(p.Training_Completed__c!=null&&oldproject.Training_Completed__c==null)
   	 			{
   	 				//Close Trainer's Tasks
   	 				List<Task> CloseTasks2 = new List<Task>();
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:p.Trainer__c and Status!='Completed']) 
					{
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
				
						CloseTasks2.add(t);
					}
					update CloseTasks2;
   	 				
   	 				//Create Expense Tasks for Trainer
   	 				/*Task t1 = new Task();
					t1.subject = 'WFT - Trainer Expenses - Scan CIT/Sales Acknowledgements/Receipts';
					t1.WhatId = p.Id;
					t1.OwnerId = p.Trainer__c;
					t1.Description = 'Scan CIT/Sales Acknowledgements/Receipts';
					t1.ActivityDate = system.Today()+3;
					t1.Type = 'Task';
					createTasks.add(t1);//insert t1;
   	 				
   	 				Task t2 = new Task();
					t2.subject = 'WFT - Trainer Expenses - File Commission/Expense Reports';
					t2.WhatId = p.Id;
					t2.OwnerId = p.Trainer__c;
					t2.Description = 'File Commission/Expense Reports';
					t2.ActivityDate = system.Today()+3;
					t2.Type = 'Task';
					createTasks.add(t2);//insert t2;
   	 				
   	 				//Account Manager Tasks (used to be assigned to the DDM)
   	 				Task d2 = new Task();
					d2.subject = 'WFT - Acct Mgr Finalization - Send Training Survey to all Training Attendees';
					d2.WhatId = p.Id;
					d2.OwnerId = p.Account_Manager_ID__c;
					d2.Description = 'Send Training Survey to all Training Attendees';
					d2.ActivityDate = system.Today()+1;
					d2.Type = 'Task';
					//createTasks.add(d2);//insert d2;
   	 				   	 				  	 				   	 				
   	 				Task D1 = new Task();
					D1.subject = 'WFT - Acct Mgr Finalization - Acct Mgr Intro Call';
			 		D1.WhatId = p.Id;
					D1.OwnerId = p.Account_Manager_ID__c;
					D1.Description = 'Introduce yourself to the client';
					D1.ActivityDate = system.Today()+1;
					D1.Type = 'Task';
					//createTasks.add(D1);//insert D1;
					
					   	 				
   	 				//Update Training Stage to Finalization*/
   	 				p.Training_Stage__c = 'Finalization';
   	 				
   	 			}
   	 			//insert createTasks;
				createTasks.clear();
   	 			
   	 			//Stage 8 (Training Expenses are done)
   	 			if(p.Trainer_Expenses_Submitted__c!=null&&oldProject.Trainer_Expenses_Submitted__c==null)
   	 			{
   	 				//Close Trainer Expense Task
   	 				List<Task> CloseTasks2 = new List<Task>();
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:p.Trainer__c and Status!='Completed']) 
					{
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
				
						CloseTasks2.add(t);
					}
					update CloseTasks2;
   	 			}
   	 			//Stage 9 (Account Manager Completed Tasks)
   	 			if(p.DDM_Finalization_Complete__c!=null&&oldProject.DDM_Finalization_Complete__c==null)
   	 			{
   	 				//Close Account Manager Tasks
   	 				List<Task> CloseTasks2 = new List<Task>();
					for (Task t : [SELECT id, Subject, Status,Date_Time_Completed__c FROM Task WHERE WhatId =:p.Id and OwnerId=:p.Account_Manager_ID__c and Status!='Completed']) 
					{
						t.Date_Time_Completed__c = system.now();
						t.Status = 'Completed';
				
						CloseTasks2.add(t);
					}
					update CloseTasks2;
					
					/*Task DD1 = new Task();
					DD1.subject = 'WFT - DDM Call Dealer to Upsell additional Training';
			 		DD1.WhatId = p.Id;
					DD1.OwnerId = DDMid;
					DD1.Description = 'Introduce yourself to the client and upsell additional training.';
					DD1.ActivityDate = system.Today()+1;
					DD1.Type = 'Task';
					createTasks.add(DD1);//insert DD1;*/
					
					
					//update Training Stage
					p.Training_Stage__c = 'Completed';
   	 			}
   	 			//insert createTasks;
				createTasks.clear();
			}   
			      	 	           	 	           
		
//==============================END TRAINING PROCESSES


	}//end UpdatePacketSent class call - The main one
		
	
}