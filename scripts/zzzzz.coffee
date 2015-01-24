# Description:
#
# lets see how this guy works. should catch all unhandled messages
# Author:
#   michael-hopkins

url = "http://idop.appit.ventures/logger"
module.exports = (robot) ->
  robot.hear /^(?!(sterling|stelring|\.|\@sterling|$))(.*)/i, (msg) ->
    user = msg.message.user.name
    message = msg.match[2]
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room}
    if(room != 'pokeproject')
      robot.http(url).query(data).get() (err, res, body) ->