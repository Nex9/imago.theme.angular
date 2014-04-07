app.directive('imagoVideo', function(imagoUtils) {
  return {
    replace: true,
    templateUrl: '/src/app/directives/views/video-widget.html',
    controller: function($scope, $element, $attrs, $transclude) {},
    compile: function(tElement, tAttrs, transclude) {
      return {
        pre: function(scope, iElement, iAttrs, controller) {
          this.defaults = {
            autobuffer: null,
            autoplay: false,
            controls: true,
            preload: 'none',
            size: 'hd',
            align: 'left top',
            sizemode: 'fit',
            lazy: true
          };
          angular.forEach(this.defaults, function(value, key) {
            return this[key] = value;
          });
          angular.forEach(iAttrs, function(value, key) {
            return this[key] = value;
          });
          if (this.controls) {
            scope.controls = this.controls;
          }
          this.video = angular.copy(scope.video);
          this.id = imagoUtils.uuid();
          scope.elementStyle = "" + this["class"] + " " + this.size + " " + this.align + " " + this.sizemode;
          if (angular.isString(this.resolution)) {
            return this.resolution = {
              width: r[0],
              height: r[1]
            };
          }
        },
        post: function(scope, iElement, iAttrs, controller) {}
      };
    }
  };
});
