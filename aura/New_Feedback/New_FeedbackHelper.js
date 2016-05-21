({
	createFeedback : function(component, feedback,articleName) {
		var action = component.get("c.saveFeedback");
        action.setParams({
        	"feedback" : feedback,
            "articleName" : articleName
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            var toastEvent = $A.get("e.force:showToast");
            if (state === 'SUCCESS'){
                toastEvent.setParams({
                	"title": "Success!",
                    "message": "The Feedback created."
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
                "url" : "/article/" + articleName
            });
            evt.fire();
        });
        
        $A.enqueueAction(action);
	}
})