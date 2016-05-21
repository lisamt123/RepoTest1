@font-face{font-family:'ProximaNova';src:url(/resource/proximanovasoft_regular_webfont) format('truetype');font-weight:300;font-style:normal;}
@font-face{font-family:'ProximaNova';src:url(/resource/proximanovasoft_medium_webfont) format('truetype');font-weight:500;font-style:normal;}
@font-face{font-family:'ProximaNova';src:url(/resource/proximanovasoft_semibold_webfont) format('truetype');font-weight:700;font-style:normal;}
@font-face{font-family:'ProximaNova';src:url(/resource/proximanovasoft_bold_webfont) format('truetype');font-weight:900;font-style:normal;}

.autocomplayout {
            padding-top:5px;
        }

        .labelCol first {
            padding-top:5px;
            vertical-align: middle
        }
        
        .hidden {
            display: none;
        }
        .sfdc_richtext .ADM_CommentBody{
            display:block !important; /* this override is so people who copy comments into details and steps to reproduce dont get caught up with the toggling of comments */
        }
        body{ 
            background-color: #F3F3EC; 
        }
       .adm_longOutputFieldWrapper,.adm_outputFieldWrapper{
            float:left;cursor:pointer;
        }
        .adm_inputField,.adm_longInputField,.adm_revertIcon{
            vertical-align:bottom;
        }
        .adm_formItemWrapper{
            height:18px; 
            width:300px;
        }
        .adm_longFormItemWrapper{ 
            width:85%;
        }
        .adm_outputFieldWrapper{
            width:200px;
        }
        .adm_longOutputFieldWrapper{
            width:400px; 
        }
        .adm_inputField{
            /*width:200px; */
            text-alight:left;
        }
        .adm_longInputField{
            width:85%; 
        }
        .adm_revertIcon{ }
        .adm_edit{
            background: url({!$Resource.IconEdit}) no-repeat top right; padding-right:20px;
        }
        .pbBody td{
            border-style:hidden !important;
        }
        .lookupInput a{
            border: none !important;
        }
        .pbBody ul {
           display:none !important;
        }
        .pbBody .sfdc_richtext ul {
           display:block !important;
        }
        .pbBody table.messageTable ul{
            display:block !important;
            margin-top: -17px !important;
        }
        .adm_displayBlock ul{
          display:block !important;
        }
        div.errorMsg{
            display:block !important;
       }
        #tag_edit_error {
            display: none !important;
        }
       .thHide{ display:none !important; }       
        a.noUnderline:link,
        a.noUnderline:hover,
        a.noUnderline:visited,
        a.noUnderline,
        .noUnderline{
            text-decoration:none !important;
        }
        
        a.normalLink {
            font-size:80%;
        }
        
        a.normalLink:link,
        a.normalLink:hover,
        a.normalLink:visited {
            color:blue;
        }
        
        .adm_imgPadding{
            padding:0px 5px 0px 0px;
        }  
        .adm_table .totalRow{
            text-align:right;
            vertical-align:middle;
            padding:5px 0px;
            text-decoration:none;
        }
        .adm_footerSpan{
            padding:0px 5px;
        }
        
        .adm_info, .adm_success, .adm_warning, .adm_error, .adm_validation {  
            border: 1px solid;  
            margin: 10px 0px;  
            padding:15px 10px 15px 50px;  
            background-repeat: no-repeat;  
            background-position: 10px center; 
            font-size: 14px; 
        }  
        
        .adm_info {  
            color: #00529B;  
            background-color: #BDE5F8;  
            background-image: url({!URLFOR($Resource.silkIcons, 'icons/information.png')}) /*url('information.png');*/  
        }
          
        .adm_success {  
            color: #4F8A10;  
            background-color: #DFF2BF;  
            background-image:url('accept.png');  
        }  
 
        .adm_warning {  
            color: #9F6000;  
            background-color: #FEEFB3;  
            background-image:url({!URLFOR($Resource.silkIcons, 'icons/error.png')}) /* url('error.png');*/  
        }  
        
        .adm_error {  
            color: #000000;
            border-color: #D8000C;  
            background-color: #FFBABA;  
            background-image: url({!URLFOR($Resource.silkIcons, 'icons/exclamation.png')}) /*url('exclamation.png');*/  
        }
        
        .adm_padding_small {
            padding: 5px 0px;
            margin:0px 0px;
        }
        
        pre {
            font-family:inherit;
            white-space:pre-wrap;
            white-space:-moz-pre-wrap;
            white-space:-pre-wrap;
            white-space:-o-pre-wrap;
            word-wrap:break-word;
            margin:0px !important;
        }
        
        .req {
            color: #CC0000;
            font-weight: bolder;
            font-size: 155%;
            margin-left:-4px;
        }
        
        .req1 {
            color: #CC0000;
            font-weight: bolder;
            font-size: 280%;
            margin-left:-4px;
        }
        
        .ptBody {
          background-color:#00335b;
        }
        
        .pbSubheader {
          background-color:#00335b;
        }
        
        .actionFooter, .actionFooter_dark {
            background: #e3e3d7;
            margin:0;
            padding:1px;
        }
        
        .actionFooter_dark {
            background: #E8E8E8;
        }
        
        .opacity_40_percent {
            opacity:0.4;
            filter:alpha(opacity=40);
        }
        
        .tooltipbody {
            background-color:#FEFDB9;
            border:1px solid orange;
            color:#000000;
            font-weight:normal;
            padding:2px 5px;
            text-decoration:none;
            white-space:normal;
            width:15em;
            z-index:12;
        }
        
        .center {
            text-align:center;
        }
        .assistiveText {  position: absolute;  border: 0;  clip: rect(0, 0, 0, 0);  width: 1px;  height: 1px;  margin: -1px;  padding: 0;  overflow: hidden;
        }

        .hiddenAnchor {
            color:inherit;
            pointer-events:none;
            text-decoration: none !important
        }
        .sfdc_richtext{
            word-break: break-word;
            word-wrap: break-word;
            /*max-width:800px;*/
        }
        
        .htmlDetailElementIframe{
            width:100%;
        }
        
        .changelists td{vertical-align:top !important;}
        .changelists tr.dataRow td{border-top:1px #333 solid !important;padding-top:10px !important;padding-bottom:10px !important;}
        
        .listViewLink {
            text-decoration:none;
            color:#3366BB;
        }
/*-------------------------------------------------
NEW GUS STYLES
-------------------------------------------------*/
div.content{width:100% !important;max-width:882px;}
.gusFieldset,.workOptionsSelector,.gusTabs > ul,body .message{width:100%;max-width:882px;box-sizing:border-box;-moz-box-sizing:border-box;} /* global width */
.gusFieldset{position:relative;background-color:#F3F6F6;padding:20px 7px 7px 7px;border:2px #85C8DD solid;border-radius:10px;margin-top:30px;font-family:'Arial','Helvetica','sans-serif';font-size:12px;color:#555;}
.gusFieldset.gusFieldsetForm{padding-top:0px;border-top-width:0px;}
.gusFieldset.gusFieldsetConnected{margin-top:-10px;border-top-width:2px;border-top-left-radius:0px;border-top-right-radius:0px;border-top-color:#BBE2EE;padding-top:28px;}
.gusFieldset.gusFieldsetConnected .gusLegend{background-color:#60A9C0;color:#fff;}
.gusFieldset.gusFieldsetExtraPadding{padding-bottom:20px;}
.gusLegend{background-color:#00485F;position:absolute;top:-12px;font-size:11px;font-weight:bold;border-radius:5px;padding:5px 14px;left:15px;color:#fff;}
.gusLegend H2{font-size:11px;color:#fff;margin:0;}
.gusRequiredText:before{position:absolute;top:-20px;right:9px;border-left:4px #C11717 solid;padding-left:4px;content:"= Required Information"}

.gusForm{display:table;width:100%;}
.gusForm .gusForm1Column{position:relative;display:table;width:100%;}
.gusForm .gusForm1Column .gusFormFieldLeft{width:118px;min-width:118px;}
.gusForm .gusForm2Column{position:relative;display:table-cell;width:50%;vertical-align:top;}
.gusForm .gusForm3Column{position:relative;display:table-cell;width:33%;vertical-align:top;}
.gusForm .gusForm3Column .gusFormFieldLeft{min-width:118px;max-width:118px;}
.gusForm .gusForm3Column .gusFormFieldRight{min-width:140px;max-width:170px;}
.gusForm .gusForm4Column{position:relative;display:table-cell;width:25%;vertical-align:top;}
.gusForm .gusForm4Column .gusFormFieldLeft{min-width:77px;max-width:77px;}
.gusForm .gusForm4Column .gusFormFieldRight{min-width:150px;max-width:150px;}
.gusForm .gusFormRow{display:table-row;}
.gusForm .gusFormField{position:relative;display:table-cell;height:30px;padding-bottom:15px;vertical-align:middle;font-family:'Arial','Helvetica','sans-serif';font-size:12px;color:#555;box-sizing:border-box;-moz-box-sizing:border-box;}
.gusForm .gusFormField.gusFieldRequired label{border-right:4px #c11717 solid;padding-right:5px;}
.gusForm .gusFormField span.lookupInput a{position:relative;left:-20px;}
.gusForm .gusFormField span.lookupInput img{opacity:0.5;width:13px;height:13px;background-repeat:no-repeat;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA0AAAANCAYAAABy6+R8AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBNYWNpbnRvc2giIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6QTQwMTEzRTVEMTI3MTFFMkEyMzVBNzRFNEM2Qzk0RDYiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6QTQwMTEzRTZEMTI3MTFFMkEyMzVBNzRFNEM2Qzk0RDYiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpBNDAxMTNFM0QxMjcxMUUyQTIzNUE3NEU0QzZDOTRENiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpBNDAxMTNFNEQxMjcxMUUyQTIzNUE3NEU0QzZDOTRENiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PlVLNZ8AAAGlSURBVHjajFG/S0JRFL7vhyjqC5UExSSHCGnQJ8Kb4vXGJqeWpmhybWlsEJozctTBauyBiUFr/QGZbT6aBENr0Iyn+Kte3xWL96ShAx/3cu79zjnfdxgyj2AwuIXjABABD3AHnLZarXuyEMycsGe324sul4vYbDbCMAwZj8ek3++T0WhUBHHfTOJoB6fTee33+3VFUU5KpdJROp0+HwwGtUajscmyrIRCNV3XtR8SLwjCIUAkSTrLZrM5dGnTB8MwatPp9FNV1RzOY6TKv60SicRLMpnEHyOwODtyHlmWn2OxmGHOozu7NBM372ARzDDv0PZFdVpIPp/v0eSeJZCLQ9s6TLIUZCORyBW9OByOspmI+yo+X9AuoVDoxjIB5l5OpVKXzWZzu9vtUotrM4d4XvR6vbMVwPqPXq8nw/qnmeWZTGagadpDvV7XMUqA47gN7CuAFbSj0aiKQmvQLUDbLlZzC+tfGZNT1L0VwD1PDYF2Pp9XCoVCbjKZuDudTg/kOG9yiopt/2G7Sk9KDIfDb6IoDsl/AkR3pVLZqVarCu78twADAGO7tEttHGMPAAAAAElFTkSuQmCC);}
.gusForm .gusFormField span.lookupInput img.lookupIconOn{}
.gusForm .gusFormField span.lookupInput a:hover,
.gusForm .gusFormField span.lookupInput a:focus{outline:0;}
.gusForm .gusFormField span.lookupInput a:hover img,
.gusForm .gusFormField span.lookupInput a:focus img{opacity:1.0;}
.gusForm .gusFormField span.lookupInput > select + a > img.lookupIcon{display:none;}
.gusForm .gusFormField span.dateFormat{display:none;}

/* Stacked Fields */
.gusForm .gusForm1Column.gusStackedRows,
.gusForm .gusForm2Column.gusStackedRows,
.gusForm .gusForm3Column.gusStackedRows,
.gusForm .gusForm4Column.gusStackedRows{/*display:block;*/padding-top:7px;/*margin-bottom:-5px;*/}

.gusForm .gusForm2Column.gusStackedRows:first-child,
.gusForm .gusForm2Column.gusStackedRows:last-child,
.gusForm .gusForm3Column.gusStackedRows:nth-child(1),
.gusForm .gusForm3Column.gusStackedRows:nth-child(2),
.gusForm .gusForm3Column.gusStackedRows:nth-child(3),
.gusForm .gusForm4Column.gusStackedRows:nth-child(1),
.gusForm .gusForm4Column.gusStackedRows:nth-child(2),
.gusForm .gusForm4Column.gusStackedRows:nth-child(3),
.gusForm .gusForm4Column.gusStackedRows:nth-child(4){padding-left:10px;padding-right:10px;}

.gusForm .gusForm1Column.gusStackedRows .gusFormRow,
.gusForm .gusForm2Column.gusStackedRows .gusFormRow,
.gusForm .gusForm3Column.gusStackedRows .gusFormRow,
.gusForm .gusForm4Column.gusStackedRows .gusFormRow{display:block;}

.gusForm .gusForm1Column.gusStackedRows .gusFormRow .gusFormField,
.gusForm .gusForm2Column.gusStackedRows .gusFormRow .gusFormField,
.gusForm .gusForm3Column.gusStackedRows .gusFormRow .gusFormField,
.gusForm .gusForm4Column.gusStackedRows .gusFormRow .gusFormField{display:block;min-width:0;width:auto;padding-left:0;padding-right:0;height:auto;}

.gusForm .gusForm1Column.gusStackedRows .gusFormRow .gusFormFieldLeft,
.gusForm .gusForm2Column.gusStackedRows .gusFormRow .gusFormFieldLeft,
.gusForm .gusForm3Column.gusStackedRows .gusFormRow .gusFormFieldLeft,
.gusForm .gusForm4Column.gusStackedRows .gusFormRow .gusFormFieldLeft{text-align:left;padding-bottom:5px;max-width:none;}

.gusForm .gusForm1Column.gusStackedRows .gusFormRow .gusFormFieldRight,
.gusForm .gusForm2Column.gusStackedRows .gusFormRow .gusFormFieldRight,
.gusForm .gusForm3Column.gusStackedRows .gusFormRow .gusFormFieldRight,
.gusForm .gusForm4Column.gusStackedRows .gusFormRow .gusFormFieldRight{max-width:none;padding-bottom:25px;}

.gusForm .gusForm1Column.gusStackedRows .gusFormRow .gusFormField label,
.gusForm .gusForm2Column.gusStackedRows .gusFormRow .gusFormField label,
.gusForm .gusForm3Column.gusStackedRows .gusFormRow .gusFormField label,
.gusForm .gusForm4Column.gusStackedRows .gusFormRow .gusFormField label{display:inline-block;margin-right:0;}

.gusForm .gusForm1Column.gusStackedRows .gusFormRow .gusFormFieldRight select[multiple]{height:auto;min-width:0;width:199px !important;}
.gusForm .gusForm2Column.gusStackedRows .gusFormRow .gusFormFieldRight select[multiple]{height:auto;min-width:0;width:192px !important;}
.gusForm .gusForm3Column.gusStackedRows .gusFormRow .gusFormFieldRight select[multiple]{height:auto;min-width:0;width:100px !important;}
.gusForm .gusForm4Column.gusStackedRows .gusFormRow .gusFormFieldRight select[multiple]{height:auto;min-width:0;width:80px !important;}

.gusForm .gusForm1Column.gusStackedRows .gusFormRow .gusFormFieldRight table.multiSelectPicklistTable,
.gusForm .gusForm2Column.gusStackedRows .gusFormRow .gusFormFieldRight table.multiSelectPicklistTable,
.gusForm .gusForm3Column.gusStackedRows .gusFormRow .gusFormFieldRight table.multiSelectPicklistTable,
.gusForm .gusForm4Column.gusStackedRows .gusFormRow .gusFormFieldRight table.multiSelectPicklistTable{margin-top:-7px;}

/* Tight Labels (25% label, 75% field) */
.gusForm .gusForm2Column.gusTightLabels:first-child{padding-right:5px;}
.gusForm .gusForm2Column.gusTightLabels:last-child{padding-left:5px;}
.gusForm .gusForm2Column.gusTightLabels .gusFormRow .gusFormFieldLeft{width:25%;}
.gusForm .gusForm2Column.gusTightLabels .gusFormRow .gusFormFieldRight{width:75%;}
.gusForm .gusForm2Column.gusTightLabels label .gusFormHelpText{margin-top:4px;display:block;width:100%;background-position:top right;margin-left:0;margin-right:0;}

/* Alt Labels */
.gusForm .gusForm1Column.gusAltLabels label,
.gusForm .gusForm2Column.gusAltLabels label,
.gusForm .gusForm3Column.gusAltLabels label,
.gusForm .gusForm4Column.gusAltLabels label{text-transform:none;font-size:11px;}


/* label */
.gusForm .gusFormFieldLeft{text-align:right;padding-left:5px;padding-right:5px;-moz-user-select:none;-webkit-user-select:none;-ms-user-select:none;user-select:none;}
.gusForm .gusFormField label{display:block;margin-right:5px;/*white-space:nowrap;*/}
.gusForm .gusFormFieldLeft label{text-transform:uppercase;color:#205883;font-size:10px;font-weight:bold;}
.gusForm .gusFormFieldRight{color:#555;font-size:12px;}
.gusForm .gusFormFieldRight.gusFormFieldInlineEdit{-moz-user-select:none;-webkit-user-select:none;-ms-user-select:none;user-select:none;}

/* auto-complete - still need to style auto-complete dropdown too! */
.gusForm .gusFormField div.input-prepend{display:table;width:100%;-moz-box-sizing:border-box;box-sizing:border-box;}
.gusForm .gusFormField div.input-prepend div.input-prepend-col1{display:table-cell;width:30px;}
.gusForm .gusFormField div.input-prepend div.input-prepend-col2{display:table-cell;width:100%;}
.gusForm .gusFormField div.input-prepend div.input-prepend-col3{display:table-cell;}
.gusForm .gusFormField div.input-prepend img{vertical-align:top;display:inline-block;width:28px;height:28px;border-top-left-radius:4px;border-bottom-left-radius:4px;border:1px #ccc solid;border-right:0;}
.gusForm .gusFormField div.input-prepend input{vertical-align:top;display:inline-block;width:100%;min-height:30px;-moz-box-sizing:border-box;box-sizing:border-box;border-radius:0 4px 4px 0;margin:0;}

/* input */
.gusForm .gusFormField input[type=text],
.gusForm .gusFormField textarea,
.gusForm .gusFormField select,
input[type=text].gusStyle,
textarea.gusStyle,
select.gusStyle,
.gusForm .inlineEditDiv input[type=text],
.gusForm .inlineEditDiv textarea,
.gusForm .inlineEditDiv select{-webkit-appearance:none;font-family:'Ubuntu','Lucida Grande','Arial','Helvetica','sans-serif';display:inline-block;width:100%;min-width:220px;outline:0;font-size:12px;border:1px #ccc solid;padding:4px 6px;background-color:#fff;color:#555;-moz-box-sizing:border-box;box-sizing:border-box;border-radius:4px;/*box-shadow:inset 1px 2px 1px rgba(0, 0, 0, 0.10);-webkit-box-shadow:inset 1px 2px 1px rgba(0, 0, 0, 0.10);*/}
.gusForm .gusFormField select[multiple],
select[multiple].gusStyle,
.gusForm .inlineEditDiv select[multiple]{height:auto;width:117px !important;min-width:0px !important;background-image:none;}
.gusForm .gusFormField select,
select.gusStyle,
.gusForm .inlineEditDiv select{background-position:right 50%;background-repeat:no-repeat;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAA4AAAAMCAYAAABSgIzaAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBNYWNpbnRvc2giIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDZFNDEwNjlGNzFEMTFFMkJEQ0VDRTM1N0RCMzMyMkIiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDZFNDEwNkFGNzFEMTFFMkJEQ0VDRTM1N0RCMzMyMkIiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0NkU0MTA2N0Y3MUQxMUUyQkRDRUNFMzU3REIzMzIyQiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0NkU0MTA2OEY3MUQxMUUyQkRDRUNFMzU3REIzMzIyQiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PuGsgwQAAAA5SURBVHjaYvz//z8DOYCJgUxAf42MQIzTk0D/M+KzkRGPoQSdykiKJrBGpOhgJFYTWNEIiEeAAAMAzNENEOH+do8AAAAASUVORK5CYII=);}
.gusForm .gusForm1Column .gusFormField input[type=text],
.gusForm .gusForm1Column .gusFormField select{width:auto;}
.gusForm .gusForm1Column .gusFormField textarea{width:100%;}
.gusForm .gusForm1Column .gusFormField div.inlineEditDiv input{width:100%;}

.gusForm .gusForm3Column .gusFormField input[type=text],
.gusForm .gusForm3Column .gusFormField textarea,
.gusForm .gusForm3Column .gusFormField select{min-width:140px;}


.gusForm .gusFormField textarea,
textarea.gusStyle{resize:vertical;height:50px;padding-top:8px;padding-bottom:8px;}
.gusForm .gusFormField input[type=text],
.gusForm .gusFormField select,
input[type=text].gusStyle,
select.gusStyle{height:30px;}
.gusForm .gusFormField input[type=text]:focus,
.gusForm .gusFormField textarea:focus,
.gusForm .gusFormField select:focus,
input[type=text].gusStyle:focus,
select.gusStyle:focus,
textarea.gusStyle:focus{background-color:#ffffee;border-color:#aaa;}
.gusForm .gusFormField select[disabled],
select[disabled].gusStyle{opacity:0.5}

/* input (read only) */
.gusForm.gusFormReadOnly .gusFormField input[type=text],
.gusForm.gusFormReadOnly .gusFormField textarea,
.gusForm.gusFormReadOnly .gusFormField select{background-color:transparent;border:1px transparent;box-shadow:none;-webkit-box-shadow:none;padding:4px 6px 4px 7px;}
.gusForm.gusFormReadOnly .gusFormField select{padding:3px 6px 4px 9px;-webkit-appearance:none;}
.gusForm.gusFormReadOnly .gusFormField input[type=text]:focus,
.gusForm.gusFormReadOnly .gusFormField textarea:focus,
.gusForm.gusFormReadOnly .gusFormField select:focus{background-color:transparent;border:1px transparent;box-shadow:none;-webkit-box-shadow:none;}

/* input (inline edit) */
span.inlineEditModified{color:#B68547;}
span.inlineEditWrite{height:30px;line-height:30px;overflow:hidden;min-width:140px;}
span.inlineEditWriteOn{height:30px;line-height:30px;overflow:hidden;background:#D6E5E7;border-radius:4px;min-width:140px;}

span.inlineEditWrite > span{display:inline;-moz-user-select:text;-webkit-user-select:text;-ms-user-select:text;user-select:text;}
span.inlineEditWriteOn > span{display:inline;-moz-user-select:text;-webkit-user-select:text;-ms-user-select:text;user-select:text;}

a.inlineEditUndoLink{display:none !important;}
span.inlineEditWrite span.lookupInput input,
span.inlineEditWriteOn span.lookupInput input{margin-top:-4px;}
span.inlineEditWrite inlineEditDiv,
span.inlineEditWriteOn inlineEditDiv{height:30px;}
span.inlineEditWrite span.lookupInput a,
span.inlineEditWriteOn span.lookupInput a{top:-2px}

/* tooltips */
.gusFormHelpText{display:inline-block;margin-left:6px;margin-top:8px;opacity:0.2;vertical-align:middle;width:12px;height:12px;background-repeat:no-repeat;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBNYWNpbnRvc2giIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NDkxMjY1NjVENURDMTFFMjhFNkNGMTFFMkY2RTM5NzYiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NDkxMjY1NjZENURDMTFFMjhFNkNGMTFFMkY2RTM5NzYiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDo0OTEyNjU2M0Q1REMxMUUyOEU2Q0YxMUUyRjZFMzk3NiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDo0OTEyNjU2NEQ1REMxMUUyOEU2Q0YxMUUyRjZFMzk3NiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Puk4YN0AAAE0SURBVHjadFLBSoRQFH3vjQoqWrhKN5MwCxEqF66CsHbt+4Bp0wf4JfoJ9QFRy3YzUu1cBC6btbYSwhQExe6VhJcwFw5X7jvnnnt9jxIuTNNcQ7oFHAMOAR+A+6IoHiYO/SMeQNoqiuIByGKxIJRS0nUdaZoGgcJLEH4LKABCYhjGmSiKvCGRJGmEqqpeWZYJlDwBx5iT0zS9wuz7/gYzniGn7/s1dV33XZblc75znudjtizrn2Pbti8CqE/44tSdd5gCuKcMutd8EbpuYOEtgsyCMaYzWCqfCci+0DTtk9m2/bxvJP4bY7lcPtFhGI6CIHit63rFLzx3hF+7S5LkgsGsX3Ec32FhIvCYyMhB7njT4IIX6IVheJNl2XVVVStBEH50Xd85jvMWRdEjPhMQdL8CDAAtA2bTq0pHuwAAAABJRU5ErkJggg==);}
label .gusFormHelpText{margin-top:-2px;margin-left:4px;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAwAAAAMCAYAAABWdVznAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyJpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuMC1jMDYwIDYxLjEzNDc3NywgMjAxMC8wMi8xMi0xNzozMjowMCAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvIiB4bWxuczp4bXBNTT0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL21tLyIgeG1sbnM6c3RSZWY9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9zVHlwZS9SZXNvdXJjZVJlZiMiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENTNSBNYWNpbnRvc2giIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6QjYyRTgyNjVEMTI2MTFFMkE5OEZDNURBMDEwOUFBNjIiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6QjYyRTgyNjZEMTI2MTFFMkE5OEZDNURBMDEwOUFBNjIiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDpCNjJFODI2M0QxMjYxMUUyQTk4RkM1REEwMTA5QUE2MiIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDpCNjJFODI2NEQxMjYxMUUyQTk4RkM1REEwMTA5QUE2MiIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PuYYMP0AAAGGSURBVHjaXFJBSwJBFJ7ZXRUVdxdRUC8m7EGEaulWkOYtQbp0DKxL0NV7f6CTUn+gvIcdO7bUQmBh4Ckw8RAaBGLoisKCfU8cED94vJl533vvezPD2Qri8fgp3BlsA6bDPmC3/X7/TnD4kqjBPQUCARPGZFlmnHPmui6bTCZklHiAxD+FEkCwwuHwtsfjWVQJBoNtrMfD4dD0er20NweDgYWQKZOMSCRyIciFQuGyVqtdlUqlOs7eGo3GEXX0+XwxSZK6PJPJ2H6/f09UtixrN5FInJDEXq/3lcvlmo7jGBSfzWaPCqpsioEgwQD5V9O0b0j8xLobjUYN0R1+S0J1RyRQACRWLBZvbNt+xf5akAmQpPJsNvuOljur14sB2XQ6ZbquM7o1gVAo1JRSqdQDW0On08lDf36VTEgmk3U+n89jGOxZDEYAeeFJnsDyQvYlPNBPtVo9pwMRJOI6mTjEXbw0utADmuVy+bjVah2ORiNDUZSxqqrtdDr9UqlU7umbIMH9F2AAOZaIqqvWF3cAAAAASUVORK5CYII=);}
.gusFormHelpText:hover{opacity:0.6;}
body .ui-tooltip{background:#F6F8E2 !important;border:1px #D5CD72 solid !important;font-size:11px;padding:5px;position:absolute;z-index:9999;max-width:300px;-webkit-box-shadow:0 2px 5px #aaa;box-shadow:0 2px 5px #aaa;}
* html .ui-tooltip{background-image:none;}

.gusTabs > ul{list-style:none;margin:0;padding-left:0;box-sizing:border-box;-moz-box-sizing:border-box;border-bottom:2px #1797C0 solid;margin-bottom:20px;font-family:'Arial','Helvetica','sans-serif';font-size:11px;font-weight:bold;}
.gusTabs > ul > li{cursor:pointer;display:inline-block;margin:0;background-color:#e6e6e6;color:#555;text-decoration:none;padding:6px 12px;border-top-left-radius:5px;border-top-right-radius:5px;}
.gusTabs > ul > li:hover{text-decoration:none;}
.gusTabs > ul > li.on,
.gusTabs > ul > li.on:hover{background-color:#1797C0;color:#fff;text-decoration:none;}
.gusTabPanelActive{display:block;}
.gusTabPanelInactive{display:none;}

.gusFormToolbar{text-align:center;background:#85C8DD;padding:5px 0px;}
.gusFormToolbarTop{margin-bottom:15px;margin-left:-9px;margin-right:-9px;border-top-left-radius:10px;border-top-right-radius:10px;border-bottom-left-radius:0px;border-bottom-right-radius:0px;}
form .gusFormToolbarTop{margin-top:-20px;}
.gusFormToolbarBottom{margin-bottom:-9px;margin-left:-9px;margin-right:-9px;border-bottom-left-radius:10px;border-bottom-right-radius:10px;border-top-left-radius:0px;border-top-right-radius:0px;}

/* salesforce overrides */
body .oRight .bPageTitle .ptBody a{color:#6E7479;}
body .message{margin:0px 0px 20px 0px;border-width:2px;font-family:'Arial','Helvetica','sans-serif';font-size:11px;border-radius:10px;box-sizing:border-box;}
body .message li{list-style-type:square;}
body .gusFormMessage{border-color:#D62323;background-color:#F1E5E5;padding-top:12px;padding-bottom:12px;}
body .gusFieldset .bPageBlock .message{width:auto;margin:0px 0px 0px 0px;}

/* salesforce overrides (only work inside "gusFieldset" */
body .gusFieldset div.bRelatedList div.pbHeader td.pbTitle{display:none;}
body .gusFieldset div.bRelatedList .bPageBlock .pbBody{margin:0;}
body .gusFieldset div.secondaryPalette.bPageBlock{background-color:transparent;border:0;}
body .gusFieldset div.bPageBlock div.pbHeader>table>tbody>tr>td{padding:5px 0px;background:#85C8DD;text-align:center;}
body .gusFieldset div.bPageBlock div.pbHeader>table>tbody>tr>td.pbTitle{display:none;}
body .gusFieldset div.marginReducer{display:block;display:block;margin-left:-7px;margin-right:-7px;margin-top:-20px;border-top-right-radius:5px;overflow:hidden;padding-bottom:70px;}
body .gusFieldset div.marginReducer div.bPageBlock div.pbHeader>table>tbody>tr>td.pbButton{border-top-left-radius:0px;}
body .gusFieldset div.bPageBlock div.pbHeader>table>tbody>tr>td.pbButton{border-top-left-radius:5px;}
body .gusFieldset div.bPageBlock div.pbHeader>table>tbody>tr>td.pbHelp{border-top-right-radius:5px;}
body .gusFieldset.gusTeamMembersOutOfOffice .apexp .bPageBlock.apexDefaultPageBlock .pbHeader{display:none;}
body .gusFieldset .list td{padding-top:7px;padding-bottom:7px;}
body .gusFieldset .pbBody table.list tr th,
body .gusFieldset .pbBody table.list tr td{color:#555;border-bottom:1px solid #ddd !important;}
body .gusFieldset .apexp .bPageBlock.apexDefaultPageBlock .pbBody{margin:0;}
body .gusFieldset .apexp .bPageBlock.apexDefaultPageBlock .pbHeader>table{padding:0;border-bottom:0;}
body .gusFieldset .apexp .bPageBlock.apexDefaultPageBlock .pbHeader{border-bottom:0;}
body .gusFieldset td.dataCell{word-wrap:break-word;word-break:break-word;}
body .gusFieldset tr.actionFooter{background-color:#EAF6F8;}
body .gusFieldset .apexp .pbBody table.list{border:0px;}

/* buttons */
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn:not(.zen-btn),
body .gusFieldset input[type=button]:not(.zen-btn),
body .gusFieldset input[type=submit]:not(.zen-btn),
body .gusFieldset button:not(.zen-btn),
body .gusFieldset .menuButton .menuButtonButton,
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn:not(.zen-btn):hover,
body .gusFieldset input[type=button]:not(.zen-btn):hover,
body .gusFieldset input[type=submit]:not(.zen-btn):hover,
body .gusFieldset button:not(.zen-btn):hover{outline:0;-webkit-appearance:none;-webkit-font-smoothing:auto;background:#fff !important;border:1px #B3B3B3 solid;border-image-outset:0px;border-image-repeat:stretch;border-image-slice:100%;border-image-source:none;border-image-width:1;border-radius:5px;box-sizing:border-box;cursor:pointer !important;font-size:11px;font-weight:700;height:auto;margin:0px 4px !important;padding:9px 14px !important;color:#5C7995;box-shadow:none;}

body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn:hover,
body .gusFieldset input[type=button]:hover,
body .gusFieldset input[type=submit]:hover,
body .gusFieldset button:hover,
body .gusFieldset .menuButton .menuButtonButton:hover,
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn:focus,
body .gusFieldset input[type=button]:focus,
body .gusFieldset input[type=submit]:focus,
body .gusFieldset button:focus,
body .gusFieldset .menuButton .menuButtonButton:focus{border:1px #5C7995 solid !important;}

body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn.active,
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn:active,
body .gusFieldset input[type=button].active,
body .gusFieldset input[type=button]:active,
body .gusFieldset input[type=submit].active,
body .gusFieldset input[type=submit]:active,
body .gusFieldset button.active,
body .gusFieldset button:active,
body .gusFieldset .menuButton .menuButtonButton:active{background:#edeff0 !important;margin-top:0px;margin-bottom:0px;border:1px #5C7995 solid !important;box-shadow:none !important;}

/*
body .gusFieldset .apexp .bPageBlock .pbHeader .btn,
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn,
body .gusFieldset input[type=button],
body .gusFieldset input[type=submit],
body .gusFieldset button{cursor:pointer;vertical-align:top;color:#555;line-height:1.4;padding:4px 12px;background:#fff;border:1px #C0C0C0 solid;border-radius:5px;font-family:'Ubuntu','Lucida Grande','Arial','Helvetica','sans-serif';font-size:11px;font-weight:bold;box-shadow:1px 2px 1px rgba(0,0,0,.1);margin:0px 4px 2px 4px;outline:0;}
body .gusFieldset .apexp .bPageBlock .pbHeader .btn:focus,
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn:focus,
body .gusFieldset input[type=button]:focus,
body .gusFieldset input[type=submit]:focus,
body .gusFieldset button:focus{border:1px #aaa solid;}
body .gusFieldset .apexp .bPageBlock .pbHeader .btn:active,
body .gusFieldset .apexp .bPageBlock .pbHeader .btn[disabled=disabled],
body .gusFieldset input[type=button][disabled=disabled],
body .gusFieldset input[type=submit][disabled=disabled],
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn:active,
body .gusFieldset input[type=button]:active,
body .gusFieldset input[type=submit]:active,
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn[disabled=disabled],
body .gusFieldset button:active{border:1px #C0C0C0 solid;box-shadow:0px 0px 1px rgba(0,0,0,.1);margin-top:1px;margin-bottom:1px;}
body .gusFieldset .apexp .bPageBlock .pbHeader .btn[disabled=disabled],
body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn[disabled=disabled],
body .gusFieldset input[type=button][disabled=disabled],
body .gusFieldset input[type=submit][disabled=disabled],
body .gusFieldset button[disabled=disabled]{color:#aaa;}
*/

/* buttons: dropdown style */
body .gusFieldset .menuButton{margin:0;padding:0;display:inline-block;text-align:left;}
body .gusFieldset .bRelatedList .bPageBlock .menuButton .menuButtonButton{padding:4px 12px;}
body .gusFieldset .bRelatedList .menuButton .menuButtonButton{margin:0px 4px 2px 4px;}
body .gusFieldset .menuButton .menuButtonButton{color:#555;line-height:1.4;padding:4px 12px;background:#fff;border:1px #C0C0C0 solid;border-radius:5px;-webkit-border-radius:5px;font-family:'Ubuntu','Lucida Grande','Arial','Helvetica','sans-serif';font-size:11px;font-weight:bold;box-shadow:1px 2px 1px rgba(0,0,0,.1);margin:0px 4px 2px 4px;outline:0;display:inline-block;white-space:pre;text-align:left;}
body .gusFieldset .menuButton .menuButtonMenu{border:1px #C0C0C0 solid;border-radius:5px;-webkit-border-radius:5px;-webkit-box-shadow: 0 2px 5px #727272;box-shadow: 0 2px 5px #727272;}
body .gusFieldset .menuButton .menuButtonMenu a:hover{border-radius:5px;}

/* tab panel */
.workOptionsSelector{display:table;margin-top:30px;box-sizing:border-box;-moz-box-sizing:border-box;position:relative;}
.workOptionsSelector .workOptionsLeft{padding-bottom:30px;}
.workOptionsSelector .workOptionsRight{display:table-cell;width:100%;background-color:#F3F6F6;border-top-right-radius:10px;border-bottom-left-radius:10px;border-bottom-right-radius:10px;border:2px #85C8DD solid;vertical-align:top;}
.workOptionsSelector > ul{display:table-cell;min-width:115px;width:115px;text-align:center;font-weight:bold;vertical-align:top;border-bottom:0;margin-bottom:0;}
.workOptionsSelector > ul > li{position:relative;display:block;cursor:pointer;margin-top:7px;background-color:#CBE4EC;border:2px #CBE4EC solid;border-top-left-radius:10px;border-bottom-left-radius:10px;border-top-right-radius:0;border-right:0px;padding:45px 10px 10px 10px;background-position:50% 10px;background-repeat:no-repeat;}
.workOptionsSelector > ul > li:first-child{margin-top:0;}
.workOptionsSelector > ul > li.on,
.workOptionsSelector > ul > li.on:hover{background-color:#F3F6F6;border-color:#85C8DD;color:#555;}
.workOptionsSelector > ul > li > div.count{position:absolute;top:-4px;right:0px;background:#00485F;border-radius:10px;color:#fff;padding:2px 8px;font-size:12px;}
.workOptionsSelector > ul > li > div.bgline{display:none;}
.workOptionsSelector > ul > li.on > div.bgline{display:block;position:absolute;background:#F3F6F6;width:2px;right:-2px;top:0px;bottom:0px;}
.workOptionsSelector .gusFieldset{width:auto;border:0;margin-top:0;}
.workOptionsSelector .workOptionsStyle{cursor:pointer;position:absolute;top:0;right:0;width:40px;height:17px;z-index:2;background:#85C8DD;border-radius:14px;overflow:hidden;color:#85C8DD;border-top-left-radius:0px;border-bottom-right-radius:0px;}
.workOptionsSelector .workOptionsStyle .workOptionsStyleButton{padding-left:14px;font-size:0;}
.workOptionsSelector .workOptionsStyle .workOptionsStyleButton > .buttonPiece1{display:block;background:#fff;height:3px;width:13px;margin-top:3px;}
.workOptionsSelector .workOptionsStyle .workOptionsStyleButton > .buttonPiece2{display:block;background:#fff;height:3px;width:13px;margin-top:1px;}
.workOptionsSelector .workOptionsStyle .workOptionsStyleButton > .buttonPiece3{display:block;background:#fff;height:3px;width:13px;margin-top:1px;}
.workOptionsSelector.workOptionsStacked .workOptionsLeft{display:none;}
.workOptionsSelector.workOptionsStacked .workOptionsRight{background-color:transparent;border:0;display:block;margin-top:-30px;}
.workOptionsSelector.workOptionsStacked .workOptionsRight .gusFieldset{display:block !important;border:2px #85C8DD solid;margin-top:30px;}
.workOptionsSelector.workOptionsStacked .workOptionsRight .gusFieldset div.marginReducer{padding-bottom:10px;}
.workOptionsSelector.workOptionsStacked .workOptionsStyle .workOptionsStyleButton > .buttonPiece1{display:inline-block;height:11px;width:5px;margin-top:3px;margin-right:1px;}
.workOptionsSelector.workOptionsStacked .workOptionsStyle .workOptionsStyleButton > .buttonPiece2{display:inline-block;height:11px;width:9px;margin-top:3px;}
.workOptionsSelector.workOptionsStacked .workOptionsStyle .workOptionsStyleButton > .buttonPiece3{display:none;}


/* product tag */
.curvedContainer {-moz-border-radius-topleft: 20px;-moz-border-radius-topright: 20px;-moz-border-radius-bottomright: 20px;-moz-border-radius-bottomleft: 20px;border-top-left-radius: 20px;border-top-right-radius: 20px;border-bottom-right-radius: 20px;border-bottom-left-radius: 20px;margin-right:3px;margin-bottom:2px;}
#productTagContainer .productTagItem {margin-right:5px;font-size:12px;color:#fff;padding-left: 12px;padding-bottom: 3px;margin-top: 5px;background: #3F6075;float: left;padding-top: 2px;}
#productTagContainer .productTagItem .productTagItemBody {}
#productTagContainer .productTagItem .productTagItemName {color: #3F6075;padding-right:8px;padding-left:8px;padding-top:6px;padding-bottom:5px;font-size:12px;font-weight:bold;margin-right:3px;background: white;border: 3px solid #3F6075;}
#productTagContainer .productTagItem .productTagItemTeam {padding-right: 5px;}
#productTagContainer .productTagItem .productTagItemRemove {cursor: pointer; padding-right: 5px;vertical-align: text-top;background:url("/resource/1365022286000/agf__crossicon") no-repeat center center;padding-left: 6px;padding-right: 6px;margin-right: 7px;margin-left: 3px;}
#productTagTextBoxContainer {background:url("/resource/1365022286000/cloud_bg_lookup") no-repeat right top transparent;padding-right: 20px;}

.publishercontainer,.feedcontainer{max-width:none !important;}

/* rich autocomplete styles */
div.gusRichAutoComplete{font-size:0;position:relative;}
div.gusRichAutoComplete input[type=text]{font-size:12px;height:30px;outline:none;vertical-align:middle;display:inline-block;}
div.gusRichAutoComplete img.status-indicator{display:none;position:absolute;right:36px;top:7px;}
div.gusRichAutoComplete img.userInputProfileImage{display:inline-block;border-left:1px #ccc solid;margin-left:-30px;height:28px;width:28px;vertical-align:middle;border-top-right-radius:3px;border-bottom-right-radius:3px;}

.gusNoPhone{display:block;}
.gusNoPhoneInline{display:inline-block;}
.gusPhoneOnly{display:none;}
.gusPhoneOnlyInline{display:none;}

@media all and (device-width: 768px) and (device-height: 1024px){
    /* iPad */
    body{margin:0px 10px 10px 10px !important;}
    body .gusFieldset .apexp .bPageBlock .pbHeader .btn,
    body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn,
    body .gusFieldset input[type="button"],
    body .gusFieldset input[type="submit"],
    body .gusFieldset button{font-size:15px;}
    body .gusFieldset div#gusDstrContainer{max-width:none;}
    body .message,.gusFieldset,.gusTabs > ul,.workOptionsSelector{width:auto !important;max-width:none !important;}
    span.inlineEditWrite,
    span.inlineEditWriteOn{background:transparent;}
}

@media all and (device-width: 768px) and (device-height: 1024px) and (orientation:portrait) {
    /* iPad portrait */
    body td#sidebarCell{display:none;}
    div#contentWrapper{min-width:0px !important;}
    /*td.searchCell{display:none !important;}*/
    #phSearchContainer{width:165px;}
    #phSearchContainer div.searchBoxClearContainer{width:102px;}
    #phSearchContainer input[type=text]{width:102px;}
    #phSearchContainer div.headerSearchRightRoundedCorner{left:112px;}
    .gusForm .gusFormRow{display:block !important;}
    .gusForm .gusForm3Column .gusFormRow{border-top: 1px #BFE7F3 solid;padding-top:20px;}
    .gusForm .gusForm1Column .gusFormField,
    .gusForm .gusForm2Column .gusFormField,
    .gusForm .gusForm3Column .gusFormField{display:block;height:auto !important;padding-bottom:0px;padding-left:0 !important;padding-right:0 !important;}
    .gusForm .gusForm1Column .gusFormFieldLeft,
    .gusForm .gusForm2Column .gusFormFieldLeft,
    .gusForm .gusForm3Column .gusFormFieldLeft{text-align:left;padding-bottom:0px !important;}
    .gusForm .gusForm1Column .gusFormFieldLeft label,
    .gusForm .gusForm2Column .gusFormFieldLeft label,
    .gusForm .gusForm3Column .gusFormFieldLeft label{white-space:normal;white-space:nowrap;}
    .gusForm .gusForm1Column .gusFormFieldRight,
    .gusForm .gusForm2Column .gusFormFieldRight,
    .gusForm .gusForm3Column .gusFormFieldRight{padding-bottom:27px !important;min-width:0px;max-width:230px !important;font-size:13px;}
    #panelButton{font-size:13px;margin-left:69px;}
    span.inlineEditWrite,
    span.inlineEditWriteOn{height:auto;line-height:normal;}
}

@media all and (device-width: 768px) and (device-height: 1024px) and (orientation:landscape) {
    /* iPad Landscape */
    body td#sidebarCell{display:none;}
    body .gusFieldset div#gusDstrContainer{max-width:none;}
    div#contentWrapper{min-width:0px !important;}
    .gusForm .gusForm3Column .gusFormFieldLeft label{white-space:nowrap;}
}

@media only screen and (max-device-width: 700px) {
    /* iPhone/Mobile */
    .gusNoPhone{display:none !important;}
    .gusNoPhoneInline{display:none !important;}
    .gusPhoneOnly{display:block !important;}
    .gusPhoneOnlyInline{display:inline-block !important;}

    a{color:#015BA7 !important;text-decoration:none !important;}
    body{margin:0 !important;background:#fff !important;}
    div.bPageHeader,div.bPageFooter,.gusTabs,div.content > div,div.gusLegend{display:none;}
    td#bodyCell{padding:0px !important;}
    div.gusFieldset{margin-top:0 !important;border-radius:0px !important;border:0 !important;padding:0 !important;background:#f0f1f2 !important;}
    div.gusForm3Column{display:block !important;width:auto !important;}
    div.gusFormToolbar{border-radius:0px !important;margin:0px !important;}
    div.gusFormToolbarTop,div.gusFormToolbarBottom{}
    body .message,.gusFieldset,.gusTabs > ul,.workOptionsSelector{width:auto !important;}
    body td#sidebarCell{display:none;}
    body .gusFieldset .apexp .bPageBlock .pbHeader .btn,body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn,body .gusFieldset input[type="button"],body .gusFieldset input[type="submit"],body .gusFieldset button{-webkit-appearance:none;-webkit-box-align:center;-webkit-box-shadow:none;-webkit-font-smoothing:antialiased;-webkit-tap-highlight-color:rgba(0, 0, 0, 0);-webkit-touch-callout:none;-webkit-user-drag:auto;background-attachment:scroll;background-clip:border-box;background-color:rgba(0, 0, 0, 0);background-image:-webkit-linear-gradient(top, rgb(255, 255, 255), rgb(241, 241, 241));background-origin:padding-box;border-bottom-color:rgb(187, 192, 196);border-bottom-left-radius:5px;border-bottom-right-radius:5px;border-bottom-style:solid;border-bottom-width:1px;border-left-color:rgb(187, 192, 196);border-left-style:solid;border-left-width:1px;border-right-color:rgb(187, 192, 196);border-right-style:solid;border-right-width:1px;border-top-color:rgb(187, 192, 196);border-top-left-radius:5px;border-top-right-radius:5px;border-top-style:solid;border-top-width:1px;box-shadow:none;box-sizing:border-box;color:rgb(0, 0, 0);cursor:pointer;display:inline-block;font-size:16px;font-style:normal;font-variant:normal;font-weight:normal;height:35px;letter-spacing:normal;line-height:normal;list-style-image:none;list-style-position:outside;list-style-type:none;margin-bottom:0px;margin-left:4px;margin-right:4px;margin-top:0px;opacity:1;overflow-x:hidden;overflow-y:hidden;padding-bottom:4px;padding-left:14px;padding-right:14px;padding-top:4px;position:static;text-align:center;text-decoration: none;text-indent:0px;text-shadow:rgb(255, 255, 255) 0px 1px 1px;text-transform:none;vertical-align:top;visibility:visible;word-spacing:0px;}
    div#contentWrapper{min-width:0px !important;}
    span.inlineEditWrite,
    span.inlineEditWriteOn{background:transparent;}
    .gusForm div.gusFormRow{display:block !important;padding:14px !important;border-top:1px #cfd4d9 solid !important;line-height:15px !important;box-sizing:border-box !important;-webkit-box-sizing:border-box !important;}
    .gusForm div.gusFormField{height:auto !important;padding:0 !important;}
    .gusForm div.gusFormFieldLeft{display:block !important;text-align:left !important;color:#696e71 !important;font-size:13px !important;}
    .gusForm div.gusFormFieldLeft label{display:inline-block !important;text-transform:none !important;color:#696e71 !important;font-size:13px !important;font-weight:normal !important;margin-right:auto !important;margin-bottom:0px !important;}
    .gusForm div.gusFormFieldRight{display:block !important;color:#000 !important;font-size:15px !important;max-width:none !important;font-weight:normal !important;}
    .gusForm .gusFormField input[type="text"], .gusForm .gusFormField textarea, .gusForm .gusFormField select, input[type="text"].gusStyle, textarea.gusStyle, select.gusStyle{font-size:16px !important;}
    .gusForm .gusFormField input[type="text"], .gusForm .gusFormField textarea, .gusForm .gusFormField select, input[type="text"].gusStyle, textarea.gusStyle, select.gusStyle,div.gusRichAutoComplete img.userInputProfileImage{margin-top:8px !important;}
    .gusForm div.gusBlankValue{color:#696e71 !important;}
    .gusForm .gusFormField span.lookupInput a{display:none !important;}
    
    body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn,
    body .gusFieldset input[type=button],
    body .gusFieldset input[type=submit],
    body .gusFieldset button,
    body .gusFieldset .bRelatedList .bPageBlock .pbButton input.btn:hover,
    body .gusFieldset input[type=button]:hover,
    body .gusFieldset input[type=submit]:hover,
    body .gusFieldset button:hover{font-family:ProximaNova, Arial, sans-serif;font-size:16px;height:40px;}
}
