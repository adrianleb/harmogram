# nop
# -----
# nop e = e.preventDefault()
window.nop = (e) ->
  e.preventDefault()
  true


window.H =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->
    console.debug 'Harmogram Initializing'
    SHUFFLER.initialize {appKey: "a5a5a5a"}
    
    @events = _.extend({}, Backbone.Events)
    @player = new H.Models.Player()
    
    @app = new H.Views.App()
    @router = new H.Routers.Main()

    # Initialize History

    # Backbone.history.start({hashChange: true})
    Backbone.history.start({pushState: true, hashChange: false})


$(document).ready ->
  H.init()

