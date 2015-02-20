# Description:
#   Calls the idop endpoints for sentiment analysis
#
# Commands:
#   hubot sentiment - lists sentiment stats (message contents NOT stored)
#   hubot who's happy?
#   hubot who's stressed?
#
# Author:
#   Michael Hopkins


module.exports = (sterling) ->
  sterling.respond /sentiment/i, (msg) ->
    user_name = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user_name,'message': message,'room': room}
    sterling.http("http://idop.appit.ventures/sentiment").query(data).get() (err, res, body) ->

  sterling.respond /who( i|')s happy\??/i, (msg) ->
    user_name = msg.message.user.name.toLowerCase()
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user_name,'message': message,'room': room}
    sterling.http("http://idop.appit.ventures/sentiment/happy").query(data).get() (err, res, body) ->

  sterling.respond /who( i|')s (sad|stress(ed)?)\??/i, (msg) ->
    user_name = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user_name,'message': message,'room': room}
    sterling.http("http://idop.appit.ventures/sentiment/stress").query(data).get() (err, res, body) ->