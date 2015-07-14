class ImagoSubscribe extends Directive

  constructor: ($http, $parse, imagoSettings) ->

    return {
      require: 'form'
      templateUrl: '/app/directives/views/imago-subscribe.html'
      transclude: true
      controllerAs: 'imagosubscribe'
      controller: ($scope, $element, $attrs) ->

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

    }
