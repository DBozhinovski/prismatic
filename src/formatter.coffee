_ = require "lodash"

class Formatter
  @input: (raw) ->
    if _.isString(raw) then return raw.split " "
    else if _.isPlainObject(raw) then return _.toArray(raw)
    else if _.isArray(raw) then return raw

  @formatFromStdOut: (raw, output) -> # from stderr, but besides the point
    line = raw.toString().trim()
    # if it starts with `frame`, take it
    if line.substring(0,5) is 'frame'
      progressArray = line.split(" ").join("=").replace(/\s+|=+/g, "|").split("|")
      progress = {}
      i = 0
      while i < progressArray.length
        progress[progressArray[i]] = progressArray[i+1]
        i+=2
      # progress = line.match /[\d.:]+/g
      return output progress
    else
      false

  @streamToStdOut: (raw) =>
    @formatFromStdOut raw, (progress) -> process.stdout.write "
      frame: #{progress.frame}; 
      fps: #{progress.fps}; 
      time: #{progress.time}; 
      kbps: #{progress.bitrate or 0} \r
      " #uses \r to avoid spamming new lines

  @returnProgress: (raw) =>
    return @formatFromStdOut raw, (progress) ->
      {
        "frame": progress.frame or 0
        "fps": progress.fps or 0
        "time": ( -> 
          time = progress.time.toString().split(":") or "00:00:00"
          parseInt(time[0],10) * 60 * 60 + parseInt(time[1], 10) * 60 + parseInt(time[2], 10)
        )()
        "bitrate": progress.bitrate or 0
      }

  @printToStdOut: (raw) ->
    console.log raw.toString().trim()

  @calculatePercentage: (current, target) ->
    if @previuos? and @previous > parseInt(current or 0,10)
      return 100  
    else
      @previous = parseInt(current or 0,10)
      ((parseInt(current or 0,10) / parseInt(target, 10)) * 100).toFixed(1)

module.exports = Formatter