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

function dropCall(leadId)
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
	var temp = "/00T/e?title=Call&who_id="+leadId+"&followup=0&tsk5=Call&retURL=%2F"+leadId+"&tsk6="+summary+"&save=1";
	window.parent.location.href=temp;
	}
}

