function alertme(){ alert(1); }
/*
function getFrameId( frameTitle ){
	var frames = parent.document.getElementsByTagName( 'iframe' ); // get all els by the tagname iframe
	var found = false;		
	
	alert( frameTitle );

	for ( i = 0; i < frames.length; i++ ) {			
		if ( frames[i].title == frameTitle) { // here is the name of the s-control as it was saved
			found = true;			
			frameId = frames[i].id;
		}
	}
	
	return frameId;
}
//---------------------------BEGIN resizeIframe----------------------------\\
function resizeIframe(){
	//reset the iframe height
	var iframe = parent.document.getElementById( frameId );

	if(iframe) {
		if(window.addEventListener) {
			window.addEventListener("resize", resizeIframeCaller, false);
			window.addEventListener("load", resizeIframeCaller, false);
		}
		else {
			window.attachEvent("resize", resizeIframeCaller);
			window.attachEvent("load", resizeIframeCaller);
		}

		var height = document.body.scrollHeight;
		iframe.style.height = height + 'px';
	}
}
//---------------------------END resizeIframe----------------------------\\
//---------------------------BEGIN resizeIframeCaller----------------------------\\
function resizeIframeCaller() {
	resizeIframe();
}
//---------------------------END resizeIframeCaller----------------------------\\*/