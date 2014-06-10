class H.Views.PlayerVisualizer extends H.View 
  template: JST['home']


  _options: ->
    bars: 128
    gaps: 1
    smooth: true
    changeRadius: true
    colorSat: 7
    colorAmp: 0.66
    colorInvert: false
    paintAmp: false
    paintBg: false
    changeHue: false
    smooth: true
    changeRadius: true
    baseRadius: 16.18
    radiusAmp: 1.618
    ampVal: 8.9
    xOffset: 2
    yOffset: 2
    baseAngle: 1.618
    changeAngle: true
    changeAngleSpeed: 0.0001618



  initialize: (parent, options={}) ->
    if !createjs.Sound.registerPlugins([createjs.WebAudioPlugin])
      console.error('THIS ONLY WORKS IF YOUR BROWSER HAS WEBAUDIOAPI')
      return false

    @GOLDEN = 1.618
    @PI = Math.PI

    @options = {}

    @options[key] = value for own key, value of @_options()

    super
    window.vView = @

    @parent = parent
    @freqByteData = new Uint8Array(@parent.analyser.frequencyBinCount)

    @initPath()
    @initEvents()




  initPath: ->

    @$canvas =  $('#vCanvas')
    paper.setup @$canvas[0]

    @bg = new paper.Rectangle(paper.view.bounds)


    paper.view.fillColor = 'rgb(255,255,233)'
    @path = new paper.Path()
    @path.closed = false
    @path.strokeColor = 'black'
    @path.strokeWidth = 1

    @TOTALWIDTH = paper.view.size.width
    @TOTALHEIGHT = paper.view.size.height

    @xPos = (@TOTALWIDTH/@options.xOffset)
    @yPos = (@TOTALHEIGHT/@options.yOffset)

    @initPoints()
    paper.view.draw()

    return @


  initPoints: ->
    for i in [0...@options.bars] by @options.gaps
      x = Math.floor(Math.cos(@options.baseAngle * i) * @options.baseRadius)
      y = Math.floor(Math.sin(@options.baseAngle * i) * @options.baseRadius)
      point = new paper.Point (@xPos + x), (@yPos) + y
      @path.add point




  updateScreen: ->
    @TOTALWIDTH = paper.view.size.width
    @TOTALHEIGHT = paper.view.size.height

    @xPos = (@TOTALWIDTH/@options.xOffset)
    @yPos = (@TOTALHEIGHT/@options.yOffset)

  updatePath: (value) ->
    for i in [0...@options.bars] by @options.gaps
      dot = @path.segments[(@path.segments.length - 1) - i]

      v = value[i]
      magnitude = v * (@GOLDEN * (@options.ampVal / 10)) 

      dot.point.x = Math.floor((Math.cos(@options.baseAngle * i) * (@options.baseRadius + magnitude) + @xPos))
      dot.point.y = Math.floor((Math.sin(@options.baseAngle * i) * (@options.baseRadius + magnitude) + @yPos))
      
    @path.smooth() if @options.smooth
    
    paper.view.draw()


  initEvents: ->

    @listenTo H.events, 'pause',  =>
      console.log 'paused'
      @runRenderer = false


    @listenTo H.events, 'start',  =>

      _.delay ( =>

        console.log 'ran render'
        @hueChanger() if @options.changeHue
      ), 10
      # trigger for window resize
    debouncedresize = _.debounce ( => @updateScreen() ), 10

    @listenTo H.events, "player:playback:new", (data) =>
      console.log 'start'
      unless @runRenderer
        @runRenderer = true
        @render()

    $(window).on 'resize', => 
      debouncedresize()


  render: =>
    if @runRenderer
      window.webkitRequestAnimationFrame @render
      @parent.analyser.getByteFrequencyData(@freqByteData)  # this gives us the frequency
      @updatePath @freqByteData




