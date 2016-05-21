function call(number)
{

var event = phone.StartAltiCtrl();

if(!event)
	alert("Connection to MaxAgent unsucessful");
event = phone.MakeCall("81"+number);
if(event == 1)
	alert("Unknown error code "+event);
if(event == 2)
	alert("Disconnect MaxAgent "+event);
if(event == 999)
	alert("Exception Occured "+event);
}

function dropCall(ContactId,ContactAccountName)
{
var event = phone.StartAltiCtrl();

if(!event)
	alert("Connection to MaxAgent unsucessful");

var summary = document.getElementById("CallLog").value;
event = phone.DropCall();

if(summary.length === 0)
alert("Please Enter Call Notes");

else	{


	if(event != 0)
		alert("Unknown error");	

	alert("Call Notes Entered");
	var temp = "/00T/e?title=Call&who_id="+ContactId+"&followup=0&tsk6="+summary+"&tsk5=Call&retURL=/"+ContactId+"&tsk3_mlktp=001&tsk3="+ContactAccountName+"&save=1";
	window.parent.location.href=temp;
	}
}

