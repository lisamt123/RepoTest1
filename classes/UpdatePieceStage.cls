public with sharing class UpdatePieceStage {
	
	public static void updatePieceStage(Project_Runner__c r)
	{
		Project_Piece__c p = [select Id, Stage_Type__c from Project_Piece__c where Id = : r.Project_Piece__c limit 1];
		
		List <Event> ev = [Select  WhoId, WhatId, StartDateTime, OwnerId, Id, CreatedById, EndDateTime, Created_Date_Time__c From Event Where WhatId =: p.Id ORDER BY Created_Date_Time__c DESC];
		
		integer eventDifference = 120;
		
		
		if (r.Runner_Action__c=='Request' && r.Runner_Type__c == 'Comp')
		{
			p.Stage_Type__c = 'Comp Requested';
			p.Project_Piece_Stage__c = 'Design';
			p.Date_Comp_Requested__c = system.today();
			
		if (ev.size() > 0) {
				
			if ((ev[0].StartDateTime != r.Event_Date_Time__c) || (ev[0].OwnerId != r.Designer__c)){
			Event e = new Event();
			
			if (r.Designer__c != null) e.OwnerId = r.Designer__c;
			else e.OwnerId = '00570000001doz3';
			
			if (r.Designer__c != null) p.Assigned_Designer__c = r.Designer__c;
			
			e.Subject = '*Comp Design ';
			e.WhatId = p.Id;
			e.StartDateTime = r.Event_Date_Time__c;
			e.EndDateTime = r.Event_End_Date_Time__c;
			//if (r.Event_End_Date_Time__c != null) e.EndDateTime = r.Event_End_Date_Time__c;
			//else e.DurationInMinutes = 120;
			
			insert e;
			}
			
		} else {
			
			Event e = new Event();
			
			if (r.Designer__c != null) e.OwnerId = r.Designer__c;
			else e.OwnerId = '00570000001doz3';
			
			if (r.Designer__c != null) p.Assigned_Designer__c = r.Designer__c;
			
			e.Subject = '*Comp Design ';
			e.WhatId = p.Id;
			e.StartDateTime = r.Event_Date_Time__c;
			//e.EndDateTime = r.Event_End_Date_Time__c;
			if (r.Event_End_Date_Time__c != null) e.EndDateTime = r.Event_End_Date_Time__c;
			else e.DurationInMinutes = 120;
			
			insert e;
			
			
		}
		
		
		
			
			if (p.Milestone_1__c == 'Requirements Gathered') p.Milestone_1_Completed__c = system.today();
			if (p.Milestone_2__c == 'Requirements Gathered') p.Milestone_2_Completed__c = system.today();
			if (p.Milestone_3__c == 'Requirements Gathered') p.Milestone_3_Completed__c = system.today();
			if (p.Milestone_4__c == 'Requirements Gathered') p.Milestone_4_Completed__c = system.today();
			if (p.Milestone_5__c == 'Requirements Gathered') p.Milestone_5_Completed__c = system.today();
			if (p.Milestone_6__c == 'Requirements Gathered') p.Milestone_6_Completed__c = system.today();
			if (p.Milestone_7__c == 'Requirements Gathered') p.Milestone_7_Completed__c = system.today();
			if (p.Milestone_8__c == 'Requirements Gathered') p.Milestone_8_Completed__c = system.today();
			if (p.Milestone_9__c == 'Requirements Gathered') p.Milestone_9_Completed__c = system.today();
			if (p.Milestone_10__c == 'Requirements Gathered') p.Milestone_10_Completed__c = system.today();
					
		}
		
		if (r.Runner_Action__c == 'Start' && r.Runner_Type__c == 'Comp')
		{
			p.Stage_Type__c = 'Comp in Progress';
			p.Date_Comp_Started__c = system.today();
		}		
		
		if (r.Runner_Action__c == 'Submit' && r.Runner_Type__c == 'Comp')
		{
			p.Stage_Type__c = 'Comp Completed';
			p.Date_Comp_Completed__c = system.today();
		}
		
		if (r.Runner_Action__c == 'Approve' && r.Runner_Type__c == 'Comp')
		{
			p.Stage_Type__c = 'Comp Approved';
			p.Date_Comp_Approved__c = system.today();
		}
		
		if (r.Runner_Action__c == 'Request' && r.Runner_Type__c == 'Revision')
		{
			p.Stage_Type__c = 'Revision Requested';
			p.Latest_Revisions_Requested__c = system.today();	
			p.Latest_Revisions_Completed__c = null;
			
				
			if (ev.size() > 0) {	
			
			if((ev[0].StartDateTime != r.Event_Date_Time__c) || (ev[0].OwnerId != r.Designer__c))	
			{
				
			Event e = new Event();
			if (r.Designer__c != null) e.OwnerId = r.Designer__c;
			else e.OwnerId = '00570000001doz3';
			
			if (r.Designer__c != null) p.Assigned_Designer__c = r.Designer__c;			
			
			e.Subject = '*Revision Request';
			e.WhatId = p.Id;
			e.StartDateTime = r.Event_Date_Time__c;
			e.EndDateTime = r.Event_End_Date_Time__c;
			insert e;		
			}
			
			} else { 
			
			
				
			
			Event e = new Event();
			if (r.Designer__c != null) e.OwnerId = r.Designer__c;
			else e.OwnerId = '00570000001doz3';
			
			if (r.Designer__c != null) p.Assigned_Designer__c = r.Designer__c;			
			
			e.Subject = '*Revision Request';
			e.WhatId = p.Id;
			e.StartDateTime = r.Event_Date_Time__c;
			e.EndDateTime = r.Event_End_Date_Time__c;
			insert e;
			}
		
		}
		
		if (r.Runner_Action__c == 'Start' && r.Runner_Type__c == 'Revision')
		{
			p.Stage_Type__c = 'Revision in Progress';
			p.Date_Revisions_Started__c = system.today();
		}
		
		if (r.Runner_Action__c == 'Submit' && r.Runner_Type__c == 'Revision')
		{
			p.Stage_Type__c = 'Revision Completed';
			p.Latest_Revisions_Completed__c = system.today();	
		}		
		
		if (r.Runner_Action__c == 'Request' && r.Runner_Type__c == 'Site' )
		{
			p.Stage_Type__c = 'Build Requested';
			p.Date_Build_Requested__c = system.today();
		
		if(ev.size() > 0)
		{
		if((ev[0].StartDateTime != r.Event_Date_Time__c) || (ev[0].OwnerId != r.Designer__c))	
		
		{
			Event e = new Event();

			if (r.Designer__c != null) e.OwnerId = r.Designer__c;
			else e.OwnerId = '00570000001eh38';
			
			if (r.Designer__c != null) p.Assigned_Designer__c = r.Designer__c;
			
			e.Subject = '*Build Requested ';
			e.WhatId = p.Id;			
			e.StartDateTime = r.Event_Date_Time__c;
			e.EndDateTime = r.Event_End_Date_Time__c;
			insert e;	
		}
		} else {
			Event e = new Event();

			if (r.Designer__c != null) e.OwnerId = r.Designer__c;
			else e.OwnerId = '00570000001eh38';
			
			if (r.Designer__c != null) p.Assigned_Designer__c = r.Designer__c;
			
			e.Subject = '*Build Requested ';
			e.WhatId = p.Id;			
			e.StartDateTime = r.Event_Date_Time__c;
			e.EndDateTime = r.Event_End_Date_Time__c;
			insert e;	

		
		}
		
			if (p.Milestone_1__c == 'Proof Approved') p.Milestone_1_Completed__c = system.today();
			if (p.Milestone_2__c == 'Proof Approved') p.Milestone_2_Completed__c = system.today();
			if (p.Milestone_3__c == 'Proof Approved') p.Milestone_3_Completed__c = system.today();
			if (p.Milestone_4__c == 'Proof Approved') p.Milestone_4_Completed__c = system.today();
			if (p.Milestone_5__c == 'Proof Approved') p.Milestone_5_Completed__c = system.today();
			if (p.Milestone_6__c == 'Proof Approved') p.Milestone_6_Completed__c = system.today();
			if (p.Milestone_7__c == 'Proof Approved') p.Milestone_7_Completed__c = system.today();
			if (p.Milestone_8__c == 'Proof Approved') p.Milestone_8_Completed__c = system.today();
			if (p.Milestone_9__c == 'Proof Approved') p.Milestone_9_Completed__c = system.today();
			if (p.Milestone_10__c == 'Proof Approved') p.Milestone_10_Completed__c = system.today();		
		}
		
		if (r.Runner_Action__c == 'Submit' && r.Runner_Type__c == 'Site')
		{
			p.Stage_Type__c = 'Build Completed';
			p.Date_Build_Completed__c = system.today();	
		}
		
		if (r.Runner_Action__c == 'Approve' && r.Runner_Type__c == 'Site')
		{
			p.Stage_Type__c = 'Build Approved';
			p.Date_Build_Approved__c = system.today();	
		}
		
		if (r.Runner_Action__c == 'Start' && r.Runner_Type__c == 'Site')
		{
			p.Stage_Type__c = 'Build in Progress';
			p.Date_Build_Started__c = system.today();
		}
		
		//end build
		
		if (r.Runner_Action__c == 'Request' && r.Runner_Type__c == 'Correction')
		{
			p.Stage_Type__c = 'Correction Requested';
			p.Latest_Revisions_Requested__c = system.today();	
			p.Latest_Revisions_Completed__c = null;
			
				
			if (ev.size() > 0) {	
			
			if((ev[0].StartDateTime != r.Event_Date_Time__c) || (ev[0].OwnerId != r.Designer__c))	
			{
				
			Event e = new Event();
			if (r.Designer__c != null) e.OwnerId = r.Designer__c;
			else e.OwnerId = '00570000001doz3';
			
			if (r.Designer__c != null) p.Assigned_Designer__c = r.Designer__c;			
			
			e.Subject = '*Correction Request';
			e.WhatId = p.Id;
			e.StartDateTime = r.Event_Date_Time__c;
			e.EndDateTime = r.Event_End_Date_Time__c;
			insert e;		
			}
			
			} else { 
			
			
				
			
			Event e = new Event();
			if (r.Designer__c != null) e.OwnerId = r.Designer__c;
			else e.OwnerId = '00570000001doz3';
			
			if (r.Designer__c != null) p.Assigned_Designer__c = r.Designer__c;			
			
			e.Subject = '*Correction Request';
			e.WhatId = p.Id;
			e.StartDateTime = r.Event_Date_Time__c;
			e.EndDateTime = r.Event_End_Date_Time__c;
			insert e;
			}
		
		}
		
		if (r.Runner_Action__c == 'Start' && r.Runner_Type__c == 'Correction')
		{
			p.Stage_Type__c = 'Correction in Progress';
			p.Date_Revisions_Started__c = system.today();
		}
		
		if (r.Runner_Action__c == 'Submit' && r.Runner_Type__c == 'Correction')
		{
			p.Stage_Type__c = 'CorrectionCompleted';
			p.Latest_Revisions_Completed__c = system.today();	
		}		
		
		
				
		update p;	
	}
	
	
	
	
}