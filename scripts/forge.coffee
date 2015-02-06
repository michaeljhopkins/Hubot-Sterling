# Description:
#   idop test script
#
# Dependencies:
#   None
#
# Commands:
#   hubot test idop - test command that should reply into a slack channel
#
# Author:
#   michael-hopkins

module.exports = (sterling) ->
  sterling.respond /deploy ([a-zA-Z]*\b) to ([a-zA-Z]*\b)/i, (msg) ->
    data = {repo: msg.match[1],branch: msg.match[2]}
    sterling.http("http://idop.appit.ventures/forge").query(data).get() (err, res, body) ->