.google-visualization-orgchart-table{
 height: 100%;
}

.chartFrame {
	margin-top: 20px;
	min-height: 500px;
    *height: 500px; 
}	

    .dialog{
     display: none;
    }
    
    .dialog input{
     width: 250px;
    }
    
    .expandIcon {
        width:16px;
        height:16px;
        background-image: url('{!URLFOR($Resource.chartPng)}');
        background-repeat: no-repeat;
    }      
     
    .dropcell{
     color: transparent !important;
     font-size: 2em !important;
     text-align: center !important;
     padding: 20px 0 20px 0 !important;  
    } 
    
    .ui-state-highlight{
      color: #009900 !important;
    }
    .chartCell{
     position: relative;
     //height: 300px;
     //overflow-y: auto;  
    }

  #userswithnorole{
   width: 240px;
   background-color: #EDF7FF;/*blue*/
   background-color: #DCFBDC;/*green*/
   background-color: #fff7ae;/*yellow*/
   padding: 10px 0 10px 0;
   border-radius: 5px;
   border: 2px solid #B5D9EA;/*blue*/
   border: 2px solid #e3ca4b;/*yellow*/
   border: 2px solid #009900;/*green*/ 
   font-size: 0.9em;
   position: fixed;
   z-index: 100;
 }
 
 #rolefilter{
  margin-left: 20px;
  width: 200px;
 }
 
 #userswithnorole h3{ 
    font-size: 1.2em;
    display: block;
    padding: 10px 0 10px 20px;
 }
 
  #userswithnorole h4{
    display: block;
  } 
  
 #userswithnorole .searchWrapper, #portal-filters{
  padding: 10px 0 0 20px;
 }
 
  .userblockwrapper{
   height: 300px;
   overflow-y: auto;
  }
 
 .userblock {
  padding: 20px 0 0 20px;
  clear: both;
  height: 65px;
  border-bottom: 1px dashed #CCCCCC;
 }
 
 .chartCell  .userblock{
  padding-left: 0;
 }
 
 .userblock:hover{
  background-color: #FFF7AE;
  cursor: pointer;
 }
 
 .userblock span{
  display: block;
  margin-left: 60px;
  font-size: 0.9em;
 }

 .userblock  .username{
  font-size: 1.1em;
  font-weight: bold;
 }
 
 .username:hover{
  text-decoration: underline;
  cursor: pointer;
 }

 #userswithnoroleopenclose{
  border: 1px solid #B5D9EA;/*blue*/
  border: 1px solid #009900;/*green*/
  display: block;
  float: left;
  margin-right: 10px;
  padding: 0 3px;
  text-align: center;
   width: 10px;
 }
    
 #userswithnoroleopenclose:hover{
  cursor: pointer;
 }
		
.google-visualization-orgchart-table{
 padding-bottom: 40px;
}	

.scrollable {
	height: 300px;
	overflow-y: auto;
}
		
.cellTitle {
	padding: 0px;
	font-size:1.2em;
	font-weight:bold;

}

.chartCellBody {
	padding: 0px;
	font-size:1em;
	line-height: 100%;
	margin: 0px;
}

.chartCell A {
	padding:0px;
	text-decoration:none;
}

.chartCell A:hover{
	padding:0px;
	text-decoration:none;
}
		
.chartCellIcon {
	float:left;
	width:50px;
	height:50px;
}

.nodeChartCell {
    height: 100%;
	width:190px;
	text-align: left;
	vertical-align: top;
	font-family: arial,helvetica;
	cursor: default;
	border: 2px solid #b5d9ea;/*blue*/
	border: 2px solid #009900;/*green*/
	border: 2px solid #1797c0; /* sf blue */
	-moz-border-radius: 5px;
	-webkit-border-radius: 5px;
	-webkit-box-shadow: rgba(0, 0, 0, 0.5) 3px 3px 3px;
	-moz-box-shadow: rgba(0, 0, 0, 0.5) 3px 3px 3px;
	background-color: #DCFBDC;/*green*/
	background-color: #edf7ff;/*blue*/
	background: -webkit-gradient(linear, left top, left bottom, from(#edf7ff), to(#cde7ee));		
}

/*
.nodeChartCellSelect {
	border: 2px solid #e3ca4b;
	background-color: #fff7ae;
	background: -webkit-gradient(linear, left top, left bottom, from(#fff7ae), to(#eee79e));
}*/

/*.addRole{
  background-color: #fff7ae;
  border-right: 2px solid #E3CA4B;
  border-left: 2px solid #E3CA4B;  
  border-bottom: 2px solid #E3CA4B;    
  box-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
  height: 18px;
  margin-left: 75px !important;
  margin-top: 1px !important;
  padding: 5px 5px 0 !important;
  position: absolute;  
  cursor: pointer;
}*/

.roleedit{
 font-size: 0.8em;
 float: right;
 display: block;
}

.roleDelete{
 float: right;
 font-size: 0.8em;
 display: block;
}

.rolename:hover{
  text-decoration: underline;
  cursor: pointer;
}

.google-visualization-orgchart-lineleft, .google-visualization-orgchart-lineright,
.google-visualization-orgchart-linetop, .google-visualization-orgchart-linebottom{
 border-color: #336600 !important;/*green*/
}

.ui-draggable-dragging{
 background-color: #fff7ae;/*yellow*/
 border: 2px solid #e3ca4b;/*yellow*/
 width: 175px;
 color: black;
 font-size:1em;
 padding: 5px;
 border-radius: 5px;
}

.ui-draggable-dragging a{
 color: black;
}

button.ui-button-icon-only {
 width: 1.4em !important;
 height: 1.2em !important;
}