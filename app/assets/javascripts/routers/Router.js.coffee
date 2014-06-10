class H.Router extends Backbone.Router

  initialize: ->
    @player = H.player
    @parentEl = $('body')
    @initClickHandlers()


  setContent: (view, playerMode=false, specialClass) ->
    @contentFragment = Backbone.history.fragment
    H.app.setContent view

  

  initClickHandlers: ->
    # Globally capture clickH. If they are internal and not in the pass
    # through list, route them through Backbone's navigate method.
    # if they have [data-modal], route click to a modal action
    # if they have ".sloth" class, then dont route it thru backbone
    $(document).on "click", "a[href^='/']", (event) =>

      console.log 'lalalal'
      href = $(event.currentTarget).attr('href')

      # chain 'or's for other black list routes
      bypass = $(event.currentTarget).attr 'data-bypass'


      # justPlay = $(event.currentTarget).attr 'data-just-play'
      # if justPlay?
        # @justPlay justPlay
        # return false

      # Allow shift+click for new tabs, etc.
      if !bypass && !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey
        event.preventDefault()

        # Remove leading slashes and hash bangs (backward compatablility)
        url = href.replace(/^\//,'').replace('\#\!\/','')

        # Instruct Backbone to trigger routing events
        @navigate url, { trigger: true }

        return false