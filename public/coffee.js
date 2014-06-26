var app, data, debug, host, tenant,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

tenant = 'TENANT';

data = 'online';

debug = true;

host = data === 'online' ? "//" + tenant + ".imagoapp.com/api/v3" : "/api/v3";

app = angular.module('app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp', 'angular-underscore', 'imago.widgets.angular']);

app.run(function($rootScope, $window) {
  var Run;
  Run = (function() {
    function Run() {
      this.onMouseWheelStart = __bind(this.onMouseWheelStart, this);
      this.onScrollStart = __bind(this.onScrollStart, this);
      this.onResizeStart = __bind(this.onResizeStart, this);
      this.w = angular.element($window);
      this.w.on('resize', this.onResizeStart);
      this.w.on('resize', _.debounce(((function(_this) {
        return function() {
          return $rootScope.$broadcast('resizestop');
        };
      })(this)), 200));
      this.w.on('resize', _.throttle(((function(_this) {
        return function() {
          return $rootScope.$broadcast('resizelimit');
        };
      })(this)), 150));
      this.w.on('scroll', this.onScrollStart);
      this.w.on('scroll', _.debounce(((function(_this) {
        return function() {
          return $rootScope.$broadcast('scrollstop');
        };
      })(this)), 200));
      this.w.on('scroll', _.throttle(((function(_this) {
        return function() {
          return $rootScope.$broadcast('scrolllimit');
        };
      })(this)), 150));
      this.w.on('mousewheel', this.onMouseWheelStart);
      this.w.on('mousewheel', _.debounce(((function(_this) {
        return function() {
          return $rootScope.$broadcast('mousewheelstop');
        };
      })(this)), 200));
      this.w.on('mousewheel', _.throttle(((function(_this) {
        return function() {
          return $rootScope.$broadcast('mousewheellimit');
        };
      })(this)), 150));
    }

    Run.prototype.onResizeStart = function(e) {
      if (this.resizeing) {
        return;
      }
      $rootScope.$broadcast('resizestart');
      this.resizeing = true;
      return this.w.one('resizestop', (function(_this) {
        return function() {
          return _this.resizeing = false;
        };
      })(this));
    };

    Run.prototype.onScrollStart = function(e) {
      if (this.scrolling) {
        return;
      }
      $rootScope.$broadcast('scrollstart');
      this.scrolling = true;
      return this.w.one('scrollstop', (function(_this) {
        return function() {
          return _this.scrolling = false;
        };
      })(this));
    };

    Run.prototype.onMouseWheelStart = function(e) {
      if (this.isMouseWheeling) {
        return;
      }
      $rootScope.$broadcast('mousewheelstart');
      this.isMouseWheeling = true;
      return this.w.one('mousewheelstop', (function(_this) {
        return function() {
          return _this.isMouseWheeling = false;
        };
      })(this));
    };

    return Run;

  })();
  return new Run;
});

app.config(function($routeProvider, $httpProvider, $sceProvider, $locationProvider) {
  var Config;
  Config = (function() {
    function Config() {
      $sceProvider.enabled(false);
      $httpProvider.defaults.cache = true;
      $httpProvider.defaults.headers.common['Content-Type'] = 'application/json';
      $httpProvider.defaults.headers.common['NexClient'] = 'public';
      $locationProvider.html5Mode(true);
    }

    return Config;

  })();
  return new Config;
});

app.controller('Home', function($scope, $http, imagoUtils, imagoPanel, $location) {
  var Home;
  Home = (function() {
    function Home() {
      imagoPanel.getData('/home').then((function(_this) {
        return function(response) {
          return $scope.assets = response[0].items;
        };
      })(this));
    }

    return Home;

  })();
  return new Home;
});

app.directive('navigation', function() {
  return {
    replace: true,
    transclude: true,
    restrict: 'AE',
    templateUrl: '/app/directives/views/navigation.html',
    controller: function($scope, $element, $attrs, $transclude, $location, $timeout) {
      var currentLink, i, l, link, links, onClass, url, urlMap, _i, _len;
      links = $element.find("a");
      onClass = "active";
      currentLink = void 0;
      urlMap = {};
      for (i = _i = 0, _len = links.length; _i < _len; i = ++_i) {
        l = links[i];
        link = angular.element(links[i]);
        url = link.attr("href");
        if ($location.$$html5) {
          urlMap[url] = link;
        } else {
          urlMap[url.replace("/^#[^/]*/", "")] = link;
        }
      }
      return $scope.$on("$routeChangeStart", function() {
        var path, pathLink;
        path = $location.path();
        pathLink = urlMap[$location.path()];
        if (pathLink) {
          if (currentLink) {
            currentLink.removeClass(onClass);
          }
          currentLink = pathLink;
          return currentLink.addClass(onClass);
        } else if (path === "/" && currentLink) {
          return currentLink.removeClass(onClass);
        }
      });
    }
  };
});
