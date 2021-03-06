class Channel
  constructor: (@channelAddress, @identifier, @owner) ->

  sayHi: ->
    deferred = new $.Deferred()
    @ws = new WebSocket("ws://" + @channelAddress)
    @ws.onopen = =>
      @ws.send("Hi I'm " + @identifier)
      deferred.resolve(true)
    @ws.onerror = (event) =>
      deferred.reject(event)
    @ws.onclose = (event) =>
      deferred.reject(event)
    @ws.onmessage = (message) =>
      @handleMessage(message)
    deferred.promise()

  send: (message) ->
    @ws.send(message)

  disconnect: ->
    @ws.close()
    @ws = null

  handleMessage: (message) ->
    console.log message
    error = message.data.match /^Sorry: (.*)/
    if error?
      @displayError(error[1])
    else
      @owner.handleMessage(message.data.toString())

  displayError: (error) ->
    $('.alerts').append(
      """<div class="alert alert-error">
          <button type="button" class="close" data-dismiss="alert">&times;</button>
          <strong>Error!</strong>
          #{error}
        </div>
      """)

@Channel = Channel
