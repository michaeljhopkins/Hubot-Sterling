# Description:
#
# lets see how this guy works. should translate everything in specficied channels
# Author:

nondirective = "http://idop.appit.ventures/webhooks/nondirective"
directive = "http://idop.appit.ventures/webhooks/directive"
module.exports = (robot) ->
  robot.hear /^(?!(wilson|wilson|\.|\@wilson|$))(.*)/i, (msg) ->
    user = msg.message.user.name
    term = msg.match[2]
    room = msg.message.user.room
    if(room == 'hello-printing' || room == 'random')
      r = 'crappypoemsbywilson'
      if(user == 'trungrueta')
        language = 'auto'
        target = 'en'
      else
        language = 'auto'
        target = 'vi'
        msg.http("https://translate.google.com/translate_a/t").query({client: 't', hl: 'en', multires: 1, sc: 1, sl: 'en', ssel: 0, tl: 'vi', tsel: 0, uptl: "en", text: term}).header('User-Agent', 'Mozilla/5.0').get() (err, res, body) ->
          data = body
          if data.length > 4 and data[0] == '['
            parsed = eval(data)
            language = languages[parsed[2]]
            parsed = parsed[0] and parsed[0][0] and parsed[0][0][0]
            if parsed
              if msg.match[2] is undefined
              else
                robot.messageRoom r, parsed