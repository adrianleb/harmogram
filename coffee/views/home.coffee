
class Sounder.Views.Home extends Backbone.View

  template: JST['home']

  # Define main element to attach to
  el: "#container"


  # events: 
  #   'keyup #search-input' : 'search'
  #   'click #about-open, #about-close' : 'openAbout'

  initialize: (key) ->
    @tracks = new Sounder.Collections.Tracks()
    @tracks.fetch 
      # data:
      dataType:'jsonp'
      success: =>
        tracks = _.filter @tracks.models, (t) =>
          console.log t
          t.attributes.object.stream.platform not in ['youtube', 'vimeo'] 
        @tracks.models = []
        @tracks.models = tracks
        console.log @tracks, tracks.length
        @render()
        @renderTracks()



  render: ->
    @$el.html(@template())

  doPlay: ->
    Sounder.control.plugMany()
    $(Sounder.player).trigger 'playLast'

  renderTracks: -> 
    i = 1
    for t in @tracks.models
      t.trackIndex = i
      v = new Sounder.Views.Track(model:t)
      @$('#track-list').append v.$el
      i += 1

    _.delay (=>
      @doPlay()

      console.log 'play'
    ), 1000

