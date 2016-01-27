tenant     = 'tenant'
data       = 'online'

angular.module 'app', [
  'angulartics'
  'angulartics.google.analytics'
  'ngAnimate'
  'ngTouch'
  'ui.router'
  'templatesApp'
  'angular-inview'
  'imago'
  'lodash'
  'ngSanitize'
  'com.2fdevs.videogular'
  'com.2fdevs.videogular.plugins.controls'
  'com.2fdevs.videogular.plugins.overlayplay'
  'com.2fdevs.videogular.plugins.poster'
]

class imagoSettings extends Constant

  constructor: ->

    if data is 'online'
      host = window.location.protocol + "//api.imago.io"
    else
      host = window.location.protocol + "//localhost:8000"

    return {
      sort_worker : 'sort.worker.js'
      host        : host
    }

class Setup extends Config

  constructor: ($httpProvider, $provide, $sceProvider, $locationProvider, $compileProvider, $stateProvider, $urlRouterProvider, $analyticsProvider) ->

    $sceProvider.enabled false

    # http defaults config START
    $httpProvider.useApplyAsync true
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

    if document.location.hostname is 'localhost'
      $analyticsProvider.developerMode true
    else
      $compileProvider.debugInfoEnabled false

    $analyticsProvider.firstPageview true
    $locationProvider.html5Mode true
    $urlRouterProvider.otherwise '/'

    $stateProvider
      .state 'home',
        url: '/'
        templateUrl: '/app/home/home.html'
        controller: 'simplePage as page'
        resolve:
          promiseData: (imagoModel) ->
            imagoModel.getData('/home')

      .state 'shop',
        url: '/shop'
        templateUrl: '/app/shop/shop.html'
        controller: 'shop as page'
        resolve:
          promiseData: (imagoModel) ->
            imagoModel.getData({path: '/shop', recursive: true})

      .state 'blog',
        url: '/blog'
        templateUrl: '/app/blog/blog.html'
        controller: 'blog as page'
      .state 'blog.tags',
        url: '/tag/:tag'
      .state 'blog.paged',
        url: '/page/:page'

      .state 'share',
        url: '/public/*parameter'
        templateUrl: '/app/share/share.html'
        controller: 'share as page'
        resolve:
          promiseData: (imagoModel, $stateParams) ->
            imagoModel.getData({path: '/public/' + $stateParams.parameter})

class Load extends Run

  constructor: ($rootScope, $state, $location, $timeout, imagoUtils) ->

    $timeout ->
      $rootScope.js = true
      $rootScope.mobile = imagoUtils.isMobile()
      $rootScope.mobileClass = if $rootScope.mobile then 'mobile' else 'desktop'
      FastClick.attach(document.body)

    $rootScope.hideMenu = ->
      $rootScope.navActive = false

    # fix adding class to late to main
    # $rootScope.$on '$stateChangeSuccess', (evt, toState) ->
    #   path  = toState.url.split('/').join(' ').trim()
    #   path = 'home' if path is ''
    #   $rootScope.state = toState.name.split('.').join(' ')
    #   $rootScope.path  = path
    #   $rootScope.hideMenu()

    # $rootScope.$on '$viewContentLoaded', (evt, viewConfig) ->
    #   notLoadedMain = document.querySelector('main:not(.loaded)')
    #   if $rootScope.state and $rootScope.path
    #     state = $rootScope.state?.split(' ')
    #     path = $rootScope.path?.split(' ')
    #     for item in path
    #       notLoadedMain.classList.add(item)
    #     for item in state
    #       notLoadedMain.classList.add(item)
    #   notLoadedMain.classList.add('loaded')

    # general code
    $rootScope.$on '$stateChangeSuccess', (evt) ->
      state = $state.current.name.split('.').join(' ')
      path  = $location.path().split('/').join(' ')
      path = 'home' if path is ' '
      $rootScope.state = state
      $rootScope.path  = path
      $rootScope.hideMenu()

