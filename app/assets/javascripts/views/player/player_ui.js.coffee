class H.Views.PlayerUi extends H.View 
  el: "#player"

  template: JST['player/player_ui']


  events:
    'click #channels': 'goChannels'
    'click #prev' : 'playPrev'
    'click #next': 'playNext'
    'click #playPause': 'playPause'
    'click #info' :'toggleInfo'
    'click #playlist' : 'togglePlaylist'
    "mousemove #seekbar" : 'changeSeeker'
    "click #seekbar" : 'changeSeeker'
    "click #seekbarTimer" : 'toggleTimer'
    "click [data-subscribable]" : 'subscribe'
    "click [data-favoritable]" : 'favorite'
    "mousedown" : 'onMouseDown'
    "mouseup" : 'onMouseUp'


  initialize: (args) ->
    # @initEvents()

    # flag for the sliders (seek / volume) to work in firefox
    @mouseButtonDown = false
    @playerVisible = false





  initEvents: ->
    e = H.events

    @playingChannel = false
    @listenTo e, "player:play:channel", (data) =>
        
      @playingChannel = data.channelKey

    @listenTo e, "player:play:track", (data) =>




    @listenTo e, "player:playback:new", (data) =>
      @render data.activity


    @listenTo e, "player:content:toggle", =>

    @listenTo e, "player:progress:update", (data) =>
      @updateTimeAndSeeker data.elapsed, data.duration

    @listenTo e, "player:progress:buffer", (data) =>
      @updateSeekerBuffer data




  onMouseDown: (e) ->
    if e.which is 1
      @mouseButtonDown = true

  onMouseUp: (e) ->
    if (e.which is 1) and @mouseButtonDown
      @mouseButtonDown = false

  toggleVisibility: (forMobile=true)->
    $('body').addClass 'player-visible'

    if forMobile
      if @playerVisible
        H.animations.closePanel(@$el, 'right')
        @playerVisible = false
      else
        H.animations.openPanel(@$el, 'left')
        @playerVisible = true

      # H.animations.openPanel(@$el)


        # $('body').toggleClass 'track-info-visible'



  closeFirstInteraction: ->
    @$('.player-media').removeClass 'first-touch'
    @$('.first-interaction').hide()


  render: (activity) ->

    act = activity

    @currentActivity = act

    if act?
      @$el.find('#trackMeta').html @template(act:act)
      @$('#playerImage').css 'background-image', "url(#{act.object.images.medium.url})"
      if act.object.metadata.artist?
        @checkSubscription 'artist', act.object.metadata.artist.id
        @checkSubscription 'site', act.object.metadata.site.id
        @checkFavorite act.id

    # unless H.navigator.isMobile
      # @closeFirstInteraction()

      if @playingChannel
        H.router.navigate "/play/#{@playingChannel}/#{@currentActivity.id}", { trigger: false }

    return @el



  toggleTimer: (e) =>
    nop e
    @$(e.currentTarget).toggleClass 'show_elapsed'


  changeSeeker: (e) =>
    nop e
    if e.type is 'click' or @mouseButtonDown

      barWidth = e.currentTarget.clientWidth
      offset = if e.offsetX? then e.offsetX else if e.originalEvent.layerX? then e.originalEvent.layerX
      value = (offset / barWidth)
      @setSeeker value

      H.events.trigger 'player:progress:seek', value


  updateTimeAndSeeker: (elapsed, duration) =>
    val = elapsed / duration

    unless @mouseButtonDown
      @setSeeker val

    # remaining time
    remainingTime = duration - elapsed
    minutes = Math.floor(remainingTime / 60)
    seconds = Math.floor(remainingTime % 60)
    @$('#seekbarTimerLeft').html "-" + minutes + ":" + addLeadingZeros(seconds, 2)

      # current time
    minutes = Math.floor(elapsed / 60)
    seconds = Math.floor(elapsed % 60)
    @$('#seekbarTimerElapsed').html minutes + ":" + addLeadingZeros(seconds, 2)



  setSeeker: (val) ->
    percent = val * 100
    @$('#seekbarValue').css 'width', "#{percent}%"

  updateSeekerBuffer: (val) =>
    percent = val * 100
    @$('#seekbarBufferValue').css 'width', "#{percent}%"

  playNext: (e) ->
    nop e
    H.events.trigger 'player:playback:end'

  playPrev: (e) ->
    nop e
    H.events.trigger 'player:playback:back'

  playPause: (e) ->
    nop e
    el = $(e.currentTarget)
    if el.hasClass('paused')
      H.events.trigger 'player:playback:play'
      el.removeClass 'paused'
      return false
    H.events.trigger 'player:playback:pause'
    el.addClass 'paused'


