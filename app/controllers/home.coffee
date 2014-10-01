class Home extends Controller

  constructor: ($scope, imagoModel) ->

    imagoModel.getData('/home').then (response) =>
      # console.log response[0].items
      $scope.assets = response[0].items