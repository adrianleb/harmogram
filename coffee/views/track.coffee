class Sounder.Views.Track extends Backbone.View

  template: JST['track']

  className: 'track__model'

  events:
    'click ': 'play'


  initialize: (model) ->
    # console.log i
    @model = model.model

    @render()


  render: ->
    @$el.html(@template(model:@model))


    # here we set the event listener for the track ending, on the audio element of this view
    @$('audio').on 'ended', (e) =>
      Sounder.player.currentTrack += 1
      Sounder.player.playCurrent()
    @


  play: (e) ->
    e.preventDefault()
    homer.$('.active').removeClass 'active'
    $(e.currentTarget).addClass 'active'
    # console.log 'heeeeeey', @$('audio'),  @$('audio')
    $(Sounder.player).trigger 'playAudio', @$('audio')

