window.Sounder =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->

    # Init settings
    $.fx.interval = 20


    # Initialize Routers
    @Routers.main = new Sounder.Routers.Main()
    Backbone.history.start()



$ ->
  Sounder.init()
