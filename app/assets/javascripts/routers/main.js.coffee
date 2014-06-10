class H.Routers.Main extends H.Router

  routes:
    # home
    '(/)': 'home'



  home: ->
    @setContent -> new H.Views.Home()
