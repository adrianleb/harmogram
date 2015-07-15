class Renderer

  BARS: 256
  runRenderer: true
  path: null

  hue: 42
  colorSat: 7
  colorAmp: 0.66
  colorInvert: false
  paintAmp: false
  paintBg: false
  changeHue: false

  smooth: true

  changeRadius: true
  baseRadius: -32
  radiusAmp: 1
  ampVal: 8

  xOffset: 1.5
  yOffset: 2


  baseAngle: 0
  changeAngle: true
  # changeAnglePlus: false
  changeAngleSpeed: 0.0001618


  gapper: 1
  gapperDir:"up"
  radiusDir:'down'
  hueDirection: "up"

  constructor: ->
    @freqByteData = new Uint8Array(Sounder.control.analyser.frequencyBinCount)
    @initEvents()
    @initPaper()
    @


  initImage: ->
    image = 'img_' + Sounder.player.currentTrack
    @raster = new paper.Raster(image)
    @raster.position = paper.view.center
    @raster.insertBelow @path
    @maskPath = new paper.Path()

  initPaper: ->
    @GOLDEN = 1.618
    @PI = Math.PI
    @$CANVAS =  $('canvas')
    paper.setup @$CANVAS[0]
    @bg = new paper.Rectangle(paper.view.bounds)
    paper.view.fillColor = 'rgb(255,255,233)'
    @path = new paper.Path()
    @path.closed = false
    @path.strokeColor = 'black'
    @path.strokeWidth = 1

    # console.log 'started ', paper ,'engine on ', @path

    @TOTALWIDTH = paper.view.size.width
    @TOTALHEIGHT = paper.view.size.height


    @xPos = (@TOTALWIDTH/@xOffset)
    @yPos = (@TOTALHEIGHT/@yOffset)
    # @baseAngle = 360/@BARS
    # @baseAngle = @PI * @GOLDEN
    # @baseAngle = (@GOLDEN * @GOLDEN) * @GOLDEN




    # console.log @TOTALWIDTH, @TOTALHEIGHT

    @initPoints()
    # console.log "each point is ", @POINTSGAP, "apart from each other"
    paper.view.draw()

  initPoints: ->
    @log = 0
    # console.log @BARS, @TOTALWIDTH /2 , @TOTALHEIGHT /2


    for i in [0...@BARS] by @gapper
      x = Math.floor(Math.cos(@baseAngle * i) * @baseRadius)
      y = Math.floor(Math.sin(@baseAngle * i) * @baseRadius)
      # console.log x, y
      # w = @TOTALWIDTH - (@POINTSGAP * i)
      point = new paper.Point (@xPos + x), (@yPos) + y
      # point = new paper.Point Math.floor(@TOTALWIDTH / 2), Math.floor(@TOTALHEIGHT / 2)
      @path.add point

      # delta = new paper.Point(
      #     length: ((5 * 0.5) + (5 * 0.8))
      #     angle: (360 / @BARS) * i
      #   )
      #   # console.log delta
      #   @path.add delta + 50
      #   i++

      # console.log @path.segments[0].point.x, @path.segments[@path.segments.length - 1].point.x



  updatePos: ->
    oldHeight = @TOTALHEIGHT
    @TOTALWIDTH = paper.view.size.width
    @TOTALHEIGHT = paper.view.size.height
    @xPos = (@TOTALWIDTH/@xOffset)
    @yPos = (@TOTALHEIGHT/@yOffset)


  initEvents: ->

    $(@).on 'pause', =>
      @runRenderer = false
      # @hueChanger false

    $(@).on 'start', =>
      @runRenderer = false
      _.delay ( =>
        @runRenderer = true
      # unless
      # @initImage()
        @render()
      ), 100
      if Sounder.renderer.changeHue
        @hueChanger()



    # trigger for window resize
    debouncedresize = _.debounce ( => @updatePos() ), 10
    $(window).resize =>
      debouncedresize()


  # constructor: ->
  #   @init()
  #   @

  signalEffects:(signal) ->

    # paint stroke
    if @paintAmp
        p = signal * @colorAmp
        if @colorInvert
          p = 100 - p
        @path.strokeColor = "hsl(#{@hue},#{@colorSat}%, #{p}%)"

    # change angle(twistit)
    if @changeAngle
      @baseAngle += @changeAngleSpeed


    # paint background
    if @paintBg
      p = (signal * @colorAmp)
      unless @colorInvert
        p = 100 - p
      document.documentElement.style.backgroundColor =  "hsl(#{@hue},25%, #{p}%)"

    # change radius
    if @changeRadius
      @baseRadius = (signal * @radiusAmp)



  shader: (value) ->

    # get an average of the signal and send it to the FX, unless not needed
    if true in [@changeRadius, @changeAngle,  @paintAmp, @paintBg]
      p = _.reduce value, (memo, num) ->
        memo + num
      p = Math.round(((p / 1024) / 255) * 100)

      @signalEffects(p)



    # FLAT - OLD
    # for i in [1..@path.segments.length - 2] by 1
    #   magnitude = value[Math.round(i * (@PI * 0.9))] * @GOLDEN
    #   @path.segments[(@path.segments.length - 1) - i].point.y = (@TOTALHEIGHT) - magnitude
    # @path.fillColor = "hsla(#{ 255 - (value[@baseOffset] % 255)},30%,80%, 0.1)"
      # "hsl(#{@hue},#{(value[@baseOffset] % 20)}%,90%)"
    # if @gapperDir is 'up' then @gapper += 1 else @gapper -= 1
    # if @gapper > 5 then @gapperDir = "down" else if @gapper is 1 then @gapperDir = "up"

    # ROUND
    # # console.log value
    for i in [0...@BARS] by @gapper

        magnitude = value[i] * (@GOLDEN * (@ampVal / 10))
        x = Math.floor((Math.cos(@baseAngle * i) * (@baseRadius + magnitude) + @xPos))
        y = Math.floor((Math.sin(@baseAngle * i) * (@baseRadius + magnitude) + @yPos))
        dot = @path.segments[(@path.segments.length - 1) - i]
        dot.point.x = x
        dot.point.y = y

      @path.smooth() if @smooth

      paper.view.draw()

  hueChanger: ->
    # really cheap toggle
    @changer ?= _.throttle (=>
      unless not Sounder.renderer.changeHue
        console.log 'hue'
        if Sounder.renderer.hueDirection is "up" then Sounder.renderer.hue = Sounder.renderer.hue + 1
        else if Sounder.renderer.hueDirection is "down" then Sounder.renderer.hue = Sounder.renderer.hue - 1

        if Sounder.renderer.hue > 250 then Sounder.renderer.hueDirection = "down"
        else if Sounder.renderer.hue < 10 then Sounder.renderer.hueDirection = "up"
        if @radiusDir is 'up'
          @radiusDir = 'down'
        else if @radiusDir is 'down'
          @radiusDir = 'up'

        @changer()
      ), 1000


    # start the chain
    @changer()


  render: ->
    if Sounder.renderer.runRenderer
      window.requestAnimationFrame Sounder.renderer.render
      Sounder.control.analyser.getByteFrequencyData Sounder.renderer.freqByteData
      Sounder.renderer.shader Sounder.renderer.freqByteData



(->
    Sounder.renderer = new Renderer
)()
