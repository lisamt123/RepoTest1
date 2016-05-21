var divHover2 = '';
var showTimeOutVar = null;
var hideTimeOutVar = null;
 		
 		/* when a button is clicked from the ddl this method fires.. */
 		/* -closes all ddl's on the page and opens up options for the button clicked */
 		/* -if the button clickd is another ddl, it hides the first ddl- */
 		
 		
 		function showOptions2Delayed(objId){
 			clearHideVar();
  			showTimeOutVar = setTimeout(function (){
  				showOptions2(objId); 
  				divHover2 = 'CloneMenuHover' + objId;
  			}, 500);
  		}
  		
  		function hideOptions2Delayed(){
  			clearShowVar();
  			hideTimeOutVar = setTimeout(function (){
  				divHover2 = '';
  				hideOptions2();
  			}, 500);
  		}
  		
  		function clearHideVar(){
  			//if (hideTimeOutVar) {
  				clearTimeout(hideTimeOutVar);
  			//}
  		}
  		
  		function clearShowVar(){
  			//if (showTimeOutVar) {
  				clearTimeout(showTimeOutVar);
  			//}
  		}
  		
 		
		function showOptions2(objId){
			clearHideVar();
			var multiButtons2 = document.getElementsByName("hoverButton");
			for(var j=0; j < multiButtons2.length; j++){
				multiButtons2[j].style.position = '';
			}
		  	
			var multiButtonOpts2 = document.getElementsByName("hoverButtonOpts");
			for(var j=0; j < multiButtonOpts2.length; j++){
				multiButtonOpts2[j].style.display = 'none';
			}		
		  
			document.getElementById('CloneMenuHover' + objId).style.display = 'block';
			document.getElementById('CloneMenuHover' + objId).style.top = '17px';
			document.getElementById('CloneMenuHover' + objId).style.left = '25px';
			//document.getElementById('CloneMenuHover' + objId).style.width = '900px';
			document.getElementById('hover' + objId).style.position = 'relative';
		}
		 
		/* close ddl when the mouse leaves the poppup */
		
		function hideOptions2(){
			clearShowVar();
			if(divHover2 == '' || divHover2 == null){
				var divs2 = document.getElementsByTagName('div');
				for(j=0; j < divs2.length; j++){
					if(divs2[j].getAttribute('name') == 'hoverButton'){
						divs2[j].style.position = '';
					}
					if(divs2[j].getAttribute('name') == 'hoverButtonOpts'){
						divs2[j].style.display = 'none';
					}
				}
			}
		}
		
		/* document.onmouseover = function(){ } */
			
