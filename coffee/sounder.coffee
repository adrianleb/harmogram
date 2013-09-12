class SounderControl

  currentGenre = null
  init: ->
    @initEvents()
    @context = new window.webkitAudioContext()
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
        $(Sounder.player).trigger 'newAudio', plug


  plugOne: (el)->
    source = @context.createMediaElementSource(el)
    source.connect @analyser
    $(Sounder.player).trigger 'newAudio', el


  _plug: (input, output) ->
    input.connect output


(->
    Sounder.control = new SounderControl
)()