# Description:
#   Generate screenshots of webpages using http://page2images.com
#
# Configuration:
#   SCREENSHOT_API_KEY
#   SCREENSHOT_CALLBACK_URL
#
# Commands:
#   hubot screencap me <url>
#   hubot screencap me mobile <url>
#
# Author:
#   michael-hopkins

module.exports = (robot) ->
  p2iKey = process.env.SCREENSHOT_API_KEY
  p2iCallback = process.env.SCREENSHOT_CALLBACK_URL
  if !p2iKey
    msg.send "Please set the SCREENSHOT_API_KEY"
  if !p2iCallback
    msg.send "Please set the SCREENSHOT_CALLBACK_URL"
  robot.respond /screencap me(?: mobile)? https:\/\/(.*)/i, (msg) ->
    msg.send "Can not process https. Please send as http"
  robot.respond /screencap me (?:http:\/\/)?(.*)/i, (msg) ->
    data = {'p2i_key': p2iKey,'p2i_url': msg.match[1],'p2i_size': '1280x0','p2i_callback': p2iCallback,'p2i_device': 6, 'p2i_fullpage': 1}
    msg.http('http://api.page2images.com/restfullink').query(data).get() (err, resp, body) ->
      msg.send "Submitted. It may take up to a minute to render the image"
  robot.respond /screencap me mobile (?:http:\/\/)?(.*)/i, (msg) ->
    data = {'p2i_key': p2iKey,'p2i_url': msg.match[1],'p2i_size': '800x0','p2i_callback': p2iCallback,'p2i_device': 2, 'p2i_fullpage': 1}
    msg.http('http://api.page2images.com/restfullink').query(data).get() (err, resp, body) ->
      msg.send "Submitted. It may take up to a minute to render the image"