class NexPage extends Controller

  constructor: ($scope, $location, $state, imagoModel) ->

    imagoModel.getData().then (response) =>
      # console.log 'response nexpage', response
      assets = []
      for data in response
        $scope.data = data
        assets = _.union assets, data.assets

      $scope.assets = assets