// Constants
var MIN_HASH_KEY_SIZE = 8;
var MAX_KEY_BUILDER_THREADS = 10;
var MAX_CONSECUTIVE_ERRORS = 10;
var SFORCE_TIMEOUT = 300 * 1000; // timeout in milliseconds.
var DELAY_BETWEEN_REMOTING_CALLS = 50; // Minimum delay between Javascript
										// remoting calls in milliseconds.

// JS Globals
var j$ = jQuery.noConflict();
var existingKeysCount = 0, keysDeleted = 0, recordCount = 0, currIndex = 0, pendingCalls = 0, totalKeys = 0, builtKeys = 0, currScenarioIndex = 0, currBuildIds = null, buildStarted = null, cacheStarted = null, deleteStarted = null, keyBuilderStarted = new Date();
var cancelled = false, deleteKeysDone = false, scenariosLoaded = false, objectCached = false, caching = false, buildingKeys = false, hashKeyBitsSet = false, stopBuildTimer = false, markScenariosBuiltPending = false, finishPending = false;
var scenariosByType = {}, objectTypes = new Array(), countTypes = new Array(), objectIds, currObject = '', countingObject = '', currScenarios, currScenarioIds;
var buildQueue = new Array();
var beingBuilt = new Object();
var scenarioIdsArray = new Array();
var objectCounts = new Object();
var consecutiveErrors = 0;

j$(document).ready(startKeyBuilder);
sforce.connection.sessionId = __sfdcSessionId;
sforce.connection.batchSize = 2000;
sforce.connection.defaultNamespace = apexNamespace;
sforce.connection.updateMru = false;
sforce.apex.defaultNamespace = apexNamespace;
j$("#deleteProgress").progressbar(0);
j$("#cacheProgress").progressbar(0);
j$("#buildProgress").progressbar(0);

function startKeyBuilder() {
	// If DupeBlocker is disabled, exit.
	if (dbDisabled == true)
		return;

	// Use the batch key builder if needed.
	if ( useBatchKeyBuilder )
	{
		if ( !isBatchRunning )
			startBatchKeyBuilder();
		
		updateBatchProgressBars();
		return;
	}

	// Prevent us from leaving during the build process.
	j$(window).bind('beforeunload', showUnloadPrompt);
	j$(window).bind('unload', processUnload);

	// Check the license.
	controller.checkLicense(validateLicense);

	setStatus('Counting existing matching keys.');
	controller.getScenarios(scenarioIds, handleScenarios);
	// Get our keys count via a web service call using @readonly to get around
	// governor limits.

	var query = 'SELECT Count() FROM ' + apexNamespace + '__Scenario_Key__c';
	if ( scenarioIds != null && scenarioIds.length > 0 )
	{
		var splitIds = scenarioIds.split( ',' );
		query += ' WHERE ' + apexNamespace + '__ScenarioID__c IN (';
		for ( var x = 0; x < splitIds.length; x++ )
		{
			if ( x == 0 )
				query += '\'' + convertId15toId18( splitIds[x] ) + '\'';
			else
				query += ',\'' + convertId15toId18( splitIds[x] ) + '\'';
		}
		query += ')';
	}

	sforce.connection.query(query, {
		onSuccess : handleKeysCount,
		onFailure : handleKeysCountError,
		timeout : SFORCE_TIMEOUT
	});
}

function updateBatchProgressBars()
{
	// Update progress bars.
	j$( ".batchProgressBar" ).each( function(){
			var curVal = j$( this ).attr( "data-value" );
			var curMax = j$( this ).attr( "data-max" );
			var progress = Math.ceil( curVal / curMax * 100 );
			j$( this ).progressbar( {value: progress} );
		});
}

