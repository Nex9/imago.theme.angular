class Header extends Directive

  constructor: ->

    return {

      templateUrl: '/app/header/header.html'
      controller: 'headerController as header'

    }

class HeaderController extends Controller

  constructor: (imagoUtils, @$rootScope) ->
    @utils  = imagoCart

  activate: ->
    @$rootScope.navActive = !@$rootScope.navActive
