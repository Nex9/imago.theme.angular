class Home extends Controller

  constructor: ($scope, imagoModel) ->

    imagoModel.getData({path: '/home'}).then (response) =>
      for data in response
        @data = data
        break