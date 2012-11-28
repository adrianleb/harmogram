class Sounder.Views.Track extends Backbone.View

  template: JST['track']

  className: 'track__model'

  # events:
  #   'click el': 'play'

  initialize: (model) ->
    # console.log i
    @model = model.model

    @render()



  render: ->
    @$el.html(@template(model:@model))
    @$el.on 'click', (e) =>
      @play(e)
    
    @


  play: (e) ->
    e.preventDefault()
    console.log 'heeeeeey', @$('audio').data 'track-index',  @$('audio')

    $(Sounder.player).trigger 'playIndex', @$('audio').data 'track-index'