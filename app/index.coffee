app = angular.module 'app', ['ngRoute', 'ngAnimate', 'ngTouch', 'templatesApp']

app.config ($routeProvider, $httpProvider, $sceProvider, $locationProvider) ->

  $sceProvider.enabled(false)

  # http defaults config START
  $httpProvider.defaults.cache = true;
  $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
  $httpProvider.defaults.headers.common['NexClient']    = 'public'
  # http defaults config ENDS

  $locationProvider.html5Mode(true);

  # $routeProvider
  #   .when '/',
  #     templateUrl: '/app/views/home.html'
  #     controller: 'Home'
  #   .when '/exhibitions',
  #     templateUrl: '/app/views/artists.html'
  #     controller: 'Artists'
  #   .when '/exhibitions/:exhibition',
  #     templateUrl: '/app/views/exhibitionView.html'
  #     controller: 'artistView'
  #   .when '/artists',
  #     templateUrl: '/app/views/artists.html'
  #     controller: 'Artists'
  #   .when '/artists/:artist',
  #     templateUrl: '/app/views/artistView.html'
  #     controller: 'artistView'
  #   .when '/news',
  #     templateUrl: '/app/views/news.html'
  #     controller: 'News'
  #   .when '/about',
  #     templateUrl: '/app/views/about.html'
  #     controller: 'About'
  #   .when '/publications',
  #     templateUrl: '/app/views/publications.html'
  #     controller: 'Artists'
  #   .when '/contact',
  #     templateUrl: '/app/views/contact.html'
  #     controller: 'Contact'