function convertId15toId18(shortId) {
	// If the Id is already 18 characters, return it.
	if (shortId == null || shortId.trim().length == 0
			|| shortId.trim().length == 18)
		return (shortId == null ? shortId : shortId.trim());

	var chunks = new Array();
	chunks[0] = shortId.substr(0, 5);
	chunks[1] = shortId.substr(5, 5);
	chunks[2] = shortId.substr(10, 5);
	var bits = 0;
	var extra = '';

	for ( var i = 0; i < 3; i++ )
	{
		var chunk = chunks[i];
		bits = 0;
		for (j in chunk)
		{
			if (chunk[j] <= 'Z' && chunk[j] >= 'A')
			{
				bits += Math.pow(2, j);
			}
		}
		if (bits < 26)
		{
			extra += String.fromCharCode('A'.charCodeAt(0) + bits);
		} else {
			extra += String.fromCharCode('0'.charCodeAt(0) + (bits - 26));
		}
	}
	return shortId + extra;
}

// Check the license to ensure it's valid.
function validateLicense(result, event) {
	// Check for errors.
	if (!event.status) {
		errorAbort(event.message, 'ValidateLicense() Error');
		return;
	}

	// Check for failure.
	if (result.toLowerCase().indexOf("failure") >= 0) {
		cancelled = true;
		j$("#cancelButton").attr("disabled", true);
		var splitString = result.split("|", 2);
		errorAbort(splitString[1], "DupeBlocker License Validation Failed.");
		return;
	}

	// Do nothing if the license is valid, let the process continue.
}

function handleKeysCount(result) {
	existingKeysCount = Number(result.size);
	j$("#deleteTotal").html(existingKeysCount);
	if (existingKeysCount > 0) {
		setStatus('Deleting ' + existingKeysCount + ' old keys.');
		deleteStarted = new Date();
		// Start deleting old keys.
		controller.deleteKeys(scenarioIds, handleDeleteKeysResult);
	} else {
		deleteKeysDone = true;
		updateDeleteProgress();
		// If we're done caching the Ids, start key building.
		if (objectCached && hashKeyBitsSet) {
			buildStarted = new Date();
			buildKeys();
		}
	}
}

function handleKeysCountError(error) {
	errorAbort(String(error), 'HandleKeysCount() Error');
}

function handleScenarios(result, event) {
	// Check for errors.
	if (!event.status) {
		errorAbort(event.message, 'HandleScenarios() Error');
		return;
	}

	// Process our array list and convert it to an array of scenario lists keyed
	// by
	// scenario type.
	for ( var x = 0; x < result.length; x++) {
		var scenarioType = result[x][apexNamespace + '__Scenario_Type__c']
				.toLowerCase();
		scenarioIdsArray.push(result[x].Id);

		// If this is a lead to X scenario it needs to be added to both Lead and
		// the target object (account/contact) lists.
		// Otherwise, just add it to the bucket for the scenario type.
		if (scenarioType == 'lead to account') {
			categorizeScenario(result[x], 'lead');
			categorizeScenario(result[x], 'account');
		} else if (scenarioType == 'lead to contact') {
			categorizeScenario(result[x], 'lead');
			categorizeScenario(result[x], 'contact');
		} else
			categorizeScenario(result[x], scenarioType);
	}

	scenariosLoaded = true;
	
	// Mark the scenarios as needing to be rebuilt.
	controller.markScenariosRebuildNeeded(scenarioIdsArray,
			function(result, event) {
				markScenariosRebuildNeededResultHandler(result, event,
						scenarioIds);
			});

	// Count all objects.
	countTypes = objectTypes.slice(0);
	countNextObject();
}

function countNextObject() {
	if ( countTypes.length > 0 ) {
		countingObject = countTypes.pop();
		setStatus('Getting ' + countingObject + ' count.');

		// Count our current object.
		var query = 'SELECT Count() FROM ' + countingObject;
		if (countingObject.toLowerCase() == 'lead')
			query += ' WHERE IsConverted = false';

		sforce.connection.query(query, {
			onSuccess : handleRecordCount,
			onFailure : handleRecordCountError,
			timeout : SFORCE_TIMEOUT
		});
	} else
		// Start processing the first object, caching will begin
		// while deletion is going on but key building won't
		// start until deletion is done.
		processNextObject();
}

function handleRecordCount(result) {
	objectCounts[countingObject] = Number(result.size);
	countNextObject();
}

function handleRecordCountError(error) {
	errorAbort(String(error), 'HandleRecordCount() Error');
}

