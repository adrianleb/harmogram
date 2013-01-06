class Sounder.Views.CustomTrack extends Backbone.View

  template: JST['customTrack']

  className: 'track__model'


  initialize: (src) ->
    @src = src.track
    @index = src.index
    @url = "http://api.soundcloud.com/tracks/#{@src}/stream?client_id=c280d0c248513cfc78d7ee05b52bf15e"
    @render()


  render: ->
    @$el.html(@template(url:@url, index:@index))
    $(Sounder.player).trigger 'newAudio', @$('audio')

    @$el.on 'click', (e) =>
      @play(e)
    _.delay (=>
      $('.active').removeClass 'active'
      @$el.addClass 'active'
      console.log 'heeeeeey', @$('audio'),  @$('audio')

      $(Sounder.player).trigger 'playAudio', @$('audio')
    ), 500
    @


  play: (e) ->
    e.preventDefault()
    $('.active').removeClass 'active'
    $(e.currentTarget).addClass 'active'
    console.log 'heeeeeey', @$('audio'),  @$('audio')

    $(Sounder.player).trigger 'playAudio', @$('audio')