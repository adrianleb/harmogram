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
      console.log 'new source', el
      @audioPlayers.push el
      @renderPlaylist()

    $(@).on 'playLast', (e) => @playLast()

    $(@).on 'playIndex', (e, index) => 
      if @currentTrack is index and @isPlaying
        @pauseCurrent()
      else
        @currentTrack = index
        @playCurrent()


  renderPlaylist: ->
    $('#playlist').html ''
    for player in @audioPlayers
      do (player) =>
        # index = @audioPlayers.indexOf player
        # console.log index ,$(player).data 'index'
        # $(player).data 'index', "#{index}"
        # console.log 'toucher', player
        # tmpl = "<a class='play' data-index='#{index}' href='#'>track-#{index}</a>"
        # $('#playlist').append tmpl


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



  playCurrent: () ->
    if @isPlaying
      @pauseCurrent()
    i = @audioPlayers.indexOf @currentTrack
    # current = @audioPlayers[@currentTrack]
    current = @audioPlayers[i]
    current.play()

    $(Sounder.renderer).trigger 'start'
    @isPlaying = true



(->
  Sounder.player = new Player
)()