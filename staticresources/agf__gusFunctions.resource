<script language="javascript" type="text/javascript">

Req = {

    url : "https://na1-blitz02.soma.salesforce.com/",
	mimeType : "text/plain",
    requestHeaders : {},
    method : "GET",
    async : false,
    onFailure : function(resp, req) {alert(resp)},
    onSuccess : function(resp, req) {}
};

sforce.connection.remoteFunction(Req);
var logingResult = sforce.connection.login("gus@gus.com", "123456");
var TASKS = null;
var WORKS = null;

var GUS = {
    InitFilter : false,
    SobjectWork : null,
    SobjectTask : null,
    LastHeader : null,
    LastView : null,
    GusObject : 'Task',

    setupPage : function ()
    {
        TASKS = new Tasks();
        WORKS = new Works();
        GUSQuery.getLists('');
        GUSDisplay.renderLists('');

        GUSSearch.doSearch("upgrading");
        /*GUSFilters.initFilterOptions();
        GUSDisplay.fillDetailsDiv("Work",WORKS.List[0].Id, null);*/
    }
};

var GUSUtils = 
{
    isPresent : function(array, value)
    {
        for(var i=0; i != array.length; i++)
        {
            if(array[i] == value )
            return true;
        }
        return false;
    },

    Query : function (querystring)
    {
        /*GUSUtils.debug("<br/>QUERY:" + querystring);*/
        var result = null;
        try
        {
            result = sforce.connection.query(querystring);
        }
        catch(error)
        {
            GUSUtils.debug(error);
        }
        return result;
    },
    
    Search : function(searchquery)
    {
        GUSUtils.debug("<br/>QUERY:" + searchquery);
        var result = null;
        try
        {
            result = sforce.connection.search(searchquery);
        }
            catch(error)
        {
            GUSUtils.debug(error);
        }
        return result;
    },
    
    returnCall : function (result)
    {
        if (result[0].getBoolean("success")) {
            GUSUtils.debug("Success!");
        }
        else
        {
            alert(result[0]);
        }
    },
    
    User : null,
UserId : null,
getUserWorks : function()
{
USER = sforce.connection.getUserInfo();
USERID = USER.userId;
},

debug : function (message)
{
document.getElementById('divDebug').innerHTML += message ;
},

Write : function (control, message)
{
document.getElementById(control).innerHTML = message;
},

removeDuplicates: function(duparray)
{
duparray.sort();
var uniarray = new Array();
var j = 1;
uniarray[0] = duparray[0];
for (var i = 0; i != duparray.length; i++)
{
if(uniarray[j-1] != duparray[i])
uniarray[j++] = duparray[i];
}
uniarray.pop();
return(uniarray);
}

};

function Tasks()
{
this.List = new Array();

this.Headers = new Array();
this.Headers[0] = new GUSColumns.Column('Task','', 'Name', 0 , true);
this.Headers[1] = new GUSColumns.Column('Hours', '', 'Hours_Remaining__c', 3 , true);
this.Headers[2] = new GUSColumns.Column('Task Status', '', 'Status__c', 4 , true);
this.Headers[3] = new GUSColumns.Column('TaskId','', 'Id', 1 , false);
this.Headers[4] = new GUSColumns.Column('Assignee', 'Assignee__r', 'Name', 2 , false);
this.Headers[5] = new GUSColumns.Column('Type', 'RecordType', 'Name', 5 , false);
this.Headers[6] = new GUSColumns.Column('Created By', 'CreatedBy', 'Name', 6 , false);
this.Headers[7] = new GUSColumns.Column('TaskParentId', 'Task_Parent__r', 'Id', 7 , false);

this.SelectClause = '';
var putComma = false;

for(var i = 0; i!= this.Headers.length; i++)
{
if(true)
{
if (putComma == true)
{
this.SelectClause += ' , ' ;
putComma = false
}
this.SelectClause += this.Headers[i].APIName ;
putComma = true;
}
}
this.Query = 'Select ' + this.SelectClause + ' From Work_Task__c';

this.fillList = function (queryresult)
{
this.List = queryresult.records;
};

this.writeData = function(record)
{
var tdElem = '';
var fillparams = '';
tdElem += '<td><input type="checkbox" name="checkboxAction" value="' + record.Id + '" /></td>';

for (var i = 0; i != this.Headers.length; i++)
{
if(this.Headers[i].visible == true)
{
var sobject = null;
if(this.Headers[i].reference != '')
{
sobject = record.get(this.Headers[i].reference);
if (sobject == null)
{
tdElem += '<td></td>';
continue;
}
}
else {sobject = record};
if(sobject.get(this.Headers[i].name) == null)
tdElem += '<td></td>';
else if(this.Headers[i].APIName == 'Name')
{
fillparams = 'GUSDisplay.fillDetailsDiv("Task","' + record.Id + '","' + record.Task_Parent__r.Id + '")';
tdElem += '<td><u><span style="cursor: pointer" onclick=' + fillparams + '>' + record.Name + '</span></u>';
}
else if(this.Headers[i].APIName == 'Hours_Remaining__c')
tdElem += '<td><div class="normal" onclick="GUSInline.handleClick(this);" onmouseover="GUSInline.hoverEditable(this);" onmouseout="GUSInline.resetStyle(this);"><span name="Hours_Remaining__c" class="editable">' + record.Hours_Remaining__c + '</span><input class="hidden" type="text" size="3" value="' + record.Hours_Remaining__c + '" id="' + record.Id + '.Hours_Remaining__c" onblur="GUSInline.formSubmit(this);" /></div></td>';
else tdElem += '<td>' + sobject.get(this.Headers[i].name) + '</td>';
}
}
return tdElem;
};

this.writeHeaders = function()
{
var thElem = '<th><input type="checkbox" onclick="GUSMassUpdate.selectAllCheckBox(this)" ></th>';
for(var i = 0; i!= this.Headers.length; i++)
{
if(this.Headers[i].visible == false)
continue;
var sortbyparams = 'GUSDisplay.sortbyHeader(\"';
sortbyparams += this.Headers[i].APIName;
sortbyparams += '\")';

thElem += '<th>';
thElem += '<span style="cursor: pointer" onclick=' + sortbyparams + '>' + this.Headers[i].label + '</span>';
thElem += '<span id="spanHeader' + this.Headers[i].APIName + '" />';
thElem += '</th>'
}
return thElem;
};

this.getListElements = function (id)
{
var temp = new Array();
for(var i = 0; i!= this.List.length; i++)
{
if(this.List[i].Task_Parent__r.Id == id)
{
temp.push(this.List[i]);
}
}
return temp;
};
}

