/* [ START STANDINGS ]********************************************/	
(function($){
	nitro_for_salesforce.leaderboards = {
		init: function(_nitro, options){
			var self = this;
				self.nitro = _nitro;

            nitro_for_salesforce.data.leaderboards = {};
			   nitro_for_salesforce.data.leaderboards.leaders = [];
            nitro_for_salesforce.data.leaderboards.options = nitro_for_salesforce.util.convertOptionStringsToBoolean(options);
			   nitro_for_salesforce.data.leaderboards.options.panelHeight = 58;	
			   
			   //setup interactions
		      this.setupSwitcherInteractions();
		      
		      // make the Leaderboard data requests
		      this.makeLeaderboardRequests(options.leaderboardIds);
		},
		
		/**
		 * leaderboards.adjustLeaderboardHeight
		 * Adjusts the height of the leaderboard sections
		 */
		adjustLeaderboardHeight: function() {
		   //monitor the heights of the columns to be equal to avoid floating misalignment
         //@HACK - temporary until we can properly come up with a solution to resize the columns and float them to be the same size. 
         setInterval(function(){
            var highestCol = Math.max(
               $('#floatContainer1 .nitro_sf_leaderboard').outerHeight(),
               $('#floatContainer2 .nitro_sf_leaderboard').outerHeight(),
               $('#floatContainer3 .nitro_sf_leaderboard').outerHeight(),
               $('#floatContainer4 .nitro_sf_leaderboard').outerHeight()
            );
            $('.n4sf_leaderboard').height(highestCol);
         },500);
		},
		
		/**
		 * leaderboards.getLeaderboardsToShow
		 * Returns us an array of leaderboards to show, based on what is passed in via params
		 */
		getLeaderboardsToShow: function(){
			var boards = [];
			var opts = nitro_for_salesforce.data.leaderboards.options;
			
			if(typeof opts.topBoard1 != "undefined"){ boards.push('topBoard1') };
			if(typeof opts.rankBoard1 != "undefined"){ boards.push('rankBoard1') };
         if(typeof opts.topBoard2 != "undefined"){ boards.push('topBoard2') };
			if(typeof opts.rankBoard2 != "undefined"){ boards.push('rankBoard2') };
         if(typeof opts.topBoard3 != "undefined"){ boards.push('topBoard3') };
			if(typeof opts.rankBoard3 != "undefined"){ boards.push('rankBoard3') };
         if(typeof opts.topBoard4 != "undefined"){ boards.push('topBoard4') };
			if(typeof opts.rankBoard4 != "undefined"){ boards.push('rankBoard4') };
			 
			return boards;
		},		
		
		/**
		 * leaderboards.fetchLeaderData
		 * gets the data for our leaderboards
		 */
		fetchLeaderData: function(){
			//var self = this;
			var opts = nitro_for_salesforce.data.leaderboards.options;
            //self.nitro.connectionParams.userId = "test_user11"
			
         /*
			this.parseLeaderboard("nitro_sf_board1_leaders", "topPoints", "rankPoints", "", " " + self.getPointsName());
			this.parseLeaderboard("nitro_sf_board2_leaders", "topQuota", "rankQuota", "", "%");
			this.parseLeaderboard("nitro_sf_board3_leaders", "topDollars", "rankDollars");
			this.parseLeaderboard("nitro_sf_board4_leaders", "topDeal", "rankDeal");
         */
         this.parseLeaderboard("nitro_sf_board1_leaders", "topBoard1", "rankBoard1", opts["board1Type"]);
			this.parseLeaderboard("nitro_sf_board2_leaders", "topBoard2", "rankBoard2", opts["board2Type"]);
			this.parseLeaderboard("nitro_sf_board3_leaders", "topBoard3", "rankBoard3", opts["board3Type"]);
			this.parseLeaderboard("nitro_sf_board4_leaders", "topBoard4", "rankBoard4", opts["board4Type"]);
		},
		
		/**
       * leaderboards.makeLeaderboardRequests
       * Makes an AJAX request to get the data for each leaderboard, and loads the leaderboard 
       * @param {Array} leaderboardIds - an array of leaderboard ids, ordered by position
       */
		makeLeaderboardRequests: function(leaderboardIds) {
		   var opts = nitro_for_salesforce.data.leaderboards.options,
            leaderboardCount = leaderboardIds.length,
            leaderboardsRetrieved = 0;

          for (var i=0; i<leaderboardCount; i++) {
               // get the data for this leaderboard         
               nitro$.ajax({
                     url: '/apex/NitroLeaderboardAjaxResponder?leaderboardId=' + leaderboardIds[i] + '&leaderboardNumber=' + (i+1),
                     dataType: 'json',
                     success: function (data) {
                          leaderboardsRetrieved++;
                        
                          var position = data.leaderboardNumber;
                        
                          if (data.leaderboardId && data.leaderboardId.length > 0) {
                             // set the data for a defined leaderboard
                             opts['topBoard' + position] = data.topBoard;
                             opts['rankBoard' + position] = data.rankBoard;
                             opts['board' + position + 'Type'] = data.type;
                          
                          } else {
                             // leaderboard has not been defined, default the values to empty
                             opts['topBoard' + position] = '';
                             opts['rankBoard' + position] = '';
                             opts['board' + position + 'Type'] = '';   
                          } 
                          
                          // parse the leaderboard data even if there's no data, the function will hide the empty leaderboard
                          nitro_for_salesforce.leaderboards.parseLeaderboard(
                             "nitro_sf_board" + position + "_leaders", 
                             "topBoard" + position, 
                             "rankBoard" + position, 
                             opts['board' + position + 'Type']);
                        
                          if (leaderboardCount == leaderboardsRetrieved) {
                             // all leaderboards have been retrieved
                             nitro_for_salesforce.leaderboards.adjustLeaderboardHeight();
                          }
                     }
               });
          }
		},
				
		/**
		 * standings.dataController
		 * directs traffic from all of the calls
		 */
		dataController: function(res){
			//if this was just a single nitro call (not a batch.run) -- fire away!
			if(typeof(res.Nitro.Nitro) === 'undefined'){
				var responseObj = res.Nitro;
				//make sure we got an async token
				if(typeof responseObj.asyncToken != "undefined"){
					//splitting asyncToken with "~~~" to allow us to define multiple pieces of data in our transmission
					var asyncParts = responseObj.asyncToken.split("~~~");
					//call the method
					eval('this.'+asyncParts[0]+"(responseObj)")
				}				
			}else{
				//loop through each returned call from batch.run
				if(typeof res.Nitro.Nitro.length != 'undefined'){
					for(i in res.Nitro.Nitro){
						var responseObj = res.Nitro.Nitro[i];
							//make sure we got an async token
							if(typeof responseObj.asyncToken != "undefined"){
								//splitting asyncToken with "~~~" to allow us to define multiple pieces of data in our transmission
								var asyncParts = responseObj.asyncToken.split("~~~");
								//call the method
								eval('this.'+asyncParts[0]+"(responseObj)")
							}
					}//end for
				}else{
					var responseObj = res.Nitro.Nitro;
					//make sure we got an async token
					if(typeof responseObj.asyncToken != "undefined"){
						var asyncParts = responseObj.asyncToken.split("~~~");
						//call the method
						eval('this.'+asyncParts[0]+"(responseObj)")
					}
				}
			}
		},


		getMockResponseObjectForActionLeaders: function(collection){
			//create an object in the format the writeActionLeaders method needs
			var responseObj = {};
				responseObj.leaders = {};
				responseObj.leaders.Leader = [];

			if(collection){
				for(i=0;i<collection.length;i++){
					var leader = {};
						leader.userId = collection[i].userId;
						leader.position = (typeof collection[i].position == "undefined")? false : collection[i].position; 
						leader.points = collection[i].value;
						leader.name = collection[i].name;
						leader.smallPhotoUrl = collection[i].smallPhotoUrl;
					responseObj.leaders.Leader.push(leader);				
				}	
			}
			
			return responseObj;
		},


		parseLeaderboard: function(boardId, topData, rankData, boardType){
			var self = this;
            $("#" + boardId + " .nitro_sf_loader").remove();
	      
         var opts = nitro_for_salesforce.data.leaderboards.options;
         
         var prefix = "";
         var suffix = "";
         boardType = boardType.toLowerCase();
         if(boardType == "points"){
            prefix = "";
            suffix = "&nbsp;" + opts.pointsName;
         }else if(boardType == "quota"){
            prefix = "";
            suffix = "%";
         }else if(boardType == "dollars" || boardType == "biggest deal") {
            prefix = "$";
            suffix = "";
         }
			
			if(typeof opts[topData] != 'undefined'){	      
	            this.writePointLeaders(boardId, "top10", prefix, suffix, 10, self.getMockResponseObjectForActionLeaders($.parseJSON(opts[topData]))); 
	            this.highlightUserRank(boardId + " .nitro_sf_board_type_top10 ", self.nitro.connectionParams.userId, true, 10, 4);
			}else{
				$("#nitro_sf_dollar_leaders .switcher_me").hide();
			}
         
			if(typeof opts[rankData] != 'undefined'){	      
	            this.writePointLeaders(boardId, "me", prefix, suffix, 10, self.getMockResponseObjectForActionLeaders($.parseJSON(opts[rankData])));
	            this.highlightUserRank(boardId + " .nitro_sf_board_type_me ", self.nitro.connectionParams.userId, false);
			}else{
				$("#nitro_sf_point_leaders .switcher_top10").hide();
			}

			//if both are not there, hide the entire board
			if(typeof opts.topPoints === 'undefined' && typeof opts.rankPoints === 'undefined'){			
				$("#nitro_sf_point_leaders").hide();
			}
		},


		/**
		 * leaderboards.parseLeaders
		 * parses the data returned from the leaderboard call
		 */
		writePointLeaders: function(leaderboard, tab, pointPrefix, pointSuffix, maxSize, responseObj){
			var self = this;
			var leaders = new Array();
			var leaderHeight = nitro_for_salesforce.data.leaderboards.options.panelHeight; //the height of each of the items
			
			//no leaders returned
			if(responseObj.res==="err"){
			 console.log(responseObj.Error.Message)
			 return false;	
			}
			if(responseObj.leaders === true){
				//do nothing...leaders will be blank.
			}          
			//single leader returned
			else if( typeof(responseObj.leaders.Leader.length) === "undefined"){
				leaders.push(responseObj.leaders.Leader);
			}
			//multiple leaders returned
			else{
                for(j=0;j<responseObj.leaders.Leader.length;j++){
					leaders.push(responseObj.leaders.Leader[j]);
				}				
			}
			
            //create our top10 or "me" containers
            $("#"+leaderboard).find(".nitro_sf_leader_list_compact").append("<div class='nitro_sf_board_type_"+tab+"'></div>");
			
			//hide the top10 boards, since we show "me" first
			if(tab==="top10"){
				$("#"+leaderboard).find(".nitro_sf_board_type_"+tab).hide();
			}
			
			//iterate through leaders and write out the HTML
            var topScore = 0;
			
    	                
			//calculate the height of this panel and smoovely animate it in.
			var panelHeight = leaders.length * leaderHeight;
			//animate the surrounding box to the height
			var panel = $("#" + leaderboard + " .nitro_sf_board_type_" + tab);
			if(panel.is(":visible")){
				panel.css('height','0px').animate({height:panelHeight},500)
			}
						
			for(j=0;j<leaders.length;j++){
               
	           //we want to limit the leaderboards to ten
	           if(j<maxSize){
		           var leader = leaders[j];
				   
				   var rank = (!leader.position) ? j+1 : leader.position;
	                
	               //write the html
				   $("#"+leaderboard).find(".nitro_sf_leader_list_compact").find('.nitro_sf_board_type_'+tab).append(self.getLeaderHtml(leader, rank, "points", pointPrefix, pointSuffix));		
	
	               //get the first score
	               if(j===0){ topScore = leader.points; }
	               
	               //iterate over each of the elements, and calculate the bar width
	               $("#" + leaderboard + " .nitro_sf_board_type_" + tab + " .nitro_sf_standings_leader").each(function(i,el){
				   	   var self = this;
	                  var perc = Math.round(parseInt($(el).data('points')) / topScore * 100);
		               if(tab==="me"){
							   $(this).find(".nitro_sf_standings_leader_bar").css('width',perc+"%")

							   $('.nitro_sf_standings_leader_wrapper').each(function(ii,el2){
								   setTimeout(function(){
	        						   $(el2).fadeIn(800, 'easeOutQuad', function(){
										//$(this).find('.nitro_sf_standings_leader_rank').fadeIn();
								   });
								   }, 200 + (ii*100));
							   });
   						}else{
   	                  $(self).find('.nitro_sf_standings_leader_bar').css("width",perc+"%");
   						}
	               });
			   }
   			}
			
			$("#" + leaderboard + " .nitro_sf_board_type_" + tab + " .nitro_sf_standings_leader_wrapper").hide();
			//$("#" + leaderboard + " .nitro_sf_board_type_" + tab + " .nitro_sf_standings_leader_rank").hide();

            //stripe it!
            $(".nitro_sf_standings_leader_wrapper:even").find(".nitro_sf_standings_leader").addClass('even');  
		},
		
   
        highlightUserRank: function(leaderboard, userId, surrounding, maxSize, numAbove){
            var el = $("#" + leaderboard + " .nitro_sf_standings_leader[data-userId='"+userId+"']");
			var allLeaders = $("#" + leaderboard + " .nitro_sf_standings_leader");
            var self = this;
			
            if(el.length > 0){
                el.addClass("me");
            }
			
			if(allLeaders.length > maxSize){ //only trim if its larger than we want to display
	            //if we want to show users with rank, and everyone else cut off
				if(surrounding && typeof maxSize != "undefined" && typeof numAbove != "undefined"){
                     //console.log("all leaders: " + allLeaders.length);
	                 //get the index for ME.
					 var myIndex = el.index();
					 
	                 //remove anyone that's above us beyond the numAbove param, if removing them wont make our list less than the maxSize
	                 if(myIndex > numAbove){
					 	var numToCut = myIndex - numAbove;
						//if cutting these people out wont make our leaderboard too small
						if(allLeaders.length - numToCut < maxSize){
							numToCut = 0;
                        }
						
                        //whats the max that we CAN cut, then?
						if(numToCut === 0){
                            numToCut = myIndex - maxSize + 1;                        
                        }
						
						//do any trimming...
						if(numToCut > 0){
							//starting with zero, cut the number of people that we've determined
							for(j=0;j<numToCut;j++){
								allLeaders.eq(j).remove();
							}

                            //update the leader collection after removal
							allLeaders = $("#" + leaderboard + " .nitro_sf_standings_leader");
                            myIndex = el.index();
						}
					 }
                     
					 //remove anyone that's below us, beyond the maxSize param, if removing them wont make our list less than the max size...
					 //if it will, figure out how many we can safely delete
                     //console.log(myIndex + " -- " + maxSize)
					 if(myIndex < maxSize){
					 	
						//calculate the number we need to trim out
						var numToCut = allLeaders.length - maxSize;
						
						if(allLeaders.length - numToCut >= maxSize){
							//console.log('cuttin off the bottom')
							//starting at the end of the board, cut upwards
							for(j=allLeaders.length;j>allLeaders.length-numToCut;j--){
                                allLeaders.eq(j-1).remove();								
							}
						}
					 }
					 allLeaders.each(function(i, el){
                                                					 	
					 });			     
					 
				     //if there are zero elements matching YOU on this board, you're outside of range.   
				}
            }			
        },
        
        setupSwitcherInteractions: function(){
			var self = this;
            $(".nitro_sf_leaderboard .switcher_bar h3").click(function(e){
                var el = $(e.currentTarget);
                //highlight this button
                el.parent().find("h3.active").removeClass('active');
                el.addClass('active');
                var parent = el.closest(".nitro_sf_leaderboard");
				var leaderboard = "";
				
                if(el.hasClass('switcher_top10')){
                    //show the top 10 leaderboard div in this board
                    var oldBoard = parent.find('.nitro_sf_board_type_me');
						oldBoard.slideUp(200,function(){
		                    parent.find('.nitro_sf_board_type_top10').fadeIn();
							leaderboard = "top10";
							var el = parent.find('.nitro_sf_board_type_top10');
							self.doLeaderBoardAnimation(el,'top10');
						});
                }else{
                    //show the "me" leaderboard div in this board
                    var oldBoard = parent.find('.nitro_sf_board_type_top10');
						oldBoard.slideUp(200,function(){
		                    parent.find('.nitro_sf_board_type_me').fadeIn();
		                    leaderboard = "me";
							var el = parent.find('.nitro_sf_board_type_me');
							self.doLeaderBoardAnimation(el,'me');
							
						});
                }
            });
        }, 
	
		/**
		 * standings.doLeaderBoardAnimation
		 * animates all leader objects in the given container
		 * @param {Object} el - a jquery object container
		 */
		doLeaderBoardAnimation: function(el,board){
			var leaders = el.find('.nitro_sf_standings_leader_wrapper');
			
			//calculate the height of this panel and smoovely animate it in.
			var panelHeight = leaders.length * nitro_for_salesforce.data.leaderboards.options.panelHeight;
			//animate the surrounding box to the height
			var panel = el;

				panel.find('.nitro_sf_standings_leader_wrapper').hide();
				panel.css('height','0px').animate({height:panelHeight},200, function(){
		            panel.find('.nitro_sf_standings_leader_wrapper').each(function(ii,el){
						setTimeout(function(){
							$(el).fadeIn(600, 'easeOutQuad', function(){

							});
						}, 200 + (ii*50));
					});
				});
		},
	
		/**
		 * standings.getLeaderHtml
		 * returns the html for each leader
		 */
		getLeaderHtml: function(leader,rank,pointAttribute,pointPrefix,pointSuffix){
			var self = this;
			var rankClass = "large";
				if(parseInt(rank) > 999){
					rankClass = "small";
				}
				else if(parseInt(rank) > 99){
					rankClass = "medium";
				}
			
			var h = "";
                h += '<div class="nitro_sf_standings_leader_wrapper"><div class="nitro_sf_standings_leader" data-points="'+leader[pointAttribute]+'" data-userid="'+leader.userId+'">' +
                        '<div class="nitro_sf_standings_leader_rank ' + rankClass + '"><h5>'+rank+'</h5></div>' +
                        '<div class="nitro_sf_standings_leader_img"><a href="'+nitro_for_salesforce.shared.getProfileUrl(leader.userId)+'"><img src="'+self.getUserPhoto(leader.smallPhotoUrl)+'" /></a></div>' +
                        '<div class="nitro_sf_standings_leader_text">' +
                            '<h1><a href="'+nitro_for_salesforce.shared.getProfileUrl(leader.userId)+'">'+ self.getUserDisplayName(leader.name) +'</a></h1>' +
                            '<h4>' + pointPrefix + nitro_for_salesforce.util.addCommas(leader[pointAttribute])+ pointSuffix + '</h4>' +
                        '</div>' +
                        '<div class="nitro_sf_standings_leader_bar_wrap">' +
                           '<div class="nitro_sf_standings_leader_bar" style="width: 1%;"></div>' +
                       '</div>' +
                    '</div></div>';
            return h;
		},
		
		getPointsName: function(){
		  return nitro_for_salesforce.data.leaderboards.options.pointsName;	
		},
		
		
		getUserDisplayName: function(name, userId){
			var str = "";
			if(typeof name != "undefined"){
				str += name;
			}
			
			if(str == "" && typeof userId != "undefined"){
				return userId;
			}else if(str == "" && typeof userId == "undefined"){
				return "";
			}else{
				return str;
			}
		},
		
		getUserPhoto: function(url){
		  if(typeof url != 'undefined'){
	 		return url;
	 	  }else{
		  	return "https://profile.ak.fbcdn.net/static-ak/rsrc.php/v1/yo/r/UlIqmHJn-SK.gif";
		  }
		  
		}
	}
})(nitro$); //closures FTW!!
/* [ END STANDINGS ]********************************************/	
