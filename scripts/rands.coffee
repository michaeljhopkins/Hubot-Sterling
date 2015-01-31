# Description
#   A slightly incomplete collection of "When you say..." tweets from @rands
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot rands - A nugget of Randsian wisdom is dispensed
#   hubot rands count - The number of wisdom nuggets is returned
#
# Notes:
#   None
#
# Author:
#   pberry

module.exports = (robot) ->
  wisdom = [
    "http://twitter.com/rands/statuses/11309449247",
    "http://twitter.com/rands/status/289893035150569472",
    "http://twitter.com/rands/status/214741618916466689",
    "http://twitter.com/rands/status/217635293484945408",
    "http://twitter.com/rands/status/220188892094152704",
    "http://twitter.com/rands/status/226375945521610753",
    "http://twitter.com/rands/status/235153466081808385",
    "http://twitter.com/rands/status/236987129513775104",
    "http://twitter.com/rands/status/237919382687334400",
    "http://twitter.com/rands/status/243698273116889088",
    "http://twitter.com/rands/status/244821499880562688",
    "http://twitter.com/rands/status/245540962162593793",
    "http://twitter.com/rands/status/247686950448943104",
    "http://twitter.com/rands/status/248565054948130817",
    "http://twitter.com/rands/status/252794850494267392",
    "http://twitter.com/rands/status/253970014825218048",
    "http://twitter.com/rands/status/255896683571978240",
    "http://twitter.com/rands/status/259162088503664640",
    "http://twitter.com/rands/status/261866058628091904",
    "http://twitter.com/rands/status/262089106551619585",
    "http://twitter.com/rands/status/264393818214899712",
    "http://twitter.com/rands/status/273951473157689344",
    "http://twitter.com/rands/status/275841713367556096",
    "http://twitter.com/rands/status/280899714336038912",
    "http://twitter.com/rands/status/281822856877322240",
    "http://twitter.com/rands/status/289485121361424384",
    "http://twitter.com/rands/statuses/28432698384",
    "http://twitter.com/rands/statuses/6472192856",
    "http://twitter.com/rands/statuses/26584224990",
    "http://twitter.com/rands/statuses/202847708271230976",
    "http://twitter.com/rands/statuses/235153466081808385",
    "http://twitter.com/rands/statuses/189203032905494529",
    "http://twitter.com/rands/statuses/99521172005326848",
    "http://twitter.com/rands/statuses/139152607083102208",
    "http://twitter.com/rands/statuses/20333834621",
    "http://twitter.com/rands/statuses/133345216886345729",
    "http://twitter.com/rands/statuses/156172596143063040",
    "http://twitter.com/rands/statuses/108597258055979008",
    "http://twitter.com/rands/statuses/189049908639186944",
    "http://twitter.com/rands/statuses/4345861202",
    "http://twitter.com/rands/statuses/21933940584",
    "http://twitter.com/rands/statuses/25998859249",
    "http://twitter.com/rands/statuses/131426938597277696",
    "http://twitter.com/rands/statuses/158647734558138368",
    "http://twitter.com/rands/statuses/182492475724800001",
    "http://twitter.com/rands/statuses/56076748953092098",
    "http://twitter.com/rands/statuses/43792659864760320",
    "http://twitter.com/rands/statuses/54290475783421952",
    "http://twitter.com/rands/statuses/152954436640182273",
    "http://twitter.com/rands/statuses/22001311155228674",
    "http://twitter.com/rands/statuses/53247126817345537",
    "http://twitter.com/rands/statuses/19513088389",
    "http://twitter.com/rands/statuses/22581884963",
    "http://twitter.com/rands/statuses/93400188479221760",
    "http://twitter.com/rands/statuses/156260385010356224",
    "http://twitter.com/rands/statuses/2793071211",
    "http://twitter.com/rands/statuses/14458189005",
    "http://twitter.com/rands/statuses/193155583938002944",
    "http://twitter.com/rands/statuses/22031352673",
    "http://twitter.com/rands/statuses/182113521876729856",
    "http://twitter.com/rands/statuses/24694739571",
    "http://twitter.com/rands/statuses/26384939022",
    "http://twitter.com/rands/statuses/159808299779358720",
    "http://twitter.com/rands/statuses/11876666225725440",
    "http://twitter.com/rands/statuses/19799390667415552",
    "http://twitter.com/rands/statuses/132114748086030337",
    "http://twitter.com/rands/statuses/6090022746",
    "http://twitter.com/rands/statuses/144102532220858368",
    "http://twitter.com/rands/statuses/83340096601993216",
    "http://twitter.com/rands/statuses/52036340375764992",
    "http://twitter.com/rands/status/294480995644743680",
    "http://twitter.com/rands/status/306933143703781377",
    "http://twitter.com/rands/status/300290819913555972",
    "http://twitter.com/rands/status/317647183547621376",
    "http://twitter.com/rands/status/326919083364847616",
    "http://twitter.com/rands/status/330570233339334656",
    "http://twitter.com/rands/status/358258824701947904",
    "http://twitter.com/rands/status/364934241697542144",
    "http://twitter.com/rands/status/400741704442990592",
    "http://twitter.com/rands/status/422980222099529728",
    "http://twitter.com/rands/status/434793516573532160",
    "http://twitter.com/rands/status/437682992018776064"
  ]
  robot.respond /rands$/i, (msg) ->
    msg.send msg.random wisdom
  robot.respond /rands count$/i, (msg) ->
    msg.send("I currently have #{wisdom.length} Randisms in my database.")