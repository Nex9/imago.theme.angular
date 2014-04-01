app.factory 'imagoPanel', ($http, imagoUtils) ->

    getData: (query) ->
      return console.log "Panel: query is empty, aborting #{query}" unless query
      # return if path is @path
      if imagoUtils.toType(query) is 'string'
        @query =
          [path: query]

      else if imagoUtils.toType(query) is 'array'
        @query = query

      else if imagoUtils.toType(query) is 'object'
        # @log 'I am an Object'
        @query = [query]

      else
        return console.log 'Panel: no valid query'

      # @log '@query: ', @query