function Works()
{
this.List = new Array();

this.Headers = new Array();
this.Headers[0] = new GUSColumns.Column('WorkId','', 'Id', 0 , false);
this.Headers[1] = new GUSColumns.Column('Bug / User Story ','', 'Name', 1 , true);
this.Headers[2] = new GUSColumns.Column('Type', 'RecordType', 'Name', 3 , true);
this.Headers[3] = new GUSColumns.Column('Status', '', 'Status__c', 2 , true);
this.Headers[4] = new GUSColumns.Column('Priority', '' , 'Priority__c', 11 , true);
this.Headers[5] = new GUSColumns.Column('Major Func Area', '', 'Major_Func_Area__c', 4 , false);
this.Headers[6] = new GUSColumns.Column('Scrum Team', 'Scrum_Team__r', 'Name', 5 , false);
this.Headers[7] = new GUSColumns.Column('Sprint', 'Sprint__r' , 'Name', 6 , false);
this.Headers[8] = new GUSColumns.Column('Release', 'Release__r' , 'Name', 7 , false);
this.Headers[9] = new GUSColumns.Column('Created By', 'CreatedBy', 'Name', 8 , false);
this.Headers[10] = new GUSColumns.Column('Developer', 'Developer__r' , 'Name', 9 , false);
this.Headers[11] = new GUSColumns.Column('QA Engineer', 'QA_Engineer__r' , 'Name', 10 , false);
this.Headers[12] = new GUSColumns.Column('Product Owner', 'Product_Owner__r' , 'Name', 11 , false);

this.SelectClause = '';
var putComma = false;

for(var i = 0; i!= this.Headers.length; i++)
{
if(true)
{
if (putComma == true)
{
this.SelectClause += ' , ' ;
putComma = false;
}
this.SelectClause += this.Headers[i].APIName ;
putComma = true;
}
}
this.Query = 'Select ' + this.SelectClause + ' From Work__c';

this.fillList = function (queryresult)
{
this.List = queryresult.records;
};

this.writeData = function(record)
{
var tdElem = '';
var sobject = null;

for (var i = 0; i != this.Headers.length; i++)
{
if(this.Headers[i].visible == true)
{
sobject = null;
if(this.Headers[i].reference != '')
{
sobject = record.get(this.Headers[i].reference);
if (sobject == null)
{
tdElem += '<td></td>';
continue;
}
}
else
sobject = record;

if(sobject.get(this.Headers[i].name) == null)
tdElem += '<td></td>';
else if(this.Headers[i].APIName == 'Name')
{
fillworkparams = 'GUSDisplay.fillDetailsDiv("Work","' + record.Id + '")';
tdElem += '<td><u><span style="cursor: pointer" onclick=' + fillworkparams + '>' + record.Name + '</span></u>';
}
else if (this.Headers[i].APIName == 'RecordType.Name')
{
if(sobject.Name == 'Detailed User Story')
tdElem += '<td>' + '<img src="/img/icon/custom51_100/chalkboard24.png" alt="User Story">' + '</td>';
else if (sobject.Name == 'Bug')
tdElem += '<td>' + '<img src="/img/icon/insect16.png" alt="Bug" >' + '</td>';
else tdElem += '<td>' + sobject.Name + '</td>';
}
else tdElem += '<td>' + sobject.get(this.Headers[i].name) + '</td>';
}
}
return tdElem;
};

this.writeHeaders = function()
{
var thElem = '';
var sortbyparams = '';
for(var i = 0; i!= this.Headers.length; i++)
{
if(this.Headers[i].visible == false)
continue;
sortbyparams = 'GUSDisplay.sortbyHeader("';
sortbyparams += 'Task_Parent__r.' + this.Headers[i].APIName;
sortbyparams += '")';

thElem += '<th>';
thElem += '<span style="cursor: pointer" onclick=' + sortbyparams + '>' + this.Headers[i].label + '</span>';
thElem += '<span id="spanHeaderTask_Parent__r.' + this.Headers[i].APIName + '" />';
thElem += '</th>'
}
return thElem;
};

this.getListElement = function (id)
{
for(var i = 0; i!= this.List.length; i++)
{
if(this.List[i].Id == id)
return this.List[i];
}
};
}