function categorizeScenario(scenario, objectType) {
	var currArray = scenariosByType[objectType.toLowerCase()];
	if (currArray != null) {
		currArray.push(scenario);
	} else {
		currArray = new Array();
		currArray.push(scenario);
		scenariosByType[objectType.toLowerCase()] = currArray;
		if (objectType.toLowerCase() == 'lead')
			objectTypes.unshift(objectType.toLowerCase());
		else
			objectTypes.push(objectType.toLowerCase());
	}
}

function handleDeleteKeysResult(result, event) {
	// Handle cancellations.
	if (cancelled) {
		doCancelled();
		return;
	}

	if (!event.status) {
		errorAbort(event.message, 'HandleDeleteKeysResult() Error');
		return;
	}

	if (result > 0) {
		keysDeleted += Number(result);
		updateDeleteProgress();
	}

	if (result == DELETE_BATCH_SIZE)
		controller.deleteKeys(scenarioIds, handleDeleteKeysResult);
	else {
		deleteKeysDone = true;
		updateDeleteProgress();
		setStatus('Done deleting old keys.');
		// If we're done caching the Ids, start key building.
		if (objectCached && hashKeyBitsSet) {
			buildStarted = new Date();
			buildKeys();
		}
	}
}

function processNextObject() {
	// Reset our cached object flag.
	objectCached = false;
	// Clear the cache.
	objectIds = new Array();
	// Our hash key bits aren't set yet.
	hashKeyBitsSet = false;
	// Clear our currIndex value for key building.
	currIndex = 0;
	builtKeys = 0;
	currScenarioIndex = 0;
	currBuildIds = null;
	// Switch to the next object if we have another.
	if (objectTypes.length > 0) {
		currObject = objectTypes.pop();
		// Start caching the next object.
		caching = true;
		// Reset our cache & build counts.
		resetCacheAndBuildProgress();
		// Get our current scenarios for this object type.
		currScenarios = scenariosByType[currObject];
		// Load our currScenarioIds array.
		currScenarioIds = new Array();
		for ( var x = 0; x < currScenarios.length; x++)
			currScenarioIds.push(currScenarios[x].Id);
		recordCount = objectCounts[currObject];
		totalKeys = recordCount * currScenarios.length;
		j$("#cacheTotal").html(recordCount);
		j$("#buildTotal").html(totalKeys);

		if (recordCount == 0)
		{
			processNextObject();
		} else {
			setHashKeyBits();
			cacheIds();
		}
	} else
		finishKeyBuilding();
}

// Calculate the hash key bits needed for this object based on it's record
// count.
// If it's changed from what the scenario is currently set to, update the
// scenario.
function setHashKeyBits() {
	var updateScenarioIds = new Array();
	var keySizes = new Array();

	// Loop through our scenarios. If the scneario doesn't have the hash key
	// calculation disabled
	// and our key size has changed, add it to the array of scenarios that need
	// to be updated
	// with a new key size.
	for ( var x = 0; x < currScenarios.length; x++) {
		var keySize = MIN_HASH_KEY_SIZE;
		var totalRecords = 0;
		
		if ( currScenarios[x][apexNamespace + '__Scenario_Type__c'].toLowerCase() == 'lead to account' )
			totalRecords = objectCounts['lead'] + objectCounts['account'];
		else if ( currScenarios[x][apexNamespace + '__Scenario_Type__c'].toLowerCase() == 'lead to contact' )
			totalRecords = objectCounts['lead'] + objectCounts['contact'];
		else
			totalRecords = recordCount;

		// Calculate our key size by increasing it one bit a time until
		// 2^keysize is greater than recordCount / 20.
		while (Math.pow(2, keySize) < totalRecords / 20) {
			keySize++;
		}
		
		if (Boolean(currScenarios[x][apexNamespace
				+ '__Disable_Hash_Calculation__c']) == false
				&& Number(currScenarios[x][apexNamespace + '__Hash_Key_Bits__c']) != keySize)
		{
			updateScenarioIds.push(currScenarios[x].Id);
			keySizes.push(keySize);
		}
	}

	// If we have any scenarios to update, do so. If not, move on to building
	// keys if
	// we're done deleting old keys and caching.
	if (updateScenarioIds.length > 0)
		controller.setScenariosKeySize(keySizes, updateScenarioIds,
				handleSetScenariosKeySizeResult);
	else {
		hashKeyBitsSet = true;
		// If caching is complete and keys are deleted, build keys.
		if (objectCached && deleteKeysDone)
			buildKeys();
	}
}

