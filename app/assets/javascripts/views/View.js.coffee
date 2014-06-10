class H.View extends Backbone.View 

  template: JST['app']

  initialize: (args) ->
    console.log 'INITIALIZED VIEW', @constructor.name

  render: ->
    console.log 'rendering?', @constructor.name
    @$el.html @template()
    @el


  afterRender: ->
    


  close: ->
    @unbind()
    @stopListening()
    @undelegateEvents()
    for c in @childViews
      c.closeChild()
    @remove()
    delete @$el


  closeChild: ->
    @unbind()
    @stopListening()
    @undelegateEvents()
    @remove()
