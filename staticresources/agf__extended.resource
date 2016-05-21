@font-face {font-family: "Salesforce Sans";src: url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-Light.woff2") format("woff2"), url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-Light.woff") format("woff");font-weight: 300;}
@font-face {font-family: "Salesforce Sans";src: url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-LightItalic.woff2") format("woff2"), url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-LightItalic.woff") format("woff");font-style: italic;font-weight: 300;}
@font-face {font-family: "Salesforce Sans";src: url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-Regular.woff2") format("woff2"), url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-Regular.woff") format("woff");font-weight: 400;}
@font-face {font-family: "Salesforce Sans";src: url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-Italic.woff2") format("woff2"), url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-Italic.woff") format("woff");font-style: italic;font-weight: 400;}
@font-face {font-family: "Salesforce Sans";src: url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-Bold.woff2") format("woff2"), url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-Bold.woff") format("woff");font-weight: 700;}
@font-face {font-family: "Salesforce Sans";src: url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-BoldItalic.woff2") format("woff2"), url("/resource/agf__SLDS_assets/fonts/webfonts/SalesforceSans-BoldItalic.woff") format("woff");font-style: italic;font-weight: 700;}

/* Needed when framed in SFX */
html > body.slds{padding:0 !important;background:#fff !important;}

/* font fixes */
html > body.slds,
html > body.sfdcBody slds,
html > body .slds,
html > body.sfdcBody .slds,
html > body.slds td,
html > body .slds td{font-family:"Salesforce Sans", Arial, sans-serif !important;font-size:.875rem;line-height:1.375;color:#16325c;/*-webkit-font-smoothing:antialiased;*/}
html > body.slds .x-btn button,
html > body.slds .btn,
html > body.slds .btnImportant,
html > body.slds .btnDisabled,
html > body.slds .btnCancel,
html > body.slds .menuButton .menuButtonButton,
html > body.slds .menuButton .menuButtonMenu a,
html > body.slds .menuButton .menuButtonMenu input.theOption,
html > body.slds h1,
html > body.slds h2,
html > body.slds h3,
html > body.slds h4,
html > body.slds h5,
html > body.slds h6{font-family:"Salesforce Sans", Arial, sans-serif;}

/* <chatter:feed> */
html > body.slds input#publishersharebutton{background-color:#0070D2 !important;border-color:#0070D2 !important;color:#FFF !important;transition: background .5s ease,opacity .5s ease .5s;}
html > body.slds input#publishersharebutton:hover{background-color:#005FB2 !important;color:#FFF !important;transition: background .5s ease,opacity .5s ease .5s;}
html > body.slds .chatter-avatar .chatter-photo,
html > body.slds .chatter-avatar .chatter-avatarStyle,
html > body.slds .feedcontainer .feeditemusericon{width:1.5rem;height:1.5rem;border-radius:1.5rem;overflow:hidden;background-image:none;}
html > body.slds span.chatter-avatarInline.chatter-avatarTiny.userLinkIconImage.chatter-avatar{width:1.5rem;height:1.5rem;margin-right:0.4rem;}
html > body.slds .defaultState #publishersharebutton{display:none !important;}
html > body.slds .feedcontainer{max-width:none;font-size:13px;}
html > body.slds .feedcontainer .feeditemcontent{margin-left:32px;}
html > body.slds .feedcontainer .feeditem .preamblecontainer{line-height:1.75em;}
html > body.slds .feedcontainer .feeditemcommentphoto img{border-radius:15px;}
html > body.slds .publishercontainer{border:1px solid #D8DDE6;padding:0px;border-radius:.25rem;margin-bottom:10px;}
html > body.slds .publisherWrapper{margin-top:-1px;border-top:1px solid #D8DDE6;padding:15px;border-top-left-radius:0;border-top-right-radius:0;}
html > body.slds .defaultState .publisherTextAreaInner{margin-right:0;}
html > body.slds .publishercontainer .publisherTextAreaInner{background-image:none !important;padding-top:9px;padding-bottom:9px;border:1px solid #D8DDE6;}
html > body.slds .publishercontainer .contentPublisherSlideDown table.postInput{width:100%;}
html > body.slds .contentPublisherSlideDown table.postInput td{padding-right:10px;}
html > body.slds .publishercontainer input[type="text"],
html > body.slds .publishercontainer .LinkPost input[type="text"]{width:100%;}
html > body.slds .publishercontainer .customPanel,
html > body.slds .publishercontainer input[type="text"]{background-image:none;}
html > body.slds .contentPublisherSlideDown .panelBody{padding-left:10px;padding-right:10px;}
html > body.slds .defaultState .TextPost .publisherTextAreaInner,
html > body.slds .publishercontainer .alignTop .publisherTextAreaInner{border-radius:.25rem;}
html > body.slds .publishercontainer .publishertextarea{color:#D5D5D5;}
html > body.slds .publishercontainer .publishertextareafocus{color:#222;}
html > body.slds .publishercontainer .bottomBar{height:40px;}
html > body.slds .publishercontainer ul.publisherFeedItemTypeChoices{margin-bottom:0;height:auto;background-color:#F4F6F9;border-top-right-radius:.25rem;font-size:0;}
html > body.slds .publishercontainer li.publisherFeedItemTypeChoice{display:inline-block;height:auto;margin-right:0;margin-left:-1px;}
html > body.slds .publishercontainer li.publisherFeedItemTypeChoice:first-child{border-top-left-radius:.25rem;}
html > body.slds .zen .publisherTypeOverflow{height:auto;max-width:none;}
html > body.slds .publishercontainer .withArrowAttached span.pArrow,
html > body.slds .zen .publisherTypeOverflow.withArrowAttached span.pArrow{display:none;}
html > body.slds .zen .publisherTypeOverflow.zen-select.zen-open{padding:0;margin:0 0 0 5px;background:none;border:0;top:-1px;}
html > body.slds .zen .publisherTypeOverflow.zen-select.zen-open.withArrowAttached{margin:0 0 0 5px;background:none;border:0;}
html > body.slds .zen .publisherTypeOverflow.zen-select.withArrowAttached{background-color:#fff;color:#0070D2;border-left:1px solid #D8DDE6;border-right:1px solid #D8DDE6;z-index:1;}
html > body.slds .publishercontainer .quickActionPanel select,
html > body.slds .publishercontainer .quickActionPanel .zen-select{background:#fff;}
html > body.slds .publishercontainer a.publisherattach{height:auto;}
html > body.slds .publishercontainer .bottomBar{padding:9px 0px;background:none;border:none;}
html > body.slds .publishercontainer .publisherFeedItemTypeChoices a.publisherattach{font-weight:normal;padding:10px 25px;text-decoration:none;font-size:.875rem;color:#54698D;border-left:1px solid #F4F6F9;border-right:1px solid #F4F6F9;}
html > body.slds .publishercontainer li.publisherFeedItemTypeChoice:first-child > a{border-top-left-radius:.25em;border-left:1px solid #D8DDE6;}
html > body.slds .zen .publisherTypeOverflow.zen-select{font-weight:normal;padding:10px 10px 6px 25px;text-decoration:none;font-size:.875rem;color:#54698D;top:0;margin:0;}
html > body.slds .publisherTypeOverflow span{color:#54698D;}
html > body.slds .zen .publisherTypeOverflow .zen-trigger{padding-left:0;height:auto;}
html > body.slds .zen .publisherTypeOverflow.zen-open .zen-trigger{bottom:0px;padding:10px 19px;background-color:#fff;}
html > body.slds .zen .publisherTypeOverflow.zen-open.withArrowAttached .zen-trigger{padding:10px 20px;}
html > body.slds .chatterPublisherActionsContainer td a{font-size:.7rem;}
html > body.slds .publisherTypeOverflow.zen-select a.publisherattach:link .publisherattachtext{font-size:.75rem;}
html > body.slds .publishercontainer .publisherFeedItemTypeChoices a.publisherattach.withArrowAttached{color:#0070D2;background-color:#fff;border-left:1px solid #D8DDE6;border-right:1px solid #D8DDE6;z-index:1;position:relative;border-bottom:1px #fff;}
html > body.slds .publishercontainer .quickActionPanel textarea,
html > body.slds .publishercontainer .quickActionPanel input[type="text"]{-webkit-box-shadow:none;box-shadow:none;}
html > body.slds .publishercontainer a.publisherattach span,
html > body.slds a.cxcontentcommentaction span{margin-left:0;line-height:normal;}
html > body.slds .publishercontainer .publisherFeedItemTypeChoices a.publisherattach:hover span,
html > body.slds a.cxcontentcommentaction:hover span{text-decoration:none;}
html > body.slds .contentPublisherSlideDown table.postInput label,
html > body.slds .contentPublisherSlideDown div.sharedWithOptionPanel label,
html > body.slds .publishercontainer .customPanel label,
html > body.slds .publisherpollchoices label.publisherpollchoicelabel{color:#16325C;font-weight:normal;font-size:.75rem;}
html > body.slds a.publisherattach img{display:none;}
html > body.slds .contentPublisherSlideDown td a:hover,
html > body.slds .contentPublisherSlideDown td a.ahover{background-color:#F4F6F9;text-decoration:none;}
html > body.slds .truncateLabelWrapper,
html > body.slds span.truncateLabel{max-width:none;}
html > body.slds .contentPublisherSlideDown tr > td a{overflow:auto;white-space:normal;min-width:0;max-width:none;border-radius:0;border-left:0;margin:0;}
html > body.slds .contentPublisherSlideDown td.chatterPublisherFileActionContainerLeft a{margin:0;}
html > body.slds .contentPublisherSlideDown tr > td:first-child a{border-top-left-radius:.25rem;border-bottom-left-radius:.25rem;border-left:1px solid #C7CCCE;}
html > body.slds .contentPublisherSlideDown tr > td:last-child a{border-top-right-radius:.25rem;border-bottom-right-radius:.25rem;}
html > body.slds .zen .zen-options a:hover,
html > body.slds .zen .zen-options a:focus,
html > body.slds .zen .zen-options a:active{background-color:#F4F6F9;}
html > body.slds .zen .publisherTypeOverflow.withArrowAttached .zen-trigger .publisherattachtext{color:#0070D2;}
html > body.slds .feedcontainer .feeditem .feedcommentuser a,
html > body.slds .feedcontainer .feeditem .feeditemfirstentity a,
html > body.slds .feedcontainer .feeditem .feeditemfirstentity,
html > body.slds .feedcontainer .feeditem .showmorefeeditemscontainer a,
html > body.slds .feedcontainer .feeditem .actorentitylink{font-weight:normal;}

/* buttons */
html > body.slds input.btn:not(.slds-button),
html > body.slds button.customButton,
html > body.slds .bRelatedList .bPageBlock .pbButton input.btn,
html > body.slds .bRelatedList .bPageBlock .pbButton input.btnDisabled,
html > body.homeTab .bMyCalendar .pbButton input.btn,
html > body.homeTab .bMyDashboard .pbButton input.btn,
html > body.slds .sidebarModuleBody input.btn,
html > body.slds .bFilterView input.btn,
html > body.slds input#publishersharebutton{font-family:"Salesforce Sans", Arial, sans-serif;height:auto;box-shadow:none;margin:0;text-align:center;vertical-align:middle;border:1px solid #D8DDE6;background:#FFF;position:relative;display:inline-block;padding:0 1rem 0 1rem;background-clip:padding-box;border-radius:0.25rem;color:#0070D2;font-size:14px;font-weight:normal;line-height:2.125rem;text-decoration:none;-webkit-appearance:none;-webkit-user-select:none;-moz-user-select:none;-ms-user-select:none;user-select:none;-webkit-transition:color 0.05s linear,background-color 0.05s linear;transition:color 0.05s linear,background-color 0.05s linear;cursor:pointer;text-transform:none;overflow:visible;}
html > body.slds input.btn:not(.slds-button):hover,
html > body.slds input.btn:not(.slds-button):focus,
html > body.slds button.customButton:hover,
html > body.slds button.customButton.btn:focus,
html > body.slds .bRelatedList .bPageBlock .pbButton input.btn:hover,
html > body.slds .bRelatedList .bPageBlock .pbButton input.btn:focus,
html > body.homeTab .bMyCalendar .pbButton input.btn:hover,
html > body.homeTab .bMyCalendar .pbButton input.btn:focus,
html > body.homeTab .bMyDashboard .pbButton input.btn:hover,
html > body.homeTab .bMyDashboard .pbButton input.btn:focus,
html > body.slds .sidebarModuleBody input.btn:hover,
html > body.slds .sidebarModuleBody input.btn:focus,
html > body.slds .bFilterView input.btn:hover,
html > body.slds .bFilterView input.btn:focus,
html > body.slds input#publishersharebutton:hover,
html > body.slds input#publishersharebutton:focus{background-color:#F4F6F9;color:#005FB2;}
html > body.slds input.btn:hover,
html > body.slds input.btn:focus,
html > body.slds button.customButton:hover,
html > body.slds button.customButton:focus,
html > body.slds input.btn:active,
html > body.slds input.btn:visited{text-decoration:none;}
html > body.slds input.btn[disabled],
html > body.slds input.btnDisabled{background-color: #FFF;cursor: default;color: #E0E5EE;}

/* button submit (brand color) */
html > body.slds input.btn[name=save],
html > body.slds input.btn[name=inlineEditSave]{background-color:#0070D2;border:1px solid #0070D2;color:#FFF;}
html > body.slds input.btn[name=save]:hover,
html > body.slds input.btn[name=inlineEditSave]:hover{background-color:#005FB2;color:#FFF;}

/* page header */
html > body.slds .outer .oRight{padding:0;}
html > body.slds .bPageTitle{margin:0;padding:0;}
html > body.slds .bPageTitle .ptBody{color:#16325C;}
html > body.slds .bPageTitle .ptBody .links a,
html > body.slds .bPageTitle .ptBody .links .configLinks,
html > body.slds .bPageTitle .ptBody .links .helpLink{color:#777;text-decoration:none;font-size:0.75rem;}
html > body.slds .bPageTitle .ptBody .links a:hover,
html > body.slds .bPageTitle .ptBody .links .configLinks:hover,
html > body.slds .bPageTitle .ptBody .links .helpLink:hover{color:#777;text-decoration:underline;font-size:0.75rem;}	
html > body.slds .sidebarCell.sidebarCollapsed{padding:0px;}
html > body.slds .bPageTitle .ptBody{background:#F4F6F9;border-bottom:1px solid #D8DDE6;}
html > body.slds .bPageTitle .ptBody .content{padding:24px;width:auto;}
html > body.slds .bPageTitle .ptBody .links{padding:15px;color:#F4F6F9;}
html > body.slds .bPageTitle .ptBody .pageType{font-size:0.75rem;line-height:1.25;text-transform:uppercase;letter-spacing:0.0625em;color:#54698D;}
html > body.slds .bPageTitle .ptBody .pageDescription{font-size:1.8em;font-weight:200;line-height:1.1em}
html > body.slds .bPageTitle .ptBody .pageType,
html > body.slds .bPageTitle .ptBody .pageDescription{margin-left:58px;}
html > body.slds .bPageTitle .ptBody .pageTitleIcon{background-color:#8299AE;background-image:url('/resource/agf__SLDS_assets/icons/standard/default.svg');margin-top:0;background-size:cover;background-position:0px 0px;width:3rem;height:3rem;border-radius:0.25rem;}
html > body.slds .bPageTitle .ptBody .links .helpIcon,
html > body.slds .bWizardBlock .helpIcon{display:none;mask:url('/resource/agf__SLDS_assets/assets/icons/utility/help.svg') top left / cover;-webkit-mask:url('/resource/agf__SLDS_assets/assets/icons/utility/help.svg') top left / cover;width:12px;height:12px;background-color:#777;background-image:none;vertical-align:middle;}
html > body.slds .bPageTitle .ptBody .links .helpLink,
html > body.slds .bWizardBlock .helpLink,
html > body.slds .bEditBlock .booleanFilterTopMargin .helpLink,
html > body.slds .bPageBlock .pbBody .pbSubblock .pbSubbody .helpLink{padding-right:0;}

/* page block header */
html > body.slds .bPageBlock,
html > body.slds .secondaryPalette.bPageBlock{border:0;background:none;}
html > body.slds .bEditBlock .pbHeader>table{border:0;}
html > body.slds h1,
html > body.slds h2,
html > body.slds h3,
html > body.slds h4,
html > body.slds h5,
html > body.slds h6{font-weight:normal;}

/* custom page icons */
html > body.opportunityTab .bPageTitle .ptBody .pageTitleIcon{background-color:#FCB051;background-image:url('/resource/agf__SLDS_assets/icons/standard/opportunity.svg');}
html > body.caseTab .bPageTitle .ptBody .pageTitleIcon{background-color:#F1CE64;background-image:url('/resource/agf__SLDS_assets/icons/standard/case.svg');}
html > body.solutionTab .bPageTitle .ptBody .pageTitleIcon{background-color:#91C876;background-image:url('/resource/agf__SLDS_assets/icons/standard/solution.svg');}
html > body.accountTab .bPageTitle .ptBody .pageTitleIcon{background-color:#808FDF;background-image:url('/resource/agf__SLDS_assets/icons/standard/account.svg');}
html > body.Custom1Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#FF6F79;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom1.svg');}
html > body.Custom2Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#CFD05C;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom2.svg');}
html > body.Custom3Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E9AB61;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom3.svg');}
html > body.Custom4Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#DDD347;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom4.svg');}
html > body.Custom5Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#95D65B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom5.svg');}
html > body.Custom6Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#4ABC68;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom6.svg');}
html > body.Custom7Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#5F7EE1;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom7.svg');}
html > body.Custom8Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#46C7B0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom8.svg');}
html > body.Custom9Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#6094DE;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom9.svg');}
html > body.Custom10Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#597DDF;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom10.svg');}
html > body.Custom11Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#7B79E7;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom11.svg');}
html > body.Custom12Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#D766CB;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom12.svg');}
html > body.Custom13Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#DB5679;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom13.svg');}
html > body.Custom14Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#34BAAA;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom14.svg');}
html > body.Custom15Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F6726A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom15.svg');}
html > body.Custom16Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E6A55C;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom16.svg');}
html > body.Custom17Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#A3CD55;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom17.svg');}
html > body.Custom18Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#44C36B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom18.svg');}
html > body.Custom19Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#32B6A8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom19.svg');}
html > body.Custom20Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#3FC0C1;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom20.svg');}
html > body.Custom21Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#7F6FEA;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom21.svg');}
html > body.Custom22Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#7F7AF8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom22.svg');}
html > body.Custom23Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#A765E2;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom23.svg');}
html > body.Custom24Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E15C8D;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom24.svg');}
html > body.Custom25Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E064B6;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom25.svg');}
html > body.Custom26Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#6A8DEE;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom26.svg');}
html > body.Custom27Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#4FA7CC;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom27.svg');}
html > body.Custom28Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#89C059;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom28.svg');}
html > body.Custom29Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#BDD25F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom29.svg');}
html > body.Custom30Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F59F71;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom30.svg');}
html > body.Custom31Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E85D74;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom31.svg');}
html > body.Custom32Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#31BB88;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom32.svg');}
html > body.Custom33Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#8CC852;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom33.svg');}
html > body.Custom34Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#CF7F5F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom34.svg');}
html > body.Custom35Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E65873;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom35.svg');}
html > body.Custom36Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#CE67CE;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom36.svg');}
html > body.Custom37Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#817EF0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom37.svg');}
html > body.Custom38Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#53B6D7;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom38.svg');}
html > body.Custom39Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#45B66A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom39.svg');}
html > body.Custom40Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#78BF53;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom40.svg');}
html > body.Custom41Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#3AACAC;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom41.svg');}
html > body.Custom42Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#CFD05B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom42.svg');}
html > body.Custom43Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#7388F8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom43.svg');}
html > body.Custom44Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#C1C34E;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom44.svg');}
html > body.Custom45Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#D44D6E;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom45.svg');}
html > body.Custom46Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#5C9BE4;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom46.svg');}
html > body.Custom47Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#54C559;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom47.svg');}
html > body.Custom48Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#EF697F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom48.svg');}
html > body.Custom49Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#DE5175;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom49.svg');}
html > body.Custom50Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#49BCD3;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom50.svg');}
html > body.Custom51Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#D8C760;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom51.svg');}
html > body.Custom52Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#EE8E6F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom52.svg');}
html > body.Custom53Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F36E83;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom53.svg');}
html > body.Custom54Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#EA70B1;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom54.svg');}
html > body.Custom55Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#D66EE0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom55.svg');}
html > body.Custom56Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#6582E8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom56.svg');}
html > body.Custom57Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#5A9CDD;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom57.svg');}
html > body.Custom58Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#34B59D;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom58.svg');}
html > body.Custom59Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E3D067;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom59.svg');}
html > body.Custom60Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#BF5A88;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom60.svg');}
html > body.Custom61Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F4676B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom61.svg');}
html > body.Custom62Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#6B92DC;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom62.svg');}
html > body.Custom63Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#7CCF60;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom63.svg');}
html > body.Custom64Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#618FD8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom64.svg');}
html > body.Custom65Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F279AB;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom65.svg');}
html > body.Custom66Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#D8BE5F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom66.svg');}
html > body.Custom67Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F87D76;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom67.svg');}
html > body.Custom68Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F26979;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom68.svg');}
html > body.Custom69Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#ED6387;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom69.svg');}
html > body.Custom70Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E769B4;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom70.svg');}
html > body.Custom71Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E36EE3;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom71.svg');}
html > body.Custom72Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#8D9BFB;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom72.svg');}
html > body.Custom73Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#679EF0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom73.svg');}
html > body.Custom74Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#41C8A0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom74.svg');}
html > body.Custom75Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#C6945A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom75.svg');}
html > body.Custom76Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#DB6D7A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom76.svg');}
html > body.Custom77Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#B55D5B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom77.svg');}
html > body.Custom78Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#4F8AD8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom78.svg');}
html > body.Custom79Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#8ED363;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom79.svg');}
html > body.Custom80Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#659AD5;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom80.svg');}
html > body.Custom81Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#DA627F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom81.svg');}
html > body.Custom82Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#CB508C;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom82.svg');}
html > body.Custom83Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E7806F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom83.svg');}
html > body.Custom84Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F56470;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom84.svg');}
html > body.Custom85Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F26891;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom85.svg');}
html > body.Custom86Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#DE55A1;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom86.svg');}
html > body.Custom87Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#D876E5;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom87.svg');}
html > body.Custom88Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#996FE6;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom88.svg');}
html > body.Custom89Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#368EB6;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom89.svg');}
html > body.Custom90Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#22A48A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom90.svg');}
html > body.Custom91Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#BF7B66;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom91.svg');}
html > body.Custom92Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#517E82;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom92.svg');}
html > body.Custom93Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#904D4C;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom93.svg');}
html > body.Custom94Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#439CBA;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom94.svg');}
html > body.Custom95Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#8BCF6A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom95.svg');}
html > body.Custom96Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#6D9DE3;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom96.svg');}
html > body.Custom97Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#DD6085;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom97.svg');}
html > body.Custom98Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E1BE5C;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom98.svg');}
html > body.Custom99Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#F0856E;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom99.svg');}
html > body.Custom100Tab .bPageTitle .ptBody .pageTitleIcon{background-color:#E15D76;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom.svg');}

/* <chatter:follow> */
html > body.slds div[data-chatter-widget=subscribeBtn] > .zen-media:first-child{cursor:pointer;display:inline;background-color:#FFF;border:1px solid #D8DDE6;border-radius:.25rem;padding:6px 1rem 7px 1rem;}
html > body.slds div[data-chatter-widget=subscribeBtn] > .zen-media:first-child a{margin-top:-1px;text-decoration:none;}
html > body.slds div[data-chatter-widget=subscribeBtn] > .zen-media:first-child:hover{background-color:#F4F6F9;}
html > body.slds div[data-chatter-widget=subscribeBtn] > .zen-media:last-child{cursor:pointer;display:inline;border:1px solid rgba(0,0,0,0);border-radius:.25rem;padding:6px 1rem 7px 1rem;position:relative;}
html > body.slds div[data-chatter-widget=subscribeBtn] > .zen-media:last-child:hover{background-color:#F4F6F9;border:1px solid #D8DDE6;}
html > body.slds div[data-chatter-widget=subscribeBtn] .chatter-followIcon{mask:url('/resource/agf__SLDS_assets/icons/utility/add.svg') top left / cover;-webkit-mask:url('/resource/agf__SLDS_assets/icons/utility/add.svg') top left / cover;width:12px;height:12px;background-color:#0070D2;background-image:none;}
html > body.slds div[data-chatter-widget=subscribeBtn] .chatter-checkedIcon{mask:url('/resource/agf__SLDS_assets/icons/utility/check.svg') top left / cover;-webkit-mask:url('/resource/agf__SLDS_assets/icons/utility/check.svg') top left / cover;width:12px;height:12px;background-color:#0070D2;background-image:none;}
html > body.slds div[data-chatter-widget=subscribeBtn] > .zen-media:last-child:hover .chatter-checkedIcon{mask:url('/resource/agf__SLDS_assets/icons/utility/close.svg') top left / cover;-webkit-mask:url('/resource/agf__SLDS_assets/icons/utility/close.svg') top left / cover;}
html > body.slds div[data-chatter-widget=subscribeBtn] > .zen-media:last-child a{position:absolute;text-decoration:none;top:0;left:0;right:0;bottom:0;margin:0 !important;}
html > body.slds div[data-chatter-widget=subscribeBtn] > .zen-media:last-child a img{display:none;}
html > body.slds div[data-chatter-widget=subscribeBtn] .zen-mediaExt:after,
html > body.slds div[data-chatter-widget=subscribeBtn] .zen-mediaExt .zen-mediaBody:after{display:none;}

/* <apex:pageMessages> */
html > body.slds .message{border-radius:0;background-color:#54698D;padding:0.5rem;margin:0.5rem 0;border:0;font-size:1em;color:#fff;text-align:center;background-image:-webkit-linear-gradient(45deg, rgba(0, 0, 0, 0.035) 25%, rgba(0, 0, 0, 0) 25%, rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0.035) 50%, rgba(0, 0, 0, 0.035) 75%, rgba(0, 0, 0, 0) 75%, rgba(0, 0, 0, 0));background-image:linear-gradient(45deg, rgba(0, 0, 0, 0.035) 25%, rgba(0, 0, 0, 0) 25%, rgba(0, 0, 0, 0) 50%, rgba(0, 0, 0, 0.035) 50%, rgba(0, 0, 0, 0.035) 75%, rgba(0, 0, 0, 0) 75%, rgba(0, 0, 0, 0));background-size: 64px 64px;}
html > body.slds .message img{display:none;}
html > body.slds .message .messageText{margin:0;font-size:1em;color:#fff;text-align:center;}

/* <apex:relatedList> */
html > body.slds div.bRelatedList .bPageBlock,
html > body.slds div.apexp bPageBlock,
html > body.slds div.apexp secondaryPalette.bPageBlock,
html > body.slds div.apexp .individualPalette .secondaryPalette.bPageBlock{background:#F4F6F9;border:1px #D3D8E2 solid;padding:20px;border-radius:.25rem;margin:20px;}
html > body.slds .bRelatedList .bPageBlock,
html > body.slds .detailPage .bRelatedList .bPageBlock{border-top-width:1px;}
html > body.slds div.bRelatedList .pbHeader,
html > body.slds div.apexp .pbHeader{margin-bottom:13px;}
html > body.slds div.apexp .bPageBlock.apexDefaultPageBlock .pbHeader{border-bottom:0px;}
html > body.slds div.bRelatedList .pbHeader .pbTitle,
html > body.slds div.apexp .pbHeader .pbTitle{padding:0 5px;width:100%;height:36px;}
html > body.slds div.bRelatedList .pbHeader .pbTitle h3,
html > body.slds div.apexp .pbHeader .pbTitle h2,
html > body.slds div.apexp .pbHeader .pbTitle h3{font-size:1.125rem;font-weight:100;color:#152c51;margin:0;}
html > body.slds div.apexp .bPageBlock.apexDefaultPageBlock .pbHeader>table{border:0;}
html > body.slds div.bRelatedList .pbHeader .pbButton,
html > body.slds div.apexp .pbHeader .pbButton{text-align:right;padding:0;white-space:nowrap;font-size:0;}
html > body.slds div.bRelatedList .pbHeader .pbHelp,
html > body.slds div.apexp .pbHeader .pbHelp{display:none;}
html > body.slds div.bRelatedList .bPageBlock .pbBody,
html > body.slds div.apexp .bPageBlock .pbBody,
html > body.slds div.apexp .bPageBlock.apexDefaultPageBlock .pbBody{background:none;margin:0;color:#16325C;overflow-x:auto;}
html > body.slds div.bRelatedList .bPageBlock .pbButton input.btn,
html > body.slds div.apexp .bPageBlock .pbButton input.btn{border-radius:0;margin-left:-1px;margin-right:0px;}
html > body.slds div.bRelatedList .bPageBlock .pbButton input.btn:first-child,
html > body.slds div.apexp .bPageBlock .pbButton input.btn:first-child{border-top-left-radius:0.25rem;border-bottom-left-radius:0.25rem;}
html > body.slds div.bRelatedList .bPageBlock .pbButton input.btn:last-child,
html > body.slds div.apexp .bPageBlock .pbButton input.btn:last-child{border-top-right-radius:0.25rem;border-bottom-right-radius:0.25rem;}
html > body.slds div.bRelatedList .pbBody table.list,
html > body.slds div.apexp .pbBody table.list{border:0;background:none;}
html > body.slds div.bRelatedList .pbBody table.list tr.headerRow td,
html > body.slds div.bRelatedList .pbBody table.list tr.headerRow th,
html > body.slds div.apexp .pbBody table.list tr.headerRow td,
html > body.slds div.apexp .pbBody table.list tr.headerRow th{color:#54698D;font-size:.75rem;font-weight:400;}
html > body.slds div.bRelatedList .pbBody table.list .actionColumn,
html > body.slds div.apexp .pbBody table.list .actionColumn,{padding:0 7px;}
html > body.slds div.bRelatedList .pbBody table.list tr th,
html > body.slds div.bRelatedList .pbBody table.list tr td,
html > body.slds div.apexp .pbBody table.list tr th,
html > body.slds div.apexp .pbBody table.list tr td{background:#fff;border:0;border-top:1px #D8DDE6 solid;color:#16325C;font-size:.875rem;line-height:2.5;}
html > body.slds div.apexp .pbBody table.list tr td:first-child{padding-left:4px;}
html > body.slds div.bRelatedList .pbBody table.list tr.last th,
html > body.slds div.bRelatedList .pbBody table.list tr.last td,
html > body.slds div.apexp .pbBody table.list tr.last th,
html > body.slds div.apexp .pbBody table.list tr.last td{border-bottom:1px #D8DDE6 solid;}
html > body.slds div.bRelatedList .pbBody table.list tr.headerRow th,
html > body.slds div.apexp .pbBody table.list tr.headerRow th{background:#fff;border:0;border-top:1px #D8DDE6 solid;font-weight:normal;text-transform:uppercase;}
html > body.slds div.bRelatedList .pbBody table.list tr.dataRow.highlight th,
html > body.slds div.bRelatedList .pbBody table.list tr.dataRow.highlight td,
html > body.slds div.apexp .pbBody table.list tr.dataRow.highlight th,
html > body.slds div.apexp .pbBody table.list tr.dataRow.highlight td{background-color:#fff;}

/* related list icons */
html > body.slds .bRelatedList .pbTitle .relatedListIcon,html > body.slds .allTabTab .relatedListIcon{background-color:#8299AE;background-position:0px 0px !important;background-image:url('/resource/agf__SLDS_assets/icons/standard/default.svg');margin-top:-4px;background-size:cover;background-position:0px 0px;width:2rem;height:2rem;border-radius:0.25rem;margin-right:0.5rem;top:0;}
html > body.slds .bRelatedList .solutionBlock .relatedListIcon,html > body.slds .allTabTab .solutionBlock .relatedListIcon{background-color:#91C876;background-image:url('/resource/agf__SLDS_assets/icons/standard/solution.svg');}
html > body.slds .bRelatedList .opportunityBlock .relatedListIcon,html > body.slds .allTabTab .opportunityBlock .relatedListIcon{background-color:#FBB863;background-image:url('/resource/agf__SLDS_assets/icons/standard/opportunity.svg');}
html > body.slds .bRelatedList .caseBlock .relatedListIcon,html > body.slds .allTabTab .caseBlock .relatedListIcon{background-color:#F1CE64;background-image:url('/resource/agf__SLDS_assets/icons/standard/case.svg');}
html > body.slds .bRelatedList .contactBlock .relatedListIcon,html > body.slds .allTabTab .contactBlock .relatedListIcon{background-color:#A094ED;background-image:url('/resource/agf__SLDS_assets/icons/standard/contact.svg');}
html > body.slds .bRelatedList .Custom1Block .relatedListIcon,html > body.slds .allTabTab .Custom1Block .relatedListIcon{background-color:#FF7B84;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom1.svg');}
html > body.slds .bRelatedList .Custom2Block .relatedListIcon,html > body.slds .allTabTab .Custom2Block .relatedListIcon{background-color:#C9C952;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom2.svg');}
html > body.slds .bRelatedList .Custom3Block .relatedListIcon,html > body.slds .allTabTab .Custom3Block .relatedListIcon{background-color:#ECB46C;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom3.svg');}
html > body.slds .bRelatedList .Custom4Block .relatedListIcon,html > body.slds .allTabTab .Custom4Block .relatedListIcon{background-color:#E1D951;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom4.svg');}
html > body.slds .bRelatedList .Custom5Block .relatedListIcon,html > body.slds .allTabTab .Custom5Block .relatedListIcon{background-color:#9FDB66;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom5.svg');}
html > body.slds .bRelatedList .Custom6Block .relatedListIcon,html > body.slds .allTabTab .Custom6Block .relatedListIcon{background-color:#4ABC68;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom6.svg');}
html > body.slds .bRelatedList .Custom7Block .relatedListIcon,html > body.slds .allTabTab .Custom7Block .relatedListIcon{background-color:#5F7EE1;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom7.svg');}
html > body.slds .bRelatedList .Custom8Block .relatedListIcon,html > body.slds .allTabTab .Custom8Block .relatedListIcon{background-color:#50CEB9;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom8.svg');}
html > body.slds .bRelatedList .Custom9Block .relatedListIcon,html > body.slds .allTabTab .Custom9Block .relatedListIcon{background-color:#6094DE;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom9.svg');}
html > body.slds .bRelatedList .Custom10Block .relatedListIcon,html > body.slds .allTabTab .Custom10Block .relatedListIcon{background-color:#6488E3;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom10.svg');}
html > body.slds .bRelatedList .Custom11Block .relatedListIcon,html > body.slds .allTabTab .Custom11Block .relatedListIcon{background-color:#7B79E7;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom11.svg');}
html > body.slds .bRelatedList .Custom12Block .relatedListIcon,html > body.slds .allTabTab .Custom12Block .relatedListIcon{background-color:#DC71D1;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom12.svg');}
html > body.slds .bRelatedList .Custom13Block .relatedListIcon,html > body.slds .allTabTab .Custom13Block .relatedListIcon{background-color:#DF6184;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom13.svg');}
html > body.slds .bRelatedList .Custom14Block .relatedListIcon,html > body.slds .allTabTab .Custom14Block .relatedListIcon{background-color:#3CC2B3;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom14.svg');}
html > body.slds .bRelatedList .Custom15Block .relatedListIcon,html > body.slds .allTabTab .Custom15Block .relatedListIcon{background-color:#F77E75;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom15.svg');}
html > body.slds .bRelatedList .Custom16Block .relatedListIcon,html > body.slds .allTabTab .Custom16Block .relatedListIcon{background-color:#E9AF67;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom16.svg');}
html > body.slds .bRelatedList .Custom17Block .relatedListIcon,html > body.slds .allTabTab .Custom17Block .relatedListIcon{background-color:#ACD360;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom17.svg');}
html > body.slds .bRelatedList .Custom18Block .relatedListIcon,html > body.slds .allTabTab .Custom18Block .relatedListIcon{background-color:#44C36B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom18.svg');}
html > body.slds .bRelatedList .Custom19Block .relatedListIcon,html > body.slds .allTabTab .Custom19Block .relatedListIcon{background-color:#3ABEB1;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom19.svg');}
html > body.slds .bRelatedList .Custom20Block .relatedListIcon,html > body.slds .allTabTab .Custom20Block .relatedListIcon{background-color:#48C7C8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom20.svg');}
html > body.slds .bRelatedList .Custom21Block .relatedListIcon,html > body.slds .allTabTab .Custom21Block .relatedListIcon{background-color:#8A7AED;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom21.svg');}
html > body.slds .bRelatedList .Custom22Block .relatedListIcon,html > body.slds .allTabTab .Custom22Block .relatedListIcon{background-color:#8B85F9;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom22.svg');}
html > body.slds .bRelatedList .Custom23Block .relatedListIcon,html > body.slds .allTabTab .Custom23Block .relatedListIcon{background-color:#A765E2;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom23.svg');}
html > body.slds .bRelatedList .Custom24Block .relatedListIcon,html > body.slds .allTabTab .Custom24Block .relatedListIcon{background-color:#E15C8D;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom24.svg');}
html > body.slds .bRelatedList .Custom25Block .relatedListIcon,html > body.slds .allTabTab .Custom25Block .relatedListIcon{background-color:#E46FBE;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom25.svg');}
html > body.slds .bRelatedList .Custom26Block .relatedListIcon,html > body.slds .allTabTab .Custom26Block .relatedListIcon{background-color:#7698F0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom26.svg');}
html > body.slds .bRelatedList .Custom27Block .relatedListIcon,html > body.slds .allTabTab .Custom27Block .relatedListIcon{background-color:#5AB0D2;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom27.svg');}
html > body.slds .bRelatedList .Custom28Block .relatedListIcon,html > body.slds .allTabTab .Custom28Block .relatedListIcon{background-color:#89C059;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom28.svg');}
html > body.slds .bRelatedList .Custom29Block .relatedListIcon,html > body.slds .allTabTab .Custom29Block .relatedListIcon{background-color:#BDD25F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom29.svg');}
html > body.slds .bRelatedList .Custom30Block .relatedListIcon,html > body.slds .allTabTab .Custom30Block .relatedListIcon{background-color:#F59F71;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom30.svg');}
html > body.slds .bRelatedList .Custom31Block .relatedListIcon,html > body.slds .allTabTab .Custom31Block .relatedListIcon{background-color:#E85D74;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom31.svg');}
html > body.slds .bRelatedList .Custom32Block .relatedListIcon,html > body.slds .allTabTab .Custom32Block .relatedListIcon{background-color:#38C393;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom32.svg');}
html > body.slds .bRelatedList .Custom33Block .relatedListIcon,html > body.slds .allTabTab .Custom33Block .relatedListIcon{background-color:#97CF5D;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom33.svg');}
html > body.slds .bRelatedList .Custom34Block .relatedListIcon,html > body.slds .allTabTab .Custom34Block .relatedListIcon{background-color:#CF7F5F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom34.svg');}
html > body.slds .bRelatedList .Custom35Block .relatedListIcon,html > body.slds .allTabTab .Custom35Block .relatedListIcon{background-color:#E9637E;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom35.svg');}
html > body.slds .bRelatedList .Custom36Block .relatedListIcon,html > body.slds .allTabTab .Custom36Block .relatedListIcon{background-color:#D472D4;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom36.svg');}
html > body.slds .bRelatedList .Custom37Block .relatedListIcon,html > body.slds .allTabTab .Custom37Block .relatedListIcon{background-color:#817EF0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom37.svg');}
html > body.slds .bRelatedList .Custom38Block .relatedListIcon,html > body.slds .allTabTab .Custom38Block .relatedListIcon{background-color:#53B6D7;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom38.svg');}
html > body.slds .bRelatedList .Custom39Block .relatedListIcon,html > body.slds .allTabTab .Custom39Block .relatedListIcon{background-color:#4FBE75;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom39.svg');}
html > body.slds .bRelatedList .Custom40Block .relatedListIcon,html > body.slds .allTabTab .Custom40Block .relatedListIcon{background-color:#83C75E;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom40.svg');}
html > body.slds .bRelatedList .Custom41Block .relatedListIcon,html > body.slds .allTabTab .Custom41Block .relatedListIcon{background-color:#43B5B5;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom41.svg');}
html > body.slds .bRelatedList .Custom42Block .relatedListIcon,html > body.slds .allTabTab .Custom42Block .relatedListIcon{background-color:#CFD05B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom42.svg');}
html > body.slds .bRelatedList .Custom43Block .relatedListIcon,html > body.slds .allTabTab .Custom43Block .relatedListIcon{background-color:#7F93F9;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom43.svg');}
html > body.slds .bRelatedList .Custom44Block .relatedListIcon,html > body.slds .allTabTab .Custom44Block .relatedListIcon{background-color:#C8CA58;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom44.svg');}
html > body.slds .bRelatedList .Custom45Block .relatedListIcon,html > body.slds .allTabTab .Custom45Block .relatedListIcon{background-color:#D95879;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom45.svg');}
html > body.slds .bRelatedList .Custom46Block .relatedListIcon,html > body.slds .allTabTab .Custom46Block .relatedListIcon{background-color:#67A5E7;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom46.svg');}
html > body.slds .bRelatedList .Custom47Block .relatedListIcon,html > body.slds .allTabTab .Custom47Block .relatedListIcon{background-color:#5FCC64;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom47.svg');}
html > body.slds .bRelatedList .Custom48Block .relatedListIcon,html > body.slds .allTabTab .Custom48Block .relatedListIcon{background-color:#EF697F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom48.svg');}
html > body.slds .bRelatedList .Custom49Block .relatedListIcon,html > body.slds .allTabTab .Custom49Block .relatedListIcon{background-color:#E25C80;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom49.svg');}
html > body.slds .bRelatedList .Custom50Block .relatedListIcon,html > body.slds .allTabTab .Custom50Block .relatedListIcon{background-color:#49BCD3;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom50.svg');}
html > body.slds .bRelatedList .Custom51Block .relatedListIcon,html > body.slds .allTabTab .Custom51Block .relatedListIcon{background-color:#D8C760;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom51.svg');}
html > body.slds .bRelatedList .Custom52Block .relatedListIcon,html > body.slds .allTabTab .Custom52Block .relatedListIcon{background-color:#EE8E6F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom52.svg');}
html > body.slds .bRelatedList .Custom53Block .relatedListIcon,html > body.slds .allTabTab .Custom53Block .relatedListIcon{background-color:#F36E83;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom53.svg');}
html > body.slds .bRelatedList .Custom54Block .relatedListIcon,html > body.slds .allTabTab .Custom54Block .relatedListIcon{background-color:#EA70B1;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom54.svg');}
html > body.slds .bRelatedList .Custom55Block .relatedListIcon,html > body.slds .allTabTab .Custom55Block .relatedListIcon{background-color:#D66EE0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom55.svg');}
html > body.slds .bRelatedList .Custom56Block .relatedListIcon,html > body.slds .allTabTab .Custom56Block .relatedListIcon{background-color:#6582E8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom56.svg');}
html > body.slds .bRelatedList .Custom57Block .relatedListIcon,html > body.slds .allTabTab .Custom57Block .relatedListIcon{background-color:#5A9CDD;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom57.svg');}
html > body.slds .bRelatedList .Custom58Block .relatedListIcon,html > body.slds .allTabTab .Custom58Block .relatedListIcon{background-color:#34B59D;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom58.svg');}
html > body.slds .bRelatedList .Custom59Block .relatedListIcon,html > body.slds .allTabTab .Custom59Block .relatedListIcon{background-color:#E3D067;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom59.svg');}
html > body.slds .bRelatedList .Custom60Block .relatedListIcon,html > body.slds .allTabTab .Custom60Block .relatedListIcon{background-color:#BF5A88;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom60.svg');}
html > body.slds .bRelatedList .Custom61Block .relatedListIcon,html > body.slds .allTabTab .Custom61Block .relatedListIcon{background-color:#F4676B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom61.svg');}
html > body.slds .bRelatedList .Custom62Block .relatedListIcon,html > body.slds .allTabTab .Custom62Block .relatedListIcon{background-color:#6B92DC;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom62.svg');}
html > body.slds .bRelatedList .Custom63Block .relatedListIcon,html > body.slds .allTabTab .Custom63Block .relatedListIcon{background-color:#7CCF60;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom63.svg');}
html > body.slds .bRelatedList .Custom64Block .relatedListIcon,html > body.slds .allTabTab .Custom64Block .relatedListIcon{background-color:#618FD8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom64.svg');}
html > body.slds .bRelatedList .Custom65Block .relatedListIcon,html > body.slds .allTabTab .Custom65Block .relatedListIcon{background-color:#F279AB;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom65.svg');}
html > body.slds .bRelatedList .Custom66Block .relatedListIcon,html > body.slds .allTabTab .Custom66Block .relatedListIcon{background-color:#D8BE5F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom66.svg');}
html > body.slds .bRelatedList .Custom67Block .relatedListIcon,html > body.slds .allTabTab .Custom67Block .relatedListIcon{background-color:#F87D76;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom67.svg');}
html > body.slds .bRelatedList .Custom68Block .relatedListIcon,html > body.slds .allTabTab .Custom68Block .relatedListIcon{background-color:#F26979;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom68.svg');}
html > body.slds .bRelatedList .Custom69Block .relatedListIcon,html > body.slds .allTabTab .Custom69Block .relatedListIcon{background-color:#ED6387;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom69.svg');}
html > body.slds .bRelatedList .Custom70Block .relatedListIcon,html > body.slds .allTabTab .Custom70Block .relatedListIcon{background-color:#E769B4;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom70.svg');}
html > body.slds .bRelatedList .Custom71Block .relatedListIcon,html > body.slds .allTabTab .Custom71Block .relatedListIcon{background-color:#E36EE3;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom71.svg');}
html > body.slds .bRelatedList .Custom72Block .relatedListIcon,html > body.slds .allTabTab .Custom72Block .relatedListIcon{background-color:#8291FB;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom72.svg');}
html > body.slds .bRelatedList .Custom73Block .relatedListIcon,html > body.slds .allTabTab .Custom73Block .relatedListIcon{background-color:#679EF0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom73.svg');}
html > body.slds .bRelatedList .Custom74Block .relatedListIcon,html > body.slds .allTabTab .Custom74Block .relatedListIcon{background-color:#41C8A0;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom74.svg');}
html > body.slds .bRelatedList .Custom75Block .relatedListIcon,html > body.slds .allTabTab .Custom75Block .relatedListIcon{background-color:#CD9F65;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom75.svg');}
html > body.slds .bRelatedList .Custom76Block .relatedListIcon,html > body.slds .allTabTab .Custom76Block .relatedListIcon{background-color:#DB6D7A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom76.svg');}
html > body.slds .bRelatedList .Custom77Block .relatedListIcon,html > body.slds .allTabTab .Custom77Block .relatedListIcon{background-color:#B55D5B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom77.svg');}
html > body.slds .bRelatedList .Custom78Block .relatedListIcon,html > body.slds .allTabTab .Custom78Block .relatedListIcon{background-color:#4F8AD8;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom78.svg');}
html > body.slds .bRelatedList .Custom79Block .relatedListIcon,html > body.slds .allTabTab .Custom79Block .relatedListIcon{background-color:#8ED363;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom79.svg');}
html > body.slds .bRelatedList .Custom80Block .relatedListIcon,html > body.slds .allTabTab .Custom80Block .relatedListIcon{background-color:#5A8FCF;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom80.svg');}
html > body.slds .bRelatedList .Custom81Block .relatedListIcon,html > body.slds .allTabTab .Custom81Block .relatedListIcon{background-color:#D55774;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom81.svg');}
html > body.slds .bRelatedList .Custom82Block .relatedListIcon,html > body.slds .allTabTab .Custom82Block .relatedListIcon{background-color:#D15B97;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom82.svg');}
html > body.slds .bRelatedList .Custom83Block .relatedListIcon,html > body.slds .allTabTab .Custom83Block .relatedListIcon{background-color:#E7806F;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom83.svg');}
html > body.slds .bRelatedList .Custom84Block .relatedListIcon,html > body.slds .allTabTab .Custom84Block .relatedListIcon{background-color:#F6707B;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom84.svg');}
html > body.slds .bRelatedList .Custom85Block .relatedListIcon,html > body.slds .allTabTab .Custom85Block .relatedListIcon{background-color:#F26891;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom85.svg');}
html > body.slds .bRelatedList .Custom86Block .relatedListIcon,html > body.slds .allTabTab .Custom86Block .relatedListIcon{background-color:#E260AB;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom86.svg');}
html > body.slds .bRelatedList .Custom87Block .relatedListIcon,html > body.slds .allTabTab .Custom87Block .relatedListIcon{background-color:#D876E5;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom87.svg');}
html > body.slds .bRelatedList .Custom88Block .relatedListIcon,html > body.slds .allTabTab .Custom88Block .relatedListIcon{background-color:#996FE6;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom88.svg');}
html > body.slds .bRelatedList .Custom89Block .relatedListIcon,html > body.slds .allTabTab .Custom89Block .relatedListIcon{background-color:#3E99BE;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom89.svg');}
html > body.slds .bRelatedList .Custom90Block .relatedListIcon,html > body.slds .allTabTab .Custom90Block .relatedListIcon{background-color:#22A48A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom90.svg');}
html > body.slds .bRelatedList .Custom91Block .relatedListIcon,html > body.slds .allTabTab .Custom91Block .relatedListIcon{background-color:#BF7B66;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom91.svg');}
html > body.slds .bRelatedList .Custom92Block .relatedListIcon,html > body.slds .allTabTab .Custom92Block .relatedListIcon{background-color:#517E82;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom92.svg');}
html > body.slds .bRelatedList .Custom93Block .relatedListIcon,html > body.slds .allTabTab .Custom93Block .relatedListIcon{background-color:#904D4C;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom93.svg');}
html > body.slds .bRelatedList .Custom94Block .relatedListIcon,html > body.slds .allTabTab .Custom94Block .relatedListIcon{background-color:#439CBA;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom94.svg');}
html > body.slds .bRelatedList .Custom95Block .relatedListIcon,html > body.slds .allTabTab .Custom95Block .relatedListIcon{background-color:#8BCF6A;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom95.svg');}
html > body.slds .bRelatedList .Custom96Block .relatedListIcon,html > body.slds .allTabTab .Custom96Block .relatedListIcon{background-color:#6D9DE3;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom96.svg');}
html > body.slds .bRelatedList .Custom97Block .relatedListIcon,html > body.slds .allTabTab .Custom97Block .relatedListIcon{background-color:#DD6085;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom97.svg');}
html > body.slds .bRelatedList .Custom98Block .relatedListIcon,html > body.slds .allTabTab .Custom98Block .relatedListIcon{background-color:#E1BE5C;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom98.svg');}
html > body.slds .bRelatedList .Custom99Block .relatedListIcon,html > body.slds .allTabTab .Custom99Block .relatedListIcon{background-color:#F0856E;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom99.svg');}
html > body.slds .bRelatedList .Custom100Block .relatedListIcon,html > body.slds .allTabTab .Custom100Block .relatedListIcon{background-color:#E15D76;background-image:url('/resource/agf__SLDS_assets/icons/custom/custom100.svg');}

/* form <apex:input> */
html > body.slds div.slds-form-element__control span.lookupInput a.slds-input{width:21px;height:25px;border:none;background-color:rgba(0,0,0,0);right:26px;position:relative;padding:0 0 0 4px;min-height:0;line-height:normal;margin-top:-3px;}
html > body.slds div.slds-form-element__control span.lookupInput a.slds-input img{mask:url(/resource/agf__SLDS_assets/icons/utility/search.svg) top left / cover;-webkit-mask:url(/resource/agf__SLDS_assets/icons/utility/search.svg) top left / cover;width:12px;height:12px;background-color:#4A5E82;background-image:none;}
html > body.slds div.slds-form-element__control span.lookupInput a.slds-input:hover img{mask:url(/resource/agf__SLDS_assets/icons/utility/search.svg) top left / cover;-webkit-mask:url(/resource/agf__SLDS_assets/icons/utility/search.svg) top left / cover;width:12px;height:12px;background-color:#0070D2;background-image:none;}
html > body.slds label .gusFormHelpText{mask:url(/resource/agf__SLDS_assets/icons/utility/info.svg) top left / cover;-webkit-mask:url(/resource/agf__SLDS_assets/icons/utility/info.svg) top left / cover;width:12px;height:12px;background-color:#4A5E82;background-image:none;}
html > body.slds div.slds-form-element__control span.dateFormat{display:none;}

/* form items: checkboxes */
html > body.slds .inlineEditWrite .checkImg{mask:url(/resource/agf__SLDS_assets/icons/utility/success.svg) 0px 0px no-repeat;-webkit-mask:url(/resource/agf__SLDS_assets/icons/utility/success.svg) 0px 0px no-repeat;width:14px;height:14px;padding-left:24px;box-sizing:border-box;background-color:#000;background-repeat:no-repeat;-webkit-mask-size:14px 14px;mask-size:14px 14px;}
/*
html > body.slds .detailList .inlineEditWriteOn{background-image:none;-webkit-mask:url(/resource/agf__SLDS_assets/icons/utility/pencil.svg) 0px 0px no-repeat;background-color:#000;background-repeat:no-repeat;-webkit-mask-size:12px 12px;}
*/

/* jquery auto-completes */
.ui-helper-hidden{display:none}
.ui-helper-hidden-accessible{border:0;clip:rect(0 0 0 0);height:1px;margin:-1px;overflow:hidden;padding:0;position:absolute;width:1px}
html > body.slds ul.ui-autocomplete{position:absolute;cursor:default;border-radius:5px;z-index:9002;background:#fff;box-shadow:0px 2px 3px 0px rgba(0, 0, 0, 0.16);border:1px solid #D8DDE6;padding:3px 0px;}
html > body.slds ul.ui-autocomplete .ui-menu-item{font-size:14px;position:relative;margin:0;line-height:33px;}
html > body.slds ul.ui-autocomplete .ui-menu-item.ui-state-focus,
html > body.slds ul.ui-autocomplete .ui-menu-item.ui-state-active{background:#F3F5F8;border-radius:0px;}
html > body.slds ul.ui-autocomplete .ui-menu-item img{width:24px;height:24px;border-radius:5px;vertical-align:middle;margin-right:5px;position:absolute;top:50%;margin-top:-12px;left:5px;}
html > body.slds ul.ui-autocomplete .ui-menu-item a{padding-left:5px;display:block;color:#16325C;text-decoration:none;}
html > body.slds ul.ui-autocomplete .ui-menu-item a.ui-state-focus,
html > body.slds ul.ui-autocomplete .ui-menu-item a.ui-state-active{background:#F3F5F8;border:0;border-radius:0;margin:0;}
html > body.slds ul.ui-autocomplete .ui-menu-item img + a{padding-left:36px;}

/* multi-select picklists */
html > body.slds select.slds-input[multiple]{font-size:13px;width:100% !important;}
html > body.slds tr.multiSelectPicklistRow td:first-child,
html > body.slds tr.multiSelectPicklistRow td:last-child{width:50%;}
html > body.slds tr.multiSelectPicklistRow td.multiSelectPicklistCell{min-width:28px;}
html > body.slds tr.multiSelectPicklistRow .picklistArrowRight{height:20px;display:block;padding:0;line-height:0;min-height:0;border:0;margin-bottom:-35px;}
html > body.slds tr.multiSelectPicklistRow .picklistArrowLeft{height:20px;display:block;padding:0;line-height:0;min-height:0;border:0;}