@isTest
private class KnowledgeControllerTest {

   public static void setupTest() {
        Integer num = [ SELECT count() FROM PKBSiteSetup__c WHERE PKBSiteName__c = 'TestPKBSiteSetup' ];
        PKBSiteSetup__c siteSetup;
        if (num == 0) {
            siteSetup = new PKBSiteSetup__c();
        } else {
            siteSetup = [ SELECT id FROM PKBSiteSetup__c ];
        }
        siteSetup.Name = 'test setup';
        siteSetup.PKBSiteName__c = 'TestPKBSiteSetup';
        siteSetup.RootCategoryName__c = 'Root categ';
        siteSetup.CategoryGroupName__c = 'Category Group';
        siteSetup.MainLanguage__c = 'en_US';
        siteSetup.SecondaryLanguages__c = 'es; fr';

        upsert siteSetup;

        Integer num2 = [ SELECT count() FROM PKBTranslation__c  WHERE language__c = 'fr' AND PKB_Site_Setup__r.PKBSiteName__c = 'TestPKBSiteSetup' ];
        PKBTranslation__c translation;

        if (num2 == 0) {
            translation = new PKBTranslation__c();
        } else {
            translation = [ SELECT id FROM PKBTranslation__c ];
        }

        translation.language__c = 'fr';
        translation.PKB_Site_Setup__c = siteSetup.id;
        translation.Category1Description__c = 'translation1';
        translation.Category2Description__c = 'translation2';
        translation.Category3Description__c = 'translation3';
        translation.Category4Description__c = 'translation4';
        translation.Category5Description__c = 'translation5';
        translation.Category6Description__c = 'translation6';
        translation.HomeAdText__c = 'translation7';
        translation.HomeAdTitle__c = 'translation8';

        upsert translation;

        // force knowledgeController to requery the static siteSetup
        KnowledgeController.siteSetup = null;
    }


    static testMethod void testParamProperties() {
        setupTest();
        TestKnowledgeController controller = new TestKnowledgeController();
        ApexPages.currentPage().getParameters().put(KnowledgeController.PAGE_NUMBER_PARAMETER_NAME, '2');
        System.assertEquals(2, controller.currentPageNumber);
        ApexPages.currentPage().getParameters().put(KnowledgeController.CATEGORY_PARAMETER_NAME, 'apples');
        System.assertEquals('apples', controller.currentCategory);
        ApexPages.currentPage().getParameters().put(KnowledgeController.KEYWORD_PARAMETER_NAME, 'pears');
        System.assertEquals('pears', controller.currentKeyword);
        ApexPages.currentPage().getParameters().put(KnowledgeController.ARTICLE_TYPE_PARAMETER_NAME, 'bananas');
        System.assertEquals('bananas', controller.currentArticleType);
        ApexPages.currentPage().getParameters().put(KnowledgeController.ARTICLE_TYPE_LABEL_PARAMETER_NAME, 'ananas');
        System.assertEquals('ananas', controller.currentArticleTypeLabel);
        // Must test with one of the available languages
        ApexPages.currentPage().getParameters().put(KnowledgeController.LANGUAGE_PARAMETER_NAME, 'fr');
        System.assertEquals('fr', controller.currentLanguage);
        ApexPages.currentPage().getParameters().put(KnowledgeController.ARTICLE_ID_PARAMETER_NAME, 'kA0x00000000e4M');
        System.assertEquals('kA0x00000000e4M', controller.currentArticleId);        
    }

