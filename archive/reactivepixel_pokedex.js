// Description:
// This script will query a json api. The user will ask the api for a Pokemon name and hubot should respond with data about the Pokemon species.
//
// Dependencies:
// Request
//
// Configuration:
// None
//
// Commands:
//
// Author:
// Antonio J. Figueroa

// Initialize a variable for the Request object.
var request = require( 'request' );

// Function to find the weather of the location entered.
function pokedex( msg ) {

    // Get the Pokemon name.
    var inputName = msg.match[ 1 ];
    var pokeName = inputName.toLowerCase();

    // Verify if submission is a string.
    if ( typeof pokeName === "string" ) {
        // *** Submission IS a string ***

        // Setup the url for the Pokeapi.
        url = 'http://pokeapi.co/api/v1/pokemon/'+pokeName;

        // Make a api request based on the submitted <pokeName>, from the prepared api URL.
        request( url, function ( error, response, body ) {

            // Verify if there's a succesfull conection.
            if ( !error && response.statusCode < 300 ) {
                // *** Connection Successful ***

                // Parse the incoming json.
                var json = JSON.parse( response.body );

                // Return the requested information back to the user.
                msg.send( "A "+json.name+" has "+json.hp+" hp. It's attack is "+json.attack+", it's defense is "+json.defense
                +"." );

            } else {
                // *** The api is not responding ***

                // Respond with a specific error message.
                msg.send( "No Pokemon species was found. Please try again." );

            }

        } );
    } else {
        // *** Submission IS NOT a string ***

        // Respond with a specific error message.
        msg.send( "The pokemon you asked for doesn't exists. Please try again without numbers (0-9)." );

    }
}//...end of function.

// Listen to the "pokedex" command and be prepared to receive a user input.
module.exports = function( robot ) {
    return robot.respond( /pokedex (.*)/i, function( msg ) {

        // Run...
        pokedex(msg);

    } );
}