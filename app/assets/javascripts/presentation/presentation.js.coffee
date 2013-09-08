#= require angular
#= require jquery
#= require bootstrap
#= require underscore
#= require underscore.string
#= require haml
#= require ../channel
#= require_tree .

class Presentation
  constructor: (@channelAddress, @presentationUrl, @fileExt, @http) ->
    @pages = 0
    @channel = new Channel(@channelAddress, 'Presentation', @)
    @channel.sayHi()

  initPresentation: -> @lookupPresentations()

  pageFound: (pageNumber) ->
    @pages = pageNumber
    @lookupPage(pageNumber + 1)

  lookupPage: (pageNumber) ->
    @http.head(@presentationUrl + @selectedPresentation + 'slide-' + pageNumber + @fileExt)
      .success(=> @pageFound(pageNumber))
      .error(=> @finalisePageCount())

  loadPage: (pageNumber) ->
    @http.get(@presentationUrl + @selectedPresentation + 'slide-' + pageNumber + @fileExt)
      .success((page) =>
        @currentPage = pageNumber
        @displayPage(haml.compileHaml(source: page)())
      )

  lookupPresentations: ->
    @http.get(@presentationUrl)
      .success((index) =>
        @parseIndexPage(index)
      )

  finalisePageCount: ->
    @presentationReady = true
    @updateController()

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
        @loadPage(@currentPage - 1).success =>
          @updateController()
        .error (error) =>
          @channel.send('Controller: Sorry: ' + error)
      when 'Go forward 1 slide'
        @loadPage(@currentPage + 1).success =>
          @updateController()
        .error (error) =>
          @channel.send('Controller: Sorry: ' + error)
      else
        match = /^Select ([a-zA-Z0-9\-\/]+)/.exec(message)
        if match
          @clearPresentationInfo()
          @selectedPresentation = match[1]
          @lookupPage(1)
        else
          match = /Goto ([0-9]+) slide/.exec(message)
          if match
            @loadPage(parseInt(match[1])).success =>
                @updateController()
              .error (error) =>
                @channel.send('Controller: Sorry: ' + error)

  updateController: ->
    @channel.send('Controller: Here is your JSON ' +
      JSON.stringify
        presentations: @presentations
        selectedPresentation: @selectedPresentation
        pages: @pages
        currentPage: @currentPage
        presentationReady: @presentationReady
    )

  displayPage: (page) ->
    $('.slide').html(page)

  parseIndexPage: (index) ->
    @presentations = []
    $(index).find('td.name a').each (index, link) =>
      text = $(link).text().trim()
      @presentations.push(text) unless text == 'Parent Directory'

  clearPresentationInfo: ->
    @pages = 0
    @presentationReady = false
    @currentPage = null

@Presentation = Presentation