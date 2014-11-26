tenant     = 'TENANT'
data       = 'online'
debug      = true

app = angular.module 'app', [
  'ngAnimate'
  'ui.router'
  'ngTouch'
  'templatesApp'
  'imago.widgets.angular'
  'lodash'
]

class imagoConf extends Constant
  constructor: ->

    if (data is 'online' and debug)
      host = window.location.protocol + "//api.2.imagoapp.com"
    else
      host = window.location.protocol + "//localhost:8000"

    return {
      sort_worker : 'sort.worker.js'
      host        : host
    }

class Setup extends Config

  constructor: ($httpProvider, $sceProvider, $locationProvider, $stateProvider, $urlRouterProvider) ->

    $sceProvider.enabled false

    # http defaults config START
    $httpProvider.defaults.cache = true
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
    $httpProvider.defaults.headers.common['NexClient']    = 'public'
    $httpProvider.defaults.headers.common['NexTenant']    = "#{tenant}"
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

class Load extends Run

  constructor: ($rootScope, $location, $timeout, $state, $urlRouter) ->

    $rootScope.js = true

    $rootScope.$on '$stateChangeSuccess', (evt) ->
      state = $state.current.name.split('.').join(' ')
      path  = $location.path().split('/').join(' ')
      $rootScope.state = state
      $rootScope.path  = path
