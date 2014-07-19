class Home extends Controller

  constructor: ($scope, imagoUtils, imagoPanel, $location) ->

    imagoPanel.getData('/home').then (response) =>
      # console.log response[0].items
      $scope.assets = response[0].items