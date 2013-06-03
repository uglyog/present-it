#= require jquery
#= require bootstrap
#= require angular
#= require ../channel
#= require_tree .

class Controller

  connectToPresentation: (channelAddress, $q) ->
    @channel = new Channel(channelAddress, 'Controller')
    @channel.sayHi()

@Controller = Controller
