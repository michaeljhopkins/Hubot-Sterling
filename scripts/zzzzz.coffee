# Description:
#
# lets see how this guy works. should catch all unhandled messages
# Author:
#   michael-hopkins

nondirective = "http://idop.appit.ventures/webhooks/nondirective"
directive = "http://idop.appit.ventures/webhooks/directive"
module.exports = (robot) ->
  robot.hear /^(?!(sterling|stelring|\.|@sterling|$))(.*)/i, (msg) ->
    user = msg.message.user.name
    message = msg.match[2]
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room}
    robot.http(nondirective).query(data).get() (err, res, body) ->
  robot.respond /(.*)/i, (msg) ->
    user = msg.message.user.name
    message = msg.match[1]
    room = msg.message.user.room
    directive = 1
    data = {'user_name': user,'message': message,'room': room,'directive': directive}
    robot.http(directive).query(data).get() (err, res, body) ->