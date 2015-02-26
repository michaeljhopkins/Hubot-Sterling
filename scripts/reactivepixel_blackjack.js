// Description:
//   Play a game of blackjack against Hubot
//
// Dependencies:
//   Ent
//
// Configuration:
//   None
//
// Commands:
//   Hubot blackjack - Plays a game of blackjack
//
// Author:
//   Bogoroh

// Variable to create entity
var ent = require('ent');

// Function to deal a card and remove it from the card array
var dealCard = function(deck){
    var target = Math.floor(Math.random()*deck.length),
        aryReturn = deck.splice(target,1);
    return aryReturn[0];
}

var cardGen = function(num, suit){
    // Switch statement for Ace, Jack, Queen, King to display as text
    var disp = num;
    switch (num) {
        case 1:
            disp = "Ace";
            num = 11;
            break;
        case 11:
            disp = "Jack";
            num = 10;
            break;
        case 12:
            disp = "Queen";
            num = 10;
            break;
        case 13:
            disp = "King";
            num = 10;
            break;
    }
    return {
        display: disp,
        suit: suit,
        value: num
    }
}

// Function to calculate the score of the 2 cards
var calcScore = function(ary){
    var scoreKeeper = 0;

    for(var i = 0; i < ary.length; i++){
        scoreKeeper += ary[i].value;
    }
    return scoreKeeper;
}

// Function to display your hand
var dispHand = function(ary){
    var aryHand = [];

    for(var HandIndex = 0; HandIndex < ary.length; HandIndex++){
        aryHand.push(ary[HandIndex].display + " " + ent.decode(ary[HandIndex].suit));
    }
    // Join the hands together with a comma
    return aryHand.join(" , ");
}


// Function to play blackjack
function playJack(msg){
    // Initialize "deck","delt","arySuits" array
    var arySuits = ["&hearts;" , "&clubs;", "&spades;", "&diams;"],
        deck = [],
        delt = [];

    var cnt = 0;

    // For loop for the 4 suits
    for(var i=0; i<4; i++){
        // For loop for the 13 values
        for(var cardValue=1; cardValue<=13; cardValue++){
            // Push the card to the deck array
            deck.push(cardGen(cardValue,arySuits[i]));
        }
    }

    // Deal 2 cards per user
    var handSize = 2;

    // Loop to deal a card and push it to the delt array
    for(var dealIndex=0; dealIndex<handSize; dealIndex++){

        // Checks if the player's "delt" array has cards inside
        if(!delt["You"]){
            delt["You"] = [];
        }

        // Checks if the dealer's "delt" array has cards inside
        if(!delt["Dealer"]){
            delt["Dealer"] = [];
        }

        // Push to the delt array the cards the player and dealer has been delt
        delt["You"].push(dealCard(deck));
        delt["Dealer"].push(dealCard(deck));
    }

    // Variables to calculate score for Dealer and Player
    var scoreYou = calcScore(delt["You"]),
        scoreDealer = calcScore(delt["Dealer"]);

    // Array to output msg.send
    var messageArray = [];

    // Display the scores for player and dealer
    messageArray.push("Your Score: " + scoreYou + " (" + dispHand(delt["You"]) + " )" );
    messageArray.push("Dealer Score: " + scoreDealer + " (" + dispHand(delt["Dealer"]) + " )" );

    // Checks to see who won
    if (scoreYou > scoreDealer){
        messageArray.push("You Win!");
    } else {
        messageArray.push("You Lose.");
    }

    // Output the strings back
    for(z = 0; z <= messageArray.length; z++){
        (function(z){
            setTimeout(function(){
                msg.send(messageArray[z])
            }, 500 * z);
        }(z));
    }

}


//Listens for the exact match of "blackjack" and calls playJack function.
module.exports = function(robot) {
    return robot.respond(/blackjack/i, function(msg) {
        playJack(msg);
    });
}