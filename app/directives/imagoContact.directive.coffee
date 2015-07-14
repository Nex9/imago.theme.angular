class imagoContact extends Directive

  constructor: (imagoSubmit)->
    return {

      scope: {}
      templateUrl: '/app/directives/views/imagoContact.html'
      controller: 'imagoContactController as contact'

    }

class imagoContactController extends Controller

  constructor: (imagoSubmit) ->

    @data =
      subscribe: true

    @submitForm = (isValid) =>
      return unless isValid
      imagoSubmit.send(@data).then (result) =>
        @status = result.status
        @error = result.message or ''
