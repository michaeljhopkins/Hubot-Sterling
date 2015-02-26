// Description:
//   Clear the page by moving the content upwards in the window.
//
// Dependencies:
//   None
//
// Configuration:
//   None
//
// Commands:
//
// Author:
//	 dgerena aka Eli!
//
// Contributor:
//	Holly Springsteen
// 	hhspringsteen@gmail.com


// I had wished to be able to pass in some specific character codes to push the page dependent on size of the browser had to settle for entering in spaces...
function seeThrough(msg){
    for(var esc = 0;esc < msg.count; esc++){
        msg.send(" ");
    }
}
// my filtering here is directly due to a misunderstanding about the extent to which i understood regex. Have to work on that for the foreseeable future...
// regex can be awesome or a pain in the rear.
module.exports = function(robot) {
    return robot.respond(/clear\sdesktop$|clear\smobile$|clear\stablet$/i,function(msg){
        //Filtering out the possible context to which someone might try to use the huClear.js/ Will work with the local and staging bots.
        //Suggested fixes or upgrades are to extend this to work with anyones bot named anything. Or to function while somehow getting the viewing size.
        //Still couldn't somehow pass in the robot to concat onto the string clear desktop to make dynamic for each robot its plugged into.

        // Holly Springsteen
        // allow for lower case robot calls with toLowerCase
        var input = msg.message.text
        switch(input.toLowerCase()){
            //desktop clear
            case"derpbot clear desktop":
            case"hubot clear desktop":
                msg.count = 25;
                seeThrough(msg);
                break;
            //mobile clear
            case"derpbot clear mobile":
            case"hubot clear mobile":
                msg.count = 11;
                seeThrough(msg);
                break;
            //tablet clear
            case"derpbot clear tablet":
            case"hubot clear tablet":
                msg.count = 21;
                seeThrough(msg);
                break;
        }
    });
}