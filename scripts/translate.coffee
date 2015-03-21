# Description:
#
# lets see how this guy works. should translate everything in specficied channels
# Author:

module.exports = (robot) ->
  pattern = new RegExp('^(?!(wilson|wilson|\.|\@wilson|$))(.*)', 'i')
  # Find the user by user name from hubot's brain.
  #
  # name - A full or partial name match.
  #
  # Returns a user object if a single user is found, an array of users if more
  # than one user matched the name or false if no user is found.
  findUser = (name) ->
    users = robot.brain.usersForFuzzyName name
    if users.length is 1
      users[0]
    else if users.length > 1
      users
    else
      false

  robot.respond /autotrans me (.{2}) to (.{2})/, (msg) ->
    messageSender = findUser msg.message.user.name
    console.log(messageSender)
    if typeof messageSender is 'object'
      messageSender.preferredLanguage = hasAutotrans: true, sourceDefault: msg.match[1], targetDefault: msg.match[2]
      console.log(messageSender.preferredLanguage)

  robot.hear pattern, (msg) ->
    name = msg.message.user.name
    user = findUser name
    messageSentIn = msg.message.user.room
    term   = "\"#{msg.match[1]}\""
    origin = if user.preferredLanguage.hasAutotrans isnt false then user.preferredLanguage.sourceDefault else 'auto'
    target = if user.preferredLanguage.hasAutotrans isnt false then user.preferredLanguage.targetDefault else 'en'
    console.log(origin)
    console.log(target)
    if typeof user is 'object'
      if user.preferredLanguage.hasAutotrans
        if(messageSentIn == 'hello-printing' || messageSentIn == 'random')
          roomToAutoTransTo = 'crappypoemsbywilson'
          dataToTrans = {client: 't', hl: 'en', multires: 1, sc: 1, sl: origin, ssel: 0, tl: target, tsel: 0, uptl: "en", text: term}
          msg.http("https://translate.google.com/translate_a/t").query(dataToTrans).header('User-Agent', 'Mozilla/5.0').get() (err, res, body) ->
            data = body
            if data.length > 4 and data[0] == '['
              parsed = eval(data)
            p = parsed[0] and parsed[0][0] and parsed[0][0][0]
            if p
              robot.messageRoom roomToAutoTransTo, p