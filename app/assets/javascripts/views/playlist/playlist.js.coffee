class H.Views.Playlist extends H.View 
  template: JST['playlist/playlist']

  el: "#playlist"

  events:
    "click #next" : "next"
    "click [data-index]": "playIndex"

  initialize: ->
    console.log 'playlist init'
    @render()
    # @fetchChannels()
    
    super

    @listenTo H.player.tracks, "add", (m, r) =>
      @renderTrack(m)




  render: ->
    @$el.append @template()


    
  renderTrack: (m) =>

    @$('#tracks').append JST['track'](model:m, index:H.player.tracks.indexOf(m))
    

  fetchChannels: ->
    H.channels = new H.Collections.Channels()
    H.channels.fetch().done =>
      console.log 'la', H.channels


  next: (e) ->
    e.preventDefault()
    H.player.tracks.go(1)
    H.player.start()


  playIndex: (e) ->
    e.preventDefault()
    H.player.stop()
    _.delay (=>
      H.app.playlist.$el.toggleClass 'open'
      _.defer (=>
        $('#vCanvas').toggleClass 'blurred'
      )
      H.player.playIndex(parseFloat(e.currentTarget.getAttribute('data-index')))
    ), 10