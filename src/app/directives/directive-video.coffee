app.directive 'imagoVideo', (imagoUtils) ->
  replace: true
  templateUrl: '/src/app/directives/views/video-widget.html'
  controller: ($scope, $element, $attrs, $transclude) ->

    # $scope.videoSource = []

    renderVideo = (video) ->
      console.log video
      dpr = if @hires then Math.ceil(window.devicePixelRatio) or 1 else 1
      width    = $scope.optionsVideo.width or $element[0].clientWidth
      height   = $scope.optionsVideo.height or $element[0].clientHeight
      @serving_url = video.serving_url
      @serving_url += "=s#{ Math.ceil(Math.min(Math.max(width, height) * dpr, 1600)) }"

      # convert resolution string to object
      if angular.isString(video.resolution)
        r = video.resolution.split('x')
        $scope.optionsVideo.resolution =
          width:  r[0]
          height: r[1]
      $scope.videoBackground["background-image"] = "url(#{@serving_url})"
      $scope.videoBackground["background-repeat"]= "no-repeat"
      $scope.videoBackground["background-size"]  = "auto 100%"
      $scope.videoBackground["width"]  = width if angular.isNumber(width)
      $scope.videoBackground["height"] = height if angular.isNumber(height)
      $scope.styleFormats =
        "autoplay" : 'autoplay'
        "preload" : 'autoplay'
        "autobuffer" : 'autoplay'
        "x-webkit-airplay" : 'allow'
        "webkitAllowFullscreen" : 'true'

      resize()


    $scope.$watch $attrs['source'], (assetsData) ->
      if assetsData
        for video in assetsData
          if video.kind is "Video"
            renderVideo video


        @id = imagoUtils.uuid()

    $scope.play       = ->

    $scope.togglePlay = ->

    $scope.pause      = ->

    $scope.toggleSize = ->

    $scope.seek       = ->

    $scope.volumeUp   = ->

    $scope.volumeDown = ->

    $scope.fullScreen = ->


    resize = ->
      assetRatio   = $scope.optionsVideo.resolution.width / $scope.optionsVideo.resolution.height

      if $scope.optionsVideo.sizemode is "crop"
        width  = $element[0].clientWidth
        height = $element[0].clientHeight
        wrapperRatio = width / height
        if assetRatio < wrapperRatio
          # $scope.optionsVideo.log 'full width'
          if imagoUtils.isiOS()
              $scope.styleFormats["width"]  =  "100%"
              $scope.styleFormats["height"] = "100%"

            if $scope.optionsVideo.align is "center center"
              $scope.styleFormats["top"]  = "0"
              $scope.styleFormats["left"] = "0"
          else
              $scope.styleFormats["width"]  =  "100%"
              $scope.styleFormats["height"] = "auto"

            if $scope.optionsVideo.align is "center center"
              $scope.styleFormats["top"]  = "50%"
              $scope.styleFormats["left"] = "auto"
              $scope.styleFormats["margin-top"]  = "-#{ (width / assetRatio / 2) }px"
              $scope.styleFormats["margin-left"] = "0px"

          $scope.videoBackground["background-size"] = "100% auto"
          $scope.videoBackground["background-position"] = $scope.optionsVideo.align

        else
          # $scope.optionsVideo.log "full height"
          if imagoUtils.isiOS()
              $scope.styleFormats["width"] = "100%"
              $scope.styleFormats["height"]= "100%"

            if $scope.optionsVideo.align is "center center"
              $scope.styleFormats["top"]  = "0"
              $scope.styleFormats["left"] = "0"
          else
              $scope.styleFormats["width"]  =  "auto"
              $scope.styleFormats["height"] = "100%"

            if $scope.optionsVideo.align is "center center"
              $scope.styleFormats["top"]  = "auto"
              $scope.styleFormats["left"] = "50%"
              $scope.styleFormats["margin-top"]  = "0px"
              $scope.styleFormats["margin-left"] = "-#{ (height * assetRatio / 2) }px"

          $scope.videoBackground["background-size"] = "auto 100%"
          $scope.videoBackground["background-position"] = $scope.optionsVideo.align

      # sizemode fit
      else
        # $scope.optionsVideo.log $scope.optionsVideo.el, $scope.optionsVideo.el.width(), $scope.optionsVideo.el.height()
        width  = $element[0].clientWidth
        height = $element[0].clientHeight
        wrapperRatio = width / height

        if assetRatio > wrapperRatio
          $scope.styleFormats["width"] = '100%'
          $scope.styleFormats["height"] = if imagoUtils.isiOS() then '100%' else 'auto'
          $scope.videoBackground["background-size"] = '100% auto'
          $scope.videoBackground["background-position"] = $scope.optionsVideo.align
          $scope.videoBackground["width"] = "#{ width }px"
          $scope.videoBackground["height"] = "#{ parseInt(width / assetRatio, 10) }px"
        else
          $scope.styleFormats["width"] = if imagoUtils.isiOS() then '100%' else 'auto'
          $scope.styleFormats["height"] = '100%'
          $scope.videoBackground["background-size"] = 'auto 100%'
          $scope.videoBackground["background-position"] = $scope.optionsVideo.align
          $scope.videoBackground["width"] =  "#{ parseInt(height * assetRatio, 10) }px"
          $scope.videoBackground["height"] = "#{ height }px"

  compile: (tElement, tAttrs, transclude) ->
    pre: (scope, iElement, iAttrs, controller) ->
      @options = []
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
        @options[key] = value

      angular.forEach iAttrs, (value, key) ->
        @options[key] = value

      if @options.controls
        scope.controls = @options.controls

      scope.elementStyle = "#{@options.class} #{@options.size} #{@options.align} #{@options.sizemode}"

      scope.videoBackground =
        "background-position" : "#{@options.align}"

      scope.optionsVideo = @options

      # Sizemode
