class Sounder.Routers.Main extends Backbone.Router

  view: null

  routes:
    '': 'home'
    ':key':'home'


  home: (key) ->
    @view = new Sounder.Views.Home(key)

