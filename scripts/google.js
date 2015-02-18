robot.respond(/(google)( me)? (.*)/i, function (msg) {
    googleMe(msg, msg.match[3], function (url) {
        msg.send(url);
    });
});

function googleMe(msg, query, cb) {
    return msg.http('http://www.google.com/search')
        .query({q: query})
        .get()(function (err, res, body) {
        var match = body.match(/class="r"><a href="\/url\?q=([^"]*)(&amp;sa.*)">/);
        cb(match ? match[1] : "Sorry, Google had zero results for '//{query}'");
    });
}