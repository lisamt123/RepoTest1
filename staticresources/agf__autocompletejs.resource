AutoComplete = function(input,suggestions,lookupto,clearfunction,objectn)
{

//Global Variables

var IS_IE = true;
var timer;
var bgColor = "#b0c4de";
var searchColor = "#FFFFCC";
var bgColorRGB = "rgb(176,196,222)";
var searchString = "Searching...";
var searchID = suggestions.id+"tmpsearch";
var clearFunction = clearfunction;
var noResultsID = suggestions.id+"N_R";

//Attach Event Handlers

		if(input.attachEvent){
			input.attachEvent("onkeyup", handleKeyUp);
			input.attachEvent("onkeydown", handleArrows);
			input.attachEvent("onblur",handleBlur);
			input.attachEvent("onfocus",handleFocus);
			suggestions.attachEvent("onmouseover",initializeMouseOver);
		}else{
			IS_IE = false;
			bgColor= "#a3ceff";
			bgColorRGB= "rgb(163, 206, 255)";
			input.onkeyup=handleKeyUp;
			input.onkeydown=handleArrows;
			input.onblur=handleBlur; 
			input.onfocus=handleFocus;
			suggestions.onmouseover=initializeMouseOver;
		}

	
	
	function hideAutoComplete(){
	
			suggestions.innerHTML = "";
			suggestions.style.display = "none";
	
	}
       
	function getCursor()
	{
		if (suggestions.innerHTML.length == 0){
			return -1;
		}else{
	
			if(suggestions.childNodes[0].id == searchID || suggestions.childNodes[0].id == noResultsID)
				return -1;
			
			for (var i = 0; i < suggestions.childNodes.length; i++){
	
				if (suggestions.childNodes[i].style.backgroundColor == bgColor || suggestions.childNodes[i].style.backgroundColor == bgColorRGB){
	
					return i;
				}
			}
			return suggestions.childNodes.length;
		
		}
	}
	
	
	function initializeMouseOver(event)
	{

				if(suggestions.childNodes.length > 0){
				
					if(suggestions.childNodes[0].id == searchID || suggestions.childNodes[0].id == noResultsID){
						return;
					}else{
					
						if(IS_IE){
						
							for (var i = 0; i < suggestions.childNodes.length; i++){
								
									suggestions.childNodes[i].attachEvent("onmouseover",handleMouseOver);
									suggestions.childNodes[i].attachEvent("onmouseout",handleMouseOut);
									suggestions.childNodes[i].attachEvent("onmousedown",handleMouseClick);		
							}
							
						}else{

							for (var i = 0; i < suggestions.childNodes.length; i++){
													
									suggestions.childNodes[i].onmouseover = handleMouseOver;
									suggestions.childNodes[i].onmouseout = handleMouseOut;
									suggestions.childNodes[i].onmousedown = handleMouseClick;		
							}
												
						}	
					}
				}
	}
	
	
	function handleMouseClick(event){

		if(IS_IE){
		
			if(event.srcElement.id)
				input.value = event.srcElement.id;
			else
				input.value = event.srcElement.innerText;		
		}else{
			if(event.target.id)
				input.value =  event.target.id;			
			else
				input.value =  event.target.textContent;

		}
 
	}
	
	function handleMouseOver(event){

		if(IS_IE){
			if(event.srcElement.style.backgroundColor != bgColor)
				event.srcElement.style.backgroundColor = searchColor;		
		}else{
			if(event.target.style.backgroundColor != bgColorRGB)
				event.target.style.backgroundColor = searchColor;
		}
	}
	
	function handleMouseOut(event){

		if(IS_IE){
			if(event.srcElement.style.backgroundColor != bgColor)
				event.srcElement.style.backgroundColor = "";		
		}else{
			if(event.target.style.backgroundColor != bgColorRGB)	
				event.target.style.backgroundColor = "";
		}
	}
	
	function handleKeyUp(event){
	
		
		//if key is not an arrow or enter
		if (event.keyCode != 40 && event.keyCode != 38 && event.keyCode != 13 && event.keyCode != 37 && event.keyCode != 39 && event.keyCode != 27)
		{
		              
		    if(timer!=null){clearTimeout(timer);timer=null;}
		                             	 
				if (input.value.length == 0){
					hideAutoComplete();
				}else{ 		 
	               	 timer = setTimeout(function(){window[lookupto](input.value,objectn);displayStatus();},350);
	            }
		} 
		
	}

	function displayStatus(){
	
	               	suggestions.innerHTML='';
                    suggestions.style.display='';
                    var myElement = document.createElement('div');
                    myElement.id = searchID;
                    myElement.style.backgroundColor=searchColor;
                    var textNode = document.createTextNode(searchString);
                    myElement.appendChild(textNode);
                    suggestions.appendChild(myElement);
	
	}
	
	function handleArrows(event){
		
		if (input.value.length == 0 || event.keyCode == 27){
			//make sure autocomplete has no values
			hideAutoComplete();
			return;

		}
		
	try{
	
		var cursor = getCursor();
				
		if (event.keyCode == 13 || event.keyCode == 9){
			

			if (cursor != -1 && cursor < suggestions.childNodes.length)
			{
				
				if (IS_IE){
					if(suggestions.childNodes[cursor].id)
						input.value = suggestions.childNodes[cursor].id;
					else
						input.value = suggestions.childNodes[cursor].innerText;
				}else{
					if(suggestions.childNodes[cursor].id)
						input.value = suggestions.childNodes[cursor].id;
					else
						input.value = suggestions.childNodes[cursor].textContent;
				}
				hideAutoComplete();
			}
			//save recipient input on enter if the input text is populated 
			submitIfRecipientInputPopulated();
				
			
			
			
		
		}else if(event.keyCode == 40 || event.keyCode == 38){
		
		
			if (cursor != -1){
		
				if (event.keyCode == 40)
				{
					if (cursor == suggestions.childNodes.length){
						suggestions.childNodes[0].style.backgroundColor = bgColor;
					}else if (cursor < suggestions.childNodes.length - 1){
						suggestions.childNodes[cursor].style.backgroundColor = "";
						suggestions.childNodes[cursor + 1].style.backgroundColor = bgColor;
					}
					

				}else{
					if (cursor > 0){
						suggestions.childNodes[cursor].style.backgroundColor = "";
						suggestions.childNodes[cursor - 1].style.backgroundColor = bgColor;
					
					}else{
						hideAutoComplete();
					}
				}
			}
		}
		

		
	}catch(e){}
	
	}
	
	function getAssignmentEl() {
		var assignmentEl = document.getElementById('pageEdit:formEdit:assignmentValue');
		return assignmentEl;
	}
	
	function getStdRecipEl() {
		var stdRecipEl = document.getElementById('pageEdit:formEdit:pageBlockEdit:workEditNotifier:ADM_NotifierComponent:pageBlockSectionNotifications:pageBlockSectionItemEmailAssignees:stdRecipients');
		return stdRecipEl;
	}
	
	function submitIfRecipientInputPopulated() {		
		//have to hard code IDs because {!$Component.*} style does not work inside static resource and can't be passed as var as this code is executed by 3rd party event handler
		var idOnWorkEditBug = 'pageEdit:formEdit:pageBlockEdit:workEditNotifier:ADM_NotifierComponent:pageBlockSectionNotifications:pageBlockSectionItemRecipientInput:recipientInput:autoCompleteComp:autoComp';
		var idOnWorkEditUserStory = 'pageEdit:formEdit:pageBlockEdit:workEditNotifier:ADM_NotifierComponent:pageBlockSectionNotifications:pageBlockSectionItemRecipientInput:recipientInput:autoComp';
		var idOnWorkEditInvestigation = 'pageEdit:formEdit:pageBlockEdit:workEditNotifier:ADM_NotifierComponent:pageBlockSectionNotifications:pageBlockSectionItemRecipientInput:recipientInput:autoComp';
		
		if( 
			((document.getElementById(idOnWorkEditBug) != null) && (document.getElementById(idOnWorkEditBug).value != '')) ||
			((document.getElementById(idOnWorkEditUserStory) != null) && (document.getElementById(idOnWorkEditUserStory).value != '')) ||
			((document.getElementById(idOnWorkEditInvestigation) != null) && (document.getElementById(idOnWorkEditInvestigation).value != ''))		
		  ) {
			
			document.getElementById('addRecipientButtonClientSide').click();
		} 
	
	}
	
	
	function handleBlur()
	{		
		hideAutoComplete();
		if(timer!=null){window[clearFunction]();clearTimeout(timer);timer=null;}else{window[clearFunction]();}		
		if(isWorkInput()) {
			updateStandardRecipients(input.value, getAssignmentEl().value);
		}
	}
	
	function handleFocus(){
		hideAutoComplete();
		
		if(isWorkInput()) {
			copyValues(input, getAssignmentEl());
		}	
	}
	
	function isWorkInput() { 
		var assigneeEls = new Array();
		var isWorkInput = false;
	        	
		assigneeEls.push('pageEdit:formEdit:pageBlockEdit:assignments:pageBlockSectionItemAssignee:aField:autoCompleteComp:autoComp');        	
		assigneeEls.push('pageEdit:formEdit:pageBlockEdit:assignments:pageBlockSectionItemQA:qaField:autoCompleteComp:autoComp');        	
		assigneeEls.push('pageEdit:formEdit:pageBlockEdit:assignments:pageBlockSectionItemPO:poField:autoCompleteComp:autoComp');        	
		assigneeEls.push('pageEdit:formEdit:pageBlockEdit:assignments:pageBlockSectionItemUE:ueField:autoCompleteComp:autoComp');        	
		assigneeEls.push('pageEdit:formEdit:pageBlockEdit:assignments:pageBlockSectionItemTW:twField:autoCompleteComp:autoComp');
		assigneeEls.push('pageEdit:formEdit:pageBlockEdit:assignments:pageBlockSectionItemSTE:steField:autoCompleteComp:autoComp');
		assigneeEls.push('pageEdit:formEdit:pageBlockEdit:assignments:pageBlockSectionItemSeniorManagementPOC:smField:autoCompleteComp:autoComp');
		assigneeEls.push('pageEdit:formEdit:pageBlockEdit:assignments:pageBlockSectionItemCsContact:csField:autoCompleteComp:autoComp');
		
		for(var i = 0; i < assigneeEls.length; i++) {
		
			if(input.id.indexOf(assigneeEls[i]) > -1) {
				isWorkInput = true;
				break;
			}
		}			
		
		
		return isWorkInput;
	}
}
