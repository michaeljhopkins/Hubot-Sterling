# Description:
#   Generate screenshots of webpages using http://screenshotmachine.com
#
# Configuration:
#   SCREENSHOT_API_KEY
#
# Commands:
#   hubot screencap me <url>
#
# Author:
#   michael-hopkins

module.exports = (robot) ->
  robot.respond /screencap me (.*)/i, (msg) ->
    ssmKey = process.env.SCREENSHOT_API_KEY
    if ssmKey
      data = {'key': ssmKey,'url': msg.match[1]}
      msg.http('http://api.screenshotmachine.com').query(data).get() (err, resp, body) ->
        msg.send body
    else
      msg.send "Please set the SCREENSHOT_API_KEY"