#= require angular
#= require jquery
#= require bootstrap
#= require_tree .

#ws = new WebSocket("ws://192.168.0.6:8080")
#ws.onmessage = (evt) ->
#  console.log "P Received: " + evt.data
#ws.onclose = (event) -> console.log("P Closed - code: " + event.code + ", reason: " + event.reason + ", wasClean: " + event.wasClean)
#ws.onopen = ->
#  console.log "P connected..."
#  ws.send("Hi I'm Presentation")

class Presentation
  constructor: (@channelAddress, @presentationUrl, @http) ->
    @pages = 0

  initPresentation: ->
    @lookupPage(1)

  pageFound: (pageNumber) ->
    @pages = pageNumber
    @lookupPage(pageNumber + 1)

  lookupPage: (pageNumber) ->
    @http.head(@presentationUrl + 'slide-' + pageNumber + '.html')
      .success(=> @pageFound(pageNumber)).error(=> @finalisePageCount())

  finalisePageCount: ->


@Presentation = Presentation