Plumbing = require "./plumbing"
{ instance, meta } = Plumbing.get()
Formatter = require "./formatter"

class Porcelain

  @getPreviewImage: (inputPath, outputPath, time="120", res="1024x768") ->
    @manual "-i #{inputPath} -vframes 1 -an -s #{res} -ss #{time} #{outputPath}"

  @getWebM: (inputPath, outputPath) ->
    @manual "-i #{inputPath} -vcodec libvpx -acodec libvorbis #{outputPath}"

  @getMp4: (inputPath, outputPath) ->
    @manual "-i #{inputPath} -vcodec libx264 -acodec aac -strict experimental #{outputPath}"

  @manual: (options) ->
    instance Formatter.input(options)

  @info: (path) ->
    meta path

module.exports = Porcelain
