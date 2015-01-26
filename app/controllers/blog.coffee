class Blog extends Controller

  constructor: ($scope, $state, $location) ->
    @path = $state.current.data.path or '/blog'
    @pageSize = 6
    @tags = $state.params.tag or ''
    @currentPage = $state.params.page or 1

    @onNext = ->
      $location.path "#{@path}/page/#{parseInt(@currentPage) + 1}"

    @onPrev = ->
      $location.path "#{@path}/page/#{parseInt(@currentPage) - 1}"