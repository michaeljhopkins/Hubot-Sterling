# Description:
#   
#
# Commands:
#   hubot google (.*) - searches google for your query
#
# Author:
#   michael-hopkins

module.exports = (robot) ->
  robot.respond /(google)( me)? (.*)/i, (msg) ->
    str = msg.match[3];
    search = str.split(' ').join('+');
    fixurl = str.replace(search,':','%3A');
    fixurl2 = str.replace(fixurl,'/','%2F');
    uri = "http://lmgtfy.com/?q=#{fixurl2}"
    msg.send uri