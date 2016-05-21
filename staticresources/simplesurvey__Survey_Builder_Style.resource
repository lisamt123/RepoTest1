.slds .slds-is-current+.slds-tabs--path__item.slds-is-complete:before {
    background-color: #0076DE;
}

.slds .slds-is-current:hover+.slds-tabs--path__item.slds-is-complete:before {
    background-color: #005fb2;
}

.slds .slds-is-complete+.slds-tabs--path__item.slds-is-incomplete:before {
    background-color: #4bca81;
}

.slds .slds-is-complete:hover+.slds-tabs--path__item.slds-is-incomplete:before {
    background-color: #04844b;
}

.slds .slds-tabs--path__item>a:focus {
    outline: none;
}

#loading-overlay {
    position: fixed;
    left: 0px;
    top: 0px;
    z-index: 99;
    background-color: rgba(255,255,255,0.9);
}

a.no-link {
    cursor: default !important;
    text-decoration: none !important;
}

#questions-spinner {
    margin: -200px auto 0px auto;
}

#questions {
    min-height: 400px;
    border-spacing: 16px;
}

#questions #available, #questions #selected {
    width: 50%;
}

#questions>thead>tr>th {
    text-align: center;
    text-transform: none;
}

#questions>tbody>tr>td#available, #questions>tbody>tr>td#selected {
    border: 1px solid #eee;
    background-color: #f4f6f9;
    vertical-align: top;
    padding: 12px;
    border-radius: 4px;
}

#questions>tbody>tr>td#arrows {
    vertical-align: middle;
    text-align: center;
    font-size: 12pt;
    font-weight: bold;
}

#questions>tbody>tr>td#available>div.overflow, #questions>tbody>tr>td#selected>div.overflow {
    width: 100%;
    height: 400px;
    overflow-y: auto;
}

#questions>tbody>tr>td#available>div.overflow:before, #questions>tbody>tr>td#selected>div.overflow:before {
    content: '';
    width: 0px;
    height: 400px;
    display: block;
    float: left;
    border-radius: 2px;
}

#questions>tbody>tr>td#arrows {
    min-width: 32px;
}

/*#questions>tbody>tr>td#arrows:before {
    content: '< >';
}*/

.dropzone {
    min-height: 32px;
}

.dropzone:after {
    content: '';
    display: block;
    clear: left;
}

.question {
    user-select: none;
    -ms-user-select: none; 
    -moz-user-select: none; 
    -webkit-user-select: none;
    cursor: move;
    margin: 5px;
    padding: 8px;
    background-color: #fdfdfd;
    border: 1px solid #ddd;
    position: relative;
    padding-left: 32px;
}

.question:hover {
    background-color: #fff;
    border: 1px solid #ccc;
}

.question:before {
    content: ': :';
    display: block;
    float: left;
    margin-right: 12px;
    position: absolute;
    left: 8px;
    top: 6px;
}

.question.drag {
    opacity: 0.5;
}

.question.over {
    border: 1px solid #777;
}

#new-question-form {
    position: fixed;
    left: 0px;
    top: 0px;
    width: 100%;
    height: 100%;
    background-color: rgba(255,255,255,0.8);
}

dt {
    font-weight: bold;
}

dd {
    margin-left: 12px !important;
}

.slds-popover__body {
    font-size: 13px !important;
}

.lightbox {
    width: 100% !important;
    max-width: 800px !important;
}

.lightbox>div {
    position: relative;
    background-color: #fff;
    border-radius: 4px;
    padding: 8px;
}