var GUSFilters =
{
fillOptionsList : function (OptionListId, queryresult)
{
if(queryresult.size == 0)
return;

for (var j = 0; j != queryresult.records.length; j++)
{
record = queryresult.records[j];
GUSControls.addToOptionList(OptionListId, record.Id, record.Name);
}
},

initFilterOptions : function ()
{
var field = '';
GUS.SobjectWork = sforce.connection.describeSObject("Work__c");
GUS.SobjectTask = sforce.connection.describeSObject("Work_Task__c");
GUSFilters.selectFilterFieldTask('Status__c', 1);
GUSFilters.selectFilterFieldTask('RecordTypeId', 2);
GUSFilters.selectFilterFieldTask('Assignee__c', 3);

var result = GUS.SobjectWork;
for (var i=0; i<result.fields.length; i++)
{
field = result.fields[i];
if((field.type == 'picklist' || field.type == 'reference') && field.custom == 'true' )
{
GUSControls.addToOptionList('listFilterHeader1', field.name, field.label);
GUSControls.addToOptionList('listFilterHeader2', field.name, field.label);
GUSControls.addToOptionList('listFilterHeader3', field.name, field.label);
}
}
GUSControls.addToOptionList('listFilterHeader1', 'RecordType', "Record Type");
GUSControls.addToOptionList('listFilterHeader2', 'RecordType', "Record Type");
GUSControls.addToOptionList('listFilterHeader3', 'RecordType', "Record Type");
GUS.InitFilter = true;
},

getSelectedFilters : function ()
{
var selected = null;
var filter = '';
children = document.getElementById('divFilters').getElementsByTagName('select');
for (var i = 0; i != children.length; i++)
{
if(children[i].id == 'listFilterHeader1' || children[i].id == 'listFilterHeader2' || children[i].id == 'listFilterHeader3')
continue;
selected = GUSFilters.getSelected(children[i].id);

filter += GUSFilters.createFilter(children[i].name,selected);
}
GUSFilters.parseFilter(filter);
GUSQuery.getLists('');
GUSDisplay.renderLists('');
GUSControls.collapse("divFilters",null);
},

clearSelectedFilters : function()
{
GUSControls.deselectOptions('listFilter1');
GUSControls.deselectOptions('listFilter2');
GUSControls.deselectOptions('listFilter3');
GUSControls.deselectOptions('listFilterColumn1');
GUSControls.deselectOptions('listFilterColumn2');
GUSControls.deselectOptions('listFilterColumn3');
},

createFilter : function (name, values)
{
var filter = ':' + name + '=';
for (var i = 0; i != values.length; i++)
{
filter += ',' + values[i] ;
}
return filter;
},

showFilters : function ()
{
if(!GUS.InitFilter)
GUSFilters.initFilterOptions();
GUSControls.collapse('divFilters',null);
},

getSelected : function (listId)
{
list = document.getElementById(listId);
selecteditems = new Array();
for (var i = 0; i < list.options.length; i++)
if (list.options[ i ].selected)
selecteditems.push(list.options[ i ].value);
return selecteditems;
},

parseFilter : function (filter)
{
var args = filter.split(':');
var clause = new Array();
var subclause = new Array();

var whereclause = '';
var andFlag = false;
var orFlag = false;
var temp = '';

for (var i = 1; i != args.length; i++)
{
clause = args[i].split('=');
if(clause[1] != '')
{
if(andFlag)
{
whereclause += GUSQuery.SOQLAnd;
andFlag = false;
}
temp = '';
subclause = clause[1].split(',');
for (var j = 1; j != subclause.length; j++)
{
if(orFlag)
{
temp += GUSQuery.SOQLOr;
orFlag = false;
}
if(subclause[j+1] != null)
orFlag = true;
temp += clause[0] + "='" + subclause[j] + "'";
}
if(temp != null)
{
whereclause += '(' + temp + ')';
andFlag = true;
}
else andFlag= false;

}

}

GUSQuery.LastFilter = GUSQuery.StartWhereClause + whereclause ;
},

selectFilterField : function (listColumn, target)
{
var column = listColumn.options[listColumn.selectedIndex].value;
if(column == 'Search')
{
document.getElementById('spanFilterColumn' + target).style.display = 'none';
GUSControls.clearOptions('listFilterColumn' + target);
return;
}

var result = GUS.SobjectWork;
if(column == "RecordType")
{
GUSControls.clearOptions('listFilterColumn' + target);
querystring = "Select Id, Name from RecordType Where Id in ('012T000000009A4AAA','012T000000009A5AAA','012T000000009A6AAE', '012T000000009A7AAE') Order By Name";
queryResult = GUSUtils.Query(querystring);
GUSFilters.fillOptionsList('listFilterColumn'+ target, queryResult);
document.getElementById('listFilterColumn' + target).name = 'Task_Parent__r.RecordType.Id';
}
else for (var i=0; i<result.fields.length; i++)
{
var field = result.fields[i];
if(column == field.name)
{
if (field.type == 'reference')
{
GUSControls.clearOptions('listFilterColumn' + target);
querystring = 'Select Id, Name from ' + field.referenceTo +' Order By Name';
queryResult = GUSUtils.Query(querystring);
GUSFilters.fillOptionsList('listFilterColumn'+ target, queryResult);
document.getElementById('listFilterColumn' + target).name = 'Task_Parent__r.' + field.relationshipName + '.Id';
break;
}
if (field.type == 'picklist')
{
GUSControls.clearOptions('listFilterColumn' + target);
for (var i = 0 ; i != field.picklistValues.length; i++)
GUSControls.addToOptionList('listFilterColumn'+ target, field.picklistValues[i].value,field.picklistValues[i].label);
document.getElementById('listFilterColumn'+ target).name = 'Task_Parent__r.' + field.name;
break;
}
}
}
document.getElementById('spanFilterColumn' + target).style.display = '';
},

selectFilterFieldTask : function (column, target)
{
var result = GUS.SobjectTask;
if(column == "RecordTypeId")
{
GUSControls.clearOptions('listFilter' + target);
querystring = "Select Id, Name from RecordType Where Id in ('012T000000009A8AAA','012T000000009A9AAA', '012T000000009AAAAE') Order By Name";
queryResult = GUSUtils.Query(querystring);
GUSFilters.fillOptionsList('listFilter'+ target, queryResult);
document.getElementById('listFilter' + target).name = 'RecordType.Id';
}
else
{
for (var i=0; i<result.fields.length; i++)
{
var field = result.fields[i];
if(column == field.name)
{
if (field.type == 'reference')
{
GUSControls.clearOptions('listFilter' + target);
querystring = "Select Id, Name from " + field.referenceTo +" Order By Name";
queryResult = GUSUtils.Query(querystring);
GUSFilters.fillOptionsList('listFilter'+ target, queryResult);
document.getElementById('listFilter' + target).name = field.relationshipName + '.Id';
break;
}
if (field.type == 'picklist')
{
GUSControls.clearOptions('listFilterColumn' + target);
for (var i = 0 ; i != field.picklistValues.length; i++)
GUSControls.addToOptionList('listFilter'+ target, field.picklistValues[i].value,field.picklistValues[i].label);
document.getElementById('listFilter'+ target).name = field.name;
break;
}
}
}
}
}
};

