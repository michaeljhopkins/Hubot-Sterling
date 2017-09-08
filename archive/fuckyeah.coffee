# Description
#   Grab images from "Fuck yeah nouns"
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   fuck yeah <noun> - Displays a fuck yeah image for the given noun
#
# Notes:
#   Uses holman/fuck-yeah as a provider. Can be altered to use the original FYN,
#   but be sure to read the caveats in the comments.
#
# Author:
#   iangreenleaf

providers =
  holman: (noun) ->
    noun = escape noun
    "http://fuckyeah.herokuapp.com/#{noun}#.jpg"
module.exports = (robot) ->
  robot.hear /fuck yeah (.+)/i, (msg) ->
    noun = msg.match[1]
    url = providers.holman noun
    ping = msg.http(url).get (e, req) =>
      req.addListener "response", (res) =>
        if res.statusCode != 200
          robot.logger.error "Bad response from FYN: #{res.statusCode}"
        else
          msg.send url
    ping()