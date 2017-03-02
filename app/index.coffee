angular.module 'app', [
  'angulartics'
  'angulartics.google.analytics'
  'angulartics.facebook.pixel'
  'ngAnimate'
  'ngTouch'
  'ui.router'
  'templatesApp'
  'angular-inview'
  'imago'
  'lodash'
  'ngSanitize'
  'monospaced.elastic'
  # 'headroom'
  'com.2fdevs.videogular'
  'com.2fdevs.videogular.plugins.controls'
  'com.2fdevs.videogular.plugins.overlayplay'
  'com.2fdevs.videogular.plugins.poster'
]

class Setup extends Config

  constructor: ($httpProvider, $provide, $sceProvider, $locationProvider, $compileProvider, $stateProvider, $urlRouterProvider, $analyticsProvider, imagoModelProvider) ->

    $sceProvider.enabled false
    $httpProvider.useApplyAsync true

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
        controller: 'page as page'
        resolve:
          promiseData: (imagoModel) ->
            imagoModel.getData
              path: '/home'
              recursive: true

      .state 'blog',
        url: '/blog'
        templateUrl: '/app/blog/blog.html'
        reload: true
        data:
          pageSize: 50
          query: '/blog'
      .state 'blog.paged',
        url: '/page/:page'
      .state 'blog.filtered',
        url: '/tags/:tag'
      .state 'blog.filtered.paged',
        url: '/page/:page'

      .state 'contact',
        url: '/contact'
        templateUrl: '/app/page/page.html'
        controller: 'page as page'
        resolve:
          promiseData: (imagoModel) ->
            imagoModel.getData '/contact'


      # .state 'shop',
      #   url: '/shop'
      #   templateUrl: '/app/shop/shop.html'
      #   controller: 'shop as page'
      #   resolve:
      #     promiseData: (imagoModel) ->
      #       imagoModel.getData({path: '/shop', recursive: true})

      # .state 'blog',
      #   url: '/blog'
      #   templateUrl: '/app/blog/blog.html'
      #   controller: 'blog as page'
      # .state 'blog.tags',
      #   url: '/tag/:tag'
      # .state 'blog.paged',
      #   url: '/page/:page'

      .state 'share',
        url: '/public/*parameter'
        templateUrl: '/app/share/share.html'
        controller: 'share as page'
        resolve:
          promiseData: (imagoModel, $stateParams) ->
            imagoModel.getData({path: '/public/' + $stateParams.parameter})

class Load extends Run

  constructor: ($rootScope, $state, $location, $timeout, tenantSettings, imagoUtils, ngProgress) ->
    document.documentElement.classList.remove('nojs')

    # imago image enable blury preview
    $rootScope.imagePlaceholder = true
    # imago video theme
    $rootScope.videoTheme = 'https://storage.googleapis.com/videoangular-imago-theme/videoangular-imago-theme.min.css'

    $rootScope.js = true
    $rootScope.mobile = imagoUtils.isMobile()
    $rootScope.mobileClass = if $rootScope.mobile then 'mobile' else 'desktop'
    FastClick.attach(document.body)


    $rootScope.toggleMenu = (status) ->
      if _.isUndefined status
        $rootScope.navActive = !$rootScope.navActive
      else
        $rootScope.navActive =  status

    $rootScope.$on '$stateChangeStart', (evt) ->
      ngProgress.start()


    # general code
    $rootScope.$on '$stateChangeSuccess', (evt) ->
      $rootScope.urlPath = $location.path()
      # blog has no controller
      $rootScope.controller =  _.last $state.current.controller?.split(' ') or ''
      state = $state.current.name.split('.').join(' ')
      path  = $rootScope.urlPath.split('/').join(' ')
      path = 'home' if path is ' '
      $rootScope.state = state
      $rootScope.path  = path
      $rootScope.toggleMenu(false)
      ngProgress.done()

