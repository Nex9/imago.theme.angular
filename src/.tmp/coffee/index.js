var app, data, debug, host, tenant;

tenant = 'pablosbirthday';

data = 'online';

debug = false;

host = data === 'online' ? "//" + tenant + ".imagoapp.com/api/v2" : "/api/v2";

app = angular.module('app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp']);

app.config(function($routeProvider) {
  return $routeProvider.when('/', {
    templateUrl: '/src/views/helloworld.html',
    controller: 'HelloWorld'
  });
});
