({
    getUserInfo : function(component){
        var action = component.get("c.getCurrentUserInfo");
        action.setCallback(this, function(response) {
    		var state = response.getState();
    		if (component.isValid() && state === "SUCCESS") {
                var userInfo = JSON.parse(response.getReturnValue());
    			component.set("v.accountName", userInfo.accountName);
                component.set("v.userName", userInfo.userName);
                component.set("v.userEmail", userInfo.userEmail);
                component.set("v.userPhone", userInfo.userPhone);
    		}
		});
		$A.enqueueAction(action);
    },
    getProductAreaList : function(component) {
        var action = component.get("c.getProductAreaList");
    	action.setCallback(this, function(response) {
    		var state = response.getState();
    		if (component.isValid() && state === "SUCCESS") {
    			component.set("v.productAreaList", response.getReturnValue());
    		}
		});
		$A.enqueueAction(action);
	},
    createCase : function(component, newCase) {
        var action = component.get("c.saveCase");
        action.setParams({
        	"newCase" : newCase
        });
        
        action.setCallback(this, function(response){
            var state = response.getState();
            var toastEvent = $A.get("e.force:showToast");
            if (state === 'SUCCESS'){
                toastEvent.setParams({
                	"title": "Success!",
                    "message": "The Case created."
                });
            }
            else {
                toastEvent.setParams({
                	"title": "Error!",
                	"message": " Something has gone wrong."
                });
            }
            toastEvent.fire();  
            
            var evt = $A.get("e.force:navigateToURL");
            evt.setParams({
                "url" : "/"
            });
            evt.fire();
        });
        
        $A.enqueueAction(action);
	}
})