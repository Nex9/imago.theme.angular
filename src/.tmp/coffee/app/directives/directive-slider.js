app.directive('imagoSlider', function(imagoUtils) {
  return {
    replace: true,
    templateUrl: '/src/app/directives/views/slider-widget.html',
    controller: function($scope, $element, $attrs, $window) {
      $scope.currentIndex = 0;
      $scope.setCurrentSlideIndex = function(index) {
        return $scope.currentIndex = index;
      };
      $scope.isCurrentSlideIndex = function(index) {
        return $scope.currentIndex === index;
      };
      $scope.goPrev = function() {
        return $scope.currentIndex = $scope.currentIndex < $scope.slideSource.length - 1 ? ++$scope.currentIndex : 0;
      };
      $scope.goNext = function() {
        return $scope.currentIndex = $scope.currentIndex > 0 ? --$scope.currentIndex : $scope.slideSource.length - 1;
      };
      return angular.element($window).on('keydown', function(e) {
        if (!$scope.confSlider.enablekeys) {
          return;
        }
        switch (e.keyCode) {
          case 37:
            return $scope.$apply(function() {
              return $scope.goPrev();
            });
          case 39:
            return $scope.$apply(function() {
              return $scope.goNext();
            });
        }
      });
    },
    compile: function(tElement, tAttrs, transclude) {
      return {
        pre: function(scope, iElement, iAttrs, controller) {
          scope.confSlider = {};
          this.defaults = {
            animation: 'fade',
            sizemode: 'fit',
            current: 0,
            enablekeys: true,
            enablearrows: true,
            enablehtml: true,
            subslides: false,
            loop: true,
            noResize: false,
            current: 0,
            lazy: false,
            align: 'center center'
          };
          angular.forEach(this.defaults, function(value, key) {
            return scope.confSlider[key] = value;
          });
          angular.forEach(iAttrs, function(value, key) {
            return scope.confSlider[key] = value;
          });
          scope.slideSource = angular.copy(scope[scope.confSlider.source]);
          if (scope.slideSource.length === 1) {
            scope.confSlider.enablearrows = false;
            scope.confSlider.enablekeys = false;
          }
          this.id = imagoUtils.uuid();
          return scope.elementStyle = scope.confSlider.animation;
        }
      };
    }
  };
});
