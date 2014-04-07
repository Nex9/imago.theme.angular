app.directive('imagoImage', function() {
  return {
    replace: true,
    templateUrl: '/src/app/directives/views/image-widget.html',
    controller: function($scope, $element, $attrs, $transclude) {},
    compile: function(tElement, tAttrs, transclude) {
      return {
        pre: function(scope, iElement, iAttrs, controller) {
          var assetRatio, backgroundSize, dpr, height, r, servingSize, sizemode, width, wrapperRatio;
          this.defaults = {
            align: 'center center',
            sizemode: 'fit',
            hires: true,
            scale: 1,
            lazy: true,
            maxSize: 2560,
            noResize: false,
            mediasize: false,
            width: 'auto',
            height: 'auto'
          };
          angular.forEach(this.defaults, function(value, key) {
            return this[key] = value;
          });
          angular.forEach(iAttrs, function(value, key) {
            return this[key] = value;
          });
          this.image = angular.copy(scope[this.source]);
          width = this.width || iElement[0].clientWidth;
          height = this.height || iElement[0].clientHeight;
          sizemode = this.sizemode;
          scope.elementStyle = {};
          if (angular.isString(this.image.resolution)) {
            r = this.image.resolution.split('x');
            this.resolution = {
              width: r[0],
              height: r[1]
            };
          }
          assetRatio = this.resolution.width / this.resolution.height;
          if (width === 'auto' || height === 'auto') {
            if (angular.isNumber(width) && angular.isNumber(height)) {

            } else if (height === 'auto' && angular.isNumber(width)) {
              height = width / assetRatio;
              scope.elementStyle.height = height;
            } else if (width === 'auto' && angular.isNumber(height)) {
              width = height * assetRatio;
              scope.elementStyle.width = width;
            } else {
              width = iElement[0].clientWidth;
              height = iElement[0].clientHeight;
            }
          }
          wrapperRatio = width / height;
          dpr = Math.ceil(window.devicePixelRatio) || 1;
          if (sizemode === 'crop') {
            if (assetRatio <= wrapperRatio) {
              servingSize = Math.round(Math.max(width, width / assetRatio));
            } else {
              servingSize = Math.round(Math.max(height, height * assetRatio));
            }
          } else {
            if (assetRatio <= wrapperRatio) {
              servingSize = Math.round(Math.max(height, height * assetRatio));
            } else {
              servingSize = Math.round(Math.max(width, width / assetRatio));
            }
          }
          servingSize = parseInt(Math.min(servingSize * dpr, this.maxSize));
          this.servingSize = servingSize;
          this.servingUrl = "" + this.image.serving_url + "=s" + (this.servingSize * this.scale);
          if (sizemode === 'crop') {
            backgroundSize = assetRatio < wrapperRatio ? "100% auto" : "auto 100%";
          } else {
            backgroundSize = assetRatio > wrapperRatio ? "100% auto" : "auto 100%";
          }
          return scope.imageStyle = {
            "background-image": "url(" + this.servingUrl + ")",
            "background-size": backgroundSize,
            "background-position": this.align,
            "display": "inline-block",
            "width": "100%",
            "height": "100%"
          };
        },
        post: function(scope, iElement, iAttrs, controller) {}
      };
    },
    link: function(scope, iElement, iAttrs) {}
  };
});
