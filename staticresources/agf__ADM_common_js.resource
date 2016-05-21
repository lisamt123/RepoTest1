// This function removes the line number and column from system
// exception error messages
function trimErrorMessage(errorMessage) {
    return errorMessage.substring(errorMessage.indexOf(':')+1).trim();
}

function removeEvents(ele) {
	ele.onblur = null;
	ele.onclick = null;
	ele.ondblclick = null;
	ele.onfocus = null;
	ele.onmouseout = null;
	ele.onmouseover = null;
}

function setInit(val) {
	init = val;
}

//---------------------------BEGIN related_url_link s-control Java script----------------------------\\
function processRelatedURL(text) {
	var linkPattern = /(\b(https?|ftp|file):\/\/[-A-Z0-9+&@#\/%?=~_|!:,.;]*[-A-Z0-9+&@#\/%=~_|])/ig;
	var wwwPattern = /(^|[^\/])(www\.[-A-Z0-9+&@#\/%?=~_|!:,.;]*)/gim;
	var mailtoPattern = /([\w-_.]+@[a-zA-Z_]+?\.[a-zA-Z]{2,6})/gim;
	var filePattern = /([\\]{2}[\w\\]*)/gi;

	text = text.replace(linkPattern, "<a href='$1' target='_blank'>$1</a>");
	text = text.replace(wwwPattern, "$1<a href='http://$2' target='_blank'>$2</a>");
	text = text.replace(mailtoPattern, '<a href="mailto:$1">$1</a>');
	text = text.replace(filePattern, '<a title="For local links in Firefox install this extension: http://locallink.mozdev.org/installation.html" href="file:///$1" target="_blank">$1</a>');

	return text;
}

//prebuilt map of regex pattern to encode entity which is used by the escapeHtml()
//function
var _entityMap = [
    [/&/g, '&amp;'],
    [/</g, '&lt;'],
    [/>/g, '&gt;'],
    [/\'/g, '&#39;'],
    [/\"/g, '&quot;'],
    [/\//g, '&#47;']
];
function escapeHTML(/**String*/ s) {
	if(s != null && s != '') {
        for(var index = 0; index < _entityMap.length; index++) {
            var pattern = _entityMap[index][0];
            var entity = _entityMap[index][1];

            s = s.replace(pattern, entity)
        }
	}
	return s;
}

function removePlus(s) {
	if(s != null && s != '') {
		var plus = /[+]/ig;
		s = s.replace(plus, ' ');
	}
	return s;
}

function reRenderIframe(id, url) {
	var targetIframe = dojo.byId(id);

	targetIframe.src = url;
}

//disable enter submitting the form and perform onClick event of provided button ID instead
function clickButtonOnEnterKeyPress(e,f,buttonID) {
	if((e == 13) || (f==13)) {
		document.getElementById(buttonID).click();
		return false;
	} else {
		return true;
	}
}

function escapePunctuation(inputValue) {
	// Need to escape single quotes.  Split the text on single quotes, and rejoin with the escaped value
    inputValue = inputValue.split("'");
    inputValue = inputValue.join("\\'");

    // Now escape double quotes.
    inputValue = inputValue.split('"');
    inputValue = inputValue.join('\\"');
    return inputValue;
}

function removeSpacesFromEmail(newUser) {
	if(newUser != null && newUser.indexOf("@") > -1) {
    	newUser = removeSpacesFromString(newUser.replace(/^\s*|\s*$/g,''));
    }
    return newUser;
}

function removeSpacesFromString(s) {
	if(s != null) {
		s = s.replace(/[\s]*/ig, "");
		s = s.toLowerCase();
	}
	return s;
}

function cleanupArray(arr) {
	if(arr != null) {
        for(var i = 0; i < arr.length; i++) {

        	if(isEmptyString(arr[i])) {
        		arr.splice([i], 1);
        	}
        }
    }

    return arr;
}

function numberOfInArray(arr, str) {
	var str = removeSpacesFromString(str);
	var numOfInArray = 0;


	if(str != null && arr != null) {
		for(var i = 0; i < arr.length; i++) {
			el = removeSpacesFromString(arr[i]);


			if(el.indexOf(str) > -1) {
				numOfInArray++;

			}
		}
	}

	return numOfInArray;
}

function indexOfArray(arr, str) {
	var str = removeSpacesFromString(str);
	var el = "";
	var idx = -1;

	if(str != null && arr != null) {
		for(var i = 0; i < arr.length; i++) {
			el = removeSpacesFromString(arr[i]);
			if(el.indexOf(str) > -1) {
				idx = i;
				break;
			}
		}
	}

	return idx;
}

function addCheckinQuestions(id, work) {
    var note = document.getElementById(id);
    // only populate if null note
    if(note != null) {
        if(note.value == null || note.value.length == 0 || note.value == 'Write something...' || note.value == 'Say something about this file...' || note.value == 'Say something about this link...' || note.value == 'What would you like to ask?') {
            var questions = [];
            questions.push('Describe the customer experience that triggered this fix.');
            questions.push('Describe the fix and how it resolves the customer issue.');
            questions.push('What needs to be tested?');
            questions.push('Why is this a low-risk fix?');
            questions.push('How does this meet the Patch or e-Release criteria?');
            questions.push('Will customers notice a change, either in functionality or performance? (Y/N) If yes, work with your PM or PO to fill out the "ReadMe Notes" field. Also add the "ReadMe Required" theme.');

            if(work && work.Scheduled_Build__c && (work.Scheduled_Build__c.toLowerCase().indexOf('ecelerity') > -1 || work.Scheduled_Build__c.toLowerCase().indexOf('momentum') > -1)) {
                questions.push('How can this be verified in ftests?');
                questions.push('How can this be verified in end-to-end tests?');
                questions.push('How can this be verified in dev?');
                questions.push('How can this be verified in blitz?');
                questions.push('How can this be verified in TYO?');
                questions.push('How can this be verified in TYO/CHI?');
                questions.push('How can this be verified in TYO/CHI/ASG?');
            }

            //convert the array of questions to a string
            var checkinQuestions = '';
            for(var index = 0; index < questions.length; index++) {
                checkinQuestions += '- ' + questions[index] + '\n\n';
            }

            note.value = checkinQuestions;
        }
        else {
            alert('Can only add checkin questions if the comment field is empty.');
        }
    }
    else {
        alert('Could not find the comment input field!');
    }
}

function copyValues(fromElement, toElement) {
	if(fromElement != null && toElement != null) {

	    if(fromElement.tagName == 'DIV' && toElement.tagName == 'TEXTAREA') {
	        toElement.innerHTML = fromElement.innerHTML;

	    } else {
	    	toElement.value = fromElement.value;

	    }
	}
}

function loadInParent(url) {
    window.open('','_self','');
    window.close();
    self.opener.location = url;
}

function getWidthHeight() {
    var myWidth = 0, myHeight = 0;

    if(typeof(window.innerWidth) == 'number') {
        //Non-IE
        myWidth = window.innerWidth;
        myHeight = window.innerHeight;
    } else if(document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
        //IE 6+ in 'standards compliant mode'
        myWidth = document.documentElement.clientWidth;
        myHeight = document.documentElement.clientHeight;
    } else if(document.body && (document.body.clientWidth || document.body.clientHeight)) {
        //IE 4 compatible
        myWidth = document.body.clientWidth;
        myHeight = document.body.clientHeight;
    }

    return [ myWidth, myHeight ];
}

function getScrollXY() {
    var scrOfX = 0, scrOfY = 0;

    if(typeof(window.pageYOffset) == 'number') {
        //Netscape compliant
        scrOfY = window.pageYOffset;
        scrOfX = window.pageXOffset;
    } else if(document.body && (document.body.scrollLeft || document.body.scrollTop)) {
        //DOM compliant
        scrOfY = document.body.scrollTop;
        scrOfX = document.body.scrollLeft;
    } else if(document.documentElement && (document.documentElement.scrollLeft || document.documentElement.scrollTop)) {
        //IE6 standards compliant mode
        scrOfY = document.documentElement.scrollTop;
        scrOfX = document.documentElement.scrollLeft;
    }

    return [ scrOfX, scrOfY ];
}

function NetscapeEventHandler_KeyDown(e) {
	if(e.which == 13 && e.target.type != 'textarea' && e.target.type != 'submit') {
  		return false;
  	} else {
  		return true;
  	}
}

function MicrosoftEventHandler_KeyDown() {
	//in ie element type is coming back as text even for textarea so enters are not being let through.  Instead using class name... will work so long as there is never an autocomplete on a textarea.
	//alert('Element class:' + event.srcElement.className);
	if(event.keyCode == 13 && event.srcElement.type != 'textarea' && event.srcElement.type != 'submit' && event.srcElement.className != 'adm_longInputField') {
		return false;
	} else {
		return true;
	}
}

function setRegressedValue(types, attributes, unselections, selections, value) {
    var text = "";

    if(!types) {
    } else {
        text = types[types.selectedIndex].text;
        if(text == 'Test Failure' || text == 'Test Change') {
            removeAttributeValue(attributes, unselections, selections, value);
        }
    }
}

function removeAttributeByValue(els, value) {
    var index = '';
    var returnVar = '';

    for(var i = 0; i < els.options.length; i++) {
        var el = els.options[i];
        if(el.text == value) {
            index = i;
            returnVar = el.value;
        }
    }
    if(index != '') {
        try {
            els.remove(index);
        } catch(ex) {
        }
    }

    return returnVar;
}

function removeAttributeValue(attributes, unselections, selections, text) {
    removeAttributeByValue(attributes, text);

    var value = removeAttributeByValue(unselections, text);

    setAttributeSelectedValue(value, text, selections);
}



function setAttributeSelectedValue(value, text, selections) {
    var newRegressedOption = document.createElement('option');
    newRegressedOption.text = text;
    newRegressedOption.value = value;

    try {
        selections.add(newRegressedOption, null);
    } catch(ex) {
        selections.add(newRegressedOption);
    }
}

function set(types, attributes, unselections, selections) {
    var text = "";
    var foundRegressed = false;

    if(!types) {
    } else {

        text = types[types.selectedIndex].text;

        if(text == 'Test Failure' || text == 'Test Change') {
            for(var i = 0; i < attributes.options.length; i++) {
                var attribute = attributes.options[i];
                if(attribute.text == 'Regressed') {
                    unselections.remove(i);

                    for(var j = 0; j < selections.options.length; i++) {
                        var selected = selections.options[j];

                        if(selected.text == attribute.text) {
                            foundRegressed = true;
                            break;
                        }
                    }

                    if(!foundRegressed) {
                        var newRegressedOption = document.createElement('option');
                        newRegressedOption.text = attribute.text;
                        newRegressedOption.value = i;

                        try {
                            selections.add(newRegressedOption, null);
                        } catch(ex) {
                            selections.add(newRegressedOption);
                        }
                    }
                }
            }
        }
    }
}

<!-- Disables browsers local autocomplete which can interfere with our server side version -->
function disableautocomplete() {
	var forms = document.getElementsByTagName('form');

	for (var i = 0; i < forms.length; ++i) {
    	if(forms[i].setAttribute) {
      		forms[i].setAttribute('autocomplete', 'off');
    	} else {
      		forms[i].autocomplete = 'off';
    	}
  	}
}

function initAutoCompleteBrowserSettings() {
	if(window.addEventListener) {
		window.addEventListener('load', disableautocomplete, true);
    } else if(window.attachEvent) {
		window.attachEvent('onload', disableautocomplete);
    } else {
      window.onload = disableautocomplete;
    }

    <!-- following code stops enter submitted the form so that you can use keyboard to navigate autocomplete -->
    var nav = window.Event ? true : false;

    if(nav) {
       window.captureEvents(Event.KEYDOWN);
       window.onkeydown = NetscapeEventHandler_KeyDown;
    } else {
       document.onkeydown = MicrosoftEventHandler_KeyDown;
    }
}


var detailsValue;
detailsValue = 'User type (As a...)\n';
detailsValue += 'Goal (I want to...)\n';
detailsValue += 'Reason (so that...)\n';
detailsValue += 'Additional Details';

function populateDetails(el) {
    if(!el) {
    } else {
        //alert('details el' + el);
        if(isEmpty(el)) {
            el.style.color = 'grey';
            el.value = detailsValue;
        } else if(el.value == detailsValue) {
            el.style.color = 'grey';
        }
    }
}

function populateHelpText(elementID, helpText) {
    var el = document.getElementById(elementID);
    if(!el) {
    } else {
        if(isEmpty(el)) {
            el.style.color = 'grey';
            el.value = helpText;
        } else if(el.value == helpText) {
            el.style.color = 'grey';
        }
    }
}

var overrideValue = 'Explain why this bug should have a different priority';

function populateOverrideExplanation(el) {
    if(el) {
        if(isEmpty(el) || el.value == overrideValue) {
            el.style.color = 'grey';
            el.value = overrideValue;
        } else {
            el.style.color = 'black';
        }
    }
}

function isString(v) {
    return typeof v === 'string' || v instanceof String;
}

var re = /^\s{1,}$/g; //match any white space including space, tab, form-feed, etc.

function isEmptyString(mytext) {
	if(mytext == '' || mytext == null || mytext.search(re) > -1) {
		return true;
	} else {
		return false;
	}
}

function isEmpty(mytext) {
    if((mytext.value.length==0) || (mytext.value==null) || ((mytext.value.search(re)) > -1)) {
        return true;
    } else {
        return false;
    }
}

function eraseValue(el) {
    if(el.value == detailsValue || el.value == overrideValue) {
        el.style.color = 'black';
        el.value = '';
    }
}

function eraseValueIfUnchanged(elementID, originalValue) {
	var el = document.getElementById(elementID);

    if(el.value == originalValue) {
        el.style.color = 'black';
        el.value = '';
    }
}

function hideIt() {
    if(document.getElementById('impact').value!='none') {
        document.getElementById('sevnone').style.display="none";
        document.getElementById('calculated').style.display="block";
    }
}

function revert() {
    document.getElementById('calculated').style.display="block";
}

function overlay() {
    el = document.getElementById("overlay");
    el.style.visibility = (el.style.visibility == "visible") ? "hidden" : "visible";
    if(el.style.visibility == 'visible') {
        try {
            var $container = $(window);
            var $dialog = $('.overlaycontainer');
            var left = ($container.width()/2) - ($dialog.width()/2) + $container.scrollLeft();
            var top = ($container.height()/2) - ($dialog.height()/2) + $container.scrollTop();
            $dialog.css({
                'position':'absolute',
                'top':top + 'px',
                'left':left + 'px',
                'margin':'0'
            });
        } catch(e) {}
    }
}

function overlay1() {
    overlay();
}

function addInvestigationQuestions(id) {
    if(id != null) {
        var el = document.getElementById(id);
        if(el != null) {
            if(el.value == null || el.value.length == 0 || el.value == 'Write something...' || el.value == 'Say something about this file...' || el.value == 'Say something about this link...' || el.value == 'What would you like to ask?') {
                el.value = 'Response Requested – \'Example: Bug with work ID, Bug with work ID to follow, explanation for working as designed.\'\n\n';
                el.value += 'Describe urgency from the customer\'s perspective –\n\n';
                el.value += 'Number of users impacted –\n\n';
            } else {
                alert('Can only add questions to the comments section if it is empty');
            }
        }
    }
}

function toggleSeniorMgrDisabled(mgr_review, senior_mgr) {
    if(mgr_review != null && senior_mgr != null) {
        if(!mgr_review.checked) {
            senior_mgr.disabled = true;
            senior_mgr.value = '';
        } else {
            senior_mgr.disabled = false;
        }
    }
}

function setIcon(recordType, node, url) {
    var img = document.createElement('img');

    if(recordType == 'User Story') {
        img.setAttribute('src', url.us);
    } else if(recordType == 'Bug') {
        img.setAttribute('src', url.bug);
    } else if(recordType == 'ToDo') {
        img.setAttribute('src', url.todo);
    } else if(recordType == 'Investigation') {
        img.setAttribute('src', url.investigation);
    } else if(recordType == 'Template') {
        img.setAttribute('src', url.template);
    }

    img.setAttribute('style', 'float:left; width:32px; vertical-align:middle; padding-top:5px;');
    node.parentNode.replaceChild(img, node);
}

/**
 * Takes an ID and encodes the special characters so that a jQuery context can
 * be created.
 */
function $byId(originalId) {
    var $;
    if(arguments.length > 1) {
        $ = arguments[1];
    } else {
        //use the default
        $ = window['$'];
    }
    return $('#' + originalId.replace(/(:|\.)/g,'\\$1'));
}

if(typeof this.gus === 'undefined') {
    this.gus = {};
}

if(typeof(gus.isUndefined) === 'undefined') {
    gus.isUndefined = function(value) {
        return typeof(value) === 'undefined';
    };
}

if(gus.isUndefined(gus.unescape)) {
    gus.unescape = (function() {
        var map = {
            '&amp;'  : '&',
            '&lt;'   : '<',
            '&gt;'   : '>',
            '&quot;' : '"',
            '&#x27;' : "'",
            '&#x2F;' : '/'
        };
        var regex = new RegExp('(&amp;|&lt;|&gt;|&quot;|&#x27;|&#x2F;)', 'g');
        return function(value) {
            if(value == null) {
                return '';
            }
            return ('' + value).replace(regex, function(match) {
                return map[match];
            });
        };
    })();
}

/**
 * Parses an encoded JSON string from the VF page into the Javascript data type
 */
if(gus.isUndefined(gus.parseVfJson)) {
    gus.parseVfJson = function(value) {
        return JSON.parse(gus.unescape(value));
    };
}

if(typeof this.gus.sfdc === 'undefined') {
    this.gus.sfdc = {};
}

/**
 * Determines if the specified input is a lookup field
 */
gus.sfdc.isLookup = function($input) {
    var id = $input.attr('id');
    if(!id) {
        console.warn('No ID specified on input');
        return false;
    }

    var lookupIdInput = document.getElementById(id + '_lkid');
    return !!lookupIdInput;
};

/**
 * Gets the SObject that has been set on a SFDC Lookup field. If no
 * value has been set a null reference is returned.
 */
gus.sfdc.getSobjectFromLookup = function($input) {
    var id = gus.sfdc.getSobjectIdFromLookup($input);
    if(!id || id === '000000000000000') {
        id = null;
    }

    var name = $input.val();
    if(!id && !name) {
        return null;
    } else {
        return {
            Id: id,
            Name: $input.val()
        };
    }
};

/**
 * Gets the ID of the SObject that has been set on a SFDC Lookup field. If no
 * value has been set a null reference is returned.
 */
gus.sfdc.getSobjectIdFromLookup = function($input) {
    if(!$input) {
        return;
    }

    var id = $input.attr('id');
    if(!id) {
        console.warn('No ID specified on input');
        return;
    }

    var lookupIdInput = document.getElementById(id + '_lkid');
    if(!lookupIdInput) {
        console.warn('Input #' + id + ' is not a lookup field');
        return;
    }

    return $(lookupIdInput).val();
};

/**
 * Sets the value of the SFDC Lookup field. Specifying a null reference for
 * sObject, clears the value in the lookup
 */
gus.sfdc.setLookup = function($field, sObject) {
    if(!sObject) {
        $field.val('').change();
        return;
    }

    //set the field value
    if('Name' in sObject) {
        $field.val(sObject.Name).change();
    }

    //try to set the lookup fields
    try {
        var fieldId = $field.attr('id');
        if(window.lookupPick && $(document.getElementById(fieldId + '_lkid')).length > 0) {
            window.lookupPick(
                $field.closest('form').attr('id'),
                fieldId + '_lkid',
                fieldId,
                '',
                sObject.Id, //ID
                sObject.Name, //value
                '',
                '');
        }
    } catch(e) {
        console.warn('Error while trying to set lookup fields: ' + e);
    }
};

(function(root, $) {
"use strict";

if(typeof $ === 'undefined') {
    console.warn('jQuery not found on page. Skipping RichAutoCompleteComponent initialization.');
    return;
}

var each = function(obj, fn, context) {
    if(obj === null) {
        return;
    }
    if(obj.forEach === Array.prototype.forEach) {
        obj.forEach(fn, context);
    } else {
        for(var i = 0, l = obj.length; i < l; ++i) {
            if(i in this) {
                iterator.call(fn, obj[i], i, obj);
            }
        }
    }
};

var map = function(obj, fn, context) {
    var results = [];
    if(obj === null) {
        return results;
    }
    if(obj.map === Array.prototype.map) {
        return obj.map(fn, context);
    } else {
        each(obj, function(value, index, list) {
            results.push(fn.call(context, value, index, list));
        });
        return results;
    }
};

var isString = function(value) {
	return (typeof value === 'string') ? true : false;
};

var isEmpty = function(value) {
    if(value === null) {
        return true;
    }
    if(Array.isArray(value) || isString(value)) {
        return value.length === 0;
    }

    for(var key in value) {
        if(value.hasOwnProperty(key)) {
            return false;
        }
    }
    return true;
};

var extend = $.extend;

var RichAutoCompleteComponent = function() {
    this.initialize.apply(this, arguments);
};
RichAutoCompleteComponent.prototype = {
    initialize: function(options) {
        if(!options) options = {};
        this.minLength = options.minLength || 1;
        this.controller = options.controller;
        this._loading = false;

        //get the inputs
        this.$container = options.$container;
        this.$nameInput = this.$('.gusRichAutoCompleteInput');
        this.$idInput = this.$('.gusRichAutoCompleteUserID');
        this.$statusIndicator = this.$('.gusRichAutoCompleteStatusIndicator');

        //register this within the input so it can be retrieved within the page
        this.$container.data('gus.RichAutoComplete', this);

        //set the field properties
        this.$nameInput.attr('placeholder', options.placeholder);

        this._initializeFromInputs();

        //whenever the input is loading, we need to the status indicator
        this.on('change:loading', $.proxy(function() {
            if(this._loading) {
                this.$statusIndicator.show();
            } else {
                this.$statusIndicator.hide();
            }
        }, this));

        //update the ID input when a value is selected
        this.on('change:selected', $.proxy(function() {
            var model = this.getSelected();
            if(model) {
                this.$idInput.val(model.Id);
            } else {
                this.$idInput.val('');
            }
        }, this));

        //update the name input when a value is selected
        this.on('change:selected', $.proxy(function() {
            var model = this.getSelected();
            if(model) {
                this.$nameInput.val(model.Name);
            } else {
                this.$nameInput.val('');
            }
        }, this));
    },

    clear: function() {
        this.set(null);
    },

    set: function(/*String|Object*/ model) {

        //convert the string argument to the a models
        if(isString(model)) {
            model = {Name: model};
        }

        this._selected = model;
        this.trigger('change:selected');
    },

    getSelected: function() {
        return this._selected;
    },

    getId: function() {
        var model = this.getSelected();
        return (model) ? model.Id : null;
    },

    render: function() {
        this.$nameInput.bind('autocompleteselect', $.proxy(this._onSelect, this));
        this.$nameInput.bind('autocompletechange', $.proxy(this._onAutocompleteChange, this));

        this.$nameInput
        	.attr('aria-expanded','false')
        	.attr('aria-activedescendant','')
        	.attr('aria-describedby','')
        	.attr('aria-haspopup','true')
        	.attr('aria-autocomplete','list')
        	.attr('role','combobox')
			.autocomplete({
            source: $.proxy(this._onLookup, this),
            minLength: this.minLength,
            delay: 0,
            focus: function(event, ui) {
	            $(this).attr('aria-activedescendant','selection-' + ui.item.Id);
            },
            open: function(event, ui) {
	            $(this).attr('aria-expanded','true');
            },
            close: function(event, ui) {
	            $(this).attr('aria-expanded','false').attr('aria-activedescendant','');
            },
            _renderItem: function(ul, item) {
                $(ul).attr('role','listbox');
    	        return $("<li>")
    	            .data("item.autocomplete", item)
    	            .attr('role','presentation')
    				//.append(itemPhoto)
    	            .append($("<a>").text(item.label).attr('role','option').attr('id','selection-' + item.Id))
    	            .appendTo(ul);
    		}
        })


    },

    setLoading: function(value) {
        var bool = !!value;
        if(this._loading !== bool) {
            this._loading = bool;
            this.trigger('change:loading');
        }
    },

    on: function() {
        return $.prototype.bind.apply($(this), arguments);
    },

    trigger: function() {
        return $.prototype.trigger.apply($(this), arguments);
    },

    $: function(selector) {
        return this.$container.find(selector);
    },

    _initializeFromInputs: function() {
        var name = this.$nameInput.val(),
            id = this.$idInput.val();

        //check to see if there are already values in the input
        if(name || id) {
            var model = {};

            if(name) {
                model.Name = name;
            }

            if(id) {
                model.Id = id;
            }

            this._selected = model;
        }
    },

    /**
     * Invoked by jQuery UI autocomplete when trying to find items with the entered search term
     */
    _onLookup: function(request, response) {
        var term = request.term;
        if(!term || term.length < this.minLength) {
            return;
        }

        var self = this;
        this._query({
            term: term,
            success: function(data) {
                response(data);
            },
            fail: function() {
                self._onError('Failed while executing query for autocomplete field');
            }
        });
    },

    /**
     * Executes the query with the given term.
     */
    _query: function(options) {
        var self = this;
        var load = this._startLoading();

        var always = function() {
            load.finish();
        };

        this.controller.getUsersWithNameLike({
            term: options.term,
            success: function(data) {
                always();

                //normalize the results returned so that they are usable by jquery autocomplete ui
                var results = map(data.results, function(result) {
                    return extend({
                        label: result.Name || result.Id,
                        value: result.Name || result.Id
                    }, result);
                });

                if(options.success) {
                    options.success(results);
                }
            },
            fail: function() {
                always();
                if(options.fail) {
                    options.fail.apply(this, arguments);
                }
            }
        });
    },

    /**
     * Invoked by jQuery UI autocomplete when an item is selected
     */
    _onSelect: function(event, ui) {
        var item = extend({}, ui.item);

        //remove the jquery specific properties
        delete item.value;
        delete item.label;

        this.set(item);
    },

    _onAutocompleteChange: function(event, ui) {
        //if the user selected an item, then the onSelect should have already been invoked
        if(ui.item) {
            return;
        }

        var name = this.$nameInput.val();
        if(!name) {
            this.clear();
            return;
        }

        this._query({
            term: name,
            success: $.proxy(function(results) {
                if(results.length === 0) {
                    this._onError('Nothing found with a name of ' + name);
                    this.clear();
                } if(results.length > 1) {
                    console.debug('name is not unique');
                    this.$nameInput.val(name);
                    this.$nameInput.autocomplete('search');
                } else {
                    var item = results[0];
                    this.set(item);
                }

            }, this),
            fail: $.proxy(function() {
                this._onError('Failed to find autocomplete match');
            }, this)
        });
    },

    _onError: function(attributes) {
        console.log(attributes.messages);
    },

    _nextLoadId: 0,
    _loads: {},
    _startLoading: function() {
        var loadId = this._nextLoadId++;
        var load = {
            id: loadId,
            finish: $.proxy(function() {
                this._endLoading(load);
            }, this)
        };
        var currentlyLoading = !isEmpty(this._loads);
        this._loads[loadId] = load;
        if(!currentlyLoading) {
            this.setLoading(true);
        }
        return load;
    },
    _endLoading: function(load) {
        delete this._loads[load.id];
        if(isEmpty(this._loads)) {
            this.setLoading(false);
        }
    }
};
RichAutoCompleteComponent.extend = function(protoProps) {
    var parent = this;
    var child = function() {
        parent.apply(this, arguments);
    };

    extend(child, parent);

    var Surrogate = function() {
        this.constructor = child;
    };
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate();

    extend(child.prototype, protoProps);
    return child;
};
root.RichAutoCompleteComponent = RichAutoCompleteComponent;

var RichUserLookupComponent = RichAutoCompleteComponent.extend({
    initialize: function(options) {
        RichAutoCompleteComponent.prototype.initialize.apply(this, arguments);
        this.$profileImage = this.$('.gusRichAutoCompleteProfileImage');
        this.$profileImageUrlInput = this.$('.gusRichAutoCompleteProfileImageUrlInput');

        //initialize the profile image from the input
        if(this.$profileImageUrlInput.val() && this._selected) {
            this._selected.SmallPhotoUrl = this.$profileImageUrlInput.val();
            this.updatePhoto();
        }

        this.on('change:selected', $.proxy(this.updatePhoto, this));
    },
    updatePhoto: function() {
        var model = this.getSelected();

        var photoUrl;
        if(model && model.SmallPhotoUrl) {
            photoUrl = model.SmallPhotoUrl;
        }
        photoUrl = photoUrl || '/profilephoto/005/F';

        //set the image's source
        this.$profileImage.attr('src', photoUrl);

        //update the URL hidden input
        this.$profileImageUrlInput.val(photoUrl);

        //set the image's title
        this.$profileImage.attr('title', (model && model.Name) ? model.Name : '');
    }
});
root.RichUserLookupComponent = RichUserLookupComponent;

}).call(this, gus, this.$);


/* Tabs */
function selectTab(tab, tabSetId) {
	$('div.gusTabs').find('>ul>li').removeClass('on');
	$('div.gusTabs').find('>ul>li[data-tab=' + tab + ']').addClass('on');
	$('div.gusTabs').find('.gusTabPanelActive,.gusTabPanelInactive').hide();
	$('#tab-' + tab).show();
	setTabInCookie(tab, tabSetId);
}

function getTabFromCookie(name) {
  var parts = document.cookie.split(name + "=");
  if (parts.length == 2) return parts.pop().split(";").shift();
}

function setTabInCookie(name, tabSetId) {
	document.cookie='selected-tab-' + tabSetId + '=' + name + ';expires=0;path=/;';
}

if (this.$) {
	$(document).ready(function() {
		var tabSetId = $('div.gusTabs').data('tabsetid');

		/* tab init */
		if ($('div.gusTabs') && tabSetId) {
			var selectedTab = getTabFromCookie('selected-tab-' + tabSetId);
			if (!selectedTab || $('div.gusTabs').find('>ul>li[data-tab=' + selectedTab + ']').length === 0) {
				selectedTab = $('div.gusTabs > ul > li:first-child').data('tab');
			}

			selectTab(selectedTab, tabSetId);

			$('div.gusTabs').find('>ul>li').click(function(event) {
				event.preventDefault();
				selectTab($(this).data('tab'), tabSetId);
			});
		}

		/* tooltips */
		if($.ui && $().tooltip) {
			$('.gusFormHelpText').tooltip();
		}

	});
}

function callNoConflict(){
    //Checking jquery version is not the one we want, if not call noConflict.
    if($().jquery != '1.8.3'){
        $.noConflict(true);
    }
}

function isRunningInSFX(){
    var runningInSFX = false;
    if ((typeof sforce == 'undefined') || (sforce == null) ) {
        runningInSFX = false;
    }
    else{
        runningInSFX = true;
    }
    return runningInSFX;
}

function checkAndNavigateToURL(url){
    if(isRunningInSFX()){//Checking if it is running in SFX
        sforce.one.navigateToURL(url);
    }
    else{
         window.location.href = url;
    }
 }

 function checkAndNavigateToID(id, isEdit){
    if(isRunningInSFX()){//Checking if it is running in SFX
            if(isEdit){
                sforce.one.editRecord(id);
            }
            else{
                sforce.one.navigateToSObject(id);
            }
    }
    else{
        if(isEdit){
            window.location.href = '/'+id+'/e';
        }
        else{
            window.location.href = '/'+id;
        }
    }
 }

if (this.$) {
	$(function() {

		// SLDS v0.4.2 tabs
		$('.slds-tabs > .slds-tabs--default__nav > .slds-tabs__item > a').on('click', function() {
			// inactive tabs
			$(this).closest('.slds-tabs--default__nav').find('.slds-tabs__item').removeClass('slds-active');
			$(this).closest('.slds-tabs--default__nav').find('.slds-tabs__item > a').removeClass('slds-active').attr('aria-selected','false');
			// active tab
			$(this).closest('.slds-tabs__item').addClass('slds-active');
			$(this).addClass('slds-active').attr('aria-selected','true');
			// inactive panels
			$(this).closest('.slds-tabs').find('.slds-tabs__content').removeClass('slds-show').addClass('slds-hide');
			// active panel
			if ($(this).closest('.slds-tabs__item').attr('data-tabpanel')) {
				$('#' + $(this).closest('.slds-tabs__item').attr('data-tabpanel')).addClass('slds-show').removeClass('slds-hide');
			}
		});

		// SLDS v0.5.2 tabs
		$('.slds-tabs--default .slds-tabs__item > a').on('click', function(e) {
			e.preventDefault();
			// inactive tabs
			$(this).closest('ul').find('li').removeClass('slds-active').removeAttr('role');
			$(this).attr('aria-selected','false').attr('tabindex','-1');
			// active tab
			$(this).closest('li').addClass('slds-active').attr('role','presentation');
			$(this).attr('aria-selected','true').attr('tabindex','0');
			// inactive panels
			$(this).closest('.slds-tabs--default').find('.slds-tabs__content').removeClass('slds-show').addClass('slds-hide');
			// active panel
			if ($(this).closest('li').attr('data-tabpanel')) {
				$('#' + $(this).closest('li').attr('data-tabpanel')).addClass('slds-show').removeClass('slds-hide');
			}
		});

	});
}
