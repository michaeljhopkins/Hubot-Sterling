# Description:
#   Hubot Deploy script
#
# Dependencies:
#   None
#
# Commands:
#   hubot deploy <project> - Kicks off deploy for given project
#
# Author:
#   michael-hopkins

module.exports = (sterling) ->
  sterling.hear /deploy onlinemeded/i, (msg) ->
    sterling.http("https://envoyer.io/deploy/SFZaiOOL03VerjcnUOCdF7O6lLH5GR3NXYgU8HS2").get() (err, res, body) ->
      if res.statusCode is 200
        msg.send "Started deployment for 'onlinemeded/onlinemeded'"
      else
        msg.send "Something is Broke"
  sterling.hear /deploy billing\-api/i, (msg) ->
    sterling.http("https://envoyer.io/deploy/griRPLZyOKNGzoq7cYkVHnPUZqvsyJ804aof3G4o").get() (err, res, body) ->
      if res.statusCode is 200
        msg.send "Started deployment for 'onlinemeded/billing-api'"
      else
        msg.send "Something is Broke"