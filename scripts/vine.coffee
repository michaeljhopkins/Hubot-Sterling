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
    sterling.http(channel).query({'type': "funny"}).get() (err, res, body) ->

  sterling.respond /vine music pls/i, (msg) ->
    sterling.http(channel).query({'type': 'music'}).get() (err, res, body) ->

  sterling.respond /vine cover pls/i, (msg) ->
    sterling.http(tag).query({'hashtag': 'cover'}).get() (err, res, body) ->

  sterling.respond /vine tag (.*) pls/i, (msg) ->
    sterling.http(tag).query({'hashtag':msg.match[1]}).get() (err, res, body) ->

  sterling.respond /vine user (.*) pls/i, (msg) ->
    sterling.http(user).query({'username':msg.match[1]}).get() (err, res, body) ->