tenant     = 'TENANT'
data       = 'online'
debug      = true

app = angular.module 'app', [
  'ngAnimate'
  'ui.router'
  'ngTouch'
  'templatesApp'
  'imago.widgets.angular'
]


class Setup extends Config

  constructor: ($httpProvider, $sceProvider, $locationProvider, $stateProvider, $urlRouterProvider) ->

    $sceProvider.enabled false

    # http defaults config START
    $httpProvider.defaults.cache = true
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
    $httpProvider.defaults.headers.common['NexClient']    = 'public'
    # http defaults config ENDS

    $locationProvider.html5Mode true

    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: '/app/views/home.html'
        controller: 'home'
    #   .state 'settings',
    #     url: '/settings'
    #     templateUrl: '/app/views/settings.html'
    #     controller: 'home'
    #   .state 'settings.menu',
    #     url: '/:menu'
    #     views:
    #       'menuSettings':
    #         templateUrl: '/app/views/settings.menu.html'
    #         controller: 'settingsMenu'
    #   .state 'trash',
    #     url: '/trash'
    #     templateUrl: '/app/views/trash.html'
    #     controller: 'home'
    #   .state 'search',
    #     url: '/search/*parameter'
    #     templateUrl: '/app/views/search.html'
    #     controller: 'searchPage'

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