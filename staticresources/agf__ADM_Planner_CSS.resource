*{font-family:'Helvetica','Arial';font-size:13px;color:#555;}
html{/*height:100%;overflow:hidden;*/}
body{margin:0;padding:0;/*height:100%;*/overflow:hidden;}
#optionsBar{outline:0;z-index:3;margin-top:-92px;position:fixed;right:100px;top:0px;text-align:center;user-select:none;-webkit-user-select:none;-moz-user-select:none;-webkit-transition-duration:0.3s;-moz-transition-duration:0.3s;-o-transition-duration:0.3s;transition-duration:0.3s;white-space:nowrap;}
#optionsBarPiece{cursor:pointer;background:#85C8DD;display:inline-block;padding:3px 15px;border-bottom-left-radius:10px;border-bottom-right-radius:10px;color:#fff;font-weight:bold;font-size:13px;box-shadow:0px 4px 13px -5px #000;}
#toolBar{display:table;background:#F3F6F6;border:2px #85C8DD solid;border-top:0px;padding:5px;border-bottom-left-radius:10px;border-bottom-right-radius:10px;font-size:0;}
#toolBar a.icon{vertical-align:top;width:60px;display:table-cell;padding:10px 15px;min-height:33px;font-weight:bold;font-size:10px;border-right:1px #B1E6E1 solid;text-align:center;background-position:50% 9px;background-repeat:no-repeat;text-decoration:none;white-space:normal;}
#toolBar a.icon div.text{font-size:10px;}
#toolBar a.icon:hover{background-color:#DAECEC;}
#toolBar a.icon:first-child{border-top-left-radius:10px;border-bottom-left-radius:10px;}
#toolBar a.icon:last-child{border-right:0;border-top-right-radius:10px;border-bottom-right-radius:10px;}
#toolBar a.icon .fa{display:block;font-size:30px;margin-bottom:6px;}
#toolBar a.exitFullscreen{display:none;}
#holder{/*position:relative;*/width:100%;height:100%;display:table;position:absolute;left:0px;right:0px;top:0px;bottom:0px;overflow:hidden;}
.column1{position:relative;display:table-cell;width:225px;min-width:225px;}
.column1 #workRecords{display:inline-block;height:100%;border-right:2px #85C8DD solid;position:absolute;top:0px;bottom:0px;width:223px;}
.column1 #column1piece{display:none;position:absolute;top:96px;right:-60px;font-size:13px;padding:3px 15px;font-weight:bold;background:#85C8DD;color:#fff;-webkit-transform:rotate(-90deg);transform:rotate(-90deg);border-bottom-left-radius:10px;border-bottom-right-radius:10px;cursor:default;}
.column2{display:table-cell;position:relative;background:#fff;width:100%;}
.column2 div.loader{background-color:#fff;width:32px;height:32px;position:absolute;margin-left:31px;top:28px;display:none;padding-left:40px;line-height:32px;background-image:url(data:image/gif;base64,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);background-repeat:no-repeat;}
.column2 iframe{position:absolute;top:0px;bottom:0px;}
.column3{position:relative;margin-right:-160px;display:block;border-left:2px #85C8DD solid;min-width:158px;width:158px;height:100%;/*-webkit-transition-duration:0.3s;-moz-transition-duration:0.3s;-o-transition-duration:0.3s;transition-duration:0.3s;*/}
.column3 iframe{position:absolute;top:0px;bottom:0px;width:158px;}
.column3.column3pushed{margin-right:0;display:table-cell;}
.notice{position:absolute;top:20px;margin-left:20px;}
.notice span{font-size:24px;vertical-align:sub;margin-right:4px;}

@media only screen and (max-width: 1160px) {
	#holder{display:block;}
	.column1,.column2{display:block;left:0;top:0;bottom:0;}
	.column1 #column1piece{display:inline-block;}
	.column1{position:fixed;z-index:2;margin-left:-223px;border-right:0;padding-right:19px;-webkit-transition-duration:0.3s;-moz-transition-duration:0.3s;-o-transition-duration:0.3s;transition-duration:0.3s;}
	.column1:hover,.column1.open{margin-left:0;-webkit-transition-duration:0.3s;-moz-transition-duration:0.3s;-o-transition-duration:0.3s;transition-duration:0.3s;}
	.column1:hover #workRecords{box-shadow:0px 0px 16px #000;}
	.column1:hover #column1piece{box-shadow:0px 7px 14px -7px #000;}
	.column2{position:absolute;right:0;z-index:1;padding-left:35px;width:auto;-webkit-transition-duration:0.3s;-moz-transition-duration:0.3s;-o-transition-duration:0.3s;transition-duration:0.3s;}
	.column2pushed{right:0px;}
	.column2 div.loader{margin-left:66px;}
	.column2 iframe{right:0;}
	.notice{margin-left:55px;}
	.column3{z-index:2;position:absolute;right:0;top:0;bottom:0;}
}