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

  handleMessage: (message) ->
    jsonPrefix = 'Here is your JSON '
    if message.match('^' + jsonPrefix)
      @presentationInfo = JSON.parse(message.substring(jsonPrefix.length))
      @scope.$digest()

@Controller = Controller
