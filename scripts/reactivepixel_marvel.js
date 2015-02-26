// Description:
// Retrieves information for a character in the Marvel Comics Universe
//
// Dependencies:
// request, MD5, async, cheerio
//
// Configuration:
// HUBOT_MARVEL_PRIVATE_KEY
// HUBOT_MARVEL_PUBLIC_KEY
//
// Commands:
// Hubot marvel <character> - Will get information about a character from Marvel. (Obscure characters may not have information yet.)
// Hubot marvel Iron Man - Will return information about Iron Man.
//
// Author:
// Bryan Erickson
// GitHub - bkerickson

// required dependencies
var request = require('request'),
    md5 = require('MD5'),
    cheerio = require('cheerio'),
    async = require('async');

//Function that makes a call to the Marvel API for info on a Marvel character
function marvelCharacterAPISearch(msg){

    // boolean to track if a Marvel wiki link is found during the info retrieval
    var wikiFound = false;

    // test if a character was entered, then cleanse the string for illegal 'characters'
    // else nothing was entered and set the variable to an empty string
    if(msg.match[1]){
        marvelCharacter = msg.match[1];
        marvelCharacter = marvelCharacter.replace(/[^a-zA-Z0-9-\s]+/g, "");
        marvelCharacter = marvelCharacter.trim();
    }else{
        marvelCharacter = "";
    }

    // test if the character name was entered or if it was empty / nothing was entered
    if(marvelCharacter.length == 0){
        msg.send("It looks like you did not enter a character name, please try again. IE: hubot marvel Thor");
        return;
    }else{
        // nothing to do here
    }

    // the Marvel API requires for server-side initiated calls an MD5 hash of a timestamp (or other variable string), the private key, and the public key

    //create a timestamp from the current date in milliseconds
    var currentDate = new Date(),
        marvelTimeStamp = currentDate.getTime(),
    // api keys stored as environment variables
        marvelPrivKey = process.env.HUBOT_MARVEL_PRIVATE_KEY,
        marvelPubKey = process.env.HUBOT_MARVEL_PUBLIC_KEY,
    // get an MD5 hash of the timestamp and keys
        marvelMD5Hash = md5(marvelTimeStamp+marvelPrivKey+marvelPubKey),
    // set up the API url to be called
        marvelAPIBaseUrl = 'http://gateway.marvel.com/v1/public/characters?ts=' + marvelTimeStamp + '&apikey=' + marvelPubKey + '&hash=' + marvelMD5Hash + "&name=" + marvelCharacter;


    // make a waterfall style cascade of calls to prevent asynchronous issues
    async.waterfall([
        function(callback){
            var characterInfoArray = [];
            // make the request call to the Marvel API
            request(marvelAPIBaseUrl, function (error, response, body) {

                // if no errors and response is good, parse the JSON and return the messages
                // else try the Marvel wiki site
                if (!error && response.statusCode < 300){

                    // parse the result body as JSON
                    var	marvelJSON = JSON.parse(body);
                    // make sure there is data to display, if no results were found, try the Marvel wiki as a second try at finding some character info
                    if(marvelJSON.data.count == 0){
                        marvelWikiSearch(msg, marvelCharacter);
                        return false;
                    }else{
                        callback(null, marvelJSON, characterInfoArray);
                    };
                }else{
                    marvelWikiSearch(msg, marvelCharacter);
                };
            }); // end of request
        },
        function(marvelJSONData, marvelInfoArray, callback){
            // if information doesn't exist or a severe lack of information in the API, do the secondary search instead
            if(marvelJSONData.data.results[0].description.trim().length == 0 && wikiFound == false){
                marvelWikiSearch(msg, marvelCharacter);
                return false;
            }else{
                // nothing to do here
            };


            // if a proper name for the character is in the data, get it and add it to the message array
            if(marvelJSONData.data.results[0].name.length > 0){
                var marvelCharName = marvelJSONData.data.results[0].name;
                marvelInfoArray.push(marvelCharName);
            }else{
                // nothing to do here
            };;
            // if a thumbnail exists, get the 'portrait_xlarge' version and add it to the message array
            var notNoImage = new RegExp("http\:\/\/[a-zA-Z0-9\.\/]*\/image_not_available");
            if(marvelJSONData.data.results[0].thumbnail.path.length > 0 &&
                notNoImage.test(marvelJSONData.data.results[0].thumbnail.path) == false){
                var marvelCharThumbnail = marvelJSONData.data.results[0].thumbnail.path
                    + "/portrait_xlarge."
                    + marvelJSONData.data.results[0].thumbnail.extension;
                marvelInfoArray.push(marvelCharThumbnail);
            }else{
                // nothing to do here
            };

            //if the description exists and is not empty, add it to the message array
            if(marvelJSONData.data.results[0].description.trim().length > 0){
                var marvelCharDescription = marvelJSONData.data.results[0].description.trim();
                marvelInfoArray.push(marvelCharDescription);
            }else{
                // nothing to do here
            };

            // if there are urls to more info, get the url to Marvel's wiki page for the character if it exists, and add it to the message array
            if(marvelJSONData.data.results[0].urls.length > 0){
                var urlArray = marvelJSONData.data.results[0].urls;
                for(var urlArrayIndex = 0; urlArrayIndex < urlArray.length; urlArrayIndex++){
                    if(urlArray[urlArrayIndex].type == "wiki"){
                        wikiFound = true;
                        marvelInfoArray.push("Check out Marvel's wiki page for more info on "+ marvelCharName + " at: " + urlArray[urlArrayIndex].url.slice(0,urlArray[urlArrayIndex].url.indexOf("?")) + "");
                    }else{
                        // nothing to do here
                    };
                };
            }else{
                // nothing to do here
            };
            callback(null, marvelInfoArray);
        }
    ], function (err, result) {
        for(var messageArrayIndex = 0; messageArrayIndex < result.length; messageArrayIndex++){
            (function(messageArrayIndex){
                setTimeout(function(){
                    msg.send(result[messageArrayIndex]);
                }, 50 * messageArrayIndex);
            }(messageArrayIndex));
        }
        characterInfoArray = [];
        return false;
    }); // end of async waterfall
}; // end of marvelCharacterAPISearch function