    static testMethod void testSiteSetupGetters() {
        setupTest();
        PKBSiteSetup__c siteSetup = [ select id, PKBSiteName__c from PKBSiteSetup__c WHERE PKBSiteName__c = 'TestPKBSiteSetup' ];
        Integer i = 0;

        siteSetup.RootCategoryName__c = String.valueOf(i++);
        siteSetup.CategoryGroupName__c = String.valueOf(i++);
        siteSetup.CacheMaxAge__c = i++;
        siteSetup.Category1Description__c = String.valueOf(i++);
        siteSetup.Category2Description__c = String.valueOf(i++);
        siteSetup.Category3Description__c = String.valueOf(i++);
        siteSetup.Category4Description__c = String.valueOf(i++);
        siteSetup.Category5Description__c = String.valueOf(i++);
        siteSetup.Category6Description__c = String.valueOf(i++);
        siteSetup.HomeAdText__c = String.valueOf(i++);
        siteSetup.HomeAdTitle__c = String.valueOf(i++);
        update siteSetup;

        TestKnowledgeController controller = new TestKnowledgeController();

        System.assertEquals(siteSetup.PKBSiteName__c, controller.getSiteSetup().PKBSiteName__c);
        System.assertEquals(controller.getRootCategoryName(), siteSetup.RootCategoryName__c);
        System.assertEquals(controller.getCategoryGroupName(), siteSetup.CategoryGroupName__c);
        System.assertEquals(controller.getCacheMaxAge(), siteSetup.CacheMaxAge__c);
        System.assertEquals(controller.getHomeAdTitle(), siteSetup.HomeAdTitle__c);
        System.assertEquals(controller.getHomeAdText(), siteSetup.HomeAdText__c);
        System.assertEquals(controller.getCategoryDescriptions()[0], siteSetup.Category1Description__c);
        System.assertEquals(controller.getCategoryDescriptions()[1], siteSetup.Category2Description__c);
        System.assertEquals(controller.getCategoryDescriptions()[2], siteSetup.Category3Description__c);
        System.assertEquals(controller.getCategoryDescriptions()[3], siteSetup.Category4Description__c);
        System.assertEquals(controller.getCategoryDescriptions()[4], siteSetup.Category5Description__c);
        System.assertEquals(controller.getCategoryDescriptions()[5], siteSetup.Category6Description__c);


    }

    static testMethod void testLanguages() {
        setupTest();

        TestKnowledgeController controller = new TestKnowledgeController();
        System.assertEquals(KnowledgeController.siteAvailableLanguages[0].getLabel(), KnowledgeController.allLanguages.get('en_US'));
        System.assertEquals(KnowledgeController.siteAvailableLanguages[1].getLabel(), KnowledgeController.allLanguages.get('es'));
        System.assertEquals(KnowledgeController.siteAvailableLanguages[2].getLabel(), KnowledgeController.allLanguages.get('fr'));
        System.assert(controller.getShowLanguagePickList());
    }

    static testMethod void testTranslation() {
        setupTest();

        // French site
        ApexPages.currentPage().getParameters().put(KnowledgeController.LANGUAGE_PARAMETER_NAME, 'fr');

        TestKnowledgeController controller = new TestKnowledgeController();
        // force knowledgeController to requery the static siteSetup
        KnowledgeController.siteSetup = null;

        // Now check translation
        System.assertEquals(controller.currentLanguage,  'fr');
        System.assertEquals(controller.getCategoryDescriptions()[0], 'translation1');
        System.assertEquals(controller.getCategoryDescriptions()[1], 'translation2');
        System.assertEquals(controller.getCategoryDescriptions()[2], 'translation3');
        System.assertEquals(controller.getCategoryDescriptions()[3], 'translation4');
        System.assertEquals(controller.getCategoryDescriptions()[4], 'translation5');
        System.assertEquals(controller.getCategoryDescriptions()[5], 'translation6');
        System.assertEquals(controller.getHomeAdText(),  'translation7');
        System.assertEquals(controller.getHomeAdTitle(),  'translation8');

        // Test that not available languages is refused and default to the first one.
        // French site
        ApexPages.currentPage().getParameters().put(KnowledgeController.LANGUAGE_PARAMETER_NAME, 'ja');
        TestKnowledgeController controllerEs = new TestKnowledgeController();
        // force knowledgeController to requery the static siteSetup
        KnowledgeController.siteSetup = null;
        System.assertEquals(controllerEs.currentLanguage,  'en_US');
    }


    static testMethod void testGetUrls() {
        TestKnowledgeController controller = new TestKnowledgeController();
        System.assertEquals(KnowledgeController.URL_HOME, controller.getHomeUrl());
        System.assertEquals(KnowledgeController.URL_SEARCH, controller.getSearchUrl());
        System.assertEquals(KnowledgeController.URL_PRODUCT, controller.getProductUrl());
    }


