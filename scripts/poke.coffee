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
url = "http://iodop.appit.ventures/poke"
module.exports = (sterling) ->

  sterling.respond /poke/i, (msg) ->
    message = msg.match[1]
    data = {statement: message, recipient: 'steve', conversevia: 'slack'}
    sterling.http(url).query(data).get() (err, res, body) ->
      msg.send(body)