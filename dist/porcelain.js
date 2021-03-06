// Generated by CoffeeScript 1.6.3
(function() {
  var Formatter, Plumbing, Porcelain, instance, meta, _ref;

  Plumbing = require("./plumbing");

  _ref = Plumbing.get(), instance = _ref.instance, meta = _ref.meta;

  Formatter = require("./formatter");

  Porcelain = (function() {
    function Porcelain() {}

    Porcelain.getPreviewImage = function(inputPath, outputPath, time, res) {
      if (time == null) {
        time = "120";
      }
      if (res == null) {
        res = "1024x768";
      }
      return this.manual("-i " + inputPath + " -vframes 1 -an -s " + res + " -ss " + time + " " + outputPath);
    };

    Porcelain.getWebM = function(inputPath, outputPath) {
      return this.manual("-i " + inputPath + " -vcodec libvpx -acodec libvorbis " + outputPath);
    };

    Porcelain.getMp4 = function(inputPath, outputPath) {
      return this.manual("-i " + inputPath + " -vcodec libx264 -acodec aac -strict experimental " + outputPath);
    };

    Porcelain.manual = function(options) {
      return instance(Formatter.input(options));
    };

    Porcelain.info = function(path) {
      return meta(path);
    };

    return Porcelain;

  })();

  module.exports = Porcelain;

}).call(this);
