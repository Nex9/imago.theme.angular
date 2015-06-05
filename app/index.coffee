tenant     = 'tenant'
data       = 'online'
debug      = true

angular.module 'app', [
  'ngAnimate'
  'ngTouch'
  'ui.router'
  'templatesApp'
  'angular-inview'
  'imago'
  'lodash'
]

class imagoSettings extends Constant
  constructor: ->

    if (data is 'online' and debug)
      host = window.location.protocol + "//api.imago.io"
    else
      host = window.location.protocol + "//localhost:8000"

    return {
      sort_worker : 'sort.worker.js'
      host        : host
    }

class Setup extends Config

  constructor: ($httpProvider, $provide, $sceProvider, $locationProvider, $compileProvider, $stateProvider, $urlRouterProvider) ->

    $sceProvider.enabled false

    # http defaults config START
    $httpProvider.defaults.cache = false
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
    $httpProvider.defaults.headers.common['NexClient']    = 'public'
    $httpProvider.defaults.headers.common['NexTenant']    = "#{tenant}"
    # http defaults config ENDS

    $provide.decorator '$exceptionHandler', [
      '$delegate'
      '$window'
      ($delegate, $window) ->
        (exception, cause) ->
          if $window.trackJs
            $window.trackJs.track exception
          $delegate exception, cause
    ]

    unless document.location.hostname is 'localhost'
      $compileProvider.debugInfoEnabled(false)

    $locationProvider.html5Mode true

    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: '/app/views/home.html'
        controller: 'home as page'



class Load extends Run

  constructor: ($rootScope, $location, $state, $urlRouter, $window, imagoUtils) ->
    $rootScope.js = true

    $rootScope.mobile = imagoUtils.isMobile()

    $rootScope.$on '$stateChangeSuccess', (evt) ->
      state = $state.current.name.split('.').join(' ')
      path  = $location.path().split('/').join(' ')
      path = 'home' if path is ' '
      $window.scrollTo(0,0)
      $rootScope.state = state
      $rootScope.path  = path