    static testMethod void testGetIsPage() {
        setupTest();

        Test.setCurrentPage(Page.knowledgeHome);
        TestKnowledgeController controller = new TestKnowledgeController();
        System.assert(controller.getIsHomePage());
        System.assert(!controller.getIsProductPage());
        System.assert(!controller.getIsSearchPage());
        System.assert(!controller.getIsExternalPage());
        System.assert(!controller.getIsRendererPage());

        Test.setCurrentPage(Page.knowledgeProduct);
        controller = new TestKnowledgeController();
        System.assert(!controller.getIsHomePage());
        System.assert(controller.getIsProductPage());
        System.assert(!controller.getIsSearchPage());
        System.assert(!controller.getIsExternalPage());
        System.assert(!controller.getIsRendererPage());

        Test.setCurrentPage(Page.knowledgeSearch);
        controller = new TestKnowledgeController();
        System.assert(!controller.getIsHomePage());
        System.assert(!controller.getIsProductPage());
        System.assert(controller.getIsSearchPage());
        System.assert(!controller.getIsExternalPage());
        System.assert(!controller.getIsRendererPage());
    }


    static testMethod void testGetPage() {
        TestKnowledgeController controller = new TestKnowledgeController();
        System.assertEquals('', controller.getPage(''));
        System.assertEquals('', controller.getPage('/'));
        System.assertEquals('', controller.getPage('//'));
        System.assertEquals('', controller.getPage('/?'));
        System.assertEquals('', controller.getPage('/?a=1'));
        System.assertEquals('', controller.getPage('/?a=1&b=2'));
        System.assertEquals('foo', controller.getPage('foo'));
        System.assertEquals('foo', controller.getPage('/foo'));
        System.assertEquals('foo', controller.getPage('//foo'));
        System.assertEquals('foo', controller.getPage('/foo/'));
        System.assertEquals('foo', controller.getPage('//foo//'));
        System.assertEquals('foo', controller.getPage('/apex/foo'));
        System.assertEquals('foo', controller.getPage('/apex/foo/'));
        System.assertEquals('foo', controller.getPage('/foo?'));
        System.assertEquals('foo', controller.getPage('/foo?a=1'));
        System.assertEquals('foo', controller.getPage('/foo?a=1&b=2'));
        System.assertEquals('foo', controller.getPage('/foo/?'));
        System.assertEquals('foo', controller.getPage('/foo/?a=1'));
        System.assertEquals('foo', controller.getPage('/foo/?a=1&b=2'));
        System.assertEquals('foo', controller.getPage('apex/foo/?'));
        System.assertEquals('foo', controller.getPage('apex/foo/?a=1'));
        System.assertEquals('foo', controller.getPage('apex/foo/?a=1&b=2'));
        System.assertEquals('foo', controller.getPage('/apex/foo/?'));
        System.assertEquals('foo', controller.getPage('/apex/foo/?a=1'));
        System.assertEquals('foo', controller.getPage('/apex/foo/?a=1&b=2'));
    }

    static testMethod void testActions() {
        // do search
        setupTest();
        Test.setCurrentPage(Page.knowledgeProduct);
        TestKnowledgeController controller = new TestKnowledgeController();
        controller.currentCategory = 'apples';
        controller.currentKeyword = 'pears';
        PageReference pg = controller.doSearch();
        System.assertEquals('pears', controller.currentKeyword);
        System.assertEquals('apples', controller.currentCategory);
        System.assert(controller.getPage(pg.getUrl()).contains(controller.getSearchPage()));

        // keyword too short
        Test.setCurrentPage(Page.knowledgeProduct);
        controller.currentCategory = 'apples';
        controller.currentKeyword = '1';
        pg = controller.doSearch();
        System.assertEquals('apples', controller.currentCategory);
        System.assertEquals('', controller.currentKeyword);
        System.assert(controller.getPage(pg.getUrl()).contains(controller.getProductPage()));

        // clean Keyword
        Test.setCurrentPage(Page.knowledgeSearch);
        controller.currentCategory = 'apples';
        controller.currentKeyword = 'pears';
        pg = controller.cleanKeyword();
        System.assertEquals('apples', controller.currentCategory);
        System.assertEquals('', controller.currentKeyword);
        System.assert(controller.getPage(pg.getUrl()).contains(controller.getProductPage()));
    }



    public class TestKnowledgeController extends KnowledgeController {}

}