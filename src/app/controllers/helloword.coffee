app.controller 'HelloWorld', ($scope, $http, imagoUtils, imagoPanel) ->
  $scope.message = 'Test'

  imagoPanel.getData('/home').then((response) =>
    console.log response
    # console.log 'return promise in controller', response[0].items
    $scope.assets = response[0].items
  )
