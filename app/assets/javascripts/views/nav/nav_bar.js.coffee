class H.Views.NavBar extends H.View 
  template: JST['nav/nav_bar']

  el: "#nav"

  events:
    "click #open" : "openPlaylist"
    "click #openUser" : "openUser"

    "click h1" : "openPlaylist"



  initialize: ->
    console.log 'nav init'
    @render()
    super



  render: ->
    @$el.append @template()

  openPlaylist: (e) ->
    e.preventDefault
    H.player.initWebAudio()
    H.app.playlist.$el.toggleClass 'open'
    _.defer (=>
      $('#vCanvas').toggleClass 'blurred'
      )


  openUser: (e) ->
    e.preventDefault
    H.app.userPanel.$el.toggleClass 'open'
    _.defer (=>
      $('#vCanvas').toggleClass 'blurred'
      )