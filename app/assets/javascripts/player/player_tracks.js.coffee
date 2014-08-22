class H.Collections.PlayerTracks extends H.Collection
  model: H.Models.PlayerTrack

  parse: (request) ->
    r = []
    for id, track of request.models.tracks
      if track.stream.source in ['soundcloud', 'tumblr', 'mp3']
        r.push track
    return r



  setUrl: (resource, data) ->
    @url = SHUFFLER.route("/activity_streams/#{@channel}", data)
    

  initialize: ->
    @objects = []
    @activities = []

    window.playlist = @
 


  injectCurrentTrack: ->
      # <audio id="source<%= @model.trackIndex %>" preload='none' data-track-index="<%= @model.trackIndex %>" src="<%= @model.get('object').stream.url %><%=  if @model.get('object').stream.platform is 'soundcloud' then '?client_id=c280d0c248513cfc78d7ee05b52bf15e' else '?api-key=zlspn5imm91ak2z7nk3g' %>" ></audio>


  _injectChannelTracks: (adding=false)->
    @currentIndex = 0
    H.events.trigger 'player:tracks:ready'



  injectChannel: (channelKey, startAt=null) ->

    data = 
      page: 1
      per_page: 200
      format: "json"


    
    @startAt = startAt if startAt?
    if @startAt
      data['start_at'] = @startAt

    @channel = channelKey
    @url = SHUFFLER.route("/activity_streams/#{@channel}", data)
    @fetch().done =>
      console.log 'gotcha', @
      @_injectChannelTracks()


  injectActivity: (activity) ->
    console.log 'injected act', @
    activity.object.activity_id = activity.id
    @activities.push activity
    @currentIndex = (@activities.length - 1)
    @generateSmIds()

    H.events.trigger 'player:tracks:ready'


  generateSmIds: ->
    for act in @activities
      act.sm_id = "shuffler-#{act.id}"

  currentTrack: ->
    if @models[@currentIndex]?
      return @models[@currentIndex]
    else
      console.debug "LAST TRACK IN PLAYLIST"

  currentMediaType: ->
    s = @currentTrack().get('stream').source
    return s


  actIndex: (activity_id) ->
    obj = null
    id = parseFloat(activity_id)


    if @activities? and @activities.length
      for a, i in @activities
        if a.id is id
          obj = a.object
          return i

    return null





  go: (i) ->
    @currentIndex += i

  goTo: (i) ->
    @currentIndex = i