function handleSetScenariosKeySizeResult(result, event) {
	// Handle cancellations.
	if (cancelled) {
		doCancelled();
		return;
	}

	if (!event.status) {
		errorAbort(event.message, 'HandleSetScenariosKeySizeResult() Error');
		return;
	}

	hashKeyBitsSet = true;

	// If caching is complete and keys are deleted, build keys.
	if (objectCached && deleteKeysDone)
		buildKeys();
}

function cacheIds() {
	// Handle cancellations.
	if (cancelled) {
		doCancelled();
		return;
	}

	caching = true;
	cacheStarted = new Date();

	var query = 'SELECT Id FROM ' + currObject;
	if (currObject.toLowerCase() == 'lead')
		query += ' WHERE IsConverted = false';

	sforce.connection.query(query, {
		onSuccess : cacheIdResults,
		onFailure : handleCacheQueryError,
		timeout : SFORCE_TIMEOUT
	});
}

function cacheIdResults(result) {
	// Handle cancellations.
	if (cancelled) {
		doCancelled();
		return;
	}

	var records = result.getArray('records');

	for ( var x = 0; x < records.length; x++)
		objectIds.push(String(records[x].Id));

	updateCacheProgress();

	if (result.queryLocator)
		sforce.connection.queryMore(result.queryLocator, {
			onSuccess : cacheIdResults,
			onFailure : handleCacheQueryError,
			timeout : SFORCE_TIMEOUT
		});
	else
		finishedCaching();
}

function handleCacheQueryError(error) {
	errorAbort(String(error), 'CacheIdResults() Error');
}

function finishedCaching() {
	objectCached = true;
	caching = false;

	updateCacheProgress();
	setStatus('Done caching ' + recordCount + ' ' + currObject + 's.');

	// Start building keys if our keys are deleted.
	if (deleteKeysDone && hashKeyBitsSet) {
		buildStarted = new Date();
		buildKeys();
	}
}

/*
 * function buildKeys() { // Handle cancellations. if ( cancelled ) {
 * doCancelled(); return; }
 *  // Start building keys simultaneously for all scenarios. while (
 * pendingCalls < MAX_KEY_BUILDER_THREADS ) { // If we're on the first scenario
 * in the list, get our next batch of Ids to build. if ( currScenarioIndex == 0 ) {
 * if ( currIndex + batchSize >= objectIds.length ) { currBuildIds =
 * objectIds.slice( currIndex ); currIndex = objectIds.length; } else {
 * currBuildIds = objectIds.slice( currIndex, currIndex + batchSize ); currIndex +=
 * batchSize; } }
 *  // Make our build keys call and increment our pending calls counter to track
 * how many // calls are currently occuring. pendingCalls++; var args = {
 * scenarioId: currScenarios[currScenarioIndex].Id, idArray: currBuildIds,
 * objectType: currObject }; sforce.apex.execute( apexNamespace +
 * '.DB_WebServices', 'rebuildKeys', args, { onSuccess: handleBuildKeysResult,
 * onFailure: function(error){ handleBuildKeysError(error, args) }, timeout:
 * SFORCE_TIMEOUT } );
 *  // Increment our scenarioIndex or reset to 0 if we're on the last scenario.
 * if ( currScenarioIndex == currScenarios.length - 1 ) { // We just finished
 * the last scenario. If our currIndex is >= the length of the objectIds list
 * then exit, we're done with this // object's keys. if ( currIndex >=
 * objectIds.length ) return; currScenarioIndex = 0; } else currScenarioIndex++; } }
 */

