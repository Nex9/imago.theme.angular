class Blog extends Controller

  constructor: ($scope, $state) ->
    @path = '/blog'
    @pageSize = 5
    @tags = $state.params.tag or ''

    # @onNext = ->

    # @onPrev = ->