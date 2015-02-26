# Description:
# Get the first item from Google Shopping
#
# Commands:
# hubot price <query> - Get Price from Google Shopping

module.exports = (robot) ->
  robot.respond /price (.*)/i, (msg) ->
    msg.http("https://www.googleapis.com/shopping/search/v1/public/products?key=********&country=US&q=#{msg.match[1]}&alt=json").get() (err, res, body) ->
      json = JSON.parse(body)
      title = json['items'][0]['product']['title']
      price = json['items'][0]['product']['inventories'][0]['price']
      link = json['items'][0]['product']['images'][0]['link']
      msg.send title + " - " + price
      msg.send link