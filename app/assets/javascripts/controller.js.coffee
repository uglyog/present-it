#= require underscore
#= require jquery
#= require bootstrap

ws = new WebSocket("ws://192.168.0.6:8080")
ws.onmessage = (evt) ->
  console.log "C Received: " + evt.data
ws.onclose = (event) -> console.log("C Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean)
ws.onopen = ->
  console.log "C connected..."
  ws.send("Hi I'm Controller")
  ws.send("Presentation: Helloooooooo!!!!!")
