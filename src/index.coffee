tenant     = 'pablosbirthday'
data       = 'online'
debug      = true

host       = if (data is 'online') then "//#{tenant}.imagoapp.com/api/v2" else "/api/v2"

app = angular.module 'app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp']

app.config ($routeProvider, $httpProvider) ->

  # http defaults config START
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
  # http defaults config EMDS

  $routeProvider
    .when '/',
      templateUrl: '/src/views/helloworld.html'
      controller: 'HelloWorld'