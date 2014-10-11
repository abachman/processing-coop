class Live.Socket
  constructor: (@room, @user) ->
    # change this address on network
    @ws = new WebSocket "ws://localhost:5100/#{@room}/#{@user}"

    @ws.onmessage = (evt) =>
      data = JSON.parse(evt.data)

      console.log '[Socket] received message', data

      if @messageCallback
        @messageCallback(data)

    @ws.onclose = =>
      @setStatus('disconnected')

    @ws.onopen = (evt) =>
      @setStatus('connected')

  send: (message) ->
    @ws.send message

  setStatus: (status) ->
    console.log status

  onmessage: (callback) ->
    @messageCallback = callback
