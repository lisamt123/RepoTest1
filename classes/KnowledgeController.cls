public abstract class KnowledgeController {
    private static final String PAGE_PREFIX = '/apex';

    public static final String PAGE_HOME = 'knowledgeHome';
    public static final String PAGE_PRODUCT = 'knowledgeProduct';
    public static final String PAGE_SEARCH = 'knowledgeSearch';
    public static final String PAGE_RENDERER = 'ArticleRendererPkb';

    private static final String LANGUAGE_COOKIE_NAME = 'PKBLanguage';

    public static final String URL_HOME = PAGE_PREFIX + '/' + PAGE_HOME;
    public static final String URL_PRODUCT = PAGE_PREFIX + '/' + PAGE_PRODUCT;
    public static final String URL_SEARCH = PAGE_PREFIX + '/' + PAGE_SEARCH;

    public static final String ARTICLE_TYPE_PARAMETER_NAME = 't';
    public static final String CATEGORY_PARAMETER_NAME = 'c';
    public static final String KEYWORD_PARAMETER_NAME = 'k';
    public static final String PAGE_NUMBER_PARAMETER_NAME = 'p';
    public static final String ARTICLE_TYPE_LABEL_PARAMETER_NAME = 'l';
    public static final String LANGUAGE_PARAMETER_NAME = 'lang';
    public static final String NEW_LANGUAGE_PARAMETER_NAME = 'n';
    public static final String ARTICLE_ID_PARAMETER_NAME = 'id';

    private Map<String, String> describeMap = new Map<String, String>();

    public KnowledgeController() {
        createDescribeMap();
    }

    public String articleIdParameterName {
        get {
            return ARTICLE_ID_PARAMETER_NAME;
        }
    }

    public String languageParameterName {
        get {
            return LANGUAGE_PARAMETER_NAME;
        }
    }

    public String newLanguageParameterName {
        get {
            return NEW_LANGUAGE_PARAMETER_NAME;
        }
    }

    public String categoryParameterName {
        get {
            return CATEGORY_PARAMETER_NAME;
        }
    }

    public String keywordParameterName {
        get {
            return KEYWORD_PARAMETER_NAME;
        }
    }

    public String articleTypeParameterName {
        get {
            return ARTICLE_TYPE_PARAMETER_NAME;
        }
    }

    public String articleTypeLabelParameterName {
        get {
            return ARTICLE_TYPE_LABEL_PARAMETER_NAME;
        }
    }

    public String pageNumberParameterName {
        get {
            return PAGE_NUMBER_PARAMETER_NAME;
        }
    }

    protected String paramByParamId(String paramId, String defaultValue) {
        if (ApexPages.currentPage().getParameters() == null) {
            return defaultValue;
        } else {
            String value = ApexPages.currentPage().getParameters().get(paramId);
            return (value == null) ? defaultValue : value;
        }
    }

    protected Integer paramByParamId(String paramId, Integer defaultValue) {
        if (ApexPages.currentPage().getParameters() == null) {
            return defaultValue;
        } else {

            String value = ApexPages.currentPage().getParameters().get(paramId);
            return (value == null) ? defaultValue : Integer.valueOf(value);
        }
    }

    public Integer currentPageNumber {
        get {
            if (currentPageNumber == null) {
                currentPageNumber = paramByParamId(PAGE_NUMBER_PARAMETER_NAME, 1);
            }
            return currentPageNumber;
        }
        set;
    }

    public String currentCategory {
        get {
            if (currentCategory == null) {
                currentCategory = paramByParamId(CATEGORY_PARAMETER_NAME, getRootCategoryName());
            }
            return currentCategory;
        }
        set;
    }

     public String currentLanguage {
        get {
            if (currentLanguage == null) {
                if (siteSetup.MainLanguage__c!=null && siteSetup.MainLanguage__c.length()>0) {
                    Boolean OK = false;
                    currentLanguage = paramByParamId(LANGUAGE_PARAMETER_NAME, '');

                    if (currentLanguage.length()==0) {
                        Cookie languageCookie = ApexPages.currentPage().getCookies().get(LANGUAGE_COOKIE_NAME);
                        if (languageCookie == null) {
                            // no language specified and no cookie : use main language
                            currentLanguage = siteAvailableLanguages[0].getIsoCode();
                        } else {
                            // no language specified but a cookie : use cookie language
                            currentLanguage = languageCookie.getValue();
                        }
                    }

                    for (Language lang : siteAvailableLanguages) {
                        if (lang.getIsoCode().equals(currentLanguage)) {
                            OK = true;
                        }
                    }
                    if (!OK) {
                        currentLanguage = siteAvailableLanguages[0].getIsoCode();
                    }

                    // User changed the language we must store that in a cookie
                    if (paramByParamId(NEW_LANGUAGE_PARAMETER_NAME, '0').equals('1')) {
                        Cookie languageCookie = new Cookie(LANGUAGE_COOKIE_NAME, currentLanguage, null, -1, false);
                        ApexPages.currentPage().setCookies(new Cookie[]{ languageCookie });
                    }
                }
            }
            return currentLanguage;
        }
        set;
    }

    public String currentArticleType {
        get {
            if (currentArticleType == null) {
                currentArticleType = paramByParamId(ARTICLE_TYPE_PARAMETER_NAME, '');
            }
            return currentArticleType;
        }
        set;
    }

    public String currentArticleTypeLabel {
        get {
            if (currentArticleTypeLabel == null) {
                currentArticleTypeLabel = paramByParamId(ARTICLE_TYPE_LABEL_PARAMETER_NAME, '');
            }
            return currentArticleTypeLabel;
        }
        set;
    }

    public String currentKeyword {
        get {
            if (currentKeyword == null) {
                currentKeyword = paramByParamId(KEYWORD_PARAMETER_NAME, '');
            }
            return currentKeyword;
        }
        set;
    }

    public String currentArticleId {
        get {
            if (currentArticleId == null) {
                currentArticleId = paramByParamId(ARTICLE_ID_PARAMETER_NAME, '');
            }
            return currentArticleId;
        }
        set;
    }

     public String currentArticleUrl {
      get {
         if (currentArticleUrl == null) {
            currentArticleUrl = getCurrentArticleUrl();
         }
         return currentArticleUrl;
      }
      set;
     }

    public static Map<String, String> allLanguages {
        get {
            if (allLanguages == null) {
                allLanguages = new Map<String, String>();
                // List of Salesforce supported languages
                 // http://www.salesforce.com/us/developer/docs/api_meta/Content/meta_translations.htm
                allLanguages.put('da', 'Danish');
                allLanguages.put('de', 'German');
                allLanguages.put('en_US', 'English');
                allLanguages.put('es', 'Spanish');
                allLanguages.put('fi', 'Finnish');
                allLanguages.put('fr', 'French');
                allLanguages.put('it', 'Italian');
                allLanguages.put('ja', 'Japanese');
                allLanguages.put('ko', 'Korean');
                allLanguages.put('nl_NL', 'Dutch');
                allLanguages.put('pt_BR', 'Portuguese (Brazil)');
                allLanguages.put('ru', 'Russian');
                allLanguages.put('sv', 'Swedish');
                allLanguages.put('th', 'Thai');
                allLanguages.put('zh_CN', 'Chinese (Simplified)');
                allLanguages.put('zh_TW', 'Chinese (Traditional)');
            }
            return allLanguages;
        }
        set;
    }

    public class Language {
        String isoCode;
        String label;
        Language(String isoCode, String label) {
            this.isoCode = isoCode;
            this.label = label;
        }
        public String getIsoCode() {
            return isoCode;
        }
        public String getLabel() {
            return label;
        }
    }

    private void createDescribeMap() {
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Set<String> keySet = gd.keySet();
        for (String key : keySet) {
            Schema.SObjectType objectType = gd.get(key);
            if (key.endsWith('ka') || key.endsWith('kb')) {
                this.describeMap.put(objectType.getDescribe().getKeyPrefix(), objectType.getDescribe().getLabel());
            }
        }
    }

    public String getArticleType(String articleId) {
        String articlePrefix = articleId.substring(0,3);
        Set<String> keySet = describeMap.keySet();
        String articleType = null;
        for(String key: keySet) {
            if(articlePrefix.equalsIgnoreCase(key)) {
                articleType = describeMap.get(key);
                return articleType;
            }
        }
        return articleType;
    }

    public String getCurrentArticleUrl() {
        String articleUrl = '';
        if (currentArticleId != null && currentArticleId.length()>0 && currentLanguage != null && currentLanguage.length()>0) {
            String query = 'select Id, UrlName, Language from KnowledgeArticleVersion where KnowledgeArticleId = \'' + currentArticleId + '\' and PublishStatus = \'Online\' and Language = \'' + currentLanguage + '\'';
            List<KnowledgeArticleVersion> articles = Database.query(query);
            KnowledgeArticleVersion article = articles.get(0);
            articleUrl =  '/articles/' + article.language + '/' + getArticleType(article.Id) + '/' + article.UrlName  + '?lang=' + article.language;
        }
        return articleUrl;
    }

    public Boolean getShowLanguagePickList() {
        return siteAvailableLanguages.size()>1;
    }

    public static Language[] siteAvailableLanguages {
        get {
            if (siteAvailableLanguages == null) {
                siteAvailableLanguages = new List<Language>();
                if (siteSetup.MainLanguage__c!=null && siteSetup.MainLanguage__c.length()>0) {
                    String isoCode = siteSetup.MainLanguage__c.trim();
                    siteAvailableLanguages.add(new Language(isoCode, allLanguages.get(isoCode)));
                }
                if (siteSetup.SecondaryLanguages__c!=null && siteSetup.SecondaryLanguages__c.length()>0) {
                    String [] isoCodes = siteSetup.SecondaryLanguages__c.split(';', -1);
                    for (String isoCode : isoCodes) {
                        isoCode = isoCode.trim();
                        if (!isoCode.equals(siteAvailableLanguages[0].getIsoCode())) {
                            siteAvailableLanguages.add(new Language(isoCode, allLanguages.get(isoCode)));
                        }
                    }
                }
            }
            return siteAvailableLanguages;
        }
        set;
    }

    public List<SelectOption> getSiteAvailableLanguagesList() {
        List<SelectOption> options = new List<SelectOption>();
        for (Language lang : siteAvailableLanguages) {
            options.add(new SelectOption(lang.isoCode, lang.label));
        }
        return options;
    }

    public List<SelectOption> getArticleAvailableLanguagesList() {
        List<SelectOption> options = new List<SelectOption>();
        if (this.currentArticleId != null &&  this.currentArticleId.length()>0) {
            String query = 'select Id, UrlName, Language from KnowledgeArticleVersion where KnowledgeArticleId = \'' + currentArticleId + '\' and PublishStatus = \'Online\'';
            List<KnowledgeArticleVersion> articles = Database.query(query);  
            Map<String, String> articleUrlsByLanguage = new Map<String, String>();                                
            for (KnowledgeArticleVersion article : articles) {              
                String isoCode = article.language;
                String articleUrl =  '/articles/' + isoCode + '/' + getArticleType(article.Id) + '/' + article.UrlName  + '?lang=' + isoCode;
                articleUrlsByLanguage.put(isoCode, articleUrl);
            }
            for (Language lang : siteAvailableLanguages) {
                if (articleUrlsByLanguage.containsKey(lang.isoCode)) {
                    options.add(new SelectOption(articleUrlsByLanguage.get(lang.isoCode), allLanguages.get(lang.isoCode)));
                }
            }
        }
        return options;
    }

    public static PKBSiteSetup__c siteSetup {
        get {
            if (siteSetup == null) {
                try {
                    String siteName = Site.getName();
                    if (siteName == null || siteName.length()==0) {
                        siteName = 'TestPKBSiteSetup';
                    }
                    siteSetup = [
                       SELECT id, PKBSiteName__c, RootCategoryName__c, CategoryGroupName__c, CacheMaxAge__c,
                       Category1Description__c, Category2Description__c, Category3Description__c,
                       Category4Description__c, Category5Description__c, Category6Description__c,
                       HomeAdText__c, HomeAdTitle__c, MainLanguage__c, SecondaryLanguages__c
                       FROM PKBSiteSetup__c
                       WHERE PKBSiteName__c = :siteName ];
                } catch (QueryException  e) {
                    // can't throw an exception here in order to prevent tests from failing before creating an PKB Site Setup
                    siteSetup = new PKBSiteSetup__c();
                }
            }
            return siteSetup;
        }
        set;
    }

    public PKBTranslation__c siteTranslation {
        get {
            if (siteTranslation == null) {
                try {
                    siteTranslation = [
                           SELECT
                               Category1Description__c, Category2Description__c, Category3Description__c,
                               Category4Description__c, Category5Description__c, Category6Description__c,
                               HomeAdText__c, HomeAdTitle__c
                           FROM PKBTranslation__c
                           WHERE language__c = :currentLanguage
                           AND PKB_Site_Setup__r.id = :siteSetup.id
                    ];
                } catch (QueryException  e) {
                    // can't throw an exception here in order to prevent tests from failing before creating an PKB Site Setup
                    siteTranslation = new PKBTranslation__c();
                }
            }
            return siteTranslation;
        }
        set;
    }


    public PKBSiteSetup__c getSiteSetup() {
        return siteSetup;
    }

    private String[] categoryDescriptions;

    public String[] getCategoryDescriptions() {
        if (categoryDescriptions == null) {
            categoryDescriptions = new String[]{};
            categoryDescriptions.add(siteTranslation.category1Description__c != null ? siteTranslation.category1Description__c : ( siteSetup.category1Description__c == null ? '' : siteSetup.category1Description__c));
            categoryDescriptions.add(siteTranslation.category2Description__c != null ? siteTranslation.category2Description__c : ( siteSetup.category2Description__c == null ? '' : siteSetup.category2Description__c));
            categoryDescriptions.add(siteTranslation.category3Description__c != null ? siteTranslation.category3Description__c : ( siteSetup.category3Description__c == null ? '' : siteSetup.category3Description__c));

            categoryDescriptions.add(siteTranslation.category4Description__c != null ? siteTranslation.category4Description__c : ( siteSetup.category4Description__c == null ? '' : siteSetup.category4Description__c));
            categoryDescriptions.add(siteTranslation.category5Description__c != null ? siteTranslation.category5Description__c : ( siteSetup.category5Description__c == null ? '' : siteSetup.category5Description__c));
            categoryDescriptions.add(siteTranslation.category6Description__c != null ? siteTranslation.category6Description__c : ( siteSetup.category6Description__c == null ? '' : siteSetup.category6Description__c));
        }
        return categoryDescriptions;
    }

    public String getHomeAdTitle() {
        return siteTranslation.HomeAdTitle__c!=null ? siteTranslation.HomeAdTitle__c :  (siteSetup.HomeAdTitle__c == null ? '' : siteSetup.HomeAdTitle__c);
    }

    public String getHomeAdText() {
        return siteTranslation.HomeAdText__c!=null ? siteTranslation.HomeAdText__c :  (siteSetup.HomeAdText__c == null ? '' : siteSetup.HomeAdText__c);
    }

    public String getRootCategoryName() {
        return siteSetup.RootCategoryName__c == null ? '' : siteSetup.RootCategoryName__c;
    }

    public String getCategoryGroupName() {
        return siteSetup.CategoryGroupName__c == null ? '' : siteSetup.CategoryGroupName__c;
    }

    public Long getCacheMaxAge() {
        return siteSetup.CacheMaxAge__c == null ? 0 : siteSetup.CacheMaxAge__c.longValue();
    }

    public Boolean getCachePage() {
        return paramByParamId(LANGUAGE_PARAMETER_NAME, '').length()>0;
    }

    public String getHomeUrl() {
        return URL_HOME;
    }

    public String getProductUrl() {
        return URL_PRODUCT;
    }

    public String getSearchUrl() {
        return URL_SEARCH;
    }

    public String getHomePage() {
        return PAGE_HOME;
    }

    public String getProductPage() {
        return PAGE_PRODUCT;
    }

    public String getSearchPage() {
        return PAGE_SEARCH;
    }

    public String getPage(String url) {
        if (url.contains('?')) {
            Integer i = url.indexOf('?');
            url = url.substring(0, i);
        }
        while (url.endsWith('/')) {
            url = url.substring(0, url.length()-1);
        }
        if (url.contains('/')) {
            Integer i = url.lastIndexOf('/');
            url = url.substring(i+1);
        }
        return url;
    }


    public PageReference currentPageReference {
        get {
            if (currentPageReference == null) {
                currentPageReference = ApexPages.currentPage();
            }
            return currentPageReference;
        }
        set;
    }

    public String currentPage {
        get {
                if (currentPage == null) {
                    currentPage = getPage(currentPageReference.getUrl());
                }
                return currentPage;
            }
            set;
    }

    public Boolean isPage(String pageName) {
        return currentPage.toLowerCase().contains(pageName.toLowerCase());
    }

    public Boolean getIsHomePage() {
        return isPage(PAGE_HOME);
    }

    public Boolean getIsProductPage() {
        return isPage(PAGE_PRODUCT);
    }

    public Boolean getIsSearchPage() {
        return isPage(PAGE_SEARCH);
    }

    public Boolean getIsExternalPage() {
        return !(getIsHomePage() || getIsProductPage() || getIsSearchPage());
    }

    public Boolean getIsRendererPage() {
        return isPage(PAGE_RENDERER);
    }

   public PageReference doSearch() {
        if (currentKeyword.length()<2) {
            return cleanKeyword();
        }
        PageReference pg = new PageReference(getSearchUrl());
        pg.getParameters().put(KEYWORD_PARAMETER_NAME, currentKeyword);
        pg.getParameters().put(CATEGORY_PARAMETER_NAME, currentCategory);
        pg.getParameters().put(LANGUAGE_PARAMETER_NAME, currentLanguage);
        if (getIsExternalPage()) {
            pg.setRedirect(true);
        }
        return pg;
   }

    public PageReference cleanKeyword() {
         PageReference pg = new PageReference(getProductUrl());
         pg.getParameters().put(CATEGORY_PARAMETER_NAME, currentCategory);
         pg.getParameters().put(KEYWORD_PARAMETER_NAME, '');
         currentKeyword = '';
         if (getIsExternalPage()) {
             pg.setRedirect(true);
         }
         return pg;
    }

    public Boolean getCanUserSeeKnowledge() {
    	// Not possible anymore to have better than this:
        return true;
    }

    public PageReference changeSiteLanguage() {
        PageReference pr = new PageReference(ApexPages.currentPage().getUrl());
        pr.getParameters().put(CATEGORY_PARAMETER_NAME, currentCategory);
        pr.getParameters().put(LANGUAGE_PARAMETER_NAME, currentLanguage);
        pr.getParameters().put(KEYWORD_PARAMETER_NAME, currentKeyword);
        pr.getParameters().put(ARTICLE_TYPE_PARAMETER_NAME, currentArticleType);
        pr.getParameters().put(ARTICLE_TYPE_LABEL_PARAMETER_NAME, currentArticleTypeLabel);
        pr.setRedirect(true);
        return pr;
    }

}