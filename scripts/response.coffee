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
  sterling.hear /1/i, (msg) ->
    msg.send "Can you email me the screenshot corbits sent you?"
  sterling.hear /2/i, (msg) ->
    msg.send "yup. just sent"