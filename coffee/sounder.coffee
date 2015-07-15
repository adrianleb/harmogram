class SounderControl


  init: ->
    @initEvents()
    AudioContext = window.AudioContext || window.webkitAudioContext
    @context = new AudioContext()

    @analyser = @context.createAnalyser()
    @_plug @analyser, @context.destination

  constructor: ->
    @loaded = false
    @source = undefined
    @audio = undefined


    @init()


  initEvents: ->
    $(@).on 'newTrack', (e, track) => @plugOne track


  plugMany: ->
    for plug in $('audio')
      do (plug) =>
        source = @context.createMediaElementSource(plug)
        source.connect @analyser
        plug.crossOrigin = "anonymous";
        $(Sounder.player).trigger 'newAudio', plug


  plugOne: (el)->
    source = @context.createMediaElementSource(el)
    source.connect @analyser
    el.crossOrigin = "anonymous";
    $(Sounder.player).trigger 'newAudio', el


  _plug: (input, output) ->
    input.connect output


(->
    Sounder.control = new SounderControl
)()
