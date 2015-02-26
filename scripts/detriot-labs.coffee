# Description:
#    Animated gifs of all deaths from AMC's breaking bad.  Images from Buzzfeed http://www.buzzfeed.com/robinedds/an-exhaustive-rundown-of-every-single-death-in-breaking-bad
#
#   Random Jaden Smith Quote
#
#   Nighty Night
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   breaking bad death - Displays a random death scene from Breaking Bad
#   is <name> dead - Check if a character is dead or not
#   good morning
#   make it so
#
# Author:
#   Jake Payton
DECEMBER = 11
ways_to_say_good_morning = [
  "http://media1.giphy.com/media/13E3GEE2zxlhhm/giphy.gif",
  "http://media3.giphy.com/media/frc5xfWMX0Vig/giphy.gif",
  "http://media.giphy.com/media/gBxL0G0DqZd84/giphy.gif",
  "http://media.giphy.com/media/XiMbUa46o1VXq/giphy.gif",
  "http://media.giphy.com/media/dilBP4FslWpm8/giphy.gif",
  "http://media1.giphy.com/media/HHxRwRSrlSBBS/200.gif",
  "http://media.giphy.com/media/XCVm7xxtEolwc/giphy.gif",
  "http://media.giphy.com/media/11rwQLkZilbRxS/giphy.gif",
  "http://media.giphy.com/media/3OYyAv41yxMnS/giphy.gif",
  "http://media.giphy.com/media/RqWlJJUuNCkBq/giphy.gif",
  "http://media.giphy.com/media/5fBH6zvK9bUXN1HKfbW/giphy.gif",
  "http://media.giphy.com/media/NLfI3zZLBp56g/giphy.gif",
  "http://www.blogcdn.com/www.pawnation.com/media/2013/07/good-morning---imgur-1.gif",
  "http://s3-ec.buzzfed.com/static/2013-10/enhanced/webdr06/1/12/anigif_enhanced-buzz-18471-1380645591-3.gif"
]
quotes = [
  "Every 7 Years Your Body Is Completely Replaced With Entirely New Cells So Just Because You Look The Same Doesn't Mean You Are.",
  "Either I Lie To You Or We Cry Together",
  "People Hate What They Don't Understand",
  "How Can Mirrors Be Real If Our Eyes Aren't Real",
  "If Newborn Babies Could Speak They Would Be The Most Intelligent Beings On Planet Earth.",
  "\"Hey Are You Jaden Can I Have A Picture With You\" No Cause I'm Super Sad But We Can Sit And Talk.",
  "I Don't Want You Guys To Think Because I Was Born In America That I Speak And Abide By English Grammar. I Speak Jaden, Indefinitely.",
  "You Can Discover Everything You Need To Know About Everything By Looking At Your Hands",
  "When The First Animal Went Extinct That Should've Bin A Sign.",
  "Haters Are Just Pre Creators Who Need The Seed Of Greatness.",
  "Most Trees Are Blue",
  "If I Was Moses Where Would I Be",
  "If A Book Store Never Runs Out Of A Certain Book, Dose That Mean That Nobody Reads It, Or Everybody Reads It",
  "School Is The Tool To Brainwash The Youth.",
  "If Everybody In The World Dropped Out Of School We Would Have A Much More Intelligent Society.",
  "When I Die. Then You Will Realize",
  "I Should Just Stop Tweeting, The Human Consciousness Must Raise Before I Speak My Juvenile Philosophy.",
  "\“The Ancient Secret of the Flower of Life\” and ancient texts; things that can’t be pre-dated.",
  "Right, because you have to live. There’s a theoretical physicist inside all of our minds, and you can talk and talk, but it’s living.",
  "the melancholiness of the ocean; the melancholiness of everything else.",
  "[bursts into laughter] As soon as me and Willow started releasing music, that’s one thing that the whole world took away is, okay, they unlocked another step of honesty. If these guys can be honest about everything, then we can be more honest.",
  "Exactly. Because your mind has a duality to it. So when one thought goes into your mind, it’s not just one thought, it has to bounce off both hemispheres of the brain. When you’re thinking about something happy, you’re thinking about something sad. When you think about an apple, you also think about the opposite of an apple.",
  "That’s another thing: What’s your job, what’s your career? Nah, I am. I’m going to imprint myself on everything in this world.",
  "Honestly, we’re just trying to make music that we think is cool. We don’t think a lot of the music out there is that cool. So we make our own music.",
  "Willow just dropped a song (\“Cares\”), allow me to quote the lyrics: \“I do not care what people say.\” We both don’t really care. I like to wear things that I make, but I throw it on as though I was throwing on anything. It looks cool, sometimes.",
  "When babies are born, their soft spots bump: It has, like, a heartbeat in it. That’s because energy is coming through their body, up and down.",
  "It’s prana energy because they still breathe through their stomach. They remember. Babies remember.",
  "Here’s the deal: School is not authentic because it ends. It’s not true, it’s not real. Our learning will never end. The school that we go to every single morning, we will continue to go to.",
  "Kids who go to normal school are so teenagery, so angsty.",
  "You never learn anything in school. Think about how many car accidents happen every day. Driver’s ed? What’s up? I still haven’t been to driver’s ed because if everybody I know has been in an accident, I can’t see how driver’s ed is really helping them out.",
  "I have a goal to be just the most craziest person of all time. And when I say craziest, I mean, like, I want to do like Olympic-level things. I want to be the most durable person on the planet.",
  "Willow’s been writing her own novels since she was 6.",
  "This Cute Little Blonde Baby Just Looked At Me.",
  "I Just Scrolled Through My Tweets And \"I\" Started Laughing.",
  "The Head Of The Sphinx Will Fall Off In The Near Future.",
  "I Just Like Showing Pretty Girls A Good Time Weather I'm Physically There Or Not Doesn't Matter.",
  "Female Energy",
  "Currently Going Through Customs Even Though I Was Born On This Planet.",
  "Gimme 12 months. You See What's Bin Started",
  "That's Art Ladies And Gentlemen",
  "You Taught Me How To Play The Piano But Have Never Heard Me.",
  "Drake Is Tight.",
  "I've Bin Drinking Distilled Water For So Long That When I Drink Normal Water It Feels Like I'm Swallowing Huge Chunks Of Aluminum.",
  "No Pain No Gain Young Kurt Cobain.",
  "Dear Everybody Who Can Rap Better Than Me. Please Show Me",
  "Dear The Internet Have Fun With That.",
  "Once All 100% Is Neglected You Have A Citizen. A Walking Zombie Who Criticizes Every Thing They See. Have Fun Its A Really Awesome Place.",
  "Hate Me Love Me Doesn't Matter I'm Still Occupying Time Inside Of Your Psyche.",
  "I Build Pyramids Constantly",
  "Teleport To Me.",
  "I Feel Like People Who Look Similar Act Similar.",
  "My Parents Are The Trillest People I Know",
  "If A Cup Cake Falls From A Tree How Far Away Will It Be From Down. #Jupiter",
  "To Kiss A Humming Bird...",
  "SPIDER MAN IS AMAZING OH MY GOD !!!!!! PLEASE GO WATCH IT",
  "Unawareness Is The Only Sin, And If You Were Aware You Would Know.",
  "People Think A RelationShip Makes You Whole, That It's Two 50%'s Coming Together To Make 100% When It Should Be Two 100%'s Making 200%",
  "You Think You Get It. YOU DONT YOU DONT YOU DONT!!!!!!!",
  "Water In The Eyes And Alcohol In The Eyes Are Pretty Much The Same I Know This From First Hand Experience.",
  "Your Passion For Hating Me Is The Same Passion I Have For SacGeometry And MagLev Technology And Any Passion Is To Be Respected",
  "I'm Here If You Need A Fellow Insane Person To Talk To. But I'm Seriously Here Not Like One Of Those I'm Here For You's That Everybody Says.",
  "If Everybody Got To Meet Me In Real Life, 50% Of My Fans Would Hate Me And 50% of My Hatters Would Love Me.",
  "I'm Slowly Realizing I Need To Make A Trip Out To Norway",
  "I Don't Like To Tweet But The New Hunger Games Is Literally Amazing.",
  "The Current Population Of Earth Is 7,124,102,180",
  "There Is No Nutrients In Our Food Anymore Or In Our Soil OR IN OUR WATER.",
  "I Encourage You All To Unfollow Me So I Can Be Left With The People Who Actually Appreciate Philosophy And Poetry. #CoolTapeVol2",
  "Why Is It Always 3 WHY IS IT ALWAYS 3!!!!!",
  "The Great Gatsby Is One Of The Greatest Movies Of All Time, Coachella.",
  "\"It's Your Birthday\" Mateo Said. I Didn't Respond. \"Are You Not Excited To Be 15\" He Asked. Reading My Book I Uttered \"I Turned 15 Long Ago\"",
  "Lately People Call Me Scoop Life",
  "You Must Not Know Fashion",
  "Umm Who Has The Floss",
  "I Gave Justin His Cartier Then Went Home.",
  "I'm Really Lovin My Instagram Right Now",
  "Like I Can't Take Life Right Now",
  "Dying Is MainStream #MONEY",
  "I Only Apply To The Sixth Amendment",
  "Once You Go In You Always Come Out Alive",
  "I Will Always Give You The Truth I Will Never Lie To You In My music If You Cant Handle My Feelings And Emotions Please Unfollow Me",
  "Swear To God If Who Hacked My Instagram Is Who I Think Hacked My Instagram..........Good Luck",
  "I Cried When I Made This #StarryRoom",
  "I Watch Twilight Every Night"
]
images = [
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/26/12/anigif_original-grid-image-20674-1380212644-3.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr05/26/12/anigif_enhanced-buzz-20530-1380212938-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr05/26/12/anigif_original-grid-image-17969-1380213360-17.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr02/26/12/anigif_enhanced-buzz-31543-1380213848-18.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr05/26/12/anigif_enhanced-buzz-19938-1380214179-13.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr05/26/12/anigif_enhanced-buzz-19940-1380214527-22.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr05/26/12/anigif_enhanced-buzz-19955-1380214726-32.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr05/26/13/anigif_enhanced-buzz-29746-1380218270-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr02/26/14/anigif_enhanced-buzz-13162-1380218422-22.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr02/26/14/anigif_enhanced-buzz-15119-1380218664-16.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/26/14/anigif_enhanced-buzz-23104-1380219527-11.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr02/26/14/anigif_enhanced-buzz-14069-1380219967-16.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/27/4/anigif_enhanced-buzz-9233-1380269901-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/4/anigif_enhanced-buzz-14731-1380269973-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/27/4/anigif_enhanced-buzz-16373-1380270438-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/27/4/anigif_enhanced-buzz-18121-1380270524-2.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/27/4/anigif_enhanced-buzz-13128-1380271054-5.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/27/4/anigif_enhanced-buzz-17498-1380271087-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/8/anigif_enhanced-buzz-7308-1380285167-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/4/anigif_enhanced-buzz-14493-1380271738-20.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/4/anigif_enhanced-buzz-29219-1380271789-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-10458-1380272454-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-11576-1380272780-6.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/5/anigif_original-grid-image-21620-1380272813-8.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/5/anigif_enhanced-buzz-22461-1380273081-2.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-11315-1380273406-5.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-19535-1380273799-9.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-16749-1380274244-11.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/5/anigif_enhanced-buzz-2296-1380274271-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/5/anigif_enhanced-buzz-26107-1380274562-3.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-21306-1380274596-1.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/5/anigif_enhanced-buzz-7043-1380274915-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-14215-1380275204-2.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-18143-1380275518-9.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/27/5/anigif_enhanced-buzz-11291-1380275729-4.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-17116-1380275965-38.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-14731-1380276199-19.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/27/6/anigif_enhanced-buzz-17110-1380276540-13.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-13839-1380276591-4.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/6/anigif_original-grid-image-14634-1380276960-3.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-7356-1380277150-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/6/anigif_enhanced-buzz-14672-1380277448-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/6/anigif_original-grid-image-14582-1380277524-8.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/6/anigif_original-grid-image-14582-1380277526-12.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-7343-1380277790-2.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-7343-1380278182-4.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/6/anigif_enhanced-buzz-14655-1380278230-0.gif",
  "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-7392-1380278438-5.gif"
]

