class Live.Artist
  constructor: (canvas) ->
    @canvas = canvas

  drawWith: (code) ->
    code.replace(/alert\([^)]*\)/gm, '')

    sketchCode = "
      #{ code }
    "

    try
      output_value = "var sketch = #{ Processing.compile(sketchCode).sourceCode };"

      # console.log('[Artist]', sketchCode)
      # console.log('[Artist compiled]', output_value)

      eval(output_value)

      # console.log('[Artist]', sketch)

      @reload()
      processingInstance = new Processing(@canvas, sketch)
    catch e
      output_value = "Parser Error! Error was:\n" + e.toString();


  reload: ->
    $(@canvas).replaceWith("<canvas id='js-canvas' class='render'></canvas>")
    @canvas = document.getElementById('js-canvas')

