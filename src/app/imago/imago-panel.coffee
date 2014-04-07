app.factory 'imagoPanel', ($http, imagoUtils) ->


  search: (query) ->
    params = @objListToDict query
    $http.post(@getSearchUrl(), angular.toJson(params))

  getData: (query) ->
    # console.log 'query in getData', query
    return console.log "Panel: query is empty, aborting #{query}" unless query
    # return if path is @path
    @query = query
    if imagoUtils.toType(query) is 'string'
      @query =
        [path: query]

    @query = @toArray(@query)

    @promises = []
    @data = []

    angular.forEach @query, (value) =>
      @search(value).then ((data)=>
        # console.log data
        @data.push arguments...
        # @data.push data.data
        console.log @data
      ), (error) ->
        console.log error

  toArray: (elem) ->
    # type = imagoUtils.toType(elem)
    # return console.log 'Panel: no valid query' unless type in ['object', 'string', ' array']
    if angular.isArray(elem) then elem else [elem]

  objListToDict: (obj_or_list) ->
    querydict = {}
    if angular.isArray(obj_or_list)
      angular.forEach obj_or_list, (elem, key) ->
        angular.forEach elem, (value, key) ->
          value = elem[key]
          querydict[key] or= []
          querydict[key].push(value)
    else
      angular.forEach obj_or_list, (value, key) ->
        value = obj_or_list[key]
        querydict[key] = if angular.isArray(value) then value else [value]
    # if querydict.collection?
    #   querydict['path'] = querydict.collection
    #   delete querydict.collection
    angular.forEach ['page', 'pagesize'], (value, key) ->
      if querydict.hasOwnProperty(key)
        querydict[key] = querydict[key][0]
    querydict

  getSearchUrl: ->
    if (data is 'online' and debug) then "http://#{tenant}.ng.imagoapp.com/api/v2/search" else "/api/v2/search"