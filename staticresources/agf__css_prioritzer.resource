@CHARSET "UTF-8";
#dialog-form-filter input, .portlet-content, .descriptionTrBug,.descriptionTrInvestigation,.descriptionTrToDo, .assignValTd {
	display: none;
	
}
#buttonSetFilters label.ui-state-active {
    box-shadow: rgba(0, 0, 0, 0.2) 1px 2px 3px inset; 
    background-image:url(/resource/1347381173000/ui_bg_glass_85_abd5f7_1x400);
    color: #6da8d5;
    font-weight: bold;
}
 
.longInput {
	width: 95%;
}

.gushelpLink {
	
		text-decoration:none;
		color:#3366BB;
		font-size:11px;
	}
	


.sprintDivider {
	margin: 0px !important;
	//padding-top: 2px;
	padding-bottom: 0px !important;
	background: #dfeffc; //#2e6e9e;
	border:#dfeffc;  //#2e6e9e;
}
#dialog {
	display: table-cell;
}
#progressbar {
	text-align:center;
	width:300px;
}
#dialog img {
	vertical-align: middle;
}
.ui-button { margin-left: -1px; padding: 0px !important;}
.ui-button-icon-only .ui-button-text { padding: 0.35em; } 
.ui-autocomplete-input { margin: 0; padding: 0.48em 0 0.47em 0.45em; }

.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto;
	/* prevent horizontal scrollbar */
	overflow-x: hidden;
	/* add padding to account for vertical scrollbar */
	padding-right: 20px;
}
/* IE 6 doesn't support max-height
 * we use height instead, but this forces the menu to always be this tall
 */
* html .ui-autocomplete {
	height: 100px;
}
.portlet-handle, .move {
	cursor:move !important;
}
.pointer, .toggle, .expand {
	cursor:pointer !important;
}
.sortable { 
	list-style-type: none; 
	margin-right: 2px; 
	float: left; 
	margin-left: 2px; 
	background: #eee; 
	border: 1px solid #ccc;
	padding: 0px;
	
}
.sortable li { 
	//margin: -1px;
	margin-left:0px !important;
	margin-top:-1px;
	margin-bottom:0px;
	
}

#sortable3 .portlet-handle {
    cursor: default !important;
}

.dropContainer {
	//margin-left: 9px; 
}

.ui-state-default {
	padding-top:5px;
	padding-bottom:5px;
	padding-right:1px;
}

.portlet {
	//border:0px !important;
	//border: 1px solid #a6daf0 //#6cc3eb; //#a7cadb; //#f0f4f5;
	
}

.ui-widget-header {
	border:0px !important;
	//border: 1px solid #ccc;
}

.portlet-header { 
	margin:0px; /* 0.3em;*/ 
	padding-bottom: 4px; 
	padding-top: 2px; 
	padding-left: 0.2em;
	background:#f5f8f9; //#f5f8f9; //#f0f0f0
	border:0px !important;
	
	/* background-image: -webkit-gradient(
	    linear,
	    left bottom,
	    left top,
	    color-stop(0.39, rgb(240,244,245)),
	    color-stop(1, rgb(202,233,247))
	);
	background-image: -moz-linear-gradient(
	    center bottom,
	    rgb(240,244,245) 39%,
	    rgb(202,233,247) 100%
	); */
	
}

.columnHeader {
    padding-right: 2px;
}

.iconCell {
    width: 16px;
}

.storyPointCell {
    width: 65px;
}

.priorityRank {
    width: 28px;
}
#sortable2 .priorityRank {
    display: none;
}

.buildNameCell {
    width: 100px;
}

.sprintNameCell {
    width: 160px;
}

.themeCell {
    width: 160px;
}

/* When there is more than one portlet shown, we want to hide the following columns */
.portlet-count-n .buildNameCell,
.portlet-count-n .sprintNameCell,
.portlet-count-n .themeCell {
    display: none;
}

.toggleCell {
    text-align: right;
    padding-right: 0;
    width: 20px;
}

.toggle, .pts { 
	float: right; 
}
.expand, .expandAll, .pointer, .move {
	float: left;
}	
.portlet-content { 
	padding: 0.4em;
	background: #dae6f0; //#cedeeb; //#cad9e6; //#f5f5f5; //#f2eff2;
	 
}
.ui-sortable-placeholder {
	visibility: visible !important;
}
.ui-sortable-placeholder { visibility: hidden; }
.recTypeIcon {
	vertical-align: text-top;
}
.ui-state-default {
	font-size: 1.1em;
	text-align: center;
	//color: #00335b;
	//color:white;
	//background:#1c81ad;
}
.labelCol {
	width: 20%;
}
.labelCol, .dataCol, .last { 
	vertical-align:top;	
}
.labelCol, .dataCol{
	//border-bottom: 1px solid #eee;
}
.subjectTd {
	width: 96% !important;
}

.assignmentTableWrapper {
	margin-left: 6px;
}

.assignmentTable td {
	vertical-align: middle;
	padding: 10px 0px 0px 0px;
		
}
.assignmentTable button {
	margin:0px 5px;
}
.underLine, .noUnderLine {
	text-decoration: underline;
}
.assignVal {
	padding: 0 5px !important;
}
.pr_rightBorder {
	//border-right:1px solid #eee;
}
.portlet-table {
	margin-right:10px;
	padding-top:2px;
}
.portlet-table td {
	text-wrap:normal; word-wrap: break-word;
	color: #195d7d; //#2e6e9e; //#00335b; //#4b4b57;
	vertical-align:top !important;
	font-size: 1.0em;
	font-weight:bold;
	
}

.summaryMData {
	color: #588fa8 !important; //757475
	font-size: 0.9em !important;
	font-weight:normal !important;
	

}

.customTruncation {
	
	overflow:hidden !important;
	width:50px !important; 
	height:0.9em;
	text-wrap:normal !important; 
	word-wrap: break-word !important;
	
}

.recordHeaderSelected {
	background:000000 !important;
	color:white;
}

.recordHeaderUnselected {
	background:FFFFFF !important;
	color:black;
}

.themeItem:after {
    content: ", ";
}
.themeItem:last-child:after {
    content: "";
}





