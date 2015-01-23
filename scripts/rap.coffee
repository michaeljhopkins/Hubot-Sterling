# Description:
#   ribbity rappity rap raptastic
#
# Dependencies:
#   None
#
# Commands:
#   hubot spit a rhyme - Have Sterling spit a mad rhyme
#
# Author:
#   michael-hopkins

module.exports = (sterling) ->

  sterling.respond /spit a rhyme/i, (msg) ->
    message = msg.match[1]
    query = { statement: message, recipient: 'sterling', conversevia: 'slack'}
    sterling.http("http://iodop.appit.ventures/rap").query(query).get() (err, res, body) ->
      textFromidop = body