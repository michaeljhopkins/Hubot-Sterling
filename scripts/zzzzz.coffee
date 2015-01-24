# Description:
#
# lets see how this guy works. should catch all unhandled messages
# Author:
#   michael-hopkins

module.exports = (robot) ->
  robot.catchAll (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'username': user,'message': message,'room': room}
    robot.http('http://idop.appit.ventures/catchall').query(data).get() (err, res, body) ->
      reply = body