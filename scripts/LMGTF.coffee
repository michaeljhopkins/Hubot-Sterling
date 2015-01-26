# Description:
#   
#
# Commands:
#   hubot google (.*) - searches google for your query
#
# Author:
#   michael-hopkins

module.exports = (robot) ->
  robot.respond /google  (.*)/i, (msg) ->
    params = msg.match[1]
    user_name = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user_name, 'message': message, 'room': room, 'params': params}
    robot.http("http://idop.appit.ventures/google").query(data).get() (err, res, body) ->