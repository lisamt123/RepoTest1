/*Builds perforce compatible changelist description and stores in the users clipboard*/

function copyWorkItemToClipBoard() {

	var workName;

	if(document.getElementById('spanWorkName')) {
		workName = document.getElementById('spanWorkName').innerHTML;
	} else {
		//must be edit/new/clone page
		
		workName = document.getElementById('pageEdit:formEdit:pageBlockEdit:pageBlockSectionInformation:inputFieldWorkName').value;
	}

	var text2copy = "Bug #" + workName + " " + document.getElementById('spanSubject').innerHTML + "\n" +  window.location.href;
	
	if ( window.clipboardData ) {
		
		window.clipboardData.setData("Text", text2copy);
		
	}
	else if ( window.netscape ) { 
	
		var errorMessage = 'An error occurred. Firefox needs to be properly configured to allow copying to the clipboard.\n \n';
		errorMessage = errorMessage + 'Open the Firefox properties by typing about:config in the address bar of the browser.\n \n';
		errorMessage = errorMessage + 'Type signed.applets.codebase_principal_support into the filter and click on the "Show All" button.\n \n';
		errorMessage = errorMessage + 'Toggle the value to true by clicking on the current value of the entry.';
		
		try {
		
			netscape.security.PrivilegeManager.enablePrivilege('UniversalXPConnect');
			var clipboard = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);
			
			if ( clipboard ) {
				var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);
			}
			
			if ( trans ) {
				
				trans.addDataFlavor('text/unicode');
				
				var str = new Object();	
				var len = new Object();
				var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);
				var copytext=text2copy;
				
				str.data=copytext;
				trans.setTransferData("text/unicode",str,copytext.length*2);
				
				var clipboardid=Components.interfaces.nsIClipboard;
			
			}
			
			if ( clipboard ) {
				
				clipboard.setData(trans,null,clipboardid.kGlobalClipboard);
				
			}
			
		}
		
		catch( e ) {
			alert( errorMessage  );
		}
		
	}
}	