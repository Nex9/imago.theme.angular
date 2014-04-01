app = angular.module 'app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp']


app.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: '/app/views/helloworld.html'
      controller: 'HelloWorld'

app.controller 'HelloWorld', ($scope) ->
  $scope.message = 'FUCK'