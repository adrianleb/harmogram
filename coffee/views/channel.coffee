class Sounder.Views.Channel extends Backbone.View

  template: JST['channel']

  className: 'channel__model'


  initialize: (arg) ->
    @model = arg.model
    @parent = arg.parent

    @render()


  render: ->
    @$el.html(@template(model:@model))
    @$el.on 'click', (e) =>
      @changeChannel(e)

    @


  changeChannel: (e)->
    @parent.currentChannel = @model.get('name')
    @parent.changeChannel @model.get('channel_url'), @$el
