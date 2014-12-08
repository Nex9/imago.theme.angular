class Home extends Controller

  constructor: ($scope, imagoModel) ->

    imagoModel.getData('/home').then (response) =>
      @assets = response[0].assets
      console.log '@assets', @assets