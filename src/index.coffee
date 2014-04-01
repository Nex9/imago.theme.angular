tenant     = 'pablosbirthday'
data       = 'online'
debug      = false

host       = if (data is 'online') then "//#{tenant}.imagoapp.com/api/v2" else "/api/v2"

app = angular.module 'app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp']

app.config ($routeProvider) ->
  $routeProvider
    .when '/',
      templateUrl: '/src/views/helloworld.html'
      controller: 'HelloWorld'