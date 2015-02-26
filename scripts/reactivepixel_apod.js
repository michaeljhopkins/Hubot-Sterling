// Description:
// Retrieves the Nasa Astronomy Picture of the Day for the current date, or for an entered date.
//
// Dependencies:
// request
// cheerio
//
// Configuration:
// none
//
// Commands:
//
// Author:
// Bryan Erickson
// GitHub - bkerickson


// required dependencies
    var request = require('request'),
        cheerio = require('cheerio');

//Function that scrapes the NASA Astronomy Picture of the Day for the image title and image url
function getAstroPicOfADay(msg) {
    // if a date option was entered, create a new Date object from the entered date and get the YYMMDD for the URL
    // else no date option is entered, get a new Date object with the current date and set the URL to the current day's picture url
    if (msg.match[2]) {
        // trim any whitespace from the entered date option
        enteredAstroPicDate = msg.match[2].trim();

        // create a new Date object with the entered date
        var astroPicFullDate = new Date(enteredAstroPicDate);

        // test to make sure a valid date was entered and not a random string
        if (isNaN(astroPicFullDate.getDate())) {
            msg.send("You did not enter a valid date, please try again.");
            return;
        } else {
            // date is valid, nothing to do here
        }

        // get the day, month, and year from the date, pass month and day into twoDigitDateFormat function to format them to 2-digit
        var astroPicDay = twoDigitDateFormat(astroPicFullDate.getDate());
        var astroPicMonth = twoDigitDateFormat(astroPicFullDate.getMonth() + 1);
        // get the 2-digit substring year from the 4-digit year
        var astroPicYear = astroPicFullDate.getFullYear().toString().substr(2, 2);

        // build the target url for the Astronomy Picture of the Day
        var astroPicUrl = 'http://apod.nasa.gov/apod/ap' + astroPicYear + astroPicMonth + astroPicDay + '.html';

    } else {
        var astroPicFullDate = new Date();
        var astroPicUrl = 'http://apod.nasa.gov/apod/astropix.html';
    };

    // make the request call to the url to get the page html
    request(astroPicUrl, function(error, response, html) {

        // test for errors or bad status codes, scrape the title and img url if it passes
        // else return error message if the request fails for bad date, no image, or errors
        if (!error && response.statusCode < 300) {

            var outputMessageArray = [];
            // load the page html with cheerio
            $ = cheerio.load(html);

            // get the title of the image
            if ($('title').length > 0) {
                $('title').filter(function() {
                    pageTitleTag = $(this);
                    astroPicOfDayTitle = pageTitleTag.text().trim();
                });
                outputMessageArray.push(astroPicOfDayTitle);
            }
            // get the url to the image,
            // else if the 'pic of the day' is a video, get the video url
            if ($('img').length > 0) {
                $('img').filter(function() {
                    pageImgTag = $(this);
                    astroPicOfDay = pageImgTag.attr('src');
                    outputMessageArray.push("http://apod.nasa.gov/apod/" + astroPicOfDay);
                });
            } else {
                outputMessageArray.push("The picture for this date is not a picture. Oops! Here is the link, check it out for yourself: " + astroPicUrl);
                outputMessageArray.push();
            }

            for (arrayIndex = 0; arrayIndex < outputMessageArray.length; arrayIndex++) {
                (function(arrayIndex) {
                    setTimeout(function() {
                        msg.send(outputMessageArray[arrayIndex])
                    }, 50 * arrayIndex);
                }(arrayIndex));
            }

        } else {
            msg.send("You may have entered a date outside of the range NASA provides (between 06/16/1995 and today), or the date may not have a photo.  Please try again.");
        };

    }); // end of request
}; // end of getAstroPicOfTheDay function

// function to convert the date components into strings 2 chars long for the YYMMDD format of the APOTD url
function twoDigitDateFormat(inputDate) {
    // if the date input is a single digit, convert it to a 2-digit format as a string with a leading 0
    // else the date is already 2-digit, just convert it to a string
    if (inputDate < 10) {
        outputDate = "0" + inputDate;
    } else {
        outputDate = "" + inputDate;
    }

    return outputDate;
}; // end of twoDigitDateFormat function

//Listens for the keyphrases 'nasa pic' or 'nasa picture', calls the function to get the picture
module.exports = function(robot) {
    return robot.respond(/(nasa pic\b|nasa picture)\s*(.*)?$/i, function(msg) {
        getAstroPicOfADay(msg);
    });
}