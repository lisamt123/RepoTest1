public with sharing class pdfGeneratorController{
    
    public Id ParentId {get; set;}
    public String pdfName {get; set;}
    public String fileName {get; set;}
    
    public Opportunity opp {get; set;}
    public Document doc;
    
     
    
    
    public pdfGeneratorController(){
        
        updateOppInfo();
        
    }
    
    public Document getPdfName(){
        
        doc = new Document();
        return doc;
    }
    
    public PageReference savePdf(){
        
        
        
        
        PageReference pdf = Page.QuoteShell;
        pdf.getParameters().put('id', ApexPages.currentPage().getParameters().get('id'));
        datetime myDateTime = dateTime.Now();
        //datetime newDate =myDateTime.addHours(-5);
        String convertedDate = myDateTime.format('MMMM d, yyyy hh:mm a');
        
        fileName = opp.VS_ID__c + ' ' + opp.Account.Name + ' ' + convertedDate + '.pdf';
        
        //create the new attachment
        Attachment attach = new Attachment();
        //create the new document
        Document doc = new Document();
        
        //the contents of the attachment from the pdf
        Blob body = !Test.isRunningTest() ? pdf.getContentAsPDF() : Blob.ValueOf('dummy text');
            
        attach.Body = body;
        attach.Name = fileName;
        attach.IsPrivate = false;
        attach.contentType = 'pdf' ;
        //attach pdf to the opportunity
        attach.ParentId  = ApexPages.currentPage().getParameters().get('Id');
        insert attach;
            
        //save pdf in My Documents folder
        doc.FolderId = UserInfo.getUserId();
        doc.Body = body;
        doc.Name = fileName;
        doc.contentType = 'pdf';
            
        insert doc;
            
        PageReference returnPage = new Pagereference('/'+attach.Id);
        //return returnPage;    
        return pdf;
            
        
    }
    
    public void updateOppInfo(){
        
        opp = [SELECT Id, Name, Account.Name, VS_ID__c, Deal_Contact__r.Name, Deal_Contact__r.Email, 
               Salesperson__r.Email, Salesperson__r.Name, QuoteNumber__c, QuoteVersion__c
               FROM Opportunity
               WHERE Id =: ApexPages.currentPage().getParameters().get('id')];
               
            
    }
    
    
    
    
}