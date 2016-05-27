class Header extends Directive

  constructor: ($rootScope) ->

    return {

      templateUrl: '/app/header/header.html'
      controller: 'headerController as header'

    }

class HeaderController extends Controller

  constructor: (imagoCart, @$rootScope) ->
    @utils  = imagoCart

  activate: (state) ->
    if state is 'show'
      @$rootScope.navActive = true
    else if state is 'hide'
      @$rootScope.navActive = false
    else
      @$rootScope.navActive = !@$rootScope.navActive
