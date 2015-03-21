# Description:
#
# lets see how this guy works. should translate everything in specficied channels
# Author:

nondirective = "http://idop.appit.ventures/webhooks/nondirective"
directive = "http://idop.appit.ventures/webhooks/directive"
module.exports = (robot) ->
  robot.hear /^(?!(wilson|wilson|\.|\@wilson|$))(.*)/i, (msg) ->
    user = msg.message.user.name
    message = msg.match[2]
    room = msg.message.user.room
    if(room == 'hello-printing' || room == 'random')
      r = 'crappypoemsbywilson'
      if(user == 'trungrueta')
        m = 'translate to english'
      else
        m = 'translate to vietnamese'
      robot.messageRoom r, m