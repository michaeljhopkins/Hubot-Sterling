// Description:
//   Get happy with hubot happy hour finder for your current time!
//
// Dependencies:
//   cheerio,ent,request
//
// Configuration:
//   none
//
// Commands:
//
// Author:
//   ndickiso
//
// Contributor:
//   Bryan Erickson
// 	 bkerickson - GitHub

//------DEPENDANCIES----------//
var request = require('request'),
    cheerio = require('cheerio'),
    ent = require('ent');


//-----REQUEST CITY FUNCTION-----//
function getHappy(msg,city){

    //Call gotime.com to scrape, concatenating in filtered city variable
    request('http://www.gotime.com/'+city+'/find/places/All-Happy+Hours-now-in-'+city+'?', function (error, response, body) {

        //If response is good
        if (!error && response.statusCode < 300){

            //Load html body into cheerio
            $ = cheerio.load(body);

            //Variables
            var list,noResults;

            //Find the happy hour list element
            list = $('#list_items li');

            //Find the class that is populated when there are no results
            noResults = $('#list_items li.noresults').length;

            //If city is matched in list
            if(noResults === 0){

                //For each place in the happy hour list
                list.each(function() {

                    //Set variables
                    var name,time,district,rating,description;

                    //Remove not needed text inside time anchor tag
                    $(this).find('div span.time a').empty();

                    //Element with name of venue
                    name = $(this).find('span h3 a').text();

                    //Element with happy hour time, strip whitespace
                    time = $(this).find('div span.time').text().trim();

                    //Element with district, strip whitespace
                    district = $(this).find('a.district').text().trim();

                    //Element with rating
                    rating = $(this).find('div:nth-child(2) span span:contains(%)').text();

                    //Element for description, strip whitespace and replace semicolons
                    description = $(this).find('.textSection span.details').attr("title").split(';').join(',').trim();

                    //Send message header with name,rating,time,district, and formatted for slack
                    msg.send('*'+name+'*'+' '+rating+' _'+time+'_ '+district);

                    //Send description
                    msg.send(description);

                });

                //If city is not matched in list
            }else{

                //replace '-' with ' ', to read better
                city.split('-').join(' ');

                //Send error message that city is NOT listed or NO current happy hours
                msg.send(city+" is not a happy city : ( Check for spaces in city names, and spelling!");
            }

            //If error with api request
        }else{

            //Return error if api request goes wrong.
            msg.send("Something went wrong here..");
        }
    })
}


//------FIX CITY REQUEST---------//
function fixCity(msg,city){

    //switch statement to change city name to the specific format need for certain names
    // changed to switch from numerous if statements
    switch (city) {
        case "broward":
        case "palm-beach":
        case "palm-beach-broward":
        case "broward--palm-beach":
            city = "broward-palm-beach";
            break;

        case "dallas-fort-worth":
        case "fort-worth":
        case "fort-worth-dallas":
        case "dallas--fort-worth":
            city = "dallas";
            break;

        case "denver-boulder":
        case "boulder":
        case "denver--boulder":
            city = "denver";
            break;

        case "greensboro":
        case "high-point":
        case "greensboro--high-point-":
        case "high-point-greensboro":
            city = "greensboro";
            break;

        case "st-paul-minneapolis":
        case "st-paul":
        case "minneapolis--st-paul"	:
            city = "minneapolis";
            break;

// Los Angeles permanently broken without a rewrite of the code to deal with possible changes in the gotime.com url scheme
        // case "los-angeles":
        // 	city = "la";
        // 	break;

        case "las-vegas":
            city = "vegas";
            break;

        case "orange-county":
            city = "oc";
            break;

        case "lehigh-valley":
        case "allentown":
            city = "allentown";
            break;

        case "raleigh":
        case "durham":
        case "raleigh--durham":
            city = "raleigh-durham";
            break;

        case "san-francisco":
        case "bay-area":
        case "san-francisco--bay-area":
        case "bay-area-san-francisco":
            city = "sf";
            break;

        case "tacoma":
        case "olympia":
        case "tacoma--olympia":
            city = "tacoma-olympia";
            break;

        case "virginia-beach":
        case "norfolk":
        case "virginia-beach--norfolk":
            city = "virginia-beach-norfolk";
            break;

        case "washington":
        case "washington-dc":
            city = "dc";

    };


    //Send fixed city name to getHappy function to return happy hours
    getHappy(msg,city);
};


//Listens for the exact match of happy and calls random fact function.
module.exports = function(robot) {
    return robot.respond(/happy(.*)/i, function(msg) {

        //Variables
        var input,regex,city;

        //Strip whitespace and lowercase input
        input = msg.match[1].trim().toLowerCase();

        //Regex for removing specials characters
        regex = /[^\w\s]/gi;
        city = input.replace(regex, "");

        //Use ent to decode any html entities
        city = ent.decode(city);

        //Replace spaces with '-' to work with api request
        city = city.split(' ').join('-');

        //Check for city to not be empty
        if(city !== ""){

            //Call fixCity function to check for api city alterations
            fixCity(msg,city);

            //Send error message if nothing is entered after hubot happy
        }else{
            msg.send("Please enter a city.");
        }

    });
}