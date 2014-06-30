tenant     = 'TENANT'
data       = 'online'
debug      = true

host       = if (data is 'online') then "//#{tenant}.imagoapp.com/api/v3" else "/api/v3"

app = angular.module 'app', [
  'ngRoute'
  'ngAnimate'
  'ngTouch'
  'templatesApp'
  'imago.widgets.angular'
]


class Setup extends Config

  constructor: ($routeProvider, $httpProvider, $sceProvider, $locationProvider) ->

    $sceProvider.enabled false

    # http defaults config START
    $httpProvider.defaults.cache = true
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
    $httpProvider.defaults.headers.common['NexClient']    = 'public'
    # http defaults config ENDS

    $locationProvider.html5Mode true

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

class onLoad extends Run

  constructor : ($rootScope, $window) ->

    w = angular.element $window

    onResizeStart = (e) =>
      return if @resizeing
      $rootScope.$broadcast 'resizestart'
      @resizeing = true
      w.one 'resizestop', => @resizeing = false

    onScrollStart = (e) =>
      # console.log 'start scrolling', @
      return if @scrolling
      $rootScope.$broadcast 'scrollstart'
      @scrolling = true
      w.one 'scrollstop', => @scrolling = false

    onMouseWheelStart = (e) =>
      return if @isMouseWheeling
      $rootScope.$broadcast 'mousewheelstart'
      @isMouseWheeling = true
      w.one 'mousewheelstop', => @isMouseWheeling = false

    w.on 'resize', onResizeStart
    w.on 'resize', _.debounce ( -> $rootScope.$broadcast 'resizestop' ),  200
    w.on 'resize', _.throttle ( -> $rootScope.$broadcast 'resizelimit' ), 150

    w.on 'scroll', onScrollStart
    w.on 'scroll', _.debounce ( -> $rootScope.$broadcast 'scrollstop' ),  200
    w.on 'scroll', _.throttle ( -> $rootScope.$broadcast 'scrolllimit' ), 150

    w.on 'mousewheel', onMouseWheelStart
    w.on 'mousewheel', _.debounce ( -> $rootScope.$broadcast 'mousewheelstop' ),  200
    w.on 'mousewheel', _.throttle ( -> $rootScope.$broadcast 'mousewheellimit' ), 150