class Sounder.Collections.Tracks extends Backbone.Collection
  model: Sounder.Models.Track
  # url: 'http://api.shuffler.fm/v1/channels/chillout?api-key=kscothchd0q6c7u2pfw1'
  # url: 'http://api.shuffler.fm/v1/artists/36376?api-key=zlspn5imm91ak2z7nk3g'
  # 36376
  # url: '/tracks.json'



  fetch: (options) ->
    options or (options = {})
    data = options.data or {}
    # options.dataType = 'jsonp'
    # options.processData = false
    # options.jsonp = 'callback'
    Backbone.Collection::fetch.call this, options
