# Description:
#   Due to the fact that hubot scripts are executed alphabetically, this script will run last. If the $hasScript flag not....flagged, then this script will act as a "catch all". This will be easy to set up for internal scripts, however I'm still struggling with how to do external scripts.
#
# Author:
#   michael-hopkins

module.exports = (sterling) ->
  sterling.hear /(.*)/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'username': user,'message': message,'room': room}
    sterling.http('http://idop.appit.ventures/catchall').query(data).get() (err, res, body) ->
      reply = body