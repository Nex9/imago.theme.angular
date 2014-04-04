app.directive 'imagoVideo', ($log, imagoUtils) ->
  replace: true
  templateUrl: '/src/app/directives/views/video-widget.html'
  restrict: 'EAC'
  controller: ($scope, $element, $attrs, $transclude) ->

  compile: (tElement, tAttrs, transclude) ->
    pre: (scope, iElement, iAttrs, controller) ->
      @defaults =
        autobuffer  : null
        autoplay    : false
        controls    : true
        preload     : 'none'
        size        : 'hd'
        align       : 'left top'
        sizemode    : 'fit'
        lazy        : true

      angular.forEach @defaults, (value, key) ->
        @[key] = value

      angular.forEach iAttrs, (value, key) ->
        @[key] = value

      @video = angular.copy(scope.video)

      @id = imagoUtils.uuid()

      scope.elementStyle = "#{@class or ''} #{@size} #{@align} #{@sizemode}"


    post: (scope, iElement, iAttrs, controller) ->

  link: (scope, iElement, iAttrs) ->
