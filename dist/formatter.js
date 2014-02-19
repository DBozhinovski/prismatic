// Generated by CoffeeScript 1.6.3
(function() {
  var Formatter, _;

  _ = require("lodash");

  Formatter = (function() {
    function Formatter() {}

    Formatter.input = function(raw) {
      if (_.isString(raw)) {
        return raw.split(" ");
      } else if (_.isPlainObject(raw)) {
        return _.toArray(raw);
      } else if (_.isArray(raw)) {
        return raw;
      }
    };

    Formatter.formatFromStdOut = function(raw, output) {
      var i, line, progress, progressArray;
      line = raw.toString().trim();
      if (line.substring(0, 5) === 'frame') {
        progressArray = line.split(" ").join("=").replace(/\s+|=+/g, "|").split("|");
        progress = {};
        i = 0;
        while (i < progressArray.length) {
          progress[progressArray[i]] = progressArray[i + 1];
          i += 2;
        }
        return output(progress);
      } else {
        return false;
      }
    };

    Formatter.streamToStdOut = function(raw) {
      return Formatter.formatFromStdOut(raw, function(progress) {
        return process.stdout.write("      frame: " + progress.frame + ";       fps: " + progress.fps + ";       time: " + progress.time + ";       kbps: " + (progress.bitrate || 0) + " \r      ");
      });
    };

    Formatter.returnProgress = function(raw) {
      return Formatter.formatFromStdOut(raw, function(progress) {
        return {
          "frame": progress.frame || 0,
          "fps": progress.fps || 0,
          "time": (function() {
            var time;
            time = progress.time.toString().split(":") || "00:00:00";
            return parseInt(time[0], 10) * 60 * 60 + parseInt(time[1], 10) * 60 + parseInt(time[2], 10);
          })(),
          "bitrate": progress.bitrate || 0
        };
      });
    };

    Formatter.printToStdOut = function(raw) {
      return console.log(raw.toString().trim());
    };

    Formatter.calculatePercentage = function(current, target) {
      if ((this.previuos != null) && this.previous > parseInt(current || 0, 10)) {
        return 100;
      } else {
        this.previous = parseInt(current || 0, 10);
        return ((parseInt(current || 0, 10) / parseInt(target, 10)) * 100).toFixed(1);
      }
    };

    return Formatter;

  }).call(this);

  module.exports = Formatter;

}).call(this);
