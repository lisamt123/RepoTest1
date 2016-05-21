// General //////////////////////////////////////////////////////////////////////
//Browser detection
var ns6=document.getElementById&&!document.all;
var ie=document.all;

function stringValue(s){
	var val = 0;
	for(i=0; i<(s.length); i++){
		val += s.charCodeAt(i)+255;
	}
	return val;
}

function compareString(a,b){
	return (stringValue(a)-stringValue(b));
}

function getPartialHier(h,l){
	var hierArr = h.split(".");
	var retHier = "";
	if((hierArr.length)<l){
		return h;
	}else{
		for(i=1; i<=l; i++){
			if(i<l)
			retHier += hierArr[i-1] + ".";
			else
			retHier += hierArr[i-1];
		}
		return retHier;
	}
}

function stringTuple(s1,s2){
	this.first = s1;
	this.second = s2;
}
function compareTuple(t1,t2){
	return (stringValue(t1.first)-stringValue(t2.first));
}

//Converts RGB string to a hex
function RGBtoHex(s) {
	var rgbs = s.substring(4,(s.length-1));
	var rgbArr = rgbs.split(",");
	return "#"+toHex(rgbArr[0])+toHex(rgbArr[1])+toHex(rgbArr[2]);
}

//Converts a single decimal to hex
function toHex(N) {
	if (N==null) return "00";
	N=parseInt(N); if (N==0 || isNaN(N)) return "00";
	N=Math.max(0,N); N=Math.min(N,255); N=Math.round(N);
	return "0123456789ABCDEF".charAt((N-N%16)/16) + "0123456789ABCDEF".charAt(N%16);
}

function lastIndexOf(s1,s2){
	var lastIndex = s2.indexOf(s1,lastIndex+1);
	while(s2.indexOf(s1,lastIndex+1) != -1){
		lastIndex = s2.indexOf(s1,lastIndex+1);
	}
	return lastIndex;
}

function parseStrongTags(m){
	m = m.replace(/<strong>/g,"");
	m = m.replace(/<\/strong>/g,"");
	return m;
}

function getCookieParam(p){
	p += "=";
	var cookie = document.cookie;
	var pOffset = (p.length);
	var pStart = cookie.indexOf(p);
	if(pStart == -1)
		return "";
	else
		pStart+=pOffset
	var pEnd = cookie.indexOf(";", pStart);
	var param = cookie.substring(pStart, pEnd);

	return param;
}

function resizeIFrame(){
	try{
		if(ie){
			thisiframe.height = Math.max(iframeMinHeight,thisiframe.Document.body.scrollHeight);
		}else{
			thisiframe.height = Math.max(iframeMinHeight,thisiframe.contentWindow.document.documentElement.scrollHeight);
		}
	}catch(e){
	}
	setTimeout("resizeIFrame()",100);
}