var GUSDisplay =
{
renderLists : function (view)
{
var divHTML = '';
if(TASKS.List.length == 0)
{
GUSUtils.Write("divCustomWorkLayout","There are no items for the current selection.");
return;
}
if(GUS.LastView == null)
{ GUS.LastView = 'Work'; }

if(GUS.LastView != 'Work')
{
divHTML = '<table>';
divHTML += '<tr>';
divHTML += TASKS.writeHeaders() + WORKS.writeHeaders();
divHTML += '</tr>';

for(var i = 0; i != TASKS.List.length; i++)
{
divHTML += '<tr>';
divHTML += TASKS.writeData(TASKS.List[i]);
var work = WORKS.getListElement(TASKS.List[i].Task_Parent__r.Id);
divHTML += WORKS.writeData(work);
divHTML += '</tr>';
}
divHTML += '</table>';
}
else if (GUS.LastView == 'Work')
{
divHTML = '<table>';
divHTML += '<tr><th></th>';
divHTML += WORKS.writeHeaders();
divHTML += '</tr>';

for(var i = 0; i != WORKS.List.length; i++)
{
var divId = 'divList' + i;
var imgId = 'imgList' + i;
divHTML += '<tr>';
divHTML += '<td>';
divHTML += '<img id="' + imgId + '" src="/img/setup_plus.gif" onclick=';
divHTML += 'GUSDisplay.fillHierarchy(this,"' + WORKS.List[i].Id + '","Work","' + divId + '") />';
divHTML += '</td>';
divHTML += WORKS.writeData(WORKS.List[i]);
divHTML += '</tr>';
divHTML += '<tr>';
divHTML += '<td colspan="6" style="border-bottom:#000000">';
divHTML += '<div id ="' + divId + '" style="display:none"></div>';
divHTML += '</td>';
divHTML += '</tr>';
}
divHTML += '</table>';
}
GUSUtils.Write('divCustomWorkLayout', divHTML);
GUSDisplay.putSortArrow();
},

putSortArrow : function ()
{
if(GUS.LastHeader != null)
document.getElementById("spanHeader" + GUS.LastHeader).innerHTML = '<img src="' + GUSQuery.SortImg + '" />';
},

fillHierarchy : function (imgobject, id, view, divid)
{
var divHTML = '';
if(view == 'Work')
{
var tasks = TASKS.getListElements(id);
divHTML += '<br/><table>';
divHTML += '<tr>';

divHTML += TASKS.writeHeaders();
divHTML += '</tr>';
for(var i = 0; i!=tasks.length; i++)
{
divHTML += '<tr>';
divHTML += TASKS.writeData(tasks[i]);;
divHTML += '</tr>';
}
divHTML += '</table><br/>';
}
GUSUtils.Write(divid, divHTML);
GUSControls.collapse(divid,imgobject);
},

fillDetailsDiv : function (gustype,id, idparent)
{
var FrameHeight = 900;
var detaildiv = document.getElementById('divDetails');
var divhtml='';/*
if(id == null && idparent == null)
{
if(gustype == 'Task')
divhtml = '<iframe width="100%" scrolling="yes" height="' + FrameHeight +'" frameborder="no" title="mainFrame" src="/setup/ui/recordtypeselect.jsp?ent=Task&retURL=%2F'+WORKS.List[0].Id +'%3Fisdtp%3Dmn%26isdtp%3Dmn%26retURL%3D%2Fsetup%2Fui%2Frecordtypeselect.jsp%3Fent%3DTask%26retURL%3D%252FT00000000001iZa%253Fisdtp%253Dmn%2526retURL%253D%252Fui%252Fdesktop%252FDesktopMainDefaultPage%253Fisdtp%253Dmn%26save_new_url%3D%252F00T%252Fe%253FretURL%253D%25252FT00000000001iZa%25253Fisdtp%25253Dmn%252526retURL%25253D%25252Fui%25252Fdesktop%25252FDesktopMainDefaultPage%25253Fisdtp%25253Dmn&save_new_url=%2F00T%2Fe%3FretURL%3D%252FT00000000001iZi%253Fisdtp%253Dmn%2526isdtp%253Dmn%2526retURL%253D%252Fsetup%252Fui%252Frecordtypeselect.jsp%253Fent%253DTask%2526retURL%253D%25252FT00000000001iZa%25253Fisdtp%25253Dmn%252526retURL%25253D%25252Fui%25252Fdesktop%25252FDesktopMainDefaultPage%25253Fisdtp%25253Dmn%2526save_new_url%253D%25252F00T%25252Fe%25253FretURL%25253D%2525252FT00000000001iZa%2525253Fisdtp%2525253Dmn%25252526retURL%2525253D%2525252Fui%2525252Fdesktop%2525252FDesktopMainDefaultPage%2525253Fisdtp%2525253Dmn&isdtp=mn" name="mainFrame" marginwidth="2" marginheight="2" id="mainFrameWork" />';
else
divhtml = '<iframe width="100%" scrolling="yes" height="' + FrameHeight +'" frameborder="no" title="mainFrame" src="/setup/ui/recordtypeselect.jsp?ent=01IT00000008bqy&retURL=%2F'+WORKS.List[0].Id +'%3Fisdtp%3Dmn%26isdtp%3Dmn%26retURL%3D%2Fsetup%2Fui%2Frecordtypeselect.jsp%3Fent%3DTask%26retURL%3D%252FT00000000001iZa%253Fisdtp%253Dmn%2526retURL%253D%252Fui%252Fdesktop%252FDesktopMainDefaultPage%253Fisdtp%253Dmn%26save_new_url%3D%252F00T%252Fe%253FretURL%253D%25252FT00000000001iZa%25253Fisdtp%25253Dmn%252526retURL%25253D%25252Fui%25252Fdesktop%25252FDesktopMainDefaultPage%25253Fisdtp%25253Dmn&save_new_url=%2Fa07%2Fe%3FretURL%3D%252FT00000000001iZi%253Fisdtp%253Dmn%2526isdtp%253Dmn%2526retURL%253D%252Fsetup%252Fui%252Frecordtypeselect.jsp%253Fent%253DTask%2526retURL%253D%25252FT00000000001iZa%25253Fisdtp%25253Dmn%252526retURL%25253D%25252Fui%25252Fdesktop%25252FDesktopMainDefaultPage%25253Fisdtp%25253Dmn%2526save_new_url%253D%25252F00T%25252Fe%25253FretURL%25253D%2525252FT00000000001iZa%2525253Fisdtp%2525253Dmn%25252526retURL%2525253D%2525252Fui%2525252Fdesktop%2525252FDesktopMainDefaultPage%2525253Fisdtp%2525253Dmn&isdtp=mn" name="mainFrame" marginwidth="2" marginheight="2" id="mainFrameWork" />';
}
else if(gustype=='Work')
divhtml = '<iframe width="100%" scrolling="yes" height="' + FrameHeight +'" frameborder="no" title="mainFrame" src="/' + id + '?isdtp=mn&retURL=/ui/desktop/DesktopMainDefaultPage?isdtp=mn" name="mainFrame" marginwidth="2" marginheight="2" id="mainFrameWork" />';
else
{
divhtml = '<table width="100%"> <tr width="100%">';
divhtml += ' <td width="50%"> ';
divhtml += '<iframe width="100%" scrolling="yes" height="'+ FrameHeight+ '" frameborder="no" title="mainFrame" src="/' + id + '?isdtp=mn&retURL=/ui/desktop/DesktopMainDefaultPage?isdtp=mn" name="mainFrame" marginwidth="2" marginheight="2" id="mainFrameWork" > </iframe>' ;
divhtml += '</td>';
divhtml += '<td width="50%">';
divhtml += '<iframe width="100%" scrolling="yes" height="'+ FrameHeight+ '" frameborder="no" title="miniFrame" src="/ui/desktop/DesktopMicro?isdtp=mo&mainId=' + id + '&id0=' + idparent + '" name="miniFrame" marginwidth="2" marginheight="2" id="miniFrameTask" > </iframe>' ;
divhtml += '</td> </tr> </table>';
}*/
detaildiv.innerHTML = divhtml ;
},

doRefresh : function ()
{
var header = GUS.LastHeader;
GUS.LastHeader = '';
GUSQuery.getLists(header);
GUSDisplay.renderLists(GUS.LastView);
},

sortbyHeader : function (header)
{
GUSQuery.getLists(header);
GUSDisplay.renderLists(GUS.LastView);
},

RowWorkShowing : null,
selectWork : function (selectedrow)
{
if( GUSDisplay.RowWorkShowing != null)
GUSDisplay.RowWorkShowing.style.fontWeight= "400";
selectedrow.style.fontWeight= "700";
GUSDisplay.RowWorkShowing = selectedrow;
},

selectView : function (listView)
{
var view = listView.options[listView.selectedIndex].value;
GUS.GusObject = view;
GUS.LastView = view;
GUS.LastHeader = null;
GUSDisplay.renderLists(view);
}

};