module.exports = (robot) ->
  robot.hear /breaking bad death/i, (msg) ->
    msg.send msg.random images

  robot.hear /is hank dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/27/6/anigif_enhanced-buzz-14655-1380278230-0.gif"

  robot.hear /is gus dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr01/27/5/anigif_enhanced-buzz-11291-1380275729-4.gif"

  robot.hear /is tuco dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr05/26/12/anigif_enhanced-buzz-19938-1380214179-13.gif"

  robot.hear /is jane dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr03/26/14/anigif_enhanced-buzz-23104-1380219527-11.gif"

  robot.hear /is gale dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-11315-1380273406-5.gif"

  robot.hear /is don eladio dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/5/anigif_enhanced-buzz-18143-1380275518-9.gif"

  robot.hear /is mike dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-7356-1380277150-0.gif"

  robot.hear /is steve dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-7343-1380278182-4.gif"

  robot.hear /is andrea dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-7392-1380278438-5.gif"

  robot.hear /is (todd|meth damon) dead/i, (msg) ->
    msg.send "http://s3-ec.buzzfed.com/static/2013-09/enhanced/webdr06/27/6/anigif_enhanced-buzz-19526-1380276891-9.gif"

  robot.hear /is (jesse|pinkman|jesse pinkman) dead/i, (msg) ->
    msg.send "https://lh5.googleusercontent.com/-yfqyg6jhC7U/UiZUVl-VwMI/AAAAAAAAAtc/k4GgVeBMsFs/breaking-bad-gif-jesse-pinkman-29695.gif"

  robot.hear /is (walt|walter|walter white|mr white) dead/i, (msg) ->
    msg.send "http://i.imgur.com/jo4kZQ8.gif"

  robot.hear /is heisenberg dead/i, (msg) ->
    msg.send "http://cdn.uproxx.com/wp-content/uploads/2012/08/heisenberg-saymyname.gif"

  robot.hear /is mr lambert dead/i, (msg) ->
    msg.send "http://kalipinckney.files.wordpress.com/2012/08/livefreeordie-dennys.jpg"

  robot.hear /is skyler dead/i, (msg) ->
    msg.send "http://thebacklot.mtvnimages.com/uploads/2013/04/bb-skyshutup1.gif"

  robot.hear /is walt jr dead/i, (msg) ->
    msg.send "http://media3.giphy.com/media/r2yaMm7v7je8w/original.gif"

  robot.hear /jaden/i, (msg) ->
    msg.send msg.random quotes

  robot.hear /(go to bed|goodnight|up late)/i, (msg) ->
    msg.send "http://i.imgur.com/tVrd0UA.jpg"

  robot.hear /good morning/i, (msg) ->
    msg.send msg.random ways_to_say_good_morning

  robot.hear /make it so\b/i, (msg) ->
    currentDate = new Date()
    if currentDate.getMonth() is DECEMBER
      msg.send "http://i.imgur.com/U2tgKjM.jpg"
    else
      msg.send "http://i.imgur.com/rsXNr22.jpg"

  robot.hear /\(thank you\)|(\bthank you\b)/i, (msg) ->
    if msg.match[1] is "thank you"
      if Math.random() > .8
        msg.send "https://s3.amazonaws.com/uploads.hipchat.com/31582/209877/5xpLrqT70xRfInI/dwy0i4evvxsvt1rf6ehi.gif"