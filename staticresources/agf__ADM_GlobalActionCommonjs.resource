function getGlobalActionRedirectUrl(workType) {
	switch(workType)
	{
		case 'Bug':
		    return '/apex/adm_workbugrichglobalaction';
			break;
		case 'UserStory':
		    return '/apex/adm_workstoryrichglobalaction'
		    break;
	}
}

function isMobileDevice(){
	var deviceAgent = navigator.userAgent.toLowerCase();
    var agentID = deviceAgent.match(/(iphone|ipod|ipad)/);
    console.log('agent:'+agentID);
    if(null == agentID){
    	return false;
    }
    return true;
}

function doMobileAction(workType){
	sforce.one.navigateToURL(getGlobalActionRedirectUrl(workType));
}

function doDesktopAction(){
	$('li.publisherFeedItemTypeChoice a[title="Bug"],li.publisherFeedItemTypeChoice a[title="Story"]', parent.window.document).bind('click', function(e) {
            if ($(this).data('loaded')) {
                return;
            }
            var actionLabel = $(this).attr('title'); // assumes the title will always be "Bug" or "Story"
            var actionElementId = $(this).attr('id'); // assumes element ID starts with "publisherAttach", followed by ID of the global action
            if (actionElementId.indexOf('publisherAttach') === 0) {
                var actionId = actionElementId.substring('publisherAttach'.length);
                $('.' + actionId + ' iframe', parent.window.document).attr('src','/apex/adm_work' + actionLabel + 'richglobalaction');
                $(this).data('loaded',true);
            }
        });
}

function onProjectOne(){
	if((typeof sforce != 'undefined') && (null != sforce)){
		return true;
	}
	return false;
}

function getGlobalActionRedirect(workType){
	
    if(isMobileDevice()){
        doMobileAction(workType);
    }
    else{
        doDesktopAction();
    }
}
