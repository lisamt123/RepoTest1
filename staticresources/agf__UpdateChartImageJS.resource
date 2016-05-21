function updatechartimage(iframe,clickthroughurl, chartHeightPix, chartWidthPix) {
	
	
	var chartImage;
	var divs;
	var images;
	var div;
		
	if(iframe.contentDocument) {
		chartImage = iframe.contentDocument.chartimage;
		divs = iframe.contentDocument.getElementsByTagName("div");
		images = iframe.contentDocument.getElementsByTagName("img");		
	} else if(iframe.contentWindow){
		chartImage = iframe.contentWindow.document.chartimage;
		divs = iframe.contentWindow.document.getElementsByTagName("div");
		images = iframe.contentWindow.document.getElementsByTagName("img");		
	}	
		
	for(var i = 0; i < divs.length; i++) {
		if(i != 0) {
			divs[i].className = 'hidden';
		} else {
			div = divs[i];
			div.className = '';
			div.style.position= "Absolute";
			div.style.top= "0px";
			div.style.left= "0px";
		}
	}		
	
	for(var i = 0; i < images.length; i++) {
		image = images[i];
		if(image.id != "chartimage") {
			image.className = "hidden";
		} else {			
			image.setAttribute('onclick', 'window.open("'+clickthroughurl+'")');
			image.style.cursor = 'pointer'; 
			div.appendChild(image);
		}
	} 
	
	iframe.height="100%";
	iframe.width="100%";
	
	var iframeParent = iframe.parentNode;
	//iframeParent.style.height = chartImage.height + 'px';
	//iframeParent.style.width = chartImage.width + 'px';
	//iframeParent.style.height = '207px';
	//iframeParent.style.width = '280px';
	iframeParent.style.height = chartHeightPix + 'px';
	iframeParent.style.width = chartWidthPix + 'px';

}