var GUSControls =
{
collapse : function (divid, imgobject)
{
var divobject = document.getElementById(divid);

if ( divobject.style.visibility == 'hidden' || divobject.style.display == 'none')
{
divobject.style.display='';
divobject.style.visibility = 'visible';
if(imgobject != null)
imgobject.src = "/img/setup_minus.gif";
}
else
{
divobject.style.display='none';
divobject.style.visibility = 'hidden';
if(imgobject != null)
imgobject.src = "/img/setup_plus.gif";
}

},

CustomListDivShowing : null,
showFewerMore : function (choice)
{
var divtomodify = null;

if(GUSControls.CustomListDivShowing == null)
divtomodify = document.getElementById('divCustomWorkLayout');
else if(GUSControls.CustomListDivShowing.id == 'divTaskDetail')
divtomodify = document.getElementById('divCustomTaskLayout');
else divtomodify = document.getElementById('divCustomWorkLayout');

var pxheight = divtomodify.style.height;
var intheight = pxheight.split('p');
var numheight = +intheight[0];

if(choice=='fewer')
{
if (numheight >= 250)
{
numheight = numheight-200;
}
divtomodify.style.height = numheight + 'px';
}
else if(choice=='more')
{
numheight += 200;
divtomodify.style.height = numheight + 'px';
}

return false;
},

clearOptions : function (OptionListId)
{
var OptionList = document.getElementById(OptionListId);
for (x = OptionList.length; x >= 0; x--)
{
OptionList[x] = null;
}
},

deselectOptions : function(listid)
{
var list = document.getElementById(listid);
for (var i in list.options)
{
list.options[i].selected = false;
}
},


addToOptionList : function (OptionListId, OptionValue, OptionText)
{
var OptionList = document.getElementById(OptionListId);
OptionList[OptionList.length] = new Option(OptionText, OptionValue);
},

createObject : function (listNew)
{
var gusobject = listNew.options[listNew.selectedIndex].value;
GUSDisplay.fillDetailsDiv(gusobject, null , null);
listNew.options[0].selected = true;
}

};

