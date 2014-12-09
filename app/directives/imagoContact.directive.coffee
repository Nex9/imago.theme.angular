ass imagoContact extends Directive

  constructor: (imagoSubmit)->
    return {
      scope: {}
      templateUrl: '/app/directives/views/imagoContact.html'
      controllerAs: 'contact'
      controller: ($scope) ->
        @data =
          subscribe: true

        @submitForm = (isValid) =>
          if isValid
            imagoSubmit.send(@data).then (result) =>
              @status = result

    }
