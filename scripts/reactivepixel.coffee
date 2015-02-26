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
#   hubot nasa pic - gets the NASA Astronomy Picture of the Day for today.
#   hubot nasa pic <date> - gets the NASA Astronomy Picture of the Day for a specific date
#   hubot pokedex <pokemonName> - A real live pokedex
#   hubot mug me - Gives you a random mug shot.
#   hubot marvel <character> - Will get information about a character from Marvel.
#   hubot marvel Iron Man - Will return information about Iron Man.
#   hubot happy <city name> - Get happy hour info
#   hubot random fact
#   hubot lets conquer - hubot will pick your random conqueror name.
#   hubot (throw|flip|toss) a coin - hubot will flip a coin (heads or tails, who knows)
#   hubot (throw|flip|toss) <number> coins - hubot will flip lots of coins
#   hubot clear desktop - clears the desktop avg line height
#   hubot clear mobile - clears the mobile avg line height
#   hubot clear tablet - clears the tablet avg line height
#   hubot chuck me - random Chuck Norris fact.
#   hubot chuck me <user> - let's see how <user> would do as Chuck Norris
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