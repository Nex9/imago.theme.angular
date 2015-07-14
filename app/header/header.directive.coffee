class Header extends Directive

  constructor: ->

    return {

      templateUrl: '/app/header/header.html'
      controller: 'HeaderController as header'

    }

class HeaderController extends Controller

  constructor: (imagoUtils, @$rootScope) ->
    @utils  = imagoCart

  activate: ->
    @$rootScope.navActive = !@$rootScope.navActive
