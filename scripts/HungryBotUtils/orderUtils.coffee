ordrin = require 'ordrin-api'
request = require 'request'
_ = require 'underscore'

email = process.env.HUBOT_ORDRIN_EMAIL
password = process.env.HUBOT_ORDRIN_PASSWORD
firstName = process.env.HUBOT_ORDRIN_FIRST_NAME
lastName = process.env.HUBOT_ORDRIN_LAST_NAME

servers = {}

servers.TEST =
  restaurants: "https://foodbot.ordr.in:7000"
  user: "https://foodbot.ordr.in:7000"
  order: "https://foodbot.ordr.in:7000"

servers.PRODUCTION =
  restaurants: "https://foodbot.ordr.in"
  user: "https://foodbot.ordr.in"
  order: "https://foodbot.ordr.in"

ordrinApi = new ordrin.APIs "0000000000000000000", servers.PRODUCTION

placeOrder = (params, cb) ->
  options =
    'rid': params.rid
    'email': email
    'current_password': password
    'tray': params.tray
    'tip': params.tip
    'first_name': firstName
    'last_name': lastName
    'delivery_date': 'ASAP'
    'nick': 'groupLocation'
    'card_nick': 'groupCard'

  ordrinApi.order_user options, cb

getRelevantMenuItems = (rid, desc, cb) ->
  request "http://foodbot.ordr.in:8000/TextSearch?rid=#{rid}&target=#{desc}&size=15",
    (err, res, body) ->
      if err
        console.log err
        return cb err

      cb null, JSON.parse(body)

getRelevantRestaurants = (name, limit, cb) ->
  ordrinApi.get_saved_addr
    email: email
    current_password: password
    nick: 'groupLocation',
    (err, result) ->
      if err
        console.log err
        return err
      ordrinApi.delivery_list(
        datetime: 'ASAP'
        addr: result.addr
        city: result.city
        zip:  result.zip,

        (err, restaurants) ->
          if err
            console.log err
            return cb err
          name = name.toLowerCase()

          relevantRestaurants = []
          for restaurant in restaurants
            if restaurant.is_delivering
              restContainsCuisine = _.contains _.map(restaurant.cu, (rest) -> rest.toLowerCase()), name
              restContainsName = restaurant.na.toLowerCase().indexOf(name) isnt -1
              if restContainsCuisine or restContainsName
                relevantRestaurants.push restaurant
              if relevantRestaurants.length > limit
                return cb null, relevantRestaurants

          cb null, relevantRestaurants
      )

getUniqueList = (size, cb) ->
  ordrinApi.get_saved_addr
    email: email
    current_password: password
    nick: 'groupLocation',
    (err, result) ->
      if err
        console.log err
        return err
      ordrinApi.delivery_list(
        datetime: 'ASAP'
        addr: result.addr
        city: result.city
        zip: result.zip,

        (err, rest_list) ->
          if err
            console.log err
            return cb err

          #remove rests that are not currently delivering
          for i in rest_list.length by 1
            if not rest_list[i].is_delivering
              rest_list = rest_list.splice(i, 1)
              i--

          unique_list = []
          cuisines = []

          while rest_list.length isnt 0 and unique_list.length < size

            random_i = Math.floor(Math.random() * rest_list.length)

            if rest_list[random_i].cu
              for cuisine in rest_list[random_i].cu
                if((cuisines.indexOf cuisine) is -1)
                  unique_list.push rest_list[random_i]
                  cuisines = cuisines.concat rest_list[random_i].cu
                  break

            rest_list.splice random_i, 1

          cb null, unique_list
      )

module.exports =
  placeOrder: placeOrder
  getRelevantMenuItems: getRelevantMenuItems
  getRelevantRestaurants: getRelevantRestaurants
  getUniqueList: getUniqueList