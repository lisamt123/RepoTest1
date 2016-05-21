({
    doInit : function(component, event, helper) {
        helper.getProductAreaList(component);
        helper.getUserInfo(component);
    },
    
    createCase : function(component, event, helper) {
        //var urlString = window.location.href;
        //var toFind = "articleName=";
        //var articleName = urlString.substring(urlString.indexOf(toFind)+toFind.length,urlString.length);
        var descriptionField = component.find("description");
        var productAreaField = component.find("productArea");
        var description = descriptionField.get("v.value");
        var productArea = productAreaField.get("v.value");
        
        var f = true;
        if(description == ''){
            descriptionField.set("v.errors",[{messge:"Enter some description."}]);
            f = false;
        }else{
            descriptionField.set("v.errors",null);
        }
        if(productArea == ''){
            productAreaField.set("v.errors",[{messge:"Select some product Area."}]);
            productAreaField.addClass("has-error");
            //$A.util.addClass(productAreaField, 'has-error')
            f = false;
        }else{
            productAreaField.set("v.errors",null);
        }
        if(f){
            var newCase = component.get("v.newCase");
            helper.createCase(component,newCase);
        }
	}
})