function buildKeys() {
	// Handle cancellations.
	if (cancelled) {
		doCancelled();
		return;
	}

	setStatus('Building keys for object: ' + currObject);

	// Start building keys simultaneously for all scenarios.
	while (pendingCalls < MAX_KEY_BUILDER_THREADS) {
		var currScenarioId = currScenarios[currScenarioIndex].Id;

		// If our current scenario is still being built, wait for it to complete
		// before continuing.
		if (beingBuilt[currScenarioId] == true)
			break;

		// If we're on the first scenario in the list, get our next batch of Ids
		// to build.
		if (currScenarioIndex == 0) {
			if (currIndex + batchSize >= objectIds.length) {
				currBuildIds = objectIds.slice(currIndex);
				currIndex = objectIds.length;
			} else {
				currBuildIds = objectIds
						.slice(currIndex, currIndex + batchSize);
				currIndex += batchSize;
			}
		}

		// Queue a set of keys to be built by our build timer.
		buildQueue.unshift({
			scenarioId : currScenarioId,
			idArray : currBuildIds.slice(0),
			objectName : currObject
		});

		// Track how many calls are currently pending.
		pendingCalls++;
		// Mark this scenario as being built.
		beingBuilt[currScenarioId] = true;

		// If our queue now has only one item in it, start our building timer.
		if (buildQueue.length == 1)
			setTimeout(buildKeysDelayed, DELAY_BETWEEN_REMOTING_CALLS);

		// Increment our scenarioIndex or reset to 0 if we're on the last
		// scenario.
		if (currScenarioIndex == currScenarios.length - 1) {
			// We just finished the last scenario. If our currIndex is >= the
			// length of the objectIds list then exit, we're done with this
			// object's keys.
			if (currIndex >= objectIds.length)
				return;
			currScenarioIndex = 0;
		} else
			currScenarioIndex++;
	}
}

function buildKeysDelayed() {
	// If we have nothing in our build queue, exit.
	if (buildQueue == null || buildQueue.length == 0)
		return;

	// Get the oldest queued params for key building.
	var currParams = buildQueue.pop();
	// Execute our remoting call.
	// controller.buildKeys( currParams.scenarioId, currParams.idArray,
	// currParams.objectName, handleBuildKeysResult, {timeout: 2} );
	Visualforce.remoting.Manager.invokeAction(apexNamespace
			+ '.DB_KeyBuilderController.buildKeys', currParams.scenarioId,
			currParams.idArray, currParams.objectName, function(result, event) {
				handleBuildKeysResult(result, event, currParams);
			});

	// If we have more parameters, queue this method to execute again after a
	// delay.
	if (buildQueue.length > 0)
		setTimeout(buildKeysDelayed, DELAY_BETWEEN_REMOTING_CALLS);
}

function handleBuildKeysResult(result, event, args) {
	pendingCalls--;

	// Handle cancellations.
	if (cancelled) {
		if (pendingCalls == 0)
			doCancelled();
		return;
	}

	// Check for errors and retry if consecutiveErrors < MAX_CONSECUTIVE_ERRORS
	if (!event.status) {
		consecutiveErrors++;
		if (consecutiveErrors < MAX_CONSECUTIVE_ERRORS)
		{
			// Retry building this batch.
			// Queue a set of keys to be built by our build timer.
			buildQueue.unshift(args);
			pendingCalls++;
			// Mark this scenario as being built.
			beingBuilt[args.scenarioId] = true;

			// If our queue now has only one item in it, start our building timer.
			if (buildQueue.length == 1)
				setTimeout(buildKeysDelayed, DELAY_BETWEEN_REMOTING_CALLS);
		}
		else
			errorAbort(event.message, 'Error Building Keys');
		return;
	}
	
	// Reset consecutive errors.
	consecutiveErrors = 0;

	// Mark the scenario as not currently being built.
	beingBuilt[args.scenarioId] = false;

	// The result is the number of records that keys were built for.
	builtKeys += Number(args.idArray.length);
	updateBuildProgress();

	// If our pendingCalls are 0 and our currentIndex is >= our recordCount then
	// we're done with this object.
	// Otherwise, continue building keys.
	if (pendingCalls == 0 && currIndex >= objectIds.length) {
		// We've finished building keys for this object, mark the scenarios as
		// built, then move on to the next object.
		setStatus('Done building keys for object: ' + args.objectName);
		var markScenarioIds = new Array();
		for (var x = 0; x < currScenarios.length; x++) {
			if (currObject.toLowerCase() == 'lead' ||
				currScenarios[x][apexNamespace + '__Scenario_Type__c'].toLowerCase().indexOf( 'lead to ' ) < 0)
				markScenarioIds.push(currScenarios[x].Id)
		}
		if (markScenarioIds.length > 0)
			markScenariosBuilt(markScenarioIds);
		processNextObject();
	} else
		buildKeys();
}

