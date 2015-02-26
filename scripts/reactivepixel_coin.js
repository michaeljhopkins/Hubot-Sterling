// Description:
// Flip a coin
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
// Holly Springsteen
// hhspringsteen@gmail.com

var theCoin = ["heads", "tails"];

function multipleCoins(msg){
    var coins = msg.match[2],
        tails = 0,
        heads = 0;

    if(coins == 'a' || coins == 1){
        // if user asks for "a"/1 coin then only display the result
        msg.send(msg.random(theCoin));
    }else if(coins > 0 && coins <= 1000000){
        // for multiple coins flipped
        for (var i=0; i<coins; i++){
            // retrieve a random result for the coin
            var randomCoin = msg.random(theCoin);
            // count the total of heads and tails
            if(randomCoin == 'heads'){
                heads++;
            }else if(randomCoin == 'tails'){
                tails++;
            }
        }
        // wait for all coins to be counted before sending out total amounts
        setTimeout(function(){
            msg.send('Heads: '+heads+' Tails: '+tails);
        }, 200);
    }else if(coins > 1000000){
        msg.send("Come on, how about we flip a reasonable number of coins.");
    }else{
        msg.send("You threw 0 coins so you get nothing.");
    }
}


module.exports = function(robot) {
    return robot.respond(/(throw|flip|toss) (\d+|a) (coins|coin)/i, function(msg) {
        multipleCoins(msg);
    });
};