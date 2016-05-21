public class DocumentListExtension 
{
	private final Welcome_Packet__c wPacket;
	public DocumentListExtension(ApexPages.StandardController controller) 
	{
		this.wPacket = (Welcome_Packet__c)controller.getSubject();
	}	
	
	Document[] docs;
	
	public void initList() 
  	{
    	query();
  	}	
  	
  	public PageReference query() 
 	{  
	    docs = 
	    [SELECT id, name, ContentType, description 
	    from Document 
	    where Description =:System.currentPageReference().getParameters().get('Id').substring(0,15)];
	    return null;
  	}
  	public Document[] getDocmnts() 
  	{
    	return docs;
  	}
  	
  	public static testmethod void testDocumentList()
	{        
		Welcome_Packet__c W = new Welcome_Packet__c();
        W.name = 'test';
        W.OwnerId = userinfo.getuserid();
        insert W;
        
        PageReference testStart = new PageReference('/VINWelcomePackets/DocumentList?parentid='+W.Id);
		Test.setCurrentPage(testStart);
		
		ApexPages.currentPage().getParameters().put('Id', W.Id);
                
        
        ApexPages.Standardcontroller newDoc = new Apexpages.Standardcontroller(W);
        DocumentListExtension DLE = new DocumentListExtension(newDoc);
        DLE.initList(); 
        DLE.getDocmnts();
	}
  
}