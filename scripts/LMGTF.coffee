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
    uri = "https://www.google.com/search?q=#{search}"
    msg.send uri