// secondary function to search the Marvel wiki and scrape for a potential match to entered character
function marvelWikiSearch(msg, characterName){

    // add the character name to the Marvel wiki search url
    marvelWikiUrl = "http://marvel.com/universe3zx/index.php?ns0=1&search=" + characterName + "&title=Special%3ASearch&fulltext=Advanced+search";
    request(marvelWikiUrl, function (error, response, html) {
        // if no errors and good status code
        // else send an error message because the Marvel sites may be down
        if (!error && response.statusCode < 300){
            // load the page html with cheerio
            $ = cheerio.load(html);

            // if a character was found and a result comes back, get the title of the character and url
            // else character might not exist or suggest spelling is checked and try again
            if($('#Page_title_matches + h2 + ul.mw-search-results li:first-of-type').length > 0){
                $('#Page_title_matches + h2 + ul.mw-search-results li:first-of-type').filter(function(){
                    marvelWikiPageLink = $(this).find('a').attr('href');
                    marvelWikiPageTitle = $(this).find('a').attr('title');
                    msg.send("I had to do some digging, but I found " + marvelWikiPageTitle + " on http://www.marvel.com" + marvelWikiPageLink + " . Hope that's the right character.");
                });
            }else{
                msg.send("I couldn't find anything for "+ characterName +". Are you sure they are a Marvel character? Can you check the spelling and try again?");
            }
        }else{
            msg.send("Marvel's sites might be down right now, please try again later.");
        }
        return false;
    }); // end of request
}; // end of marvelWikiSearch

//Listens for the key-phrase 'marvel <character>' and calls the function to get information about that character
module.exports = function(robot) {
    return robot.respond(/marvel(.*)?$/i, function(msg) {
        marvelCharacterAPISearch(msg);
    });
}