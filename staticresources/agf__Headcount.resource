
function processHeadcountResults(displayLocation, hcList) {
    var updatedHC = "<table class='list'><tr class='headerRow'><th>Headcount #</th><th>Employee Name</th><th>New Manager</th></tr>";
    for(var i = 0; i < hcList.length; i++) {
        updatedHC = updatedHC + "<tr><td>" + hcList[i].Name + "</td>"
        
        try {
            //some browsers will allow you to test for undefined others will throw an exception
            if(typeof hcList[i].Headcount_Name__r.Name === 'undefined') {
                updatedHC = updatedHC + "<td>&nbsp;</td>";
            } else {
                updatedHC = updatedHC + "<td>" + hcList[i].Headcount_Name__r.Name + "</td>"
            }
        } catch(err) {
             updatedHC = updatedHC + "<td>&nbsp; </td>";
        }
        
        try {
            //some browsers will allow you to test for undefined others will throw an exception
            if(typeof hcList[i].Hiring_Manager__r.Name === 'undefined') {
                updatedHC = updatedHC + "<td>&nbsp;</td>";
            } else {
                updatedHC = updatedHC + "<td>" + hcList[i].Hiring_Manager__r.Name + "</td>"
            }
        } catch(err) {
             updatedHC = updatedHC + "<td>&nbsp; </td>";
        }
      
        
         updatedHC = updatedHC + "</tr>"; 
    }
    $('#' + displayLocation).html(updatedHC);


}

function showHeadcountError(errorMessage) {
    $("#headcountErrorMessage").text("Error: " + errorMessage);
    $("#headcountErrorMessageWrapper").show();

}


function showHeadcountInfo(infoMessage) {
    $("#headcountInfoMessage").text(infoMessage);
    $("#headcountInfoMessageWrapper").show();

}

function resetHeadcountError() {
    $("#headcountErrorMessage").text("&nbsp;");
    $("#headcountErrorMessageWrapper").hide();

}

function resetHeadcountInfo() {
    $("#headcountInfoMessage").text("&nbsp;");
    $("#headcountInfoMessageWrapper").hide();

}

function parseHeadcountIDs(hcList) {
     var idlist = '';
     for(var i = 0; i < hcList.length; i++) {
         idlist = idlist +  hcList[i].Id + ',';
     }
    return idlist;

}