var GUSQuery =
{
SOQLLimit : ' Limit 500 ',
StartWhereClause :" Where ",
SOQLAnd : ' And ',
SOQLOr : ' Or ',
LastFilter : '',
Toggle : false,
SortImg : null,

getLists : function (header)
{
var queryresult = null;
var querystring = TASKS.Query + GUSQuery.LastFilter + GUSQuery.getOrderBy(header) + GUSQuery.SOQLLimit;

queryresult = GUSUtils.Query(querystring);

if(queryresult.size == 0 || queryresult.size == 1 || queryresult.size == 3)
{
TASKS = new Tasks();
WORKS = new Works();
return;
}
TASKS.fillList(queryresult);

var worklistids = new Array();
for(var i=1; i!= TASKS.List.length; i++)
{
worklistids[i] = TASKS.List[i].Task_Parent__r.Id;
}
var worklistids = GUSUtils.removeDuplicates(worklistids);


var worklist = "('" + worklistids[0] + "'";

for(var i=1; i!= worklistids.length; i++)
{
worklist += ',' + "'" + worklistids[i] + "'";
}
worklist += ')';

querystring = WORKS.Query + ' Where Id in ' + worklist + GUSQuery.SOQLLimit;
queryresult = GUSUtils.Query(querystring);
WORKS.fillList(queryresult);

},

getOrderBy : function (header)
{
var ascdesc = null;
var orderby = null;
if(header == null || header == '')
{
orderby = ' Order By CreatedDate DESC ';
return orderby;
}
orderby = header;
if(GUS.LastHeader == header)
if(GUSQuery.Toggle)
ascdesc = ' DESC ';
else ascdesc = ' ASC ';
else ascdesc = ' ASC ';

var imgsrc = '';
if(ascdesc == ' ASC ')
imgsrc = "/img/sort_asc_arrow.gif";
else imgsrc = "/img/sort_desc_arrow.gif";
GUSQuery.SortImg = imgsrc;

GUSQuery.Toggle = (GUSQuery.Toggle == false);
GUS.LastHeader = header;
orderby = ' Order By ' + orderby + ascdesc;
return orderby;
}

};

