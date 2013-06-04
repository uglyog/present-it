#= require jquery
#= require bootstrap
#= require angular
#= require ../channel
#= require_tree .

class Controller

  connectToPresentation: (channelAddress) ->
    @channel = new Channel(channelAddress, 'Controller')
    @channel.sayHi().done =>
      @channel.requestPresentationInfo()

  disconnect: -> @channel.disconnect()

@Controller = Controller
