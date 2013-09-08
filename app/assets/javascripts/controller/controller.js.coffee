#= require jquery
#= require bootstrap
#= require angular
#= require ../channel
#= require_tree .

class Controller

  constructor: (@scope) ->
    @presentationInfo = null

  connectToPresentation: (channelAddress) ->
    @channel = new Channel(channelAddress, 'Controller', @)
    @channel.sayHi().done =>
      @requestPresentationInfo()

  disconnect: ->
    @channel.disconnect()
    @presentationInfo = null

  requestPresentationInfo: -> @channel.send("Presentation: Info Please")
  startPresentation: -> @channel.send("Presentation: You may start")
  backSlide: -> @channel.send("Presentation: Go back 1 slide")
  forwardSlide: -> @channel.send("Presentation: Go forward 1 slide")
  gotoSlide: (slide) -> @channel.send("Presentation: Goto #{slide} slide")
  selectPresentation: -> @channel.send("Presentation: Select #{@presentationInfo.selectedPresentation.trim()}")

  handleMessage: (message) ->
    jsonPrefix = 'Here is your JSON '
    if message.match('^' + jsonPrefix)
      @presentationInfo = JSON.parse(message.substring(jsonPrefix.length))
      @scope.$digest()

@Controller = Controller
