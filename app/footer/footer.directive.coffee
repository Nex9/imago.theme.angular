class Footer extends Directive

  constructor: ->

    return {

      restrict: 'E'
      templateUrl: '/app/directives/views/footer.html'
      controller: 'footerController as footer'

      }

class FooterController extends Controller

  constructor: ->