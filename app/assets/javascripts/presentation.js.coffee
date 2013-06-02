#= require underscore
#= require jquery
#= require bootstrap

ws = new WebSocket("ws://localhost:8080")
ws.onmessage = (evt) ->
  console.log "P Received: " + evt.data
ws.onclose = (event) -> console.log("P Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean)
ws.onopen = ->
  console.log "P connected..."
  ws.send("Hi I'm Presentation")