# An object mapping function names to ther listener regular expressions.
listeners =
  startOrder: [/start order(.*)$/i, /let's order food from(.*)/i, /let's get (.*) food/i, /let's order (.*) food/i]
  more: [/\bmore\b/i]
  finishOrder: [/(.*)\bdone\b(.*)/i]
  exitOrder: [/I'm out$/i, /quit$/i, /bye$/i]
  select: [/(.*)/i]
  tipTotal: [/(([1-9]\d{0,2}(,\d{3})*)|(([1-9]\d*)?\d))(\.\d\d)/i]
  tipPercentage: [/(\d+)%/i]
  queryMenuItem: [/I want (.*)/i, /give me (.*)/i]
  randomItem: [/suggest something/i]
  confirm: [/(.*)\byes\b(.*)/i, /sure$/i, /yea$/i, /yep$/i]
  decline: [/(.*)\bno\b(.*)/i]
  cancelOrder: [/cancel order/i]
  placeOrder: [/place order/i]
  displayOrders: [/show orders$/i]

# An object containing strings that the bot uses for responding to users.
getResponse = (response, params) ->

  responses =
    error: "Something bad happened! #{params.err}"
    orderStarted: "#{params.leader} is the leader, and has started a group order. Wait while I find some cool nearby restaurants."
    noRestaurants: "There were no restaurants that fit that description. Try again."
    chooseRestaurant: "Tell me a restaurant to choose from: #{params.restaurantsDisplay} (say \"more\" to see more restaurants)"
    findMoreRestaurants: "Alright let me find more restaurants."
    confirmOrder: "#{params.user} how about any of these?: #{params.orderDisplay} tell me \"no\" if you want something else, and \"more\" to see more options."
    noMatches: "There are no more matches for that item. Sorry! Try again."
    finishOrder: "Awesome! Lets place this order. Here is what everyone wants:\n #{params.userString}\nIs this correct? #{params.leader} tell me \"place order\" when you are ready, and \"no\" if you wish to keep ordering."
    exitOrder: "I'm sorry to hear that. Looks like #{params.user} doesn't want to get food with us."
    restaurantSelected: "Alright lets order from #{params.restaurantName}! #{params.cuisineText} The minimum order amount is $#{params.mino}. Everyone enter the name of the item from the menu that you want. #{params.leader}, tell me when you are done. Tell me \"I'm out\" if you want to cancel your order."
    orderSelected: "Cool. #{params.username} is getting #{params.selected}. #{params.username}, do you want anything else?"
    joinOrder: "Awesome! #{params.user} is in!"
    orderMore: "Wow #{params.username}, you sure can eat a lot! What do you want?"
    userIsDone: "#{params.username}, hold on while everyone else orders!"
    userWantsMore: "Well, #{params.username} what DO you want then?"
    keepListeningForOrders: "It's all good. I'll keep listening for orders!"
    placingOrder: "Placing order. Please wait for me to confirm that everything was correct."
    orderError: "Sorry! We messed up: #{params.err}"
    cancellingOrder: "Cancelled the current order."
    orderPlaced: "Order placed: #{params.msg}"

  return responses[response]

module.exports =
  listeners: listeners
  getResponse: getResponse