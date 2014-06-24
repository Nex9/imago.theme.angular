var app, data, debug, host, tenant;

tenant = 'TENANT';

data = 'online';

debug = true;

host = data === 'online' ? "//" + tenant + ".imagoapp.com/api/v3" : "/api/v3";

app = angular.module('app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp', 'imago.widgets.angular']);

app.run(function($rootScope) {
  return $rootScope.jsVersion = true;
});

app.config(function($routeProvider, $httpProvider, $sceProvider, $locationProvider) {
  $sceProvider.enabled(false);
  $httpProvider.defaults.cache = true;
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json';
  $httpProvider.defaults.headers.common['NexClient'] = 'public';
  return $locationProvider.html5Mode(true);
});

app.controller('Home', function($scope, $http, imagoUtils, imagoPanel, $location) {
  return imagoPanel.getData('/home').then((function(_this) {
    return function(response) {
      return $scope.assets = response[0].items;
    };
  })(this));
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