var GUSInline =
{
hoverEditable : function (td)
{
td.className = 'hoverEditable';
},

resetStyle : function (element)
{
if(element.childNodes[0].className != 'hidden'){element.className = 'normal' };
},

handleClick : function (element)
{
if(element.childNodes[0].className == 'hidden')
{
element.className = 'hoverEditable';
}
else {

element.childNodes[0].className = 'hidden';
element.childNodes[1].className = 'inputText';
element.childNodes[1].focus();
element.childNodes[1].select();
GUSInline.resetStyle(element);
}
},

formSubmit : function (element)
{
element.value=trim(element.value);

if(GUSInline.isNumeric(element.value))
{
GUSInline.save(element);
var task = new sforce.SObject("Work_Task__c");
task.Id = element.id.substr(0,element.id.indexOf('.'));
var hours = 0;
if( element.value != '') hours = element.value;
task.set(element.id.substr(element.id.indexOf('.') + 1), hours);

if ( hours == 0 )
{
task.set( 'Status__c', 'Closed' );
}
else if (!isNaN( hours ) )
{
if (parseFloat(hours) == 0 )
{
task.set( 'Status__c', 'Closed' );
}
else {
task.set( 'Status__c', 'In Progress' );
}
}
var taskChangeMade = true;
sforce.connection.update([task],GUSUtils.returnCall);
}
else if(!isNumeric(element.value))
{
alert('\'' + element.value + '\' is not a number.');
element.select();
}
},

save : function (element)
{
var displayValue = element.parentNode.childNodes[0];
element.className = 'hidden';
displayValue.className = 'editable';
var hours = 0;
if(element.value != '') hours = element.value;
displayValue.innerHTML = hours;
GUSInline.resetStyle(element.parentNode);
},

isNumeric : function (sText)
{
var ValidChars = "0123456789.";
var IsNumber=true;
var Char;

for (i = 0; i < sText.length && IsNumber == true; i++)
{
Char = sText.charAt(i);
if (ValidChars.indexOf(Char) == -1)
{
IsNumber = false;
}
}
return IsNumber;
}
};

var GUSMassUpdate =
{
selectAllCheckBox : function (element)
{
var selected = '';
var select = true;
if (!element.checked)
select = false;
var parent = element.parentNode;
parent = parent.parentNode;
parent = parent.parentNode;
parent = parent.parentNode;
parent = parent.parentNode;
var checkboxes = parent.getElementsByTagName("input");
for (var i=0; i < checkboxes.length; i++)
{
if(checkboxes[i].type == "checkbox" )
checkboxes[i].checked = select;
}
},

doAction : function (listAction)
{
if(listAction.options[listAction.selectedIndex].value == 'Add')
alert("Wait for 152!");
if(listAction.options[listAction.selectedIndex].value == 'UpdateCompleted')
GUSMassUpdate.doTaskUpdate('Closed');
if(listAction.options[listAction.selectedIndex].value == 'UpdateInProgress')
GUSMassUpdate.doTaskUpdate('In Progress');

listAction.options[0].selected = "yes";
},

doTaskUpdate : function (status)
{
var object = null;
var objects = new Array();
var checkboxes = new Array();

checkboxes = document.formDetails.checkboxAction;

for (var i = 0; i != checkboxes.length; i++)
{
if(checkboxes[i].checked)
{
if(GUS.GusObject == 'Task')
object = new sforce.SObject("Work_Task__c");
else object = new sforce.SObject("Work__c");

object.Id = checkboxes[i].value;
if(GUS.GusObject == 'Task')
if(status == "Closed")
object.set( 'Hours_Remaining__c', '0' );
object.set( 'Status__c', status );
objects.push(object);

}
}

var result = sforce.connection.update(objects);
var parent = null;
var columnnum = Number(GUSColumns.getTaskColumnNum('Status__c'));
columnnum += 1;
for (var i=0; i < checkboxes.length; i++)
{
if(checkboxes[i].checked)
{
for(var j = 0; j != result.length; j++)
{
if(result[j].get("id") == checkboxes[i].value && result[j].getBoolean("success"))
{
parent = checkboxes[i].parentNode;
parent = parent.parentNode;
parent.childNodes[columnnum].innerHTML = status;
}
}
}
}
}
};

