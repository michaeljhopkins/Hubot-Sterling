# Description:
#   Hubot sends a random Chuck Norris fact
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot chuck me -- random Chuck Norris fact.
#   hubot chuck me <user> -- let's see how <user> would do as Chuck Norris
#
# Author:
#   Seth Healy


module.exports = (robot) ->
  # I am calling my hubot here in 2 different ways.
  # One being Chuck me where hubot will tell a Chuck Norris joke.
  # Second one being Chuck me <user> where you can insert a user name and hubot will tell a joke
  # but with your name.

  robot.respond /(chuck me)(me)?(.*)/i,(msg)->
    olduser = msg.match[3]
    user = olduser.replace /\s{2,}/g, ""
    # I am calling the api here for the the Chuck me feature.
    if user.length == 0
      Chuck msg, "http://api.icndb.com/jokes/random"
      # Here is my else statement for if they add their name to it hubot will put their name in the
      # joke.
    else
      Chuck msg, "http://api.icndb.com/jokes/random?firstName="+user+"&lastName="

  # Here is my varible for Chuck so I can send my msg.
  Chuck = (msg, url) ->
    msg.http(url)
    .get() (err, res, body) ->
      # My error message in case something fails.
      if err
        msg.send "Chuck Norris says: #{err}"
      else
        message_from_chuck = JSON.parse(body)
        # If my length goes to zero this error message will show.
        if message_from_chuck.length == 0
          msg.send "Achievement unlocked: Chuck Norris is quiet!"
        else
          # Replaces quotes with ASCII characters.
          msg.send message_from_chuck.value.joke.replace /&quot;/g, ""