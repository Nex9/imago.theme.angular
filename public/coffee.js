var Load, Setup, app, data, debug, imagoSettings, tenant;

tenant = 'TENANT';

data = 'online';

debug = true;

app = angular.module('app', ['ngAnimate', 'ui.router', 'hmTouchEvents', 'templatesApp', 'angular-inview', 'imago', 'lodash']);

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
    }).state('blog', {
      url: '/blog',
      templateUrl: '/app/views/blog.html',
      controller: 'blog as blog',
      data: {
        path: '/blog'
      }
    }).state('blog.tags', {
      url: '/tag/:tag'
    }).state('post', {
      url: '/blog/:name',
      templateUrl: '/app/views/post.html',
      controller: 'imagoPage as post'
    });
  }

  return Setup;

})();

Load = (function() {
  function Load($rootScope, $location, $state, $urlRouter, $window) {
    $rootScope.js = true;
    $rootScope.$on('$stateChangeSuccess', function(evt) {
      var path, state;
      state = $state.current.name.split('.').join(' ');
      path = $location.path().split('/').join(' ');
      $window.scrollTo(0, 0);
      $rootScope.state = state;
      return $rootScope.path = path;
    });
  }

  return Load;

})();

angular.module('app').constant('imagoSettings', imagoSettings()).config(['$httpProvider', '$sceProvider', '$locationProvider', '$stateProvider', '$urlRouterProvider', Setup]).run(['$rootScope', '$location', '$state', '$urlRouter', '$window', Load]);

var Blog;

Blog = (function() {
  function Blog($scope, $state, $location) {
    this.path = $state.current.data.path || '/blog';
    this.pageSize = 6;
    this.tags = $state.params.tag || '';
    this.currentPage = $state.params.page || 1;
    this.onNext = function() {
      return $location.path(this.path + "/page/" + (parseInt(this.currentPage) + 1));
    };
    this.onPrev = function() {
      return $location.path(this.path + "/page/" + (parseInt(this.currentPage) - 1));
    };
  }

  return Blog;

})();

angular.module('app').controller('blog', ['$scope', '$state', '$location', Blog]);

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
        var data, i, len, results;
        results = [];
        for (i = 0, len = response.length; i < len; i++) {
          data = response[i];
          _this.data = data;
          break;
        }
        return results;
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
        var currentLink, i, j, l, len, link, links, onClass, url, urlMap;
        links = $element.find("a");
        onClass = "active";
        currentLink = void 0;
        urlMap = {};
        for (i = j = 0, len = links.length; j < len; i = ++j) {
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

var imagoContact;

imagoContact = (function() {
  function imagoContact(imagoSubmit) {
    return {
      scope: {},
      templateUrl: '/app/directives/views/imagoContact.html',
      controllerAs: 'contact',
      controller: function($scope) {
        this.data = {
          subscribe: true
        };
        return this.submitForm = (function(_this) {
          return function(isValid) {
            if (isValid) {
              return imagoSubmit.send(_this.data).then(function(result) {
                _this.status = result.status;
                return _this.error = result.message || '';
              });
            }
          };
        })(this);
      }
    };
  }

  return imagoContact;

})();

angular.module('app').directive('imagoContact', ['imagoSubmit', imagoContact]);
