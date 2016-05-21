.jsondiffpatch-visualdiff-root {
    font-family: "Arial", "Sans Serif";
    font-size: 1.0em;
    margin: 20px;
}

.jsondiffpatch-object-table {
    width: 100%;
}

tr.jsondiffpatch-object-table-header {
    font-size: 1.3em;
}

.jsondiffpatch-array-table {
    width: 100%;
    table-layout:fixed;
}

.jsondiffpatch-array-table tr {
	border-style:solid;
	border-color:black;
}

.jsondiffpatch-array-table td {
	overflow:hidden;
}

.jsondiffpatch-array-table td:nth-of-type(1) {
	width:50%;
}/*Setting the width of column 1.*/

.jsondiffpatch-array-table td:nth-of-type(2) {
	width:50%;
}/*Setting the width of column 2.*/

.jsondiffpatch-item-table {
    width: 100%;
    table-layout:fixed;
}

.jsondiffpatch-item-table > tr:nth-child(even) {
    background-color: white;
}

.jsondiffpatch-item-table tr {
	border-style:none
}


.jsondiffpatch-item-table-header {
	font-size: 1.3em;
	font-weight:bold;
}

.jsondiffpatch-item-table-added {
    width: 100%;
    table-layout:fixed;
    background: #99ff66;
}

.jsondiffpatch-item-table-added > tr:nth-child(even) {
    background-color: #99ff99;
}

.jsondiffpatch-item-table-notfound-original {
    width: 100%;
    table-layout:fixed;
    background: #00ffcc;
   text-decoration: line-through;
}

.jsondiffpatch-item-table-notfound-original > tr:nth-child(even) {
    background-color: #00ffff;
}


table.jsondiffpatch-item-table-notfound-original:hover {
    text-decoration: none;
}


.jsondiffpatch-item-table-moved-original {
    width: 100%;
    table-layout:fixed;
    background: #ccffcc;
}

.jsondiffpatch-item-table-moved-original > tr:nth-child(even) {
    background-color: #ccffff;
}

.jsondiffpatch-item-table-moved-new {
    width: 100%;
    table-layout:fixed;
    background: #ccffcc;
}

.jsondiffpatch-item-table-moved-new > tr:nth-child(even) {
    background-color: #ccffff;
}

.jsondiffpatch-item-table-changed {
    width: 100%;
    table-layout:fixed;
}

.jsondiffpatch-item-table-changed-new {
    width: 100%;
    table-layout:fixed;
    background: #ffff99;
}

.jsondiffpatch-item-table-changed-new > tr:nth-child(even) {
    background-color: #ffffcc;
}

.jsondiffpatch-textdiff .jsondiffpatch-added {
    background: #33ff66;
}

.jsondiffpatch-textdiff .jsondiffpatch-deleted {
    background: #ffbbbb;
    text-decoration: line-through;
}

.jsondiffpatch-textdiff .jsondiffpatch-deleted:hover {
    text-decoration: none;
}

.jsondiffpatch-textdiff .jsondiffpatch-header {
    color: gray;
    display: block;
}

.jsondiffpatch-unchanged {
    color: gray;
}

tr.jsondiffpatch-unchanged td {
    color: gray;
}

tr.jsondiffpatch-unchanged td:hover {
    color: black;
}

.jsondiffpatch-important {
	font-weight:400;
}

tr.jsondiffpatch-modified{
	font-size: 1.2em;
	font-weight: 600;
}

.jsondiffpatch-modified-member-original {
    background: #ffbbbb;
    text-decoration: line-through;
}

.jsondiffpatch-modified-member-original > div > table > tr > td{
    text-decoration: line-through;
}

td.jsondiffpatch-modified-member-original:hover {
    text-decoration: none;
}

.jsondiffpatch-modified-member-newJSON {
    margin-left: 5px;
}


.jsondiffpatch-modified-original {
    background: #ffbbbb;
    text-decoration: line-through;
    float: right;
}

.jsondiffpatch-modified-original > div > table > tr > td{
    text-decoration: line-through;
}

td.jsondiffpatch-modified-original:hover {
    text-decoration: none;
}

.jsondiffpatch-modified-newJSON {
    margin-left: 5px;
    float: right;
}

.jsondiffpatch-unchanged-newJSON {
    float: right;
}

.jsondiffpatch-unchanged-original {
    float: right;
}

.jsondiffpatch-unchanged-original .jsondiffpatch-important {
    float: right;
}


.jsondiffpatch-property-name {
    margin: 0;
    padding: 0 10px 0 0;
    min-height: 17px;
}

.jsondiffpatch-property-name > td {
    margin: 0;
    padding: 0 10px 0 0;
    min-height: 17px;
    width: 33%;
}

