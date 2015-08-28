
module.exports = (robot) ->
  robot.respond /^googly me (.*)|^googlify me (.*)|^googly eyes (.*)/i, (msg) ->
    mustachify = "http://googlio.herokuapp.com/?src="
    imagery = msg.match[1]
    if imagery.match /^https?:\/\//i
      encodedUrl = encodeURIComponent imagery
      msg.send "#{mustachify}#{encodedUrl}"
    else
      imageMe msg, imagery, false, true, (url) ->
        encodedUrl = encodeURIComponent url
        msg.send "#{mustachify}#{encodedUrl}"