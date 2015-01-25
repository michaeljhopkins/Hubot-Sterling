# Description:
# Pulls a random gif (optionally by tag[s]) from Giphy
#
# Dependencies:
# none
#
# Configuration:
# process.env.HUBOT_GIPHY_API_KEY = <your giphy API key>
#
# Commands:
# !<tag> - Get a random gif with your tag
# hubot gif set sfw limit - Set the SFW guard limit, 0 = 'y', 1 = 'g', 2 = 'pg', 3 = 'pg-13', 4 = 'r'
# hubot gif get sfw limit - Get the current SFW guard limit (0 - 4)
# hubot gif enable sfw guard - Enable SFW guard
# hubot gif disable  sfw guard - Disable SFW guard
# hubot gif get sfw status - Get the current SFW guard status (enabled/disabled)

api_key = 'dc6zaTOxFJmzC'

giphy_ratings = {
  'y': 0,
  'g': 1,
  'pg': 2,
  'pg-13': 3,
  'r': 4
}
sfw_guard = true
sfw_limit = 2

getRandomGiphyGif = (msg, tags) ->
  url = 'http://api.giphy.com/v1/gifs/random?api_key='+api_key
  if tags and tags[0] != ''
    url += '&tag=' + tags[0]
    for i in [1...tags.length]
      url += ('+' + tags[i]) if tags[i].length > 0
  msg.http(url).get() (err, res, body) ->
    response = JSON.parse(body);
    if sfw_guard
      if response.data.rating and giphy_ratings[response.data.rating] <= sfw_limit
        msg.send(response.data.image_url)
      else
        msg.send('SFW guard activated, gif blocked. You\'re welcome.')
    else
      msg.send(response.data.image_url)

setSFWGuardLimit = (msg, limit) ->
  if limit < giphy_ratings['y']
    msg.send('Invalid limit, setting to 0')
    sfw_limit = giphy_ratings['y']
  else if limit > giphy_ratings['r']
    msg.send('Invalid limit, setting to 4')
    sfw_limit = giphy_ratings['r']
  else
    sfw_limit = limit
  msg.send('SFW guard limit set to ' + sfw_limit)

getSFWGuardLimit = (msg) ->
  msg.send('SFW guard limit set to ' + sfw_limit)

setSFWGuardStatus = (msg, value) ->
  sfw_guard = value
  getSFWGuardStatus(msg)

getSFWGuardStatus = (msg) ->
  status = if sfw_guard then 'enabled' else 'disabled'
  msg.send('SFW guard is ' + status)

module.exports = (robot) ->
  robot.hear /^!(.*)/i, (msg) ->
    tags = msg.match[1]
    getRandomGiphyGif(msg, tags)

  robot.respond /gif set sfw limit(\d)/i, (msg) ->
    limit = msg.match[1]
    setSFWGuardLimit(msg, limit)

  robot.respond /gif get sfw limit/i, (msg) ->
    getSFWGuardLimit(msg)

  robot.respond /gif enable sfw guard/i, (msg) ->
    setSFWGuardStatus(msg, true)

  robot.respond /gif disable sfw guard/i, (msg) ->
    setSFWGuardStatus(msg, false)

  robot.respond /gif get sfw status/i, (msg) ->
    getSFWGuardStatus(msg)