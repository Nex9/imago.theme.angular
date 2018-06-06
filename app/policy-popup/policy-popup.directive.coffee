class PolicyPopup extends Directive

  constructor: ($rootScope, imagoModel, @imagoUtils) ->

    return {

      templateUrl: '/app/policy-popup/policy-popup.html'
      controller: 'policyPopupController as policypopup'
      link: (scope, element, attrs) ->

    }

class PolicyPopupController extends Controller

  constructor: (@imagoUtils) ->
    return if @imagoUtils.cookie('policy-popup') is 'hide'
    @showform = true

  hide: ->
    @showform = false
    @setCookie()


  setCookie: ->
    @imagoUtils.cookie('policy-popup', 'hide')

