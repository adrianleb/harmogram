class Sounder.Routers.Main extends Backbone.Router

  view: null

  routes:
    '': 'home'
    ':key': 'homeWithChannel'
    ':key/:id': 'homeWithTrack'


  home: (key) ->
    @view = new Sounder.Views.Home(key)

  homeWithChannel: (key) ->
    @view = new Sounder.Views.Home key:key

  homeWithTrack: (key, id) ->
    @view = new Sounder.Views.Home key:key, id:id


