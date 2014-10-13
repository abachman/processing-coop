class Live.Socket
  constructor: (@room, @user) ->
    # change this address on network
    address = 'localhost'

    @ws = new WebSocket "ws://#{ address }:5100/#{@room}/#{@user}"

    @ws.onmessage = (evt) =>
      data = JSON.parse(evt.data)

      console.log '[Socket] received message', data

      if @messageCallback
        @messageCallback(data)

    @ws.onclose = =>
      @setStatus('disconnected')

    @ws.onopen = (evt) =>
      @setStatus('connected')
      if @onconnect?
        @onconnect(evt)

  send: (message) ->
    @ws.send message

  setStatus: (status) ->
    console.log '[Socket]', status

  onmessage: (callback) ->
    @messageCallback = callback
