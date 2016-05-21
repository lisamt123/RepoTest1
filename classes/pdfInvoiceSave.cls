public with sharing class pdfInvoiceSave {

    public Id ParentId {get; set;}
    public String pdfName {get; set;}
    public String fileName {get; set;}
    
    public Opportunity opp {get; set;}
    public Document doc;
    
    public pdfInvoiceSave(){
        
        updateOppInfo();
    }
    
    public Document getPdfName(){
        
        doc = new Document();
        return doc;
    }
    
    public PageReference savePdf(){
        
        PageReference pdf = Page.Opportunity_Invoice;
        pdf.getParameters().put('id', ApexPages.currentPage().getParameters().get('id'));
        datetime myDatetime = datetime.Now();
        String convertedDate = myDateTime.format('MMMM d, yyyy hh:mm a');
        
        fileName = 'Invoice-' + opp.VS_ID__c + '' + opp.Account.Name + '' + convertedDate + '.pdf';
        
        //create the new attachment
        Attachment attach = new Attachment();
        //create the new document
        Document doc = new Document();
        
        //the contents of the attachment from the pdf
        Blob body = !Test.isRunningTest() ? pdf.getContent() : Blob.ValueOf('dummy text');
        //fixed to run test for coverage    
            //body = pdf.getContent();
            
            attach.Body = body;
            attach.Name = fileName;
            attach.IsPrivate = false;
            attach.ContentType = 'pdf';
            
            attach.ParentId = Apexpages.currentPage().getParameters().get('Id');
            insert attach;
            
            doc.FolderId = UserInfo.getUserId();
            doc.Body = body;
            doc.Name = fileName;
            doc.ContentType = 'pdf';
            insert doc;
            
            PageReference returnPage = new PageReference('/'+attach.Id);
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