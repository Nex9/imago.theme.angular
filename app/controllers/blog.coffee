class Blog extends Controller

  constructor: ($scope, $state) ->
    @path = $state.current.data.path
    @pageSize = 2000
    @tags = $state.params.tag or ''
    @currentPage = $state.params.pageNo or 1
    @shuffle = true

    @onNext = ->
      if $state.params.tag
        $state.go 'blog.filtered.paged', {'tag': $state.params.tag, 'pageNo': parseInt(@currentPage) + 1}
      else
        $state.go 'blog.paged', {'pageNo': parseInt(@currentPage) + 1}

    @onPrev = ->
      if $state.params.tag
        $state.go 'blog.filtered.paged', {'tag': $state.params.tag, 'pageNo': parseInt(@currentPage) - 1}
      else
        $state.go 'blog.paged', {'pageNo': parseInt(@currentPage) - 1}

    $scope.$on "$stateChangeSuccess", (ev, current, params) =>
      @tags = params.tag or ''