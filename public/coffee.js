var Load, Setup, app, data, debug, imagoSettings, tenant;

tenant = 'TENANT';

data = 'online';

debug = true;

app = angular.module('app', ['ngAnimate', 'ui.router', 'ngTouch', 'templatesApp', 'imago.widgets.angular', 'lodash']);

imagoSettings = (function() {
  function imagoSettings() {
    var host;
    if (data === 'online' && debug) {
      host = window.location.protocol + "//api.2.imagoapp.com";
    } else {
      host = window.location.protocol + "//localhost:8000";
    }
    return {
      sort_worker: 'sort.worker.js',
      host: host
    };
  }

  return imagoSettings;

})();

Setup = (function() {
  function Setup($httpProvider, $sceProvider, $locationProvider, $stateProvider, $urlRouterProvider) {
    $sceProvider.enabled(false);
    $httpProvider.defaults.cache = true;
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json';
    $httpProvider.defaults.headers.common['NexClient'] = 'public';
    $httpProvider.defaults.headers.common['NexTenant'] = "" + tenant;
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

Load = (function() {
  function Load($rootScope, $location, $timeout, $state, $urlRouter) {
    $rootScope.js = true;
    $rootScope.$on('$stateChangeSuccess', function(evt) {
      var path, state;
      state = $state.current.name.split('.').join(' ');
      path = $location.path().split('/').join(' ');
      $rootScope.state = state;
      return $rootScope.path = path;
    });
  }

  return Load;

})();

angular.module('app').constant('imagoSettings', imagoSettings()).config(['$httpProvider', '$sceProvider', '$locationProvider', '$stateProvider', '$urlRouterProvider', Setup]).run(['$rootScope', '$location', '$timeout', '$state', '$urlRouter', Load]);

var Blog;

Blog = (function() {
  function Blog($scope, $state) {
    this.path = '/blog';
    this.pageSize = 5;
    this.tags = $state.params.tag || '';
  }

  return Blog;

})();

angular.module('app').controller('blog', ['$scope', '$state', Blog]);

var Home;

Home = (function() {
  function Home($scope, imagoModel) {
    imagoModel.getData('/home').then((function(_this) {
      return function(response) {
        _this.assets = response[0].assets;
        return console.log('@assets', _this.assets);
      };
    })(this));
  }

  return Home;

})();

angular.module('app').controller('home', ['$scope', 'imagoModel', Home]);

var imagoPage;

imagoPage = (function() {
  function imagoPage($scope, $location, $state, imagoModel) {
    imagoModel.getData().then((function(_this) {
      return function(response) {
        var data, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = response.length; _i < _len; _i++) {
          data = response[_i];
          _this.data = data;
          break;
        }
        return _results;
      };
    })(this));
  }

  return imagoPage;

})();

angular.module('app').controller('imagoPage', ['$scope', '$location', '$state', 'imagoModel', imagoPage]);

var Maintenance;

Maintenance = (function() {
  function Maintenance($scope) {
    $scope.tenant = tenant;
  }

  return Maintenance;

})();

angular.module('app').controller('maintenance', ['$scope', Maintenance]);

var Header;

Header = (function() {
  function Header($location, $timeout, $urlRouter) {
    return {
      templateUrl: '/app/directives/views/header.html',
      controller: function($scope, $element, $attrs) {
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

  return Header;

})();

angular.module('app').directive('header', ['$location', '$timeout', '$urlRouter', Header]);
