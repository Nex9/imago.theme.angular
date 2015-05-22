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

  constructor: ($httpProvider, $sceProvider, $locationProvider, $compileProvider, $stateProvider, $urlRouterProvider) ->

    $sceProvider.enabled false

    # http defaults config START
    $httpProvider.defaults.cache = false
    $httpProvider.defaults.headers.common['Content-Type'] = 'application/json'
    $httpProvider.defaults.headers.common['NexClient']    = 'public'
    $httpProvider.defaults.headers.common['NexTenant']    = "#{tenant}"
    # http defaults config ENDS

    unless document.location.hostname is 'localhost'
      $compileProvider.debugInfoEnabled(false)

    $locationProvider.html5Mode true

    $urlRouterProvider.otherwise '/'

    $stateProvider

      .state 'menu',
        url: '/menu'
        templateUrl: '/app/views/menu.html'
        controller: ->

      .state 'home',
        url: '/'
        templateUrl: '/app/views/home.html'
        controller: 'home as page'

      .state 'live',
        url: '/live'
        templateUrl: '/app/views/live.html'
        controller: 'imagoPage as page'

      .state 'instagram',
        url: '/instagram'
        templateUrl: '/app/views/instagram.html'
        controller: 'imagoPage as page'

      .state 'subscribe',
        url: '/subscribe'
        templateUrl: '/app/views/subscribe.html'
        controller: 'imagoPage as page'

      .state 'pictures',
        url: '/pictures'
        templateUrl: '/app/views/pictures.html'
        controller: 'imagoPage as page'

      .state 'contact',
        url: '/contact'
        templateUrl: '/app/views/contact.html'
        controller: 'imagoPage as page'

      .state 'biography',
        url: '/biography'
        templateUrl: '/app/views/page.html'
        controller: 'imagoPage as page'

      .state 'music',
        url: '/music'
        templateUrl: '/app/views/music.html'
        controller: 'imagoPage as page'


      .state 'blog',
          url: '/news'
          templateUrl: '/app/views/blog.html'
          controller: 'blog as blog'
          data:
            path: '/news'

      .state 'blog.tags',
        url: '/news/tag/:tag'
      .state 'blog.paged',
        url: '/page/:page'

      .state 'blog-post',
        url: '/news/:name'
        templateUrl: '/app/views/post.html'
        controller: 'imagoPage as post'



class Load extends Run

  constructor: ($rootScope, $location, $state, $urlRouter, $window, imagoUtils) ->
    $rootScope.js = true

    $rootScope.mobile = imagoUtils.isMobile()

    $rootScope.$on '$stateChangeSuccess', (evt) ->
      state = $state.current.name.split('.').join(' ')
      path  = $location.path().split('/').join(' ')
      $window.scrollTo(0,0)
      $rootScope.state = state
      $rootScope.path  = path