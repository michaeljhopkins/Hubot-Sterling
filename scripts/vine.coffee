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
     data = {'type': "funny",'room': room}
    sterling.http(channel).query(data).get() (err, res, body) ->

  sterling.respond /vine music pls/i, (msg) ->
     room = msg.message.user.room
     data = {'type': 'music','room': room}
    sterling.http(channel).query(data).get() (err, res, body) ->

  sterling.respond /vine cover pls/i, (msg) ->
     room = msg.message.user.room
     data = {'hashtag': 'cover','room': room}
    sterling.http(tag).query(data).get() (err, res, body) ->

  sterling.respond /vine tag (.*) pls/i, (msg) ->
     room = msg.message.user.room
     data = {'hashtag':msg.match[1],'room': room}
    sterling.http(tag).query(data).get() (err, res, body) ->

  sterling.respond /vine user (.*) pls/i, (msg) ->
     room = msg.message.user.room
     data = {'username':msg.match[1],'room': room}
    sterling.http(user).query(data).get() (err, res, body) ->
