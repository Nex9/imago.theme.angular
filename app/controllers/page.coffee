class Page extends Controller

  constructor: ($scope, $state, imagoModel) ->

    imagoModel.getData().then (response) =>
      for data in response
        $scope.data    = data
        $scope.assets  = imagoModel.findChildren data
        break