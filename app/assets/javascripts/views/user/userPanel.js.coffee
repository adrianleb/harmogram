class H.Views.UserPanel extends H.View 
  template: JST['user/userPanel']

  el: "#userPanel"

  events:
    "click #soundcloudLogin" : "soundcloudLogin"
    # "click [data-index]": "playIndex"

  initialize: ->
    console.log 'userPanel init'
    @render()
    super

    # @listenTo H.player.tracks, "add", (m, r) =>
    #   @renderTrack(m)




  soundcloudLogin: (e) ->
    e.preventDefault()
    SC.connect () =>
      SC.get '/me', (r) =>
        H.events.trigger 'user:connected', r



  render: ->
    @$el.append @template()

