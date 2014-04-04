app.directive('imagoVideo', function($log, imagoUtils) {
  return {
    replace: true,
    templateUrl: '/src/app/directives/views/video-widget.html',
    restrict: 'EAC',
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
          this.video = angular.copy(scope.video);
          this.id = imagoUtils.uuid();
          return scope.elementStyle = "" + (this["class"] || '') + " " + this.size + " " + this.align + " " + this.sizemode;
        },
        post: function(scope, iElement, iAttrs, controller) {}
      };
    },
    link: function(scope, iElement, iAttrs) {}
  };
});
