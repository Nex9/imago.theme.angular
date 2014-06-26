app.controller 'Home', ($scope, $http, imagoUtils, imagoPanel, $location) ->

  class Home
    constructor: ->

      imagoPanel.getData('/home').then (response) =>
        # console.log response[0].items
        $scope.assets = response[0].items

  new Home