class Home extends Controller

  constructor: ($scope, imagoModel) ->

    imagoModel.getData({path: '/home', recursive: true}).then (response) =>
      @data = response[0]