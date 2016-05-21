
@font-face{font-family:'ProximaNova';src:url(proximanovasoft_regular_webfont) format('truetype');font-weight:300;font-style:normal;}
@font-face{font-family:'ProximaNova';src:url(proximanovasoft_medium_webfont) format('truetype');font-weight:500;font-style:normal;}
@font-face{font-family:'ProximaNova';src:url(proximanovasoft_semibold_webfont) format('truetype');font-weight:700;font-style:normal;}
@font-face{font-family:'ProximaNova';src:url(proximanovasoft_bold_webfont) format('truetype');font-weight:900;font-style:normal;}

div.bodyDiv,div.bodyDiv td{font-family:'ProximaNova','Lucida Grande','Arial';font-size:13px;color:#666;}
div.bodyDiv *{box-sizing:border-box;}
body .bodyDiv #bodyTable{padding:0px !important;}

body{font-family:'ProximaNova','Lucida Grande','Arial';font-size:13px;background:#eee;margin:0;}
button{font-family:'ProximaNova','Lucida Grande','Arial';font-size:13px;}

#kanbanContainer{overflow:hidden;}
.ui-dialog button{height:auto !important;border-radius:5px !important;}
.ui-dialog button:hover{background-color:#DCDCDC;}
.ui-dialog button[disabled]:hover{background:transparent;}
.ui-dialog button[disabled] span{color:#838383 !important;}
#kanbanContainer button,
.ui-dialog button{font-family:'ProximaNova','Lucida Grande','Arial';font-size:13px;border-radius:0;display:inline-block;text-decoration:none;padding:0px 10px;background:transparent;border:0;cursor:pointer;margin:0;height:42px;-webkit-appearance:none;outline:0;}
#kanbanContainer button:hover,
.ui-dialog button:hover{background-color:#DCDCDC;}
#kanbanContainer button:active,
.ui-dialog button:active{background-color:#C0C0C0;}
.ui-dialog button:active{border:1px #C0C0C0 solid;}
#kanbanContainer button span,
.ui-dialog button span{display:inline-block;margin:0px;padding:5px;font-size:12px;color:#333;font-weight:bold;}
#kanbanContainer button .fa,
.ui-dialog button .fa{color:#333;font-size:13px;}
#kanbanContainer button i.fa{margin-left:5px;font-size:12px;}
#kanbanContainer #kanbanLoading{display:none;}
#kanbanContainer #kanbanFailed{position:absolute;top:40%;left:50%;margin-left:-58px;}
#kanbanContainer #kanbanFailed button,
.ui-dialog button{border:1px #C0C0C0 solid;background:#E8E8E8;}
#kanbanContainer #kanbanFailed button:hover,
#kanbanContainer.boardloading #kanbanLoading{display:block;position:absolute;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);text-align:center;}
#kanbanContainer.boardloading #kanbanLoading .fa{color:#fff;font-size:30px;position:absolute;top:50%;}
#kanbanContainer #dragDropContainment{position:absolute;left:0;top:0;right:0;bottom:0;/* border:1px red solid; */margin:40px -22px -20px -22px;z-index:-1;}
#containerToolbar{font-weight:bold;position:absolute;top:0;left:0;right:0;background-color:#E8E8E8;height:42px;line-height:42px;/* border-bottom:1px #C0C0C0 solid; */box-shadow:0px 2px 4px #666;z-index:1;border-top-right-radius:10px;border-top-left-radius:10px;}
#toolbarTitle{text-align:center;font-size:18px;color:#888;text-shadow:0px 0px 3px #FFF;}
.sort-handle{cursor:move;}

#toolbarButtonsLeft{position:absolute;left:0px;top:0px;}
#toolbarButtonsLeft li{border-right:1px #CECECE solid;}
#toolbarButtonsLeft li:first-child button{border-top-left-radius:7px;}
#toolbarButtonsRight{position:absolute;right:0px;top:0px;}
#toolbarButtonsRight li{border-left:1px #CECECE solid;}
#toolbarButtonsRight li:last-child button{border-top-right-radius:7px;}
.toolbarButtons{padding:0;margin:0;list-style-type:none;font-size:0;height:42px;overflow:hidden;}
.toolbarButtons li{display:inline-block;}
	
#kanbanContents{overflow:auto;}
.containerColumns{display:table;width:100%;}
.columnsRow{display:table-row;height:100%;}
.columnsHolder{display:table-cell;height:100%;padding:0px;}
.columnsHolder:last-child{border-right:0;}

.holderContents{display:none;overflow:hidden;}
.holderContents:first-child{display:block;}
.holderTitle{background-color:#1D446E;padding:10px;color:#fff;text-align:center;font-size:18px;}
.holderWork{overflow-y:auto;overflow-x:hidden;min-height:97px;/*background:#5fdf9a;padding-bottom:120px;*/}
#parent-0-row-0 > .holderContents > .holderTitle{border-top:0;} /* remove top border on titles */

.titleText{display:block;color:#fff;white-space:nowrap;cursor: pointer;}
.titleOptions .fa{font-size:14px;font-weight:normal;color:#fff;margin:-3px 2px 0px 2px;}
.titleOptions .fa:hover{color:#C8E27C;cursor:pointer;}
#titleOptionsLeft{float:left;}
#titleOptionsRight{float:right;}

.progress{display:inline-block;position:relative;width:100px;max-width:100%;background-color:#464646;border:1px #797979 solid;margin-top:5px;}
.progressLeft{position:absolute;top:0;bottom:0;left:0;width:0%;background:#C8E27C;}
span.progressTitle{padding-left:4px;color:#ccc;font-size:11px;}
div.progressTitle{padding:2px;}

/* work card */
.card{display:block;min-width:150px;margin:13px;cursor:default;}
.card-bug > div{border-left-color:#00A61B !important;}
.card-userstory > div{border-left-color:#0067A6 !important;}
.inner-card >div >div.workid .fa:before{content:"\f188";}
.card-userstory .workid .fa:before{content:"\f02d";}

/*.card.ui-sortable-helper{transform:rotate(2deg);-ms-transform:rotate(2deg);-webkit-transform:rotate(2deg);}*/
.card.placeholder{opacity:0;}



/* dialog stuff */
.ui-widget-overlay{background:rgba(0,0,0,0.7);}
.ui-button{border:0;outline:0;border-radius:5px;cursor:pointer;}
.ui-button:hover{background:#E7E7E7;}
.ui-dialog-titlebar-close{display:none;}
.ui-dialog{display:none;background:#E8E8E8;border-radius:10px;font-size:13px;color:#666;min-height:0 !important;box-sizing:border-box;}
.ui-dialog *{box-sizing:border-box;}
.ui-button-text-only .ui-button-text{color:#333;font-weight:bold;}
.ui-dialog input[type=text],
.ui-dialog input[type=number],
.ui-dialog select,
.ui-dialog textarea{display:block;font-family:'ProximaNova','Lucida Grande','Arial';font-size:13px;padding:5px;border:1px #C0C0C0 solid;outline:0;border-radius:5px;}
.ui-dialog select{height:27px;}
.ui-dialog textarea{resize:none;height:100px;}
.ui-dialog #customcolor{display:block;margin-bottom:20px;}
.ui-dialog .message{margin:0;border:0;background:none;color:#fff;padding:0;}
.ui-dialog li{margin-bottom:10px;}
.ui-dialog .ui-dialog-buttonpane{margin-top:0;border-top:1px #BEBEBE solid;}
.ui-dialog .ui-dialog-title{font-weight:bold;}
.ui-dialog .ui-dialog-titlebar{background:#666;border-radius:5px;margin:3px;color:#fff;}
.ui-dialog .ui-dialog-titlebar-close{display:none !important;}
.ui-dialog-error{display:none;margin-top:10px;padding:5px 10px;background:#C03300;color:#FFF;border-radius:5px;}

/* settings */
#settingsDialog .settingsColumn{background:#666;border-color:#E8E8E8;display:table-cell;border-right:1px #C0C0C0 solid;overflow:hidden;}
#settingsDialog .settingsColumn:last-child{border-right:0;}
#settingsDialog .settingsColumn.highlight{background:#005B99;outline:0;}
/*#settingsDialog .settingsColumn.highlight > .containerColumns > .settingsColumn{background:none;}*/
#settingsDialog .settingsColumn.remove{display:none;}
#settingsDialog .settingsColumn .holderTitle{background:none;height:auto;}
#settingsDialog .settingsColumn.settingsSwimlane > .holderTitle{border-top-width:5px;}
#settingsDialog .holderTitle{border-color:#E8E8E8;}
#settingsDialog #kanbanSettingsContents{user-select:none;-webkit-user-select:none;-moz-user-select:none;overflow:auto;position:relative;}
#settingsDialog #kanbanSettingsContents *{cursor:pointer;}
#settingsDialog #kanbanSettingsLoading{display:none;}
#settingsDialog.boardloading #kanbanSettingsLoading{display:block;position:absolute;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);text-align:center;z-index:10;}
#settingsDialog.boardloading #kanbanSettingsLoading .fa{color:#fff;font-size:30px;margin-top:60px;}
#settingsDialog #propertyPanel{position:relative;}
#settingsDialog .propertyHeader{margin-top:20px;border-bottom:1px #BEBEBE solid;margin-bottom:8px;padding-bottom:3px;font-weight:bold;}
#settingsDialog .propertyFormOptions{visibility:hidden;}
#settingsDialog .propertyFormOptions label{white-space:nowrap;}
#settingsDialog #closePanelHolder{position:absolute;top:0px;right:4px;}
#settingsDialog #closePanelHolder .fa{font-size:18px;}
#settingsDialog #columnNameTitle{text-transform:uppercase;margin-top:15px;font-size:14px;}
#settingsDialog #closePanel{cursor:pointer;}
#settingsDialog #workExists,
#settingsDialog #childrenExist{margin-bottom:10px;display:none;}
#settingsDialog #createStatusMappingHolder{display:none;}
#settingsDialog .statusesText{font-size:10px;color:#61D5FF;text-transform:uppercase;}
#settingsDialog span.progressTitle{display:none;padding:0px 4px;color:#4D4D4D;font-size:11px;background:#CCC;border-radius:4px;top:-2px;position:relative;font-weight:bold;}
button#saveButton{display:none;}
button#saveButton[disabled]{border:1px transparent;}

/* backlog panel */
.workList{background:#fff;height:300px;width:100%;overflow-y:auto;border:1px #C0C0C0 solid;border-radius:5px;user-select:none;-webkit-user-select:none;-moz-user-select:none;}
.workList .spacer{padding-top:5px;text-align:center;}
#backlogDialogHeader{margin-bottom:12px;}
#backlogColumnSelect{display:inline-block;}
.backlogRow:first-child > div{padding-top:10px;}
.backlogRow:hover > div{background-color:#E4E4E4;}
.backlogRow > div{display:table-cell;padding:2px 5px;}
.backlogRow > div.backlogSubject{width:100%;}
.backlogRow > div.backlogSubject label{display:block;}
.backlogRow > div.backlogWorkId{white-space:nowrap;}
#backlogDialog #backlogDialogLoading{display:none;}
#backlogDialog.dialogloading #backlogDialogLoading{display:block;position:absolute;top:0;left:0;right:0;bottom:0;background:rgba(0,0,0,0.5);text-align:center;z-index:10;}
#backlogDialog.dialogloading #backlogDialogLoading .fa{color:#fff;font-size:30px;margin-top:220px;}
#backlogDialog .ui-dialog-error{margin-bottom:10px;}

/* salesforce1 style tabs */
ul.sTabs{padding:0;margin:0;list-style:none;text-align:center;border-bottom:1px #BEBEBE solid;margin-bottom:12px;}
ul.sTabs > li{display:inline-block;margin:0;}
ul.sTabs > li > a,
ul.sTabs > li > a:hover{text-decoration:none;text-transform:uppercase;font-weight:bold;font-size:11px;color:#555;display:block;padding:7px 16px;outline:none;}
ul.sTabs > li.on > a{border-bottom:2px #0088E5 solid;}

/* fullscreen changes */
html.fullscreen{height:100%;}
html.fullscreen body{height:100%;margin:0px;background:#F2F2F2;overflow:hidden;}
html.fullscreen div#contentWrapper{height:100%}
html.fullscreen div.bPageHeader,
html.fullscreen div.bPageFooter{display:none;}
html.fullscreen div.bodyDiv{box-shadow:none;-webkit-box-shadow:none;background:none;border:0px;}
html.fullscreen table#bodyTable{height:100%;padding:0px;}
html.fullscreen td.noSidebarCell{padding:0px;vertical-align:top;height:100%;}
html.fullscreen #buttonFullscreen{background-color:#B8B8B8;}
html.fullscreen #kanbanContainer{border-radius:0px;border:0px;width:auto;box-sizing:content-box;}
html.fullscreen #kanbanContainer *{box-sizing:border-box;}

#columnMenu{position:absolute;top:38px;left:0;right:0;text-align:center;display:none;}
#columnMenu > div{background:#000;color:#fff;display:inline-block;margin:0 auto;border-radius:5px;padding:0;}
#columnMenu > div > div#columnMenuArrow{margin:-9px auto 0 auto;}
#columnMenu > div > div#columnMenuArrow > .fa{color:#000;}
#columnMenu > div > div#columnMenuItems > a{display:block;color:#fff;padding:10px 40px;border-bottom:1px #424242 solid;}
#columnMenu > div > div#columnMenuItems > a:last-child{border-bottom:0;}