Live.LaunchPresentationMode = ->
  active_id = "#{ SESSION_ID }presenter"

  sock = new Live.Socket('primary', active_id)

  artist = new Live.Artist(document.getElementById('js-canvas'))

  sock.onmessage (message) ->
    console.log('[Presenter] message', message)

    if message.user != 'system'
      # compute diff and patch editor content based on sent content
      code = message.comment
      artist.drawWith(code)

  $('.js-fullscreen-trigger').on 'click', (evt) ->
    evt.preventDefault()
    artist.fullscreen()


