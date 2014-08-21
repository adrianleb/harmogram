class H.Views.Home extends H.View 
  template: JST['home']

  events:
    "click #play" : "start"
    "click #next" : "next"
    "click [data-index]": "playIndex"
  initialize: ->
    console.log 'home'
    H.player.initStub()
    super
    @listenTo e, 'player:player:ready', =>
      @$('#play').hide()

  start: (e)->
    e.preventDefault()
    H.player.initWebAudio()
    
  next: (e) ->
    e.preventDefault()
    H.player.tracks.go(1)
    H.player.start()


  playIndex: (e) ->
    e.preventDefault()
    H.player.tracks.go parseFloat(e.currentTarget.getAttribute('data-index'))
    H.player.start()