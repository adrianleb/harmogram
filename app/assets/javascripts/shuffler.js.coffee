class ShufflerSDK
  _version: "0.0.1"
  constructor: ->

    @options = {
      accessToken: "lalala"
      siteUrl: "http://shuffler.fm"
      baseUrl: () -> return "http://api.pre.shuffler.fm/v3"
    }



  initialize: (options={}) ->

      
    @options[key] = value for own key, value of options
    unless @options.appKey?
      console.error 'An App-Key is required.'
      return false
      
    $.ajaxPrefilter (options, originalOptions, jqXHR) =>
      jqXHR.setRequestHeader "X-App-Key", @options.appKey
      return
    @


  route: (path, params={}) ->
    url = @options.baseUrl() + path
    
    if Object.keys(params).length
      url += @_paramsSeparator(path) + @_stringifyParams(params)
    return url


  _paramsSeparator: (path) ->
    return if path.indexOf('?') >= 0 then "&" else "?"


  _stringifyParams: (obj) ->
    (if obj then Object.keys(obj).map((key) ->
      val = obj[key]
      if Array.isArray(val)
        return val.map((val2) ->
          encodeURIComponent(key) + "=" + encodeURIComponent(val2)
        ).join("&")
      encodeURIComponent(key) + "=" + encodeURIComponent(val)
    ).join("&") else "")


window.SHUFFLER = new ShufflerSDK()