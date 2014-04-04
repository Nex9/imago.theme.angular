app.directive 'imagoSlider', ($window, imagoUtils) ->
  replace: true
  templateUrl: '/src/app/directives/views/slider-widget.html'
  controller: ($scope, $element, $attrs, $transclude) ->
    # @slider = angular.copy($scope[$attrs.source])

    $scope.currentIndex = 0;

    $scope.setCurrentSlideIndex = (index) ->
      $scope.currentIndex = index;

    $scope.isCurrentSlideIndex = (index) ->
      return $scope.currentIndex is index;

    $scope.goPrev = () ->
      console.log 'go Prev'
      $scope.currentIndex = (if ($scope.currentIndex < $scope.slideSource.length - 1) then ++$scope.currentIndex else 0)

    $scope.goNext = () ->
      console.log 'go Next'
      $scope.currentIndex = (if ($scope.currentIndex > 0) then --$scope.currentIndex else $scope.slideSource.length - 1)

    angular.element($window).on 'keydown', (e) ->
      return unless $scope.confSlider.enablekeys
      switch e.keyCode
        when 37 then $scope.goPrev()
        when 39 then $scope.goNext()

    

  compile: (tElement, tAttrs, transclude) ->
    pre: (scope, iElement, iAttrs, controller) ->

      scope.confSlider = {}

      @defaults =
        animation:    'fade'
        sizemode:     'fit'
        current:      0
        enablekeys:   true
        enablearrows: true
        enablehtml:   true
        subslides:    false
        loop:         true
        noResize:     false
        current:      0
        lazy:         false
        align:         'center center'

      angular.forEach @defaults, (value, key) ->
        scope.confSlider[key] = value

      angular.forEach iAttrs, (value, key) ->
        scope.confSlider[key] = value

      # return unless scope.video
      # @slider = angular.copy(scope[scope.confSlider.source])
      scope.slideSource = angular.copy(scope[scope.confSlider.source])

      #If slider has one slide
      if scope.slideSource.length is 1
        scope.confSlider.enablearrows = false
        scope.confSlider.enablekeys   = false

      @id = imagoUtils.uuid()


    post: (scope, iElement, iAttrs, controller) ->

  link: (scope, iElement, iAttrs) ->
