class imagoPage extends Controller

  constructor: ($scope, $location, $state, imagoModel) ->

    imagoModel.getData().then (response) =>
      # console.log 'response nexpage', response
      for data in response
        @data = data
        break