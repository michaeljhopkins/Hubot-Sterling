# Description:
#   Tell forge to deploy your committed code!
#
# Dependencies:
#   None
#
# Commands:
#   hubot deploy repo@environment
#
# Author:
#   michael-hopkins

module.exports = (sterling) ->
  sterling.respond /deploy (.*)/i, (msg) ->
    sterling.http("http://idop.appit.ventures/deploy").get() (err, res, body) ->
      if res.statusCode is 200
        msg.send("Deployment Started")