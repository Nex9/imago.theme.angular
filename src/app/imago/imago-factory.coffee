app.factory 'imagoPanel', ($http, $log, imagoUtils) ->

    getData: (query) ->
      return $log "Panel: query is empty, aborting #{query}" unless query
      # return if path is @path
      if angular.isString(query)
        @query =
          [path: query]

      else if angular.isArray(query)
        @query = query

      else if iangular.isObject(query)
        # @log 'I am an Object'
        @query = [query]

      else
        return $log 'Panel: no valid query'

      # @log '@query: ', @query

      angular.forEach @query, (value, key) ->