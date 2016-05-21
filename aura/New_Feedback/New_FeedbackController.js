({
	createFeedback : function(component, event, helper) {
        var urlString = window.location.href;
        var toFind = "articleName=";
        var articleName = urlString.substring(urlString.indexOf(toFind)+toFind.length,urlString.length);
        var desField = component.find("description");
        var des = desField.get("v.value");
        if(des == ''){
            desField.set("v.errors",[{messge:"Enter some description."}])
        }else{
            desField.set("v.errors",null);
            var newFeedback = component.get("v.newFeedback");
            helper.createFeedback(component,newFeedback,articleName);
        }
	}
})