var Setup, app, data, debug, onLoad, tenant;

tenant = 'TENANT';

data = 'online';

debug = true;

app = angular.module('app', ['ngAnimate', 'ui.router', 'ngTouch', 'templatesApp', 'imago.widgets.angular']);

Setup = (function() {
  function Setup($httpProvider, $sceProvider, $locationProvider, $stateProvider, $urlRouterProvider) {
    $sceProvider.enabled(false);
    $httpProvider.defaults.cache = true;
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json';
    $httpProvider.defaults.headers.common['NexClient'] = 'public';
    $locationProvider.html5Mode(true);
    $urlRouterProvider.otherwise('/');
    $stateProvider.state('home', {
      url: '/',
      templateUrl: '/app/views/home.html',
      controller: 'home'
    });
  }

  return Setup;

})();

onLoad = (function() {
  function onLoad($rootScope, $window) {
    var onMouseWheelStart, onResizeStart, onScrollStart, w;
    w = angular.element($window);
    onResizeStart = (function(_this) {
      return function(e) {
        if (_this.resizeing) {
          return;
        }
        $rootScope.$broadcast('resizestart');
        _this.resizeing = true;
        return w.one('resizestop', function() {
          return _this.resizeing = false;
        });
      };
    })(this);
    onScrollStart = (function(_this) {
      return function(e) {
        if (_this.scrolling) {
          return;
        }
        $rootScope.$broadcast('scrollstart');
        _this.scrolling = true;
        return w.one('scrollstop', function() {
          return _this.scrolling = false;
        });
      };
    })(this);
    onMouseWheelStart = (function(_this) {
      return function(e) {
        if (_this.isMouseWheeling) {
          return;
        }
        $rootScope.$broadcast('mousewheelstart');
        _this.isMouseWheeling = true;
        return w.one('mousewheelstop', function() {
          return _this.isMouseWheeling = false;
        });
      };
    })(this);
    w.on('resize', onResizeStart);
    w.on('resize', _.debounce((function() {
      return $rootScope.$broadcast('resizestop');
    }), 200));
    w.on('resize', _.throttle((function() {
      return $rootScope.$broadcast('resizelimit');
    }), 150));
    w.on('scroll', onScrollStart);
    w.on('scroll', _.debounce((function() {
      return $rootScope.$broadcast('scrollstop');
    }), 200));
    w.on('scroll', _.throttle((function() {
      return $rootScope.$broadcast('scrolllimit');
    }), 150));
    w.on('mousewheel', onMouseWheelStart);
    w.on('mousewheel', _.debounce((function() {
      return $rootScope.$broadcast('mousewheelstop');
    }), 200));
    w.on('mousewheel', _.throttle((function() {
      return $rootScope.$broadcast('mousewheellimit');
    }), 150));
  }

  return onLoad;

})();

angular.module('app').config(['$httpProvider', '$sceProvider', '$locationProvider', '$stateProvider', '$urlRouterProvider', Setup]).run(['$rootScope', '$window', onLoad]);

var Home;

Home = (function() {
  function Home($scope, imagoModel) {
    imagoModel.getData('/home').then((function(_this) {
      return function(response) {
        return $scope.assets = response[0].items;
      };
    })(this));
  }

  return Home;

})();

angular.module('app').controller('home', ['$scope', 'imagoModel', Home]);

var Page;

Page = (function() {
  function Page($scope, $state, imagoModel) {
    imagoModel.getData().then((function(_this) {
      return function(response) {
        var data, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = response.length; _i < _len; _i++) {
          data = response[_i];
          $scope.data = data;
          $scope.assets = imagoModel.findChildren(data);
          break;
        }
        return _results;
      };
    })(this));
  }

  return Page;

})();

angular.module('app').controller('page', ['$scope', '$state', 'imagoModel', Page]);

var Navigation;

Navigation = (function() {
  function Navigation($location, $timeout, $urlRouter) {
    return {
      replace: true,
      transclude: true,
      restrict: 'AE',
      templateUrl: '/app/directives/views/navigation.html',
      controller: function($scope, $element, $attrs, $transclude) {
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
        return $scope.$on("$locationChangeSuccess", function() {
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
  }

  return Navigation;

})();

angular.module('app').directive('navigation', ['$location', '$timeout', '$urlRouter', Navigation]);
