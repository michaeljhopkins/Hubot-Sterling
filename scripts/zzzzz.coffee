# Description:
#
# lets see how this guy works. should catch all unhandled messages
# Author:
#   michael-hopkins

module.exports = (robot) ->
  robot.hear /^(?!(sterling|stelring|\.|\@sterling|$))(.*)/i, (msg) ->
    user = msg.message.user.name
    message = msg.match[2]
    room = msg.message.user.room
    data = {'username': user,'message': message,'room': room}
    if(room != 'pokeproject')
      robot.http('http://idop.appit.ventures/logger').query(data).get() (err, res, body) ->
        reply = body