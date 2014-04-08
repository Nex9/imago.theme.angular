app.directive 'imagoVideo', (imagoUtils) ->
  replace: true
  templateUrl: '/src/app/directives/views/video-widget.html'
  controller: ($scope, $element, $attrs, $transclude) ->
    $scope.$watch 'assets', (assetsData) ->
      if assetsData
        $scope.videoSource = []
        for video in assetsData
          if video?.kind is "Video"
            console.log video
            $scope.videoBackground["background-image"] = "url(#{video.serving_url})"
            $scope.videoBackground["background-repeat"]= "no-repeat"
            $scope.videoBackground["background-size"]  = "auto 100%"

        @id = imagoUtils.uuid()

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

      scope.elementStyle = "#{@class} #{@size} #{@align} #{@sizemode}"

      scope.videoBackground =
        "background-position" : "#{@align}"

      # convert resolution string to object
      if angular.isString(@resolution)
        @resolution =
          width:  r[0]
          height: r[1]

      # Sizemode




    post: (scope, iElement, iAttrs, controller) ->
