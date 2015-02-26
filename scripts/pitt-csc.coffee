# Description:
#   Cowsay.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot cowsay <statement> - Returns a cow that says what you want
#
# Author:
#   brettbuddin
benedicts = [
  "BENEDICT",
  "BAILIWICK",
  "BORNFREE",
  "BARSTOOLINGTON",
  "BORINGTEDTALK",
  "BRATWURST",
  "BATMITZVAH",
  "BATHYSPHERE",
  "BATTLEMENT",
  "BENTO BOX",
  "BENEVOLENT",
  "BENDYSTRAWS",
  "BUNDYSTRICT",
  "BANDERSNATCH",
  "BEERSANDWICH",
  "BALACLAVA",
  "BALTHAZAR",
  "BALACLAVA",
  "BARCALOUNGER"
  "BARNDOOR"
  "BENELUX"
  "BEERBELLY"
  "BEECHNUT"
  "BEANCOUNTER"
  "BRANDYWITCH"
  "BANDICOOT"
  "BATTLESHIP"
  "BUTTERSCOTCH"
  "BLUNDERBUSS"
]

cumberbatches = [
  "CARBUNCLE",
  "COREPOWER",
  "CARBURETOR",
  "CAMBRIANAGE",
  "CUMBERBATCH",
  "CAMISOLE",
  "CAMELBACK",
  "CAMOUFLAGE",
  "CHLOROFORM",
  "CLAM-DIGGERS",
  "CAMEMBERT",
  "CUMMERBUND",
  "MONTALBAN",
  "COMBOBRATS",
  "CULPABILITY",
  "CAMBOZOLA",
  "CHRONOTRIGGER",
  "CLAMBAKE",
  "STACKEXCHANGE",
  "CRUMBLECAKE",
  "DUMBLEDORE",
  "CARROTCAKE",
  "CHAMBERPOT",
  "COFFEEPOT",
  "CLINKERFUZZ",
  "CLOISTERFARM"
]
module.exports = (robot) ->
  robot.respond /cowsay( me)? (.*)/i, (msg) ->
    msg
    .http("http://cowsay.morecode.org/say")
    .query(format: 'text', message: msg.match[2])
    .get() (err, res, body) ->
      msg.send "```\n#{body}```"

  robot.hear /benedict cumberbatch/i, (msg) ->
    benedict = msg.random benedicts
    cumberbatch = msg.random cumberbatches
    msg.send "#{benedict} #{cumberbatch}!"