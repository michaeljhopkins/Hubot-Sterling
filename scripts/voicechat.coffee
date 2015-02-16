# Description:
#   Create VoiceChatApi rooms on the fly
#
# Commands:
#   hubot voice me - hubot will reply with a new voicechatapi room
#
# Author:
#   michael-hopkins - contributed

module.exports = (robot) ->
  url = "http://www.voicechatapi.com"
  purgeMessage = ""

  if process.env.HUBOT_VOICECHAT_HOST?
    url = process.env.HUBOT_VOICECHAT_HOST

  if not process.env.HUBOT_VOICECHAT_EXPIRE_CONFERENCE? or process.env.HUBOT_VOICECHAT_EXPIRE_CONFERENCE is true
    purgeMessage = " \n*This room will be automatically removed after 24 hours. More info at #{url}"

  robot.respond /voice (me)?/i, (msg) ->
    msg.http("#{url}/api/v1/conference/")
    .post() (err, res, body) ->
      if not err and res.statusCode is 200
        json = JSON.parse(body)
        msg.send "Your conference room: #{json.conference_url}#{purgeMessage}"
      else
        robot.logger.error "Unable to create conference at #{url}", err, res
        msg.send "Sorry, but I was unable to create a conference for you."