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
  'uiGmapgoogle-maps'
]

class Setup extends Config

  constructor: ($httpProvider, $provide, $sceProvider, $locationProvider, $compileProvider, $stateProvider, $urlRouterProvider, $analyticsProvider, imagoModelProvider) ->

    $sceProvider.enabled false
    $httpProvider.useApplyAsync true
    $httpProvider.interceptors.push 'httpInterceptor'

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
    $urlRouterProvider.otherwise '/page-not-found'

    $stateProvider
      # theme routes
      .state 'page-not-found',
        url: '/page-not-found'
        templateUrl: '/app/page-not-found/page-not-found.html'

      # custom routes

      # .state 'blog',
      #   url: '/blog'
      #   templateUrl: '/app/blog/blog.html'
      #   reload: true
      #   data:
      #     pageSize: 50
      #     query: '/blog'
      # .state 'blog.paged',
      #   url: '/page/:page'
      # .state 'blog.filtered',
      #   url: '/tags/:tag'
      # .state 'blog.filtered.paged',
      #   url: '/page/:page'

      .state 'contact',
        url: '/contact'
        templateUrl: '/app/contact/contact.html'
        controller: 'page as page'
        resolve:
          promiseData: (imagoModel) ->
            imagoModel.getData '/contact'

      .state 'subscribe',
        url: '/subscribe'
        templateUrl: '/app/subscribe/subscribe.html'
        controller: 'page as page'
        resolve:
          promiseData: (imagoModel) ->
            imagoModel.getData
              path: '/subscribe'


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


      .state 'home',
        url: '/:url'
        templateUrl: '/app/home/home.html'
        controller: 'home as page'
        resolve:
          promiseData: (imagoModel, $stateParams) ->
            imagoModel.getData
              path: if $stateParams.url then "/#{$stateParams.url}" else '/home'
              recursive: true

class Load extends Run

  constructor: ($rootScope, $state, $location, $timeout, tenantSettings, imagoUtils, ngProgress) ->
    document.documentElement.classList.remove('nojs')

    # imago image enable blury preview
    $rootScope.imagePlaceholder = true
    # imago video theme
    $rootScope.videoTheme = '//themes.imago.io/videoangular-imago-theme/videoangular-imago-theme.min.css'
    # detect webp compartibility
    $rootScope.webp = document.createElement('canvas').toDataURL('image/webp').indexOf('data:image/webp') == 0

    $rootScope.gmapstyle = [{"featureType":"administrative","elementType":"all","stylers":[{"saturation":"-100"}]},{"featureType":"administrative.province","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"administrative.locality","elementType":"all","stylers":[{"visibility":"on"}]},{"featureType":"administrative.neighborhood","elementType":"all","stylers":[{"visibility":"off"}]},{"featureType":"landscape","elementType":"all","stylers":[{"saturation":-100},{"lightness":65},{"visibility":"on"}]},{"featureType":"poi","elementType":"all","stylers":[{"saturation":-100},{"lightness":"50"},{"visibility":"off"}]},{"featureType":"road","elementType":"all","stylers":[{"saturation":"-100"},{"visibility":"simplified"}]},{"featureType":"road","elementType":"labels","stylers":[{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"all","stylers":[{"visibility":"simplified"}]},{"featureType":"road.highway","elementType":"labels","stylers":[{"visibility":"off"}]},{"featureType":"road.arterial","elementType":"all","stylers":[{"lightness":"30"}]},{"featureType":"road.local","elementType":"all","stylers":[{"lightness":"40"}]},{"featureType":"transit","elementType":"all","stylers":[{"saturation":-100},{"visibility":"off"}]},{"featureType":"water","elementType":"geometry","stylers":[{"hue":"#ffff00"},{"lightness":-25},{"saturation":-97}]},{"featureType":"water","elementType":"labels","stylers":[{"lightness":-25},{"saturation":-100}]}]

    $rootScope.js = true
    $rootScope.mobile = imagoUtils.isMobile()
    $rootScope.mobileClass = if $rootScope.mobile then 'mobidle' else 'desktop'
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

