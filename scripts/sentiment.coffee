# Description:
#   This bot measures sentiment in all channels its in and tracks analytics; starts are reset each week
#
# Commands:
#   hubot sentiment - lists sentiment stats (message contents NOT stored)
#   hubot who's happy?
#   hubot who's stressed?
#
# Author:
#   Michael Hopkins
#
#
#   Tracks scores by current month. Collects sentiment on users [sentiment:week_digit:user] and
#   channels [sentiment:week_digit:channel] in format:
#
#    [{
#      name: user_or_channe_name
#      year: 'YYYY',
#      score_average: 0,
#      score_count: 0
#    }]
#
# Example:
#   [sentiment:12:user:michi] = {n:a:yyyy} where n is the number of records, and a is the average score of the n records
#   To add a new score: (n + 1), ((a * n) + 2.5 / (n+1)) => new averages
#

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