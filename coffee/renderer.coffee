class Renderer

  OFFSET: 100
  BARS: 104
  BARWIDTH: 60
  BARSOFFSET: 0
  activeShader: "paper"
  hue: 0
  theI:0
  hueDirection: "up"
  runRenderer: true
  points: []
  path: null
  changeHue: false
  smooth: true

  constructor: ->
    @freqByteData = new Uint8Array(Sounder.control.analyser.frequencyBinCount)
    @initEvents()
    @initPaper()
    @


  initPaper: ->
    paper.setup $('canvas')[0]
    @bg = new paper.Rectangle(paper.view.bounds)
    paper.view.fillColor = 'rgb(255,2555,233)'
    @path = new paper.Path()
    @path.strokeColor = 'black'
    # @path.fillColor = '#000000'
    @path.strokeWidth = 1

    console.log 'started ', paper ,'engine on ', @path

    @TOTALWIDTH = paper.view.size.width
    @TOTALHEIGHT = paper.view.size.height
    console.log @TOTALWIDTH, @TOTALHEIGHT
    @POINTSGAP = ( @TOTALWIDTH / @BARS )
    @PI = Math.PI
    @GOLDEN = 1.618
    @initPoints()
    console.log "each point is ", @POINTSGAP, "apart from each other"
    paper.view.draw()

  initPoints: ->
    console.log @BARS
    i = 0
    while i <= @BARS 
      w = @TOTALWIDTH - (@POINTSGAP * i)
      point = new paper.Point w, @TOTALHEIGHT
      @path.add point
      i += 1
    console.log @path.segments[0].point.x, @path.segments[@path.segments.length - 1].point.x



  updatePos: ->
    oldHeight = @TOTALHEIGHT
    @TOTALWIDTH = paper.view.size.width
    @TOTALHEIGHT = paper.view.size.height
    @POINTSGAP = ( @TOTALWIDTH / @BARS )

    # i = 0
    # 
    # 
    for i in [0...@BARS] by 1
    # while i <= @BARS
      w = @TOTALWIDTH - (@POINTSGAP * i)
      @path.segments[i].point.x = w
      @path.segments[i].point.y = @TOTALHEIGHT if @path.segments[i].point.y is oldHeight
      # i += 1

  initEvents: ->

    $(@).on 'drawPoints', =>


    $(@).on 'pause', =>
      @runRenderer = false
      # @hueChanger false

    $(@).on 'start', =>
      @runRenderer = true
      @render()
      # @hueChanger()

    $(@).on 'changeShader', (e, shader) =>
      $('body').attr('style', '');
      @activeShader = shader

    # trigger for window resize
    debouncedresize = _.debounce ( => @updatePos() ), 10
    $(window).resize => 
      debouncedresize()

  # constructor: ->
  #   @init()
  #   @

  shader: (value) ->
    # if @activeShader is "solid"
      # $("body").css "background-color", =>
        # "hsl(#{@hue},#{(value[@OFFSET] /10)}%,10%)"


    # if @activeShader is "paper"
      # i = 0


    for i in [1..@path.segments.length - 2] by 1

    # while i < (@path.segments.length - 2)

      magnitude = value[Math.round(i * (@PI * 0.9))] * @GOLDEN

      # unless i is 0
      @path.segments[(@path.segments.length - 1) - i].point.y = (@TOTALHEIGHT) - magnitude
      # i += 1

    @bg.fillColor = "hsla(#{ 255 - (value[@OFFSET] % 255)},30%,80%, 0.1)"
    @path.strokeColor = "hsla(#{255 - (value[@OFFSET] % 255)},20%,60%, 0.2)"
    # @path.strokeWidth = 100
    @path.smooth() if @smooth
    
    paper.view.draw()

    $("body").css "background-color", =>
      "hsla(#{ (value[@OFFSET] % 255)},10%,90%, 1)"





  hueChanger: (looping=true) ->
    if Sounder.renderer.changeHue
      window.webkitRequestAnimationFrame Sounder.renderer.hueChanger

      if Sounder.renderer.hueDirection is "up" then Sounder.renderer.hue = Sounder.renderer.hue + 1
      else if Sounder.renderer.hueDirection is "down" then Sounder.renderer.hue = Sounder.renderer.hue - 1

      if Sounder.renderer.hue > 250 then Sounder.renderer.hueDirection = "down"
      else if Sounder.renderer.hue < 10 then Sounder.renderer.hueDirection = "up"



  render: ->
    if Sounder.renderer.runRenderer
      window.webkitRequestAnimationFrame Sounder.renderer.render
      Sounder.control.analyser.getByteFrequencyData Sounder.renderer.freqByteData 
      Sounder.renderer.shader Sounder.renderer.freqByteData

(->
  Sounder.renderer = new Renderer
)()