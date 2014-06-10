class H.Views.NavBar extends H.View 
  template: JST['nav/nav_bar']

  el: "#nav"

  events:
    "click #open" : "openPlaylist"
    "click h1" : "openPlaylist"



  initialize: ->
    console.log 'nav init'
    @render()
    super



  render: ->
    @$el.append @template()

  openPlaylist: (e) ->
    console.log 'cricked!'
    e.preventDefault
    H.app.playlist.$el.toggleClass 'open'
    _.defer (=>
      $('#vCanvas').toggleClass 'blurred'
      )