# Description:
#   Build a markov model based on everything that Hubot sees. Construct markov
#   chains based on its accumulated history on demand, to produce plausible-
#   sounding and occasionally hilarious nonsense.
#
#   While this is written to support any order of markov model, extensive
#   experimentation has shown that order 1 produces the most funny. Higher-
#   order models occupy a *lot* more storage space and frequently produce
#   exact quotes.
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_MARKOV_PLY - Order of the markov model to build. Default: 1
#   HUBOT_MARKOV_LEARN_MIN - Minimum number of tokens to use in training. Default: 1
#   HUBOT_MARKOV_GENERATE_MAX - Maximum number of tokens in a generated chain. Default: 50
#   HUBOT_MARKOV_RESPOND_CHANCE - Chance for hubot to respond automatically
#   HUBOT_TWITTER_CONSUMER_KEY - twitter
#   HUBOT_TWITTER_CONSUMER_SECRET - twitter
#   HUBOT_TWITTER_ACCESS_TOKEN - twitter
#   HUBOT_TWITTER_ACCESS_SECRET - twitter
#
# Commands:
#   hubot markov <seed> - Generate a markov chain, optionally seeded with the provided phrase.
#
# Author:
#   smashwilson

Url = require 'url'
Redis = require 'redis'
twitter = require 'simple-twitter'

MarkovModel = require './model'
RedisStorage = require './redis-storage'

module.exports = (robot) ->

  # Configure redis the same way that redis-brain does.
  info = Url.parse process.env.REDISTOGO_URL or
    process.env.REDISCLOUD_URL or
    process.env.BOXEN_REDIS_URL or
    'redis://localhost:6379'
  client = Redis.createClient(info.port, info.hostname)

  if info.auth
    client.auth info.auth.split(":")[1]

  storage = new RedisStorage(client)

  # Read markov-specific configuration from the environment.
  ply = process.env.HUBOT_MARKOV_PLY or 1
  min = process.env.HUBOT_MARKOV_LEARN_MIN or 1
  max = process.env.HUBOT_MARKOV_GENERATE_MAX or 50
  pct = Number(process.env.HUBOT_MARKOV_RESPOND_CHANCE or 0)

  # Start up Twitter stuff
  twitter = new twitter(process.env.HUBOT_TWITTER_CONSUMER_KEY,
    process.env.HUBOT_TWITTER_CONSUMER_SECRET,
    process.env.HUBOT_TWITTER_ACCESS_TOKEN,
    process.env.HUBOT_TWITTER_ACCESS_SECRET)

  model = new MarkovModel(storage, ply, min)

  robot.brain.on 'loaded', =>
    robot.brain.data.markovs ||= {}

  # The robot hears ALL. You cannot run.
  robot.catchAll (msg) ->

    # Return on empty messages
    return if !msg.message.text

    model.learn msg.message.text

    # Chance to randomly respond un-prompted
    if (msg.message.room == 'keepin-it-real' || msg.message.room == 'sansbossman')
      if pct > 0 and Math.random() < pct
        seed = msg.message.text.match /\w+$/
        model.generate seed[0] or '', max, (text) =>
          msg.send text

  # Generate markov chains on demand, optionally seeded by some initial state.
  robot.respond /markov(\s+(.+))?$/i, (msg) ->
    model.generate msg.match[2] or '', max, (text) =>
      msg.send text
      robot.brain.data.markovs[msg.message.room] or= []
      robot.brain.data.markovs[msg.message.room] = text

  robot.respond /tweet\sthat/i, (msg) ->
    if (tweet = robot.brain.data.markovs[msg.message.room])
      twitter.post('statuses/update', {'status' : tweet})
    delete robot.brain.data.markovs[msg.message.room]