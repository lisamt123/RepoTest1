/* Gus Related Email Functions */

function createEmailFromWorkItem() {
	var subjectText = document.getElementById('spanSubject').innerHTML;	
	var nameText = document.getElementById('spanWorkName').innerHTML;	
	var subject = escapeUTF ( "Work #" + nameText + " - " + subjectText );
	var body = escapeUTF ( window.location.href ); 
	document.location = "mailto: ?subject=" + subject + "&body=" + body;
}

function perforceCheckinRequest(){
	document.location = "mailto:PerforceCheckins@salesforce.com?subject=" + getSubject() + "&body=" + getBody();
}

function getSubject(){
	var subject = escapeUTF ( "Perforce Checkin Request" );
	return subject;
}

function getBody(){
	var build = document.getElementById('spanScheduledBuild').innerHTML;
	var body = escapeUTF ( window.location.href );
	if ( build != null && build != '' ){
		body += "%0D%0A%0D%0A- What is broken?What are we fixing?";
		body += "%0D%0A%0D%0A- What needs to be tested? What are the areas impacted?";
		body += "%0D%0A%0D%0A- Who reviewed your changes?";
		body += "%0D%0A%0D%0A- Why is it important to fix this bug in this patch release?";
	}
	return body;
}