class ImagoSubscribe extends Directive

  constructor: ($http, $parse, imagoSettings) ->

    return {

      require: 'form'
      transclude: true
      templateUrl: '/app/directives/views/imago-subscribe.html'
      controller: 'imagoSubscribeController as imagosubscribe'

    }

class ImagoSubscribeController extends Controller

  constructor:($http, $parse, imagoSettings) ->

    @submit = (validate) ->
      return if validate.$invalid
      form = $parse($attrs.imagoSubscribe)($scope)

      @submitted = true

      $http.post("#{imagoSettings.host}/api/subscribe", form).then (response) =>
        @error = false
        console.log 'response', response
      , (error) ->
        @error = true
        console.log 'error', error
