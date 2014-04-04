app.directive('imagoSlider', function($window, imagoUtils) {
  return {
    replace: true,
    templateUrl: '/src/app/directives/views/slider-widget.html',
    controller: function($scope, $element, $attrs, $transclude) {
      $scope.currentIndex = 0;
      $scope.setCurrentSlideIndex = function(index) {
        return $scope.currentIndex = index;
      };
      $scope.isCurrentSlideIndex = function(index) {
        return $scope.currentIndex === index;
      };
      $scope.goPrev = function() {
        console.log('go Prev');
        return $scope.currentIndex = ($scope.currentIndex < $scope.slideSource.length - 1 ? ++$scope.currentIndex : 0);
      };
      $scope.goNext = function() {
        console.log('go Next');
        return $scope.currentIndex = ($scope.currentIndex > 0 ? --$scope.currentIndex : $scope.slideSource.length - 1);
      };
      return angular.element($window).on('keydown', function(e) {
        if (!$scope.confSlider.enablekeys) {
          return;
        }
        switch (e.keyCode) {
          case 37:
            return $scope.goPrev();
          case 39:
            return $scope.goNext();
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
          return this.id = imagoUtils.uuid();
        },
        post: function(scope, iElement, iAttrs, controller) {}
      };
    },
    link: function(scope, iElement, iAttrs) {}
  };
});
