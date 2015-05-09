class imagoPage extends Controller

  constructor: ($scope, $location, $state, imagoModel) ->

    imagoModel.getData().then (response) =>
      for data in response
        @data = data
        console.log '@data', @data
        break