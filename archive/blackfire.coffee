# Description:
#   Profile using blackfire
#
# Commands:
#   hubot blackfire <slot> <url> - profiles a url to a given slot
#
# Author:
#   michael-hopkins

module.exports = (robot) ->
  robot.respond /blackfire (\d+) (.*)/i, (msg) ->
    slot = msg.match[1]
    url = msg.match[2]
    @exec = require('child_process').exec
    command = "blackfire curl --slot #{slot} #{url}"

    msg.send "Profiling #{url}..."

    @exec command, (error, stdout, stderr) ->
      msg.send error
      msg.send stdout
      msg.send stderr