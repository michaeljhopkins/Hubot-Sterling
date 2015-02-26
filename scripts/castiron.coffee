# Description:
#   [hubot] makes you a video with crumbles (http://www.crumbles.co)
#
# Commands:
#   crumbles (me) [text] outputs a link to the crumblized video
#   crumbles (me) [text]:[dictionary] outputs a link to the crumblized video with the dictonary specified
#
#   NB: Since Crumbles is new (and the dictionary list is probably growing),
#   there isn't a list of dictionaries or any sanitization on the :[dictionary] command.
#   dictionary parameters can be found by playing around on http://www.crumbles.co.
#   In the future, a more structured command may be added
#

class Crumbler
  querify: (input) ->
    # Use to remove punctuation if query contains any
    query = input.replace(/[^a-zA-Z\d\s]/g, '');
    return encodeURIComponent(query)

module.exports = (robot) ->
  crumbler = new Crumbler;
  robot.respond /crumble(s ?)? (me ?)?([^:]+)(:[a-zA-Z_]+)?/i, (msg) ->
    if msg.match[4] then dictionary = msg.match[4].replace(':', '') else dictionary = 'standard'
    msg.send 'https://www.crumbles.co/?crumble=' + crumbler.querify(msg.match[3]) + '&dictionary=' + dictionary
