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
channel = "http://idop.appit.ventures/vine/channel"
tag     = "http://idop.appit.ventures/vine/tag"
user    = "http://idop.appit.ventures/vine/find"

module.exports = (sterling) ->
  sterling.respond /vine funny pls/i, (msg) ->
     room = msg.message.user.room
    sterling.http(channel).query({'type': "funny","room" : room}).get() (err, res, body) ->

  sterling.respond /vine music pls/i, (msg) ->
     room = msg.message.user.room
    sterling.http(channel).query({'type': 'music',"room" : room}).get() (err, res, body) ->

  sterling.respond /vine cover pls/i, (msg) ->
     room = msg.message.user.room
    sterling.http(tag).query({'hashtag': 'cover',"room" : room}).get() (err, res, body) ->

  sterling.respond /vine tag (.*) pls/i, (msg) ->
     room = msg.message.user.room
    sterling.http(tag).query({'hashtag':msg.match[1],"room" : room}).get() (err, res, body) ->

  sterling.respond /vine user (.*) pls/i, (msg) ->
     room = msg.message.user.room
    sterling.http(user).query({'username':msg.match[1],"room" : room}).get() (err, res, body) ->
