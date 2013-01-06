
class Sounder.Views.Home extends Backbone.View

  template: JST['home']

  # Define main element to attach to
  el: "body"


  events:
    'click .menu__item': 'handleMenu'
    'hover #track-list': 'handleHoverOut'
    'keydown' : 'handleKeyboard'
    'click #about-trigger' : 'showAbout'
    # 'click #track-submit' : 'inputNewTrack'

  initialize: (key) ->
    @tracks = new Sounder.Collections.Tracks()
    @channels = new Sounder.Collections.Channels()
    @controls = new Sounder.Views.Controls(parent:@)

    # @initControlsPanel()
    @tracksVisible = true
    @channelsVisible = false
    @controlsVisible = false

    @keyboardInit()
    # @fetchTracks()
    @fetchChannels()
    window.homer = @
    @



  render: ->
    @



  showAbout: (e) ->
    e.preventDefault()
    @$el.toggleClass 'open--about'


  fetchTracks: ->
    @tracks.fetch 
          dataType:'jsonp'
          success: =>
            tracks = _.filter @tracks.models, (t) =>
              t.attributes.object.stream.platform is 'soundcloud'
            @tracks.models = []
            @tracks.models = tracks
            @render()
            @renderTracks()

  handleHoverOut: (e) ->
    if e.type is 'mouseleave' and @tracksVisible
      @scrollCurrent()

  goChannels: (e, forward=true) ->
      if !forward
        @channelsVisible = true
        @tracksVisible = false
        @$el.removeClass 'open--input open--controls'
        @makeActiveMenu '[data-go="Tracks"]'
      else
        @tracksVisible = false
        @$el.removeClass 'open--controls'
        @$el.toggleClass 'open--channels'
        @makeActiveMenu '[data-go="Channels"]'
        @channelsVisible = true



  goInput: (e, forward=true) ->
      unless forward
        @$el.removeClass 'open--input'
        false
      @tracksVisible = false
      @channelsVisible = false
      @$el.toggleClass 'open--input'
      @$el.animate scrollTop: 0

  goTracks: (e, forward=true, first=false) ->
      @makeActiveMenu '[data-go="Tracks"]'
      @channelsVisible = false
      @tracksVisible = true
      @$el.removeClass 'open--input open--channels open--controls'
      unless @first
        @scrollCurrent()

  goControls: (e, forward=true, first=false) ->
    if forward
      @channelsVisible = false
      @tracksVisible = false
      @controlsVisible = true
      @$el.removeClass 'open--channels'
      @$el.addClass 'open--controls'
      @makeActiveMenu '[data-go="Controls"]'
      @$el.animate scrollTop: 0
    else
      @$el.removeClass 'open--controls open--channels open--tracks'
      @makeActiveMenu '[data-go="Tracks"]'
      @controlsVisible = false
      @tracksVisible = true
      unless first
        @scrollCurrent()
      # 



  handleMenu: (e) ->
    e.preventDefault()
    dir = e.currentTarget.dataset.go
    @makeActiveMenu e.currentTarget
    @['go' + dir]()

  makeActiveMenu: (el) ->
    $('.open--about').removeClass 'open--about'
    $('.menu--active').removeClass 'menu--active'
    $(el).addClass 'menu--active'
 

  keyboardInit: ->

    # keyboard events debounced by 200ms
    @handleKeyboard = _.debounce ( (e) =>
      # console.log e.which
      e.preventDefault()
      # down
      if e.which is 40
        if @tracksVisible
          Sounder.player.currentTrack += 1
          Sounder.player.playCurrent()
      # up
      else if e.which is 38
        if @tracksVisible
          Sounder.player.currentTrack -= 1
          Sounder.player.playCurrent()
      # left
      else if e.which is 37
        if @tracksVisible then @goChannels()
        else if @controlsVisible then @goControls(false, false)

      # right
      else if e.which is 39
        if @channelsVisible then @goTracks()
        else if @tracksVisible then @goControls()
      
      # space
      else if e.which is 32
        if Sounder.player.isPlaying
          Sounder.player.pauseCurrent()
        else
          Sounder.player.playCurrent()
        return false

    ), 200



  fetchChannels: ->
    @channels.fetch
          dataType:'jsonp'
          success: =>
            @renderChannels()
          

  renderChannels: ->
    $('#channel-list').empty()

    @channelViews = []
    for c in @channels.models
      v = new Sounder.Views.Channel(model:c, parent:@)
      $('#channel-list').append v.$el
      @channelViews.push v


    # ugly hacky way to pick a channel, way, jump to track
    pick = @channelViews[Math.round(Math.random() * @channelViews.length) - 1].el
    $(pick).addClass 'active'
    _.delay ( =>
      @$el.animate {scrollTop: (pick.offsetTop - (Sounder.renderer.TOTALHEIGHT/2.4))}, 500, () =>
        _.delay ( =>
          $(pick).click()
        ), 500
    ), 500

  changeChannel: (url) ->
    Sounder.player.emptyPlayer()
    @tracks.url = url
    @fetchTracks()
    @$('#channel-current').html @currentChannel
    @goTracks()



  renderTracks: -> 
    i = 0
    $('#track-list').empty()

    for t in @tracks.models
      t.trackIndex = i
      v = new Sounder.Views.Track(model:t)
      $('#track-list').append v.$el
      i++


    # making sure the browser finishes what hes doing before he starts doings this...
    _.delay (=>
      Sounder.control.plugMany()
      $(Sounder.player).trigger 'playAudio', $('audio')[Math.round( Math.random() * $('audio').length) - 1]
    ), 10

  # inputNewTrack: (e) ->
  #   e.preventDefault()
  #   src = @$('#track-url').val()
  #   i = @$('audio').length
  #   vi = new Sounder.Views.CustomTrack(track:src, index:i)
  #   @$('#track-list').append vi.$el
  #   @goTracks()
  #   Sounder.player.currentTrack = i



  scrollCurrent: () ->
    if @tracksVisible
      el = @$el.find('audio').eq(Sounder.player.currentTrack).parent()
      if el[0]?
        topPos = el[0].offsetTop
        @$el.animate scrollTop: (topPos - (Sounder.renderer.TOTALHEIGHT/2.4))

