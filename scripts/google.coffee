module.exports = (sterling) ->
  sterling.respond /(google)( me)? (.*)/i, (msg) ->
    sterling.http('http://www.google.com/search').query({q: msg.match[3]}).get() (err, res, bd) ->
      responseVar = bd.match(/class="r"><a href="\/url\?q=([^"]*)(&amp;sa.*)">/)
      msg.send(responseVar)