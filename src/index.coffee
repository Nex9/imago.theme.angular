tenant     = 'pablosbirthday'
data       = 'online'
debug      = true

host       = if (data is 'online') then "//#{tenant}.imagoapp.com/api/v3" else "/api/v2"

app = angular.module 'app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp']

app.config ($routeProvider, $httpProvider, $sceProvider) ->

  $sceProvider.enabled(false)

  # http defaults config START
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
  $httpProvider.defaults.headers.common['NexClient']    = 'public'
  # http defaults config ENDS

  $routeProvider
    .when '/',
      templateUrl: '/src/views/helloworld.html'
      controller: 'HelloWorld'