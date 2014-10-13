class Live.Artist
  constructor: (canvas) ->
    @canvas = canvas

  drawWith: (code) ->
    code.replace(/alert\([^)]*\)/gm, '')

    sketchCode = "
      #{ code }
    "

    try
      sketch = Processing.compile(sketchCode)

      if @processing?
        @processing.exit()

      @processing = new Processing(@canvas, sketch)
    catch e
      output_value = "Parser Error! Error was:\n" + e.toString();

  fullscreen: ->
    if(@canvas.requestFullScreen)
      @canvas.requestFullScreen()
    else if(@canvas.webkitRequestFullScreen)
      @canvas.webkitRequestFullScreen()
    else if(@canvas.mozRequestFullScreen)
      @canvas.mozRequestFullScreen()


