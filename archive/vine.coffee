# Description:
#   Vine Provider!
#
# Dependencies:
#   None
#
# Commands:
#
#
# Author:
#   michael-kantor
baseUrl = process.env.HUBOT_IDOP_HOSTNAME
channel = baseUrl+"vine/channel"
tag = baseUrl+"vine/tag"
user = baseUrl+"/vine/find"

module.exports = (sterling) ->
  sterling.respond /vine funny pls/i, (msg) ->
    room = msg.message.user.room
    data = {'type': "funny", 'room': room}
    sterling.http(channel).query(data).get() (err, res, body) ->

  sterling.respond /vine music pls/i, (msg) ->
    data = {'type': 'music', 'room': msg.message.user.room}
    room = msg.message.user.room
    sterling.http(channel).query(data).get() (err, res, body) ->

  sterling.respond /vine cover pls/i, (msg) ->
    data = {'hashtag': 'cover', 'room': msg.message.user.room}
    room = msg.message.user.room
    sterling.http(tag).query(data).get() (err, res, body) ->

  sterling.respond /vine tag (.*) pls/i, (msg) ->
    data = {'hashtag': msg.match[1], 'room': msg.message.user.room}
    room = msg.message.user.room
    sterling.http(tag).query(data).get() (err, res, body) ->

  sterling.respond /vine user (.*) pls/i, (msg) ->
    data = {'username': msg.match[1], 'room': msg.message.user.room}
    room = msg.message.user.room
    sterling.http(user).query(data).get() (err, res, body) ->
