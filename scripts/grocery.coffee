# Description:
#   Allows groceries to be added to Hubot
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot grocery add <grocery> - Add a grocery
#   hubot grocery list groceries - List the groceries
#   hubot grocery delete <grocery number> - Delete a grocery
#
# Author:
#   Michael-Hopkins

class Groceries
  constructor: (@robot) ->
    @cache = []
    @robot.brain.on 'loaded', =>
      if @robot.brain.data.groceries
        @cache = @robot.brain.data.groceries
  nextGroceryNum: ->
    maxGroceryNum = if @cache.length then Math.max.apply(Math,@cache.map (n) -> n.num) else 0
    maxGroceryNum++
    maxGroceryNum
  add: (groceryString) ->
    grocery = {num: @nextGroceryNum(), grocery: groceryString}
    @cache.push grocery
    @robot.brain.data.groceries = @cache
    grocery
  all: -> @cache
  deleteByNumber: (num) ->
    index = @cache.map((n) -> n.num).indexOf(parseInt(num))
    grocery = @cache.splice(index, 1)[0]
    @robot.brain.data.groceries = @cache
    grocery

module.exports = (robot) ->
  groceries = new Groceries robot

#  robot.respond /(grocery add|add grocery) (.+?)$/i, (msg) ->
#    grocery = groceries.add msg.match[2]
#    msg.send "Grocery added: ##{grocery.num} - #{grocery.grocery}"

#  robot.respond /(grocery list|list groceries)/i, (msg) ->
#    if groceries.all().length > 0
#      response = ""
#      for grocery, num in groceries.all()
#        response += "##{grocery.num} - #{grocery.grocery}\n"
#      msg.send response
#    else
#      msg.send "There are no groceries"

#  robot.respond /(grocery delete|delete grocery) #?(\d+)/i, (msg) ->
#    groceryNum = msg.match[2]
#    grocery = groceries.deleteByNumber groceryNum
#    msg.send "Grocery deleted: ##{grocery.num} - #{grocery.grocery}"