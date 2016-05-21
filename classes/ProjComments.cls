public with sharing class ProjComments 
{
	
	public static void UpdateLastComment(Project_Comment__c[] pc)
	{	
		if(pc[0].Project_Piece__c!=null)
		{
			Project_Piece__c pp = [select id, Last_Comment__c from Project_Piece__c where id =:pc[0].Project_Piece__c];
		
			for (Project_Comment__c p:pc)
			{ 		
				string Comment;
				if (p.Comments__c == null) Comment = '...';
				else Comment = p.Comments__c;
				string LastComment;
				
				if(Comment.length()<=160)
				{
					LastComment = Comment;
				}
				if(Comment.length()>160)
				{
					LastComment = Comment.substring(0,160)+'...';
				}
				
				pp.Last_Comment__c =  LastComment;			
				update pp;
			}
		}
	}



	/*public static testMethod void TestProjectComments()
	{	
		Account Ac = new Account();
		Ac.Name = 'test'; 
		insert Ac;
	
		Opportunity Opt = new Opportunity();
		Opt.AccountId = Ac.Id;
		Opt.StageName = 'test'; 
		Opt.CloseDate = system.today();
		Opt.Opportunity_Names__c = 'test';
		Opt.Type = 'New Business';
		Opt.Name = 'test';
		insert Opt;
		
		SFDC_520_Quote__c Pro = new SFDC_520_Quote__c();
		Pro.Approval_Stage__c = 'Introduction';
		Pro.Name = 'test';
		Pro.Opportunity__c = Opt.Id;
		Pro.Account__c = Ac.Id;
		//Pro.DDM__c = userinfo.getUserId();
		insert Pro;
		
		Project_Piece__c PP = new Project_Piece__c();
		PP.Project__c = Pro.Id;
		PP.Piece_Issue__c = 'TestPiece - Sticker';
		PP.Name = 'VinSticker';
		PP.Project_Piece_Stage__c = 'Introduction';
		insert PP;
	
		Project_Comment__c PjctC = new Project_Comment__c();
		PjctC.Comments__c = 'test';
		PjctC.Project__c = Pro.Id;
		PjctC.Project_Piece__c = PP.Id;	
	
		insert PjctC;
	}*/
}