/*--------------------------------------------------------------------------
Author:         Moon Cui (Perficient)
Description:    Create a Feedback in Community.
History
1/28/2016   Moon Cui    Initial version
----------------------------------------------------------------------------*/
public with sharing class NewFeedbackController {
    @AuraEnabled
    public static Feedback__c saveFeedback(Feedback__c feedback, 
                                                   String articleName){
        
        List<KnowledgeArticleVersion> articleList = [SELECT KnowledgeArticleId 
                                            FROM KnowledgeArticleVersion 
                                            WHERE UrlName=:articleName 
                                            AND PublishStatus='Online' 
                                            AND Language='en_US'];
        if(articleList.size()>0){
            feedback.KnowledgeArticleId__c = articleList.get(0).KnowledgeArticleId;
            String sitePre = Site.getPathPrefix();
            String pre = '';
            if(sitePre != null && sitePre.length() > 2){
                pre = sitePre.substring(0, sitePre.length()-2);
            }
            feedback.Article_URL__c = URL.getSalesforceBaseUrl().toExternalForm()
                                    + pre
                                    + '/' + articleList.get(0).KnowledgeArticleId;
        }
        User currentUser = [SELECT ContactId FROM User WHERE Id = :UserInfo.getUserId() limit 1];
        if(currentUser != null && currentUser.ContactId != null){
            feedback.Contact__c = currentUser.ContactId;
        }
                                                       
        List<Group> groups = [SELECT Id, DeveloperName FROM Group WHERE Type='Queue' AND DeveloperName = :CommunityConstants.FEEDBACK_QUEUE_DEV_NAME];
        if(groups.size() > 0){
            feedback.OwnerId = groups.get(0).Id;
        }
        upsert feedback;
        return feedback;
    }
}