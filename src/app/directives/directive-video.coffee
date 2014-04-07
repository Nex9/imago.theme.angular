app.directive 'imagoVideo', (imagoUtils) ->
  replace: true
  templateUrl: '/src/app/directives/views/video-widget.html'
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

      if @controls
        scope.controls = @controls

      @video = angular.copy(scope.video)

      @id = imagoUtils.uuid()

      scope.elementStyle = "#{@class} #{@size} #{@align} #{@sizemode}"

      # convert resolution string to object
      if angular.isString(@resolution)
        @resolution =
          width:  r[0]
          height: r[1]

      # Sizemode




    post: (scope, iElement, iAttrs, controller) ->
