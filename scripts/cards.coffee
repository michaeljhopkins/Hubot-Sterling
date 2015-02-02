# Description:
#   Cards Against Humanity!
#
# Dependencies:
#   None
#
# Commands:
#   hubot cards deal - adds you to the current cards game
#   hubot cards quit - removes you from the current cards game
#   hubot cards show - messages you your cards again incase you forgot
#   /cards {id} - plays the id of your chosen card for the current round (a slack slash command is taking care of it though)
#   hubot cards choose {id} - The current round's judge chooses the best card against the pre determined black card
#
# Author:
#   michael-hopkins
deal = "http://idop.appit.ventures/cards/deal"
quit = "http://idop.appit.ventures/cards/quit"
choose = "http://idop.appit.ventures/cards/choose"
show = "http://idop.appit.ventures/cards/show"

module.exports = (sterling) ->
  sterling.respond /cards deal/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room,'directive': 1}
    sterling.http(deal).query(data).get() (err, res, body) ->

  sterling.respond /cards quit/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room,'directive': 1}
    sterling.http(quit).query(data).get() (err, res, body) ->

  sterling.respond /cards show/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    data = {'user_name': user,'message': message,'room': room,'directive': 1}
    sterling.http(show).query(data).get() (err, res, body) ->

  sterling.respond /cards choose (.*)/i, (msg) ->
    user = msg.message.user.name
    message = msg.message.text
    room = msg.message.user.room
    cardId = msg.match[1]
    data = {'user_name': user,'message': message,'room': room,'directive': 1,'cardId': cardId}
    sterling.http(choose).query(data).get() (err, res, body) ->