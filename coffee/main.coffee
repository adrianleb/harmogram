window.Sounder =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->


    SC.initialize({
      client_id: '5ae3a12aef6952a4dd801d1bde3386b6',
      redirect_uri: 'http://harmogram.com/'
    });

    # Initialize Routers
    @Routers.main = new Sounder.Routers.Main()
    Backbone.history.start()


$ ->
  Sounder.init()
