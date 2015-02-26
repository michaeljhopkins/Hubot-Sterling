# Description:
#   pandorabot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   . {message} - calls pandorabot

QS = require "querystring"
xml2js = require 'xml2js'
module.exports = (robot) ->

  robot.hear /^\. (.*)/i, (msg) ->
    user = msg.message.user.name
    query = msg.match[1]

    if query
      botid = process.env.HUBOT_PANDORA_BOTID
      if !botid
        msg.send "Please set the HUBOT_PANDORA_BOTID"
        return

      data = QS.stringify botid: botid, custid: user, input: query

      msg.http('http://www.pandorabots.com')
      .path("/pandora/talk-xml")
      .header("Content-Type", "application/x-www-form-urlencoded")
      .post(data) (err, resp, body) ->
        parser = new xml2js.Parser()
        parser.parseString body, (err, result)->
          msg.send "#{result.result.that}"