/*--------------------------------------------------------------------------
Author:         Moon Cui (Perficient)
Description:    Testing NewFeedbackController.
History
2/2/2016    Moon Cui    Initial version
----------------------------------------------------------------------------*/
@isTest
private class NewFeedbackController_Test {
    static final String UNIQ_NAME = 'NewFeedbackController_Test';
    @isTest
    public static void testSaveFeedback(){
        FAQ__kav faq = prepareArticle();
        Feedback__c fb = new Feedback__c();
        fb.Description__c = UNIQ_NAME;
        Test.startTest();
            NewFeedbackController.saveFeedback(fb,faq.UrlName);
        Test.stopTest();
        List<Feedback__c> fbList = [SELECT Contact__c,OwnerId,Description__c,Article_URL__c,KnowledgeArticleId__c FROM Feedback__c];
        System.assertEquals(1,fbList.size());
        Feedback__c fbUpdated = fbList.get(0);
        String ownerId = fbUpdated.OwnerId;
        System.assert(ownerId.startsWith('00G'));
        System.assertEquals(faq.KnowledgeArticleId,fbUpdated.KnowledgeArticleId__c);
        System.assert(fbUpdated.Article_URL__c.contains(faq.KnowledgeArticleId),'Article URL not populated or not contain article Id');
        System.assertEquals(UNIQ_NAME, fbUpdated.Description__c);
    }
    
    private static FAQ__kav prepareArticle(){
        FAQ__kav faq = new FAQ__kav();
        faq.Title = 'test';
        faq.UrlName = 'test';
        faq.IsVisibleInCsp = true;
        insert faq;
        FAQ__kav a = [SELECT Id,UrlName, KnowledgeArticleId FROM FAQ__kav WHERE Id= :faq.Id limit 1];
        String articleId =  a.KnowledgeArticleId ;
        KbManagement.PublishingService.publishArticle(articleId , true ); 
        return a;
    }
}