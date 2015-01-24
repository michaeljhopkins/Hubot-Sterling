# Description:
#
# lets see how this guy works. should catch all unhandled messages
# Author:
#   michael-hopkins

module.exports = (robot) ->
  robot.hear /^(?!(sterling|stelring|\.|\@sterling|$))(.*)/i, (msg) ->
    console.log(msg.match[0])
    console.log(msg.match[1])
    console.log(msg.match[2])