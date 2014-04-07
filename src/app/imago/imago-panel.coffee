app.factory 'imagoPanel', ($http, imagoUtils, $q) ->


  search: (query) ->
    # console.log 'search...', query
    params = @objListToDict query
    return $http.post(@getSearchUrl(), angular.toJson(params))

  getData: (query) ->
    # console.log 'query in getData', query
    return console.log "Panel: query is empty, aborting #{query}" unless query
    # return if path is @path
    @query = query
    if angular.isString(query)
      @query =
        [path: query]

    @query = @toArray(@query)


    @promises = []
    @data = []

    # console.log 'before', @query
    angular.forEach @query, (value) =>
      # console.log 'in foreach', value
      @promises.push @search(value).success((data) =>

        # if the data is one single item and its a collection
        if data.length is 1 and data[0].kind is 'Collection'
          @data.push data[0]
        else
          result =
            items : data
            count : data.length

          @data.push(result)
        # else construct a result object
        # {items : data, count : data.length}
      )
    $q.all(@promises).then ((response)=>
      return @data
      # console.log response
      # console.log @data
    )

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