function markScenariosBuilt(scenarioIds) {
	markScenariosBuiltPending = true;
	// Execute our remoting call.
	Visualforce.remoting.Manager.invokeAction(apexNamespace
			+ '.DB_KeyBuilderController.markScenariosBuilt', scenarioIds,
			function(result, event) {
				handleMarkScenariosBuiltResult(result, event, scenarioIds);
			});
}

function handleMarkScenariosBuiltResult(result, event, scenarioIds) {
	markScenariosBuiltPending = false;

	// Check for errors.
	if (!event.status) {
		errorAbort(event.message, 'Error Marking Scenarios as Built');
		return;
	}

	// If the key building process was just waiting on this call to
	// return, call finishKeyBuilding.
	if (finishPending)
		finishKeyBuilding();
}

function markScenariosRebuildNeededResultHandler(result, event, scenarioIds) {
	// Check for errors.
	if (!event.status) {
		errorAbort(event.message, 'Error Setting Scenarios Rebuild Flag');
		return;
	}
}

function handleBuildKeysError(error, context) {
	cancelled = true;
	// throw 'Generic exception to catch.';
	errorAbort(String(error), 'HandleBuildKeysResult() Error');
}

function finishKeyBuilding() {
	finishPending = true;
	// If we haven't gotten our response to the markScenariosBuilt call then
	// wait for it to return.
	// The return handler will call finishKeyBuilding() if finishPending is
	// true.
	if (markScenariosBuiltPending == true)
		return;
	// Remove the warning for leaving this page and early unload processing.
	j$(window).unbind('beforeunload');
	j$(window).unbind('unload');
	var currentTime = new Date();
	var timeDiff = currentTime.getTime() - keyBuilderStarted.getTime();
	var duration = secondsToTimeString(Math.round(timeDiff / 1000));
	j$('#dialog-Message').attr('title', 'Key Building Completed');
	j$('#dialog-Message').html('Finished building keys in ' + duration + '.');
	j$('#dialog-Message').dialog({
		modal : true,
		buttons : {
			Ok : function() {
				j$(this).dialog('close');
				quit();
			}
		}
	});
}

function errorAbort(message, title, execFunc) {
	if (!title)
		title = 'Key Builder Error';
	if (!execFunc)
		execFunc = quit;
	cancelled = true;
	setStatus('Key building aborted due to an error: ' + message);
	j$('#dialog-errorMessage').attr('title', title);
	j$('#dialog-errorMessage').html(message);
	j$('#dialog-errorMessage').dialog({
		modal : true,
		buttons : {
			Ok : function() {
				j$(this).dialog('close');
				if (execFunc)
					execFunc();
			}
		}
	});
}

function quit() {
	// Remove the warning for leaving this page and early unload processing.
	j$(window).unbind('beforeunload');
	j$(window).unbind('unload');
	// Go to our return URL.
	window.location.href = redirUrl;
}

function doCancelled() {
	errorAbort('Process cancelled.', 'Key Building Cancelled');
}

function cancelKeyBuilding() {
	j$('#cancelButton').attr('disabled', 'true');
	cancelled = true;
	setStatus('Cancelling key building.');

	// Prevent form submission.
	return false;
}

function setStatus(message) {
	try {
		j$('#status').html(message);
	} catch (ex) {
		// Ignore the error, status updates aren't important enough to abort key
		// building.
		// Log the error to the console for debugging.
		if (console && console.log)
			console.log('setStatus() exception: ' + ex.toString());
	}
}

function resetCacheAndBuildProgress() {
	try {
		j$("#cacheObject").html(currObject);
		j$("#cachedCounter").html("0");
		j$("#cacheTotal").html("unknown");
		j$("#cacheProgress").progressbar("value", 0);
		j$("#buildObject").html(currObject);
		j$("#builtCounter").html("0");
		j$("#buildTotal").html("unknown");
		j$("#buildProgress").progressbar("value", 0);
	} catch (ex) {
		// Ignore the error, progress updates aren't important enough to abort
		// key building.
		// Log the error to the console for debugging.
		if (console && console.log)
			console.log('resetCacheAndBuildProgress() exception: '
					+ ex.toString());
	}
}

