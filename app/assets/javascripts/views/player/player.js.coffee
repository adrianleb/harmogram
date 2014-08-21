class H.Models.Player extends H.Model


  mainVolume: 50


  initialize: (args) ->
    @playerReady = false
    @tracks = new H.Collections.PlayerTracks()
    @ui = new H.Views.PlayerUi()
    # @initWebAudio()
    # @initMic()
    @initEvents()


    # @initStub()




# http://soundcloud.vo.llnwd.net/1BrByxNx65Mg.128.mp3?AWSAccessKeyId=AKIAJNIGGLK7XA7YZSNQ&Expires=1401584705&Signature=8sr3bRLDtsvK9g1iRyF9MHxj7Fw%3D&e=1401584705&h=cc69831d9db7179b546fe1aedea1fcc5
  initStub: ->
    @tracks.injectChannel('__all__')


  initMediaElement: (url) ->
    console.log 'did chrome mdoe!'
    unless @playerElement?
      el = "<audio id='playerElement' preload='none' autoplay='true' src='#{url}' ></audio>"
      @playerElement = $(el).appendTo('body')
      _.delay (=>        
        @source = @context.createMediaElementSource(@playerElement[0])
        @source.connect @analyser
      ), 250

    $.get url, (r) =>
      @playerElement[0].src = r.file
      _.defer (=>
        @playerElement[0].play()
        H.events.trigger "player:playback:new", track: @tracks.currentTrack() 
      )
      # @playerElement.on 'canplaythrough', (r) =>
        # console.log 'ready to PLAYEEEERRR'
      # @playerElement[0].play()



  initArrayBuffer: (url) ->
    $.get url, (r) =>
      console.log r
      request = new XMLHttpRequest()
      request.overrideMimeType("text/plain; charset=x-user-defined")
      request.responseType = "stream" 
      request.open "GET", r.file, true
      request.responseType = "arraybuffer"
      

      # Decode asynchronously
      request.onload = =>
        @context.decodeAudioData request.response, @connectBuffer, (r, e, o) =>
          console.log r, e, o

      request.send(null)



  connectBuffer: (buffer) =>
    unless @source?
      @source = @context.createBufferSource()
      @source.connect(@analyser)
    @source.buffer = buffer                  # tell the source which sound to play
    @source.start(0) unless @sourceStarted?
    @sourceStarted = true

    H.events.trigger "player:playback:new", track: @tracks.currentTrack()


  initWebAudio: ->
    unless @playerReady
      window.AudioContext = window.AudioContext || window.webkitAudioContext
      @context = new AudioContext()
      @analyser = @context.createAnalyser()
      @analyser.fftSize = 256 # The size of the FFT used for frequency-domain analysis. This must be a power of two
      @analyser.smoothingTimeConstant = 0.77 # A value from 0 -> 1 where 0 represents no time averaging with the last analysis frame
      @analyser.connect(@context.destination)

      @visualizer = new H.Views.PlayerVisualizer(@, {})
      H.events.trigger "player:player:ready", track: @tracks.currentTrack()




  initMic: ->
    navigator.webkitGetUserMedia {audio: true, video:false}, ((stream) =>
      @microphone = @context.createMediaStreamSource(stream)
      @microphone.connect @analyser
      H.events.trigger "player:playback:new", track: @tracks.currentTrack()

      ), (error) ->
        console.log error

  initEvents: ->
    e = H.events

    @listenTo e, 'player:play:track', (data) =>
      @tracks.injectActivity data.activity

    @listenTo e, 'player:play:channel', (data) =>
      @tracks.injectChannel data.channelKey, data.startAt

    @listenTo e, 'player:player:ready', =>
      @playerReady = true
      if @tracksReady?
        @stop()
        @start()
        
    @listenTo e, 'player:tracks:ready', =>
      @tracksReady = true
      if @playerReady
        @stop()
        @start()

    @listenTo e, 'player:playback:end', =>
      @stop()
      @tracks.go(1)
      @start()

    @listenTo e, 'player:playback:back', =>
      @stop()
      @tracks.go(-1)
      @start()

    @listenTo e, 'player:playback:pause', =>
      @pause()

    @listenTo e, 'player:playback:stop', =>
      @stop()
            
    @listenTo e, 'player:playback:play', =>
      @play()

    @listenTo e, 'player:progress:seek', (data) =>
      @setPosition data


    $(@player).on "ended", (e) =>
      @tracks.go(1)
      @start()



  # according to the type of track being played return the instance of the player
  currentPlayer: () ->
    return @player


  # AudioPlayer entry point for playing sound.
  start:->
    $('body').attr('data-current-media-type', @tracks.currentMediaType() )

    if window.chrome?
      @initMediaElement("/welcome/stream?soundcloud_location=#{@tracks.currentTrack().get('stream').api_id}")
    else 
      @initArrayBuffer("/welcome/stream?soundcloud_location=#{@tracks.currentTrack().get('stream').api_id}")
    # @currentPlayer().start()
    # @player.src = location
    # if @tracks.currentMediaType() is 'soundcloud'
      # @player.src += "?client_id=c280d0c248513cfc78d7ee05b52bf15e"


    # $(@player).on "canplaythrough", (e) =>
      # console.log 'CAN PLAYER THRU.............................'
      # H.events.trigger "player:playback:new", track: @tracks.currentTrack()


# <audio id="source2" preload="none" data-track-index="2" src="https://api.soundcloud.com/tracks/39664086/stream?client_id=c280d0c248513cfc78d7ee05b52bf15e"></audio>

  play: ->
    @currentPlayer().play()

  pause: () ->
    @currentPlayer().pause()

  stop: ->
    # stop all players
    @player?.pause()
    @player?.currentTime = 0

  playIndex: (i) ->
    @tracks.go i
    if @playerReady
      @start()
    else
      @initWebAudio()

  # AudioPlayer entry point for setting volume.
  setVolume: (value) ->
    @mainVolume = value
    @currentPlayer().setVolume value

  # AudioPlayer entry point for setting position.
  setPosition: (value) ->
    @currentPlayer().setPosition value

  playing: () ->
    @currentPlayer().playing()


