app.controller 'HelloWorld', ($scope, $http, imagoUtils, imagoPanel) ->
  $scope.message = 'Test'

  imagoPanel.getData('/docs/assets').then((response) =>
    # console.log 'return promise in controller', response[0].items
    # console.log response[0]
    $scope.assets = response[0].items
  )
