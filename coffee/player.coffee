class Player

  constructor: ->
    @audioPlayers = []
    @currentPlaying = null
    @isPlaying = false
    @currentTrack = 0
    @initEvents()

    @


  initEvents: (el) ->
    $(@).on 'newAudio', (e, el) =>
      @audioPlayers.push el
      # $(el).on 'ended', 'audio', (e) =>
      #   @currentTrack += 1
      #   @playCurrent()

    $(@).on 'playLast', (e) => @playLast()

    $(@).on 'playIndex', (e, index) =>
      if @currentTrack is index and @isPlaying
        @pauseCurrent()
      else
        @currentTrack = index
        @playCurrent()

    $(@).on 'playAudio', (e, audio) =>
      i = @audioPlayers.indexOf audio
      if @currentTrack is i and @isPlaying
        @pauseCurrent()
      else
        @currentTrack = i
        @playCurrent()

  pauseCurrent: ->
    current = _.filter @audioPlayers, (a) ->
      a.paused is false

    for audio in current
      do (audio) ->
        audio.pause()

    $(Sounder.renderer).trigger 'pause'
    @isPlaying = false


  playLast: ->
    if @isPlaying
      @pauseCurrent()

    last = @audioPlayers[@audioPlayers.length - 1]
    last.play()

    $(Sounder.renderer).trigger 'start'
    @isPlaying = true


  emptyPlayer: ->
      @audioPlayers = []
      @currentTrack = 0

  playCurrent: () ->
    if @isPlaying
      @pauseCurrent()
    if @audioPlayers[@currentTrack]
      current = @audioPlayers[@currentTrack]
      current.play()
      homer.$('.active').removeClass 'active'
      homer.scrollCurrent()
      $(current).parent().addClass 'active'
      $(Sounder.renderer).trigger 'start'
      @isPlaying = true


(->
    Sounder.player = new Player
)()
