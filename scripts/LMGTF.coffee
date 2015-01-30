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
    uri = "https://www.google.com/search?q=#{msg.match[3]}"
    msg.send uri