var GUSColumns =
{
Column : function (label, reference,name, number, visible)
{
this.label = label;
this.reference = reference;
this.name = name;
this.number = number;
this.visible = visible;

if(this.reference == '')
this.APIName = this.name;
else this.APIName = this.reference + '.' + this.name;
},

showColumns : function()
{
GUSControls.collapse("divColumns", null);
if(document.getElementById("divColumns").style.visibility != 'hidden')
{
GUSControls.clearOptions("selectTaskAvailable");
GUSControls.clearOptions("selectTaskSelected");
GUSControls.clearOptions("selectWorkAvailable");
GUSControls.clearOptions("selectWorkSelected");

for(var i in TASKS.Headers)
{
if(TASKS.Headers[i].visible == false)
GUSControls.addToOptionList("selectTaskAvailable",i, TASKS.Headers[i].label);
else GUSControls.addToOptionList("selectTaskSelected",i, TASKS.Headers[i].label);
}

for(var i in WORKS.Headers)
{
if(WORKS.Headers[i].visible == false)
GUSControls.addToOptionList("selectWorkAvailable",i, WORKS.Headers[i].label);
else GUSControls.addToOptionList("selectWorkSelected",i, WORKS.Headers[i].label);
}
}
},

moveColumn : function (direction, gusobject)
{
var available = null;
var selected = null;
if(gusobject == 'Task')
{
available = document.getElementById('selectTaskAvailable');
selected = document.getElementById('selectTaskSelected');
}
else
{
available = document.getElementById('selectWorkAvailable');
selected = document.getElementById('selectWorkSelected');
}
if(direction == 'add')
{
moveOption(available, selected, '--None--', [], null,'--None--');
}
else if(direction == 'remove')
{
moveOption(selected, available, '--None--', [], null,'--None--');
}
else if(direction == 'up')
{
moveUp(selected, null,null,null);
}
else if(direction == 'down')
{
moveDown(selected, null,null,null);
}
},

saveColumns: function()
{
var columns = document.getElementById('selectTaskSelected');
var neworder = new Array();
for(var i = 0; i != columns.length; i++)
{
TASKS.Headers[columns[i].value].visible = true;
neworder[i] = TASKS.Headers[columns[i].value];
TASKS.Headers[columns[i].value] = null;
}
for(var i = 0; i != TASKS.Headers.length; i++)
{
if(TASKS.Headers[i] != null)
{
TASKS.Headers[i].visible = false;
neworder.push(TASKS.Headers[i]);
}
}
TASKS.Headers = neworder;

columns = document.getElementById('selectWorkSelected');
neworder = new Array();
for(var i = 0; i != columns.length; i++)
{
WORKS.Headers[columns[i].value].visible = true;
neworder[i] = WORKS.Headers[columns[i].value];
WORKS.Headers[columns[i].value] = null;
}
for(var i = 0; i != WORKS.Headers.length; i++)
{
if(WORKS.Headers[i] != null)
{
WORKS.Headers[i].visible = false;
neworder.push(WORKS.Headers[i]);
}
}
WORKS.Headers = neworder;

GUSDisplay.renderLists();
GUSControls.collapse('divColumns', null);
},

getTaskColumnNum : function (apiname)
{
for(var i in TASKS.Headers)
{
if(TASKS.Headers[i].APIName == apiname)
return i ;
}
}

};

var GUSSearch =
{
doSearch : function (keyword)
{
var searchquery = 'find {'+ keyword +'} returning Work__c, Work_Task__c(Task_Parent__r.Id)';
var searchresult = GUSUtils.Search(searchquery);
GUSUtils.debug(searchresult);
var records = searchresult.getSearchRecords();
var worklistids = new Array();
var tasklistids = new Array();
var record = null;
var taskparent = null;
var j = 0;
for(var i = 0 ; i != searchresult.length ; i++)
{
record = records[i];
if(record.get("type") == 'Work__c')
worklistids[i] = record.Id;
else if(record.get("type") == 'Work_Task__c')
{
tasklistids[j++] = record.Id;
taskparent = record.Task_Parent__r;
worklistids[i] = taskparent.Id;
}
}
alert(tasklistids);
}
}

</script>