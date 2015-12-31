# Description:
#   Cards Against Humanity!
#
# Dependencies:
#   None
#
# Commands:
#   hubot cards help - displays the SlackAgainstHumanity specific commands
#
# Author:
#   michael-hopkins
url = "http://idop.appit.ventures/cards/"

module.exports = (sterling) ->
  sterling.respond /cards deal/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room}
    sterling.http(url+"deal").query(data).get() (err, res, body) ->

  sterling.respond /cards start/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room}
    sterling.http(url+"start").query(data).get() (err, res, body) ->

  sterling.respond /cards quit/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room}
    sterling.http(url+"quit").query(data).get() (err, res, body) ->

  sterling.respond /cards show/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room}
    sterling.http(url+"show").query(data).get() (err, res, body) ->

  sterling.respond /cards choose (.*)/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    cardId = msg.match[1]
    data = {'user_name': user,'message': message,'room': room,'cardId': cardId}
    sterling.http(url+"choose").query(data).get() (err, res, body) ->

  sterling.respond /cards status/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room}
    sterling.http(url+"status").query(data).get() (err, res, body) ->

  sterling.respond /cards help/i, (msg) ->
    msg.send "`sterling cards deal` - adds you to the current cards game"
    msg.send "`sterling cards quit` - removes you from the current cards game"
    msg.send "`sterling cards show` - messages you your cards again incase you forgot"
    msg.send "`\/cards {id}` - plays the id of your chosen card for the current round (a slack slash command is taking care of it though)"
    msg.send "`sterling cards choose {id}` - The current round's judge chooses the best card against the pre determined black card"
    msg.send "`sterling cards status` - Returns the current rounds judge, and any players who have not yet played a card"