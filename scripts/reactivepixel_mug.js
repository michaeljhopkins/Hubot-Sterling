// Description:
// Calls an api to get a random mug shot from a random county.
//
// Dependencies:
// request, cheerio, async
//
// Configuration:
// None
//
// Commands:
//
// Author:
// Austin Mayer
// austinemayer@gmail.com

//Dependencies required.
var request = require('request'),
    cheerio = require('cheerio'),
    async = require('async');

function getMugShot(msg){

    //Async allows the county list to populate before getting info from the api
    async.waterfall([
        function(callback){

            //Makes a request to get the list if county id's from the table.
            request('http://www.jailbase.com/api/1/sources/', function (error, response){

                //Catches an error or if the api does not come back with anything.
                if(!error && response.statusCode < 300){

                    //Calls the api to get a random county id first
                    var	countyInfoJSON = JSON.parse(response.body),
                        countyId = countyInfoJSON.records[Math.floor(Math.random()*countyInfoJSON.records.length)].source_id;

                    //passes the county id to the next function in the waterfall
                    callback(null, countyId);
                }
                else{
                    //Message if there is an error and breaks out of the function.
                    msg.send("Sorry I couldn't find any new mug shots.");
                    return false;
                }
            });
        }
    ],function(err, result){

        //Makes a request to get a random mug shot from the api.
        request('http://www.jailbase.com/api/1/recent/?source_id='+result, function (error, response){

            //Catches an error or if the api does not come back with anything.
            if(!error && response.statusCode < 300){

                //Parses the Json and just grabs the first record to send back to the user.
                var mugShotJSON = JSON.parse(response.body),
                    recentArrest = mugShotJSON.records[0],
                    arresteeInfo = [];

                //Outputs the name, charges, and mugshot of the arrestee if available.
                if (recentArrest.name.length > 0){
                    arresteeInfo.push(recentArrest.name);
                }else{
                    arresteeInfo.push('Name not stated.');
                }
                if (recentArrest.charges.length > 0){
                    //Loops through all of their charges.
                    for(i = 0; i < recentArrest.charges.length; i++){
                        arresteeInfo.push(recentArrest.charges[i]);
                    };
                }else{
                    arresteeInfo.push('Charges not stated.');
                }
                if (recentArrest.mugshot.length > 0){
                    //Checks if the placeholder image is present.
                    if(recentArrest.mugshot != "http://imgstore.jailbase.com/widgets/NoMug.gif"){
                        //Cuts out small/ in the url to get the large picture.
                        arresteeInfo.push(recentArrest.mugshot.replace("small/", ""));
                    }else{
                        arresteeInfo.push(recentArrest.mugshot);
                    }
                }else{
                    arresteeInfo.push('No picture available.');
                }
                if (recentArrest.more_info_url.length > 0){
                    arresteeInfo.push("More Info: "+recentArrest.more_info_url);
                }else{
                    arresteeInfo.push('More Info Not available.');
                }

                //Sends out each array item in the proper order
                for(i = 0; i < arresteeInfo.length; i++){
                    (function(i){
                        setTimeout(function(){
                            msg.send(arresteeInfo[i]);
                        }, 100 * i);
                    }(i))};

            }
            else{

                //Message if there is an error.
                msg.send("Sorry I couldn't find any new mug shots.");
            }
        });
    });
}

module.exports = function(robot){

    //Receives the command.
    return robot.respond(/mug me/i, function(msg){

        //Calls the function to get the random joke.
        getMugShot(msg);
    });
}