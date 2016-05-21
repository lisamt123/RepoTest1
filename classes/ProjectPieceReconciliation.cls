public class ProjectPieceReconciliation 
{
	private final Opportunity Oppty1;
	public ProjectPieceReconciliation(ApexPages.StandardController controller) 
	{
		this.Oppty1 = (Opportunity)controller.getSubject();
	}	
	
	string OpptyId = System.currentPageReference().getParameters().get('Id').substring(0,15);
	string projectId;
	
	Opportunity oppty = 	
	[select id, name, Account.name, Total_Installments_Paid__c, Territory_State_Id__c 
	from Opportunity 
	where id =: OpptyId];
	
	string acctName = oppty.Account.name;
	
	LIST<Project_Piece__c> PP = new LIST<Project_Piece__c>();
	LIST<OpportunityLineItem> OLI = new LIST<OpportunityLineItem>();
	LIST<OpportunityLineItem> OLI2 = new LIST<OpportunityLineItem>();
	LIST<OpportunityLineItem> OLI3 = new LIST<OpportunityLineItem>();
	
	
	
	//Run through the Opportunity Line Items/Products on the Oppty to see if the following special tasks/pieces need be generated
        boolean sendPacket=false;
        boolean CRM=false;
        boolean ILM=false;
        boolean BOTH=false;
        boolean emailBanner=false;  
        boolean inventoryLight=false; 
        boolean hasEmailBannerPiece=false; 
        
        
	
	
	
	public void initList() 
  	{
    	ProductRemovedList();
    	ProductAddedList();    	
  	}	
  	
  	public PageReference ProductRemovedList() 
 	{  
 		MAP<Id, OpportunityLineItem> opptyLineItemIDs = new MAP<Id, OpportunityLineItem>();
 		for(OpportunityLineItem thisOLI: 
 		[select Id, OpportunityId, PricebookEntry.Name
 		from OpportunityLineItem 
 		where OpportunityId=:OpptyId
	    AND Product_Issue__c!=null])
 		{
 			opptyLineItemIDs.put(thisOLI.Id, thisOLI); 		
 			if(thisOLI.PricebookEntry.Name.contains('CRM'))
 			{
 				 CRM=true;
 				 emailBanner=true;
 			}
 		}
        
        
 		
	   	PP = 
	    [SELECT CreatedDate, LastModifiedDate, 
	    Project__r.Opportunity__c, Project__c, id, 
	    name, Account__c, Opportunity_Line_Item_Id__c
	    from Project_Piece__c
	    where Project__r.Opportunity__c=:OpptyId
	    AND Opportunity_Line_Item_Id__c NOT IN: opptyLineItemIDs.keySet()
	    and Start_Process__c=null 
	    and Contact_Made__c=null
	    and Opportunity_Line_Item_Id__c != null];  
	        
	    return null;	    
  	}
  	
  	
  	public PageReference ProductAddedList() 
 	{  
 		MAP<Id, Project_Piece__c> ppOpptyLineItemIDs = new MAP<Id, Project_Piece__c>();
 		
 		for(Project_Piece__c thesePPs:
 		[SELECT Project__r.Opportunity__c, Project__c, id, name, Account__c, Opportunity_Line_Item_Id__c
	    from Project_Piece__c
	    where Project__r.Opportunity__c=:OpptyId])
	    {
	    	ppOpptyLineItemIDs.put(thesePPs.Opportunity_Line_Item_Id__c, thesePPs);
	    	projectId = thesePPs.Project__c;
	    	if(thesePPs.Name.toLowerCase().contains('email banner'))
	    	{
	    		hasEmailBannerPiece=true;
	    	}
	    }
 		 
 		
	   	OLI = 
	    [select Id, OpportunityId, Description, IsTraining__c, ProductId__c, PricebookEntry.Name, 
	    ProdProj_Default_Owner__c, Product_Issue__c, Product_Issue2__c, Product_Issue3__c, 
	    ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, Production_Department__c, 
	    Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
	    PricebookEntryId, requiresWelcomePacket__c, TotalPrice, Total_List_Price__c, VS_Sale_Price__c  
 		from OpportunityLineItem 
 		where OpportunityId=:OpptyId
	    AND Id NOT IN: ppOpptyLineItemIDs.keySet()
	    AND Product_Issue__c!=null];	
	    
	    boolean exp=false;
	    boolean train=false;
	    
	    if (projectId == null)
 		{
 			SFDC_520_Quote__c thisProject = [select Id from SFDC_520_Quote__c where Opportunity__c =: OpptyId limit 1]; 
 			projectId = thisProject.Id; 			
 		} 	   
	    
	    if(projectId!=null)
	    {
		    SFDC_520_Quote__c project = 
		    [select id, Training_Expenses_Paid_by_Dealer__c, Training_Included__c
		    from SFDC_520_Quote__c
		    where id=:projectId];
		    
		    for(OpportunityLineItem trainCheck:OLI)
		    {
		    	if(trainCheck.ExpPaidByDealer__c.tolowercase()=='true')exp=true;
		    	if(trainCheck.IsTraining__c.tolowercase()=='true')train=true;
		    }
		    
		    project.Training_Expenses_Paid_by_Dealer__c = exp;
		    project.Training_Included__c = train;
		    update project;
	    }
	    
	    MAP<ID, OpportunityLineItem> oliMap = new MAP<Id, OpportunityLineItem>();	    
	    //check existing OpportunityLineItems for CRM/ILM rules        
        for(OpportunityLineItem setPP:OLI)
        {
            if(setPP.requiresWelcomePacket__c=='True')sendPacket = true;
            if(setPP.PricebookEntry.Name.contains('CRM'))CRM=true;
            if(setPP.PricebookEntry.Name.contains('ILM'))ILM=true;
            if(CRM==true||ILM==true) emailBanner=true;  
            if(setPP.PricebookEntry.Name.contains('Inventory Light'))inventoryLight=true;       
        }
	    if(CRM==true&ILM==true) BOTH=true;
	    
	    for(OpportunityLineItem addOLI: OLI)
	    {
	    	/*if(BOTH==false||
	    	(BOTH==true&&!addOLI.PricebookEntry.Name.tolowerCase().contains('ilm')
	    	&&!addOLI.PricebookEntry.Name.tolowerCase().contains('inventory light')))
	    	{*/
	    		OLI2.add(addOLI);
	    		if(addOLI.IsTraining__c.tolowercase()!='true')
	    		oliMap.put(addOLI.Id, addOLI);
	    	//}
	    } 
	    
	    OLI3 = 
	    [select Id, OpportunityId, Description, IsTraining__c, ProductId__c, PricebookEntry.Name, 
	    ProdProj_Default_Owner__c, Product_Issue__c, Product_Issue2__c, Product_Issue3__c, 
	    ExpPaidByDealer__c, ProdProj_Dept2_Owner__c, ProdProj_Dept3_Owner__c, Production_Department__c, 
	    Quantity_Exception__c, Production_Department2__c, Production_Department3__c, Quantity, 
	    PricebookEntryId, requiresWelcomePacket__c, TotalPrice, Total_List_Price__c, VS_Sale_Price__c, 
	    OLI_Cost_Factor__c 
 		from OpportunityLineItem 
 		where id IN: oliMap.keySet()];	    
	    return null;	    
  	}
  	
  	public Project_Piece__c[] getPPs() 
  	{
    	return PP;
  	}
  	public OpportunityLineItem[] getOLIs()
  	{
  		return OLI3;
  	}  	
  	
  	public PageReference reconcile()
  	{  
		
		//Get a list of all Product Processes
		LIST<Product_Process__c> prodProc = new LIST<Product_Process__c>();
	    for(Product_Process__c PrP:
	    [select id, Number_of_Milestones__c, Product__c 
	    from Product_Process__c])
	    {
	        prodProc.add(Prp);
	    }
	    
	    
	    Territory_State__c territoryState = 
	    [select Territory_Manager__c, DDM__c, Account_Manager__c, Regional__c, Implementation_Manager__c
	    from Territory_State__c where Id =: oppty.Territory_State_ID__c];
	    		
  		LIST<Project_Piece__c> piecesToCreate = new LIST<Project_Piece__c>();
        
        for(OpportunityLineItem thisOli: OLI3)
        {                       
            if(thisOli.ProdProj_Default_Owner__c!=null)
            {               
                integer i=1;
                
                if(thisOli.Quantity_Exception__c=='True')i=Math.round(thisOli.Quantity.intValue());
                do
                {   
                    //Find the proper Product Process ID from the list
                    string productProcessId;
                    integer numberMilestones;
                    for(Product_Process__c PrdP:prodProc)
                    {
                        if(PrdP.Product__c==thisOli.ProductId__c)
                        {
                            productProcessId = PrdP.Id;
                            numberMilestones = PrdP.Number_of_Milestones__c.intValue();
                        }
                    }
                                    
                    /*if((BOTH==true&&thisOli.PricebookEntry.Name!='ILM')||BOTH!=true)
                    {*/
                        string pieceName = 'PP-'+thisOli.Product_Issue__c+'-'+acctName+'-'+system.today().format();
                        /*if((thisOli.PricebookEntry.Name.contains('ILM')||thisOli.PricebookEntry.Name.contains('CRM'))
                        &&inventoryLight==true)
                        pieceName = 'PP-'+thisOli.Product_Issue__c+acctName+'-'+system.now().format();*/
                        if(pieceName.length()>=75) pieceName = piecename.substring(0,75);
                        
                        if(thisOli.Quantity>1&&thisOli.Quantity_Exception__c!='True') pieceName+=+'-'+i;
                        Project_Piece__c newPiece = new Project_Piece__c();
                        newPiece.Product_Process__c = productProcessId;                        
                        if (thisOli.ProdProj_Default_Owner__c != null) newPiece.OwnerId = thisOli.ProdProj_Default_Owner__c;
                        else if(territoryState.Implementation_Manager__c!=null) newPiece.OwnerId = territoryState.Implementation_Manager__c;
                        else newPiece.OwnerId = Userinfo.getUserId();
                        
                        newPiece.Account__c = oppty.AccountId;
                        newPiece.Project_Piece_Special_Instructions__c = thisOli.Description;
                        if(thisOli.Quantity_Exception__c == 'false' && thisOli.Quantity > 1){
					      newPiece.Product_Value__c = thisOli.UnitPrice;
					    }
					    else{
					      newPiece.Product_Value__c = thisOli.TotalPrice;
					    }
                        newPiece.Project_Piece_Stage__c = 'Introduction';
                        newPiece.Product_Name__c = thisOli.PricebookEntry.name;
                        newPiece.Name = pieceName;
                        if(numberMilestones==1) newPiece.RecordTypeId = '01270000000Q4Ux';
						else if(numberMilestones==2) newPiece.RecordTypeId = '01270000000Q4V2';
						else if(numberMilestones==3) newPiece.RecordTypeId = '01270000000Q4V7';
						else if(numberMilestones==4) newPiece.RecordTypeId = '01270000000Q4VC';
						else if(numberMilestones==5) newPiece.RecordTypeId = '01270000000Q4VH';
						else if(numberMilestones==6) newPiece.RecordTypeId = '01270000000Q4Uy';
						else if(numberMilestones==7) newPiece.RecordTypeId = '01270000000Q4Uz';
						else if(numberMilestones==8) newPiece.RecordTypeId = '01270000000Q4VM';
						else if(numberMilestones==9) newPiece.RecordTypeId = '01270000000Q4VR';
						else if(numberMilestones==10) newPiece.RecordTypeId = '01270000000Q4V0';
                        else newPiece.RecordTypeId = '012700000005e2u';                       
                        newPiece.Piece_Issue__c = thisOli.Product_Issue__c+'-'+acctName;
                        newPiece.Project__c = projectId;
                        newPiece.Opportunity_Line_Item_ID__c=thisOli.Id;        
                        
                        newPiece.Product_Revenue__c = thisOli.OLI_Cost_Factor__c;                  
                        
                        piecesToCreate.add(newPiece);
                    //}
                                        
                    i++;                    
                }
                while(i<=thisOli.Quantity); 
            }                               
        }
        if(hasEmailBannerPiece==false&&emailBanner==true)
        {
        	string pieceName = 'PP-Email Banners-'+'-'+acctName+'-'+system.today().format();
            if(pieceName.length()>=80) pieceName = piecename.substring(0,79);
            Project_Piece__c newPiece = new Project_Piece__c();
            Product_Process__c productProcess = [select Id from Product_Process__c where name like '%Email Banner%' limit 1];            
            newPiece.Product_Process__c = productProcess.Id;
            string emailBannerRep = userinfo.getUserId();            
            if(territoryState.Implementation_Manager__c!=null) emailBannerRep = territoryState.Implementation_Manager__c;
            User bannerRep = [select Id from User where Email_Banner_Rep__c=true limit 1];
            if(bannerRep.Id!=null) emailBannerRep = bannerRep.Id;
            //newPiece.OwnerId = emailBannerRep;
            newPiece.OwnerId = territoryState.Implementation_Manager__c;
            newPiece.Account__c = oppty.AccountId;
            newPiece.Name = pieceName;   
            newPiece.Piece_Issue__c = 'Email Banners - '+'-'+acctName;
            newPiece.Project__c = projectId;
            newPiece.Project_Piece_Stage__c = 'Introduction';
            
            //piecesToCreate.add(newPiece);
            
            hasEmailBannerPiece=true;
        }   
                
        
        //Generate all the project pieces in the list
        LIST<Project_Piece__c> deletePieces = new LIST<Project_Piece__c>();
        for(Project_Piece__c P:PP)
        {	
        	if(!P.Name.toLowerCase().contains('email banner'))
        	{
        		deletePieces.add(P);
        	}
        }
        delete deletePieces;
        insert piecesToCreate;  
        
  		return Page.ProjectPieceReconciliation;
  	}
  	

  	

}