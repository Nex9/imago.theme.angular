var app, data, debug, host, tenant;

tenant = 'pablosbirthday';

data = 'online';

debug = true;

host = data === 'online' ? "//" + tenant + ".imagoapp.com/api/v2" : "/api/v2";

app = angular.module('app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp']);

app.config(function($routeProvider, $httpProvider) {
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json';
  return $routeProvider.when('/', {
    templateUrl: '/src/views/helloworld.html',
    controller: 'HelloWorld'
  });
});
