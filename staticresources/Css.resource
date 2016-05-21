/* -------------- */
/* version: 20.0*/
/* skin: PortalDefault */
/* cssSheet: portal_template.css */
/* postfix:  */
/* spritesEnabled: false */


/* BEGIN Global */
body {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 80%;
}
/* Override empty related list header weirdness */
.list .headerRow .noRowsHeader {
    font-family: Arial, Helvetica, sans-serif;
}

/* END Global */

/* BEGIN Header */
body .primaryPalette,
body .primaryPalette a,
body .bPageTitle .secondaryPalette,
body .bPageTitle .secondaryPalette a,
body .secondaryPalette .lbHeader,
body .secondaryPalette .lbHeader a,
body .pbSubheader,
body .pbSubheader a {
    color: #2F436F;
    font-family: Arial, Helvetica, sans-serif;
}

/* Default base palette color */
.primaryPalette,
.secondaryPalette,
.tertiaryPalette,
.individualPalette .primaryPalette,
.individualPalette .secondaryPalette,
.individualPalette .tertiaryPalette,
.bPageBlock .pbFooter {
    background-color: #C8D7E3;
    border-color: #C8D7E3;
}
/* END Header */


/* BEGIN Portal Text Color */
body,
td,
select,
input,
textarea,
fieldset legend,
.warn .textCounter,
.miniTab .currentTab,
.requiredLegend,
.bPageBlock .noRecords,
.list td,
.list th,
.bPageBlock td.actionColumn .actionLink,
.bWizardBlock .pbDescription,
.bWizardBlock .pbTopButtons {
    color: #000000;
}

a,
.miniTab .currentTab a {
    color: #000000;
}
a:hover,
.miniTab .currentTab a:hover {
    color: #000000;
}

/* Override darkening in SFDC skin */
.pbBody,
.pbBody td,
.lbBodyDescription,
.list .headerRow .noRowsHeader {
    color: #000000;
}

.pbBody a,
.lbBody a {
    color: #000000;
}

.pbBody a:hover,
.lbBody a:hover {
    color: #000000;
}

/* END Portal Text Color */


/* BEGIN Tab Bar Navigation Styles */
.tabNavigation {
    background-image: url(/dimg/portalTopBg000000C8D7E3.gif);
    background-color: #FFFFFF;
}

.tab td {
    background-image: url(/dimg/portalTabLeftC8D7E3FFFFFF.gif);
    border-bottom-color: #000000;
}

.tab td div,
.tab .last div {
    background-image: url(/dimg/portalTabRightC8D7E3FFFFFF.gif);
}

