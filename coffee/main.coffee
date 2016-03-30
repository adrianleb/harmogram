window.Sounder =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  init: ->


    SC.initialize({
      client_id: '5ae3a12aef6952a4dd801d1bde3386b6',
      redirect_uri: 'http://harmogram.com/'
    });

    # Initialize Routers
    @Routers.main = new Sounder.Routers.Main()
    Backbone.history.start()



# since we use web audio api, only chrome allowed in...

window.imChrome = () ->
  navigator.userAgent.toLowerCase().indexOf('chrome') > -1



# give a random msg
window.gimmeIntro = () ->
  placeholders = ['Uh Oh!', 'Errr...', 'Oops!', 'Damn...', 'Dammit!', 'Bollocks',  'Hmmm...' ]
  magicNumber = Math.round(Math.random() * placeholders.length) - 1
  return placeholders[magicNumber]



$ ->
  if imChrome()
    Sounder.init()
  else
    $('html').addClass 'not_chrome'
    $('#custom-intro').text gimmeIntro()
