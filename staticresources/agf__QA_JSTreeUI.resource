//browser detection
var ns6=document.getElementById&&!document.all;
var ie=document.all;

//defines the appearance of the tree and set by the constructor
var bg_color, h_color, s_color, e_color;

//semaphore locks to prevent multiple operations of the same time from happening since
//visualforce page to apex class calls are asynchronus so if a new call of the same
//visualforce function is called before a previous on returns, the apex class goes crazy
var selectLock = false;
var loadBranchLock = false;
var loadDetailsLock = false;
var selectBranchLock = false;
var changedOrderLock = false;
var openBranchLock = false;
	
//constructor of the UI tree
function initTreeUI(arg_c1,arg_c2,arg_c3,arg_c4){
	//properties
	bg_color = arg_c1.toLowerCase();
	h_color = arg_c2.toLowerCase();
	s_color = arg_c3.toLowerCase();
	e_color = arg_c4.toLowerCase();
}

//apex classes escape HTML entities in strings so we need to change them back to display
//correct html
function unescapeEntities(str){
	return str.replace(/&gt;/gi,">").replace(/&lt;/gi,"<").replace(/&amp;/gi,"&");
}

//resizes an iframe
function resize(){
    try{
        if(ie){
            thisiframe.height = document.getElementById("pageBottom").offsetTop; 
        }else{
            thisiframe.height = document.getElementById("pageBottom").offsetTop; 
        }
    }catch(e){}
    setTimeout("resize()", 500);
}

//toggles the highlight of a branch or item in the tree
function toggleHighlight(groupId){
	var cbox = document.getElementById(groupId + ".cbox");
	var branch = document.getElementById(groupId + ".highlight");
	
	//change color for checked
	var bgColor=ns6 ? branch.style.backgroundColor.replace(/, /g,",") : branch.style.backgroundColor;

	if(cbox != null && cbox.checked == true){
		if(bgColor == s_color)
			branch.style.backgroundColor = e_color;
		else
			branch.style.backgroundColor = s_color;
	//change color for not checked
	}else{
		if(bgColor == bg_color || bgColor == "")
			branch.style.backgroundColor = h_color;
		else
			branch.style.backgroundColor = "";
	}
}

