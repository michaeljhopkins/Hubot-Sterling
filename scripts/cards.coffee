# Description:
#   Cards Against Humanity!
#
# Dependencies:
#   None
#
# Commands:
#   hubot cards deal - adds you to the current cards game
#   hubot cards quit - removes you from the current cards game
#   /cards {id} - plays the id of your chosen card for the current round
#   hubot cards choose {id} - The current round's judge chooses the best card against the pre determined black card
#
# Author:
#   michael-hopkins

module.exports = (sterling) ->
  sterling.respond /cards deal/i, (msg) ->
    username = msg.message.user.name
    data = {'username': username}
    sterling.http("http://idop.appit.ventures/cards/deal").query(data).get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)

  sterling.respond /cards quit/i, (msg) ->
    username = msg.message.user.name
    data = {'username': username}
    sterling.http("http://idop.appit.ventures/cards/quit").query(data).get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)

  sterling.respond /cards choose (\d+)/i, (msg) ->
    username = msg.message.user.name
    cardId = msg.match[1]
    data = {'username': username, 'cardId': cardId}
    sterling.http("http://idop.appit.ventures/cards/choose").query(data).get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)