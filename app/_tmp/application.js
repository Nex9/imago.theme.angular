var app;

app = angular.module('app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp']);

app.config(function($routeProvider) {
  return $routeProvider.when('/', {
    templateUrl: '/app/views/helloworld.html',
    controlller: 'HelloWorld'
  });
});

app.controller('HelloWorld', function($scope) {
  return $scope.message = 'FUCK';
});
