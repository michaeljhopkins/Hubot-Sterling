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
    sterling.http(deal).query({'user_name': msg.message.user.name}).get() (err, res, body) ->
      data = JSON.parse(body)

  sterling.respond /cards quit/i, (msg) ->
    sterling.http(quit).query({'user_name': msg.message.user.name}).get() (err, res, body) ->
      data = JSON.parse(body)

  sterling.respond /cards show/i, (msg) ->
    sterling.http(show).query({'user_name': msg.message.user.name}).get() (err, res, body) ->
      data = JSON.parse(body)

  sterling.respond /cards choose (.*)/i, (msg) ->
    sterling.http(choose).query({'user_name': msg.message.user.name,'cardId':msg.match[1]}).get() (err, res, body) ->
      data = JSON.parse(body)