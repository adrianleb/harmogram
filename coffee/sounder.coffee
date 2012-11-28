class SounderControl


  init: ->
    @initEvents()
    @context = new window.webkitAudioContext()
    @analyser = @context.createAnalyser()
    @_plug @analyser, @context.destination
    console.log 'welcome to ', @context, @analyser
    @getTracks()


  constructor: ->
    @loaded = false
    @source = undefined
    @audio = undefined

    # Sounder.player = new Player()

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
    # @audioSources.push source


  _plug: (input, output) ->
    input.connect output

  getTracks: ->
    # console.log Meteor
    # console.log @tracks
    @


(->
  Sounder.control = new SounderControl
)()