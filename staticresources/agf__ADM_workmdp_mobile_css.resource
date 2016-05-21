*{font-family:'ProximaNovaSoft-Regular',Arial;}
body{/*background-color:#f2f2f2;*/margin:0;padding:0;}
.gusFieldset{padding-top:0;max-width:none;}
.gusFormRow{padding:5px 0px;}
.gusFormFieldLeft{font-weight:normal;font-size:14px;}
.gusFormFieldRight{font-size:14px;}
.gusForm2Column > div.gusFormRow:nth-child(1){padding-right:4px;}
.gusForm2Column > div.gusFormRow:nth-child(2){padding-left:4px;}
.gusForm3Column > div.gusFormRow:nth-child(1){padding-right:4px;}
.gusForm3Column > div.gusFormRow:nth-child(2){padding-left:4px;padding-right:4px;}
.gusForm3Column > div.gusFormRow:nth-child(3){padding-left:4px;}
label{color:#696e71;}
input[type=text],textarea,select{font-family:'ProximaNovaSoft-Regular',Arial;background:#e8eaeb;border-color:#cfd0d2;font-size:15px;padding:12px 7px;color:#3b3c3d;box-shadow:0px 2px 6px #dadcdd inset;-webkit-box-shadow:0px 2px 6px #dadcdd inset;}
input[type=text]:focus,textarea:focus,select:focus{border-color:#bbc0c4;outline:0;background:#fff;-webkit-box-shadow:none;box-shadow:none;-webkit-box-shadow:none;}
textarea{height:130px;}
.gusFormToolbar{display:none;margin-top:6px;background:transparent;text-align:center;padding:0px 0px 20px 0px;border-top:0;}
input[type=submit]{font-family:'ProximaNovaSoft-Regular',Arial;background-image:-webkit-linear-gradient(top, #fff 0px, #f3f3f3 100%);font-size:15px;width:100%;color:#44596c;background-color:#fff;border-radius:3px;border-color:#bbc0c4;box-shadow:none;-webkit-box-shadow:none;font-weight:normal;padding:0px;height:34px;}
div.message{margin:5px 0px;}
div.gusRichAutoComplete img.userInputProfileImage{margin-left:-44px;width:43px;height:43px;}
ul.ui-autocomplete > li{border-bottom:1px #c7ccce solid;}
ul.ui-autocomplete > li:last-child{border-bottom:0;}
ul.ui-autocomplete > li > a{line-height:3.5;}
ul.ui-autocomplete > li > a:active{background:#D0E5F5;}

@media only screen and (max-width:400px) {
	/* Mobile (inherits all above) */
	.gusForm2Column,.gusForm3Column{display:block}
	.gusForm2Column > div.gusFormRow,.gusForm3Column > div.gusFormRow{display:block;width:100%;padding-left:0 !important;padding-right:0 !important;}
	textarea{height:70px;}
	textarea:focus{height:240px;}
}