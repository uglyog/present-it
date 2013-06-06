#= require angular
#= require jquery
#= require bootstrap
#= require ../channel
#= require_tree .

class Presentation
  constructor: (@channelAddress, @presentationUrl, @http) ->
    @pages = 0
    @channel = new Channel(@channelAddress, 'Presentation', @)
    @channel.sayHi()

  initPresentation: -> @lookupPage(1)

  pageFound: (pageNumber) ->
    @pages = pageNumber
    @lookupPage(pageNumber + 1)

  lookupPage: (pageNumber) ->
    @http.head(@presentationUrl + 'slide-' + pageNumber + '.html')
      .success(=> @pageFound(pageNumber))
      .error(=> @finalisePageCount())

  loadPage: (pageNumber) ->
    @http.get(@presentationUrl + 'slide-' + pageNumber + '.html')
      .success((page) =>
        @currentPage = pageNumber
        @displayPage(page)
      )

  finalisePageCount: -> @presentationReady = true

  handleMessage: (message) ->
    switch message
      when 'Info Please'
        @updateController()
      when 'You may start'
        @loadPage(1).success =>
          @updateController()
        .error (error) =>
          @channel.send('Controller: Sorry: ' + error)
      when 'Go back 1 slide'
        @updateController()
      when 'Go forward 1 slide'
        @updateController()

  updateController: ->
    @channel.send('Controller: Here is your JSON ' +
      JSON.stringify(pages: @pages, currentPage: @currentPage, presentationReady: @presentationReady))

  displayPage: (page) ->
    $('.slide').html(page)

@Presentation = Presentation