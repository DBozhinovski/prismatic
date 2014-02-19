{ spawn, exec } = require "child_process"
Q = require "q"
fs = require "fs"

class Plumbing

  @get: ->
    instance: (options) ->
      deferred = Q.defer()
      exec "ffmpeg -loglevel error -t 1 #{options.filter((n) -> n).slice(0,-1).join ' '} -f null /dev/null", (error, stdout, stderr) =>
        if error then deferred.reject error.toString().trim()
        else if stderr then deferred.reject stderr.toString().trim()
        else
          fs.writeFile 'dummy.sh', "ffmpeg #{options.filter((n) -> n).join ' '}", (error) =>
            ff = spawn "sh", ["dummy.sh"]

            # since ffmpeg has the nasty habit of printing to stderr...
            ff.stderr.on "data", (out) -> 
              deferred.notify out

            ff.stdout.on "close", (out) -> 
              deferred.resolve out

      deferred.promise

    meta: (path) ->
      deferred = Q.defer()
      exec "ffprobe -v quiet -print_format json -show_format -show_streams #{path}", (error, stdout, stderr) ->
        if error then deferred.reject error
        else
          deferred.resolve stdout
      
      deferred.promise


module.exports = Plumbing