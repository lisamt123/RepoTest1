public class documentExt 
{
   Document d = new Document();
    public documentExt(ApexPages.StandardController controller) 
    {
    	d = (Document) controller.getRecord();
       	d.folderid = '00l70000001I1DF';
       	d.IsPublic=true;
       	      
       	d.Description  =  System.currentPageReference().getParameters().get('parentId').substring(0,15);//this puts it in My Personal Documents
                   //	d.ParentId=System.currentPageReference().getParameters().get('parentId');
    } 
    
    public pageReference docSave()
    {
    	insert d;
    	return Page.Welcome_Packet_Complete;
    }    
    
    public pageReference previous()
    {
    	return Page.Welcome_Packet_Page_13;
    } 
    
    public pageReference Skip()
    {
    	return Page.Welcome_Packet_Complete;
    } 
    
    public pageReference docSaveWebsite()
    {
    	if(d.Body!=null)
    	{
	    	insert d;
	    	PageReference moreDocs = new PageReference('/WebsitePacketPage1x5b?parentId='+d.description);
	    	d=null; 
	    	moreDocs.setredirect(true);   	
	    	return moreDocs;
    	}
    	else return Page.WebsitePacketPage1x5;
    }   
    
    //DOCUMENTS
			
	Document[] docs;
		
	public void initList() 
	{
		query();
	}	
	  	
	public PageReference query() 
	{  
		docs = 
		[SELECT id, name, description, ContentType, Type 
		from Document 
		where Description like: System.currentPageReference().getParameters().get('parentId').substring(0,15)];
		return null;
	}
	public Document[] getDocmnts() 
	{
		return docs;
	}
	 
	public static testmethod void testDocumentExt()
	{        
		Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        Document d = new Document();       
        d.Description = W.Id;
        d.name = 'test';
        d.Body = blob.valueOf('test');
        
        PageReference testStart = new PageReference('/VINWelcomePackets/DocumentCreate?parentid='+W.Id);
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);
                
        ApexPages.Standardcontroller newDoc = new Apexpages.Standardcontroller(d);
        documentExt dX = new documentExt(newDoc);     
      	Document[] Doc = dX.getDocmnts();            
       	dX.initList();
       	dx.docSave();
       	
       	Document d2 = new Document();       
        d2.Description = W.Id;
        d2.name = 'test';
        
       	newDoc = new Apexpages.Standardcontroller(d2);
        documentExt dX2 = new documentExt(newDoc);     
      	Document[] Doc2 = dX.getDocmnts();            
      	
       	
        
       	dx2.docSaveWebsite();
       	dx2.previous();
       	dx2.Skip();
	}
}