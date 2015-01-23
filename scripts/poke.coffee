# Description:
#  Send Pokes
#
# Dependencies:
#   None
#
# Commands:
#   Sterling send dondraper1 WhatsUp poke from dondraper1
#
# Author:
#   mikenolimits

module.exports = (sterling) ->

  sterling.respond /poke/i, (msg) ->
    message = msg.match[1]
    query = { statement: message, recipient: 'steve', conversevia: 'slack'}
    sterling.http("http://iodop.appit.ventures/poke").query(query).get() (err, res, body) ->
      msg.send(body);