function escapeHierarchy(str){
	if(str == null) 
		return null;
	else
		return str.replace(/\\/g,"\\\\").replace(/\'/g,"\\\'");
}

//add an open branch to the list
function addOpenBranch(path){
	//see if we are already contacting the apex class about adding a branch, if so
	//wait 200 ms and try again until able to.
	if(selectBranchLock){
		var delayedAddBranch = setTimeout("addOpenBranch('" + escapeHierarchy(path) + "')", 200);
	}else{
		selectBranchLock = true;
		addOpenBranchApex(path);
	}
}

//remove an open branch to the list
function removeOpenBranch(path){
	//see if we are already contacting the apex class about removing a branch, if so
	//wait 200 ms and try again until able to.
	if(selectBranchLock){
		var delayedRemoveBranch = setTimeout("removeOpenBranch('" + escapeHierarchy(path) + "')", 200);
	}else{
		selectBranchLock = true;
		removeOpenBranchApex(path);
	}
}

//toggle a branch open and closed
function toggleBranch(branchId){
	//get branch elements
	var ifLoaded = document.getElementById(branchId + ".loaded");
	var branch = document.getElementById(branchId + ".branch");
	var twisty = document.getElementById(branchId + ".twist");
	var path = unescape(branchId).replace(/\+/g," ");
	
	//if the branch is already loaded just open or close it
	if(ifLoaded.value == "true"){
		if(branch.style.display == ""){
			removeOpenBranch(path);
			branch.style.display = "none";
			twisty.src = "/img/twistySubhRight.gif";
		}else{
			addOpenBranch(path);
			branch.style.display = "";
			twisty.src = "/img/twistySubhDown.gif";
		}
	//if branch is not loaded, try to loaded it if another load is not already happening
	}else{
		var content = document.getElementById(branchId + ".content");
		
		branch.style.display = "";
		twisty.src = "/img/twistySubhDown.gif";
		content.innerHTML = "Loading...";
		
		if(!loadBranchLock){
			//if no other load operation is happening, load it
			loadBranchLock = true;
			loadBranch(path, branchId);
			ifLoaded.value = "true";
		}else{
			//if another load operation is occuring, try again in 200ms
			var delayedLoadBranch = setTimeout("toggleBranch('" + branchId + "')", 200);
		}
	}
}

//force load/open a branch, used when initially loading or regenerating the tree and reopening memorized branches
//or just returning tree to the state before regeneration
function forceLoadBranch(branchId){
	//put up the load screen to block users clickety clicketies which might interfere with apex calls
	showLoadScreen();
	
	//just in case something goes wrong, we dont want the load screen to block everything else
	try{
		//get branch elements
		var ifLoaded = document.getElementById(branchId + ".loaded");
		var branch = document.getElementById(branchId + ".branch");
		var twisty = document.getElementById(branchId + ".twist");
		var path = unescape(branchId).replace(/\+/g," ");
		
		//if the branch is already loaded, just open it
		if(ifLoaded.value == "true"){
			branch.style.display = "";
			twisty.src = "/img/twistySubhDown.gif";
			openRemainingBranches();
		} else {
			//show loading text for the branch
			var content = document.getElementById(branchId + ".content");
			branch.style.display = "";
			twisty.src = "/img/twistySubhDown.gif";
			content.innerHTML = "Loading...";
			
			if(!loadBranchLock){
				//if no other load operation is happening, load it
				loadBranchLock = true;
				loadBranch(path, branchId);
				ifLoaded.value = "true";
			}else{
				//if another load operation is occuring, try again in 200ms
				var delayedLoadBranch = setTimeout("forceLoadBranch('" + branchId + "')", 200);
			}
		}
		
		//update the load screen to block any new content that might have popped up
		showLoadScreen();
	}catch(e){
		hideLoadScreen();
	}
}

//show the load screen to block user actions on the tree
function showLoadScreen(){
	//get the load screen elements
	var treeWrapperDiv = document.getElementById("treeWrapper");
	var loadBgDiv = document.getElementById("loadBg");
	var loadTextDiv = document.getElementById("loadText");
	
	//position and size the load screen and text to cover the entire tree
	loadBgDiv.style.display = "";
	loadTextDiv.style.display = "";
	
	loadBgDiv.style.height = treeWrapperDiv.offsetHeight + "px";
	loadBgDiv.style.width = treeWrapperDiv.offsetWidth + "px";
	
	loadTextDiv.style.width = treeWrapperDiv.offsetWidth + "px";
	loadTextDiv.style.top = ((treeWrapperDiv.offsetHeight-loadTextDiv.offsetHeight)/2) + "px";
}

//hide the load screen to allow the user to manipulate the tree again
function hideLoadScreen(){
	document.getElementById("loadBg").style.display = "none";
	document.getElementById("loadText").style.display = "none";
}

//toggle open and close the details of a TC or TE
function toggleDetails(caseId){
	//get some details elements
	var idList = caseId.split("|~|");
	var ifLoaded = document.getElementById(caseId + ".loaded");
	var details = document.getElementById(caseId + ".details");
	
	if(ifLoaded.value == "true"){
		//if already loaded, just expand the details
		if(details.style.display == "")
			details.style.display = "none";
		else
			details.style.display = "";
	}else{
		//display some load text
		var content = document.getElementById(caseId + ".content");
		details.style.display = "";
		content.innerHTML = "Loading...";
		
		if(!loadDetailsLock){
			//if another details load is not happening, load it
			loadDetailsLock = true;
			loadDetails(idList[1], caseId);
			ifLoaded.value = "true";
		}else{
			//id another details load is happening, wait and try again in 200ms
			var delayedDetails = setTimeout("toggleDetails('" + caseId + "')", 200);
		}
	}
}

//update the visual counters for the number of elements selected
function updateNumSelected(path, inc){
	var pathArr = path.split(".");
	var curPath = pathArr[0];
	
	//iterate through the entire path and update counts by the inc value
	for(i=1; i<=pathArr.length; i++){
		var count = document.getElementById(curPath + ".count");
		var name = document.getElementById(curPath + ".name");
		var label = document.getElementById(curPath + ".label");

		if(count != null){
			count.value = parseInt(count.value) + inc; //get the currunt count and increment(or decrement it)
			
			//update the text with correct count
			if(count.value != 0)
				label.innerHTML = "&nbsp;&nbsp;" + (name.value).replace(/\+/g," ") + " <span class=\"textGreenItalic\">(" + count.value + ")</span>";
			else
				label.innerHTML = "&nbsp;&nbsp;" + (name.value).replace(/\+/g," ");
		}

		curPath += "." + pathArr[i];
	}
}

function gotoHash(hashId){
	if(hashId != "" || hashId != null) window.location.hash = hashId;
}

function delayToggleSelect(caseId){
	var cbox = document.getElementById(caseId + ".cbox");

	if(toggleSelect(caseId))
		cbox.disabled = false;
	else
		cbox.disabled = true;
}

function toggleSelect(caseId){
	var cbox = document.getElementById(caseId + ".cbox");
	var branch = document.getElementById(caseId + ".highlight"); //select the row
	if(cbox.checked == false)
		branch.style.backgroundColor = bg_color;
	else
		branch.style.backgroundColor = s_color;
	
	if(!selectLock){
		var idList = caseId.split("|~|");
		selectLock = true;

		//if checkbox already checked, uncheck and revert back to original color
		if(cbox.checked == false){
			deselectElem(idList[1], idList[0]);
			updateNumSelected(idList[0], -1);
		//else, check and change to selected color
		}else{
			selectElem(idList[1], idList[0]);
			updateNumSelected(idList[0], 1);
		}
		
		return true;
	}else{
		cbox.disabled = true;
		var delayedSelect = setTimeout("delayToggleSelect('" + caseId + "')", 200);
		
		return false;
	}
}

//select all elements of a certain branch
function selectBranch(path){
	var elemIdString = null;
	var pathIdString = null;
	var cboxArr = document.getElementsByTagName("INPUT");
	
	//iterate through all the checkbox elements present on the page to find the correct ones
	for(var i=0; i<cboxArr.length; i++){
		var id = cboxArr[i].id;
		var curPath = id.substring(0,path.length);
		var post = id.substring(id.lastIndexOf(".")+1, id.length);
		
		//if the element matches the path to select all, select it
		if(post == "cbox" && cboxArr[i].disabled == false && cboxArr[i].checked == false && (id[path.length] == "." || id[path.length] == "|") && curPath == path){
			var caseId = id.substring(0, id.lastIndexOf("."));
			var idList = caseId.split("|~|");
			
			//update the string of selected elements and their paths
			if(elemIdString == null){
				elemIdString = idList[1];
				pathIdString = idList[0];
			}else{
				elemIdString += "," + idList[1];
				pathIdString += "|~|" + idList[0];
			}
			
			//update the number of selected
			updateNumSelected(idList[0], 1);
			
			//check the box and highlight the element
			var branch = document.getElementById(caseId + ".highlight");
			branch.style.backgroundColor = s_color;
			cboxArr[i].checked = true;
		}
	}
	
	//if the select lock is not on, tell the controller what was selected, else wait and try again
	if(!selectLock){
		selectLock = true;
		selectElems(elemIdString, pathIdString);
	}else{
		var delayedSelectBranch = setTimeout("selectElems('" + elemIdString + "','" + pathIdString + "')", 200);
	}
}

//deselect all elements of a certain branch
function deselectBranch(path){
	var elemIdString = null;
	var pathIdString = null;
	var cboxArr = document.getElementsByTagName("INPUT");
	
	for(var i=0; i<cboxArr.length; i++){
		id = cboxArr[i].id;
		curPath = id.substring(0,path.length);
		post = id.substring(id.lastIndexOf(".")+1, id.length);

		if(post == "cbox" && cboxArr[i].disabled == false && cboxArr[i].checked == true && curPath == path && (id[path.length] == "." || id[path.length] == "|")){	
			var caseId = id.substring(0, id.lastIndexOf("."));
			var idList = caseId.split("|~|");
			
			if(elemIdString == null){
				elemIdString = idList[1];
				pathIdString = idList[0];
			}else{
				elemIdString += "," + idList[1];
				pathIdString += "|~|" + idList[0];
			}
			updateNumSelected(idList[0], -1);
			
			var branch = document.getElementById(caseId + ".highlight");
			branch.style.backgroundColor = bg_color;
			cboxArr[i].checked = false;
		}
	}
	
	//if the select lock is not on, tell the controller what was selected, else wait and try again
	if(!selectLock){
		selectLock = true;
		deselectElems(elemIdString, pathIdString);
	}else{
		var delayedSelectBranch = setTimeout("selectElems('" + elemIdString + "','" + pathIdString + "')", 200);
	}
}

//add a changed order to the change order queue in the controller, the order is not actually changed until the user clicks the
//action link in the actions tab
function addChangedOrder(id, value, path){
	//wait for the lock to open before telling the controller
	if(changedOrderLock){
		var delayedAddChangedOrder = setTimeout("addChangedOrder('" + id + "'," + value + ",'" + path + "')", 200);
	}else{
		changedOrderLock = true;
		addChangedOrderApex(id, value, path);
	}
}

//remove a changed order from the change order queue in the controller
function removeChangedOrder(id, path){
	//wait for the lock to open before telling the controller
	if(changedOrderLock){
		var delayedRemoveChangedOrder = setTimeout("removeChangedOrder('" + id + "','" + path + "')", 200);
	}else{
		changedOrderLock = true;
		removeChangedOrderApex(id, path);
	}
}

//an order was changed, verify and notify the controller
function changeOrder(e){
	var source = ie ? e.srcElement : e.target; //choose param for either ie or other browser
	var keyPressed = ie ? e.keyCode : e.which;

	//if not an arrow key, verify changed order, allows user to use arrow key to navigate the text
	if(keyPressed < 37 || keyPressed > 40){
		var val = source.value;
		var id = source.id.substr(0,source.id.length-6);
		var idArr = id.split("|~|");
		
		//parse the text in the order box
		source.value = parseInt(val);
		
		//if it is not a valid integer, remove from changed order queue and highlight the box
		if(isNaN(source.value)){
			source.style.backgroundColor = "#CC0000";
			source.style.color = "#FFFFFF";
			source.value = "";
			removeChangedOrder(idArr[1], idArr[0]);
		//if it is a valid integer, add to changed order queue and highlight the box
		}else{
			source.style.backgroundColor = s_color;
			source.style.color = "#000000";
			addChangedOrder(idArr[1], source.value, idArr[0]);
		}
	}
}

//unlock the locks, called by the oncomplete event of visualforce functions
function unblockSelect(){
	selectLock = false;
}
function unblockLoadBranch(){
	loadBranchLock = false;
}
function unblockSelectBranch(){
	selectBranchLock = false;
}
function unblockLoadDetails(){
	loadDetailsLock = false;
}
function unblockChangedOrder(){
	changedOrderLock = false;
}
function unblockOpenBranch(){
	openBranchLock = false;
}

//status variables needed for autocomplete UI
var acListMOver = false;
var acTFFocused = false;
var acCurSelection = 0;
var acHighlightColr = "rgb(220,220,220)";
var acBaseColr = "rgb(246,246,246)";

//toggles flag indicating the user is currently in the autocomplete field
function acTFFocus(){
	acTFFocused = true;
	toggleACVisibility();
}
//toggles flag indicating the user is currently not in the autocomplete field
function acTFBlur(){
	acTFFocused = false;
	toggleACVisibility();
}
//toggles flag indicating the mouse is over the autocomplete list
function acListOver(){
	acTFFocused = true;
	toggleACVisibility();
}
//toggles flag indicating the mouse is not over the autocomplete list
function acListOut(){
	acTFFocused = false;
	toggleACVisibility();
}

//sets the hierarchy filter and regenerates the tree using the fileter
function setHierarchy(i){
	var hier = document.getElementById("ACRow" + i + ".hierarchy").value;
	regenerateTree(hier);
}

//handles key down events in the autocomplete field
function acKeyDown(e){
	//makes the autocomplete list visible
	var div = document.getElementById("ACList");
	div.style.visibility="visible";

	//get the key that was pressed
	var keyPressed = ie ? e.keyCode : e.which;

	//handle the key press
	switch(keyPressed){ 
		case 13: //if enter, get the desired hierarchy
			if(acCurSelection == 0){
				acHierValue = document.getElementById("AC.tf").value;
				if(acHierValue == "")
					regenerateTree('');
				else
					setHierarchy(1);
			}else{
				setHierarchy(acCurSelection);
			}
			
			acListMOver = false;
			break;
		case 40: //if the down arrow key is pressed, move down on the autocomplete list
			if(acCurSelection < acMatchCount) acSelect(acCurSelection + 1);
			break;
		case 38: //if the up arrow key is pressed, move up on the autocomplete list
			if(acCurSelection > 0) acSelect(acCurSelection - 1);
			break;
	}
}

//handles key up events in the autocomplete field
function acKeyUp(e){
	//get the key that was pressed
	var keyPressed = ie ? e.keyCode : e.which;

	//if it was not an arrow key update, the autocomplete list to show the matches
	if(keyPressed != 40 && keyPressed != 38) loadACMatches(document.getElementById("AC.tf").value);
}

//toggle the visibility of the autocomplete list
function toggleACVisibility(){
	var div = document.getElementById("ACList");

	//if the mouse is not over the autocomplete list and if the user is not in the autocomplete field, hide it, else make it visible
	if(!acListMOver && !acTFFocused)
		div.style.visibility="hidden";
	else
		div.style.visibility="visible";
}

//selects the i-th element in the autocomplete list
function acSelect(i){
	//unhighlight the last selected element if it was not 0, 0 indicates no element is currently selected
	if(acCurSelection != 0){
		var row = document.getElementById("ACRow" + acCurSelection);
		row.style.backgroundColor = acBaseColr;
	}

	//select the i-th element, or do nothing if 0
	acCurSelection = i;
	if(acCurSelection != 0){
		var hier = document.getElementById("ACRow" + i + ".hierarchy").value;
		document.getElementById("AC.tf").value = hier;
		
		var row = document.getElementById("ACRow" + acCurSelection);
		row.style.backgroundColor = acHighlightColr;
	}
}

function blockEnter (field, e) {
	var keyPressed = ie ? e.keyCode : e.which;
	if (keyPressed == 13) {
		var i;
		for (i = 0; i < field.form.elements.length; i++)
			if (field == field.form.elements[i]) break;
		i = (i + 1) % field.form.elements.length;
		field.form.elements[i].focus();
		return false;
	} else {
		return true;
	}
} 

//handler for if a button is pressed in the search box, checks if it is enter, if so perform the search
function searchEnter(e){
	var keyPressed = ie ? e.keyCode : e.which;
	if(keyPressed == 13) searchTree();
}

//perform the search
function searchTree(){
	document.getElementById("searchResults").innerHTML = "Searching...";
	
	var searchTerm = document.getElementById("search.tf").value;
	try{
		var searchPath = document.getElementById("AC.tf").value;
		searchTreeApex(searchTerm, searchPath);
	}catch(e){
		searchTreeApex(searchTerm);
	}
}

//toggles highlighting of search groups when you mouse over or out of it
function searchToggleHighlight(id){
	var hier = document.getElementById("search." + id + ".header");
	var bgColor = ie ? hier.style.backgroundColor : hier.style.backgroundColor.replace(/, /g,",");
	
	if(bgColor != "rgb(220,220,220)")
		hier.style.backgroundColor = "rgb(220,220,220)";
	else
		hier.style.backgroundColor = "";
}

//toggles opening up and closing search groups
function searchToggleSelect(id){
	var results = document.getElementById("search." + id + ".results");
	var twisty = document.getElementById("search." + id + ".twisty");
	if(results.style.display == ""){
		results.style.display = "none";
		twisty.src = "/img/setup_plus.gif";
	}else{
		results.style.display = "";
		twisty.src = "/img/setup_minus.gif";
	}
}

//when the user leaves the TC library, write a cookie to memorize their last state
function generateCookie(){
	var expDate = new Date();
	expDate.setDate(expDate.getDate()+7);
	var curhier = document.getElementById("AC.tf").value;
	
	document.cookie = "branches=" + this.openBranches + ";expires=" + expDate.toGMTString();
	document.cookie = "hierarchy=" + (curhier == null ? "|null|" : curhier) + ";expires=" + expDate.toGMTString();
}
