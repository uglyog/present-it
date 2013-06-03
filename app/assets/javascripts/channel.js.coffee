#ws = new WebSocket("ws://192.168.0.6:8080")
#ws.onmessage = (evt) ->
#  console.log "C Received: " + evt.data
#ws.onclose = (event) -> console.log("C Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean)
#ws.onopen = ->
#  console.log "C connected..."
#  ws.send("Hi I'm Controller")
#  ws.send("Presentation: Helloooooooo!!!!!")

class Channel
  constructor: (@channelAddress, @identifier) ->

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
    deferred.promise()

@Channel = Channel