.tab .currentTab {
    background-image: url(http://images.apple.com/global/nav/images/globalnav.png);
    border-right-color: #000000;
	margin: 0 0 10px 10px;
}

.tab .currentTab div {
    background-image: url(http://images.apple.com/global/nav/images/globalnav.png);
	margin: 0 0 10px 10px;
}

body .tab,
body .tab a {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}
body .currentTab,
body .currentTab a {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}
/* END Tab Bar Navigation Styles */

/* BEGIN Sidebar Modules */
.sidebarModule {
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}

.sidebarModuleHeader,
.nestedModule .sidebarModuleHeader {
    background-color: #C8D7E3;
    color: #2F436F;
    font-family: Arial, Helvetica, sans-serif;
}
.sidebarModuleHeader h1,
.sidebarModuleHeader h2,
.sidebarModuleHeader h3,
.sidebarModuleHeader h4,
.sidebarModuleHeader h5,
.sidebarModuleHeader h6 {
    font-family: Arial, Helvetica, sans-serif;
}
/* END Sidebar Modules */

/* BEGIN Content */
.bodyDiv {
    background-color: #FFFFFF;
    border-bottom: 2px solid #000000;
}

.requiredLegend {
    background-color: #F4F6F8;
}
/* END Content */

/* BEGIN Page Blocks */
.bPageBlock,
.individualPalette .bPageBlock {
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}

.bPageBlock .pbHeader {
    background-color: #C8D7E3;
}

.pbHeader .pbTitle h2,
.pbHeader .pbTitle h2 a,
.pbHeader .pbTitle h3,
.pbHeader .pbTitle h3 a,
.pbSubheader h3,
.pbSubheader h3 a {
    color: #2F436F;
    font-family: Arial, Helvetica, sans-serif;
}

.bPageBlock .labelCol,
.bPageBlock .labelCol a {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}

.bPageBlock .pbBody .pbSubsection .detailList .labelCol .noWrap{
    white-space: nowrap;
}

/* END Page Blocks */

/* BEGIN SubBlock */
.bSubBlock {
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}

.bSubBlock .lbHeader {
    background-color: #C8D7E3;
}
/* END SubBlock */

/* BEGIN Detail & Edit Pages */
.bPageBlock .detailList tr td, .bPageBlock .detailList tr th {
    border-bottom-color: #C8D7E3;
}

.detailPage .bPageBlock, .editPage .bPageBlock {
    border-top-width: 1px;
}

.detailPage .bRelatedList .bPageBlock,
.editPage .bRelatedList .bPageBlock {
    border-top-width: 1px;
}
/* END Detail & Edit Pages */

/* BEGIN List */
.list .headerRow th,
.list .headerRow th a {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    border-bottom-color: #C8D7E3;
}

.list td,
.list th,
body.oldForecast .list .last td,
body.oldForecast .list .last th {
    border-bottom:1px solid #C8D7E3;
}

.highlight td,
.highlight th {
    background-color: #C8D7E3;
}

/* END List */


/* BEGIN Lookup */
.lookupTab {
    background-color: #FFFFFF;
}
/* END Lookup */


/* BEGIN Calendar */
.homeCalendarEvents .event {
    border-top-color: #C8D7E3;
}

.mCalendar .header td {
    color: #2F436F;
    border-bottom-color: #C8D7E3;
    font-family: Arial, Helvetica, sans-serif;
}
/* END Calendar */

/* BEGIN Report */

.reportTab .csvSetup .pbSubheader,
.reportTab .csvSetup .bPageBlock .pbSubheader,
.reportTab .bGeneratedReport .bPageBlock .pbSubheader {
    background-color: #C8D7E3;
    border-color: #C8D7E3;
}

.reportTab .csvSetup,
.reportTab .csvSetup .bPageBlock,
.reportTab .csvSetup .bPageBlock .pbHeader,
.reportTab .csvSetup .bPageBlock .detailList tr td,
.reportTab .csvSetup .bPageBlock .detailList tr th {
    background-color: #FFFFFF;
    border: none;
}

/* END Report */

/* BEGIN Color Correction */
/*
 * Overrides to handle non-standard color palettes
 */
.bMyCalendar .primaryPalette,
.bMyCalendar .secondaryPalette,
.bMultiuserCalendar .primaryPalette,
.bMultiuserCalendar .secondaryPalette {
    background-color: #C8D7E3;
    border-color: #C8D7E3;
}

.bMyCalendar .bPageBlock,
.bMultiuserCalendar .bPageBlock,
.bMyDashboard .bPageBlock {
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}
/* END Color Correction */

/* BEGIN Knowledge Article Renderers */

.knowledgeTabPanel ul.x-tab-strip-top {
    background-image: url(/dimg/portalTopBg000000C8D7E3.gif);
    background-repeat: repeat-x;
    background-position: bottom;
    padding-bottom: 10px;
    background-color: #FFFFFF;
}

.knowledgeTabPanel .x-tab-strip-top  .x-tab-right {
    background-image: url(/dimg/portalTabLeftC8D7E3FFFFFF.gif);
    background-position: 0 0;
    border-bottom-color: #000000;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    padding-left: 3px;
}

.knowledgeTabPanel .x-tab-strip-top  .x-tab-strip-inner {
    background-image: url(/dimg/portalTabRightC8D7E3FFFFFF.gif);
    background-position: 0 0;
}

.knowledgeTabPanel .x-tab-strip-top  .x-tab-left {
    background-image: url(/dimg/portalTabRightC8D7E3FFFFFF.gif);
    background-position: 0 0;
    border-right-color: #C8D7E3;
    border-right-width: 1px;
    border-right-style: solid;
    padding-left: 7px;
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-text {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-active .x-tab-right {
    background: url(/dimg/portalTabActiveRight000000C8D7E3.gif);
    border-left-color: #000000;
    border-left-width: 1px;
    border-left-style: solid;
    border-bottom-style: none;
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-active .x-tab-strip-inner {
    background: url(/dimg/portalTabActiveRight000000C8D7E3.gif);
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-active .x-tab-left {
    background: url(/dimg/portalTabActiveRight000000C8D7E3.gif);
    border-right-color: #000000;
    border-right-width: 1px;
    border-right-style: solid;
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-active .x-tab-strip-text {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}

.knowledgeTabPanel .bPageBlock, .knowledgeTabPanel .individualPalette .bPageBlock {
    border-top-style: none;
}

.knowledgeTOCRendererSections {
    background-color: #FFFFFF;
}

.knowledgeTOCRendererSections .knowledgeTOCRendererSection.selected {
    background-color: #C8D7E3;
    color: #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-bottom: 1px solid #000000;
    border-top: 1px solid #000000;
}

.knowledgeTOCRendererContent .sectionName.selected td {
    color: #000000;
}

.knowledgeTOCRendererContent .sectionName.selected {
    background-color: #C8D7E3;
    color: #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}

.knowledgeTOCRendererSections .knowledgeTOCRendererSection {
    background-color: #FFFFFF;
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    border-left: 1px solid #C8D7E3;
    border-right: 1px solid #C8D7E3;
    border-bottom: 1px solid #C8D7E3;
}

.knowledgeTOCRendererContent .sectionName {
    background-color: #FFFFFF;
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
    border-bottom: 1px solid #000000;
}

.knowledgeTOCRendererContent, .knowledgeTOCRendererContentDiv, .knowledgeTOCRendererContentDiv .sectionContent {
    background-color: #FFFFFF;
}

.knowledgeTOCRendererContent .sectionContent {
    background-image: none;
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
}

/* END Knowledge Article Renderers */

/* START Answers */

.ansContent a {
    color: #000000;
}

.ansQuestionDetailsOnList .ansQuestionPrimary, .ansReplyPrimary, .ansActivityPrimary,
    .ansBestReply .ansReplyPrimary {
    border-color: #C8D7E3;
}

form.ansAskQuestionBox label, .ansCategoriesLabel {
    color: #000000;
}

.ansAskQuestionContainer {
    background: none;
}

.ansReplyListAndPostContainer {
    background: none;
}

.ansHomeRecentlyAsked h2, .ansHomeRecentlyReplied h2, .ansHomeStillOpen h2 {
    color: #2F436F;
}

/* END Answers */

/* -------------- */
/* version: 20.0*/
/* skin: PortalDefault */
/* cssSheet: portal_template.css */
/* postfix:  */
/* spritesEnabled: false */


/* BEGIN Global */
body {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 80%;
}
/* Override empty related list header weirdness */
.list .headerRow .noRowsHeader {
    font-family: Arial, Helvetica, sans-serif;
}

/* END Global */

/* BEGIN Header */
body .primaryPalette,
body .primaryPalette a,
body .bPageTitle .secondaryPalette,
body .bPageTitle .secondaryPalette a,
body .secondaryPalette .lbHeader,
body .secondaryPalette .lbHeader a,
body .pbSubheader,
body .pbSubheader a {
    color: #2F436F;
    font-family: Arial, Helvetica, sans-serif;
}

/* Default base palette color */
.primaryPalette,
.secondaryPalette,
.tertiaryPalette,
.individualPalette .primaryPalette,
.individualPalette .secondaryPalette,
.individualPalette .tertiaryPalette,
.bPageBlock .pbFooter {
    background-color: #C8D7E3;
    border-color: #C8D7E3;
}
/* END Header */


/* BEGIN Portal Text Color */
body,
td,
select,
input,
textarea,
fieldset legend,
.warn .textCounter,
.miniTab .currentTab,
.requiredLegend,
.bPageBlock .noRecords,
.list td,
.list th,
.bPageBlock td.actionColumn .actionLink,
.bWizardBlock .pbDescription,
.bWizardBlock .pbTopButtons {
    color: #000000;
}

a,
.miniTab .currentTab a {
    color: #000000;
}
a:hover,
.miniTab .currentTab a:hover {
    color: #000000;
}

/* Override darkening in SFDC skin */
.pbBody,
.pbBody td,
.lbBodyDescription,
.list .headerRow .noRowsHeader {
    color: #000000;
}

.pbBody a,
.lbBody a {
    color: #000000;
}

.pbBody a:hover,
.lbBody a:hover {
    color: #000000;
}

/* END Portal Text Color */


/* BEGIN Tab Bar Navigation Styles */
.tabNavigation {
    background-image: url(/dimg/portalTopBg000000C8D7E3.gif);
    background-color: #FFFFFF;
}

.tab td {
    background-image: url(/dimg/portalTabLeftC8D7E3FFFFFF.gif);
    border-bottom-color: #000000;
}

.tab td div,
.tab .last div {
    background-image: url(/dimg/portalTabRightC8D7E3FFFFFF.gif);
}

.tab .currentTab {
    background-image: url(/dimg/portalTabLeft000000C8D7E3.gif);
    border-right-color: #000000;
}

.tab .currentTab div {
    background-image: url(/dimg/portalTabActiveRight000000C8D7E3.gif);
}

body .tab,
body .tab a {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}
body .currentTab,
body .currentTab a {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}
/* END Tab Bar Navigation Styles */

/* BEGIN Sidebar Modules */
.sidebarModule {
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}

.sidebarModuleHeader,
.nestedModule .sidebarModuleHeader {
    background-color: #C8D7E3;
    color: #2F436F;
    font-family: Arial, Helvetica, sans-serif;
}
.sidebarModuleHeader h1,
.sidebarModuleHeader h2,
.sidebarModuleHeader h3,
.sidebarModuleHeader h4,
.sidebarModuleHeader h5,
.sidebarModuleHeader h6 {
    font-family: Arial, Helvetica, sans-serif;
}
/* END Sidebar Modules */

/* BEGIN Content */
.bodyDiv {
    background-color: #FFFFFF;
    border-bottom: 2px solid #000000;
}

.requiredLegend {
    background-color: #F4F6F8;
}
/* END Content */

/* BEGIN Page Blocks */
.bPageBlock,
.individualPalette .bPageBlock {
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}

.bPageBlock .pbHeader {
    background-color: #C8D7E3;
}

.pbHeader .pbTitle h2,
.pbHeader .pbTitle h2 a,
.pbHeader .pbTitle h3,
.pbHeader .pbTitle h3 a,
.pbSubheader h3,
.pbSubheader h3 a {
    color: #2F436F;
    font-family: Arial, Helvetica, sans-serif;
}

.bPageBlock .labelCol,
.bPageBlock .labelCol a {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}

.bPageBlock .pbBody .pbSubsection .detailList .labelCol .noWrap{
    white-space: nowrap;
}

/* END Page Blocks */

/* BEGIN SubBlock */
.bSubBlock {
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}

.bSubBlock .lbHeader {
    background-color: #C8D7E3;
}
/* END SubBlock */

/* BEGIN Detail & Edit Pages */
.bPageBlock .detailList tr td, .bPageBlock .detailList tr th {
    border-bottom-color: #C8D7E3;
}

.detailPage .bPageBlock, .editPage .bPageBlock {
    border-top-width: 1px;
}

.detailPage .bRelatedList .bPageBlock,
.editPage .bRelatedList .bPageBlock {
    border-top-width: 1px;
}
/* END Detail & Edit Pages */

/* BEGIN List */
.list .headerRow th,
.list .headerRow th a {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    border-bottom-color: #C8D7E3;
}

.list td,
.list th,
body.oldForecast .list .last td,
body.oldForecast .list .last th {
    border-bottom:1px solid #C8D7E3;
}

.highlight td,
.highlight th {
    background-color: #C8D7E3;
}

/* END List */


/* BEGIN Lookup */
.lookupTab {
    background-color: #FFFFFF;
}
/* END Lookup */


/* BEGIN Calendar */
.homeCalendarEvents .event {
    border-top-color: #C8D7E3;
}

.mCalendar .header td {
    color: #2F436F;
    border-bottom-color: #C8D7E3;
    font-family: Arial, Helvetica, sans-serif;
}
/* END Calendar */

/* BEGIN Report */

.reportTab .csvSetup .pbSubheader,
.reportTab .csvSetup .bPageBlock .pbSubheader,
.reportTab .bGeneratedReport .bPageBlock .pbSubheader {
    background-color: #C8D7E3;
    border-color: #C8D7E3;
}

.reportTab .csvSetup,
.reportTab .csvSetup .bPageBlock,
.reportTab .csvSetup .bPageBlock .pbHeader,
.reportTab .csvSetup .bPageBlock .detailList tr td,
.reportTab .csvSetup .bPageBlock .detailList tr th {
    background-color: #FFFFFF;
    border: none;
}

/* END Report */

/* BEGIN Color Correction */
/*
 * Overrides to handle non-standard color palettes
 */
.bMyCalendar .primaryPalette,
.bMyCalendar .secondaryPalette,
.bMultiuserCalendar .primaryPalette,
.bMultiuserCalendar .secondaryPalette {
    background-color: #C8D7E3;
    border-color: #C8D7E3;
}

.bMyCalendar .bPageBlock,
.bMultiuserCalendar .bPageBlock,
.bMyDashboard .bPageBlock {
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}
/* END Color Correction */

/* BEGIN Knowledge Article Renderers */

.knowledgeTabPanel ul.x-tab-strip-top {
    background-image: url(/dimg/portalTopBg000000C8D7E3.gif);
    background-repeat: repeat-x;
    background-position: bottom;
    padding-bottom: 10px;
    background-color: #FFFFFF;
}

.knowledgeTabPanel .x-tab-strip-top  .x-tab-right {
    background-image: url(/dimg/portalTabLeftC8D7E3FFFFFF.gif);
    background-position: 0 0;
    border-bottom-color: #000000;
    border-bottom-width: 1px;
    border-bottom-style: solid;
    padding-left: 3px;
}

.knowledgeTabPanel .x-tab-strip-top  .x-tab-strip-inner {
    background-image: url(/dimg/portalTabRightC8D7E3FFFFFF.gif);
    background-position: 0 0;
}

.knowledgeTabPanel .x-tab-strip-top  .x-tab-left {
    background-image: url(/dimg/portalTabRightC8D7E3FFFFFF.gif);
    background-position: 0 0;
    border-right-color: #C8D7E3;
    border-right-width: 1px;
    border-right-style: solid;
    padding-left: 7px;
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-text {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-active .x-tab-right {
    background: url(/dimg/portalTabActiveRight000000C8D7E3.gif);
    border-left-color: #000000;
    border-left-width: 1px;
    border-left-style: solid;
    border-bottom-style: none;
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-active .x-tab-strip-inner {
    background: url(/dimg/portalTabActiveRight000000C8D7E3.gif);
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-active .x-tab-left {
    background: url(/dimg/portalTabActiveRight000000C8D7E3.gif);
    border-right-color: #000000;
    border-right-width: 1px;
    border-right-style: solid;
}

.knowledgeTabPanel .x-tab-strip-top .x-tab-strip-active .x-tab-strip-text {
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
}

.knowledgeTabPanel .bPageBlock, .knowledgeTabPanel .individualPalette .bPageBlock {
    border-top-style: none;
}

.knowledgeTOCRendererSections {
    background-color: #FFFFFF;
}

.knowledgeTOCRendererSections .knowledgeTOCRendererSection.selected {
    background-color: #C8D7E3;
    color: #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-bottom: 1px solid #000000;
    border-top: 1px solid #000000;
}

.knowledgeTOCRendererContent .sectionName.selected td {
    color: #000000;
}

.knowledgeTOCRendererContent .sectionName.selected {
    background-color: #C8D7E3;
    color: #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
}

.knowledgeTOCRendererSections .knowledgeTOCRendererSection {
    background-color: #FFFFFF;
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    border-left: 1px solid #C8D7E3;
    border-right: 1px solid #C8D7E3;
    border-bottom: 1px solid #C8D7E3;
}

.knowledgeTOCRendererContent .sectionName {
    background-color: #FFFFFF;
    color: #000000;
    font-family: Arial, Helvetica, sans-serif;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
    border-top: 1px solid #000000;
    border-bottom: 1px solid #000000;
}

.knowledgeTOCRendererContent, .knowledgeTOCRendererContentDiv, .knowledgeTOCRendererContentDiv .sectionContent {
    background-color: #FFFFFF;
}

.knowledgeTOCRendererContent .sectionContent {
    background-image: none;
    background-color: #F4F6F8;
    border-bottom: 1px solid #000000;
    border-left: 1px solid #000000;
    border-right: 1px solid #000000;
}

/* END Knowledge Article Renderers */

/* START Answers */

.ansContent a {
    color: #000000;
}

.ansQuestionDetailsOnList .ansQuestionPrimary, .ansReplyPrimary, .ansActivityPrimary,
    .ansBestReply .ansReplyPrimary {
    border-color: #C8D7E3;
}

form.ansAskQuestionBox label, .ansCategoriesLabel {
    color: #000000;
}

.ansAskQuestionContainer {
    background: none;
}

.ansReplyListAndPostContainer {
    background: none;
}

.ansHomeRecentlyAsked h2, .ansHomeRecentlyReplied h2, .ansHomeStillOpen h2 {
    color: #2F436F;
}

/* END Answers */
