class Home extends Controller

  constructor: ($scope, imagoModel) ->

    imagoModel.getData({path: '/home', recursive: true}).then (response) =>
      for data in response
        @data = data
        console.log '@data', @data
        break