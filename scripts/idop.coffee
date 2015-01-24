# Description:
#   idop test script
#
# Dependencies:
#   None
#
# Commands:
#   hubot test idop - test command that should reply into a slack channel
#
# Author:
#   michael-hopkins

module.exports = (sterling) ->
  sterling.respond /test catchall/i, (msg) ->
    user = msg.message.user.name.toLowerCase()
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room}
    sterling.http("http://idop.appit.ventures/catchall").query(data).get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)
        msg.send "#{data.message} - Source: Sterling"

  sterling.hear /sterling test idop/i, (msg) ->
    sterling.http("http://idop.appit.ventures/test").get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)
        msg.send "#{data.message} - Source: Sterling"
      else
        msg.send "Something is Broke - Source: Sterling"

  sterling.hear /do I work/i, (msg) ->
    sterling.http("http://idop.appit.ventures/test").get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)
        msg.send "#{data.message} - Source: Sterling"
      else
        msg.send "Something is Broke - Source: Sterling"