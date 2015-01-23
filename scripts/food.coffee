# Description
#   A plugin for group based food ordering.
#
# Dependencies:
#   "<module name>": "<module version>"
#
# Configuration:
#   LIST_OF_ENV_VARS_TO_SET
#
# Commands:
#   hubot start order - Start a group order.
#   hubot start order <text> - Start a group order while filtering through available restaurants with the given text.
#
# Notes:
#   See documentation at github.com/ordrin/hungrybot for examples of how to complete a group order.
#
# Author:
#   ordrin

_ = require 'underscore'
orderUtils = require './HungryBotUtils/orderUtils'
local = require './HungryBotUtils/local'

module.exports = (robot) ->

  # A "global" variable containing the state information of the current order.
  HUBOT_APP = {}
  HUBOT_APP.state = 1 #1-listening, 2-Selecting a restaurant 3-gathering orders 4-verify order 5-Placing order

  # Set the initial state of the order.
  initialize = () ->
    # Set the HUBOT_APP to its initial state
    HUBOT_APP.state = 1 #1-listening, 2-Selecting a restaurant 3-gathering orders 4-verify order 5-Placing order
    HUBOT_APP.rid = ""
    HUBOT_APP.users = {} #user state 0 - waiting for order, 1 - waiting for confirmation, 2 - waiting for new request confirmation, 3 - complete
    HUBOT_APP.leader = ''
    HUBOT_APP.restaurants = []
    HUBOT_APP.restaurantLimit = 5

  responseHandlers =
  # Handles any uncaught exceptions.
    error: (err, msg) ->
      console.log err
      if msg?
        console.log err.stack
        console.log msg
        msg.send local.getResponse('error', err: err)

  # Listen for the start of an order.
    startOrder: (msg) ->
      if HUBOT_APP.state is 1
        # A group order has been started
        initialize()
        leader = msg.message.user.name
        HUBOT_APP.leader = leader
        HUBOT_APP.users[leader] = {}
        HUBOT_APP.users[leader].orders = []
        HUBOT_APP.users[leader].state = 0
        msg.send local.getResponse('orderStarted', leader: HUBOT_APP.leader)

        if msg.match[1].trim() isnt ''
          # A cuisine type or restaurant name was selected.
          HUBOT_APP.keywordString = msg.match[1].trim()
          orderUtils.getRelevantRestaurants msg.match[1].trim(), 5, (err, data) ->
            if err
              msg.send err
              return err
            if data.length is 0
              msg.send local.getResponse 'noRestaurants', {}
              return
            HUBOT_APP.restaurants = data
            restaurantsDisplay = ''
            for rest, index in data
              restaurantsDisplay += "(#{index}) #{rest.na}, "
            msg.send local.getResponse('chooseRestaurant', restaurantsDisplay: restaurantsDisplay)
            HUBOT_APP.filtered = true
            HUBOT_APP.state = 2
        else
          # No particular restaurant or cuisine type was selected.
          orderUtils.getUniqueList 5, (err, data) ->
            if err
              msg.send err
              return err
            HUBOT_APP.restaurants = data
            restaurantsDisplay = ''
            for rest, index in data
              restaurantsDisplay += "(#{index}) #{rest.na}, "
            HUBOT_APP.filtered = false
            msg.send local.getResponse('chooseRestaurant', restaurantsDisplay: restaurantsDisplay)
            HUBOT_APP.state = 2

    cancelOrder: (msg) ->
      console.log("cancel order received")
      username = msg.message.user.name
      if username is HUBOT_APP.leader
        msg.send local.getResponse 'cancellingOrder', {}
        HUBOT_APP = {}
        HUBOT_APP.state = 1 #1-listening, 2-Selecting a restaurant 3-gathering orders 4-verify order 5-Placing order

  # Displays more options for restaurant or item selection.
    more: (msg) ->
      user = msg.message.user.name
      if user is HUBOT_APP.leader and HUBOT_APP.state is 2
        # Listen for the leader to ask for more restaurants.
        msg.send local.getResponse 'findMoreRestaurants', {}
        HUBOT_APP.restaurantLimit += 5
        if HUBOT_APP.filtered
          # A cuisine/restaurant filter was entered.
          orderUtils.getRelevantRestaurants HUBOT_APP.keywordString, HUBOT_APP.restaurantLimit, (err, data) ->
            if err
              msg.send err
              return err
            HUBOT_APP.restaurants = data
            restaurantsDisplay = ''
            for rest, index in data
              restaurantsDisplay += "(#{index}) #{rest.na}, "
            msg.send local.getResponse('chooseRestaurant', restaurantsDisplay: restaurantsDisplay)
            HUBOT_APP.state = 2
        else
          # No cuisine/restaurant filter was entered.
          orderUtils.getUniqueList HUBOT_APP.restaurantLimit, (err, data) ->
            if err
              msg.send err
              return err
            HUBOT_APP.restaurants = data
            restaurantsDisplay = ''
            for rest, index in data
              restaurantsDisplay += "(#{index}) #{rest.na}, "
            msg.send local.getResponse('chooseRestaurant', restaurantsDisplay: restaurantsDisplay)
            HUBOT_APP.state = 2
      else if HUBOT_APP.state is 3
        # A user asked for more item selections.
        orderDisplay = ''
        orderLimit = HUBOT_APP.users[user].orderLimit
        if orderLimit + 5 < HUBOT_APP.users[user].currentOrders.length
          for order, index in HUBOT_APP.users[user].currentOrders[orderLimit + 1..orderLimit + 5]
            if order?
              orderDisplay += "(#{orderLimit + 1 + index}) #{order.name} - $#{order.price}, "
          msg.send local.getResponse 'confirmOrder',
            user: user,
            orderDisplay: orderDisplay
          HUBOT_APP.users[user].orderLimit += 5
        else
          msg.send local.getResponse 'noMatches', {}
          HUBOT_APP.users[msg.message.user.name].state = 0

  # Listen for the leader to say that everyone is in.
    finishOrder: (msg) ->
      user = msg.message.user.name
      if user is HUBOT_APP.leader and HUBOT_APP.state is 3
        userString = ''
        _.each HUBOT_APP.users, (user, name) ->
          for order in user.orders
            userString += "#{name}: #{order.name}\n"
        msg.send local.getResponse 'finishOrder',
          leader: HUBOT_APP.leader
          userString: userString
        HUBOT_APP.state = 4

  # Listen for users who want to be removed from the order.
    exitOrder: (msg) ->
      user = msg.message.user.name
      if user isnt HUBOT_APP.leader
        HUBOT_APP.users = _.filter HUBOT_APP.users, (userInOrder) -> userInOrder isnt user
        msg.send local.getResponse('exitOrder', user: user)

  # Listen for the leader to choose a restaurant, or for a user to select a menu item.
    select: (msg) ->
      username = msg.message.user.name
      message = msg.match[1]
      if not isFinite message
        msgArray = message.split(' ')
        message = msgArray[msgArray.length - 1]

      if HUBOT_APP.state is 2 and username is HUBOT_APP.leader
        # The leader is choosing a restaurant from the given choices.
        if isFinite message
          restaurant = HUBOT_APP.restaurants[message]
        else if msg.match[1] in _.pluck HUBOT_APP.restaurants, 'na'
          restaurant = _.findWhere HUBOT_APP.restaurants, na: msg.match[1]
        else if message isnt "more"
          msg.send "I didn't get that. Can you try telling me again?"

        if restaurant?
          cuisineText = "They serve "

          if not restaurant.cu?
            cuisineText = ""
          else if restaurant.cu.length is 1
            cuisineText += restaurant.cu[0] + "."
          else if restaurant.cu.length is 2
            cuisineText += restaurant.cu[0] + " and " + restaurant.cu[1] + "."
          else if restaurant.cu.length > 2
            restaurant.cu[restaurant.cu.length-1] = "and " + restaurant.cu[restaurant.cu.length-1]
            cuisineText += _.reduce(restaurant.cu, (memo, item) -> return memo + ", " + item)
            cuisineText += "."

          msg.send local.getResponse 'restaurantSelected',
            restaurantName: restaurant.na,
            leader: HUBOT_APP.leader
            cuisineText: cuisineText
            mino: restaurant.mino
          HUBOT_APP.rid = "#{restaurant.id}"
          HUBOT_APP.state = 3

      else if HUBOT_APP.state is 3
        # User is deciding on which food to get.
        if HUBOT_APP.users[username]?
          if HUBOT_APP.users[username].state is 1
            if isFinite message
              index = message
              HUBOT_APP.users[username].orders.push(HUBOT_APP.users[username].currentOrders[index])
              HUBOT_APP.users[username].state = 2
              msg.send local.getResponse 'orderSelected',
                username: username,
                selected: HUBOT_APP.users[username].currentOrders[index].name

  # Listen for orders.
    queryMenuItem: (msg) ->
      if isFinite msg.match[1]
        return

      if HUBOT_APP.state is 3
        # A user is asking for a specific type of food.
        user = msg.message.user.name
        if user isnt HUBOT_APP.leader and user not in _.keys(HUBOT_APP.users)
          # This user is just joining the order.
          HUBOT_APP.users[user] = {}
          HUBOT_APP.users[user].state = 0
          HUBOT_APP.users[user].orders = []
          msg.send local.getResponse('joinOrder', user: user)

        if HUBOT_APP.users[user].state in [0, 1, 2]
          order = escape(msg.match[1])

          orderUtils.getRelevantMenuItems(HUBOT_APP.rid, order,
            (err, data) ->
              if err
                console.log err
                msg.send local.getResponse 'noMatches', {}
                return err

              if data.length > 0
                orderDisplay = ''
                for order, index in data
                  orderDisplay += "(#{index}) #{order.name} - $#{order.price}, "
                  if index > 4
                    break
                msg.send local.getResponse 'confirmOrder',
                  user: user,
                  orderDisplay: orderDisplay
                HUBOT_APP.users[msg.message.user.name].currentOrders = data
                HUBOT_APP.users[msg.message.user.name].state = 1
                HUBOT_APP.users[msg.message.user.name].orderLimit = 5
              else
                msg.send local.getResponse 'noMatches', {}
          )

  # Listen for orders.
    randomItem: (msg) ->
      if HUBOT_APP.state is 3
        # A user is asking for a specific type of food.
        user = msg.message.user.name
        if user isnt HUBOT_APP.leader and user not in _.keys(HUBOT_APP.users)
          # This user is just joining the order.
          HUBOT_APP.users[user] = {}
          HUBOT_APP.users[user].state = 0
          HUBOT_APP.users[user].orders = []
          msg.send local.getResponse('joinOrder', user: user)

        if HUBOT_APP.users[user].state in [0, 1, 2]

          orderUtils.getRelevantMenuItems(HUBOT_APP.rid, '',
            (err, data) ->
              if err
                console.log err
                msg.send local.getResponse 'noMatches', {}
                return err

              if data.length > 0
                orderDisplay = ''
                for order, index in data
                  orderDisplay += "(#{index}) #{order.name} - $#{order.price}, "
                  if index > 4
                    break
                msg.send local.getResponse 'confirmOrder',
                  user: user,
                  orderDisplay: orderDisplay
                HUBOT_APP.users[msg.message.user.name].currentOrders = data
                HUBOT_APP.users[msg.message.user.name].state = 1
                HUBOT_APP.users[msg.message.user.name].orderLimit = 5
              else
                msg.send local.getResponse 'noMatches', {}
          )

  # Listen for confirmation
    confirm: (msg) ->
      username = msg.message.user.name
      if HUBOT_APP.state is 3 and HUBOT_APP.users[username].state is 2
        # The user wants more food.
        msg.send local.getResponse('orderMore', username: username)
        HUBOT_APP.users[username].state = 0

  # Listen for confirmation
    decline: (msg) ->
      username = msg.message.user.name
      if HUBOT_APP.state is 3 and HUBOT_APP.users[username].state is 2
        # This user is finished ordering.
        HUBOT_APP.users[username].state = 3
        msg.send local.getResponse('userIsDone', username: username)
      else if HUBOT_APP.state is 3 and HUBOT_APP.users[username].state is 1
        # This user does not want any of the suggested items.
        msg.send local.getResponse('userWantsMore', username: username)
        HUBOT_APP.users[username].state = 0
      else if HUBOT_APP.state is 4
        # The order is not finished yet.
        msg.send local.getResponse 'keepListeningForOrders', {}
        HUBOT_APP.state = 3

  # Ask for tip
    placeOrder: (msg) ->
      username = msg.message.user.name
      if HUBOT_APP.state is 4 and username is HUBOT_APP.leader

        traySubtotal = 0
        _.each HUBOT_APP.users, (user) ->
          for order in user.orders
            traySubtotal += parseFloat(order.price)

        HUBOT_APP.subtotal = traySubtotal

        msg.send "How much would you like to tip? Please enter in the format '#.##' or as a percentage '##%'"
        msg.send "10% - #{(traySubtotal*.10).toFixed(2)}, 15% - #{(traySubtotal*.15).toFixed(2)}, 20% - #{(traySubtotal*.2).toFixed(2)}"

        HUBOT_APP.state = 6

  # Everything is finished, and the order can be placed.
    tipTotal: (msg) ->
      username = msg.message.user.name
      if HUBOT_APP.state is 6 and username is HUBOT_APP.leader
        tip = msg.match[0].substring(msg.robot.name.length).trim()

        # confirm and place order
        tray = ''
        _.each HUBOT_APP.users, (user) ->
          for order in user.orders
            tray += "+#{order.tray}"

        params =
          rid: HUBOT_APP.rid
          tray: tray.substring(1)
          tip: tip

        msg.send local.getResponse 'placingOrder', {}
        HUBOT_APP.state = 5
        orderUtils.placeOrder params, (err, data) ->
          if err
            console.log err
            msg.send local.getResponse('orderError', err: err.body._msg)
            HUBOT_APP.state = 1
            return err
          msg.send local.getResponse('orderPlaced', msg: data.msg)
          HUBOT_APP.state = 1

    tipPercentage: (msg) ->
      username = msg.message.user.name
      if HUBOT_APP.state is 6 and username is HUBOT_APP.leader
        tipPercentage = msg.match[1]

        # confirm and place order
        tray = ''
        _.each HUBOT_APP.users, (user) ->
          for order in user.orders
            tray += "+#{order.tray}"

        tip = HUBOT_APP.subtotal * parseInt(tipPercentage) / 100
        tip = tip.toFixed(2)

        params =
          rid: HUBOT_APP.rid
          tray: tray.substring(1)
          tip: tip

        msg.send local.getResponse 'placingOrder', {}
        HUBOT_APP.state = 5
        orderUtils.placeOrder params, (err, data) ->
          if err
            console.log err
            msg.send local.getResponse('orderError', err: err.body._msg)
            HUBOT_APP.state = 1
            return err
          msg.send local.getResponse('orderPlaced', msg: data.msg)
          HUBOT_APP.state = 1

  # Display orders for each user.
    displayOrders: (msg) ->
      orderDisplay = ''
      for name in _.keys(HUBOT_APP.users)
        user = HUBOT_APP.users[name]
        for order in user.orders
          orderDisplay += "#{name}: #{order.name} - #{order.price}\n"
      msg.send orderDisplay

  # Map listeners to functions.
  mapHandlersToListeners = () ->
    _.each local.listeners, (expressions, name) ->
      for regex in expressions
        robot.respond regex, responseHandlers[name]

  mapHandlersToListeners()