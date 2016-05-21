({
	submitCase : function(component, event, helper) {
        //var urlString = window.location.href;
        //var idx = urlString.indexOf("article");
        //var str = urlString.substring(idx,urlString.length);
        //var articleUrlName = str.substring(8,str.length);
        var evt = $A.get("e.force:navigateToURL");
        evt.setParams({
            "url" : "/newcase"
        });
        evt.fire();
	}
})