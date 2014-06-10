class H.Views.Home extends H.View 
  template: JST['home']

  events:
    "click #play" : "start"
    "click #next" : "next"
    "click [data-index]": "playIndex"
  initialize: ->
    console.log 'home'
    super

  start: (e)->
    e.preventDefault()
    H.player.initWebAudio()
    H.player.initStub()
    @$(e.currentTarget).hide()
    
  next: (e) ->
    e.preventDefault()
    H.player.tracks.go(1)
    H.player.start()


  playIndex: (e) ->
    e.preventDefault()
    H.player.tracks.go parseFloat(e.currentTarget.getAttribute('data-index'))
    H.player.start()