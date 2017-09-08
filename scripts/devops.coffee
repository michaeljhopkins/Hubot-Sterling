# Description:
#   Because devops are devops.
#
# Configuration:
#   None
#
# Commands:
#   hubot devops me - Grab a random gif from devopsreactions tumblr
#
# Author:
#   epinault

cheerio = require('cheerio')

module.exports = (robot) ->
  robot.respond /devops me/i, (msg) ->
    randevopsMe robot, (url, title) ->
      msg.send title
      msg.send url

randevopsMe = (robot, cb) ->
  robot.http("http://devopsreactions.tumblr.com/random")
  .get() (err, res, body) ->
    devopsMe robot, res.headers.location, (location, title) ->
      cb location , title

devopsMe = (robot, location, cb) ->
  robot.http(location)
  .get() (err, res, body) ->

    $ = cheerio.load(body)

    img = $('img', 'div[class=item_content]').attr('src')
    title = $('a', 'div[class=post_title]').text()

    cb img, title
