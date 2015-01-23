    module.exports = (hubot) ->
      hubot.respond /hello/i, (msg) ->
        msg.send "Hello!"

      hubot.hear /nsa/i, (msg) ->
        msg.send "nsa is always listening"

      hubot.respond /say (.*)/i, (msg) ->
        msg.send "#{msg.match[1]}"