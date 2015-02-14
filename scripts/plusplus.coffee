# Description:
#   Give or take away points. Keeps track and even prints out graphs.
#
# Dependencies:
#   "underscore": ">= 1.0.0"
#   "clark": "0.0.6"
#
# Configuration:
#
# Commands:
#   <name>++
#   <name>--
#   hubot score <name> [for <reason>]
#   hubot top <amount>
#   hubot bottom <amount>
#   hubot erase <user> [<reason>]
#   GET http://<url>/hubot/scores[?name=<name>][&direction=<top|botton>][&limit=<10>]
#
# Author:
#   ajacksified


_ = require('underscore')
clark = require('clark')
querystring = require('querystring')
ScoreKeeper = require('./scorekeeper')

module.exports = (robot) ->
  scoreKeeper = new ScoreKeeper(robot)

  # sweet regex bro
  robot.hear ///
    # from beginning of line
    ^
    # the thing being upvoted, which is any number of words and spaces
    ([\s\w':@.-]*)
    # the increment/decrement operator ++ or --
    ([-+]{2}|—)
    # optional reason for the plusplus
    (?:\s+(?:for|because|cause|cuz)\s+(.+))?
    $ # end of line
  ///i, (msg) ->
    # let's get our local vars in place
    [dummy, name, operator, reason] = msg.match
    from = msg.message.user.name.toLowerCase()
    room = msg.message.room

    # do some sanitizing
    reason = reason?.trim().toLowerCase()
    name = (name.replace /(^\s*@)|([,:\s]*$)/g, "").trim().toLowerCase() if name
    the_thing = name
    operator = operator
    user_name = msg.message.user.name
    room = msg.message.user.room
    data = {'the_thing': the_thing,'operator': operator,'reason': reason,'user_name': user_name,'room': room,'directive': 0}
    robot.http("http://idop.appit.ventures/plusplus/newVote").query(data).get() (err, res, body) ->
    	console.log(body)

  robot.respond ///
    (?:erase )
    # thing to be erased
    ([\s\w'@.-]+?)
    # optionally erase a reason from thing
    (?:\s+(?:for|because|cause|cuz)\s+(.+))?
    $ # eol
  ///i, (msg) ->
    [__, name, reason] = msg.match
    from = msg.message.user.name.toLowerCase()
    user = msg.envelope.user
    room = msg.message.room
    reason = reason?.trim().toLowerCase()
    name = (name.replace /(^\s*@)|([,:\s]*$)/g, "").trim().toLowerCase() if name

    isAdmin = @robot.auth?.hasRole(user, 'plusplus-admin') or @robot.auth?.hasRole(user, 'admin')

    if not @robot.auth? or isAdmin
      erased = scoreKeeper.erase(name, from, room, reason)
    else
      return msg.reply "Sorry, you don't have authorization to do that."

    if erased?
      message = if reason?
        "Erased the following reason from #{name}: #{reason}"
      else
        "Erased points for #{name}"
      msg.send message

  robot.respond /score (for\s)?(.*)/i, (msg) ->
    name = msg.match[2].trim().toLowerCase()
    score = scoreKeeper.scoreForUser(name)
    reasons = scoreKeeper.reasonsForUser(name)

    reasonString = if typeof reasons == 'object' && Object.keys(reasons).length > 0
      "#{name} has #{score} points. here are some raisins:" +
        _.reduce(reasons, (memo, val, key) ->
          memo += "\n#{key}: #{val} points"
        , "")
    else
      "#{name} has #{score} points."

    msg.send reasonString

  robot.respond /(top|bottom) (\d+)/i, (msg) ->
    amount = parseInt(msg.match[2]) || 10
    message = []

    tops = scoreKeeper[msg.match[1]](amount)

    if tops.length > 0
      for i in [0..tops.length-1]
        message.push("#{i+1}. #{tops[i].name} : #{tops[i].score}")
    else
      message.push("No scores to keep track of yet!")

    if(msg.match[1] == "top")
      graphSize = Math.min(tops.length, Math.min(amount, 20))
      message.splice(0, 0, clark(_.first(_.pluck(tops, "score"), graphSize)))

    msg.send message.join("\n")

  robot.router.get "/#{robot.name}/normalize-points", (req, res) ->
    scoreKeeper.normalize((score) ->
      if score > 0
        score = score - Math.ceil(score / 10)
      else if score < 0
        score = score - Math.floor(score / 10)

      score
    )

    res.end JSON.stringify('done')

  robot.router.get "/#{robot.name}/scores", (req, res) ->
    query = querystring.parse(req._parsedUrl.query)

    if query.name
      obj = {}
      obj[query.name] = scoreKeeper.scoreForUser(query.name)
      res.end JSON.stringify(obj)
    else
      direction = query.direction || "top"
      amount = query.limit || 10

      tops = scoreKeeper[direction](amount)

      res.end JSON.stringify(tops, null, 2)