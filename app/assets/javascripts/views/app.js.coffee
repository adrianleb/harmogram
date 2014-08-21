class H.Views.App extends H.View 
  el: "#mainPanel"
  template: JST['app']

  childViews: []

  initialize: (opts) ->
    console.debug "INITIALIZED MAIN VIEW"
    window.mainContent = @
    @playlist = new H.Views.Playlist()
    @userPanel = new H.Views.UserPanel()

    @nav = new H.Views.NavBar()
    console.log 'done?'

    @initEvents()


  initEvents: ->
    @listenTo H.events, "app:loading:start", (data) =>
      $('body').addClass 'loading'

    @listenTo H.events, "app:loading:finish", (data) =>
      $('body').removeClass 'loading'


  render: ->
    @$el.append @template()
    @el

    
  setContent: (view) ->
    @$el.empty()
    if @currentView?
      @currentView.close()
      delete @currentView
    @currentView = view()
    @$el.append @currentView.render()
    _.defer =>
      @currentView.afterRender()

    H.events.trigger 'app:loading:finish'
