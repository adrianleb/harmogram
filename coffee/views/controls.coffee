class Sounder.Views.Controls extends Backbone.View

  template: JST['controls']

  el: "#controls"

  events:
    # 'click .presets__box' : 'handlePresets'
    'change [data-control-method]' : 'handleRange'
    'click [data-control-switch]' : 'handleSwitch'

    # 'click #control-radius-rand' : 'toggleRadiusRand'
    # 'click #control-color-active' : 'toggleColorActive'
    'click #control-fullscreen' : 'toggleFullScreen'
    'click #control-centered' : 'toggleCentered'

    # 'click #control-spin' : 'toggleSpin'
    # 'click #control-huechanger' : 'toggleHueChanger'
    # 'click #control-changeangle' : 'toggleChangeAngle'

  initialize: (src) ->
    @render()
    @isFullScreen = false
    @isCentered = false



  handleRange: (e) ->
    attr = $(e.currentTarget).data 'control-method'
    val = e.currentTarget.valueAsNumber

    if attr is 'baseAngle'
      val = val / 100

    if attr is 'colorAmp'
      val = val / 100
    if attr is 'changeAngleSpeed'
      val = val / 10000
    e.currentTarget.dataset.controlMethodValue = val

    Sounder.renderer[attr] = val

  
  handleSwitch: (e) ->
    e.preventDefault()
    attr = $(e.currentTarget).data 'control-switch'

    if Sounder.renderer[attr]
      Sounder.renderer[attr] = false
      @switch e.currentTarget, false
      # if attr is 'paintBg'
        # $('html').attr 'style', ''
    else if not Sounder.renderer[attr]
      Sounder.renderer[attr] = true
      @switch e.currentTarget, true




  toggleFullScreen: (e) ->
    e.preventDefault()

    el = $(document.body).parent()
    if @isFullScreen
      document.webkitCancelFullScreen()
      @$(e.currentTarget).parent().removeClass 'controls--active'
      @isFullScreen = false
      Sounder.renderer.updatePos()
      return true

    el[0].webkitRequestFullScreen()
    @$(e.currentTarget).parent().toggleClass 'controls--active'
    @isFullScreen = true
    Sounder.renderer.updatePos()

  toggleCentered: (e) ->
    e.preventDefault()

    if @isCentered
      @$(e.currentTarget).parent().removeClass 'controls--active'
      @isCentered = false
      Sounder.renderer.xOffset = 1.5
      Sounder.renderer.updatePos()
      return true

    @$(e.currentTarget).parent().toggleClass 'controls--active'
    Sounder.renderer.xOffset = 2
    @isCentered = true
    Sounder.renderer.updatePos()


  switch: (el, truth=true) ->
    if truth
      $(el).parent().addClass 'controls--active'
    else if not truth
      $(el).parent().removeClass 'controls--active'

  render: ->
    @$el.html(@template())
    @resetInputs()

  resetInputs: ->
    ranges = @$('input[type="range"]')
    checkers = @$('input[type="checkbox"]')
    for range in ranges
      attr = range.dataset.controlMethod
      val = Sounder.renderer[attr]

      range.dataset.controlMethodValue = val
      range.value = val

    for checker in checkers
      attr = checker.dataset.controlSwitch
      val = Sounder.renderer[attr]

      if val is true then $(checker).parent().addClass 'controls--active'



