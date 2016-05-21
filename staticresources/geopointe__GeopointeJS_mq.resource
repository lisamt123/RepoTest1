//Info about the jQuery Tabs
var gp_JQTabs = {
	"mapDataSets": 0,
	"search": 1,
	"layers": 2, // will be removed in code
	"manualEntry": 2,
	"currentRoute": 3,
	"mySettings": 4
}

var gp_map; // holds the MQA.TileMap
//var gp_routeResultsData; // Holds route result data
//var gp_routeRequestLocs; // Holds the route request locations
var gp_markerIdClicked; //Keeps track of the map poi that was clicked when in record selection mode

var gp_shapeCollectionsArchive; // holds the MQA shape collections so they can be removed in ROUTE mode and added back in SEARCH mode

// Constructs a Map
function gp_mapConstructor(jsAction){
	
	var thisMC = jsAction.mapConstructor;
	
	// Fix up the thisMC object as needed
	thisMC.startingZoom = 2; // 2 on MQv7, 1 on MQv6
	if (typeof(eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Zoom__c')) != 'undefined'){
		if (eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Zoom__c') != "") {
			thisMC.startingZoom = eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Zoom__c');
		}
	}
	
	thisMC.startingLat = 0;
	if (typeof(eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Lat__c')) != 'undefined'){
		if (eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Lat__c') != "") {
			thisMC.startingLat = eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Lat__c');
		}
	}
	
	thisMC.startingLng = 0;
	if (typeof(eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Lng__c')) != 'undefined'){
		if (eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Lng__c') != "") {
			thisMC.startingLng = eval('gp_userSettings.settings__c.' + gp_orgSettings.fieldPrefix + 'Starting_Lng__c');
		}
	}
	
	thisMC.width = jQuery("#mapWrapper").width();

	if (thisMC.height == "") { thisMC.height = 600;}
	
	if (thisMC.centerLat == null || thisMC.centerLat == ''){
		thisMC.centerLat = thisMC.startingLat;
	}
	
	if (thisMC.centerLng == null || thisMC.centerLng == ''){
		thisMC.centerLng = thisMC.startingLng;
	}
	
	if (thisMC.centerZoom == null || thisMC.centerZoom == ''){
		thisMC.centerZoom = thisMC.startingZoom;
	}
	
	// Map Options
	//Determine map type
	var savedMapTypeId = gp_userSettings.settings__c[gp_orgSettings.fieldPrefix + 'Map_Type__c'];
	var mqMapTypeId = 'map';
	if(savedMapTypeId == 'map' || savedMapTypeId == 'OSM' || savedMapTypeId == 'roadmap'){
		mqMapTypeId = 'map';
	}else if(savedMapTypeId == 'sat' || savedMapTypeId == 'satellite'){
		mqMapTypeId = 'sat';
		jQuery('.mapControlTab').addClass('mapControlDarkShadow');
		jQuery('.mapControlContent').addClass('mapControlContentDarkShadow');
		showWhiteSettingsHelp();
	}else if(savedMapTypeId == 'hyb' || savedMapTypeId == 'hybrid'){
		mqMapTypeId = 'hyb';
		jQuery('.mapControlTab').addClass('mapControlDarkShadow');
		jQuery('.mapControlContent').addClass('mapControlContentDarkShadow');
		showWhiteSettingsHelp();
	}

	var mapoptions ={
					elt:document.getElementById('mapDIV'),
					zoom: thisMC.startingZoom,
					latLng: {lat: thisMC.startingLat, lng: thisMC.startingLng},
					mtype: mqMapTypeId,
					bestFitMargin:0,
					//useRightClick:true,
					zoomOnDoubleClick:true
					};
	
	// New Map Object
	if (thisMC.newMap){
		gp_map = null;
		jQuery('#mapDIV').html(''); 
		gp_map = new MQA.TileMap(mapoptions); 
		
		MQA.withModule('largezoom','viewoptions','traffictoggle','geolocationcontrol','insetmapcontrol', function() {
			
			// Large Zoom
			gp_map.addControl( 
				new MQA.LargeZoom(), 
				new MQA.MapCornerPlacement(MQA.MapCorner.TOP_RIGHT, new MQA.Size(0,47))
			);
			
			// View Options
			gp_map.addControl(
				new MQA.ViewOptions(), 
				new MQA.MapCornerPlacement(MQA.MapCorner.TOP_RIGHT)
			);
			
			// Traffic
			gp_map.addControl(
				new MQA.TrafficToggle(), 
				new MQA.MapCornerPlacement(MQA.MapCorner.TOP_RIGHT)
			);
			
			// Inset Map
			var insetoptions=	{
								size:{width:150, height:125},
								zoom:3,
								mapType:'map',
								minimized:false 
								};
			gp_map.addControl( new MQA.InsetMapControl(insetoptions), new MQA.MapCornerPlacement(MQA.MapCorner.BOTTOM_RIGHT) );
			
			// GeoLocation
			var geoControl = new MQA.GeolocationControl();
			geoControl.onLocate = function(poi, position) {
				gp_map.setZoomLevel(15);
				geoControl.deactivate();
				gp_mapManualMove();
			};
			gp_map.addControl( 
				geoControl, 
				new MQA.MapCornerPlacement(MQA.MapCorner.TOP_RIGHT, new MQA.Size(13,262))
			);
			if (thisMC.useGeoLocation){
				if (thisMC.centerByGeoLocation){
					geoControl.activate();
				}
			}
			
		});

		if (thisMC.useScrollWheel){
			MQA.withModule('mousewheel', function() {
				gp_map.enableMouseWheelZoom();
			});
		}
	
		//MQA.withModule('geocoder', function() {});

		//Add right click event listener to open map context menu
		document.getElementById("mapDIV").oncontextmenu=function(e){
			
			$mapDIV = jQuery("#mapDIV");

			//Determine mouse position within the map
			var posx = 0;
			var posy = 0;

			//Fix for IE8
			if (e === undefined) e = window.event; 
			
			if (e.pageX && e.pageY){
				posx = e.pageX;
				posy = e.pageY;
			} else if (e.clientX && e.clientY) 	{
				posx = e.clientX + document.body.scrollLeft + document.documentElement.scrollLeft;
				posy = e.clientY + document.body.scrollTop + document.documentElement.scrollTop;
			}

			var x = posx - $mapDIV.offset().left
			var y = posy - $mapDIV.offset().top
			
			//Create on object with coordinates and mouse position
			var clickInfo = {
				lat: gp_map.pixToLL(new MQA.Point(x, y)).lat,
				lng: gp_map.pixToLL(new MQA.Point(x, y)).lng,
				x: x,
				y: y
			};

			//Save the lat lng of the click in rightClickLatLng var so other methods have access
			rightClickLatLng = clickInfo;
			
			//Show the right click menu
			showMapContextMenu(clickInfo);
		}

		//Other map event listener to close the map right click context menu
		MQA.EventManager.addListener(gp_map, 'click', function(){
			jQuery("#mapContextMenu").hide();
		});
		MQA.EventManager.addListener(gp_map, 'movestart', function(){
			jQuery("#mapContextMenu").hide();
		});
		MQA.EventManager.addListener(gp_map, 'zoomstart', function(){
			jQuery("#mapContextMenu").hide();
		});

		//Event listener for user drag
		MQA.EventManager.addListener(gp_map, 'dragend', function(){
			//User has moved the map, centerpoint address should change
			gp_centerPointKeepAddress = false;
		});

		//Event listner for map type change
	 	MQA.EventManager.addListener(gp_map, 'maptypechanged', function() {
	 		//Update shadow boxes map controls
			var mapType = gp_map.getMapType();

			if(mapType == 'sat' || mapType == 'satellite' || mapType == 'hyb' || mapType == 'hybrid'){
				jQuery('.mapControlTab').addClass('mapControlDarkShadow');
				jQuery('.mapControlContent').addClass('mapControlContentDarkShadow');
				showWhiteSettingsHelp();
			}else{
				jQuery('.mapControlTab').removeClass('mapControlDarkShadow');
				jQuery('.mapControlContent').removeClass('mapControlContentDarkShadow');
				showBlackSettingsHelp();
			}

			//Update the map type on user custom settings
			Visualforce.remoting.Manager.invokeAction(gp_remotes.settingSetMapType,gp_map.getMapType(),function(result, event){ 
		        //Nothing to do here
		    },{escape:true, timeout: 120000});
	 	});

		//Handle mqpquest bug where map center values can become incorrect if user drags map around world.
		MQA.EventManager.addListener(gp_map, 'move', function(){
			gp_fixMapLng();
		});
		MQA.EventManager.addListener(gp_map, 'moveend', function(){
			gp_fixMapLng();
		});

		//Create jquery event listner for map control panel so that if user moves map gp_centerPointKeepAddress is set to false, this is brittle has mq may change markup
		jQuery("#mapDIV").on('click','.mapControl',function(){
			gp_centerPointKeepAddress = false;
		});
		
		//Track map load
		gp_trackMapLoad();
		
	}
	
	// Set Size
	if (thisMC.setSize){
		//If height is null or auto, use auto height
		if(!thisMC.height || thisMC.height == 'auto'){
			thisMC.height = getAutoMapHeight();
		}

		gp_map.setSize(new MQA.Size(thisMC.width, thisMC.height));
	}
	
	// Set Center
	if (thisMC.setCenter){
		gp_map.setCenter(new MQA.LatLng(thisMC.centerLat, thisMC.centerLng), thisMC.centerZoom);
	}
	
	// GeoLocation
	if (thisMC.useGeoLocation){
		if (navigator.geolocation != null){
			if (thisMC.centerByGeoLocation){
    			navigator.geolocation.getCurrentPosition(function(position){
			    	gp_map.setCenter(new MQA.LatLng(position.coords.latitude, position.coords.longitude), 7);
				}, function() {
			      // continue on a failure
			    });
			}
		}
	}

	//After map is created set the max height of the route table, my locations table, and layers table
	setRouteTabHeights();
	setMyLocationsTableMaxHeight();
	setDataSetTabMaxHeight();
	setLayersTableMaxHeight();
}

//Attempts to fix invalid lng values because of MapQuest bug - http://developer.mapquest.com/web/products/forums/-/message_boards/view_message/500570
function gp_fixMapLng(){
	//Get the current lat/lng as reported by getCenter()
	var lat = gp_map.getCenter().lat;
	var lng = gp_map.getCenter().lng;

	//If lng values are invalid, adjust them accordingly
	if(lng < -180){
		lng = lng + 360;
		gp_map.setCenter({lat: lat, lng: lng});
	}else if(lng > 180){
		lng = lng - 360;
		gp_map.setCenter({lat: lat, lng: lng});
	}
}

// Handles a poiCollections Request
function gp_poiCollections(jsAction){

	//Update the gp_dataSetSearches object 
	gp_updateDataSearchesObject(jsAction);
	
	MQA.withModule('shapes', function() {
		
		var thisPOICollections = jsAction.poiCollections;
		
		var allShapeCollections = new Array(); // An array to hold all Shape Collections until after the loop
    	
		// Quick loop through the POI Collections to determine if we should bestFit and/or remove shapes at the end
		var toBestFit = false; // assume we are not doing bestFit
		var bestFitMaxZoom = 2; // init the best fix max zoom, // 2 on MQv7, 1 on MQv6
		var toRemoveAllShapes = true; // assume we are removing them
		if (thisPOICollections.length == 0){ toRemoveAllShapes = false; } // don't touch the points if there are no poiCollections
		
		jQuery.each(thisPOICollections, function(key, value) { 
			// Determine if we are removing shapes
			if(!value.removeAllShapes){ 
				toRemoveAllShapes = false;
			}
 			
			// Determine if we are doing Best Fit
			if (value.bestFit) {
				toBestFit = true;
			}
			
			// Figure out the max bestFitMaxZoom
			if (value.bestFitMaxZoom > bestFitMaxZoom){
				bestFitMaxZoom = value.bestFitMaxZoom;
			}
			
		});
		
		// Clear the data tables
		if (toRemoveAllShapes){
			gp_destroyDataTables('gp_dataTables');

			//Reset object that keeps track of selected records
			gp_selectedRecords = {};
		}
		
		// Loop through each poiCollection
		jQuery.each(thisPOICollections, function(key, value) {
			
			thisPOIC = value;
			thisPOIC.searchType = jsAction.searchType;
			thisPOIC.sfdcObject = '';
			thisPOIC.writeBackEnabled = jsAction.writeBackEnabled;
			thisPOIC.writeBackLookupObject = jsAction.writeBackLookupObject;
			thisPOIC.writeBackButtonText = jsAction.writeBackButtonText;
			
			// Determine whether we should create the table
			var createTable = thisPOIC.collectionName != gp_centerPOICollectionName;
			
			if(createTable){
				jQuery('#gp_dataTablesNoData').hide(); // Hide the No Data message
				gp_newDataTableStructure('gp_dataTables', thisPOIC); // Add new jQuery Data Table structure
				var tableCols = gp_defineDataTableColumns(thisPOIC); // Prepare the columns array for use in creating the data table
			}
			
			// Create and Name the MQ ShapeCollection
			var mq_PoisCollection = new MQA.ShapeCollection();
			if (thisPOIC.collectionName != '') {
				mq_PoisCollection.setName(thisPOIC.collectionName);
			}
			
			// Loop over data and add POIS / rows to table
			var tableData = new Array();
			if(typeof(value.POIs) != "undefined"){
				if(value.POIs != null){
					jQuery.each(value.POIs, function(key, value) { 
						
						thisPOI = gp_finishPOIObject(value);
						thisPOI.poicCollectionName = thisPOIC.collectionName;
						thisPOIC.sfdcObject = thisPOI.sfdcObject;

						//Set center pin icon if necesssary
						if(thisPOI.mapIconURL == 'centerPin'){
							thisPOI.mapIconURL = gpImg.center_pin2;
						}
						
						// Archive off the centerPOI
						if (thisPOI.uniqueId == gp_centerPOICollectionName) { 
							gp_centerPOI = thisPOI; 
							
							gp_radialSearchCenter = {lat: gp_centerPOI.lat, 
													 lng: gp_centerPOI.lng, 
													 recordId: gp_centerPOI.recordId};
						}
						
						// Create an MQA.POI out of this local object
						poi = gp_handlePOI(thisPOIC, thisPOI);
						
						// Add poi to the current POI collection
						if (poi != null){
							mq_PoisCollection.add(poi);
						}
						
						// Add a row of data to the data table array
						if(createTable){									
							tableData.push(gp_defineDataTableRow(thisPOIC, thisPOI));
						}
						
						thisPOI = null;
						
					}); // end of loop through POIs
				}
			}
			
			// Add poi collection to the array of all shape collections
			allShapeCollections.push(mq_PoisCollection);
			
			// create circle overlay
			if(	thisPOIC.searchType == 'nearby' 
				&& typeof(thisPOIC.searchNearbyRange) != "undefined" 
				&& typeof(thisPOIC.searchNearbyLat) != "undefined" 
				&& typeof(thisPOIC.searchNearbyLng) != "undefined"
				&& jsAction.searchNearbyShowOverlay){
					MQA.withModule('shapes', function() {
						
						var coll = new MQA.ShapeCollection();
						if (thisPOIC.collectionName != '') {
							coll.setName(thisPOIC.collectionName + '_overlay');
						}
						
						var radiusUnit = 'MI';
						if(thisPOIC.distanceUnits=='kilometers' || thisPOIC.distanceUnits=='km' || thisPOIC.distanceUnits=='k'){
							radiusUnit = 'KM';
						}
						var circle = new MQA.CircleOverlay();
					    circle.radiusUnit=radiusUnit; 
					    circle.radius=thisPOIC.searchNearbyRange
					    circle.shapePoints=[thisPOIC.searchNearbyLat, thisPOIC.searchNearbyLng];
					    circle.color='#B00303'; //'#B00303'; '#1797c0';
					    circle.colorAlpha=.5;
					    circle.borderWidth=2;
					    circle.fillColor='#EFFF79'; //'#EFFF79'; '#1797c0';
					    circle.fillColorAlpha=.15;
					    
					    coll.add(circle);
					    allShapeCollections.push(coll);
					});
					
			}
			
			// Initialize the Data Table
			if(createTable){
				//Delay the creation of the table slightly
				setTimeout(function(){ 
					//value is the POI collection in the larger jQuery loop, need to use this due do the way var are stored and used in timeout functions
					gp_initDataTable(value, tableCols, tableData)  

					// Calculate Drive Times
					if (jsAction.searchNearbyDriveCalc){
						gp_calcDriveTimes(value.collectionName, value.distanceUnits);
					}
				}, 50);
			}
			
		}); // end of loop through poiCollections

		// Removing shapes, except for the center one
		if (toRemoveAllShapes){
			var colNames = gp_map.getShapeCollectionNames();
			for(var i = 0, iLen = colNames.length; i < iLen; i++) {
				if (colNames[i] != gp_centerPOICollectionName && colNames[i]!='PlacesLayer' && colNames[i].indexOf('route') == -1){
					gp_map.removeShapeCollection(colNames[i]);
				}
			}
		}
		
		// Add points to the map
		for(var i = 0, iLen = allShapeCollections.length; i < iLen; i++) {
			gp_map.addShapeCollection(allShapeCollections[i]);
		}

		//Update hover content for pois
		updateHoverContent();
		
		// Best Fit
		if (toBestFit) {
			gp_map.bestFit(false, 2, bestFitMaxZoom); // 2 on MQv7, 1 on MQv6
		}

		//Build the list actions
		buildListActions(); //map.actions.js
		
	}); // end of MQA.withModule('shapes'...
	
}
//Take an object as input and process the POI onto the map
function gp_handlePOI(thisPOIC, thisPOI){

	if(!thisPOI.isBlankLat && !thisPOI.isBlankLng){
		
		var mq_poi = new MQA.Poi({lat:thisPOI.latDisplay, lng:thisPOI.lngDisplay});
		
		// Set POI title
		//mq_poi.setInfoTitleHTML(thisPOI.title);
		
		// Build the InfoContentHTML
		var tmpInfoContentHTML = '<div style="font-size: 1.1em;">'; 
		tmpInfoContentHTML += '<b style="font-size: 1.2em;">' + thisPOI.title + '</b><br/>'; 
		if(thisPOI.title2 != ''){
			tmpInfoContentHTML += '<b style="font-size: 1.2em;">' + thisPOI.title2 + '</b><br/>';
		}
		tmpInfoContentHTML += thisPOI.formattedAddr;
		if (thisPOI.distanceInfo != '' && thisPOI.distanceInfo != null){
			tmpInfoContentHTML += thisPOI.distanceInfo;
		}
		if (thisPOI.geocodeQuality != ''){
			tmpInfoContentHTML += '<br/><b>'+gp_translations.Geocode_Quality+'</b>: ' + thisPOI.geocodeQuality;
		}

		if(thisPOI.additionalFields){
			tmpInfoContentHTML += '<hr/>';
			jQuery.each(thisPOI.additionalFields, function(key, value) { 
				tmpInfoContentHTML += '<b>' + value.label + '</b>: ' + gp_formatOutputField(thisPOI.recordId,value.datatype,value.value,thisPOI.recordId,thisPOI.title,value.precision) + '<br/>';
			});
		}

		//POI Buttons
		tmpInfoContentHTML += '<div class="poiTooltipButtons">';
		tmpInfoContentHTML += 		buildPOIActions(thisPOIC,thisPOI,'button'); //map.actions.js
		tmpInfoContentHTML += '</div>';
		// end POI Buttons
		
		//Map Actions
		tmpInfoContentHTML += '<div style="margin: 5px 0; padding: 5px; background-color: #efebe2; line-height:1.5em;"><span style="font-size: 10pt;"><b>'+gp_translations.Map_Actions+':</b></span>';
		tmpInfoContentHTML += '<br/><span style="text-decoration:underline; cursor:pointer;" onclick="gp_zoomToStreet(' + thisPOI.latDisplay + ',' + thisPOI.lngDisplay + ',14); gp_openPoiInfoMarker(\'' + thisPOI.uniqueId + '\');">'+gp_translations.Zoom_and_Center+'</span>';
		tmpInfoContentHTML += '&nbsp;&nbsp;<a href="http://mapq.st/?q=' + thisPOI.lat + ',' + thisPOI.lng + '(' + escape(thisPOI.title) + ')" target="_blank">'+gp_translations.View_on_MapQuest+'</a>';
		tmpInfoContentHTML += '</div>';
		
		//Record Actions
		var actionsHTML = buildPOIActions(thisPOIC,thisPOI,'link');
		if(actionsHTML){
			tmpInfoContentHTML += '<div class="poiTooltipActions"><span style="font-size: 10pt;"><b>'+gp_translations.Record_Actions+':</b></span><br/>';
			tmpInfoContentHTML += 		actionsHTML;
			tmpInfoContentHTML += '</div>';
		}
		
		//tmpInfoContentHTML += '<hr/><input class="btn" onclick="gp_SGContextSearch(' + thisPOI.lat + ',' + thisPOI.lng + '); return false;" value="Add Context Layer" type="button" />';
			
		if (thisPOIC.writeBackEnabled){
			if (thisPOI.sfdcObject == thisPOIC.writeBackLookupObject){
				tmpInfoContentHTML += '<hr/><input class="btn" onclick="geopointeAjaxStart(\'body\',\''+gp_translations.Updating_Originating_Record+'...\'); gp_writeBackSelection(\'' + thisPOI.recordId + '\'); return false;" value="' + thisPOIC.writeBackButtonText + '" type="button" />';
			}
		}
		
		tmpInfoContentHTML += '</div>'; 
		mq_poi.setInfoContentHTML(tmpInfoContentHTML);
		
		if(thisPOI.title2 == ''){
			mq_poi.setRolloverContent('<b style="font-size: 1.2em;">' + thisPOI.title + '</b>');
		} else {
			mq_poi.setRolloverContent('<b style="font-size: 1.2em;">' + thisPOI.title + '</b><br/><b style="font-size: 1.2em;">' + thisPOI.title2 + '</b>');
		}

		//Store rollover content in seperate properties on the mq object so we can switch between the two
		mq_poi.tooltip = mq_poi.rolloverContent;
		mq_poi.tooltipDetail = '';
		if(tmpInfoContentHTML){
			mq_poi.tooltipDetail = tmpInfoContentHTML.substring(0,tmpInfoContentHTML.indexOf('<div class="poiTooltipButtons">'));   
		}

		if(thisPOI.uniqueId != ''){mq_poi.setKey(thisPOI.uniqueId);}
		
		if(!thisPOI.isBlankMapIconURL && !thisPOI.isBlankMapIconSize){
			mq_poi.gp_iconURL = thisPOI.mapIconURL;
			mq_poi.gp_iconW = 23;
			mq_poi.gp_iconH = 35;
			mq_poi.setIcon(new MQA.Icon(thisPOI.mapIconURL, 23, 35));
			
			// Offset -50% from left and -100% from top
			mq_poi.setIconOffset(new MQA.Point(-11.5, -30));
		}
		
		mq_poi.setShadow(null);
		mq_poi.setDeclutterMode(false);

		//Create click event listener
		MQA.EventManager.addListener(mq_poi, 'click', function(e){
			//If we are in record selection mode perform special handling from record clicks
			if(gp_inRecordSelectionMode && this.key != 'gp_mapCenterPoi' && this.key != 'centerPOI'){
				gp_toggleRecordSelection(this.key); //'this' is the poi
			}
		});

		return mq_poi;
		
	}
	
	return null;
	
}

function gp_toggleRecordSelection(uniqueId){
	
	//Set apply to picklist to selected records
	jQuery("#applyActionTo").val('selectedRecords');
	
	//Find the mapquest poi marker that was clicked
	var gpMarker; 
	var shapeCollections = gp_map.getShapeCollections();

	if(shapeCollections){
		for(var i = 0; i < shapeCollections.length; i++){

			var pois = shapeCollections[i].items;

			if(pois){
				for(var j = 0; j < pois.length; j++){
					var poi = pois[j];
					if(poi.key == uniqueId){
						gpMarker = poi;
					}
				}
			}
		}
	}

	//Check to see if the record is already selected
	if(!gp_selectedRecords[uniqueId] ){
		gp_selectedRecords[uniqueId] = true;

		//Add check mark next to this record on the map,
		if(gpMarker){
			gp_addCheckMark(gpMarker);
		}
	}else{
		//Set selected flag as false for the record
		gp_selectedRecords[uniqueId] = false;
		
		//Remove the check marker from the map
		var checkMarkCollection = gp_map.getShapeCollection('checkMarks');
		var checkPoi = checkMarkCollection.getByKey(uniqueId + '-check');
		if(checkPoi){
			checkMarkCollection.removeItem(checkPoi);
		}
	}

	//Update the datatable so checkbox stays in sync
	updateDataTableSelectedProp(uniqueId);

	//Hide the info window that will popup on click, this is a hack as there doesn't seem to be a good way to close the info window
	gp_markerClicked = gpMarker;				
	window.setTimeout(function() {
	    if(jQuery(".mqabasicwnd").length > 0){
	    	gp_markerClicked.toggleInfoWindow();
		}
	}, 1);
}

//Remove a route from the map
function gp_removeRouteFromMap(){
	MQA.withModule('directions','route','routeio', function() {
		gp_map.removeRoute();
	});
}

//Add the route back to map, this recalcs based on route list
function gp_restoreRouteOnMap(){
	angular.element(jQuery('#routePanel')).scope().getRoute();
}

//Handles a Route Request
function gp_routeRequest(route,routeOptions){

	var maxZoomBefore = MQA.MAXZOOM;
	var minZoomBefore = MQA.MINZOOM;
	
	var zoomLevelBefore = gp_getZoomLevel();
	var mapCenterBefore = gp_getCenterObject();

	//Prevent zoom change when route is added to map
	if(routeOptions.preserveViewport && route.routeStops.length > 1){
		MQA.MAXZOOM = gp_getZoomLevel();
		MQA.MINZOOM = gp_getZoomLevel();
	}

	if (route.routeStops.length > 1) {
		MQA.withModule('directions','route','routeio', function() {
		
			/* Override optimized Route function */
			MQA.RouteIO.prototype.optimizedRoute = function(routeRequest,ioSettings,callback){
				routeRequest = this._checkShapeFormat(routeRequest);
				if (!this.noTrim) {
					routeRequest.locations=this._trimLocations(routeRequest.locations);
				}
				
				var cachebust = MQA.IO.cacheBust(),
				url = this.baseURI + '/optimizedroute?key='+ ( window.Key || '') + '&cacheBust=' + cachebust;
				
				if (this.noProxy){
					cachebust = 'c' + cachebust.replace(',','');
					
					MQA.RouteIO.CALLBACKS[cachebust] = function(results) {
						callback(MQA.RouteIO.decompress(results));
					}
					
					if (routeRequest.options.ambiguities){
						var ambiguities='ignore';
						delete routeRequest.options.ambiguities;
					}
					
					url += '&callback=MQA.RouteIO.CALLBACKS.' + cachebust;
					if (ambiguities) {
						url += '&ambiguities=' + ambiguities;
					}
					url += '&json=' + MQA.IO.stringifyJSON(routeRequest);
					return MQA.IO.doJSONP(url, ioSettings);
				}
				return MQA.IO.doPostJSON(url,routeRequest,ioSettings,function(results){
					callback(MQA.RouteIO.decompress(results));
				});
			};
	       	/* end of Override optimized Route function */


	       	//Build a list of stops for the maquest api
	       	var mqStops = new Array();
			for (var i = 0; i < route.routeStops.length ; i++ ){
				
				var stop = {};
				
				stop.latLng = new Object();
				stop.latLng.lat = route.routeStops[i].lat;
				stop.latLng.lng = route.routeStops[i].lng;
				stop.name = encodeURIComponent(gp_cleanStringForJSON(route.routeStops[i].name));
				stop.street = encodeURIComponent(gp_cleanStringForJSON(route.routeStops[i].street));
				stop.city = encodeURIComponent(gp_cleanStringForJSON(route.routeStops[i].city));
				if(route.routeStops[i].countryISO == 'GB'){
					stop.state = '';
				} else {
					stop.state = encodeURIComponent(gp_cleanStringForJSON(route.routeStops[i].state));
				}
				stop.postalCode = encodeURIComponent(gp_cleanStringForJSON(route.routeStops[i].postalCode));
				stop.country = encodeURIComponent(gp_cleanStringForJSON(route.routeStops[i].countryISO));
				
				mqStops.push(stop);			
			}
			
			//Set route avoid options
			var avoidsArray = new Array();
			if (route.avoidTolls){
				avoidsArray[0] = 'toll road';
			}

			//Set mq route type
			var mqRouteType = route.type;
			if(mqRouteType == 'driving'){
				mqRouteType = 'fastest';
			}

			//Build route options object
			var options = {
				routeOptions: {
					ambiguities: 'ignore',
					avoids: avoidsArray,
					routeType: mqRouteType, 
					draggable: true,
					locale: gp_userSettings.userInfo.language,
					unit: route.units
				},
				ribbonOptions: {
					draggable:true, 
					draggablepoi:false,
					ribbonDisplay:{colorAlpha:.33}
				}
			};
			
			if(route.optimize){
				// Optimized Route
				gp_map.addOptimizedRoute(
					mqStops,
					options,
					function(results) {
						//Set center to what is was before the route reuest
						if(routeOptions.preserveViewport){
							//Reset default zoom levels
							MQA.MAXZOOM = maxZoomBefore;
							MQA.MINZOOM = minZoomBefore;
						
							gp_map.setCenter({lat:mapCenterBefore.lat, lng:mapCenterBefore.lng},zoomLevelBefore);
						}
						
						if(results.info.statuscode == 0){
							route.status = 'Success';

							//Send this object to angular
							var routeDetail = {
								order: results.route.locationSequence,
								routeResponse: results,
								legs: []
							};

							//Populate the legDurations
							for(var i = 0; i < results.route.legs.length; i++){
								routeDetail.legs.push({
									duration: results.route.legs[i].time * 1000 //convert to ms
								});
							}

							//Let angular controller know map was added successfully, return object with data about the route request, order, etc
							angular.element(jQuery('.routeController')).scope().$broadcast('routeAddedToMap',routeDetail);
							angular.element(jQuery('.routeController')).scope().$apply(); //This is async outside context of angular so update scope on controller
							
							gp_trackRoute(route);
						}else{
							//Route failed
							route.status = results.info.messages[0];
							jQuery.jGrowl(gp_translations.Unable_to_build_route + ' ' + results.info.messages[0], { life: 5000 });
							angular.element(jQuery('.routeController')).scope().$broadcast('routeNotAddedToMap');
							gp_trackRoute(route);
						}
					}
				);
			} else {
				// Regular Route
				gp_map.addRoute(
					mqStops,
					options,
					function(results) {

						//Set center to what is was before the route reuest
						if(routeOptions.preserveViewport){
							//Reset default zoom levels
							MQA.MAXZOOM = maxZoomBefore;
							MQA.MINZOOM = minZoomBefore;

							gp_map.setCenter({lat:mapCenterBefore.lat, lng:mapCenterBefore.lng},zoomLevelBefore);
						}

						if(results.info.statuscode == 0){

							//Send this object to angular
							var routeDetail = {
								routeResponse: results,
								legs: []
							};

							//Populate the legDurations
							for(var i = 0; i < results.route.legs.length; i++){
								routeDetail.legs.push({
									duration: results.route.legs[i].time * 1000 //convert to ms
								});
							}

							//Let angular controller know map was added successfully, return object with data about the route request, order, etc
							angular.element(jQuery('.routeController')).scope().$broadcast('routeAddedToMap',routeDetail);
							angular.element(jQuery('.routeController')).scope().$apply(); //This is async outside context of angular so update scope on controller

							route.status = 'Success';
							gp_trackRoute(route);
						}else{
							//Route failed
							route.status = results.info.messages[0];
							jQuery.jGrowl(gp_translations.Unable_to_build_route + ' ' + results.info.messages[0], { life: 5000 });
							angular.element(jQuery('.routeController')).scope().$broadcast('routeNotAddedToMap');
							gp_trackRoute(route);
						}
					}
				);
			}
		});

	}else{
		//Remove the route
		gp_removeRouteFromMap();
	}
}

//Callback from a Route Request
//Sets some globals
//Writes the route narrative to the page
function gp_displayRouteNarrative(route, data){
	
	// Display messages if there are any
	if (data.info.messages){		
		jQuery("#routeNarrativeDIV").html('');

		for (i = 0; i < data.info.messages.length; i++) {
			jQuery("#routeNarrativeDIV").append('<div style="background-color: lightyellow; padding: 5px;"><b>' + data.info.messages[i] + '</b></div><br/>');
		}
	}
	
	// ===== local functions =====
	
	var dtwaypoints=[]
	function waypointInTable(img,thisLD){
		var tmp = 	'<tr>' + 
					'<td style="border-top: 1px solid rgb(205, 205, 205); padding: 4px 15px 4px 5px; vertical-align: middle; width: 15px;">' +img+ '</td>' + 
					'<td style="border-top: 1px solid rgb(205, 205, 205); vertical-align: middle; width: 150px;">' + thisLD.name + '&nbsp;</td>' +
					'<td style="border-top: 1px solid rgb(205, 205, 205); vertical-align: middle; width: 150px;">' + thisLD.street + '&nbsp;</td>' +
					'<td style="border-top: 1px solid rgb(205, 205, 205); vertical-align: middle; width: 80px;">' + thisLD.city + '&nbsp;</td>' +
					'<td style="border-top: 1px solid rgb(205, 205, 205); vertical-align: middle; width: 50px;">' + thisLD.state + '&nbsp;</td>' +
					'<td style="border-top: 1px solid rgb(205, 205, 205); vertical-align: middle; width: 60px;">' + thisLD.postalCode + '&nbsp;</td>' +
					'<td style="border-top: 1px solid rgb(205, 205, 205); vertical-align: middle; width: 80px;">' + thisLD.country + '&nbsp;</td>' +
					'</tr>';
		dtwaypoints.push(tmp);
	}
	
	function datatable(){
		// added to front of PDF
		var tmp = '<div class="dirSection">'+gp_translations.Location_Summary+'</div>';
		tmp += 	'<table class="waySummary">' + 
						'<tr>' + 
						'<th width: 20px;">&nbsp;</td>' + 
						'<th style="vertical-align: middle;">'+gp_translations.Location_Name+'</td>' +
						'<th style="vertical-align: middle;">'+gp_translations.Street+'</td>' +
						'<th style="vertical-align: middle;">'+gp_translations.City+'</td>' +
						'<th style="vertical-align: middle;">'+gp_translations.State_Province+'</td>' +
						'<th style="vertical-align: middle;">'+gp_translations.Postal_Code+'</td>' +
						'<th style="vertical-align: middle;">'+gp_translations.Country+'</td>' +
						'</tr>';
		for (var i=0; i < dtwaypoints.length; i++) {
			tmp += dtwaypoints[i];
		}
		tmp += '</table>';
		htmlPDF = tmp + htmlPDF;
	}
	
	// ===== process functions =====
	
	// Affect the map if there's a route, otherwise add a message to the page
	if(data.route){
		
		var staticMapURL = 'https://www.mapquestapi.com/staticmap/v4/getmap?key=' + gp_MQApiKey;
		staticMapURL += '&size=700,500';
		//staticMapURL += '&bestfit=' + data.route.boundingBox.ul.lat + ',' + data.route.boundingBox.ul.lng + ',' + data.route.boundingBox.lr.lat + ',' + data.route.boundingBox.lr.lng;
		staticMapURL += '&imageType=png';
		staticMapURL += '&session=' + data.route.sessionId;
		
		// html is for the screen
		// htmlPDF is for the PDF
		var legs = data.route.legs, html = '', htmlPDF = '', i = 0, j = 0, trek, maneuver, wrk = '';
		
		// Begin Table and define header 
		var directionsType = gp_translations.Driving.toUpperCase();
		if (route.type == 'pedestrian' || route.type == 'walking'){directionsType = gp_translations.Walking.toUpperCase();}
		if (route.type == 'bicycle'){directionsType = gp_translations.Bicycling.toUpperCase();}
		if (route.type == 'multimodal' || route.type == 'transit'){directionsType = gp_translations.Public_Transit.toUpperCase();}
		
		html += '<table width="100%" cellspacing="0" cellpadding="3" style="margin: 0 auto;"><tbody>';
		htmlPDF += '<table width="700px;" cellspacing="0" cellpadding="3" style="margin: 0 auto;"><tbody>';
		
		wrk = '<tr><td colspan="5" class="dirTitleMQ"><span>' + directionsType + ' '+ gp_translations.Directions.toUpperCase()+'</span>&nbsp;</td></tr>';
		html += wrk;
		htmlPDF += wrk;
		
		// Determine Route Unit
		var routeUnit = gp_translations.Miles;
		if (route.units == "k"){routeUnit = gp_translations.Kilometers;}
		
		var abc = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
		
		// Journey's Total Time & Distance
		var totalTimeHTML = '';
		totalTimeHTML = '<tr><td colspan="5" class="dirTotalTimeMQ">';
		totalTimeHTML += '<b>'+gp_translations.Total_Route_Time.toUpperCase()+': </b>' + data.route.formattedTime + '&nbsp;&nbsp;&nbsp;<b>'+gp_translations.Total_Route_Distance.toUpperCase()+': </b>' + Math.round(data.route.distance*100)/100 + ' ' + routeUnit;
		totalTimeHTML += '</td></tr>';
			html += totalTimeHTML;
			htmlPDF += totalTimeHTML;
		
		staticMapURL += '&stops=' + abc.substring(0,1) + ',' + data.route.locations[data.route.locationSequence[0]].latLng.lat + ',' + data.route.locations[data.route.locationSequence[0]].latLng.lng;
		
		// Loop through the legs
		for (i = 0; i < legs.length; i++) {
			
			var fromLocationDisplay = route.routeStops[i];
			var toLocationDisplay = route.routeStops[i+1];
			
			var fromLocationLatLng = route.routeStops[i];
			var toLocationLatLng = route.routeStops[i+1];

			if (i <= 25){
				var thisLatLng = data.route.locations[i+1].latLng;
				staticMapURL += '|' + abc.substring(i+1,i+2) + ',' + thisLatLng.lat + ',' + thisLatLng.lng;
			}
			
			// Assess geocode quality
			var poorGCImage = '<img src="' + gpImg.warning12 + '" alt="Poor Geocode Quality" />';
			var goodGCImage = '<img src="' + gpImg.confirm12 + '" alt="Good Geocode Quality" />';
			var fromGC = fromLocationDisplay.geocodeQuality;
			var fromGCImage = poorGCImage;
			var toGC = toLocationDisplay.geocodeQuality;
			var toGCImage = poorGCImage;
			if (fromGC == 'POINT' || fromGC == 'ADDRESS' || fromGC == 'STREET' || fromGC == 'INTERSECTION' || fromGC == 'CUSTOM'){
				fromGCImage = goodGCImage;
			}
			if (toGC == 'POINT' || toGC == 'ADDRESS' || toGC == 'STREET' || toGC == 'INTERSECTION' || toGC == 'CUSTOM'){
				toGCImage = goodGCImage;
			}
			
			// Summary for the leg
			var fromMQImage = '<img src="https://www.mapquestapi.com/staticmap/geticon?uri=stop-' + abc.substring(i,i+1) + '.png" />';
			var toMQImage = '<img src="https://www.mapquestapi.com/staticmap/geticon?uri=stop-' + abc.substring(i+1,i+2) + '.png" />';
			
			var fromAddr = fromLocationDisplay.name + ' @ ' + fromLocationDisplay.street + ' ' + fromLocationDisplay.city + ', ' + fromLocationDisplay.state + ' ' + fromLocationDisplay.postalCode + ' ' + fromLocationDisplay.country;
			if (fromGC == 'CUSTOM' && !fromLocationDisplay.street){
				fromAddr = fromLocationDisplay.name + ' @ ' + fromLocationLatLng.lat + ' , ' + fromLocationLatLng.lng;
			}
			
			var toAddr = toLocationDisplay.name + ' @ ' + toLocationDisplay.street + ' ' + toLocationDisplay.city + ', ' + toLocationDisplay.state + ' ' + toLocationDisplay.postalCode + ' ' + toLocationDisplay.country;
			if (toGC == 'CUSTOM' && !toLocationDisplay.street){
				toAddr = toLocationDisplay.name + ' @ ' + toLocationLatLng.lat + ' ,  ' + toLocationLatLng.lng;
			}
			
			wrk =	'<tr><td colspan="5" class="dirLegSummaryMQ">';
			wrk +=	fromMQImage + '<b>'+gp_translations.From.toUpperCase()+': </b> ' + fromAddr + '<i>&nbsp;('+gp_translations.Geocode_Quality+': ' + fromGCImage + '&nbsp;' + fromGC + ')</i><br/>'; 
			wrk +=	toMQImage + '<b>'+gp_translations.To.toUpperCase()+': </b> ' + toAddr + '<i>&nbsp;('+gp_translations.Geocode_Quality+': ' + toGCImage + '&nbsp;' + toGC + ')</i><br/>'; 
			wrk +=	'<div style="padding: 10px 25px;">' + 
					'<b>'+gp_translations.Time+': </b>' + legs[i].formattedTime + '&nbsp;&nbsp;&nbsp;' + 
					'<b>'+gp_translations.Distance+': </b>' + Math.round(legs[i].distance*100)/100 + ' ' + routeUnit + 
					'</div>';
			wrk += 	'</td></tr>';
				html += wrk;
				htmlPDF += wrk;
			
			waypointInTable(fromMQImage, fromLocationDisplay);
			if(i == (legs.length - 1)){
				waypointInTable(toMQImage, toLocationDisplay);
			}
				
			// Loop through the maneuvers
			var manCounter = 1;
			for (j = 0; j < legs[i].maneuvers.length; j++) {
			
				maneuver = legs[i].maneuvers[j];
				
				// Start maneuver row
				wrk = '<tr>';
					html += wrk;
					htmlPDF += wrk;
					
				// Icons & Signs
				wrk = '<td class="dirManeuverMQ">';
					html += wrk;
					htmlPDF += wrk;
					
				wrk = '<img src="https://www.mapquestapi.com/staticmap/cdn/print/poi-' + (maneuver.index + 1) + '.png" alt="' + + (maneuver.index + 1) + ')" />';
					html += '&nbsp;'
					htmlPDF += manCounter + '.)';
						
					
				wrk = '</td>';
				wrk += '<td class="dirManeuverMQ">';
					html += wrk;
					htmlPDF += wrk;
					
				if (maneuver.iconUrl) {
					wrk = '<img src="' + maneuver.iconUrl + '" alt="maneuver icon" />  ';
						 html += wrk;
						 // don't add icons to PDF
				}
				
				for (k = 0; k < maneuver.signs.length; k++) {
					var sign = maneuver.signs[k];
					if (sign && sign.url) {
						wrk = '<img src="' + sign.url + '"  alt="sign icon" />  ';
							html += wrk;
							// don't add icons to PDF
					}
				}
				
				wrk = '</td>';
					html += wrk;
					htmlPDF += wrk;
				
				// Narrative
				wrk = '<td class="dirManeuverMQ">' + maneuver.narrative + '</td>';
					html += wrk;
					htmlPDF += wrk;
				
				// Distance & Time
				wrk = '<td class="dirManeuverMQ">' + Math.round(maneuver.distance*100)/100 + ' ' + routeUnit + '</td>';
					html += wrk;
					htmlPDF += wrk;
					
				// Thumb Map
				if (route.thumbnails){
					if (maneuver.mapUrl){
						wrk = '<td class="dirManeuverThumbMQ"><img src="' + maneuver.mapUrl + '"></td>';
							html += wrk;
							// don't add maneuvers maps to PDF
					} else {
						wrk = '<td class="dirManeuverMQ">&nbsp;</td>';
					}
				}
				
				wrk = '</tr>';
					html += wrk;
					htmlPDF += wrk;
				
				manCounter++;
				
			} // End loop through the maneuvers
			
		} // End loop through the legs
		
		// Add the total time row again
		html += totalTimeHTML;
		htmlPDF += totalTimeHTML;
			
		// End the table
		wrk = '</tbody></table>';
			html += wrk;
			htmlPDF += wrk;
			
		//Create a route tab under the map if it doesn't already exisit
		gp_createRouteTab(); //GeopointeJS

		// Put html on the page
		jQuery("#routeNarrativeDIV").html(html);
		
		// data table in PDF
		datatable();
		
		// Add the static map to the PDF
		htmlPDF = '<table class="dirImageTable" border="0"><tr><td><img src="' + staticMapURL + '" alt="Route Overview Map"/></td></tr></table>' + htmlPDF;
		
		// Save the printing HTML in a hidden input field
		gp_UIElem.hidden_htmlDirections.value = htmlPDF;
	}

	//Reset tab offsets as height of route tab content may have changed
	resetMapControlOffset('#routePanel'); 	
}

// Adds the poiCollections back onto the map and remove any routes we have on there
function gp_resetCenterPOIContext(div){

	// remove the route
	gp_map.removeRoute();
	
	// Loop through the poi collection archive and re-apply the icons
	if (typeof(gp_shapeCollectionsArchive) != "undefined"){
		
		// Looping through the collection
		for(var i in gp_shapeCollectionsArchive) {
			
			// Looping through the items in the collection
			for(var j = 0, jLen = gp_shapeCollectionsArchive[i].items.length; j < jLen; j++) {
				if(gp_shapeCollectionsArchive[i].collectionName.indexOf('_overlay') == -1){
					var poi = gp_shapeCollectionsArchive[i].items[j];
					poi.setIcon(new MQA.Icon(poi.gp_iconURL, poi.gp_iconW, poi.gp_iconH));
					poi.setIconOffset(new MQA.Point(poi.gp_iconW * .5 * -1, poi.gp_iconH * -1)); // Offset -50% from left and -100% from top
					poi.setShadow(null);
				}
			}
			
			gp_map.addShapeCollection(gp_shapeCollectionsArchive[i]);
		}
	}
	
	jQuery( "#theTabPanel" ).tabs("select",gp_JQTabs.mapDataSets);
	
	// empty the array because the collections are all on the map now. we'll fill it again on the next route
	gp_shapeCollectionsArchive = new Object();
	
	gp_map.bestFit(false, 2, 15);
	
	// Reload the Color By drop-down
	gp_UIElem.hidden_colorMarkersBy.value='';
	
	geopointeAjaxEnd();
}

//Runs a Search Nearby passing the center of the map along with the query
function gp_searchNearbyRecordsWrapper(isRemote,options){
	
	geopointeAjaxStart('body',gp_translations.Performing_a_Radial_Search + '...'); 
	
	// Clear the hidden data so we don't keep sending it to server
	gp_clearHiddenFields();
	
	// Get Map Center
	var centerLat = gp_getCenterObject().lat;
	var centerLng = gp_getCenterObject().lng;

	//If options where provided with lat lng use these
	if(options && options.radialCenterLat && options.radialCenterLng){
		centerLat = options.radialCenterLat;
		centerLng = options.radialCenterLng;
	}

	// If we are in Search mode, add a POI to the map to act as the center
	if (loadWithCenterPOI == false || rightClickRepositionOccured == true){
		
		// Removing the center poi if it exists on the map
		var colNames = gp_map.getShapeCollectionNames();
		var lenColNames = colNames.length;
		for(var i = 0; i < lenColNames; i++) {
			if (colNames[i] == gp_centerPOICollectionName){
				gp_map.removeShapeCollection(colNames[i]);
			}
		}
		
		// Setup the Icon	
		var width = 24;
		var height = 37;
		var iconURL = gpImg.center_pin2;
		var icon = new MQA.Icon(iconURL, width, height);
		
		
		//Set content of marker bubble
		var tmpInfoContentHTML = '<span id="latLng"><b>Latitude: </b>'+centerLat.toFixed(4)+'<br/><b>Longitude: </b>'+centerLng.toFixed(4)+'<br/></span>'+ //hide after Geocode
		'<span id="address"/>'+ //Show after geocode

		'<div style="margin: 5px 0; padding: 5px; background-color: #efebe2; line-height:1.5em;">'+
			'<span style="font-size: 10pt;"><b>'+gp_translations.Map_Actions+':</b></span><br/>'+
			'<span style="text-decoration:underline; cursor:pointer;" onclick="gp_searchRadialRemote(' + centerLat + ',' + centerLng + ');">'+gp_translations.Search_Nearby+'</span>'+
			'&nbsp;&nbsp;<span style="text-decoration:underline; cursor:pointer;" onclick="gp_zoomToStreet(' + centerLat + ',' + centerLng + ',16);">'+gp_translations.Zoom_and_Center+'</span><br/>'+
			'<span id="routesAndLocations" style="display:none;">'+ // show after geocode 
				'<span style="text-decoration:underline; cursor:pointer;" onclick="gp_addToRouteSearchOrCenterPOI(gp_centerPOI,\'center\');">'+gp_translations.Add_to_Route+'</span>'+
				'&nbsp;&nbsp;<span style="text-decoration:underline; cursor:pointer;" onclick="gp_addToMyLocations(gp_radialAddress);">'+gp_translations.Save_to_My_Locations+'</span><br/>'+
			'</span>'+ 
			'<a href="http://mapq.st/?q=' + centerLat + ',' + centerLng +'" target="_blank">'+gp_translations.View_on_MapQuest+'</a>'+
		'</div>';

		//If this radial search was launched from a my location use that HTML
		if(options.keepSearchFromAddress && gp_searchPOI){
			tmpInfoContentHTML = gp_searchPOI.markerHtml;		
		}

		// Create a new center POI
		var poiUniqueId = 'gp_mapCenterPoi';
		var mq_poi = new MQA.Poi({lat:centerLat, lng:centerLng});
			mq_poi.setInfoTitleHTML('<b>'+gp_translations.Center_of_Map_for_Last_Radial_Search+'</b>')
			mq_poi.setInfoContentHTML(tmpInfoContentHTML);
			mq_poi.setRolloverContent('<b>'+gp_translations.Center_of_Map_for_Last_Radial_Search+'</b>')
			mq_poi.setShadow(null);
			mq_poi.setKey(poiUniqueId);
		mq_poi.setIcon(icon);
		mq_poi.setIconOffset(new MQA.Point(width * .5 * -1, height * -1));
		
		// Add POI to shape collection
		var mq_PoisCollection = new MQA.ShapeCollection();
			mq_PoisCollection.setName(gp_centerPOICollectionName);
			mq_PoisCollection.add(mq_poi);

		// Add shape collection to map
		gp_map.addShapeCollection(mq_PoisCollection);

		//Update search center title
		if(options.keepSearchFromAddress){
			//Keep the existing search from address
			
		}else{
			//Do reverse geocode and attempt to update address in the marker bubble
			//var latlng = new google.maps.LatLng(centerLat,centerLng)

			var centerTitle = '';

			//Do the reverse geocode to get the address and update marker bubble			
			MQA.withModule('geocoder', function() {
				
				//This handles the response of the geocode below
				MQA.Geocoder.processResults=function(response, gp_map){
			   		if(response && response.info && response.info.statuscode==0 && response.results && response.results && response.results.length == 1){

						//Parse MapQuest geocode and store result in var, store in case user wants to add to their saved locations
						gp_radialAddress = gp_parseMQGeocode(response.results[0].locations[0]);

						//Update the gp_CenterPOI object
						gp_centerPOI.lat = gp_radialAddress.lat;
						gp_centerPOI.lng = gp_radialAddress.lng;
						gp_centerPOI.countryISO = gp_radialAddress.country;
						gp_centerPOI.title = gp_radialAddress.title;
						gp_centerPOI.street = gp_radialAddress.street;
						gp_centerPOI.city = gp_radialAddress.city;
						gp_centerPOI.state = gp_radialAddress.state;
						gp_centerPOI.postalCode = gp_radialAddress.postalCode;
						gp_centerPOI.country = gp_radialAddress.country;
						gp_centerPOI.geocodeQuality = 'CUSTOM';
						gp_centerPOI.usesCustomerGeocode = '';
						gp_centerPOI.recordId = '';

						//If the search center object has no values, set them as this is the first search
						if(!gp_radialSearchCenter.lat && !gp_radialSearchCenter.lng){
							gp_radialSearchCenter = {lat: gp_centerPOI.lat, 
	  												 lng: gp_centerPOI.lng, 
	 												 recordId: null};

	 						gp_centerPointKeepAddress = true;
						}
						
						//Update the HTML for the center point marker
						for(var i = 0; i < gp_map.getShapeCollections().length; i++){

							if(gp_map.getShapeCollections()[i].getName() == gp_centerPOICollectionName && gp_map.getShapeCollections()[i].items.length > 0){
								var html = gp_map.getShapeCollections()[i].items[0].infoContentHTML;
								html = html.replace('<span id="routesAndLocations" style="display:none;">','<span id="routesAndLocations">');
								html = html.replace('<span id="latLng">','<span id="latLng" style="display:none;">');
								html = html.replace('<span id="address"/>','<span id="address">'+gp_radialAddress.fullAddress+'</span>');
								gp_map.getShapeCollections()[i].items[0].setInfoContentHTML(html);
							}
						}

			   			//Set center search title
						centerTitle = gp_radialAddress.singleLineAddress;

						//Split the address into tow lines after the first commma,
						var firstCommaIndex = centerTitle.indexOf(',');
						
						if(firstCommaIndex > 0){
							centerTitle = centerTitle.substring(0,firstCommaIndex) + '<br/>' + centerTitle.substring(firstCommaIndex + 1,centerTitle.length);
						}

						jQuery("#centerContextTitleOutput").html(centerTitle);
						resetMapControlOffset("#dataSetPanel");
						
						//Called to reset the ActionFunction bug		
						gp_emptyActionFunction(); 

			   		}else{
			   			//Geocode failure
			   			centerTitle += ' '+ gp_translations.The_maps_center_will_be_used_as_the_centerpoint_for_the_radial_search;
			   		}
			    };

				//Do the reverse geocode, response handed by processResults function above 
				gp_map.reverseGeocodeAndAddLocation(
					{lat: centerLat, lng: centerLng}
				);
			});
		}
	}
	
	gp_trackRadialSearch();
	
	if(isRemote != true){
		gp_searchNearbyRecords(centerLat,centerLng); //Action function that does the search
	}
}

function gp_removeCenterMarker(){
	// Removing the center poi if it exists on the map
	var colNames = gp_map.getShapeCollectionNames();
	var lenColNames = colNames.length;
	for(var i = 0; i < lenColNames; i++) {
		if (colNames[i] == gp_centerPOICollectionName){
			gp_map.removeShapeCollection(colNames[i]);
			jQuery("#centerContextTitleOutput").html('Center of the Map');
			resetMapControlOffset("#dataSetPanel");
		}
	}
}

//Resizes the map to be the width of the div
function gp_resetMapWidth(){
	var width = document.getElementById("mapWrapper").clientWidth;
	if (typeof(gp_map) == "object"){
		gp_map.setSize(new MQA.Size(width, gp_map.getSize().getHeight()));
	}
	//Reset legend max width
	setLegendMaxWidthHeight();
}

// Sets the map height
function gp_setMapHeight(height){
	if(height == 'auto'){
		height = getAutoMapHeight();
	}
	gp_map.setSize(new MQA.Size(gp_map.width, height));
	setRouteTabHeights();
	setMyLocationsTableMaxHeight();
	setDataSetTabMaxHeight();
	setLayersTableMaxHeight();
}

//Called from a link inside a POI to zoom down to that location
function gp_zoomToStreet(lat, lon, zoom){
	gp_map.setCenter(new MQA.LatLng(lat, lon),zoom);
}

function gp_getZoomLevel(){
	return gp_map.getZoomLevel();
}

function gp_centerRightClick(){
	gp_map.setCenter({lat:rightClickLatLng.lat, lng:rightClickLatLng.lng});
	gp_trackRightClick('Center');
}

function gp_bestFitRightClick(){
	gp_map.bestFit(false, 2, 15);
	gp_trackRightClick('Show All Mapped Points');
}

function gp_centerZoomRightClick(){
	gp_map.setCenter({lat:rightClickLatLng.lat, lng:rightClickLatLng.lng});

	//Based on current zoom level zoom in.
	var zoom = gp_getZoomLevel();
	var newZoom = 14; //Default
	if(zoom <= 2){
		newZoom = 4;
	}else if(zoom == 3){
		newZoom = 6;
	}else if(zoom == 4){
		newZoom = 8;
	}else if(zoom == 5){
		newZoom = 9;
	}else if(zoom == 6){
		newZoom = 10;
	}else if(zoom == 7){
		newZoom = 10;
	}else if(zoom == 8){
		newZoom = 11;
	}else if(zoom == 9){
		newZoom = 13;
	}else if(zoom == 10){
		newZoom = 13;
	}else if(zoom == 11){
		newZoom = 14;
	}else if(zoom == 12){
		newZoom = 15;
	}else if(zoom == 13){
		newZoom = 15;
	}else if(zoom == 14){
		newZoom = 16;
	}else if(zoom == 15){
		newZoom = 17;
	}else if(zoom == 16){
		newZoom = 18;
	}else if(zoom == 17){
		newZoom = 18;
	}else if(zoom == 18){
		newZoom = 18;
	}

	gp_map.setCenter(new MQA.LatLng(rightClickLatLng.lat, rightClickLatLng.lng),newZoom);
	gp_trackRightClick('Center and Zoom');
}

function gp_searchRadialRemoteRightClick(){
	//Center map
	gp_map.setCenter({lat:rightClickLatLng.lat, lng:rightClickLatLng.lng});

	//Set the right click repositioned flag to true so original centerPOI is not used
	rightClickRepositionOccured = true;

	//Wipe out the old center point poi
	gp_centerPOI = {};
	gp_centerPointKeepAddress = false;

	//Set search center
	gp_radialSearchCenter = {lat: rightClickLatLng.lat, 
							 lng: rightClickLatLng.lng, 
							 recordId: null};

	//Do radial search
	gp_searchRadialRemote();

	gp_trackRightClick('Radial Search');
}

//Return an object with center info
function gp_getCenterObject(){
	var r = new Object();
	r.center = gp_map.getCenter();
	r.lat = r.center.lat;
	r.lng = r.center.lng;
	return r;
}

//Return an object with bounds
function gp_getBoundsObject(){
	var r = new Object();
	r.bounds = gp_map.getBounds();
	r.minLat = r.bounds.lr.lat;
	r.maxLat = r.bounds.ul.lat;
	r.minLng = r.bounds.ul.lng;
	r.maxLng = r.bounds.lr.lng;
	return r;
}

//Open the POI's Info Window with the marker's array ID
function gp_openPoiInfoMarker(markerID) {
	var shapeCols = gp_map.getShapeCollections();
	var lenShapeCols = shapeCols.length;
	for(var i = 0; i < lenShapeCols; i++) {
		var shapeCol = shapeCols[i];
		var thePoi = shapeCol.getByKey(markerID);
		if (thePoi != null){
			thePoi.toggleInfoWindow();
		}
	}
}

// Remove the marker from the map
function gp_removeMarkerMap(markerID) {
	
	// Find and delete the shape
	var shapeCols = gp_map.getShapeCollections();
	var lenShapeCols = shapeCols.length;
	for(var i = 0; i < lenShapeCols; i++) {
		var shapeCol = shapeCols[i];
		var thePoi = shapeCol.getByKey(markerID);
		if (thePoi != null){
			shapeCol.removeItem(thePoi);
		}
	}

	//Also remove the check marker if there is one
	var checkMarkCollection = gp_map.getShapeCollection('checkMarks');
	var checkPoi;

	if(checkMarkCollection){
		checkPoi = checkMarkCollection.getByKey(markerID + '-check');
	}
	
	if(checkPoi){
		checkMarkCollection.removeItem(checkPoi);
	}
	
}

//Given a data set search collection name, remove those markers from the map
function gp_removeDataSetSearchFromMap(collectionName){

	var checkMarkCollection = gp_map.getShapeCollection('checkMarks');

	//Loop through the shape collections and hide the collection shapes on the map
	for(var i = 0; i < gp_map.getShapeCollectionNames().length; i++){
		if(gp_map.getShapeCollectionNames()[i].indexOf(collectionName) > -1){
			gp_map.getShapeCollection( gp_map.getShapeCollectionNames()[i] ).setVisible(false);

			//Remove any related check markers
			var markers = gp_map.getShapeCollection( gp_map.getShapeCollectionNames()[i] );
			
			for(var i = 0; i < markers.items.length; i++){
				var checkPoi = checkMarkCollection.getByKey(markers.items[i].key + '-check');
				if(checkPoi){
					checkMarkCollection.removeItem(checkPoi);
				}
			}
		}
	}
}

function gp_removeDataSetSearchTab(collectionName){
	
	//Loop through the shape collections and remove the collection shapes on the map
	var shapeCollectionNames = gp_map.getShapeCollectionNames();

	for(var i = 0; i < shapeCollectionNames.length; i++){
		if(shapeCollectionNames[i].indexOf(collectionName) > -1){
			gp_map.removeShapeCollection( shapeCollectionNames[i] ); //Remove the markers
		}
	}

	//Remove the tab and content
	jQuery(".dataSetResultTableTab[data-collectionName='"+collectionName+"']").remove();
	jQuery("#tabs-" + collectionName).remove();

	//If there no more result or route tabs show the no data message
	var $tabs = jQuery(".dataSetResultTableTab,#routeDirectionsTab");
	if($tabs.length == 0){
		jQuery("#gp_dataTablesNoData").show();
		jQuery("#gp_dataTables").hide();
	}else{ 
		jQuery($tabs[0]).find("a").click();
	}
}

function gp_restoreDataSetSearchOnMap(collectionName){
	//Loop through the shape collections and show the collection shapes on the map
	for(var i = 0; i < gp_map.getShapeCollectionNames().length; i++){
		if(gp_map.getShapeCollectionNames()[i].indexOf(collectionName) > -1){
			gp_map.getShapeCollection( gp_map.getShapeCollectionNames()[i] ).setVisible(true);

			//Add back the check mark icon for selected records
			var markers = gp_map.getShapeCollection( gp_map.getShapeCollectionNames()[i] );
			
			for(var i = 0; i < markers.items.length; i++){
				if(gp_selectedRecords[markers.items[i].key]){
					gp_addCheckMark(markers.items[i]);
				}
			}
		}
	}
}

//Add a checkbox icon next to a poi
function gp_addCheckMark(marker){
	if(!gp_map.getShapeCollection('checkMarks')){
		var gp_checkShapeCollection = new MQA.ShapeCollection();
		gp_checkShapeCollection.setName('checkMarks');
		gp_map.addShapeCollection(gp_checkShapeCollection);
	}

	//Create a checkbox poi
	var checkPoi = new MQA.Poi({lat:marker.latLng.lat, lng:marker.latLng.lng});
	checkPoi.masterPoiKey = marker.key;
	checkPoi.setIcon(new MQA.Icon(redCheckIconURL,18,18));
	checkPoi.setKey(marker.key + '-check');

	// Add shape collection to map
	gp_map.getShapeCollection('checkMarks').add(checkPoi);
}

// Add a Places result to the map as a layer
function gp_addPlaces(data){
	
	// NOKIA
	if (typeof(data.results) == "undefined"){return;}
	if (typeof(data.results.items) == "undefined"){return;}

	// icons are 60x65
	var icon_w = 60*.6; 
	var icon_h = 65*.6;
	
	gp_clearPlaces();
	
	var mq_PoisCollection = new MQA.ShapeCollection();
	mq_PoisCollection.setName('PlacesLayer');
	
	jQuery.each(data.results.items, function(index, poi) {
		
		if(poi.type=='urn:nlp-types:place'){
			var lat = poi.position[0];
			var lng = poi.position[1];
			
			if (!jQuery('#gp_placesRestrictSearchArea').is(':checked') || gp_latLngInBounds(lat,lng)){
				var mq_poi = new MQA.Poi({lat:lat, lng:lng});
				mq_poi.setKey(poi.id);
				mq_poi.setRolloverContent('<b style="font-size: 1.2em;">' + poi.title + '</b>');
				mq_poi.gp_placeId = poi.id;
				mq_poi.gp_placeURL = poi.href;
				mq_poi.gp_placeLat = lat;
				mq_poi.gp_placeLng = lng;
				mq_poi.gp_placeSponsored = false;
				if(typeof(poi.sponsored)!="undefined"){if(poi.sponsored){mq_poi.gp_placeSponsored=true;}}
				
				mq_poi.gp_iconURL = poi.icon.replace("http://","https://");
				mq_poi.gp_iconW = icon_w;
				mq_poi.gp_iconH = icon_h;
				mq_poi.setIcon(new MQA.Icon(poi.icon.replace("http://","https://"), icon_w, icon_h));
				mq_poi.setIconOffset(new MQA.Point(icon_w * .5 * -1, icon_h * -1)); // Offset -50% from left and -100% from top
				mq_poi.setShadow(null);
				
				MQA.EventManager.addListener(mq_poi, 'click', gp_placesInfoWindowHandler);
				
				mq_PoisCollection.add(mq_poi);
			}
		}
		
	});
	
	if(mq_PoisCollection.getSize() > 0){
		gp_map.addShapeCollection(mq_PoisCollection);
		gp_map.zoomToRect(mq_PoisCollection.getBoundingRect());
	} else {
		jQuery.jGrowl(gp_translations.No_results_were_found_that_met_your_search_criteria, { life: 5000 });
	}
	
}

function gp_clearPlaces(){
	gp_map.removeShapeCollection('PlacesLayer');
}

function gp_placesInfoWindowHandler(evt){
	var url = evt.srcObject.gp_placeURL.replace("http://","https://");
	jQuery.ajax({
		url: url,
		dataType: 'jsonp',
		type: 'GET',
		crossDomain: true,
		success: function(data, textStatus, XMLHttpRequest){
			html = gp_buildPlacesInfoContent(data,evt.srcObject);
			evt.srcObject.setInfoTitle = data.name;
			evt.srcObject.setInfoContentHTML(html);
			gp_map.windowManager.openPoiWindow(evt.srcObject);
		}
	});
}

function gp_updateSearchMarker(address,isGotoMyLocation){
	
	//Make user a minimum zoom level
	var zoom = gp_getZoomLevel();

	if(zoom < 13){
		zoom = 13;		
	}

	//1 Center the map on result
	gp_map.setCenter({lat:address.lat, lng:address.lng},zoom);

	//2 Remove existing center map marker if it exists
	var colNames = gp_map.getShapeCollectionNames();
	for(var i = 0; i < colNames.length; i++) {
		if (colNames[i] == gp_searchPOICollectionName){
			gp_map.removeShapeCollection(colNames[i]);
		}
	}
	
	//3 Add new search map marker
	// Setup the Icon	
	var width = 27;
	var height = 42;
	var icon = new MQA.Icon(searchPinURL, width, height);

	//Set option to keep center address for marker and "Search Center" on dataset 
	var keepSearchFromAddress = false;
	if(isGotoMyLocation || address.keepAddress){
		keepSearchFromAddress = true;
	}

	//Update search center location
	gp_radialSearchCenter = {lat: address.lat, 
							 lng: address.lng, 
							 recordId: null};
	jQuery('#centerContextTitleOutput').html('<span notranslate>'+address.fullAddress+'</span>');
	resetMapControlOffset("#dataSetPanel");
	
	// Create a new center POI
	tmpInfoContentHTML = '';
	if(address.title){
		tmpInfoContentHTML += '<strong notranslate><u>'+address.title+'</u></strong>';
	}
	tmpInfoContentHTML += '<div notranslate>'+address.fullAddress+'</div>'+
	'<div style="margin: 5px 0; padding: 5px; background-color: #efebe2; line-height:1.5em;">'+
		'<span style="font-size: 10pt;"><b>'+gp_translations.Map_Actions+':</b></span><br/>'+
		'<span style="text-decoration:underline; cursor:pointer;" onclick="gp_searchRadialRemote(' + address.lat + ',' + address.lng + ',' + keepSearchFromAddress +');">'+gp_translations.Search_Nearby+'</span>'+
		'&nbsp;&nbsp;<span style="text-decoration:underline; cursor:pointer;" onclick="gp_zoomToStreet(' + address.lat + ',' + address.lng + ',16);">'+gp_translations.Zoom_and_Center+'</span>'+
		'&nbsp;&nbsp;<span style="text-decoration:underline; cursor:pointer;" onclick="gp_addToRouteSearchOrCenterPOI(gp_searchPOI,\'search\');">'+gp_translations.Add_to_Route+'</span>';

		//Only show this if was an address search, not a goto location
		if(isGotoMyLocation != true){
			tmpInfoContentHTML += '<br/><span style="text-decoration:underline; cursor:pointer;" onclick="gp_addToMyLocations(gp_searchAddress);">'+gp_translations.Save_to_My_Locations+'</span>';
		}


	tmpInfoContentHTML += '</div>';

	//Update html on searchPOI object
	if(gp_searchPOI){
		gp_searchPOI.markerHtml = tmpInfoContentHTML;
	}

	var poiUniqueId = 'gp_mapSearchPoi';
	var mq_poi = new MQA.Poi({lat:address.lat, lng:address.lng});
		mq_poi.setInfoContentHTML(tmpInfoContentHTML);
		mq_poi.setRolloverContent('<b>'+address.singleLineAddress+'</b>');
		mq_poi.setShadow(null);
		mq_poi.setKey(poiUniqueId);
	mq_poi.setIcon(icon);
	mq_poi.setIconOffset(new MQA.Point(width * .5 * -1, height * -1));
	
	// Add POI to shape collection
	var mq_PoisCollection = new MQA.ShapeCollection();
		mq_PoisCollection.setName(gp_searchPOICollectionName);
		mq_PoisCollection.add(mq_poi);

	// Add shape collection to map
	gp_map.addShapeCollection(mq_PoisCollection);
}

function updateHoverContent(){
	if(gp_map){
		//Loop through all the poi collections and update the over contect based on if we are in record selection mode
		var shapeCollections = gp_map.getShapeCollections();

		if(shapeCollections){
			for(var i = 0; i < shapeCollections.length; i++){

				if(shapeCollections[i].collectionName != 'centerPOI'){
					var pois = shapeCollections[i].items;
					if(pois){
						for(var j = 0; j < pois.length; j++){
							var poi = pois[j];
							if(gp_inRecordSelectionMode && poi.tooltipDetail){
								poi.rolloverContent = poi.tooltipDetail;
							}else{
								poi.rolloverContent = poi.tooltip;
							}
						}
					}
				}
			}
		}
	}
}