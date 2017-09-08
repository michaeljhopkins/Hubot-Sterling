(function() {
  var psi = require('psi');
  var prettyBytes = require('pretty-bytes');

  module.exports = function(robot) {
    robot.respond(/pagespeed ([^\s]*)\s?(desktop|mobile)?/i, function(msg) {
        var http = /^https?:\/\/.*$/i.test(msg.match[1]);
        var url = (!http) ? 'http://'+msg.match[1] : msg.match[1];
        var strategy = (typeof(msg.match[2]) == 'undefined') ? 'desktop' : msg.match[2];
        var options = {
            //key: '',
            url: url,
            paths: '',           // optional
            locale: 'en_US',     // optional
            strategy: strategy,  // optional
            threshold: 80        // optional
        };

	var divider = new Array(65).join('-') + '\n';

	var buffer = function (msg, length) {
	  var buffer = '';

	  if (length === undefined) {
	      length = 50;
	  }
	  if (length - msg.length > 0) {
	    buffer = new Array(length - msg.length).join(' ');
	  }
	  return buffer;
	};

	var addSpacesToWords = function (msg) {
	  return msg.replace(/([A-Z]+)/g, ' $1').replace(/([A-Z][a-z])/g, '$1');
	};

	var firstToUpperCaseAndAddSpace = function (msg) {
	  msg = msg.replace('Bytes', '');
	  return msg.charAt(0).toUpperCase() + addSpacesToWords(msg.slice(1));
	};

	var labelize = function(msg) {
	  var label = firstToUpperCaseAndAddSpace(msg);
	  return label + buffer(label) + '| ';
	};

	var generateScore = function (url, strategy, score) {
	    score = 'Score:     ' + score;
	    url = 'URL:       ' + url;
	    strategy = 'Strategy:  ' + strategy;

	    return [url, score, strategy].join('\n') + '\n';
	};

	var generateRuleSetResults = function (rulesets) {
	    var result, ruleImpact, title;
	    var _results = [];

	    for (title in rulesets) {
	      result = rulesets[title];
	      ruleImpact = Math.ceil(result.ruleImpact * 100) / 100;
	      _results.push(labelize(title) + ruleImpact);
	    }

	    return _results.join('\n');
	};

	var generateStatistics = function (statistics) {
	    var result, title;
	    var _results = [];

	    for (title in statistics) {
	      result = title.indexOf('Bytes') !== -1 ?
		prettyBytes(+statistics[title]) :
		statistics[title];

	      _results.push(labelize(title) + result);
	    }

	    return _results.join('\n');
	};

        psi(options, function(err, data) {
		var output;
		output = [
		      '/quote ',
		      divider,
		      generateScore(data.id, strategy, data.score)
		].join('\n');
		msg.send(output);

		output = [
		      '/quote ',
		      divider,
		      generateStatistics(data.pageStats)
		].join('\n');
		msg.send(output);

		output = [
		      '/quote ',
		      divider,
		      generateRuleSetResults(data.formattedResults.ruleResults)
		].join('\n');
		msg.send(output);
	});
    });
  };

}).call(this);