function updateDeleteProgress() {
	try {
		var progress;
		if (keysDeleted < existingKeysCount)
			progress = Math.min(Math
					.ceil(keysDeleted / existingKeysCount * 100));
		else
			progress = 100;
		j$("#deletedCounter").html(keysDeleted);
		j$("#deleteProgress").progressbar("value", progress);
		if (progress == 100)
			j$("#deleteEta").html("Done");
		else if (keysDeleted > 0)
			j$("#deleteEta")
					.html(
							calculateEta(deleteStarted, keysDeleted,
									existingKeysCount));
	} catch (ex) {
		// Do nothing for a progress update error, don't let this abort the key
		// build, it's not
		// important.
		// Log the error to the console for debugging.
		if (console && console.log)
			console.log('updateDeleteProgress() exception: ' + ex.toString());
	}
}

function updateCacheProgress() {
	try {
		var progress;
		if (objectIds.length < recordCount)
			progress = Math.min(100, Math.ceil(objectIds.length / recordCount
					* 100));
		else
			progress = 100;
		j$("#cachedCounter").html(objectIds.length);
		j$("#cacheProgress").progressbar("value", progress);
		if (progress == 100)
			j$("#cacheEta").html("Done");
		else if (objectIds.length > 0)
			j$("#cacheEta").html(
					calculateEta(cacheStarted, objectIds.length, recordCount));
	} catch (ex) {
		// Do nothing for a progress update error, don't let this abort the key
		// build, it's not
		// important.
		// Log the error to the console for debugging.
		if (console && console.log)
			console.log('updateCacheProgress() exception: ' + ex.toString());
	}
}

function updateBuildProgress() {
	try {
		var progress;
		if ( builtKeys > totalKeys )
			builtKeys = totalKeys;
		progress = Math.ceil(builtKeys / totalKeys * 100);
		j$("#builtCounter").html(builtKeys);
		j$("#buildProgress").progressbar("value", progress);
		if (progress == 100)
			j$("#buildEta").html("Done");
		else if (builtKeys > 0)
			j$("#buildEta").html(
					calculateEta(buildStarted, builtKeys, totalKeys));
	} catch (ex) {
		// Do nothing for a progress update error, don't let this abort the key
		// build, it's not
		// important.
		// Log the error to the console for debugging.
		if (console && console.log)
			console.log('updateBuildProgress() exception: ' + ex.toString());
	}
}

function calculateEta(startTime, recordsDone, totalRecords) {
	try {
		var currentTime = new Date();
		var timeDiff = currentTime.getTime() - startTime.getTime();
		var etaTotalSeconds = Math.round((totalRecords - recordsDone)
				* (timeDiff / recordsDone) / 1000);
		return secondsToTimeString(etaTotalSeconds);
	} catch (ex) {
		// Do nothing for a progress update error, don't let this abort the key
		// build, it's not
		// important.
		// Log the error to the console for debugging.
		if (console && console.log)
			console.log('calculateEta() exception: ' + ex.toString());
	}
}

function secondsToTimeString(inSeconds) {
	var seconds = inSeconds % 60;
	var minutes = Math.floor(inSeconds / 60) % 60;
	var hours = Math.floor(inSeconds / (60 * 60)) % 24;
	var days = Math.floor(inSeconds / (24 * 60 * 60));
	var timeString = pad(minutes, 2) + ":" + pad(seconds, 2);
	if (days > 0)
		timeString = String(days) + ":" + pad(hours, 2) + ":" + timeString;
	else if (hours > 0)
		timeString = pad(hours, 2) + ":" + timeString;
	return timeString;
}

function pad(number, length) {
	var result = String(number);
	while (result.length < length) {
		result = '0' + result;
	}

	return result;
}

function showUnloadPrompt() {
	return 'If you leave or refresh this page key building will be ABORTED.';
}

function processUnload() {
	cancelled = true;
	setStatus('Leaving page befeore building complete.');
}
