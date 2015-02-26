// Description:
// Have hubot pick your conqueror name
//
// Dependencies:
// none
//
// Configuration:
// none
//
// Commands:
//
// Author:
// Seth Healy.
// shealy@fullsail.edu.

// First name for conquerors.
var firstname = ["Ivan","Bodark","Genghis","Alexander","Hitler","Attila","Napoleon","Tamerlane",
    "Fluffy","Sparkles","Jordan", "Antonio","Ashoka","Charlemagne","Thutmose","Cyrus","Caesar"];

// Adjective that descibes the conqueror.
var adjective = ["the Terrible", "the Destroyer", "the Sweet", "the Fury", "the Furry", "the Fabulous",
    "the Glamorous","the Fire-Wielder","the Iron-Clad","the Shadow-Hand"]

// Where they conquered.
var place = ["of the World", "of Mars", "of your Mom", "of Uranus", "of Egypt","of America","of the Antarctic","of Narnia",
    "of Middle-Earth","of the Shire","of the Universe","of the Front Yard","of Death"]


module.exports = function(robot) {
    return robot.respond(/lets conquer$/i, function(msg) {

        //The message that hubot will deliver.

        msg.send(msg.random(firstname)+" "+msg.random(adjective)+", the Conqueror "+msg.random(place));
    });
};