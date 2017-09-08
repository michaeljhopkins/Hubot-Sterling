# Description:
#   Sterling really likes the Verve Pipe
#   Some fun business response images
#   Robot is very encouraging
#   Insert Pictures of Magic: The Gathering Cards
#   http://xkcd.com/1009/
#   Makes hubot act as Tony Montana.
#
# Dependencies:
#   None
#
# Commands:
#   hubot encourage me
#   hubot encourge name
#   hubot encourage all
#   hubot cast <card name> - a picture of the named magic card
#   hubot nettipot - Send scarring, horrifying image of a nettipot in use.
#   hubot nettibomb - Send a nettibomb
#
# Author:
#   michael-hopkins
#
# Notes:
#   FOOOOOR THE LIFE OF MEEEEE!

querystring = require 'querystring';

remarks = [
  "Great job, %!",
  "Way to go, %!",
  "% is amazing, and everyone should be happy this amazing person is around.",
  "I wish I was more like %.",
  "% is good at like, 10 times more things than I am.",
  "%, you are an incredibly sensitive person who inspires joyous feelings in all those around you.",
  "%, you are crazy, but in a good way.",
  "% has a phenomenal attitude.",
  "% is a great part of the team!",
  "I admire %'s strength and perseverance.",
  "% is a problem-solver and cooperative teammate.",
  "% is the wind beneath my wings.",
  "% has a great reputation.",
  "No. % is sort of an ass"
]
allinclusive = [
  "Great job today, everyone!",
  "Go team!",
  "Super duper, gang!",
  "If I could afford it, I would buy you all lunch!",
  "What a great group of individuals there are in here. I'm proud to be chatting with you.",
  "You all are capable of accomplishing whatever you set your mind to.",
  "I love this team's different way of looking at things!"
]

module.exports = (robot) ->

  # freshman
  robot.hear /for the life of me/i, (msg) ->
    msg.reply "Fooor the life of meeee....IIII cannot remember what made us think that we were wise and we'd never compromise!"
    msg.reply "For the life of me....I cannot believe we'd ever die for these sins; we were merely freshmen."
  robot.respond /whats your favorite song\?/i, (msg) ->
    msg.reply "Fooor the life of meeee....IIII cannot remember what made us think that we were wise and we'd never compromise!"
    msg.reply "For the life of me....I cannot believe we'd ever die for these sins; we were merely freshmen."

  # encourage
  robot.respond /(encourage )(.*)/i, (msg) ->
    encourage = msg.random remarks
    if msg.match[2] == 'me'
      msg.send encourage.replace "%", msg.message.user.name
    else if msg.match[2] == 'all'
      msg.send msg.random allinclusive
    else
      msg.send encourage.replace "%", msg.match[2]

  # mtg
  robot.respond /cast (.+)/i, (msg) ->
    url = "http://gatherer.wizards.com/Handlers/Image.ashx"
    card = msg.match[1] || "Dismal%20Failure"
    query = { type: "card", name: card }
    msg.send "#{url}?#{querystring.stringify(query)}#.jpg"

  # sigh
  sigh_counter = 0
  robot.hear /(^|\W)[s]+[i]+[g]+[h]+(\z|\W|$)/i, (msg) ->
    if sigh_counter == 3
      sigh_counter = 0
      msg.send "I work out"
    else
      sigh_counter += 1
      msg.send "Girl look at that body"

  # business
  business_counter = 0
  late_counter = 0
  robot.hear /( business )/i, (msg) ->
    if business_counter == 3
      business_counter = 0
      msg.send "HAHA BUSINESS!"
      msg.send "http://i.imgur.com/6wGCVmv.jpg"
    else
      business_counter += 1
  robot.hear /( late )/i, (msg) ->
    if late_counter == 3
      late_counter = 0
      msg.send "I'm late for business!"
      msg.send "https://i.imgur.com/WkQlv.jpg"
    else
      late_counter += 1

  # Liona triggers
  robot.hear /^tableflip/i, (msg) ->
    msg.send "(╯°□°)╯︵ ┻━┻"
  robot.hear /^dunno/i, (msg) ->
    msg.send " ¯\\_(ツ)_/¯"
  robot.hear /^unstoppable/i, (msg) ->
    msg.send "I am unstoppable!!! http://i.imgur.com/ALHS4Za.png"
  robot.hear /^drama/i, (msg) ->
    msg.send "I just can't take it anymore...."